/*
 *  Copyright (c) 2001-2003, Jean Tessier
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *  
 *  	* Redistributions of source code must retain the above copyright
 *  	  notice, this list of conditions and the following disclaimer.
 *  
 *  	* Redistributions in binary form must reproduce the above copyright
 *  	  notice, this list of conditions and the following disclaimer in the
 *  	  documentation and/or other materials provided with the distribution.
 *  
 *  	* Neither the name of the Jean Tessier nor the names of his contributors
 *  	  may be used to endorse or promote products derived from this software
 *  	  without specific prior written permission.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package com.jeantessier.dependencyfinder.gui;

import java.awt.event.*;
import java.util.*;

import javax.swing.*;

import org.apache.oro.text.perl.*;

import com.jeantessier.classreader.*;
import com.jeantessier.metrics.*;

public class FilterActionListener implements Runnable, ActionListener {
	private static final Perl5Util perl = new Perl5Util();

	private OOMetrics model;

	public FilterActionListener(OOMetrics model) {
		this.model = model;
	}

	public void actionPerformed(ActionEvent event) {
		new Thread(this).start();
	}

	public void run() {
		try {
			Date start = new Date();
			
			model.StatusLine().ShowInfo("Filtering ...");
			model.GroupsModel().UpdateMetrics(FilterMetrics(model.MetricsFactory().GroupMetrics()));
			model.ClassesModel().UpdateMetrics(FilterMetrics(model.MetricsFactory().ClassMetrics()));
			model.MethodsModel().UpdateMetrics(FilterMetrics(model.MetricsFactory().MethodMetrics()));
			
			Date stop = new Date();
			
			model.StatusLine().ShowInfo("Done (" + ((stop.getTime() - start.getTime()) / (double) 1000) + " secs).");
			model.setTitle("OO Metrics - Extractor");
		} catch (MalformedPerl5PatternException ex) {
			JOptionPane dialog = new JOptionPane();
			dialog.showMessageDialog(model, ex.getMessage(), "Malformed pattern", JOptionPane.ERROR_MESSAGE);
			model.StatusLine().ShowInfo("Ready.");
		} catch (Exception ex) {
			JOptionPane dialog = new JOptionPane();
			dialog.showMessageDialog(model, ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
			model.StatusLine().ShowInfo("Ready.");
		}
	}

	private Collection FilterMetrics(Collection metrics_list) {
		Collection result = new ArrayList(metrics_list.size());

		Iterator i = metrics_list.iterator();
		while (i.hasNext()) {
			Metrics metrics = (Metrics) i.next();

			if (perl.match(model.FilterField().getText(), metrics.Name())) {
				result.add(metrics);
			}
		}

		return result;
	}
}
