Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FCBC36005
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 03:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txHPi-0001UB-Vn; Tue, 25 Mar 2025 23:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1txHPd-0001Tf-Pg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 23:26:44 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1txHPb-0006Wz-VL
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 23:26:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-601c12ac8d0so3169028eaf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742959597; x=1743564397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x9igzxqMJAtjM6FYhJTJXDaNbz0GNfpXcZOZmvCUVGE=;
 b=Qg+jcUlPYs+fBPP5vdnmi8RxkWHE0RvD2WcQlDUdGZhsDos+GFJlc+GN4I0qQgD137
 38PgaHd7GwFL5+RD7qCNKw402+A9VX/94161mqSj6xuGHaT+d0VA5e2flC2atYONcGlx
 LWUg2FXsk1s30C3N1C+1+SioI2sxuq9Hrg6Jo1rpLBWD7kZ7PSPQAEqmJGhc9yn8POkO
 XtGhcgkMfSyRG2nbR3PzY0fHreicvCL5KUQD4fdFNrvg3CgsiGNWigcLbqsOt8YMAesq
 cM/HvT6TI+CLsU7A42uytaEzHdGhWb3UN478rxW6aAD6eLwUiMNSiO/ul+4m3FFB0EHs
 i8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742959597; x=1743564397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9igzxqMJAtjM6FYhJTJXDaNbz0GNfpXcZOZmvCUVGE=;
 b=qg/wqLBeNgGJGerNXvxSrDv/RdTMDx4KOJGs+qPRwcQOVssQOuJ4edqW4dsO9LcgMs
 9vOm+9LDMdb+Isiy1q61abo6enU+6ZordRe7Rg2+72KBUbk2i5JpC67hFRk0SYyfSDNy
 rPrpDMDZ8macpwQizlp6j1aQpCNMdT4YdEEjf5dxMMzV1Wa+8gOXlnS3XEY+tAEEZta1
 8W0esunVft6jSMsiU6WOJhjomlin5D5EqE1TAtl3mcI06CBbpwbBL4K23c7KpWOHoPtg
 HOyynmZMUkZlC0Gm+FDj+e9HHlRjS3sq5YVC1n0audwRRPmb61mHmGqY6YYajJMUEbrn
 3tCQ==
X-Gm-Message-State: AOJu0YzSEpQWTlNSHa1juPOibpN1j6paEghQ+gJb36K5W0aM9dH2lVMo
 zEDmiAdscyNCzcEIXoiLHYMPwolIrLVO7R0Z54LlZgNAngbA1hGtHKMs4ClZrmqF7m8NRb1kFHl
 Ko1EpFEal3suwE/g9HPgWldvpVMWDLwCV+tIwNA==
X-Gm-Gg: ASbGncu+P+OgN4YvX89XZvcObKqeOaeG8L0m+SSVIh5oLD2BXfmxKnQlGhfwVZF5euX
 dNIv2J0A7dZBneoBFhAVUiAB3tLxSbjjnxKRRPLTMhwpQpccPPPBMwJrnScRj1mbEJuafd/v9Gb
 p1opUpOFnDu2+7kfmZyhvr9mD1aBYz
X-Google-Smtp-Source: AGHT+IHQSJCXy9YClLaelpDEvv5A7PbQ5+2sHFeL4x6XGXLFVVxsfTj3/PH0sh3YItzWVrv0wQwEhr9UDOM13EWwVNQ=
X-Received: by 2002:a05:6871:5812:b0:296:5928:7a42 with SMTP id
 586e51a60fabf-2c7802e74ffmr11507336fac.22.1742959596616; Tue, 25 Mar 2025
 20:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250318070136.38898-1-jay.chang@sifive.com>
 <20250318070136.38898-2-jay.chang@sifive.com>
 <19189ed9-0459-4c7d-902a-fcacb2595f07@ventanamicro.com>
In-Reply-To: <19189ed9-0459-4c7d-902a-fcacb2595f07@ventanamicro.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 26 Mar 2025 11:26:24 +0800
X-Gm-Features: AQ5f1JptqyggyUBJoa-VxCaY70EpdnUlDe8C17elF6v7ftfChfxG4ghcA1QpZpI
Message-ID: <CACNNAjPrStVBHRFWj_+O68KqS6Mz_8brU5N2R39tsKeWZmPBKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Restrict midelegh access to S-mode harts
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000009d5a9d063136671c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=jay.chang@sifive.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009d5a9d063136671c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback!

You're right =E2=80=94 I missed initializing csr_priv.
In this case, we only want to check for privilege M-mode CSRs along with
the smaia condition.
I=E2=80=99ll fix it by adding:

"int csr_priv =3D get_field(csrno, 0x300);"

Jay

On Wed, Mar 19, 2025 at 8:59=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 3/18/25 4:01 AM, Jay Chang wrote:
> > RISC-V AIA Spec states:
> > "For a machine-level environment, extension Smaia encompasses all added
> > CSRs and all modifications to interrupt response behavior that the AIA
> > specifies for a hart, over all privilege levels. For a supervisor-level
> > environment, extension Ssaia is essentially the same as Smaia except
> > excluding the machine-level CSRs and behavior not directly visible to
> > supervisor level."
> >
> > Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
> > aia_smode32 predicate.
> >
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > ---
> >   target/riscv/csr.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 975d6e307f..c3dd8e6cda 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *env=
,
> int csrno)
> >   static RISCVException aia_smode32(CPURISCVState *env, int csrno)
> >   {
> >       int ret;
> > +    int csr_priv;
> >
> > -    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> > +    if (csr_priv =3D=3D PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
> >           return RISCV_EXCP_ILLEGAL_INST;
> >       }
>
> I believe this won't compile:
>
> ../target/riscv/csr.c: In function =E2=80=98aia_smode32=E2=80=99:
> ../target/riscv/csr.c:377:8: error: =E2=80=98csr_priv=E2=80=99 is used un=
initialized
> [-Werror=3Duninitialized]
>    377 |     if (csr_priv =3D=3D PRV_M && !riscv_cpu_cfg(env)->ext_smaia)=
 {
>        |        ^
> ../target/riscv/csr.c:375:9: note: =E2=80=98csr_priv=E2=80=99 was declare=
d here
>    375 |     int csr_priv;
>        |         ^~~~~~~~
> cc1: all warnings being treated as errors
> [2171/2988] Compiling C object
> libqemu-riscv64-softmmu.a.p/target_riscv_translate.c.o
> ninja: build stopped: subcommand failed.
>
>
> Perhaps the idea here is doing a "int csr_priv =3D env->priv;", but in th=
at
> case you
> might as well just use env->priv directly. Thanks,
>
>
> Daniel
>
> >
> > @@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
> >       [CSR_MVIP]     =3D { "mvip",     aia_any, NULL, NULL, rmw_mvip   =
 },
> >
> >       /* Machine-Level High-Half CSRs (AIA) */
> > -    [CSR_MIDELEGH] =3D { "midelegh", aia_any32, NULL, NULL, rmw_midele=
gh
> },
> > +    [CSR_MIDELEGH] =3D { "midelegh", aia_smode32, NULL, NULL,
> rmw_midelegh },
> >       [CSR_MIEH]     =3D { "mieh",     aia_any32, NULL, NULL, rmw_mieh
>  },
> >       [CSR_MVIENH]   =3D { "mvienh",   aia_any32, NULL, NULL, rmw_mvien=
h
>  },
> >       [CSR_MVIPH]    =3D { "mviph",    aia_any32, NULL, NULL, rmw_mviph
> },
>
>

--0000000000009d5a9d063136671c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-">Thanks for the feedback!</p>
<p class=3D"gmail-">You&#39;re right =E2=80=94 I missed initializing <code>=
csr_priv</code>.<br>
In this case, we only want to check for privilege M-mode CSRs along with th=
e <code>smaia</code> condition.<br>
I=E2=80=99ll fix it by adding:</p><p class=3D"gmail-">&quot;int csr_priv =
=3D get_field(csrno, 0x300);&quot;<br><br>Jay</p></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On W=
ed, Mar 19, 2025 at 8:59=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"=
mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 3/18/25 4:01 AM, Jay Chang wrote:<br>
&gt; RISC-V AIA Spec states:<br>
&gt; &quot;For a machine-level environment, extension Smaia encompasses all=
 added<br>
&gt; CSRs and all modifications to interrupt response behavior that the AIA=
<br>
&gt; specifies for a hart, over all privilege levels. For a supervisor-leve=
l<br>
&gt; environment, extension Ssaia is essentially the same as Smaia except<b=
r>
&gt; excluding the machine-level CSRs and behavior not directly visible to<=
br>
&gt; supervisor level.&quot;<br>
&gt; <br>
&gt; Since midelegh is an AIA machine-mode CSR, add Smaia extension check i=
n<br>
&gt; aia_smode32 predicate.<br>
&gt; <br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c | 7 +++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>
&gt; index 975d6e307f..c3dd8e6cda 100644<br>
&gt; --- a/target/riscv/csr.c<br>
&gt; +++ b/target/riscv/csr.c<br>
&gt; @@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *en=
v, int csrno)<br>
&gt;=C2=A0 =C2=A0static RISCVException aia_smode32(CPURISCVState *env, int =
csrno)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 int csr_priv;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (!riscv_cpu_cfg(env)-&gt;ext_ssaia) {<br>
&gt; +=C2=A0 =C2=A0 if (csr_priv =3D=3D PRV_M &amp;&amp; !riscv_cpu_cfg(env=
)-&gt;ext_smaia) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>
&gt; +=C2=A0 =C2=A0 } else if (!riscv_cpu_cfg(env)-&gt;ext_ssaia) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_ILLEGAL_INST=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
I believe this won&#39;t compile:<br>
<br>
../target/riscv/csr.c: In function =E2=80=98aia_smode32=E2=80=99:<br>
../target/riscv/csr.c:377:8: error: =E2=80=98csr_priv=E2=80=99 is used unin=
itialized [-Werror=3Duninitialized]<br>
=C2=A0 =C2=A0377 |=C2=A0 =C2=A0 =C2=A0if (csr_priv =3D=3D PRV_M &amp;&amp; =
!riscv_cpu_cfg(env)-&gt;ext_smaia) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
../target/riscv/csr.c:375:9: note: =E2=80=98csr_priv=E2=80=99 was declared =
here<br>
=C2=A0 =C2=A0375 |=C2=A0 =C2=A0 =C2=A0int csr_priv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>
cc1: all warnings being treated as errors<br>
[2171/2988] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_tra=
nslate.c.o<br>
ninja: build stopped: subcommand failed.<br>
<br>
<br>
Perhaps the idea here is doing a &quot;int csr_priv =3D env-&gt;priv;&quot;=
, but in that case you<br>
might as well just use env-&gt;priv directly. Thanks,<br>
<br>
<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIP]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mv=
ip&quot;,=C2=A0 =C2=A0 =C2=A0aia_any, NULL, NULL, rmw_mvip=C2=A0 =C2=A0 },<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Machine-Level High-Half CSRs (AIA) */<br>
&gt; -=C2=A0 =C2=A0 [CSR_MIDELEGH] =3D { &quot;midelegh&quot;, aia_any32, N=
ULL, NULL, rmw_midelegh },<br>
&gt; +=C2=A0 =C2=A0 [CSR_MIDELEGH] =3D { &quot;midelegh&quot;, aia_smode32,=
 NULL, NULL, rmw_midelegh },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MIEH]=C2=A0 =C2=A0 =C2=A0=3D { &quot;mi=
eh&quot;,=C2=A0 =C2=A0 =C2=A0aia_any32, NULL, NULL, rmw_mieh=C2=A0 =C2=A0 =
=C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIENH]=C2=A0 =C2=A0=3D { &quot;mvienh&=
quot;,=C2=A0 =C2=A0aia_any32, NULL, NULL, rmw_mvienh=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[CSR_MVIPH]=C2=A0 =C2=A0 =3D { &quot;mviph&q=
uot;,=C2=A0 =C2=A0 aia_any32, NULL, NULL, rmw_mviph=C2=A0 =C2=A0 },<br>
<br>
</blockquote></div>

--0000000000009d5a9d063136671c--

