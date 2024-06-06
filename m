Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99427C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDPI-00079E-51; Thu, 06 Jun 2024 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDPG-00078p-P2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:43:54 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDPD-0007YW-PG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:43:54 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-80a8770ff33so346704241.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681430; x=1718286230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+fHJazDoWTGv9of061dS7OWhP2xQmWlTXq22diNhG0Q=;
 b=EFabO+ZMwu/h4ECcm4YpaPzhUhFLfNG1poIAhRaU2zWpL3iw5qBS+H1lWrh2moFbZK
 AydWWo6Iy2phnx3R5CTD0J+Kvy1dRVW4mY2hNf2a6bKl+O7ltoQt4kFC4i7l+i+73lhA
 Qs2aWBw8dI2UEFSo/unSWslj6XKKo4Z2VyrhHywf/0LsFwXu/pK52x6oNugi8klSBy8e
 bGoEXoInsi3IoJvy9NrehjYt7TvAdJ+QPsIOm7DLgFwsXUbTrzuVuIS85jer9prW8foc
 WiQkdN7f4NkDvtRt0Hri9vgY749LDxkt6sLfQdghpb9iC84ctL3eP3FZ9d+fWOawHzAL
 qafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681430; x=1718286230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+fHJazDoWTGv9of061dS7OWhP2xQmWlTXq22diNhG0Q=;
 b=kan/hjrPcw2iDfwu3uskecvZomUpVKNfijuRpPvBUdp9ZuORE2xsVhjvIdlFLP+EDf
 +FtoxnfZklrEjfdAljy2fH/V7XRFhdnXH+JNl1xO8SRLTJE4XDygrLWKzJyGlUBiZbcc
 2yvQh1OULgPfwAUelQiHlKAK3YR4CHjr3aHAxIrZNi9OG3uF0E14fziMZdH81BtaDn2P
 0GnN2PZHs4r/xPWDyzfvxyXeUB5kPJ5/uoU1MwnhtjHGEPUXbWRV0xnhq0Ty0o2zfgi5
 gToD4H9DMTvkBkZ9ea+AYp+nRUiLL26YJ6UTJNoYT0Dxn09B676CoOTnupvQFVGszVlv
 Iupg==
X-Gm-Message-State: AOJu0YygF+KAQG8fdFwU6nDJoaS4RcWKTDcy9zI1Blh4e7lXW57BvTkZ
 CRhcqHT2JuwJ2NoMSxNAwxJA+ucwx5HMZZR6O/1cwwjSSQHbmeWzni+YL59Bu0ZHVvR6wgQ5nPv
 WIXo8Zjg51iPF8PyAZeO+f1xvja5un2WT53IlEg==
X-Google-Smtp-Source: AGHT+IGBy0ocGscYn4PMfGxm277ayLEmYgzYxeNuhIIizYxFYqCIV7Diw2Xc/F+htmpbXG2L/Pg6zeb1cn4jts9cUNA=
X-Received: by 2002:a1f:eeca:0:b0:4e4:eda9:ec32 with SMTP id
 71dfb90a1353d-4eb3a4aafcfmr5935348e0c.10.1717681430122; Thu, 06 Jun 2024
 06:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240604062747.9212-1-fea.wang@sifive.com>
 <20240604062747.9212-4-fea.wang@sifive.com>
 <CAKmqyKM_WQNV2=W=C5xe4wh99sbQUD7AWhYTgOOyqO=0_dW3jA@mail.gmail.com>
In-Reply-To: <CAKmqyKM_WQNV2=W=C5xe4wh99sbQUD7AWhYTgOOyqO=0_dW3jA@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Thu, 6 Jun 2024 21:43:38 +0800
Message-ID: <CAKhCfscJf+GikUfQb5XKxqk=+zfRzw1kvF4i4tXuxHEGdV0FQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] target/riscv: Support the version for ss1p13
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="0000000000007aef0d061a38df5e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=fea.wang@sifive.com; helo=mail-ua1-x933.google.com
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

--0000000000007aef0d061a38df5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, I will reorder the commits in the next patch series.
Thank you

Sincerely,
Fea

On Thu, Jun 6, 2024 at 7:58=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om>
wrote:

> On Tue, Jun 4, 2024 at 4:23=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wro=
te:
> >
> > Add RISC-V privilege 1.13 support.
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Weiwei Li <liwei1518@gmail.com>
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> This should be the last patch in the series. The idea is that we add
> support and then let users enable it.
>
> Alistair
>
> > ---
> >  target/riscv/cpu.c         | 6 +++++-
> >  target/riscv/tcg/tcg-cpu.c | 4 ++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index e9e69b9863..02c1e12a03 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char
> *priv_spec_str)
> >  {
> >      int priv_version =3D -1;
> >
> > -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> > +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> > +        priv_version =3D PRIV_VERSION_1_13_0;
> > +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> >          priv_version =3D PRIV_VERSION_1_12_0;
> >      } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
> >          priv_version =3D PRIV_VERSION_1_11_0;
> > @@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)
> >          return PRIV_VER_1_11_0_STR;
> >      case PRIV_VERSION_1_12_0:
> >          return PRIV_VER_1_12_0_STR;
> > +    case PRIV_VERSION_1_13_0:
> > +        return PRIV_VER_1_13_0_STR;
> >      default:
> >          return NULL;
> >      }
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 60fe0fd060..595d3b5b8f 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -318,6 +318,10 @@ static void
> riscv_cpu_update_named_features(RISCVCPU *cpu)
> >          cpu->cfg.has_priv_1_12 =3D true;
> >      }
> >
> > +    if (cpu->env.priv_ver >=3D PRIV_VERSION_1_13_0) {
> > +        cpu->cfg.has_priv_1_13 =3D true;
> > +    }
> > +
> >      /* zic64b is 1.12 or later */
> >      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
> >                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
> > --
> > 2.34.1
> >
> >
>

--0000000000007aef0d061a38df5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Sure, I will reorder the commits in the next patc=
h series.</div><div>Thank you</div><div><br></div><div>Sincerely,</div><div=
>Fea</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Jun 6, 2024 at 7:58=E2=80=AFAM Alistair Francis &lt;<a hr=
ef=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Jun 4, 2024 =
at 4:23=E2=80=AFPM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" targ=
et=3D"_blank">fea.wang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add RISC-V privilege 1.13 support.<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Weiwei Li &lt;<a href=3D"mailto:liwei1518@gmail.com" targ=
et=3D"_blank">liwei1518@gmail.com</a>&gt;<br>
&gt; Reviewed-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba=
.com" target=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt;<br>
<br>
This should be the last patch in the series. The idea is that we add<br>
support and then let users enable it.<br>
<br>
Alistair<br>
<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 +++++-<b=
r>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 4 ++++<br>
&gt;=C2=A0 2 files changed, 9 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index e9e69b9863..02c1e12a03 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1775,7 +1775,9 @@ static int priv_spec_from_str(const char *priv_s=
pec_str)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int priv_version =3D -1;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {<b=
r>
&gt; +=C2=A0 =C2=A0 if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 priv_version =3D PRIV_VERSION_1_13_0;<br>
&gt; +=C2=A0 =C2=A0 } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_ST=
R)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv_version =3D PRIV_VERSION_1_12_0=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11=
_0_STR)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 priv_version =3D PRIV_VERSION_1_11_0=
;<br>
&gt; @@ -1795,6 +1797,8 @@ const char *priv_spec_to_str(int priv_version)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PRIV_VER_1_11_0_STR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PRIV_VERSION_1_12_0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PRIV_VER_1_12_0_STR;<br>
&gt; +=C2=A0 =C2=A0 case PRIV_VERSION_1_13_0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return PRIV_VER_1_13_0_STR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index 60fe0fd060..595d3b5b8f 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -318,6 +318,10 @@ static void riscv_cpu_update_named_features(RISCV=
CPU *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.has_priv_1_12 =3D true;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (cpu-&gt;env.priv_ver &gt;=3D PRIV_VERSION_1_13_0) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.has_priv_1_13 =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* zic64b is 1.12 or later */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.ext_zic64b =3D cpu-&gt;cfg.cbom_blocks=
ize =3D=3D 64 &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.cbop_blocksize =3D=3D 64 &amp;&amp;=
<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--0000000000007aef0d061a38df5e--

