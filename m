Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5869E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 04:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXYYk-0000tK-CW; Mon, 13 Jan 2025 23:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tXYYi-0000sg-7g; Mon, 13 Jan 2025 23:29:44 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tXYYg-0007yt-Ck; Mon, 13 Jan 2025 23:29:44 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so1668408a12.3; 
 Mon, 13 Jan 2025 20:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736828980; x=1737433780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewTxbWLLs9rdn7uQdnV5XTUg8jK+nK6sQR1Q+zvHVDY=;
 b=Fw4eOXh6U3v52LZU8PM9CtL7HU1D3gfpnap2o9lL9rFn9BGuU09s18P5arwBSk74sl
 vT+WpRDLaLmQbG2jC/prO96go6wTh+YKZaqMCeLHAtWii8bbPE0femIJBkoS/6AtjTCy
 kCnzE5HJhW8YpAkW8G8/OdQYiB6+tiU5YfaCVJoukfhf+wgf7WBQCcbFGuiGk8Menz3F
 jmduP353JF6TsD4bRHgJM9qS1y/DtbETJezmkcKFVqmQq+iT9d1ztemii/ayvQISMWGZ
 j0RxBrKV/7N0YW7cyNsgZqBOUyiOfgU2xXe+ewe/Omgel4ho4x8PXVuc9HaCJ7oTAfiq
 S7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736828980; x=1737433780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewTxbWLLs9rdn7uQdnV5XTUg8jK+nK6sQR1Q+zvHVDY=;
 b=QITeu4F3OlyBUvF+PEemxqES+2L+P/UfFrmFip5LYRqEZPcXeEM5NF83efC7z3e09Z
 paVT6Fu9LgX1/IwEA9Yh6yyK2OmNkmVtpu4dxAeHylznb+4k1QfinCtiyqXXgvCurHUn
 Kh5mPx0P6ege74k6wDYOcFjvfd+hkumAQzguK15ee5QwT+uRUbCBEFUs7lkaJqcIIgcL
 +OCOoouUiF2zdDSM+yFZLPKPUvXTa24OYrR7bRJhmRwKm2FPy+DRXDIf1YcxKkwjfA+P
 vSaMGnp4WjyH7LGK/39upvnzJJC66zoHmcTSEjhdxX/RG0CquM6+fWLWol6uzhhPaZsb
 HbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm9xEJn7QNKrfmnp0f46MdGhUVrVv/h8x75CIbF2wKWJhbjzUlVc0hUVcaOaAP4uzJixIPXPUT5JyM@nongnu.org,
 AJvYcCWvTjSoC3tz5r/u1+leTwpLVQpqeIgO13tlAvmWA+na2PlJk4ajNlzMR3xX0Mny/ugYyop4gVD0q5MS5g==@nongnu.org
X-Gm-Message-State: AOJu0Yy3ykFHXeeZrZQnRx3OAj9Yj22cRd70R07/kLeQDLQ2fOaQLFML
 /Kz20agixw8EnpazEdj1lbEpkDWoEQLs897ToFn03Yu1dwSNQH2yPI0eI0CleS1uzclV32S4ACt
 y/BiVVQGLpch4O30tZ4Q8Oewxt8w=
X-Gm-Gg: ASbGncsXEHR6EcQvkWhrYr8sWql1y/zETiyP/mrtSRgh82n429Puyo+tUBp3zB64xWV
 9hknXcenju5ufYTH/TVvI+1Ml7l45cUsg2BzhpQ==
X-Google-Smtp-Source: AGHT+IH+wx2Mc6S7X8qTDswxGZpoylhmI/V+HPU1SbkiIQfHCEGbOGUZUVK2XMG4pW9AiZB3Dm9gOpERVwCwVk/JhXA=
X-Received: by 2002:a05:6402:254b:b0:5d8:a46f:110b with SMTP id
 4fb4d7f45d1cf-5d972e17033mr23139044a12.17.1736828979995; Mon, 13 Jan 2025
 20:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20250113194410.1307494-1-baturo.alexey@gmail.com>
 <CAKmqyKMZgAh-ecvU+OXCAnNeqSUMwG9DSnKQpCSuMnL+FmBKXQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMZgAh-ecvU+OXCAnNeqSUMwG9DSnKQpCSuMnL+FmBKXQ@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Tue, 14 Jan 2025 07:29:28 +0300
X-Gm-Features: AbW1kvYMoM3WTx_0KBEbzpzAGozmG4DH-e4PzemCAQeGeiS6aF-ySL0lyi4oPPs
Message-ID: <CAFukJ-BeL_m9j1266OpuasF64zyVmh9rjjmqe2VJrNcDW18XXQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Support Supm and Sspm as part of Zjpm
 v1.0
To: Alistair Francis <alistair23@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000636933062ba302c3"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000636933062ba302c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>I removed the lines above, as we don't want to include the changelog or
rebase notes in the commit message
Sure, sorry for that

Thank you Alistair and Daniel!

=D0=B2=D1=82, 14 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 04:43, Ali=
stair Francis <alistair23@gmail.com>:

> On Tue, Jan 14, 2025 at 5:45=E2=80=AFAM <baturo.alexey@gmail.com> wrote:
> >
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Rebased against alistair/riscv-to-apply.next
> >
> > [v1]:
>
> I removed the lines above, as we don't want to include the changelog
> or rebase notes in the commit message
>
> > The Zjpm v1.0 spec states there should be Supm and Sspm extensions that
> are used in profile specification.
> > Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enable=
s
> only Smnpm.
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next
>
> Alistair
>
> > ---
> >  target/riscv/cpu.c     | 23 +++++++++++++++++++++++
> >  target/riscv/cpu_cfg.h |  2 ++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index bddf1ba75e..3d4bd157d2 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -208,10 +208,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
> >      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
> >      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> > +    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> >      ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
> >      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> >      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> >      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> > +    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
> >      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> >      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> >      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> > @@ -1625,6 +1627,8 @@ const RISCVCPUMultiExtConfig
> riscv_cpu_extensions[] =3D {
> >      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
> >      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> >      MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
> > +    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
> > +    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
> >
> >      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> >      MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
> > @@ -2781,6 +2785,24 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D=
 {
> >      },
> >  };
> >
> > +static RISCVCPUImpliedExtsRule SUPM_IMPLIED =3D {
> > +    .ext =3D CPU_CFG_OFFSET(ext_supm),
> > +    .implied_multi_exts =3D {
> > +        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> > +static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D {
> > +    .ext =3D CPU_CFG_OFFSET(ext_sspm),
> > +    .implied_multi_exts =3D {
> > +        CPU_CFG_OFFSET(ext_smnpm),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> >  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
> >      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> >      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> > @@ -2799,6 +2821,7 @@ RISCVCPUImpliedExtsRule
> *riscv_multi_ext_implied_rules[] =3D {
> >      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> >      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> >      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> > +    &SUPM_IMPLIED, &SSPM_IMPLIED,
> >      NULL
> >  };
> >
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index aef896ba00..b410b1e603 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -139,6 +139,8 @@ struct RISCVCPUConfig {
> >      bool ext_ssnpm;
> >      bool ext_smnpm;
> >      bool ext_smmpm;
> > +    bool ext_sspm;
> > +    bool ext_supm;
> >      bool rvv_ta_all_1s;
> >      bool rvv_ma_all_1s;
> >      bool rvv_vl_half_avl;
> > --
> > 2.39.5
> >
> >
>

--000000000000636933062ba302c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;I removed the lines above, as we don&#39;t want to inc=
lude the changelog or rebase notes in the commit message<div>Sure, sorry fo=
r that</div><div><br></div><div>Thank you Alistair and Daniel!</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">=D0=B2=D1=82, 14 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =
=D0=B2 04:43, Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">=
alistair23@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, Jan 14, 2025 at 5:45=E2=80=AFAM &lt;<a href=3D"mailto=
:baturo.alexey@gmail.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Rebased against alistair/riscv-to-apply.next<br>
&gt;<br>
&gt; [v1]:<br>
<br>
I removed the lines above, as we don&#39;t want to include the changelog<br=
>
or rebase notes in the commit message<br>
<br>
&gt; The Zjpm v1.0 spec states there should be Supm and Sspm extensions tha=
t are used in profile specification.<br>
&gt; Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enabl=
es only Smnpm.<br>
&gt;<br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ve=
ntanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
<br>
Thanks!<br>
<br>
Applied to riscv-to-apply.next<br>
<br>
Alistair<br>
<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0| 23 +++++++++++++++++++++=
++<br>
&gt;=C2=A0 target/riscv/cpu_cfg.h |=C2=A0 2 ++<br>
&gt;=C2=A0 2 files changed, 25 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index bddf1ba75e..3d4bd157d2 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -208,10 +208,12 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, =
ext_sscsrind),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, =
ext_ssdbltrp),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext=
_ssnpm),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0,=
 ext_ssstateen),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_=
sstc),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, h=
as_priv_1_12),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, h=
as_priv_1_12),<br>
&gt; +=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext=
_svade),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext=
_svadu),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, e=
xt_svinval),<br>
&gt; @@ -1625,6 +1627,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extension=
s[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;zvfhmin&quot;, ext_zvfhmi=
n, false),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;sstc&quot;, ext_sstc, tru=
e),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;ssnpm&quot;, ext_ssnpm, f=
alse),<br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;sspm&quot;, ext_sspm, false),<=
br>
&gt; +=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;supm&quot;, ext_supm, false),<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smaia&quot;, ext_smaia, f=
alse),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;smdbltrp&quot;, ext_smdbl=
trp, false),<br>
&gt; @@ -2781,6 +2785,24 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; +static RISCVCPUImpliedExtsRule SUPM_IMPLIED =3D {<br>
&gt; +=C2=A0 =C2=A0 .ext =3D CPU_CFG_OFFSET(ext_supm),<br>
&gt; +=C2=A0 =C2=A0 .implied_multi_exts =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET=
(ext_smnpm),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IMPLIED_EXTS_RULE_END<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D {<br>
&gt; +=C2=A0 =C2=A0 .ext =3D CPU_CFG_OFFSET(ext_sspm),<br>
&gt; +=C2=A0 =C2=A0 .implied_multi_exts =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU_CFG_OFFSET(ext_smnpm),<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IMPLIED_EXTS_RULE_END<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &amp;RVA_IMPLIED, &amp;RVD_IMPLIED, &amp;RVF_IMPLI=
ED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &amp;RVM_IMPLIED, &amp;RVV_IMPLIED, NULL<br>
&gt; @@ -2799,6 +2821,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied=
_rules[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &amp;ZVFH_IMPLIED, &amp;ZVFHMIN_IMPLIED, &amp;ZVKN=
_IMPLIED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &amp;ZVKNC_IMPLIED, &amp;ZVKNG_IMPLIED, &amp;ZVKNH=
B_IMPLIED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &amp;ZVKS_IMPLIED,=C2=A0 &amp;ZVKSC_IMPLIED, &amp;=
ZVKSG_IMPLIED, &amp;SSCFG_IMPLIED,<br>
&gt; +=C2=A0 =C2=A0 &amp;SUPM_IMPLIED, &amp;SSPM_IMPLIED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NULL<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
&gt; index aef896ba00..b410b1e603 100644<br>
&gt; --- a/target/riscv/cpu_cfg.h<br>
&gt; +++ b/target/riscv/cpu_cfg.h<br>
&gt; @@ -139,6 +139,8 @@ struct RISCVCPUConfig {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ext_ssnpm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ext_smnpm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool ext_smmpm;<br>
&gt; +=C2=A0 =C2=A0 bool ext_sspm;<br>
&gt; +=C2=A0 =C2=A0 bool ext_supm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool rvv_ta_all_1s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool rvv_ma_all_1s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool rvv_vl_half_avl;<br>
&gt; --<br>
&gt; 2.39.5<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000636933062ba302c3--

