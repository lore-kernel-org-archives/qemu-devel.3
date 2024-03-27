Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12EAC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpXBF-00057X-EY; Wed, 27 Mar 2024 13:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpXBD-00056z-UR
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:35:15 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpXBC-0002uf-5F
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:35:15 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso5360860a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711560912; x=1712165712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cBqL+eioe9ESqpibFRBuITeKQM3HalmroX+IQ+4BKgw=;
 b=CwTupFkb6yJFxAVXvfUFb9DdwQsGUjY3Bzk9pRcfUeetd642sdFQxxZTvB2WE5IeCQ
 yJhNP4fTHcXX3qaPIAtlX49mrHcik0DN9dmXRaQT+mrm0cyKLuQLGYWXqN7dvioM9eMl
 tsjjGChJ1/rwozpuWCP6H96L0xbgtnsnt24gt/NbpntLIV5fI2QwXSPsxIJ3SYeeKN5i
 m1vYpHVCgiFVynLYBdfjIJONV2wg2awWYefS1PAKJW9zK8Ds7yPyQzezJ6dURIQSX8lv
 78zGVE5kPqLvluxKfvMYIeGuCocOSzYLxujgeO+6U5cF0b6bnHfIdIyB+RDW1w1JFAb9
 yGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711560912; x=1712165712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cBqL+eioe9ESqpibFRBuITeKQM3HalmroX+IQ+4BKgw=;
 b=wywrzOo1SUnjJWXzpp99lZaHRpCRPHmLIXqfzr6qhsrC/t/K+wI3hlI7fXnRNawBgR
 cp8mzHL3YoifqvPe8hDU9KMglXZg7tCMzrfbeSfV/I/OuMoFyFnPLtDSbqKf986wdHPC
 /0lPL8vyeYNhF1pkLzFwukMU/d07YBmh6NKl6HrJ27JRF3towqGOihpSzy5n2L8yKqEK
 eEb7abQkdpqZ6CSmsLVYYHeaOBQ8cnYk8HTjSKfv2kB0hwiYkYEcjqmmea3SBPm1HTVY
 CEluwvk8kEXo/E2JiaocNa7+dYNuPt4RWRIZLHwKkFfbbDFgObS1c/Ng6oCyNkaRajGC
 Ciiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ+P0PL2NeW5pW5p6YK9k2CgsApL8kHyyGdI+YjsfzAajGpU9TYWSkXJDvUmzDqKlkv3QP+oL05TRdqAriKv9sFNpDkN0=
X-Gm-Message-State: AOJu0YwYsPFfK1MMOSWyDtCiMJILgElNPdGMfyNsqJTlK0my6QtVG03Q
 paNGDA3zO9Qw+sG3z5C+UNoD6VLYGbGY8KE6+zUZaU/QsdDXY/tblnq1cgeF++A=
X-Google-Smtp-Source: AGHT+IE65HoY/aSz7QIlrfWbEJgwIZlDomKZ4RTgWZjobi1M2t9vMFjcIp0A0debsn1ugxF4kzvLEQ==
X-Received: by 2002:a05:6a21:9b0:b0:1a3:e2c6:6ea6 with SMTP id
 li48-20020a056a2109b000b001a3e2c66ea6mr364676pzb.23.1711560912554; 
 Wed, 27 Mar 2024 10:35:12 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a170902f74700b001dd2bacf30asm9416585plw.162.2024.03.27.10.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 10:35:12 -0700 (PDT)
Message-ID: <973fab63-111a-4429-83e7-1bab7d96c254@ventanamicro.com>
Date: Wed, 27 Mar 2024 14:35:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: Add support for Zve32x extension
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
References: <20240325083346.16656-1-jason.chien@sifive.com>
 <20240325083346.16656-2-jason.chien@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240325083346.16656-2-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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



On 3/25/24 05:33, Jason Chien wrote:
> Add support for Zve32x extension and replace some checks for Zve32f with
> Zve32x, since Zve32f depends on Zve32x.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                      |  1 +
>   target/riscv/cpu_cfg.h                  |  1 +
>   target/riscv/cpu_helper.c               |  2 +-
>   target/riscv/csr.c                      |  2 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>   target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
>   6 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..851ac7372c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -153,6 +153,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>       ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>       ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> +    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
>       ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>       ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>       ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index cb750154bd..dce49050c0 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -91,6 +91,7 @@ struct RISCVCPUConfig {
>       bool ext_zhinx;
>       bool ext_zhinxmin;
>       bool ext_zve32f;
> +    bool ext_zve32x;
>       bool ext_zve64f;
>       bool ext_zve64d;
>       bool ext_zvbb;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fc090d729a..b13a50a665 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
>       *cs_base = 0;
>   
> -    if (cpu->cfg.ext_zve32f) {
> +    if (cpu->cfg.ext_zve32x) {
>           /*
>            * If env->vl equals to VLMAX, we can use generic vector operation
>            * expanders (GVEC) to accerlate the vector operations.
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..d96feea5d3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
>   
>   static RISCVException vs(CPURISCVState *env, int csrno)
>   {
> -    if (riscv_cpu_cfg(env)->ext_zve32f) {
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
>   #if !defined(CONFIG_USER_ONLY)
>           if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
>               return RISCV_EXCP_ILLEGAL_INST;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 7d84e7d812..eec2939e23 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
>   {
>       TCGv s1, dst;
>   
> -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>           return false;
>       }
>   
> @@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>   {
>       TCGv dst;
>   
> -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>           return false;
>       }
>   
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b5b95e052d..ff0d485e7f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -511,9 +511,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
> -        error_setg(errp, "Zve32f/Zve64f extensions require F extension");
> -        return;
> +    /* The Zve32f extension depends on the Zve32x extension */
> +    if (cpu->cfg.ext_zve32f) {
> +        if (!riscv_has_ext(env, RVF)) {
> +            error_setg(errp, "Zve32f/Zve64f extensions require F extension");
> +            return;
> +        }
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
>       }
>   
>       if (cpu->cfg.ext_zvfh) {
> @@ -658,13 +662,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>       }
>   
> -    /*
> -     * In principle Zve*x would also suffice here, were they supported
> -     * in qemu
> -     */
>       if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
>            cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed ||
> -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
> +         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
>           error_setg(errp,
>                      "Vector crypto extensions require V or Zve* extensions");
>           return;

