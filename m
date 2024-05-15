Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76574C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Ls-0005qG-Ul; Wed, 15 May 2024 03:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79LE-0005Wi-Dh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:46:26 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79L7-0005RO-Gf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:46:23 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7f18331b308so2488634241.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759175; x=1716363975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cLkW6duPIehS+/nX8X/9176wPwkDz+F+aEgseyaGx7Q=;
 b=WRSURZk2835iJkGrkwY9/Ubpgrwuc2xyzTVl7J71Hf+j4RNdOSPMhkTQrmgGZmjpBy
 uSzS1IZ3SkAj9apSw3Ij+UhQXRah+tAF2HzgsSINt09YNrg0F5SRKQ2rejfQxkVlSfNf
 VDV629zMMA/gHGXgoiL+WK8Qsds3vC9m1Ah4nHfdEZDe5wnd1qV5YFlnByTMOp62ufAT
 DIauOhaqLtypkV3xrBqLz6AQIoaySwhoL7vcz+7GDhilXceMAmEPqMgMxNs8bpHmOFYR
 SYpVQhMn5sxZoNZSgb0jl+dRvkyEy4lfpeGOEWk7R7wX1FgkNDU0NraYb2jTJqN4HGpr
 Qn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759175; x=1716363975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLkW6duPIehS+/nX8X/9176wPwkDz+F+aEgseyaGx7Q=;
 b=cJxagExDgWisPAwtSwDGI6C8aRJqQOele6kHhYC/WZg7pv9eAG7M/6P7NMqzMaLX26
 2W36Zt6q24oPV++QCnWZEqo12vqiRqQjhEN1b8eUyIUtt4n3/3RgMeal57uTyCkYgeAJ
 xET38k895dHSsQ0aNx2znfAs04ZnlwL/vyV35myknBt+Tuj9qd5gurw95MKnZG9Z0bV9
 OETlCQXO2aM2KE/wlMBvqBV4HOIELGw4vOhOwdkRg1CR2sJ6cMJTSNZ/N9a6N2bbWSZO
 fU5mdDkO7UrOpYiSHzDpmepYmpBfCBjzx8pW7Vs2ZG5FHwrf3zmCu3I9IdalV0wkZw8O
 +FMQ==
X-Gm-Message-State: AOJu0Yy8SGFc0LmENaxirUAkvOHlcXNmtWe7V++RTRfoDmmpTMD2oV9w
 lDXD2w8Qz11RcMVM2FndazuhU1c8udfeJs+NGjECPEpcLNWV7KBvGkcEbn3b5YoT7UhWXPdrxB4
 M6acCYlNCocqM1k3d23O0n/z4OKVQ9nAWo/41Mg==
X-Google-Smtp-Source: AGHT+IF5LENK7U+H62JX7W8Xof02uYBc65OWb0lQGI+HjGPGGLT5BCncqjLtxHN1hpe45T29Ur/ry2c/G74jp1k+U0I=
X-Received: by 2002:a05:6122:250b:b0:4d4:b89:bd2a with SMTP id
 71dfb90a1353d-4df88280733mr12606612e0c.3.1715759175413; Wed, 15 May 2024
 00:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-2-fea.wang@sifive.com>
 <fb91965c-6ff8-4dda-98cc-04668dbd2af4@linux.alibaba.com>
In-Reply-To: <fb91965c-6ff8-4dda-98cc-04668dbd2af4@linux.alibaba.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Wed, 15 May 2024 15:46:04 +0800
Message-ID: <CAKhCfse2OvqSuTqrJ3g8dWaPnCWk-BGWZ8TNe17vbPLs9-6AEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Reuse the conversion function of
 priv_spec and string
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000002bd0a40618795090"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=fea.wang@sifive.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000002bd0a40618795090
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, I will correct it in the patch v2.

Sincerely,
Fea

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> On 2024/5/10 14:58, Fea.Wang wrote:
> > From: Jim Shu <jim.shu@sifive.com>
> >
> > Public the conversion function of priv_spec and string in cpu.h, so tha=
t
> > tcg-cpu.c could also use it.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   target/riscv/cpu.c         |  4 ++--
> >   target/riscv/cpu.h         |  3 +++
> >   target/riscv/tcg/tcg-cpu.c | 13 +++++--------
> >   3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index a74f0eb29c..b6b48e5620 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1769,7 +1769,7 @@ static const PropertyInfo prop_pmp =3D {
> >       .set =3D prop_pmp_set,
> >   };
> >
> > -static int priv_spec_from_str(const char *priv_spec_str)
> > +int priv_spec_from_str(const char *priv_spec_str)
> >   {
> >       int priv_version =3D -1;
> >
> > @@ -1784,7 +1784,7 @@ static int priv_spec_from_str(const char
> *priv_spec_str)
> >       return priv_version;
> >   }
> >
> > -static const char *priv_spec_to_str(int priv_version)
> > +const char *priv_spec_to_str(int priv_version)
> >   {
> >       switch (priv_version) {
> >       case PRIV_VERSION_1_10_0:
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index e0dd1828b5..7696102697 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -829,4 +829,7 @@ target_ulong riscv_new_csr_seed(target_ulong
> new_value,
> >   uint8_t satp_mode_max_from_map(uint32_t map);
> >   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
> >
> > +const char *priv_spec_to_str(int priv_version);
> > +int priv_spec_from_str(const char *priv_spec_str);
> > +
> >   #endif /* RISCV_CPU_H */
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 4ebebebe09..faa8de9b83 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -76,16 +76,13 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu,
> uint32_t bit,
> >
> >   static const char *cpu_priv_ver_to_str(int priv_ver)
> >   {
> > -    switch (priv_ver) {
> > -    case PRIV_VERSION_1_10_0:
> > -        return "v1.10.0";
> > -    case PRIV_VERSION_1_11_0:
> > -        return "v1.11.0";
> > -    case PRIV_VERSION_1_12_0:
> > -        return "v1.12.0";
> > +    const char *priv_spec_str =3D priv_spec_to_str(priv_ver);
> > +
> > +    if (priv_spec_str =3D=3D NULL) {
> > +        g_assert_not_reached();
> >       }
>
> g_assert(priv_spec_str !=3D NULL) or g_assert(priv_spec_str)
>
> Otherwise,
>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> Zhiwei
>
> >
> > -    g_assert_not_reached();
> > +    return priv_spec_str;
> >   }
> >
> >   static void riscv_cpu_synchronize_from_tb(CPUState *cs,
>

--0000000000002bd0a40618795090
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you, I will correct it in the patch v2.<div><br></di=
v><div>Sincerely,</div><div>Fea</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">LIU Zhiwei &lt;<a href=3D"mailto:zhiwe=
i_liu@linux.alibaba.com">zhiwei_liu@linux.alibaba.com</a>&gt; =E6=96=BC 202=
4=E5=B9=B45=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:55=
=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
On 2024/5/10 14:58, Fea.Wang wrote:<br>
&gt; From: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=3D"_bla=
nk">jim.shu@sifive.com</a>&gt;<br>
&gt;<br>
&gt; Public the conversion function of priv_spec and string in cpu.h, so th=
at<br>
&gt; tcg-cpu.c could also use it.<br>
&gt;<br>
&gt; Signed-off-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" targe=
t=3D"_blank">jim.shu@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++--<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 3 +++<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/tcg-cpu.c | 13 +++++--------<br>
&gt;=C2=A0 =C2=A03 files changed, 10 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index a74f0eb29c..b6b48e5620 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1769,7 +1769,7 @@ static const PropertyInfo prop_pmp =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.set =3D prop_pmp_set,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static int priv_spec_from_str(const char *priv_spec_str)<br>
&gt; +int priv_spec_from_str(const char *priv_spec_str)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int priv_version =3D -1;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1784,7 +1784,7 @@ static int priv_spec_from_str(const char *priv_s=
pec_str)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return priv_version;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static const char *priv_spec_to_str(int priv_version)<br>
&gt; +const char *priv_spec_to_str(int priv_version)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (priv_version) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case PRIV_VERSION_1_10_0:<br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index e0dd1828b5..7696102697 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -829,4 +829,7 @@ target_ulong riscv_new_csr_seed(target_ulong new_v=
alue,<br>
&gt;=C2=A0 =C2=A0uint8_t satp_mode_max_from_map(uint32_t map);<br>
&gt;=C2=A0 =C2=A0const char *satp_mode_str(uint8_t satp_mode, bool is_32_bi=
t);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +const char *priv_spec_to_str(int priv_version);<br>
&gt; +int priv_spec_from_str(const char *priv_spec_str);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif /* RISCV_CPU_H */<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index 4ebebebe09..faa8de9b83 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -76,16 +76,13 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu=
, uint32_t bit,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const char *cpu_priv_ver_to_str(int priv_ver)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 switch (priv_ver) {<br>
&gt; -=C2=A0 =C2=A0 case PRIV_VERSION_1_10_0:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v1.10.0&quot;;<br>
&gt; -=C2=A0 =C2=A0 case PRIV_VERSION_1_11_0:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v1.11.0&quot;;<br>
&gt; -=C2=A0 =C2=A0 case PRIV_VERSION_1_12_0:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v1.12.0&quot;;<br>
&gt; +=C2=A0 =C2=A0 const char *priv_spec_str =3D priv_spec_to_str(priv_ver=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (priv_spec_str =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
g_assert(priv_spec_str !=3D NULL) or g_assert(priv_spec_str)<br>
<br>
Otherwise,<br>
<br>
Reviewed-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com"=
 target=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt;<br>
<br>
Zhiwei<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +=C2=A0 =C2=A0 return priv_spec_str;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void riscv_cpu_synchronize_from_tb(CPUState *cs,<br=
>
</blockquote></div>

--0000000000002bd0a40618795090--

