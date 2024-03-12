Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D76FC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1ck-0003HY-6a; Tue, 12 Mar 2024 08:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rk1ch-00032k-6R
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:52:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rk1cY-0001ry-Sc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:52:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ddbad11823so4277755ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710247961; x=1710852761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yc6iRIfEDdUlwWA7oqFfy6lGyjMJI0wLwlAMhYZQvcg=;
 b=Y9YTXFTPvUjIDGQPSTHzG+SxwTd+JTNaBdS3IkEAyRBU1dkVZi1ZAYReCM8IwKTwIL
 Ycm9HHheZ2U1ktuSgIEwds4XdE/ZNs1LmdPrX5LQi67Xwu+eoMdqEelQFK5ZK09wMnhL
 dS/BeSp2kvbJGeXMNZ2djQLIIKNKgm53+5g2DhWcJ32tAkM7w/bNlubpGXtI6E11cC7w
 c7vp2jfP2UnD3k+y890z8Iy3q9De7SaxyXVs13FXLHiIJ74FChMtnoNeneEvSAIN+3F+
 C866u4xphL37Z3KM38OKc2l+w9yKiMvnEy2YzNpkIEz84Cjb14VmY26pirDIcanrfXsO
 Xv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710247961; x=1710852761;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yc6iRIfEDdUlwWA7oqFfy6lGyjMJI0wLwlAMhYZQvcg=;
 b=ZNdzUndWt7/q0RBRqHPNVcuMC8VS35T1Pkw7Wt7IeiYWjzmYTVNOc7eNoZJ4sEpNiY
 NiRlSNAPzaMqGqUAGZhH2rBWBLA/TRJR1ZA0b91cH/dao4bUuh2+FxyGMwQg17R7wj/h
 Y037hlbWYzaSIOpuMoOFwvwkULldU0nRZI6aOCbz0045DbzhkDqJo2twvVbG71P4RQB/
 qxFcfgxBRxu2xMXFHFxIOtp4yst91oKLYA09jmid9BCWP4G+lzHba9WlJ3fmZMNMr1OV
 SW8Ty48EbIGijs9Fvm5MMDLppjOhORj+aulZw10YoLTcezluercFkPc8WOGVbA+a2lLB
 foLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWfggiX936dws20VJ7nbSAM+e72Wn4fRDmns0bEDJxccW5baLFZyfpApESLqYah8HBiOm0NfRuTViQSfOH4bMWSJbbG5Y=
X-Gm-Message-State: AOJu0Yx6JkAoZmXn0UgC9MPx6T1BIyZE/cnfk6wzoinvtQfev08ZjkV2
 nYF4BmNQ/YrL3BLPXPNq90xRsv7y5Outal67rhIGBc3XNxE8CRckdI+IVWUfVnw=
X-Google-Smtp-Source: AGHT+IEXkQ0eshI5KSh9PduugLLBzgadc+SxJ8VB1qqNgm1aOY1mjEvILlpVc/balqG7IfgEnlrbbA==
X-Received: by 2002:a17:902:7441:b0:1dc:7279:8a3e with SMTP id
 e1-20020a170902744100b001dc72798a3emr8862563plt.21.1710247961160; 
 Tue, 12 Mar 2024 05:52:41 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a170903228f00b001dd1bdee6d9sm6608666plh.31.2024.03.12.05.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:52:40 -0700 (PDT)
Message-ID: <4b4c39ef-3315-48fb-a8ed-f9d3fc1c7865@ventanamicro.com>
Date: Tue, 12 Mar 2024 09:52:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, tech-server-soc@lists.riscv.org,
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, andrei.warkentin@intel.com,
 shaolin.xie@alibaba-inc.com, ved@rivosinc.com, sunilvl@ventanamicro.com,
 haibo1.xu@intel.com, evan.chai@intel.com, yin.wang@intel.com,
 tech-server-platform@lists.riscv.org
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
 <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
 <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
 <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
 <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
 <52159cae-2f95-45e4-85c5-14b36984039c@ventanamicro.com>
 <603b8000-3949-4710-bcd1-7ce2f0fb9fbc@intel.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <603b8000-3949-4710-bcd1-7ce2f0fb9fbc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/12/24 09:33, Wu, Fei wrote:
> On 3/8/2024 3:15 AM, Daniel Henrique Barboza wrote:
>>
>>
>> On 3/7/24 04:36, Wu, Fei wrote:
>>> On 3/6/2024 9:26 PM, Wu, Fei wrote:
>>>> On 3/5/2024 1:58 PM, Wu, Fei wrote:
>>>>> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>>>>>
>>>>>>
>>>>>> On 3/4/24 07:25, Fei Wu wrote:
>>>>>>> The harts requirements of RISC-V server platform [1] require RVA23
>>>>>>> ISA
>>>>>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch
>>>>>>> provides
>>>>>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>>>>>
>>>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>>>>>     target/riscv/cpu-qom.h         |  1 +
>>>>>>>     target/riscv/cpu.c             | 62
>>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>>     3 files changed, 68 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/hw/riscv/server_platform_ref.c
>>>>>>> b/hw/riscv/server_platform_ref.c
>>>>>>> index ae90c4b27a..52ec607cee 100644
>>>>>>> --- a/hw/riscv/server_platform_ref.c
>>>>>>> +++ b/hw/riscv/server_platform_ref.c
>>>>>>> @@ -1205,11 +1205,15 @@ static void
>>>>>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>>>>     {
>>>>>>>         char str[128];
>>>>>>>         MachineClass *mc = MACHINE_CLASS(oc);
>>>>>>> +    static const char * const valid_cpu_types[] = {
>>>>>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>>>>>> +    };
>>>>>>>           mc->desc = "RISC-V Server SoC Reference board";
>>>>>>>         mc->init = rvsp_ref_machine_init;
>>>>>>>         mc->max_cpus = RVSP_CPUS_MAX;
>>>>>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>>>>>> +    mc->valid_cpu_types = valid_cpu_types;
>>>>>>
>>>>>> I suggest introducing this patch first, then the new machine type that
>>>>>> will use it as a default
>>>>>> CPU. The reason is to facilitate future bisects. If we introduce the
>>>>>> board first, a future bisect
>>>>>> might hit the previous patch, the board will be run using RV64 instead
>>>>>> of the correct CPU, and
>>>>>> we'll have different results because of it.
>>>>>>
>>>>> Good suggestion.
>>>>>
>>>>>>>         mc->pci_allow_0_address = true;
>>>>>>>         mc->default_nic = "e1000e";
>>>>>>>         mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>>>>> index 3670cfe6d9..adb934d19e 100644
>>>>>>> --- a/target/riscv/cpu-qom.h
>>>>>>> +++ b/target/riscv/cpu-qom.h
>>>>>>> @@ -49,6 +49,7 @@
>>>>>>>     #define TYPE_RISCV_CPU_SIFIVE_U54
>>>>>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>>>>>     #define TYPE_RISCV_CPU_THEAD_C906
>>>>>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>>>>>     #define TYPE_RISCV_CPU_VEYRON_V1
>>>>>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>>>>>> +#define TYPE_RISCV_CPU_RVSP_REF
>>>>>>> RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>>>>>     #define TYPE_RISCV_CPU_HOST
>>>>>>> RISCV_CPU_TYPE_NAME("host")
>>>>>>>       OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>>>> index 5ff0192c52..bc91be702b 100644
>>>>>>> --- a/target/riscv/cpu.c
>>>>>>> +++ b/target/riscv/cpu.c
>>>>>>> @@ -2282,6 +2282,67 @@ static void
>>>>>>> rva22s64_profile_cpu_init(Object *obj)
>>>>>>>           RVA22S64.enabled = true;
>>>>>>>     }
>>>>>>> +
>>>>>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>>>>>> +{
>>>>>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>>>>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>>>>>> +
>>>>>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>>>>>> +
>>>>>>> +    /* FIXME: change to 1.13 */
>>>>>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>>>>>> +
>>>>>>> +    /* RVA22U64 */
>>>>>>> +    cpu->cfg.mmu = true;
>>>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>>>> +    cpu->cfg.ext_zicsr = true;
>>>>>>> +    cpu->cfg.ext_zicntr = true;
>>>>>>> +    cpu->cfg.ext_zihpm = true;
>>>>>>> +    cpu->cfg.ext_zihintpause = true;
>>>>>>> +    cpu->cfg.ext_zba = true;
>>>>>>> +    cpu->cfg.ext_zbb = true;
>>>>>>> +    cpu->cfg.ext_zbs = true;
>>>>>>> +    cpu->cfg.zic64b = true;
>>>>>>> +    cpu->cfg.ext_zicbom = true;
>>>>>>> +    cpu->cfg.ext_zicbop = true;
>>>>>>> +    cpu->cfg.ext_zicboz = true;
>>>>>>> +    cpu->cfg.cbom_blocksize = 64;
>>>>>>> +    cpu->cfg.cbop_blocksize = 64;
>>>>>>> +    cpu->cfg.cboz_blocksize = 64;
>>>>>>> +    cpu->cfg.ext_zfhmin = true;
>>>>>>> +    cpu->cfg.ext_zkt = true;
>>>>>>
>>>>>> You can change this whole block with:
>>>>>>
>>>>>> RVA22U64.enabled = true;
>>>>>>
>>>>>>
>>>>>> riscv_cpu_add_profiles() will check if we have a profile enabled
>>>>>> and, if
>>>>>> that's the
>>>>>> case, we'll enable all its extensions in the CPU.
>>>>>>
>>>>>> In the near future, when we implement a proper RVA23 support, we'll be
>>>>>> able to just do
>>>>>> a single RVA23S64.enabled = true in this cpu_init(). But for now we
>>>>>> can
>>>>>> at least declare
>>>>>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>>>>>
>>>>
>>>> Hi Daniel,
>>>>
>>>> I'm not sure if it's a regression or the usage has been changed. I'm not
>>>> able to use '-cpu rva22s64' on latest qemu (db596ae190).
>>>>
>>> I did a quick git bisect and found that commit d06f28db6 "target/riscv:
>>> move 'mmu' to riscv_cpu_properties[]" disabled mmu by default, so that
>>> an explicit mmu option should be added to qemu command line like '-cpu
>>> rva22s64,mmu=true', I think rva22s64 should enable it by default.
>>>
>>
>> This is fixed in alistair/riscv-to-apply.next by this commit:
>>
> Hi Daniel,
> 
> The following still doesn't work for me with this commit (already
> upstreamed now)
> 
>    RVA22S64.enabled = true;
> 
> cpu_set_profile() does nothing for vendor cpu as it checks
> riscv_cpu_is_vendor() at the beginning, and it's still not working even
> if it's removed. I think rvsp-ref is supposed to be
> TYPE_RISCV_VENDOR_CPU, changing to other type such as DYNAMIC doesn't
> work either, how to make this work?

Hmm yeah, set_profile() is filtering vendor CPUs because, although we are exposing
profiles as command line options, users would be able to enable profiles in vendor
CPUs, pottentialy enable extensions that the CPU doesn't have, and we don't want
that.

One way to keep this behavior but allowing the usage I mentioned for rvsp-ref is
to put everything that's after this point in cpu_set_profile():

     if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }

in it's own helper, and then we would be able to enable profile extensions for
vendor CPUs outside of this setter.


This is out of scope for your RFC though. I thought this was a use case we can use for
rvsp-ref right now, but I was wrong. I believe we can keep what you've already done
(i.e. setting all exts by hand). We can rework in a generic way to enable profile
extensions for all CPUs later.


Thanks,

Daniel


> 
> Thanks,
> Fei.
> 
>> commit 5b8d66e6bf7904535ee277e9c70b332c4462f10a
>> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Date:   Thu Feb 15 19:39:50 2024 -0300
>>
>>      target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
>>          Recent changes in options handling removed the 'mmu' default the
>> bare
>>      CPUs had, meaning that we must enable 'mmu' by hand when using the
>>      rva22s64 profile CPU.
>>          Given that this profile is setting a satp mode, it already
>> implies that
>>      we need a 'mmu'. Enable the 'mmu' in this case.
>>
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>> Thanks,
>>> Fei.
>>>
>>>> -- latest qemu, cannot see linux boot message and blocked
>>>>
>>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>>     -cpu rva22s64 \
>>>>     -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>>     -kernel $Kernel
>>>>
>>>> Boot HART ID              : 1
>>>> Boot HART Domain          : root
>>>> Boot HART Priv Version    : v1.12
>>>> Boot HART Base ISA        : rv64imafdc
>>>> Boot HART ISA Extensions  : time
>>>> Boot HART PMP Count       : 0
>>>> Boot HART PMP Granularity : 0
>>>> Boot HART PMP Address Bits: 0
>>>> Boot HART MHPM Count      : 16
>>>> Boot HART MIDELEG         : 0x0000000000000222
>>>> Boot HART MEDELEG         : 0x000000000000b109
>>>>
>>>> -- latest qemu, w/o rva22s64, looks good
>>>>
>>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>>     -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>>     -kernel $Kernel
>>>>
>>>> Boot HART ID              : 0
>>>> Boot HART Domain          : root
>>>> Boot HART Priv Version    : v1.12
>>>> Boot HART Base ISA        : rv64imafdch
>>>> Boot HART ISA Extensions  : time,sstc
>>>> Boot HART PMP Count       : 16
>>>> Boot HART PMP Granularity : 4
>>>> Boot HART PMP Address Bits: 54
>>>> Boot HART MHPM Count      : 16
>>>> Boot HART MIDELEG         : 0x0000000000001666
>>>> Boot HART MEDELEG         : 0x0000000000f0b509
>>>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>>>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>>>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>>>
>>>> -- commit dfa3c4c57, patch to enable rva22s64, looks good
>>>>
>>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>>     -cpu rva22s64 \
>>>>     -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>>     -kernel $Kernel
>>>>
>>>> Boot HART ID              : 0
>>>> Boot HART Domain          : root
>>>> Boot HART Priv Version    : v1.12
>>>> Boot HART Base ISA        : rv64imafdc
>>>> Boot HART ISA Extensions  : time
>>>> Boot HART PMP Count       : 16
>>>> Boot HART PMP Granularity : 4
>>>> Boot HART PMP Address Bits: 54
>>>> Boot HART MHPM Count      : 16
>>>> Boot HART MIDELEG         : 0x0000000000000222
>>>> Boot HART MEDELEG         : 0x000000000000b109
>>>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>>>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>>>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>>>
>>>> Thanks,
>>>> Fei
>>>>
>>>>> Let me try.
>>>>>
>>>>> Thanks,
>>>>> Fei.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Daniel
>>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +    /* RVA23U64 */
>>>>>>> +    cpu->cfg.ext_zvfhmin = true;
>>>>>>> +    cpu->cfg.ext_zvbb = true;
>>>>>>> +    cpu->cfg.ext_zvkt = true;
>>>>>>> +    cpu->cfg.ext_zihintntl = true;
>>>>>>> +    cpu->cfg.ext_zicond = true;
>>>>>>> +    cpu->cfg.ext_zcb = true;
>>>>>>> +    cpu->cfg.ext_zfa = true;
>>>>>>> +    cpu->cfg.ext_zawrs = true;
>>>>>>> +
>>>>>>> +    /* RVA23S64 */
>>>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>>>> +    cpu->cfg.svade = true;
>>>>>>> +    cpu->cfg.ext_svpbmt = true;
>>>>>>> +    cpu->cfg.ext_svinval = true;
>>>>>>> +    cpu->cfg.ext_svnapot = true;
>>>>>>> +    cpu->cfg.ext_sstc = true;
>>>>>>> +    cpu->cfg.ext_sscofpmf = true;
>>>>>>> +    cpu->cfg.ext_smstateen = true;
>>>>>>> +
>>>>>>> +    cpu->cfg.ext_smaia = true;
>>>>>>> +    cpu->cfg.ext_ssaia = true;
>>>>>>> +
>>>>>>> +    /* Server Platform */
>>>>>>> +#ifndef CONFIG_USER_ONLY
>>>>>>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>>>>>>> +#endif
>>>>>>> +    cpu->cfg.ext_svadu = true;
>>>>>>> +    cpu->cfg.ext_zkr = true;
>>>>>>> +}
>>>>>>>     #endif
>>>>>>>       static const gchar *riscv_gdb_arch_name(CPUState *cs)
>>>>>>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[]
>>>>>>> = {
>>>>>>>         DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,
>>>>>>> rv64e_bare_cpu_init),
>>>>>>>         DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,
>>>>>>> rva22u64_profile_cpu_init),
>>>>>>>         DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,
>>>>>>> rva22s64_profile_cpu_init),
>>>>>>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,
>>>>>>> rv64_rvsp_ref_cpu_init),
>>>>>>>     #endif
>>>>>>>     };
>>>>>>>     
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#135):
>> https://lists.riscv.org/g/tech-server-soc/message/135
>> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
>> Group Owner: tech-server-soc+owner@lists.riscv.org
>> Unsubscribe:
>> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>
> 

