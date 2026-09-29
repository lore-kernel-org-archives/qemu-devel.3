Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07605CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZY0-000343-BE; Tue, 29 Sep 2026 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBZXw-00033W-Ls
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBZXu-0006R9-6s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOApTsat11TyDtgWvjLxw13wZQJsxnVP6eQIqfbbNYA=;
 b=FMlG5De0AmUZErNOtn2qqAi+1soOA/iQlJUOXMCrhJKniUqel0c954p48/qZyHhCvw8x9D
 do3kD4z/Mof5Mrg/bfg/ak/FcXdG8af5eOu+FX2FEqzPpud0hki/qswkSaw5S8nfiIdJ8N
 F+jP6gb6GUi32IYq1zJLYWIHG515Bmc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-PPtl4-ZPOeiunaoKtwXlHQ-1; Tue, 29 Sep 2026 11:15:03 -0400
X-MC-Unique: PPtl4-ZPOeiunaoKtwXlHQ-1
X-Mimecast-MFC-AGG-ID: PPtl4-ZPOeiunaoKtwXlHQ_1790694903
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49fffa5de0fso40769175e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694903; x=1791299703;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JOApTsat11TyDtgWvjLxw13wZQJsxnVP6eQIqfbbNYA=;
 b=wwEHLSLvYqi5k+UwyPpzcML5Jbayv3Dy5ooQiRPNPNeNRsoKded/Tt9uN3HcddAd71
 fIaIQhOr4YKxiBwfRkBOCenO8SIoOIttoUELQkNshlOYw3xkVBrqTYWgjTyIdMMAph/V
 lAZEQk35ACKCSIr1kD74t8OEvTZGk7jzqBJVtnXe8xROnH0N0wZ/KCTtBKC5RFrDUv3v
 PO6Nb6oaNU2wdmbt265MNN7KTtvhFitNJg9frNunFFMLlFTuKeq2Fu/JFMpIGtnXkJyw
 lVkVg+mJSZpVwSKUQdaM32/hO3lG902I1ZhlSgKuqZInPJziPqKFhY6qa+DVNAOYLyZq
 flpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbBxSVRUKnA49+gLalK3tY+uEa2Uv6hqvLu1M2I3NaNt7hiGf+/Kc4eEvDppnoLUICVUCOaIs41kBA@nongnu.org
X-Gm-Message-State: AFuF++kYJsKwiWHZof0jtJflKBaJZoNMAio1fv+InK/kCzNScHCBrV2E
 aVsDRWsKLfjpuUhq36EhT3ZMo/c93gNI9CHy7wPrha9YKhqwyqCNPm1iFmfX66O+kCweOstws6V
 wN9vUTHVwEZH6ifjFEVzsYS08xJCNSGiD8leaSEa6ziaTLlu56WjWKwXO
X-Gm-Gg: AYBFou3BgpQ1W0oHlVw8O88sSRK1mSGNcAm86vc/xXOywK3w9Z5Tk1kf87KvxGZBgx+
 4fR2W4vhMY51tOUjstdznwTob70aXRrToInLmb4iLmGXJXdBUdV5t1RjUtQ9UKzutfeKmc7PIjz
 z45uvQqgUy91Yyga3pzDrAo5re0rgDQEWqVibQ8AEiPGT+iO9F5TryZ8bTgCadUwQAA5g+sABMS
 UwXNUSmQvrnl7Crw71Me1qHfHF7k98YZE/6b/ZZ77pUegmuSGS2ylVtbXdj8RK3iUNYDE5RIPnm
 cNlATBRM63YMe4vb0yNxvxJoOUNQKtu1FA1p9KsGx+ciSSGlyWmGydEdRsyKEnrcll01+tkxpjj
 908afgOzK73JFUiYfCcAIjvqx5UZOGpTZIgb4LqKdbmCI9NVT
X-Received: by 2002:a05:600c:4ed2:b0:49f:e3f2:f5a3 with SMTP id
 5b1f17b1804b1-49fe6685393mr292557715e9.0.1790694902373; 
 Tue, 29 Sep 2026 08:15:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed2:b0:49f:e3f2:f5a3 with SMTP id
 5b1f17b1804b1-49fe6685393mr292556905e9.0.1790694901810; 
 Tue, 29 Sep 2026 08:15:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00ebcd353sm105153995e9.3.2026.09.29.08.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:15:00 -0700 (PDT)
Message-ID: <f5e2e972-b521-41f5-80f1-f5e4adb1ebfe@redhat.com>
Date: Tue, 29 Sep 2026 17:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 05/26] scripts: Introduce
 scripts/aarch64_sysreg_helpers module
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
 <20260916144721.751810-6-eric.auger@redhat.com>
 <5538C4CB-1B66-48A4-BA44-EF93CADE5C48@nutanix.com>
Content-Language: en-US
In-Reply-To: <5538C4CB-1B66-48A4-BA44-EF93CADE5C48@nutanix.com>
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

Hi Khushit,

On 9/24/26 12:18 PM, Khushit Shah wrote:
> Only few nits.
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> We plan to reuse get_opcode() and extract_idregs_from_registers_json()
>> functions in another script. So let's move them into a module
> Nit: fullstop.
yes
>
>> No functional change intended.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
>> ---
>> scripts/aarch64_sysreg_helpers.py            | 121 +++++++++++++++++++
>> scripts/update-aarch64-cpu-sysregs-header.py |  97 +--------------
>> 2 files changed, 122 insertions(+), 96 deletions(-)
>> create mode 100644 scripts/aarch64_sysreg_helpers.py
>>
>> diff --git a/scripts/aarch64_sysreg_helpers.py b/scripts/aarch64_sysreg_helpers.py
>> new file mode 100644
>> index 0000000000..24bbc5bb3d
>> --- /dev/null
>> +++ b/scripts/aarch64_sysreg_helpers.py
>> @@ -0,0 +1,121 @@
>> +#!/usr/bin/env python3
>> +
>> +# Helpers used in aarch64 sysreg definition generation
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
>> +            'VMPIDR_EL2', 'VPIDR_EL2']
>> +
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
> ^^ does not apply now.
indeed
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
> Can we put is_demux_register inside loop? 
done
>
>> +    ]
>> +
>> +    idregs = {}
>> +
>> +    # Some regs have op code values like 000x, 001x. Anyway we don't need
>> +    # them. Besides some regs are undesired in the generated file such as
>> +    # VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
>> +    # are interested in and are tricky to decode as their system accessor
>> +    # refer to MPIDR_EL1/MIDR_EL1 respectively
>> +
>> +    skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
>> +                'VMPIDR_EL2', 'VPIDR_EL2’]
> I see the op1 of VMPIDR_EL2/VPIDR_EL2 is 0b100, why are they needed in the skip-list, as they will anyway be skipped...
see previous replies.

Note I have squashed the initial script + intro of the module + the
update because it is much simpler to maintain while staying functionaly
consistent.

Eric
>
> Warm Regards,
> Khushit
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
>> +
>> +
>> diff --git a/scripts/update-aarch64-cpu-sysregs-header.py b/scripts/update-aarch64-cpu-sysregs-header.py
>> index ef1471a197..43107264e9 100755
>> --- a/scripts/update-aarch64-cpu-sysregs-header.py
>> +++ b/scripts/update-aarch64-cpu-sysregs-header.py
>> @@ -17,102 +17,7 @@
>> import json
>> import os
>> import sys
>> -
>> -def is_demux_register(r):
>> -    name = r.get('name', '')
>> -
>> -    if name.startswith("CCSIDR"):
>> -        return True
>> -
>> -    return False
>> -
>> -# Some regs have op code values like 000x, 001x. Anyway we don't need
>> -# them. Besides some regs are undesired in the generated file such as
>> -# VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
>> -# are interested in and are tricky to decode as their system accessor
>> -# refer to MPIDR_EL1/MIDR_EL1 respectively
>> -
>> -skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
>> -            'VMPIDR_EL2', 'VPIDR_EL2']
>> -
>> -# returns the int value of a given @opcode for a reg @encoding
>> -def get_opcode(encoding, opcode):
>> -    fvalue = encoding.get(opcode)
>> -    if fvalue:
>> -        value = fvalue.get('value')
>> -        if isinstance(value, str):
>> -            value = value.strip("'")
>> -            value = int(value, 2)
>> -            return value
>> -    return -1
>> -
>> -def extract_idregs_from_registers_json(filename):
>> -    """
>> -    Load a Registers.json file and extract all ID registers, decode their
>> -    opcode and dump the information in target/arm/cpu-sysregs.h.inc
>> -
>> -    Args:
>> -        filename (str): The path to the Registers.json
>> -    returns:
>> -        idregs: list of ID regs and their encoding
>> -    """
>> -    if not os.path.exists(filename):
>> -        print(f"Error: {filename} could not be found!")
>> -        return {}
>> -
>> -    try:
>> -        with open(filename, 'r') as f:
>> -            register_data = json.load(f)
>> -
>> -    except json.JSONDecodeError:
>> -        print(f"Could not decode json from '{filename}'!")
>> -        return {}
>> -    except Exception as e:
>> -        print(f"Unexpected error while reading {filename}: {e}")
>> -        return {}
>> -
>> -    registers = [
>> -        r for r in register_data
>> -        if isinstance(r, dict)
>> -        and r.get('_type') == 'Register'
>> -        and not is_demux_register(r)
>> -    ]
>> -
>> -    idregs = {}
>> -
>> -    for register in registers:
>> -        reg_name = register.get('name')
>> -
>> -        is_skipped = any(term in (reg_name or "").upper() for term in skiplist)
>> -
>> -        if reg_name and not is_skipped:
>> -            accessors = register.get('accessors', [])
>> -
>> -            for accessor in accessors:
>> -                type = accessor.get('_type')
>> -                if type in ['Accessors.SystemAccessor']:
>> -                    encoding_list = accessor.get('encoding')
>> -
>> -                    if isinstance(encoding_list, list) and encoding_list and \
>> -                       isinstance(encoding_list[0], dict):
>> -                        encoding_wrapper = encoding_list[0]
>> -                        encoding_source = encoding_wrapper.get('encodings', \
>> -                                                               encoding_wrapper)
>> -
>> -                        if isinstance(encoding_source, dict):
>> -                                op0 = get_opcode(encoding_source, 'op0')
>> -                                op1 = get_opcode(encoding_source, 'op1')
>> -                                op2 = get_opcode(encoding_source, 'op2')
>> -                                crn = get_opcode(encoding_source, 'CRn')
>> -                                crm = get_opcode(encoding_source, 'CRm')
>> -                                encoding_str=f"{op0} {op1} {crn} {crm} {op2}"
>> -
>> -                # ID regs are assumed within this scope
>> -                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3) and \
>> -                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >= 0 and op2 <= 7):
>> -                    idregs[reg_name] = encoding_str
>> -
>> -    return idregs
>> +from aarch64_sysreg_helpers import extract_idregs_from_registers_json
>>
>> if __name__ == "__main__":
>>     # Single arg expected: the path to the Registers.json file
>> -- 
>> 2.53.0
>>


