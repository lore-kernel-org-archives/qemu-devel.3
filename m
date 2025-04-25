Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786BFC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 13:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8IpN-00085U-RI; Fri, 25 Apr 2025 09:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8IpM-000855-Jy
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 09:10:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8IpK-0001Ro-Ff
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 09:10:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so1753213b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745586644; x=1746191444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQ17aaL99aaYEyBtnf2SQwyCK1/ueROiPMKURVR16K8=;
 b=O224W9o4biNQ4l/1WbMq0Zzw+cRdR7I+z0RYN/aO02yBaDzLkdGnGGLF/bhJgMrL6s
 Wg3cphDYzeEfN965MCyhTnXubCbTfSDr2wOE/5Zm/ADezKGYB220/mwAm4KbxrlrrgB+
 vjHa55ITvMNBvnmlZuqb7yahlkbbO4jH2WN7VXPl3xBfZUxthw8lQcSEJbbrDtlNm5s5
 cBKmH5eG+ZOHZt/Ax48++lFLScQaqDttxqei9wG5Vo21d4mTsd/QGO+Mvd9sGA0oRKWw
 mQ0zZ4TqAiQrjzrvho4k4zUBoLpKQHcMdpFf6GGFro5PMPwkamn7wcVKVVkgEsMO8RXt
 jnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745586644; x=1746191444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tQ17aaL99aaYEyBtnf2SQwyCK1/ueROiPMKURVR16K8=;
 b=nIBPDF6ov76mepwUxfFtD7h7V1F0vLhA5Xx6tE5KiJQUdGElA27vcQafI79MXP+y+8
 X8AhxQLEbzb85y0SYRh0JqSY+0XIiLKcJwudHbOxLWPVkKUnbyH//d/PIB93AX2R+OMZ
 xZCCk7YkFvzEbv6vF5m3yw8ymlZmxmZIRBufz3mLntScCWX0XfucaCT5Sh4CuXSLgWrv
 tQwjLWnOwOtlKMCJ+GVYwbxhHSAqqpv9078MMJOIWPbOtWfKmctFKkADEv2QM5YR7zpQ
 dNHKoEgED7Lam410OXPEcugzUmAF/RaRjNjU5pY5wle5rJgsUp9OlZ50/SI5PxwKlP3p
 L53w==
X-Gm-Message-State: AOJu0YzRBMYD5QK2dO81whUN0ARAuTlRNINY8q4c25Y9ng2RKkDX9rep
 iTAtvKQIJPCKMi0RrkSV554rh6Jyactal2wOmNQ+RP8KVrnLhIne+RBB9uo3j60=
X-Gm-Gg: ASbGncsD+ILXZstk5P3hyAcdbKhL8NAo9w8YIzkPD2fKG9Hc2LVrQkQ0k64KA2/mahd
 oxCE1tuQ5WbOUN+tA5+pdslaSZAZUWrMSyQsorx6amhonmqkVjjM3WRGE53ODJSFm7Be/Yh15A0
 LMJjYLPGkpfgQ/7IbZd+1SdYgAXAqu3VpW17T/wSX6eSs/eSlRiK0E9XrJ4sIBhbVGgY9V/MexL
 pxuUUAx+IOItnNEf43ZXLzzYoKNezoqs7kgSW1d+IREs2RyJUOgoF8VqW423X8hFTC270UKSLXx
 MYwkCeq0qUD0Hv5vm6ONaQMBoQe1KFFjrz8XVHyecVAnlfO1Wss4Jqs=
X-Google-Smtp-Source: AGHT+IGCZgwbEoCcKDsHvNqxSWhdUeGzb5hogs3hEVdkbhpYlt64vlpRmY6pxXFzkWiGlGttS5+upg==
X-Received: by 2002:a05:6a00:2311:b0:736:62a8:e52d with SMTP id
 d2e1a72fcca58-73fd74be6ffmr2627793b3a.12.1745586644246; 
 Fri, 25 Apr 2025 06:10:44 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9d443sm3071129b3a.150.2025.04.25.06.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 06:10:43 -0700 (PDT)
Message-ID: <71bf433d-1980-40cf-9b6c-5a01c31213d8@ventanamicro.com>
Date: Fri, 25 Apr 2025 10:10:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/riscv: widen (m|s)counteren to target_ulong
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250425113705.2741457-1-dbarboza@ventanamicro.com>
 <20250425113705.2741457-9-dbarboza@ventanamicro.com>
 <20250425-d3897a3163a3fb2853763a8e@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250425-d3897a3163a3fb2853763a8e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/25/25 9:11 AM, Andrew Jones wrote:
> On Fri, Apr 25, 2025 at 08:37:04AM -0300, Daniel Henrique Barboza wrote:
>> We want to support scounteren as a KVM CSR. The KVM UAPI defines every
>> CSR size as target_ulong, and our env->scounteren is fixed at 32 bits.
>>
>> The other existing cases where the property size does not match the KVM
>> reg size happens with uint64_t properties, like 'mstatus'. When running
>> a 32 bit CPU we'll write a 32 bit 'sstatus' KVM reg into the 64 bit
>> 'mstatus' field. As long as we're consistent, i.e. we're always
>> reading/writing the same words, this is ok.
>>
>> For scounteren, a KVM guest running in a 64 bit CPU will end up writing
>> a 64 bit reg in a 32 bit field. This will have all sort of funny side
>> effects in the KVM guest that we would rather avoid.
>>
>> Increase scounteren to target_ulong to allow KVM to read/write the
>> scounteren CSR without any surprises. 'mcounteren' is being changed to
>> target_ulong for consistency.
>>
>> Aside from bumping the version of the RISCVCPU vmstate no other
>> behavioral changes are expected.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.h     | 4 ++--
>>   target/riscv/machine.c | 8 ++++----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index f5a60d0c52..0623c3187b 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -400,8 +400,8 @@ struct CPUArchState {
>>        */
>>       bool two_stage_indirect_lookup;
>>   
>> -    uint32_t scounteren;
>> -    uint32_t mcounteren;
>> +    target_ulong scounteren;
>> +    target_ulong mcounteren;
> 
> Let's leave mcounteren a u32 and write a comment above scounteren
> explaining that it's supposed to be a u32 (as the spec says) but
> we're using a ulong instead to support KVM's get/put due to how
> it's defined in struct kvm_riscv_csr.

Fair enough.

> 
>>   
>>       uint32_t scountinhibit;
>>       uint32_t mcountinhibit;
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index df2d5bad8d..4b11b203fb 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
>>   
>>   const VMStateDescription vmstate_riscv_cpu = {
>>       .name = "cpu",
>> -    .version_id = 10,
>> -    .minimum_version_id = 10,
>> +    .version_id = 11,
>> +    .minimum_version_id = 11,
>>       .post_load = riscv_cpu_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>> @@ -445,8 +445,8 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           VMSTATE_UINTTL(env.mtval, RISCVCPU),
>>           VMSTATE_UINTTL(env.miselect, RISCVCPU),
>>           VMSTATE_UINTTL(env.siselect, RISCVCPU),
>> -        VMSTATE_UINT32(env.scounteren, RISCVCPU),
>> -        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
>> +        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
>> +        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> 
> Since we only expect the lower 32 bits to ever be written, then do we need
> to make this change?


The VMSTATE_UINT32() macro checks for the size of the variable and will fail in compile
time if it's not an uint32_t:

In file included from /home/danielhb/work/qemu/include/qemu/osdep.h:53,
                  from ../target/riscv/machine.c:19:
/home/danielhb/work/qemu/include/qemu/compiler.h:65:35: error: invalid operands to binary - (have ‘uint32_t *’ {aka ‘unsigned int *’} and ‘target_ulong *’ {aka ‘long unsigned int *’})
    65 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)
       |                                   ^
/home/danielhb/work/qemu/include/migration/vmstate.h:270:6: note: in expansion of macro ‘type_check’
   270 |      type_check(_type, typeof_field(_state, _field)))
       |      ^~~~~~~~~~
/home/danielhb/work/qemu/include/migration/vmstate.h:321:21: note: in expansion of macro ‘vmstate_offset_value’
   321 |     .offset       = vmstate_offset_value(_state, _field, _type),     \
       |                     ^~~~~~~~~~~~~~~~~~~~
/home/danielhb/work/qemu/include/migration/vmstate.h:854:5: note: in expansion of macro ‘VMSTATE_SINGLE_TEST’
   854 |     VMSTATE_SINGLE_TEST(_field, _state, NULL, _version, _info, _type)
       |     ^~~~~~~~~~~~~~~~~~~
/home/danielhb/work/qemu/include/migration/vmstate.h:902:5: note: in expansion of macro ‘VMSTATE_SINGLE’
   902 |     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, uint32_t)
       |     ^~~~~~~~~~~~~~
/home/danielhb/work/qemu/include/migration/vmstate.h:939:5: note: in expansion of macro ‘VMSTATE_UINT32_V’
   939 |     VMSTATE_UINT32_V(_f, _s, 0)
       |     ^~~~~~~~~~~~~~~~
../target/riscv/machine.c:448:9: note: in expansion of macro ‘VMSTATE_UINT32’
   448 |         VMSTATE_UINT32(env.scounteren, RISCVCPU),
       |         ^~~~~~~~~~~~~~


Thanks,

Daniel

> 
>>           VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
>>           VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>>           VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
>> -- 
>> 2.49.0
>>
> 
> Thanks,
> drew


