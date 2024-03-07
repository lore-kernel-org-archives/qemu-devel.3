Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C09C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJDm-0007fe-UU; Thu, 07 Mar 2024 14:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riJDa-0007cy-Ux
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:15:53 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riJDU-00058V-4A
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:15:47 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce942efda5so1000001a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709838938; x=1710443738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yrx9JCDVRPhgaAVwYHUK4pUsrbUwGQpQP9dyduxwUbY=;
 b=RgQ0rjp8r14LrIbXrE4uvPEXn0csfSPrX/xZeeRZVRiF55TPK7w3s41NeiKTMCpRrR
 qwlGll1ABd7K3phBvWEc6KXwsnK4NvHGEmhmaH2RrgShB/7UuNuwqaD8I2GnxSiIZIa5
 +NFd1XnXYYomvWysMWF+4MtfCvwhYP4Ipcj2HYdEHDIMVOBwcmO93tTeSnyMIGnZvgqW
 NmKmL7ImyM7DLo2zlnZYKPyq7WgWtR0cHM95LhxrIoQ6BjDzyoGctniPURE3BmoKaHb0
 oAydwYoIWV4ZSh988hMmvd5HiUZpbnpXY5GjGKZDniMc3+EGktFNCof1oJc4M0ADyock
 s5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709838938; x=1710443738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yrx9JCDVRPhgaAVwYHUK4pUsrbUwGQpQP9dyduxwUbY=;
 b=kypiDJHQe7auRKnPdAY2p8o+mhHsyoy4i8Fg2grC5OT9I4KmMX6lNiqFUhXJCG1SHL
 DBfhX4DmWdxZ8Q/JAoRm4xTZG5bcAq0I0cMXTSK1bSBlgtuG1ZLM5Kzw69SEZXaC5/Yj
 ILhn52djVyVV4fCixgo5+kKDC4ubGx3bwxNazMAHisQidjMPFVfVdDoguXJgDw6dREm/
 IDOn1bsAhnlp1qikhC+nh/oLD4zNxrmpm8dptw55fq+KsQPrfvwXZUb6FIVHE1UpzD5i
 EJpGmILuNxywB1iuqUZgf4+3GDo3JWyKyf8yO3BKSqiqEguHYKeQlSBhDEdB1JIcMMiI
 2UKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPHGqxXYw0/itaD7eDrssUS1It5NuQpI5fMVnsXQfTqvSYhG+AcU/xLisThan9I4LRisZoZfG9SoeRP2244+XSTKdS9oY=
X-Gm-Message-State: AOJu0YwnoHjWwU7fERecSD80fDtrlR4Xp0Ewp+ICxKTRBL5qB8SnJJyh
 pNmoFJT607O6BsVMpy55NjkjECfIYG1FEmf8k5aljosXB7JiSqph53FL061sjGlXRz62Agvyrpx
 +
X-Google-Smtp-Source: AGHT+IE+VhAU3q1jqIXMrgEE9jrggtCNTeiC1tVTkJ1TuUwXJz8usQUahXpm0cQkT51a0bKaAltMHA==
X-Received: by 2002:a17:903:41c2:b0:1dc:ccd3:29e5 with SMTP id
 u2-20020a17090341c200b001dcccd329e5mr11703272ple.2.1709838938052; 
 Thu, 07 Mar 2024 11:15:38 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170903004d00b001dd54c4320esm12283pla.256.2024.03.07.11.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 11:15:37 -0800 (PST)
Message-ID: <52159cae-2f95-45e4-85c5-14b36984039c@ventanamicro.com>
Date: Thu, 7 Mar 2024 16:15:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
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
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/7/24 04:36, Wu, Fei wrote:
> On 3/6/2024 9:26 PM, Wu, Fei wrote:
>> On 3/5/2024 1:58 PM, Wu, Fei wrote:
>>> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 3/4/24 07:25, Fei Wu wrote:
>>>>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>>>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
>>>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>>>
>>>>> [1]
>>>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>>>
>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>>>    target/riscv/cpu-qom.h         |  1 +
>>>>>    target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 68 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/riscv/server_platform_ref.c
>>>>> b/hw/riscv/server_platform_ref.c
>>>>> index ae90c4b27a..52ec607cee 100644
>>>>> --- a/hw/riscv/server_platform_ref.c
>>>>> +++ b/hw/riscv/server_platform_ref.c
>>>>> @@ -1205,11 +1205,15 @@ static void
>>>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>>    {
>>>>>        char str[128];
>>>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>>> +    static const char * const valid_cpu_types[] = {
>>>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>>>> +    };
>>>>>          mc->desc = "RISC-V Server SoC Reference board";
>>>>>        mc->init = rvsp_ref_machine_init;
>>>>>        mc->max_cpus = RVSP_CPUS_MAX;
>>>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>>>> +    mc->valid_cpu_types = valid_cpu_types;
>>>>
>>>> I suggest introducing this patch first, then the new machine type that
>>>> will use it as a default
>>>> CPU. The reason is to facilitate future bisects. If we introduce the
>>>> board first, a future bisect
>>>> might hit the previous patch, the board will be run using RV64 instead
>>>> of the correct CPU, and
>>>> we'll have different results because of it.
>>>>
>>> Good suggestion.
>>>
>>>>>        mc->pci_allow_0_address = true;
>>>>>        mc->default_nic = "e1000e";
>>>>>        mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>>> index 3670cfe6d9..adb934d19e 100644
>>>>> --- a/target/riscv/cpu-qom.h
>>>>> +++ b/target/riscv/cpu-qom.h
>>>>> @@ -49,6 +49,7 @@
>>>>>    #define TYPE_RISCV_CPU_SIFIVE_U54
>>>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>>>    #define TYPE_RISCV_CPU_THEAD_C906
>>>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>>>    #define TYPE_RISCV_CPU_VEYRON_V1
>>>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>>>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>>>    #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>>>>>      OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>> index 5ff0192c52..bc91be702b 100644
>>>>> --- a/target/riscv/cpu.c
>>>>> +++ b/target/riscv/cpu.c
>>>>> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>>>>          RVA22S64.enabled = true;
>>>>>    }
>>>>> +
>>>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>>>> +{
>>>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>>>> +
>>>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>>>> +
>>>>> +    /* FIXME: change to 1.13 */
>>>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>>>> +
>>>>> +    /* RVA22U64 */
>>>>> +    cpu->cfg.mmu = true;
>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>> +    cpu->cfg.ext_zicsr = true;
>>>>> +    cpu->cfg.ext_zicntr = true;
>>>>> +    cpu->cfg.ext_zihpm = true;
>>>>> +    cpu->cfg.ext_zihintpause = true;
>>>>> +    cpu->cfg.ext_zba = true;
>>>>> +    cpu->cfg.ext_zbb = true;
>>>>> +    cpu->cfg.ext_zbs = true;
>>>>> +    cpu->cfg.zic64b = true;
>>>>> +    cpu->cfg.ext_zicbom = true;
>>>>> +    cpu->cfg.ext_zicbop = true;
>>>>> +    cpu->cfg.ext_zicboz = true;
>>>>> +    cpu->cfg.cbom_blocksize = 64;
>>>>> +    cpu->cfg.cbop_blocksize = 64;
>>>>> +    cpu->cfg.cboz_blocksize = 64;
>>>>> +    cpu->cfg.ext_zfhmin = true;
>>>>> +    cpu->cfg.ext_zkt = true;
>>>>
>>>> You can change this whole block with:
>>>>
>>>> RVA22U64.enabled = true;
>>>>
>>>>
>>>> riscv_cpu_add_profiles() will check if we have a profile enabled and, if
>>>> that's the
>>>> case, we'll enable all its extensions in the CPU.
>>>>
>>>> In the near future, when we implement a proper RVA23 support, we'll be
>>>> able to just do
>>>> a single RVA23S64.enabled = true in this cpu_init(). But for now we can
>>>> at least declare
>>>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>>>
>>
>> Hi Daniel,
>>
>> I'm not sure if it's a regression or the usage has been changed. I'm not
>> able to use '-cpu rva22s64' on latest qemu (db596ae190).
>>
> I did a quick git bisect and found that commit d06f28db6 "target/riscv:
> move 'mmu' to riscv_cpu_properties[]" disabled mmu by default, so that
> an explicit mmu option should be added to qemu command line like '-cpu
> rva22s64,mmu=true', I think rva22s64 should enable it by default.
> 

This is fixed in alistair/riscv-to-apply.next by this commit:

commit 5b8d66e6bf7904535ee277e9c70b332c4462f10a
Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Date:   Thu Feb 15 19:39:50 2024 -0300

     target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
     
     Recent changes in options handling removed the 'mmu' default the bare
     CPUs had, meaning that we must enable 'mmu' by hand when using the
     rva22s64 profile CPU.
     
     Given that this profile is setting a satp mode, it already implies that
     we need a 'mmu'. Enable the 'mmu' in this case.



Thanks,

Daniel


> Thanks,
> Fei.
> 
>> -- latest qemu, cannot see linux boot message and blocked
>>
>> $Q -machine virt -nographic -m 2G -smp 2 \
>>    -cpu rva22s64 \
>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>    -kernel $Kernel
>>
>> Boot HART ID              : 1
>> Boot HART Domain          : root
>> Boot HART Priv Version    : v1.12
>> Boot HART Base ISA        : rv64imafdc
>> Boot HART ISA Extensions  : time
>> Boot HART PMP Count       : 0
>> Boot HART PMP Granularity : 0
>> Boot HART PMP Address Bits: 0
>> Boot HART MHPM Count      : 16
>> Boot HART MIDELEG         : 0x0000000000000222
>> Boot HART MEDELEG         : 0x000000000000b109
>>
>> -- latest qemu, w/o rva22s64, looks good
>>
>> $Q -machine virt -nographic -m 2G -smp 2 \
>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>    -kernel $Kernel
>>
>> Boot HART ID              : 0
>> Boot HART Domain          : root
>> Boot HART Priv Version    : v1.12
>> Boot HART Base ISA        : rv64imafdch
>> Boot HART ISA Extensions  : time,sstc
>> Boot HART PMP Count       : 16
>> Boot HART PMP Granularity : 4
>> Boot HART PMP Address Bits: 54
>> Boot HART MHPM Count      : 16
>> Boot HART MIDELEG         : 0x0000000000001666
>> Boot HART MEDELEG         : 0x0000000000f0b509
>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>
>> -- commit dfa3c4c57, patch to enable rva22s64, looks good
>>
>> $Q -machine virt -nographic -m 2G -smp 2 \
>>    -cpu rva22s64 \
>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>    -kernel $Kernel
>>
>> Boot HART ID              : 0
>> Boot HART Domain          : root
>> Boot HART Priv Version    : v1.12
>> Boot HART Base ISA        : rv64imafdc
>> Boot HART ISA Extensions  : time
>> Boot HART PMP Count       : 16
>> Boot HART PMP Granularity : 4
>> Boot HART PMP Address Bits: 54
>> Boot HART MHPM Count      : 16
>> Boot HART MIDELEG         : 0x0000000000000222
>> Boot HART MEDELEG         : 0x000000000000b109
>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>
>> Thanks,
>> Fei
>>
>>> Let me try.
>>>
>>> Thanks,
>>> Fei.
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Daniel
>>>>
>>>>
>>>>> +
>>>>> +    /* RVA23U64 */
>>>>> +    cpu->cfg.ext_zvfhmin = true;
>>>>> +    cpu->cfg.ext_zvbb = true;
>>>>> +    cpu->cfg.ext_zvkt = true;
>>>>> +    cpu->cfg.ext_zihintntl = true;
>>>>> +    cpu->cfg.ext_zicond = true;
>>>>> +    cpu->cfg.ext_zcb = true;
>>>>> +    cpu->cfg.ext_zfa = true;
>>>>> +    cpu->cfg.ext_zawrs = true;
>>>>> +
>>>>> +    /* RVA23S64 */
>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>> +    cpu->cfg.svade = true;
>>>>> +    cpu->cfg.ext_svpbmt = true;
>>>>> +    cpu->cfg.ext_svinval = true;
>>>>> +    cpu->cfg.ext_svnapot = true;
>>>>> +    cpu->cfg.ext_sstc = true;
>>>>> +    cpu->cfg.ext_sscofpmf = true;
>>>>> +    cpu->cfg.ext_smstateen = true;
>>>>> +
>>>>> +    cpu->cfg.ext_smaia = true;
>>>>> +    cpu->cfg.ext_ssaia = true;
>>>>> +
>>>>> +    /* Server Platform */
>>>>> +#ifndef CONFIG_USER_ONLY
>>>>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>>>>> +#endif
>>>>> +    cpu->cfg.ext_svadu = true;
>>>>> +    cpu->cfg.ext_zkr = true;
>>>>> +}
>>>>>    #endif
>>>>>      static const gchar *riscv_gdb_arch_name(CPUState *cs)
>>>>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>>>        DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,
>>>>> rv64e_bare_cpu_init),
>>>>>        DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,
>>>>> rva22u64_profile_cpu_init),
>>>>>        DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,
>>>>> rva22s64_profile_cpu_init),
>>>>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,
>>>>> rv64_rvsp_ref_cpu_init),
>>>>>    #endif
>>>>>    };
>>>>>    
>>>>
>>>>
>>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>> Links: You receive all messages sent to this group.
>>>> View/Reply Online (#125):
>>>> https://lists.riscv.org/g/tech-server-soc/message/125
>>>> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
>>>> Group Owner: tech-server-soc+owner@lists.riscv.org
>>>> Unsubscribe:
>>>> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
>>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>>
>>>>
>>>
>>
> 

