/*
 *  Copyright (c) 2001-2008, Jean Tessier
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *      * Redistributions of source code must retain the above copyright
 *        notice, this list of conditions and the following disclaimer.
 *
 *      * Redistributions in binary form must reproduce the above copyright
 *        notice, this list of conditions and the following disclaimer in the
 *        documentation and/or other materials provided with the distribution.
 *
 *      * Neither the name of Jean Tessier nor the names of his contributors
 *        may be used to endorse or promote products derived from this software
 *        without specific prior written permission.
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

package com.jeantessier.classreader.impl;

import java.io.*;

import org.apache.log4j.*;

import com.jeantessier.classreader.UTF8_info;
import com.jeantessier.classreader.*;

public class EnumElementValue extends ElementValue implements com.jeantessier.classreader.EnumElementValue {
    private int typeNameIndex;
    private int constNameIndex;

    public EnumElementValue(ConstantPool constantPool, DataInput in) throws IOException {
        super(constantPool);

        typeNameIndex = in.readUnsignedShort();
        Logger.getLogger(getClass()).debug("Type name index: " + typeNameIndex);

        constNameIndex = in.readUnsignedShort();
        Logger.getLogger(getClass()).debug("Const name index: " + constNameIndex);
    }

    public int getTypeNameIndex() {
        return typeNameIndex;
    }

    public UTF8_info getRawTypeName() {
        return (UTF8_info) getConstantPool().get(getTypeNameIndex());
    }

    public String getTypeName() {
        return getRawTypeName().getValue();
    }

    public int getConstNameIndex() {
        return constNameIndex;
    }

    public UTF8_info getRawConstName() {
        return (UTF8_info) getConstantPool().get(getConstNameIndex());
    }

    public String getConstName() {
        return getRawConstName().getValue();
    }

    public char getTag() {
        return ElementValueType.ENUM.getTag();
    }

    public void accept(Visitor visitor) {
        visitor.visitEnumElementValue(this);
    }
}