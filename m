Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88615E94627
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdPm-0002Rr-55; Mon, 09 Feb 2026 21:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vpdPl-0002RY-8G
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:23:45 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vpdPj-0007RZ-0c
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:23:44 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1270adc5121so411524c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 18:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770690220; x=1771295020; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iHbTzI4W1Uf0zp0qivdqURs6QFv9HXsj3KZvQu/5TCs=;
 b=evh8EIvRm/O33fVdP+X3IE16lGkXd5mHm1EdPdzMq/Spy9+OA4OZE+yXp/NiUxpkjb
 f4JECtZn5/+sIAHjQbT6yqHJcg8rzla+kMtFkRFum3P82yy20U5ELUHLOGGppoeKfl10
 yuCk6qGEH0zCNIGTy6wlWxLshwkf37hWnUESCxGSgiF1ppx7CxcOwpvRs/y9WIprQyLf
 QEFrW5Qlzwt+us5dQhrZXFwwQbfdf8vmZpzHFDuQTgYPhw78fDIfXFeXXMlcf/SdO4w1
 q45r8FkeykkaPvcBD/xKacR4q/4ZNQiL11V2xyBehqsiktXiXdtOsPwPUweQnGnCF4jH
 iQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770690220; x=1771295020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHbTzI4W1Uf0zp0qivdqURs6QFv9HXsj3KZvQu/5TCs=;
 b=K8RrVAoLXDxIkjDu4hcZ6dZlfj/PxUv3a4Xy1F5NTsSm0eaeMqGLAUGbsbI6VlbWnF
 HEmxXw1O/9ZsMbDANRo7HmbR5W46EBCfMFNwJbsZE9cG72edEu/UjdM0AVOC5ZITk0RO
 HlkGald6nW/Ktoddtg4+978GZaHieUL8juZqpsjKidevRg0Gy0pI+aHKLmtZrW671tIB
 Yf+9qj0zvXrSJvox4gR+rpHimuy/zi8Zt0KXhUWX5y6mmwNefaHqlg1DJuXIbKAkNfDi
 ivEjmxOAu23XOc5IxWRd5EhAOXGr/ZVyjGwmPeS0mBSzV4P+QAj40kTAOXMlL1vrf7fc
 AcWA==
X-Gm-Message-State: AOJu0YxPUoECb0W+SkxIOrx6apyBqI81+OKHwIUN+559By2+6Nx5huKt
 KWXCeurUmD6jyzN2GZ0dBXyxlGeqYQ+dkZ6x75hBGn4ZCVacJzRCgtRL
X-Gm-Gg: AZuq6aKFGd92XQcGl82vMNmOldlIIiqdjStnpeCdKP8gtE5jhCKkN2qBA7PlUlVbvjv
 o7+gXdoFnwdIqAdbJ/BzwwdsAFgIcX2vl0BiUMagOwm0ESP2EKurLUkP3QfXvI2Qo24UeCzxDg2
 nZoZa7htTAU6e6QsIOo3Fa+z4nDPqSQ0RSawc4/y04/WxkZtcvOWyNQp8VXVZ74Nlu+nfV019UJ
 mr4BDjGMq3qr6R5kP/Bt/jujmU9W1mxJaySASr2ToqKn/UUfUPBMIWuJ9czMLRv8Xh8zLZK4ATv
 y/Hp1xuhTARJTa/e0ZBhN4IlYE0t6APW5mndPe5xyvFbp+LD6ifssW0TxQr2F/jXuqhiPLnNWk1
 vnnbC9uOXGodBRo4aDNXrSME/pPOsJ8iMG2UjC8L2MR45yld6usZ/BT+2Gx+TE+vJZ6wLnZKxcz
 WQw1wlaf1NZ4+2RYR2JQl12TsPWTC/hSfUYaSqYmduBRMNplh40gtH4nAJZEzLde1qgAwU/GsXL
 +yCDABcHNqJ8zMuF3kdWVw5LpA8fen2rMR/NZcBuw==
X-Received: by 2002:a05:7022:698a:b0:124:a610:62f6 with SMTP id
 a92af1059eb24-127040744a8mr4846461c88.44.1770690220227; 
 Mon, 09 Feb 2026 18:23:40 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba6cd2be9dsm4358619eec.21.2026.02.09.18.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 18:23:39 -0800 (PST)
Date: Tue, 10 Feb 2026 10:23:22 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: Re: [RFC PATCH v5 1/7] target/riscv: deprecate 'debug' CPU property
Message-ID: <aYqWG2zxbq85tvwf@ZEVORN-PC.localdomain>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
 <30b51bbe85516664482caec9748baef92c99b4b6.1770104280.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b51bbe85516664482caec9748baef92c99b4b6.1770104280.git.chao.liu.zevorn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Feb 03, 2026 at 08:56:00PM +0800, Chao Liu wrote:
> From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig'.
> 
> We're going to add more debug trigger extensions, e.g. 'sdext' [1].  And
> all of a sudden the existence of this flag is now weird. Do we keep it
> as a 'sdtrig' only or do we add 'sdext'?
> 
> The solution proposed here is to deprecate it. The flag was introduced a
> long time ago as a way to encapsulate support for all debug related
> CSRs.  Today we have specific debug trigger extensions and there's no
> more use for a generic 'debug' flag. Users should be encouraged to
> enable/disable extensions directly instead of using "made-up" flags that
> exists only in a QEMU context.
> 
> The following changes are made:
> 
> - 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
>   cpu->cfg;
> - All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
> - Two explicit getters and setters for the 'debug' property were added.
>   The property will simply get/set ext_sdtrig;
> - vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
>   will impact migration between QEMU 10.2 to newer versions, but we're
>   still in a point where the migration break cost isn't big enough to
>   justify adding migration compatibility scaffolding.
> 
> Finally, deprecated.rst was updated to deprecate 'debug' and encourage
> users to use 'ext_sdtrig' instead.
> 
> [1] https://lore.kernel.org/qemu-devel/cover.1768622881.git.chao.liu.zevorn@gmail.com/
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  docs/about/deprecated.rst         |  7 +++++
>  target/riscv/cpu.c                | 51 ++++++++++++++++++++++++++++---
>  target/riscv/cpu_cfg_fields.h.inc |  2 +-
>  target/riscv/csr.c                |  2 +-
>  target/riscv/machine.c            | 24 +++++++--------
>  target/riscv/tcg/tcg-cpu.c        |  2 +-
>  6 files changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7abb3dab59..44a6e53044 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -507,6 +507,13 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
>  only with ``-cpu max`` (which does not guarantee migration compatibility
>  across versions).
>  
> +``debug=true|false`` on RISC-V CPUs (since 11.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This option, since QEMU 10.1, has been a simple alias to the ``sdtrig``
> +extension. Users are advised to enable/disable ``sdtrig`` directly instead
> +of using ``debug``.
> +
>  Backwards compatibility
>  -----------------------
>  
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 01cb62bde4..9fa4e09f17 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -210,7 +210,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> -    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>      ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -782,7 +782,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      env->vill = true;
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
>  
> @@ -945,7 +945,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      riscv_cpu_register_gdb_regs_for_features(cs);
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->cfg.debug) {
> +    if (cpu->cfg.ext_sdtrig) {
>          riscv_trigger_realize(&cpu->env);
>      }
>  #endif
> @@ -1124,6 +1124,14 @@ static void riscv_cpu_init(Object *obj)
>      cpu->env.vext_ver = VEXT_VERSION_1_00_0;
>      cpu->cfg.max_satp_mode = -1;
>  
> +    /*
> +     * 'debug' started being deprecated in 11.0, been just a proxy
> +     * to set ext_sdtrig ever since. It has been enabled by default
> +     * for a long time though, so we're stuck with setting set 'strig'
> +     * by default too. At least for now ...
> +     */
> +    cpu->cfg.ext_sdtrig = true;
> +
>      if (mcc->def->profile) {
>          mcc->def->profile->enabled = true;
>      }
> @@ -1238,6 +1246,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
>      MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
>      MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> @@ -2649,8 +2658,42 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      NULL
>  };
>  
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static void prop_debug_get(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static void prop_debug_set(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    bool value;
> +
> +    visit_type_bool(v, name, &value, errp);
> +    cpu->cfg.ext_sdtrig = value;
> +}
> +
> +/*
> + * DEPRECATED_11.0: just a proxy for ext_sdtrig.
> + */
> +static const PropertyInfo prop_debug = {
> +    .type = "bool",
> +    .description = "DEPRECATED: use 'sdtrig' instead.",
> +    .get = prop_debug_get,
> +    .set = prop_debug_set,
> +};
> +
>  static const Property riscv_cpu_properties[] = {
> -    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    {.name = "debug", .info = &prop_debug},
>  
>      {.name = "pmu-mask", .info = &prop_pmu_mask},
>      {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 3696f02ee0..1e9162281f 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -46,6 +46,7 @@ BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
> +BOOL_FIELD(ext_sdtrig)
>  BOOL_FIELD(ext_smstateen)
>  BOOL_FIELD(ext_sstc)
>  BOOL_FIELD(ext_smcdeleg)
> @@ -157,7 +158,6 @@ BOOL_FIELD(ext_xmipslsp)
>  
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
> -BOOL_FIELD(debug)
>  BOOL_FIELD(misa_w)
>  
>  BOOL_FIELD(short_isa_string)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 05c7ec8352..870fad87ac 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -777,7 +777,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>  
>  static RISCVException debug(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_cpu_cfg(env)->debug) {
> +    if (riscv_cpu_cfg(env)->ext_sdtrig) {
>          return RISCV_EXCP_NONE;
>      }
>  
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a879..62c51c8033 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -218,14 +218,14 @@ static const VMStateDescription vmstate_kvmtimer = {
>  };
>  #endif
>  
> -static bool debug_needed(void *opaque)
> +static bool sdtrig_needed(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
>  
> -    return cpu->cfg.debug;
> +    return cpu->cfg.ext_sdtrig;
>  }
>  
> -static int debug_post_load(void *opaque, int version_id)
> +static int sdtrig_post_load(void *opaque, int version_id)
>  {
>      RISCVCPU *cpu = opaque;
>      CPURISCVState *env = &cpu->env;
> @@ -237,12 +237,12 @@ static int debug_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -static const VMStateDescription vmstate_debug = {
> -    .name = "cpu/debug",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .needed = debug_needed,
> -    .post_load = debug_post_load,
> +static const VMStateDescription vmstate_sdtrig = {
> +    .name = "cpu/sdtrig",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = sdtrig_needed,
> +    .post_load = sdtrig_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
>          VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> @@ -425,8 +425,8 @@ static const VMStateDescription vmstate_sstc = {
>  
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
> -    .version_id = 11,
> -    .minimum_version_id = 11,
> +    .version_id = 12,
> +    .minimum_version_id = 12,
>      .post_load = riscv_cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -492,13 +492,13 @@ const VMStateDescription vmstate_riscv_cpu = {
>          &vmstate_kvmtimer,
>  #endif
>          &vmstate_envcfg,
> -        &vmstate_debug,
>          &vmstate_smstateen,
>          &vmstate_jvt,
>          &vmstate_elp,
>          &vmstate_ssp,
>          &vmstate_ctr,
>          &vmstate_sstc,
> +        &vmstate_sdtrig,
>          NULL
>      }
>  };
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 378b298886..d9fbb5bf58 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -180,7 +180,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>               ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>      }
>  
> -    if (cpu->cfg.debug && !icount_enabled()) {
> +    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
>          flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>      }
>  #endif
> -- 
> 2.53.0
> 

