Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81574CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWzk-0000hI-Us; Tue, 29 Sep 2026 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBWzV-0000ft-3t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBWzP-00051T-Ac
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790685077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WGg/57fwo23jQlqOupCF+5aZuHcAbwT6zsy3md/Vuc=;
 b=d7BIb9BQKYpoWbtiQ1PFts0mPiFxob1Ix/aAnD4VAZzR8ozo8brwdIWC3oJXAdpRgQWYT+
 GDQh+OwNWEp1yI84c+9d0A842YH9TRSOcLXFFLhvSMVpws7Y/tWsMaOT6P0hcZ4GhH5cIZ
 RoZRor9d8rsEJq3D1H8UFBe//gtiMfI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-hOLFUptrOZG-bXmOEzpOlA-1; Tue, 29 Sep 2026 08:31:16 -0400
X-MC-Unique: hOLFUptrOZG-bXmOEzpOlA-1
X-Mimecast-MFC-AGG-ID: hOLFUptrOZG-bXmOEzpOlA_1790685075
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e65ecd557so27822395e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685075; x=1791289875;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+WGg/57fwo23jQlqOupCF+5aZuHcAbwT6zsy3md/Vuc=;
 b=SahGOyHnEpcGJ3PD9qORpVlA2nBtKrHa75goLGK/mzxvAVI8aMyd1sFfRPQEWnJgtO
 FbDvAF92MgNjFLDOJxH0T+OS4K7gAC22uodk1wjYbnQIsTZTm1yGBQytaXx4UlPTfvLj
 AD+orAMGqOlwSyK4+b8X1uYJNbtwcYdchry3yjehTkTHUvZlps/TSBABQ26iq6KCWrMX
 R3vMSoB/b1DiWYduddusSAmxsYoAJ3e0IexxmHXWhbu2d8IRmqqFmBW5gAEt7LbA3IRP
 RSi+RgpOKUs7Z13f1uDBWarHU1uUPnH6eV2wxo7Np3ows0xjTFCO/ZTME7rapM1QxXQP
 MxBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByExJKSAqTxeZKFLTQp4fM1tHbOcq5lACRlG6OYvKMYseeF5li1KzKnM4LVl+wXTvVvG0yumYmyzTn+@nongnu.org
X-Gm-Message-State: AFuF++kYYeEeBtMda8RB1Nk+C/VOtJlYQ7V5GsQK3Jwc0fOJwQGKimAh
 fHdmfLM32G4eqM6OaWvl7KhbTsEjbH5DvQMR9Ah1RatuJcaYyEkcp/y7csjuUTc+OYEXI3n0O1A
 ZdkQD7rWt98pt/QR0+X/smOLCs+R3Z/Sf1Hrp80z1JVRu3aqxiTw4JQW6
X-Gm-Gg: AYBFou0XKrdAHAkTm0NRZaCp3Wp/1XYydA6QslTJvYJgRxeYJ8JWuYN+IGkoqX2khfU
 IPrmUXi3TCSxC5QqmCzonR44Qt9HPWxtLd6nvdTqJypV5gKCT/jllWZbsE4vyqSX2XtK9Q192ck
 skgTztO+xkyvcBd+tjegZEaDLa1cCUhgsTKGMSgDV98FvM8eo1MpACW6RGwR6cEU5j2GiV6uqJa
 pjZqu5Lp97it7+7Hmb9PYc6DQEpZVyYkG1gmHXa5eTsZdAiAfcLWNjPBR2v+iD1GLNAtBHyXMw2
 ItocmhCEvgl6fDBZRjkueZGpwSvtmpo1OCgyjVDkIDiaKY7q+nl+1aW80l0v/oGtP7SpxjQDP1l
 +2M2ywn1RQ0lkPUr2dJ9q1l7/z+9LmFkTBnVyl/i1xcCwBQ29
X-Received: by 2002:a05:600c:3514:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-49fe6701e7emr276898615e9.35.1790685074888; 
 Tue, 29 Sep 2026 05:31:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3514:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-49fe6701e7emr276898035e9.35.1790685074310; 
 Tue, 29 Sep 2026 05:31:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502cd22sm3826417f8f.13.2026.09.29.05.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:31:13 -0700 (PDT)
Message-ID: <e230d00e-8c22-4d5e-bf40-e4ebed562ac7@redhat.com>
Date: Tue, 29 Sep 2026 14:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/26] scripts: introduce
 scripts/update-aarch64-cpu-sysregs-header.py
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
 <20260916144721.751810-2-eric.auger@redhat.com>
 <A01DB50C-7455-4E60-9BF2-6F3C8369B529@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <A01DB50C-7455-4E60-9BF2-6F3C8369B529@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/24/26 12:24 PM, Khushit Shah wrote:
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Introduce a script that takes as input the Registers.json file
>> delivered in the AARCHMRS Features Model downloadable from the
>> Arm Developer A-Profile Architecture Exploration Tools page:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.arm.com_Architectures_A-2DProfile-2520Architecture-23Downloads&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=PGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=SAaDSqqwmIC1nbrh-28kms6KiFYKvW8H_CIOKWgWjucuAn37j49gnNNnMIpoP_bK&s=sxOID-2FnhcQ56l1mmjKbXtXpcERk4oOXYiF3-6fenk&e= 
>> and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
>> under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>).
>>
>> We only care about IDregs with opcodes satisfying:
>> op0 = 3, op1 = {0,1,3}, crn = 0, crm within [0, 7], op2 within [0, 7]
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> [CH: note correct op1 range, don't skip CCSIDR]
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Message-ID: <20251208163751.611186-2-eric.auger@redhat.com>
>> ---
>> scripts/update-aarch64-cpu-sysregs-header.py | 146 +++++++++++++++++++
>> 1 file changed, 146 insertions(+)
>> create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py
>>
>> diff --git a/scripts/update-aarch64-cpu-sysregs-header.py b/scripts/update-aarch64-cpu-sysregs-header.py
>> new file mode 100755
>> index 0000000000..ef1471a197
>> --- /dev/null
>> +++ b/scripts/update-aarch64-cpu-sysregs-header.py
>> @@ -0,0 +1,146 @@
>> +#!/usr/bin/env python3
>> +
>> +# This script takes as input the Registers.json file delivered in
>> +# the AARCHMRS Features Model downloadable from the Arm Developer
>> +# A-Profile Architecture Exploration Tools page:
>> +# https://urldefense.proofpoint.com/v2/url?u=https-3A__developer.arm.com_Architectures_A-2DProfile-2520Architecture-23Downloads&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=PGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=SAaDSqqwmIC1nbrh-28kms6KiFYKvW8H_CIOKWgWjucuAn37j49gnNNnMIpoP_bK&s=sxOID-2FnhcQ56l1mmjKbXtXpcERk4oOXYiF3-6fenk&e= 
>> +# and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
>> +# under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
>> +#
>> +# Copyright (C) 2026 Red Hat, Inc.
>> +#
>> +# Authors: Eric Auger <eric.auger@redhat.com>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +
>> +import json
>> +import os
>> +import sys
>> +
>> +def is_demux_register(r):
>> +    name = r.get('name', '')
>> +
>> +    if name.startswith("CCSIDR"):
>> +        return True
>> +
>> +    return False
>> +
>> +# Some regs have op code values like 000x, 001x. Anyway we don't need
>> +# them. Besides some regs are undesired in the generated file such as
>> +# VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
>> +# are interested in and are tricky to decode as their system accessor
>> +# refer to MPIDR_EL1/MIDR_EL1 respectively
>> +
>> +skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
>> +            'VMPIDR_EL2', 'VPIDR_EL2’]
> I see VMPIDR_EL2/VPIDR_EL2 have op1=0100, they will automatically get skipped, why is this needed?

because op1=4 is outside of the IDreg range:
    op0 = 3, op1 = {0,1,3}, crn = 0, crm within [0, 7], op2 within [0, 7]

Eric
>
> Warm Regards,
> Khushit
>> +# returns the int value of a given @opcode for a reg @encoding
>> +def get_opcode(encoding, opcode):
>> +    fvalue = encoding.get(opcode)
>> +    if fvalue:
>> +        value = fvalue.get('value')
>> +        if isinstance(value, str):
>> +            value = value.strip("'")
>> +            value = int(value, 2)
>> +            return value
>> +    return -1
>> +
>> +def extract_idregs_from_registers_json(filename):
>> +    """
>> +    Load a Registers.json file and extract all ID registers, decode their
>> +    opcode and dump the information in target/arm/cpu-sysregs.h.inc
>> +
>> +    Args:
>> +        filename (str): The path to the Registers.json
>> +    returns:
>> +        idregs: list of ID regs and their encoding
>> +    """
>> +    if not os.path.exists(filename):
>> +        print(f"Error: {filename} could not be found!")
>> +        return {}
>> +
>> +    try:
>> +        with open(filename, 'r') as f:
>> +            register_data = json.load(f)
>> +
>> +    except json.JSONDecodeError:
>> +        print(f"Could not decode json from '{filename}'!")
>> +        return {}
>> +    except Exception as e:
>> +        print(f"Unexpected error while reading {filename}: {e}")
>> +        return {}
>> +
>> +    registers = [
>> +        r for r in register_data
>> +        if isinstance(r, dict)
>> +        and r.get('_type') == 'Register'
>> +        and not is_demux_register(r)
>> +    ]
>> +
>> +    idregs = {}
>> +
>> +    for register in registers:
>> +        reg_name = register.get('name')
>> +
>> +        is_skipped = any(term in (reg_name or "").upper() for term in skiplist)
>> +
>> +        if reg_name and not is_skipped:
>> +            accessors = register.get('accessors', [])
>> +
>> +            for accessor in accessors:
>> +                type = accessor.get('_type')
>> +                if type in ['Accessors.SystemAccessor']:
>> +                    encoding_list = accessor.get('encoding')
>> +
>> +                    if isinstance(encoding_list, list) and encoding_list and \
>> +                       isinstance(encoding_list[0], dict):
>> +                        encoding_wrapper = encoding_list[0]
>> +                        encoding_source = encoding_wrapper.get('encodings', \
>> +                                                               encoding_wrapper)
>> +
>> +                        if isinstance(encoding_source, dict):
>> +                                op0 = get_opcode(encoding_source, 'op0')
>> +                                op1 = get_opcode(encoding_source, 'op1')
>> +                                op2 = get_opcode(encoding_source, 'op2')
>> +                                crn = get_opcode(encoding_source, 'CRn')
>> +                                crm = get_opcode(encoding_source, 'CRm')
>> +                                encoding_str=f"{op0} {op1} {crn} {crm} {op2}"
>> +
>> +                # ID regs are assumed within this scope
>> +                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3) and \
>> +                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >= 0 and op2 <= 7):
>> +                    idregs[reg_name] = encoding_str
>> +
>> +    return idregs
>> +
>> +if __name__ == "__main__":
>> +    # Single arg expected: the path to the Registers.json file
>> +    if len(sys.argv) < 2:
>> +        print("Usage: python scripts/update-aarch64-cpu-sysregs-header.py "
>> +              "<path_to_registers_json>")
>> +        sys.exit(1)
>> +    else:
>> +        json_file_path = sys.argv[1]
>> +
>> +    extracted_registers = extract_idregs_from_registers_json(json_file_path)
>> +
>> +    if extracted_registers:
>> +        output_list = extracted_registers.items()
>> +
>> +        # Sort by register name
>> +        sorted_output = sorted(output_list, key=lambda item: item[0])
>> +
>> +        # format lines as DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
>> +        final_output = ""
>> +        for reg_name, encoding in sorted_output:
>> +            reformatted_encoding = encoding.replace(" ", ", ")
>> +            final_output += f"DEF({reg_name}, {reformatted_encoding})\n"
>> +
>> +        with open("target/arm/cpu-sysregs.h.inc", 'w') as f:
>> +            f.write("/* SPDX-License-Identifier: GPL-2.0-or-later */\n\n")
>> +            f.write("/* This file is autogenerated by ")
>> +            f.write("scripts/update-aarch64-cpu-sysregs-header.py */\n")
>> +            f.write("/* DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>) */\n\n")
>> +            f.write(final_output)
>> +        print("updated target/arm/cpu-sysregs.h.inc")
>> -- 
>> 2.53.0
>>


