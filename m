Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26DDC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEK-0005Qr-Ig; Mon, 04 Mar 2024 14:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhEEE-0005QS-DF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:02 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhEEC-0006uG-Ak
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:02 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2997a92e23bso3009338a91.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709581439; x=1710186239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aK5MEnsuNt8kOWRDjkuorH2Y+KM/6UJXdQNK5bcYjo0=;
 b=KNosJvGvpu1tqNh0M2BMlI9Lq1rxdklHPgtOaJgt0R1AAlx89erKhr0yF+i1HChDA6
 t6hZ2w34twly/92eWSOGRwoXlI7+CW7/QSpK4s5MnHbY5J2BnFsDSjx+GIiipS3O2G3P
 op1cVgPiKYSkWRN9wSxNuMuxcMZ4e9gZANcCclscC1mc/nK2O1upgeeyF9ZO3SM/0BPw
 I6z4DLZgSdnsROhsMVeKtTm8JcPvPMUO2oHLVLwfJPwdyQ91iF1TZtIgYdKs0l/K2lhE
 qrkFyU7evZgflnkqE7+aBtoLwSa3ZFo7gbAzw+Zdzpzck7r26GQHgctT9VLBG5xpUykz
 OsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581439; x=1710186239;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aK5MEnsuNt8kOWRDjkuorH2Y+KM/6UJXdQNK5bcYjo0=;
 b=C84/zSeaf2d9nq1RhUVkwGE61LKFYFzv0fU3rZgCAgLKAUjTlUHQVtBg1pEBUbA+Wj
 xjBGJBrFqUSvl2wGHWWoTn4nSBBt6ONkr24EduCcsUggQMV7boawvXuE8d3Eo/5hZxqn
 cVyFVERmJrp/SqCZbdFLHYfBNQKI631T3FK7SqO7pgWuU3Pw++FMIC8SZbv3eBl9jm7/
 ry0Y2NTX0s5IpNiBkMmVW73jGwbs7iwFXysPnv2hhhN5ZQD5DuxCdekn6avXKEquG/AE
 l0LbZFcYohvMnmdsqBHmYSGiJhA7UmSKxGJRacxbswukjXg7wwsoEcCZV8q634UBgx4u
 xqJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmriwxEcHNsQv2QGJ68e3rbMFxeTG5ZTtoN+MZSLdCIAq9ImYKBnxV25m2+s6YvNP21/6l1DsNQUcu/8beETn69BdSQGU=
X-Gm-Message-State: AOJu0YxwwZpBJaT6xOMMe4Y3RNtbtWK0Cl2c/cmsVvyGgknm3OGmnXzj
 KoyuRkVXZfufQ1f3iDJTX8CXDVSa10eAE7TM8frnoGBQXNGnf32JwZwjtvvGKFg=
X-Google-Smtp-Source: AGHT+IEuYVC/BMVyeTeiUK3bampXahobefIY9pUY+jaAuuisRPZKDylQ/clZA8hbTaE5XpJm2I+kGg==
X-Received: by 2002:a17:90b:1007:b0:29a:bb49:eb41 with SMTP id
 gm7-20020a17090b100700b0029abb49eb41mr6937237pjb.29.1709581438987; 
 Mon, 04 Mar 2024 11:43:58 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:e4b8:6daf:840a:5593:a7a3?
 ([2804:7f0:bcc0:e4b8:6daf:840a:5593:a7a3])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a17090ad40c00b00298d2182f1asm10363868pju.55.2024.03.04.11.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 11:43:58 -0800 (PST)
Message-ID: <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
Date: Mon, 4 Mar 2024 16:43:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] target/riscv: Add server platform reference cpu
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240304102540.2789225-3-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
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



On 3/4/24 07:25, Fei Wu wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
> a virt CPU type (rvsp-ref) as compliant as possible.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> --->   hw/riscv/server_platform_ref.c |  6 +++-
>   target/riscv/cpu-qom.h         |  1 +
>   target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>   3 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index ae90c4b27a..52ec607cee 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -1205,11 +1205,15 @@ static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>   {
>       char str[128];
>       MachineClass *mc = MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_RVSP_REF,
> +    };
>   
>       mc->desc = "RISC-V Server SoC Reference board";
>       mc->init = rvsp_ref_machine_init;
>       mc->max_cpus = RVSP_CPUS_MAX;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
> +    mc->valid_cpu_types = valid_cpu_types;

I suggest introducing this patch first, then the new machine type that will use it as a default
CPU. The reason is to facilitate future bisects. If we introduce the board first, a future bisect
might hit the previous patch, the board will be run using RV64 instead of the correct CPU, and
we'll have different results because of it.

>       mc->pci_allow_0_address = true;
>       mc->default_nic = "e1000e";
>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 3670cfe6d9..adb934d19e 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -49,6 +49,7 @@
>   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>   #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5ff0192c52..bc91be702b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>   
>       RVA22S64.enabled = true;
>   }
> +
> +static void rv64_rvsp_ref_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
> +
> +    /* FIXME: change to 1.13 */
> +    env->priv_ver = PRIV_VERSION_1_12_0;
> +
> +    /* RVA22U64 */
> +    cpu->cfg.mmu = true;
> +    cpu->cfg.ext_zifencei = true;
> +    cpu->cfg.ext_zicsr = true;
> +    cpu->cfg.ext_zicntr = true;
> +    cpu->cfg.ext_zihpm = true;
> +    cpu->cfg.ext_zihintpause = true;
> +    cpu->cfg.ext_zba = true;
> +    cpu->cfg.ext_zbb = true;
> +    cpu->cfg.ext_zbs = true;
> +    cpu->cfg.zic64b = true;
> +    cpu->cfg.ext_zicbom = true;
> +    cpu->cfg.ext_zicbop = true;
> +    cpu->cfg.ext_zicboz = true;
> +    cpu->cfg.cbom_blocksize = 64;
> +    cpu->cfg.cbop_blocksize = 64;
> +    cpu->cfg.cboz_blocksize = 64;
> +    cpu->cfg.ext_zfhmin = true;
> +    cpu->cfg.ext_zkt = true;

You can change this whole block with:

RVA22U64.enabled = true;


riscv_cpu_add_profiles() will check if we have a profile enabled and, if that's the
case, we'll enable all its extensions in the CPU.

In the near future, when we implement a proper RVA23 support, we'll be able to just do
a single RVA23S64.enabled = true in this cpu_init(). But for now we can at least declare
RVA22U64 (perhaps RVA22S64) support for this CPU.


Thanks,

Daniel


> +
> +    /* RVA23U64 */
> +    cpu->cfg.ext_zvfhmin = true;
> +    cpu->cfg.ext_zvbb = true;
> +    cpu->cfg.ext_zvkt = true;
> +    cpu->cfg.ext_zihintntl = true;
> +    cpu->cfg.ext_zicond = true;
> +    cpu->cfg.ext_zcb = true;
> +    cpu->cfg.ext_zfa = true;
> +    cpu->cfg.ext_zawrs = true;
> +
> +    /* RVA23S64 */
> +    cpu->cfg.ext_zifencei = true;
> +    cpu->cfg.svade = true;
> +    cpu->cfg.ext_svpbmt = true;
> +    cpu->cfg.ext_svinval = true;
> +    cpu->cfg.ext_svnapot = true;
> +    cpu->cfg.ext_sstc = true;
> +    cpu->cfg.ext_sscofpmf = true;
> +    cpu->cfg.ext_smstateen = true;
> +
> +    cpu->cfg.ext_smaia = true;
> +    cpu->cfg.ext_ssaia = true;
> +
> +    /* Server Platform */
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
> +#endif
> +    cpu->cfg.ext_svadu = true;
> +    cpu->cfg.ext_zkr = true;
> +}
>   #endif
>   
>   static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,  rv64_rvsp_ref_cpu_init),
>   #endif
>   };
>   

