Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04426D3B7F1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUaL-00062K-9O; Mon, 25 Nov 2024 03:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tFUaE-00060w-QA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:36:38 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tFUaC-0003Fb-1N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:36:38 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-724f74d6457so1446559b3a.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732523793; x=1733128593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n+lDgGOWJ1iKrYQQwwYtIGQvaSmtx6BX6Lz2oVGpLs0=;
 b=dQ9PkzkaFBTjL2O7kA7vRz5BhkubyxQdyS5WuKVpuDqV9yZZQupbyf+tkpy547yNmq
 xjtUN4EATZwXvhXsPAgTMUDFaHVYD7dU2raOAc+u73pjQV1ZWQdXB8v9cfVhQDo3w47v
 iCm1r3cEEUNLwZxpeVZseW0oUINtrGpy+MX4VZqJCYbgs6Wlx4fmX7rLjABg11xwS+0K
 8lwJfqL7U+wXi5TOsw7llglZCX7MkB7DYL98i7FbXv67R5NYqPpfbklaH6Fu+bVQXvs7
 KjzHPp5EavfDmj7x7oacI9HNK4XmhfAdQdB3pMmOgAnm34h5eQE+vzGRC4Gc2w72pDQj
 9B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523793; x=1733128593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+lDgGOWJ1iKrYQQwwYtIGQvaSmtx6BX6Lz2oVGpLs0=;
 b=Pp/WMTpR8MS1oabptsRKG54CK55h2masFQGj6P80kjCkPDQX3stvvv2Nuiwz+nVyc1
 E5gHB2yLWocTXdEfX5vi68R51CM3U2KQo8DMwS1ZM4ddhMhzpVG8FMgrX1MvSz5G1Ss/
 mQYJvHQW5bQGLI+vd3DDt2WWzv8RQB+Hgyp36CnP3UNF4Yx1ENcPnB3VW33U6llHIwPX
 RsOqYdED9OadoExKugFvNYbztbFJVIsuMtoKzIKBwUqMPEuekSojR5pVCou885QQavG8
 C6aUhlF4GHdrdiuPlriHp2P6CPh9y8B8s8D4HYqo8llaujm3FQXwuh63B/EsRzqnb/N6
 sfsQ==
X-Gm-Message-State: AOJu0YwOSlrFK561VMg3viZTf7NMD5kZGCeqBay550o924EhzrieQkcR
 rK9orvLytUTg3Q0nWO4ihy/IQHX68p+E48e4Q4UmRKVtbDRFI6fjDODAW6UORv++ZtG91ozNHPs
 S4z/ivq9EW3pHfGSe+8LS1W+GcbLWFR2HLKbRBw==
X-Gm-Gg: ASbGnctlfHE6N6GjSRRk1nMbXTHOHJ/EweN1UEq2gv1GiI13oTv8YhRXfnoy5BrMwFI
 jC4VbMfZhKDNjZbjliW4vUkVQyZ5qUR4=
X-Google-Smtp-Source: AGHT+IEbTH+2stgEdh2uUNsGnFD7eRtzdODAPKemm/0x2U9z6wwh9CPTRUIIkIiZCH9AVtysxFKTNe+JaH/1AHAS9/4=
X-Received: by 2002:a05:6a21:3289:b0:1db:ef78:c60f with SMTP id
 adf61e73a8af0-1e09e57ad1amr14357941637.33.1732523793603; Mon, 25 Nov 2024
 00:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20241120074854.1767780-1-fea.wang@sifive.com>
 <20241120074854.1767780-7-fea.wang@sifive.com>
 <CAKmqyKOFp3dXjvX-Q2=a2ny3aDv33B064dFGzxgUB1cD0M5M_g@mail.gmail.com>
In-Reply-To: <CAKmqyKOFp3dXjvX-Q2=a2ny3aDv33B064dFGzxgUB1cD0M5M_g@mail.gmail.com>
From: Fea Wang <fea.wang@sifive.com>
Date: Mon, 25 Nov 2024 16:36:21 +0800
Message-ID: <CAKhCfsdYrE=AKEGCg7bu2F004e6Y+FcoM-ovCPTkxVzTHB+1Cg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/riscv: Check svukte is not enabled in RV32
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000004882eb0627b8a1a9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x429.google.com
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

--0000000000004882eb0627b8a1a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, thank you.
I will refine it in the next patches.

On Fri, Nov 22, 2024 at 1:00=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Wed, Nov 20, 2024 at 5:47=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wr=
ote:
> >
> > Based on the spec, svukte depends on SV39, so it should not be enabled
> > in RV32.
>
> The spec explicitly says it doesn't support RV32.
>
> >
> > Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> > ---
> >  target/riscv/tcg/tcg-cpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index c62c221696..4273f1f472 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU
> *cpu, Error **errp)
> >          return;
> >      }
> >
> > +    if (mcc->misa_mxl_max =3D=3D MXL_RV32 && cpu->cfg.ext_svukte) {
> > +        error_setg(errp, "svukte is not supported by to RV32");
>
> "svukte is not supported for RV32"
>
> Alistair
>
> > +        return;
> > +    }
> > +
> >      /*
> >       * Disable isa extensions based on priv spec after we
> >       * validated and set everything we need.
> > --
> > 2.34.1
> >
> >
>

--0000000000004882eb0627b8a1a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>OK, thank you.</div><div>I will refine it in the =
next patches.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Nov 22, 2024 at 1:00=E2=80=AFPM Alistair Francis=
 &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, No=
v 20, 2024 at 5:47=E2=80=AFPM Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifiv=
e.com" target=3D"_blank">fea.wang@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Based on the spec, svukte depends on SV39, so it should not be enabled=
<br>
&gt; in RV32.<br>
<br>
The spec explicitly says it doesn&#39;t support RV32.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" tar=
get=3D"_blank">fea.wang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/tcg/tcg-cpu.c | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c<b=
r>
&gt; index c62c221696..4273f1f472 100644<br>
&gt; --- a/target/riscv/tcg/tcg-cpu.c<br>
&gt; +++ b/target/riscv/tcg/tcg-cpu.c<br>
&gt; @@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *=
cpu, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (mcc-&gt;misa_mxl_max =3D=3D MXL_RV32 &amp;&amp; cpu=
-&gt;cfg.ext_svukte) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;svukte is not supp=
orted by to RV32&quot;);<br>
<br>
&quot;svukte is not supported for RV32&quot;<br>
<br>
Alistair<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Disable isa extensions based on priv spec =
after we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* validated and set everything we need.<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--0000000000004882eb0627b8a1a9--

