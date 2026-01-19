Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDC4D29C28
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpAB-0000ty-1n; Mon, 19 Jan 2026 08:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vhpAA-0000tc-AE
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:19:22 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vhpA7-0004xK-RO
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:19:21 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5014e1312c6so19520651cf.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768828758; x=1769433558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kkaooDlowkjQOVv6SkrGEd2sYv+v1R/MT/ZtiDERZbk=;
 b=GevjxHUh+OVHLbNVgzRo0SPjDRI6FNA8VUnhNblSCt5SNTptpvsNJOsAYUzExPNVRW
 WPbCCkmSngriLP51WDyZfvS2KklxiaKg7DN5RIwsP1nA3Ids5v8XtfsMNYl97izpo5TD
 KkXCkM48xzZfg0nIhnU/qTDqgwFdQLwW9uTqnTz5u+uDkZsojMdfzyymeJZiG19L9D76
 hoLrXA+WLBU+ECkKzOMbGiEy2w+vlSsmooz7v9VFXzml4XM+Q3tOgHLvzKBk9fHSnPSL
 OmiljQbmnNPAWrUygsuODMwpCtMFAn/1umc+6fi8qWkDmLlSXfATG4RbGVRgwbM8TGdu
 xwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768828758; x=1769433558;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkaooDlowkjQOVv6SkrGEd2sYv+v1R/MT/ZtiDERZbk=;
 b=tCafZYvoTBCXvDf1GK++524MC1bvE7ZO6vIEGOrgdStgyPWQRZHoccVpQZG9BWX7+C
 lNXmCqNPfrGSZUEsUi9gSfj/3D1rzKipuBuwUFJUD31v9eBZS232djUJP/1MM56kpn3h
 uS8WI4UteL7k54cAEwGrl3ggUKmaca/SSqU2nBT0Q4aowZF5M1Mdj7sWtTKWndn9yfPr
 fOukHtPyIPCSDvJqa3fGdZv6bdlnZZDuJqbg1f5RtBeDa+vgHhnjskPYWiqTKRls5e0V
 AfWsmNP6oQFzdvdpzO+yWV3Sg52Y3GgWFvpTOf8IZU2TIZak+6nZpImIXLhk6MSphcU0
 Szjg==
X-Gm-Message-State: AOJu0YxqL8PpgvVtEglMExVDkPfP6tNA54fHjR8Beis81QH7FdWcGqf8
 VaDLsAa6lT6N8Jrq615uGS/ajUu+50nCxMKdirxKO3WzAxSC59MPfb7phLY2v49Gwd4=
X-Gm-Gg: AY/fxX5gtKxp001naYtBBUtbSkZ0SE6+b/GGOWjN4FjCtUjWP1nSFXMR91U1voRu+Y0
 fYnv9j7KdclhaZys/t6guBI99Ojsr4IgzZcpKSVg63jrJRgAlqDNYxT4mlSaoRM/yf9TsFZs4Eg
 vyWLRDGh1jbdqlKta6Ft35D1/UGtst5rLW4rW2liA1UaRI8/yvGpD4Bd5O8Ct6RJP87Q0FYFQWl
 pf55DJPr76/MyXqqL4hZ2N2/LC+0zAgJj+lac20o9KPqFDSLZfmcaNIlPIe/kPgcDTGgliIlg0N
 iTbo1LqwlpYMMqhkMUZ/aMxZMUphAHeorZPSK83fNF66AobUjoOGDvXrU0ympXjwdkXl0bN4J+p
 5zh/JvzzWlIeCROBFB05kJfdgikNaI80XJs7bBnbXNHV0uZQlHl02MD/fHMQ7/A8kflTszjEEHK
 Jci1x7Rc5noH2InaWjxpqWvJ1TbqtbZrl8n1uWQoA=
X-Received: by 2002:ac8:5ac2:0:b0:4ed:b83f:78a3 with SMTP id
 d75a77b69052e-502a1759606mr153059241cf.47.1768828757732; 
 Mon, 19 Jan 2026 05:19:17 -0800 (PST)
Received: from [192.168.68.103] ([152.234.122.35])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1d9eca6sm77073521cf.11.2026.01.19.05.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 05:19:17 -0800 (PST)
Message-ID: <d7fa00f7-7e10-454c-b4b1-03ac4862fc9d@ventanamicro.com>
Date: Mon, 19 Jan 2026 10:19:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/8] riscv: split sdext and sdtrig config bits
To: Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
 <78122e119ee8c961716e2bec72c9895148b04ef9.1768622882.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <78122e119ee8c961716e2bec72c9895148b04ef9.1768622882.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/17/2026 1:27 AM, Chao Liu wrote:
> Add cfg.ext_sdext and cfg.ext_sdtrig and expose them as ISA
> extensions. Keep the legacy 'debug' CPU property as a global kill
> switch and force-disable both when it is off.


I would rather put the 'debug' flag in deprecation. It's a flag that at 
this moment means 'enable sdtrig' and I'd rather get rid of it than 
making it enable sdext too.

But deprecating 'debug' is out of scope for this work and we can handle 
it later. Matter of fact I might drop patches deprecating it today.

About enabling sdext by default, the patch is breaking bios-table-test 
because we're adding an extra string in riscv,isa ...



> 
> Trigger CSRs (tselect/tdata*/tinfo/mcontext) and trigger setup now
> depend on ext_sdtrig instead of cfg.debug.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   target/riscv/cpu.c                | 18 +++++++++++++++---
>   target/riscv/cpu_cfg_fields.h.inc |  2 ++
>   target/riscv/csr.c                | 16 ++++++++--------
>   target/riscv/machine.c            |  4 ++--
>   target/riscv/tcg/tcg-cpu.c        | 11 +----------
>   5 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..bc0b385cc1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,7 +189,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>       ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -783,7 +784,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       env->vill = true;
>   
>   #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>           riscv_trigger_reset_hold(env);
>       }
>   
> @@ -922,6 +923,15 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>               return;
>           }
>       }
> +
> +    /*
> +     * Keep the legacy 'debug' CPU property as a global kill switch.
> +     * If it is off, force-disable Sdext/Sdtrig regardless of ISA strings.
> +     */
> +    if (!cpu->cfg.debug) {
> +        cpu->cfg.ext_sdext = false;
> +        cpu->cfg.ext_sdtrig = false;
> +    }
>   }
>   
>   static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> @@ -946,7 +956,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       riscv_cpu_register_gdb_regs_for_features(cs);
>   
>   #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>           riscv_trigger_realize(&cpu->env);
>       }
>   #endif
> @@ -1112,6 +1122,8 @@ static void riscv_cpu_init(Object *obj)
>        */
>       RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
>       RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
> +    RISCV_CPU(obj)->cfg.ext_sdext = true;
> +    RISCV_CPU(obj)->cfg.ext_sdtrig = true;


^ here. Every time we change the defaults we have to dance around 
bios-tables-test due to riscv,isa changes.

If we really want sdext to be enabled by default we should (1) only 
enable it when the feature is already fully implemented and (2) changing 
bios-tables-test according to avoid leaving broken tests.



The remaining of the patch has the right idea, like here:



>   
>       /* Default values for non-bool cpu properties */
>       cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc79..9701319195 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -44,6 +44,8 @@ BOOL_FIELD(ext_zihpm)
>   BOOL_FIELD(ext_zimop)
>   BOOL_FIELD(ext_zcmop)
>   BOOL_FIELD(ext_ztso)
> +BOOL_FIELD(ext_sdext)
> +BOOL_FIELD(ext_sdtrig)
>   BOOL_FIELD(ext_smstateen)
>   BOOL_FIELD(ext_sstc)
>   BOOL_FIELD(ext_smcdeleg)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5c91658c3d..4f071b1db2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -775,9 +775,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> -static RISCVException debug(CPURISCVState *env, int csrno)
> +static RISCVException sdtrig(CPURISCVState *env, int csrno)
>   {
> -    if (riscv_cpu_cfg(env)->debug) {
> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>           return RISCV_EXCP_NONE;
>       }

debug == sdtrig is what we want and we should use 'sdtrig' everywhere 
'debug' is appearing, but there's a particular way to go about it. We 
need to add getters/setters for 'debug' that would enable/disable 
sdtrig. We should avoid adding this kind of handling in init() or 
finalize().

I can do that in a deprecation patch. You can use your patches to handle 
sdext only.


Thanks,
Daniel

>   
> @@ -6308,12 +6308,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                            .min_priv_ver = PRIV_VERSION_1_12_0           },
>   
>       /* Debug CSRs */
> -    [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
> -    [CSR_TDATA1]    =  { "tdata1",   debug, read_tdata,    write_tdata    },
> -    [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,    write_tdata    },
> -    [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
> -    [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
> -    [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
> +    [CSR_TSELECT]   =  { "tselect",  sdtrig, read_tselect,  write_tselect  },
> +    [CSR_TDATA1]    =  { "tdata1",   sdtrig, read_tdata,    write_tdata    },
> +    [CSR_TDATA2]    =  { "tdata2",   sdtrig, read_tdata,    write_tdata    },
> +    [CSR_TDATA3]    =  { "tdata3",   sdtrig, read_tdata,    write_tdata    },
> +    [CSR_TINFO]     =  { "tinfo",    sdtrig, read_tinfo,    write_ignore   },
> +    [CSR_MCONTEXT]  =  { "mcontext", sdtrig, read_mcontext, write_mcontext },
>   
>       [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 18d790af0d..d6a0b8e357 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -222,7 +222,7 @@ static bool debug_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>   
> -    return cpu->cfg.debug;
> +    return cpu->cfg.ext_sdext || cpu->cfg.ext_sdtrig;
>   }
>   
>   static int debug_post_load(void *opaque, int version_id)
> @@ -230,7 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>   
> -    if (icount_enabled()) {
> +    if (cpu->cfg.ext_sdtrig && icount_enabled()) {
>           env->itrigger_enabled = riscv_itrigger_enabled(env);
>       }
>   
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index d3968251fa..b5a26cf662 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -177,7 +177,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> -    if (cpu->cfg.debug && !icount_enabled()) {
> +    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>       }
>   #endif
> @@ -469,15 +469,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>                   continue;
>               }
>   
> -            /*
> -             * cpu.debug = true is marked as 'sdtrig', priv spec 1.12.
> -             * Skip this warning since existing CPUs with older priv
> -             * spec and debug = true will be impacted.
> -             */
> -            if (!strcmp(edata->name, "sdtrig")) {
> -                continue;
> -            }
> -
>               isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
>   
>               /*


