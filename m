Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B6C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 11:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaiC-0008GT-PB; Mon, 09 Jun 2025 07:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uOai9-0008Fz-4f
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:30:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uOai2-0001o9-JB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:30:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3477573b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749468630; x=1750073430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sihcIgSbzBOuqslUnXbT2x3V2M3mhgceXIxeRKBM1pg=;
 b=ZTr+2kDmRMyxeeHCXHKPMj7FIpOYJpcxPhyqx6Yj6Cblk2KZbujgfgnM584977e+kk
 7z9G+b0yrN49MSridAgGZ0F2ky0VVRK5ivZOo7T7I08rTUW+xTrOAWaWEq8TC4GgtsFv
 3iE/mIsnERMpvjd4AfNuLVIae0wjT9YRUwe6GNG92Ub1RWA/C3vZu17R44jZ1ZdJNlIH
 LyVpXv5lCyw0GMmmC8iZ1PIaTCznd9VziV2qUD9tDgBW7Ypa+f1RlY3IExCwJWpfZcN+
 2nCnF4YIQ7d2UYl6/gDdLJlSU8yFvBH5HG6/CcP7JMoWc7Z6+YNBIwKiukV6n2gVdWQb
 EO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749468630; x=1750073430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sihcIgSbzBOuqslUnXbT2x3V2M3mhgceXIxeRKBM1pg=;
 b=slygRwikA4aoOwsydHbAaUFxeTnaqMBFOjJyiDJAvrvMs8Pa9JcD1c5BBEkdddU9xt
 RvDX+nXd5fuakA1K/g0ihKZkqHcRCGjkHZULjLufdlYzaWyXMQewMKFitqY+06rMKdEY
 DiX0kBn0ERh8J57CnW6ATOV+JEn85KBouPtwvT471tQQ6mUGIzDtalu0u1+65neIwpKt
 NHjdaDTLbeDzmh0MVfyQLhxZcaCvON52b2YMMECGkSd6tidr4BzO2CKVlJw6pIlDGh4z
 9M77DJIPCCBSzydkmWtcujsJkSs2z/0Dgj2s6QLLuAN/gnkZ8AZIEqsWza4voiy09kLs
 ++ZA==
X-Gm-Message-State: AOJu0YwUQnea8NanBHjvjO9drw+s+oNbPLFUvr5arLclHQ9NJ0iSTlGI
 jmZHfLLG7BJT3giZkNqcfkc5UPcISQO7e2nLd6yhejDWnsIuxffG4OZLX4G2rmV9CkU=
X-Gm-Gg: ASbGncsWumA7dv/HlL+NiWX1xV5wKFAbvnYuaO1/qNVxmSORd6bo8eMiGuolXQM4RXH
 7dn7VUk+YVfCyfopw7kTvE8C3p3l6E0ddWFX5cDLBBsOvB21i0J//NqiWMOt7Hssk1vlEDR6L1r
 a5uP1mI05sS43S/69Ew5V1d6biRc51O34zyjtOHoeR2Of3NkosGDflLKIoWHSrZwuLtEdegx146
 CroD3RGPW3k3cptI8fx5YKyj6zGMvRRVgHuZBLtM8iXhnUyOSObGOuAz/sMFLHG9LFsc6iiisaS
 VTnZaJni+OGa9VQsvTd9HXRtBkZtVyrGdOJciXMt06hx4yYjnCwR3ifzVkumv+lxkmJlX66UGG4
 =
X-Google-Smtp-Source: AGHT+IHHBmJs+UwoEe/C3JAeJM0XVvRafev00SmY1CyaILUPVpA+pZMVaI9a2u+VkSpa1T7GAJNodw==
X-Received: by 2002:a05:6a00:4b51:b0:740:41e4:e761 with SMTP id
 d2e1a72fcca58-74827f3ba85mr16542837b3a.22.1749468630436; 
 Mon, 09 Jun 2025 04:30:30 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.21.192])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0f2ebasm5648777b3a.177.2025.06.09.04.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 04:30:29 -0700 (PDT)
Message-ID: <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
Date: Mon, 9 Jun 2025 08:30:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
 <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
 <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 6/9/25 7:40 AM, Ben Dooks wrote:
> On 07/06/2025 21:17, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/27/25 8:24 AM, Ben Dooks wrote:
>>> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   target/riscv/cpu-qom.h |  1 +
>>>   target/riscv/cpu.c     | 11 +++++++++++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>> index 1ee05eb393..3daf75568c 100644
>>> --- a/target/riscv/cpu-qom.h
>>> +++ b/target/riscv/cpu-qom.h
>>> @@ -34,6 +34,7 @@
>>>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>>>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>>>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
>>> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>>>   #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>>>   #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>>>   #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 629ac37501..fca45dc9d9 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>           .misa_mxl_max = MXL_RV64,
>>>       ),
>>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
>>> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU,
>>> +        .misa_mxl_max = MXL_RV64,
>>> +        .cfg.max_satp_mode = VM_1_10_SV39,
>>> +        .priv_spec = PRIV_VERSION_1_12_0,
>>> +        .cfg.pmp = true,
>>> +        .cfg.mmu = true,
>>> +        .cfg.ext_zifencei = true,
>>> +        .cfg.ext_zicsr = true,
>>> +    ),
>>> +
>>
>> The CPU is being added inside a "#if defined(TARGET_RISCV64)" block, meaning
>> that it's a 64-bit CPU only. But the CVA6 board added in patch 1 is being
>> added for both 32 and 64 bit emulations in hw/riscv/Kconfig:
> 
> Ah yes, it is possible to make a cva6 32bit, is it ok just to ove this
> into a different place or is there anything else needed to allow 32 or 64bit?
> 
> I've only been building a 64bit userland to test so didn't notice the
> lack of 32bit was an issue.
> 
>> config CVA6
>>      bool
>>      default y
>>      depends on RISCV32 || RISCV64  <------------------
>>
>> This setup (after patch 3 is added) triggered a test failure in 'check- qtest',
>> when polling all available boards in qemu-system-riscv32, because it didn't find
>> a default 32 bit CPU for the cva6 board:
>>
>> # starting QEMU: exec ./qemu-system-riscv32 -qtest unix:/tmp/ qtest-1683816.sock -qtest-log /dev/null -chardev socket,path=/tmp/ qtest-1683816.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine cva6 -accel qtest
>> ----------------------------------- stderr -----------------------------------
>> qemu-system-riscv32: ../hw/core/machine.c:1574: is_cpu_type_supported: Assertion `cc != NULL' failed.
>> Broken pipe
>> ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>>
>>
>>
>> We have 2 options here:
>>
>> - if the CVA6 board is supposed to run in RISCV32 and RISCV64, then its default
>> CPU must be 32 bit compliant too. The CPU declaration in this patch must be moved
>> outside the "#if defined(TARGET_RISCV64)" block (e.g right after
>> TYPE_RISCV_CPU_SIFIVE_U);
>>
>> - if the board is 64 bit only then the CPU declaration is fine, and we need to
>> change the board hw/riscv/Kconfig entry to "depends on RISCV64".
>>
> 
> As long as it is just the #ifdef block I will move it.

I just read the CV6 documentation at:

https://github.com/openhwgroup/cva6/


The README states right at the start:


"CVA6 is a 6-stage, single-issue, in-order CPU which implements the 64-bit RISC-V instruction set."


So this means that CVA6 is a 64-bit CPU only. This means that we want the second
option: the CPU declaration is fine, but the CVA6 board must be built only for 64
bits. In patch 1, this line:


>> config CVA6
>>      bool
>>      default y
>>      depends on RISCV32 || RISCV64  <------------------


Should be "depends on RISCV64".


Thanks,

Daniel

> 
> Should I just re-send this change?
> 
>> Thanks,
>>
>> Daniel
>>
>>
>>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
>>>           .misa_mxl_max = MXL_RV64
>>>       ),
>>
>>
> 
> 


