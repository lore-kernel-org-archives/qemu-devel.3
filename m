Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB89CC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 07:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnCVa-0007um-54; Thu, 21 Mar 2024 03:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rnCVV-0007s7-3N
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:06:33 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1rnCVR-000889-MM
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 03:06:32 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso9069711fa.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711004787; x=1711609587; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NheNhyzqc64wFfUa3lXIHLzDQLQGqF7GmHf1+JwuTVY=;
 b=TnlAwCLXCRhD5FNPh34OssSO4P/KyWxBy1ytbrGbD2B9CUKBNC8bLDmrEzdcfC6W0M
 zHZts2Uu4eJaoBvWH7uIQwVl4rmmu2pE6wIvc6bfe85bggp7kvZ1+o5KSqdoXNajvozP
 QYEvHXaIyiHMgVFj31Q/mkMR0s3+WdmME0Lm/gs42drX10WI61G6rltEHALgfP/w80Zk
 jmbIKLm9M2ersxTlYsu1wtBwj/YEk7uQJ/9OIYjyN5aDTMBmkiXhHcmXt4nRJhSkgsy9
 MCmvJseed+Wv5sJSReRin2sMHA/K1tdihFht8zBE9QVn6dpW04cvrNHyzTBT/yGSE4Lw
 UnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711004787; x=1711609587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NheNhyzqc64wFfUa3lXIHLzDQLQGqF7GmHf1+JwuTVY=;
 b=LQL6rJUe1HF7+ITHvkxsZt90jk2IXJT92aULXpeASYD30cuz6+6ba9nevbLJK59pDL
 +rc766lAKRX+weVVrae2DfwcFPTObyELvsqnKXACYQ5cYEmKSV3rt4w3G1jcdV9PjCKE
 S/3b0DSG7rBX1AnmPpfYXG12w2L2RBR77begl82cInK9ohc65Zh0PUw7uvvjE1xUu9T7
 oxASY8KeSvI3cCN2Y6DT64D4ZkeuloY4zUY9RBub3Ovr3KPQp1ZZ0qenl1KUU2HAg6F8
 DtujK3lUOIVFPv0nxOF3qqTBDij30JbEqngPhrlNa4cKGgwaLL5UL0fJwLQRINOfryuV
 8chQ==
X-Gm-Message-State: AOJu0YwXu4WsVUgFQVytM76O0rgzd4MkRCmS0uMDc+45aAyRtphIjo/B
 GGu6GOnAO2LB24ALSDGx5aFEZNPX0mdnlt8ehbVlXzC9oHoLAXqVgahhHhtx/PanBPSiBUFTvDf
 zEhkN18duOQzG6erPcfpSuDf/dsrRv7yNDigcOg==
X-Google-Smtp-Source: AGHT+IFI2pA9cekt2uiO0uD5I1mgSxLa2dIB9kVyiCHuT8IEWaJbtvmje1mA8o9rmb8PK5u+FibLQepsyiQUlpmMMUs=
X-Received: by 2002:a05:651c:b20:b0:2d4:9201:d4ff with SMTP id
 b32-20020a05651c0b2000b002d49201d4ffmr12388185ljr.5.1711004786835; Thu, 21
 Mar 2024 00:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240306170855.24341-1-jason.chien@sifive.com>
 <20240306170855.24341-2-jason.chien@sifive.com>
 <CADr__8qWMHnBVnCqiEAekWj6JAkvpS6cuMmo8E8rfuRLFKCDcA@mail.gmail.com>
 <16f08a8d-ba5b-430a-9276-2bf2f1b0d24d@ventanamicro.com>
In-Reply-To: <16f08a8d-ba5b-430a-9276-2bf2f1b0d24d@ventanamicro.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Thu, 21 Mar 2024 15:06:14 +0800
Message-ID: <CADr__8rWGB9KZ1jn5HstvJoxtHn+1aEzLev08RAMBcbtjDYhzg@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Add support for Zve32x extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: multipart/alternative; boundary="0000000000008763fe061426584d"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x235.google.com
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

--0000000000008763fe061426584d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will re-send shortly. Thanks.

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=8820=E6=97=A5 =E9=80=B1=E4=B8=89
=E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=BC=9A

> Hi Jason,
>
> Care to re-send please? The patches don't apply to neither
> riscv-to-apply.next
> nor master.
>
>
> Thanks,
>
> Daniel
>
> On 3/19/24 13:23, Jason Chien wrote:
> > Ping. Can anyone review the patches please?
> >
> > Jason Chien <jason.chien@sifive.com <mailto:jason.chien@sifive.com>> =
=E6=96=BC
> 2024=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:=
09=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >     Add support for Zve32x extension and replace some checks for Zve32f
> with
> >     Zve32x, since Zve32f depends on Zve32x.
> >
> >     Signed-off-by: Jason Chien <jason.chien@sifive.com <mailto:
> jason.chien@sifive.com>>
> >     Reviewed-by: Frank Chang <frank.chang@sifive.com <mailto:
> frank.chang@sifive.com>>
> >     Reviewed-by: Max Chou <max.chou@sifive.com <mailto:
> max.chou@sifive.com>>
> >     ---
> >       target/riscv/cpu.c                      |  1 +
> >       target/riscv/cpu_cfg.h                  |  1 +
> >       target/riscv/cpu_helper.c               |  2 +-
> >       target/riscv/csr.c                      |  2 +-
> >       target/riscv/insn_trans/trans_rvv.c.inc |  4 ++--
> >       target/riscv/tcg/tcg-cpu.c              | 16 ++++++++--------
> >       6 files changed, 14 insertions(+), 12 deletions(-)
> >
> >     diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >     index fd0c7efdda..10ccae3323 100644
> >     --- a/target/riscv/cpu.c
> >     +++ b/target/riscv/cpu.c
> >     @@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >           ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),
> >           ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
> >           ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
> >     +    ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
> >           ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
> >           ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
> >           ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0,
> ext_zvfbfmin),
> >     diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> >     index be39870691..beb3d10213 100644
> >     --- a/target/riscv/cpu_cfg.h
> >     +++ b/target/riscv/cpu_cfg.h
> >     @@ -90,6 +90,7 @@ struct RISCVCPUConfig {
> >           bool ext_zhinx;
> >           bool ext_zhinxmin;
> >           bool ext_zve32f;
> >     +    bool ext_zve32x;
> >           bool ext_zve64f;
> >           bool ext_zve64d;
> >           bool ext_zvbb;
> >     diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >     index c994a72634..ebbe56d9a2 100644
> >     --- a/target/riscv/cpu_helper.c
> >     +++ b/target/riscv/cpu_helper.c
> >     @@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env,
> vaddr *pc,
> >           *pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env-=
>pc;
> >           *cs_base =3D 0;
> >
> >     -    if (cpu->cfg.ext_zve32f) {
> >     +    if (cpu->cfg.ext_zve32x) {
> >               /*
> >                * If env->vl equals to VLMAX, we can use generic vector
> operation
> >                * expanders (GVEC) to accerlate the vector operations.
> >     diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >     index 726096444f..d96feea5d3 100644
> >     --- a/target/riscv/csr.c
> >     +++ b/target/riscv/csr.c
> >     @@ -93,7 +93,7 @@ static RISCVException fs(CPURISCVState *env, int
> csrno)
> >
> >       static RISCVException vs(CPURISCVState *env, int csrno)
> >       {
> >     -    if (riscv_cpu_cfg(env)->ext_zve32f) {
> >     +    if (riscv_cpu_cfg(env)->ext_zve32x) {
> >       #if !defined(CONFIG_USER_ONLY)
> >               if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
> >                   return RISCV_EXCP_ILLEGAL_INST;
> >     diff --git a/target/riscv/insn_trans/trans_rvv.c.inc
> b/target/riscv/insn_trans/trans_rvv.c.inc
> >     index 9e101ab434..f00f1ee886 100644
> >     --- a/target/riscv/insn_trans/trans_rvv.c.inc
> >     +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> >     @@ -149,7 +149,7 @@ static bool do_vsetvl(DisasContext *s, int rd,
> int rs1, TCGv s2)
> >       {
> >           TCGv s1, dst;
> >
> >     -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> >     +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
> >               return false;
> >           }
> >
> >     @@ -179,7 +179,7 @@ static bool do_vsetivli(DisasContext *s, int rd=
,
> TCGv s1, TCGv s2)
> >       {
> >           TCGv dst;
> >
> >     -    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32f) {
> >     +    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
> >               return false;
> >           }
> >
> >     diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.=
c
> >     index ab6db817db..ce539528e6 100644
> >     --- a/target/riscv/tcg/tcg-cpu.c
> >     +++ b/target/riscv/tcg/tcg-cpu.c
> >     @@ -501,9 +501,13 @@ void riscv_cpu_validate_set_extensions(RISCVCP=
U
> *cpu, Error **errp)
> >               return;
> >           }
> >
> >     -    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
> >     -        error_setg(errp, "Zve32f/Zve64f extensions require F
> extension");
> >     -        return;
> >     +    /* The Zve32f extension depends on the Zve32x extension */
> >     +    if (cpu->cfg.ext_zve32f) {
> >     +        if (!riscv_has_ext(env, RVF)) {
> >     +            error_setg(errp, "Zve32f/Zve64f extensions require F
> extension");
> >     +            return;
> >     +        }
> >     +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32x),
> true);
> >           }
> >
> >           if (cpu->cfg.ext_zvfh) {
> >     @@ -653,13 +657,9 @@ void riscv_cpu_validate_set_extensions(RISCVCP=
U
> *cpu, Error **errp)
> >               cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc),
> true);
> >           }
> >
> >     -    /*
> >     -     * In principle Zve*x would also suffice here, were they
> supported
> >     -     * in qemu
> >     -     */
> >           if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkb ||
> cpu->cfg.ext_zvkg ||
> >                cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha ||
> cpu->cfg.ext_zvksed ||
> >     -         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
> >     +         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32x) {
> >               error_setg(errp,
> >                          "Vector crypto extensions require V or Zve*
> extensions");
> >               return;
> >     --
> >     2.43.2
> >
>

--0000000000008763fe061426584d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will re-send=C2=A0shortly. Thanks.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Daniel Henrique Barb=
oza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.=
com</a>&gt; =E6=96=BC 2024=E5=B9=B43=E6=9C=8820=E6=97=A5 =E9=80=B1=E4=B8=89=
 =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Jason,<br>
<br>
Care to re-send please? The patches don&#39;t apply to neither riscv-to-app=
ly.next<br>
nor master.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
On 3/19/24 13:23, Jason Chien wrote:<br>
&gt; Ping. Can anyone review the patches please?<br>
&gt; <br>
&gt; Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" target=3D"_b=
lank">jason.chien@sifive.com</a> &lt;mailto:<a href=3D"mailto:jason.chien@s=
ifive.com" target=3D"_blank">jason.chien@sifive.com</a>&gt;&gt; =E6=96=BC 2=
024=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:09=
=E5=AF=AB=E9=81=93=EF=BC=9A<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Add support for Zve32x extension and replace some c=
hecks for Zve32f with<br>
&gt;=C2=A0 =C2=A0 =C2=A0Zve32x, since Zve32f depends on Zve32x.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Jason Chien &lt;<a href=3D"mailto:ja=
son.chien@sifive.com" target=3D"_blank">jason.chien@sifive.com</a> &lt;mail=
to:<a href=3D"mailto:jason.chien@sifive.com" target=3D"_blank">jason.chien@=
sifive.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Frank Chang &lt;<a href=3D"mailto:fran=
k.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> &lt;mailto=
:<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@si=
five.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Max Chou &lt;<a href=3D"mailto:max.cho=
u@sifive.com" target=3D"_blank">max.chou@sifive.com</a> &lt;mailto:<a href=
=3D"mailto:max.chou@sifive.com" target=3D"_blank">max.chou@sifive.com</a>&g=
t;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/insn_trans/trans_rvv.c.inc |=C2=
=A0 4 ++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 ++++++++--------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A06 files changed, 14 insertions(+), 12 deleti=
ons(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/cpu.c b/target/riscv/cpu.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index fd0c7efdda..10ccae3323 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -152,6 +152,7 @@ const RISCVIsaExtData isa_edata=
_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvbb, PRIV_=
VERSION_1_12_0, ext_zvbb),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvbc, PRIV_=
VERSION_1_12_0, ext_zvbc),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve32f, PRI=
V_VERSION_1_10_0, ext_zve32f),<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERS=
ION_1_10_0, ext_zve32x),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve64f, PRI=
V_VERSION_1_10_0, ext_zve64f),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zve64d, PRI=
V_VERSION_1_10_0, ext_zve64d),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zvfbfmin, P=
RIV_VERSION_1_12_0, ext_zvfbfmin),<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/cpu_cfg.h b/target/riscv/=
cpu_cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0index be39870691..beb3d10213 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/cpu_cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/cpu_cfg.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -90,6 +90,7 @@ struct RISCVCPUConfig {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zhinx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zhinxmin;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zve32f;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bool ext_zve32x;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zve64f;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zve64d;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool ext_zvbb;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/cpu_helper.c b/target/ris=
cv/cpu_helper.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index c994a72634..ebbe56d9a2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/cpu_helper.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/cpu_helper.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -72,7 +72,7 @@ void cpu_get_tb_cpu_state(CPURISC=
VState *env, vaddr *pc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pc =3D env-&gt;xl =3D=3D MXL_=
RV32 ? env-&gt;pc &amp; UINT32_MAX : env-&gt;pc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*cs_base =3D 0;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If env-&gt;vl=
 equals to VLMAX, we can use generic vector operation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * expanders (GV=
EC) to accerlate the vector operations.<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/csr.c b/target/riscv/csr.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 726096444f..d96feea5d3 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/csr.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/csr.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -93,7 +93,7 @@ static RISCVException fs(CPURISCV=
State *env, int csrno)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0static RISCVException vs(CPURISCVState *env,=
 int csrno)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_zve32=
f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_zve32=
x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#if !defined(CONFIG_USER_ONLY)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!env-&gt;deb=
ugger &amp;&amp; !riscv_cpu_vector_enabled(env)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn RISCV_EXCP_ILLEGAL_INST;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/insn_trans/trans_rvv.c.in=
c b/target/riscv/insn_trans/trans_rvv.c.inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 9e101ab434..f00f1ee886 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/insn_trans/trans_rvv.c.inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/insn_trans/trans_rvv.c.inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -149,7 +149,7 @@ static bool do_vsetvl(DisasCont=
ext *s, int rd, int rs1, TCGv s2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv s1, dst;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_pt=
r-&gt;ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_pt=
r-&gt;ext_zve32x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -179,7 +179,7 @@ static bool do_vsetivli(DisasCo=
ntext *s, int rd, TCGv s1, TCGv s2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv dst;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_pt=
r-&gt;ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (!require_rvv(s) || !s-&gt;cfg_pt=
r-&gt;ext_zve32x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/target/riscv/tcg/tcg-cpu.c b/target/ri=
scv/tcg/tcg-cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index ab6db817db..ce539528e6 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/target/riscv/tcg/tcg-cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -501,9 +501,13 @@ void riscv_cpu_validate_set_ex=
tensions(RISCVCPU *cpu, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f &amp;&amp=
; !riscv_has_ext(env, RVF)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot=
;Zve32f/Zve64f extensions require F extension&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 /* The Zve32f extension depends on t=
he Zve32x extension */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (cpu-&gt;cfg.ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!riscv_has_ext(env=
, RVF)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_se=
tg(errp, &quot;Zve32f/Zve64f extensions require F extension&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_cfg_ext_auto_updat=
e(cpu, CPU_CFG_OFFSET(ext_zve32x), true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu-&gt;cfg.ext_zvfh) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -653,13 +657,9 @@ void riscv_cpu_validate_set_ex=
tensions(RISCVCPU *cpu, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_cfg_ext_auto=
_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0* In principle Zve*x would als=
o suffice here, were they supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0* in qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((cpu-&gt;cfg.ext_zvbb || c=
pu-&gt;cfg.ext_zvkb || cpu-&gt;cfg.ext_zvkg ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext=
_zvkned || cpu-&gt;cfg.ext_zvknha || cpu-&gt;cfg.ext_zvksed ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.ext_=
zvksh) &amp;&amp; !cpu-&gt;cfg.ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;cfg.ext_=
zvksh) &amp;&amp; !cpu-&gt;cfg.ext_zve32x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;Vector crypto extensions require V or Zve* exten=
sions&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.43.2<br>
&gt; <br>
</blockquote></div>

--0000000000008763fe061426584d--

