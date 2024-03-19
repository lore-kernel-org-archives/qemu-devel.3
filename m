Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CDAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcGA-0004GB-70; Tue, 19 Mar 2024 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rmcG0-00044u-Jp
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:24:09 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rmcFy-0005Cr-E3
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:24:08 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d46dd5f222so65126311fa.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710865443; x=1711470243; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H97QZ2h29BVhDMviywLLHMLCg3ZLWp6ny3RK33EvOZ0=;
 b=Pyo2b1FjmdWVzePkjwCOsVKzkawecq3mXm8ZtuuR2Dv5qVtPMVDiCnrqcD11CVK94P
 R0udZMo89wTOzZcHEgaXyfTpR9riDvv0kMZeRxWrFTttWLyuhPZujNgXucKQSDEshcvl
 u4U99JMbpLRwE7oqP8U8dAHwaY3/TMfXF1avqT5eH+Ye4lAG3vRCyrgxC1lxXlsROken
 nrItAi0mY31uf9SLKeBLP1mfMOqymXgYI+QWkkOuhFpUTgbcDSnNx2dP467QB3gD/Txb
 +GiheAEpb5K6bdKULtQC0wFDTTyLZF85dau9ffpx24U+cdd7xglwNCA/CK0Xkq2HW8yj
 T1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865443; x=1711470243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H97QZ2h29BVhDMviywLLHMLCg3ZLWp6ny3RK33EvOZ0=;
 b=cohKCi0jrbE3YDCtmEtt83eZ4MODOiaRglwK1hCJ7SbCv9VLfrUP3ZyIvHAo7qNl+F
 EuQR91EiTAeFkJOF5o8+DkkaV95F9qmdvKpoyWVk9E4Q9o2gIEvb63OAJ6G58848cjZK
 YKTxNFNC9POqit41S55ddsDXd4xgkmtatOxOE2aP17V/lwvfim0ZcLOmADB1eEgTDmPQ
 X9rcVKloUMDS6sA6g7FszurMQhB/rQIf1WcVwe6Jk944/rcNfZu5eJ3yS9AxVobH698k
 I1rx84z9RMFlVBFQ3dHPARt68UAaDAi1ePklUiVqfHzl6tGFNKfPngEPMQwQptMMGhc5
 tKfg==
X-Gm-Message-State: AOJu0Yy9rHFr6ijf43CtTh8Fx+2x4rUcKn6GXH/G39bN7pxvcA/zAxFK
 AxKlxuPH07L0AWZFJpYvBOoyh2jMI6oBie7GHlCvnsh9OjCrng7d0BywBF2u+G38IK4uGm/Kouy
 Va6FczbUwwhIha1LIX57TXlrQ9uz4C4Nq77+uoJFnmRYGLXysvjk=
X-Google-Smtp-Source: AGHT+IGanRU9nHcR1jelNUTw1BVINs028Ev1R6cGg60nAg8esRtaJCfzkpzQ2gfQxUFbH+GcQ7JLP7yctUe4+T5z3eM=
X-Received: by 2002:a2e:8552:0:b0:2d4:22d9:b015 with SMTP id
 u18-20020a2e8552000000b002d422d9b015mr10374325ljj.10.1710865443292; Tue, 19
 Mar 2024 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240306170855.24341-1-jason.chien@sifive.com>
 <20240306170855.24341-2-jason.chien@sifive.com>
In-Reply-To: <20240306170855.24341-2-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Wed, 20 Mar 2024 00:23:52 +0800
Message-ID: <CADr__8qWMHnBVnCqiEAekWj6JAkvpS6cuMmo8E8rfuRLFKCDcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Add support for Zve32x extension
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: multipart/alternative; boundary="00000000000001a1bf061405e776"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000001a1bf061405e776
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping. Can anyone review the patches please?

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=887=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A

> Add support for Zve32x extension and replace some checks for Zve32f with
> Zve32x, since Zve32f depends on Zve32x.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                      |  1 +
>  target/riscv/cpu_cfg.h                  |  1 +
>  target/riscv/cpu_helper.c               |  2 +-
>  target/riscv/csr.c                      |  2 +-
>  target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
>  target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
>  6 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fd0c7efdda..10ccae3323 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
>      ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
>      ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> +    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
>      ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>      ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>      ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index be39870691..beb3d10213 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -90,6 +90,7 @@ struct RISCVCPUConfig {
>      bool ext_zhinx;
>      bool ext_zhinxmin;
>      bool ext_zve32f;
> +    bool ext_zve32x;
>      bool ext_zve64f;
>      bool ext_zve64d;
>      bool ext_zvbb;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c994a72634..ebbe56d9a2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc=
,
>      *pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
>      *cs_base =3D 0;
>
> -    if (cpu->cfg.ext_zve32f) {
> +    if (cpu->cfg.ext_zve32x) {
>          /*
>           * If env->vl equals to VLMAX, we can use generic vector operati=
on
>           * expanders (GVEC) to accerlate the vector operations.
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..d96feea5d3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)
>
>  static RISCVException vs(CPURISCVState *env, int csrno)
>  {
> -    if (riscv_cpu_cfg(env)->ext_zve32f) {
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
>  #if !defined(CONFIG_USER_ONLY)
>          if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
>              return RISCV_EXCP_ILLEGAL_INST;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc
> b/target/riscv/insn_trans/trans_rvv.c.inc
> index 9e101ab434..f00f1ee886 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int
> rs1, TCGv s2)
>  {
>      TCGv s1, dst;
>
> -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>          return false;
>      }
>
> @@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv
> s1, TCGv s2)
>  {
>      TCGv dst;
>
> -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
>          return false;
>      }
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ab6db817db..ce539528e6 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -501,9 +501,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
,
> Error **errp)
>          return;
>      }
>
> -    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
> -        error_setg(errp, "Zve32f/Zve64f extensions require F extension")=
;
> -        return;
> +    /* The Zve32f extension depends on the Zve32x extension */
> +    if (cpu->cfg.ext_zve32f) {
> +        if (!riscv_has_ext(env, RVF)) {
> +            error_setg(errp, "Zve32f/Zve64f extensions require F
> extension");
> +            return;
> +        }
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x), true);
>      }
>
>      if (cpu->cfg.ext_zvfh) {
> @@ -653,13 +657,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
,
> Error **errp)
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>      }
>
> -    /*
> -     * In principle Zve*x would also suffice here, were they supported
> -     * in qemu
> -     */
>      if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb || cpu->cfg.ext_zvkg ||
>           cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha ||
> cpu->cfg.ext_zvksed ||
> -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
> +         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
>          error_setg(errp,
>                     "Vector crypto extensions require V or Zve*
> extensions");
>          return;
> --
> 2.43.2
>
>

--00000000000001a1bf061405e776
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping. Can anyone review the patches please?<br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Jason Chien=
 &lt;<a href=3D"mailto:jason.chien@sifive.com">jason.chien@sifive.com</a>&g=
t; =E6=96=BC 2024=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=
=E5=8D=881:09=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Add support for Zve32x extension and replace some =
checks for Zve32f with<br>
Zve32x, since Zve32f depends on Zve32x.<br>
<br>
Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" ta=
rget=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" targ=
et=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" target=3D"=
_blank">max.chou@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0target/riscv/insn_trans/trans_rvv.c.inc |=C2=A0 4 ++--<br>
=C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 16 ++++++++--------<br>
=C2=A06 files changed, 14 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index fd0c7efdda..10ccae3323 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb)=
,<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc)=
,<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve=
32f),<br>
+=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),=
<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve=
64f),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve=
64d),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_z=
vfbfmin),<br>
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
index be39870691..beb3d10213 100644<br>
--- a/target/riscv/cpu_cfg.h<br>
+++ b/target/riscv/cpu_cfg.h<br>
@@ -90,6 +90,7 @@ struct RISCVCPUConfig {<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zhinx;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zhinxmin;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zve32f;<br>
+=C2=A0 =C2=A0 bool ext_zve32x;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zve64f;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zve64d;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zvbb;<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index c994a72634..ebbe56d9a2 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,<=
br>
=C2=A0 =C2=A0 =C2=A0*pc =3D env-&gt;xl =3D=3D MXL_RV32 ? env-&gt;pc &amp; U=
INT32_MAX : env-&gt;pc;<br>
=C2=A0 =C2=A0 =C2=A0*cs_base =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f) {<br>
+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32x) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If env-&gt;vl equals to VLMAX, we can =
use generic vector operation<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * expanders (GVEC) to accerlate the vect=
or operations.<br>
diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
index 726096444f..d96feea5d3 100644<br>
--- a/target/riscv/csr.c<br>
+++ b/target/riscv/csr.c<br>
@@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int csrno)<b=
r>
<br>
=C2=A0static RISCVException vs(CPURISCVState *env, int csrno)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_zve32f) {<br>
+=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_zve32x) {<br>
=C2=A0#if !defined(CONFIG_USER_ONLY)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!env-&gt;debugger &amp;&amp; !riscv_c=
pu_vector_enabled(env)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_ILLEGAL_I=
NST;<br>
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_tr=
ans/trans_rvv.c.inc<br>
index 9e101ab434..f00f1ee886 100644<br>
--- a/target/riscv/insn_trans/trans_rvv.c.inc<br>
+++ b/target/riscv/insn_trans/trans_rvv.c.inc<br>
@@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1,=
 TCGv s2)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv s1, dst;<br>
<br>
-=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_ptr-&gt;ext_zve32f) {<br>
+=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_ptr-&gt;ext_zve32x) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s=
1, TCGv s2)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TCGv dst;<br>
<br>
-=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_ptr-&gt;ext_zve32f) {<br>
+=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_ptr-&gt;ext_zve32x) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<br>
index ab6db817db..ce539528e6 100644<br>
--- a/target/riscv/tcg/tcg-cpu.c<br>
+++ b/target/riscv/tcg/tcg-cpu.c<br>
@@ -501,9 +501,13 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, =
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f &amp;&amp; !riscv_has_ext(env, RV=
F)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Zve32f/Zve64f extension=
s require F extension&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 /* The Zve32f extension depends on the Zve32x extension */<b=
r>
+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!riscv_has_ext(env, RVF)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Zve32f/Zv=
e64f extensions require F extension&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ex=
t_zve32x), true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cpu-&gt;cfg.ext_zvfh) {<br>
@@ -653,13 +657,9 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, =
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFS=
ET(ext_zvbc), true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* In principle Zve*x would also suffice here, were the=
y supported<br>
-=C2=A0 =C2=A0 =C2=A0* in qemu<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0if ((cpu-&gt;cfg.ext_zvbb || cpu-&gt;cfg.ext_zvkb || cp=
u-&gt;cfg.ext_zvkg ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zvkned || cpu-&gt;cfg.ex=
t_zvknha || cpu-&gt;cfg.ext_zvksed ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.ext_zvksh) &amp;&amp; !cpu-&=
gt;cfg.ext_zve32f) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.ext_zvksh) &amp;&amp; !cpu-&=
gt;cfg.ext_zve32x) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;Vector crypto extensions require V or Zve* extensions&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div>

--00000000000001a1bf061405e776--

