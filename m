Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3550C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgrl-0004hl-Fu; Tue, 19 Mar 2024 17:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmgrk-0004hN-44
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:19:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rmgrh-0000Oc-0u
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:19:23 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29deb7e2f7aso3750579a91.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710883159; x=1711487959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqAlH6Fo70PFLaz/p6ZNz1h3+ZDMSNjzyqePBQl/Z/w=;
 b=DWfOfkW9yNxB3s90WYu+y61UBgjr7CeMIQFAoIn2DQy07igi2OAWl6girlagYuyTY7
 hPl1g2FIm3pyTjkFx95vP1GF9H+C/+EPXIc9Tj2YtOwCph6GZDT3P4RIDE01iRx/UrUO
 V125eVf23mqt4dyXpGEC4yXkdjkdyyw8GmDaO/t60oVo6N1sa7DAvA61EGX5wlAZ8z42
 OcgWn1WpLXtfHH2UBYSQEjyMppi6O5nWibxKd9vdPpR3yuvfktRVFNgEVvGM9gUYdaZX
 j+YucbtJTLfbsQsZr28aAP5uSNOMcX0lbTU5hRC7VW6aurBNBKfWXRc2iqe5jZeupljI
 o5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710883159; x=1711487959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqAlH6Fo70PFLaz/p6ZNz1h3+ZDMSNjzyqePBQl/Z/w=;
 b=vCWnsubHaOhHy99dtUuCHUZTsHPokwE8/G3rIKGFo4uX4iHLjkH8eIbxAp1upa1ul/
 NmazKg5p3mFsR7ArZVzmqI0HhE0o4RzMaOt+tY1d4X9WXMr5oJE2yfFTpBLzhwRgch+P
 M38yQOEqN4fQu8BD8Xonn9fob7JeyecMtPoku97BEZZEPx3KosyR4AoOca3we9q93iTy
 01D4p1/fJsvoJx7jxg9WrbP8J3SSKnMZdVBeckJfXH6NaT4OBRTuqmfCzu84oytCooBj
 71JCyvN5qD93liZwJq+b32FcKroq2L+HuvL4VVxXhi+2sjPxNSJB8SxMRD6yB836A8eN
 rHng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe5HYsN2soCueIKTHcGNSwTXXEFPqqMDF5MrtmCmZ5WcbPyHNrtx1fZlILazEKq79JAQqtYvJhU+tadjSfnXgrBs+R8Oo=
X-Gm-Message-State: AOJu0YxhZGIew8z8zwHcB4gAnk+JvH2TD0IwX9Md3Ji08molUDfoLOUX
 imFx/pFWdJhGLV8sHte8uhgCMxKF0IEmuSA6JQVtraLM6y8KEBN8FAE583hIPhWDEC4v4HvTt0D
 t
X-Google-Smtp-Source: AGHT+IE4k78QiIKnM+/uOw5LsAJMJhdOsokZ1b3J8qhY4LiZhlKg3ToLTOJxoN78rz2VgiuTggFDvg==
X-Received: by 2002:a17:90a:4741:b0:29c:7537:afbc with SMTP id
 y1-20020a17090a474100b0029c7537afbcmr4023045pjg.31.1710883158803; 
 Tue, 19 Mar 2024 14:19:18 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 gb8-20020a17090b060800b0029b2e5bc1b9sm14611pjb.23.2024.03.19.14.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:19:18 -0700 (PDT)
Message-ID: <16f08a8d-ba5b-430a-9276-2bf2f1b0d24d@ventanamicro.com>
Date: Tue, 19 Mar 2024 18:19:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Add support for Zve32x extension
Content-Language: en-US
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
 <20240306170855.24341-2-jason.chien@sifive.com>
 <CADr__8qWMHnBVnCqiEAekWj6JAkvpS6cuMmo8E8rfuRLFKCDcA@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CADr__8qWMHnBVnCqiEAekWj6JAkvpS6cuMmo8E8rfuRLFKCDcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Jason,

Care to re-send please? The patches don't apply to neither riscv-to-apply.next
nor master.


Thanks,

Daniel

On 3/19/24 13:23, Jason Chien wrote:
> Ping. Can anyone review the patches please?
> 
> Jason Chien <jason.chien@sifive.com <mailto:jason.chien@sifive.com>> 於 2024年3月7日 週四 上午1:09寫道：
> 
>     Add support for Zve32x extension and replace some checks for Zve32f with
>     Zve32x, since Zve32f depends on Zve32x.
> 
>     Signed-off-by: Jason Chien <jason.chien@sifive.com <mailto:jason.chien@sifive.com>>
>     Reviewed-by: Frank Chang <frank.chang@sifive.com <mailto:frank.chang@sifive.com>>
>     Reviewed-by: Max Chou <max.chou@sifive.com <mailto:max.chou@sifive.com>>
>     ---
>       target/riscv/cpu.c                      |  1 +
>       target/riscv/cpu_cfg.h                  |  1 +
>       target/riscv/cpu_helper.c               |  2 +-
>       target/riscv/csr.c                      |  2 +-
>       target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>       target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
>       6 files changed, 14 insertions(+), 12 deletions(-)
> 
>     diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>     index fd0c7efdda..10ccae3323 100644
>     --- a/target/riscv/cpu.c
>     +++ b/target/riscv/cpu.c
>     @@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>           ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>           ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>           ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
>     +    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
>           ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>           ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>           ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
>     diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>     index be39870691..beb3d10213 100644
>     --- a/target/riscv/cpu_cfg.h
>     +++ b/target/riscv/cpu_cfg.h
>     @@ -90,6 +90,7 @@ struct RISCVCPUConfig {
>           bool ext_zhinx;
>           bool ext_zhinxmin;
>           bool ext_zve32f;
>     +    bool ext_zve32x;
>           bool ext_zve64f;
>           bool ext_zve64d;
>           bool ext_zvbb;
>     diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>     index c994a72634..ebbe56d9a2 100644
>     --- a/target/riscv/cpu_helper.c
>     +++ b/target/riscv/cpu_helper.c
>     @@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>           *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
>           *cs_base = 0;
> 
>     -    if (cpu->cfg.ext_zve32f) {
>     +    if (cpu->cfg.ext_zve32x) {
>               /*
>                * If env->vl equals to VLMAX, we can use generic vector operation
>                * expanders (GVEC) to accerlate the vector operations.
>     diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>     index 726096444f..d96feea5d3 100644
>     --- a/target/riscv/csr.c
>     +++ b/target/riscv/csr.c
>     @@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
> 
>       static RISCVException vs(CPURISCVState *env, int csrno)
>       {
>     -    if (riscv_cpu_cfg(env)->ext_zve32f) {
>     +    if (riscv_cpu_cfg(env)->ext_zve32x) {
>       #if !defined(CONFIG_USER_ONLY)
>               if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
>                   return RISCV_EXCP_ILLEGAL_INST;
>     diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
>     index 9e101ab434..f00f1ee886 100644
>     --- a/target/riscv/insn_trans/trans_rvv.c.inc
>     +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>     @@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
>       {
>           TCGv s1, dst;
> 
>     -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
>     +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>               return false;
>           }
> 
>     @@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>       {
>           TCGv dst;
> 
>     -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
>     +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>               return false;
>           }
> 
>     diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>     index ab6db817db..ce539528e6 100644
>     --- a/target/riscv/tcg/tcg-cpu.c
>     +++ b/target/riscv/tcg/tcg-cpu.c
>     @@ -501,9 +501,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>               return;
>           }
> 
>     -    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
>     -        error_setg(errp, "Zve32f/Zve64f extensions require F extension");
>     -        return;
>     +    /* The Zve32f extension depends on the Zve32x extension */
>     +    if (cpu->cfg.ext_zve32f) {
>     +        if (!riscv_has_ext(env, RVF)) {
>     +            error_setg(errp, "Zve32f/Zve64f extensions require F extension");
>     +            return;
>     +        }
>     +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
>           }
> 
>           if (cpu->cfg.ext_zvfh) {
>     @@ -653,13 +657,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>           }
> 
>     -    /*
>     -     * In principle Zve*x would also suffice here, were they supported
>     -     * in qemu
>     -     */
>           if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
>                cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
>     -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
>     +         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
>               error_setg(errp,
>                          "Vector crypto extensions require V or Zve* extensions");
>               return;
>     -- 
>     2.43.2
> 

