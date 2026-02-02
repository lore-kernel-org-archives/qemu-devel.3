Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0B4E7DF13
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxtP-0007Ke-6B; Mon, 02 Feb 2026 12:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxtN-0007KB-QH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:39:17 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vmxtL-0004e2-Dt
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:39:17 -0500
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8c59bce68a1so357011985a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770053954; x=1770658754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BrIOMSspAJuVYvXM4SNxT1bpAos9fFxbnpQTGHhn1dE=;
 b=QdI1AadLlSpsPFGc09s0oUtCzhcfJ7Ww2tMTE/vxUvH2urIHk74uw/9DtAZMyEc4x9
 q7iuLHM8FVMyAIEt7vbZo2Gph3ALkAgiaVqf3W3jgEJydUX/A8X3jNde4AqwNwbIDo5W
 6I12enxn0in0HSBueXN+vVhNJYzMUZHjyw53wRNSNrxh/9Wf2ryQmW3Js8Kafq/oL17f
 q2yu0o6TCNMOL8wXyCiKlOX1IQY93XZaNgtKwOM9h/iNW/61EjUv6ej1ZPxx/OHF73B5
 b3vMFfglo8oIc+S9i93DRfltzEIpE2dnabmm3XUH0IcUuKzdk9ZzEO0MtiUuNosf2GhL
 s9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053954; x=1770658754;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BrIOMSspAJuVYvXM4SNxT1bpAos9fFxbnpQTGHhn1dE=;
 b=Fc6iNPjZhHhexgf5LzNrNKITx13nH8vgIfHQywAn44Alyi0DX3ogkonpIILtKm+N27
 BBrVGIZiAKx9z9CfJgaYZeeNexMKuc2nTDu6llo2WVuXAReJKLMTvvl1zLA5viisu8HW
 o5RZ4+BqwdBeQi9PagCfg+dfvSTzL3haSzUVzpLWvhOzaV63OnLeGxpHbCrFHMQA+Myb
 XnotU4gPc/3dDSeiPedgvarjxzGhfy7uoL8uVhA7t0wZxUXUH4rao8dF+wi+Gx3LH1YI
 6WGcObGvBKYcOzd46E3pPEkM7E4MnIrprY9e4I0tGV4PgktRYrl4elnhl6RnkdGeO0Qa
 E9sw==
X-Gm-Message-State: AOJu0YzmKsgbmP2dw+CqqcrIGzB5pCl6bJ1kBkKCzrOd2O8e++wyKif0
 nNgWibhLFcvFLTSUitM3igup3pwUmn/Hpw2SOMKIYqueEo3X3+8Qn1DDVq3ixr6x4IU=
X-Gm-Gg: AZuq6aI3mpliqEoYj7kIemFBqzX5fMdZpXAAj/uY7LAWzAJaWEzZCYirXloWAEx/xyM
 E5ysCGxBm9jURop3o+4tmH5NhRx0/UmQnF/5yka/uV77t7riPDTn0dtOyqe3Fbr4cvVQrymDDaK
 kdxev8y18OCKrefgBZRFtiZ83UZdVbEOB70vpy1zOAwAA0TGV01z+vhXdMPe2B5AlrAsjac7+Bt
 ZhRplAlCTQG58ATfM9FJbqS3uIzqdM/7zQv6PV+wmP7qYrokEPn9LTAOX8wilZxoV+DwAe8/ORv
 tMdwwg1trbJeFB9u6Smir+Y6pGH0I7RGkSZAHwktFmMvekyz+wxTwkAqFZMIdxPU5NfZ4xa5XEs
 +hQubqKdocfd5XfqNJ5elhv3ZMLhYxxUfWn+Q5QopwvJbE2bo7rAI0tNeBlfuI5LWSRtI4Ns3cE
 a0DasctUIQOvK/Kmi/6YnHrcmVOclKTzto2BABbpiNiTvvW/fFBEV0Qz/JsO/2fi3sTs/m942WR
 Q==
X-Received: by 2002:a05:620a:444a:b0:8c6:aeff:4002 with SMTP id
 af79cd13be357-8c9eb349f59mr1580477285a.81.1770053953546; 
 Mon, 02 Feb 2026 09:39:13 -0800 (PST)
Received: from [192.168.68.103] (200-206-229-25.dsl.telesp.net.br.
 [200.206.229.25]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b7c789sm1274221785a.7.2026.02.02.09.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:39:13 -0800 (PST)
Message-ID: <3d39bbeb-d0ce-4b9b-9aa3-71f6e0dc8230@ventanamicro.com>
Date: Mon, 2 Feb 2026 14:39:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/7] target/riscv: add sdext debug CSRs state
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
 <6cbae2d3248275c050942c196f6b6e16d1ad4eee.1769751489.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <6cbae2d3248275c050942c196f6b6e16d1ad4eee.1769751489.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x744.google.com
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



On 1/30/2026 3:00 AM, Chao Liu wrote:
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> 
> Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
> and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
> them to Debug Mode (or host debugger access).
> 
> The Sdext is not fully implemented, so it is disabled by default.
> 
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   target/riscv/cpu.c                |  11 +++
>   target/riscv/cpu.h                |   4 +
>   target/riscv/cpu_bits.h           |  33 ++++++++
>   target/riscv/cpu_cfg_fields.h.inc |   1 +
>   target/riscv/csr.c                | 126 ++++++++++++++++++++++++++++++
>   target/riscv/machine.c            |  20 +++++
>   6 files changed, 195 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9fa4e09f17..9b08ef9fb0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -210,6 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>       ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
> @@ -782,6 +783,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       env->vill = true;
>   
>   #ifndef CONFIG_USER_ONLY
> +    env->debug_mode = false;
> +    env->dcsr = DCSR_DEBUGVER(4);
> +    env->dpc = 0;
> +    env->dscratch[0] = 0;
> +    env->dscratch[1] = 0;
> +
>       if (cpu->cfg.ext_sdtrig) {
>           riscv_trigger_reset_hold(env);
>       }
> @@ -1132,6 +1139,9 @@ static void riscv_cpu_init(Object *obj)
>        */
>       cpu->cfg.ext_sdtrig = true;
>   
> +    /* sdext is not fully implemented, so it is disabled by default. */
> +    cpu->cfg.ext_sdext = false;
> +

We don't need to specify ext_sdext as default false here. You've already 
set it to false in MULTI_EXT_CFG_BOOL below, and that covers the rv64 
defaults. For every other CPU, an ext is always assumed as 'false' 
unless it's explicitly set to 'true' somewhere.


Everything else LGTM, so with these 3 lines above removed:

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>       if (mcc->def->profile) {
>           mcc->def->profile->enabled = true;
>       }
> @@ -1246,6 +1256,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>       MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>       MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("sdext", ext_sdext, false),
>       MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
>       MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
>       MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c0676ed53..2a265faae5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -476,6 +476,10 @@ struct CPUArchState {
>   
>       /* True if in debugger mode.  */
>       bool debugger;
> +    bool debug_mode;
> +    target_ulong dcsr;
> +    target_ulong dpc;
> +    target_ulong dscratch[2];
>   
>       uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>       uint64_t hstateen[SMSTATEEN_MAX_COUNT];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..bb59f7ff56 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -467,6 +467,39 @@
>   #define CSR_DCSR            0x7b0
>   #define CSR_DPC             0x7b1
>   #define CSR_DSCRATCH        0x7b2
> +#define CSR_DSCRATCH1       0x7b3
> +
> +/* DCSR fields */
> +#define DCSR_XDEBUGVER_SHIFT    28
> +#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
> +#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
> +#define DCSR_EXTCAUSE_SHIFT     24
> +#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
> +#define DCSR_CETRIG             BIT(19)
> +#define DCSR_PELP               BIT(18)
> +#define DCSR_EBREAKVS           BIT(17)
> +#define DCSR_EBREAKVU           BIT(16)
> +#define DCSR_EBREAKM            BIT(15)
> +#define DCSR_EBREAKS            BIT(13)
> +#define DCSR_EBREAKU            BIT(12)
> +#define DCSR_STEPIE             BIT(11)
> +#define DCSR_STOPCOUNT          BIT(10)
> +#define DCSR_STOPTIME           BIT(9)
> +#define DCSR_CAUSE_SHIFT        6
> +#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
> +#define DCSR_V                  BIT(5)
> +#define DCSR_MPRVEN             BIT(4)
> +#define DCSR_NMIP               BIT(3)
> +#define DCSR_STEP               BIT(2)
> +#define DCSR_PRV_MASK           0x3u
> +
> +#define DCSR_CAUSE_EBREAK       1
> +#define DCSR_CAUSE_TRIGGER      2
> +#define DCSR_CAUSE_HALTREQ      3
> +#define DCSR_CAUSE_STEP         4
> +#define DCSR_CAUSE_RESET        5
> +#define DCSR_CAUSE_GROUP        6
> +#define DCSR_CAUSE_OTHER        7
>   
>   /* Performance Counters */
>   #define CSR_MHPMCOUNTER3    0xb03
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 1e9162281f..e0d70fe8c7 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>   BOOL_FIELD(ext_zimop)
>   BOOL_FIELD(ext_zcmop)
>   BOOL_FIELD(ext_ztso)
> +BOOL_FIELD(ext_sdext)
>   BOOL_FIELD(ext_sdtrig)
>   BOOL_FIELD(ext_smstateen)
>   BOOL_FIELD(ext_sstc)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 870fad87ac..3e38c943e0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3136,6 +3136,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +#if !defined(CONFIG_USER_ONLY)
> +static RISCVException sdext(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_sdext) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (!env->debug_mode && !env->debugger) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static target_ulong dcsr_visible_mask(CPURISCVState *env)
> +{
> +    target_ulong mask = (target_ulong)-1;
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!riscv_has_ext(env, RVH)) {
> +        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
> +    }
> +    if (!riscv_has_ext(env, RVS)) {
> +        mask &= ~DCSR_EBREAKS;
> +    }
> +    if (!riscv_has_ext(env, RVU)) {
> +        mask &= ~DCSR_EBREAKU;
> +    }
> +    if (!cpu->cfg.ext_zicfilp) {
> +        mask &= ~DCSR_PELP;
> +    }
> +    if (!cpu->cfg.ext_smdbltrp) {
> +        mask &= ~DCSR_CETRIG;
> +    }
> +
> +    return mask;
> +}
> +
> +static RISCVException read_dcsr(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
> +{
> +    *val = env->dcsr & dcsr_visible_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static target_ulong dcsr_writable_mask(CPURISCVState *env)
> +{
> +    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
> +                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
> +                        DCSR_STEP | DCSR_PRV_MASK;
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    mask |= DCSR_MPRVEN;
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
> +    }
> +    if (riscv_has_ext(env, RVS)) {
> +        mask |= DCSR_EBREAKS;
> +    }
> +    if (riscv_has_ext(env, RVU)) {
> +        mask |= DCSR_EBREAKU;
> +    }
> +    if (cpu->cfg.ext_zicfilp) {
> +        mask |= DCSR_PELP;
> +    }
> +    if (cpu->cfg.ext_smdbltrp) {
> +        mask |= DCSR_CETRIG;
> +    }
> +
> +    return mask;
> +}
> +
> +static RISCVException write_dcsr(CPURISCVState *env, int csrno,
> +                                 target_ulong val, uintptr_t ra)
> +{
> +    target_ulong mask = dcsr_writable_mask(env);
> +    target_ulong new_val = env->dcsr;
> +
> +    new_val &= ~mask;
> +    new_val |= val & mask;
> +    new_val &= ~DCSR_XDEBUGVER_MASK;
> +    new_val |= DCSR_DEBUGVER(4);
> +    env->dcsr = new_val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_dpc(CPURISCVState *env, int csrno,
> +                               target_ulong *val)
> +{
> +    *val = env->dpc & get_xepc_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_dpc(CPURISCVState *env, int csrno,
> +                                target_ulong val, uintptr_t ra)
> +{
> +    env->dpc = val & get_xepc_mask(env);
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_dscratch(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
> +
> +    *val = env->dscratch[index];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_dscratch(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
> +{
> +    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
> +
> +    env->dscratch[index] = val;
> +    return RISCV_EXCP_NONE;
> +}
> +#endif /* !CONFIG_USER_ONLY */
> +
>   /* Execution environment configuration setup */
>   static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
>                                      target_ulong *val)
> @@ -6297,6 +6417,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
>       [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
>       [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
> +#if !defined(CONFIG_USER_ONLY)
> +    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
> +    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
> +    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
> +    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
> +#endif
>   
>       [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
>       [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 62c51c8033..52264cf047 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -248,6 +248,25 @@ static const VMStateDescription vmstate_sdtrig = {
>           VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
>           VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
>           VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sdext = {
> +    .name = "cpu/sdext",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = sdtrig_needed,
> +    .post_load = sdtrig_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
> +        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
> +        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_ctr,
>           &vmstate_sstc,
>           &vmstate_sdtrig,
> +        &vmstate_sdext,
>           NULL
>       }
>   };


