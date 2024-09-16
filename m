Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A14C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 06:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq4zH-00079L-SP; Mon, 16 Sep 2024 02:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sq4zG-00078Q-Sa
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:13:26 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sq4zE-00049m-O1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:13:26 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f762de00e5so45058271fa.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726467203; x=1727072003; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rleNyH8LPXX68qo/t8Kqutyi5T9TW+dTF8BeSm12s54=;
 b=dM1hH/5yhkTb5s0Wgi3LEEYhSuKA2ts+omHDy6Q4qB/t8wbX24smRf8M2MoiVt6kQg
 mt1/M/TvjpkKnNKs1MDKkUDPyICWqcxDKHxxPIOe1LpSfPQ2HufLYI5Hb2oA41sGT07T
 P2K14EVM6A4kad+4z3xoqWIKHXXIdGI3pH3ZiWBv787ddPM/xKaO+DnoEaVN7Vee2S/0
 TMpyLldcqOnsSz2Me+vZYkcyLUYgwiIHmVh9RTTb2qxC+cJS6CMCcQTl5sgYyx/dhbYs
 hi95XAmribGU9UVYg9p+fS4E5jDWMUIuHfGN8tXe1jQ/yARb0uquoBzH87O6p3WW9FPD
 6gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726467203; x=1727072003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rleNyH8LPXX68qo/t8Kqutyi5T9TW+dTF8BeSm12s54=;
 b=k8IsKSeH6c3W0rgHirKzigZPqpKUBimajWXKejrsqzAEci7VI50j3As0ZUIRu57b/6
 NlNI6LC3P9hDcVTutqEIRYJ0bnbWQ7eEWpgf+eeCThhtJ0m66SY9NwjTiE6r10VhyML/
 fFUgRbuLM4a2GduDjF26PymiJGlwHnq1vdTvNBWLXIMFwiKVaaYWNFMad4n/KereZenA
 XS3NnfavAPU7FbfjTlK+yaeniykzWOORVeQU1o+e4UC0MDUwGjVf2Ur5ogG5G2x4ZeMv
 qiKRECy451tC0hIwW4P4jjKuQN0ZF22NH8EGrD7rEiTd43mXoOz91nC4rHpDDp17B3ts
 yhpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk8x22/3W6Tj8UmMqZKptRdMcRkaudiKxDFU3GI/BYM/VKWuul5/8nHKvliU4HaNHZh64Knesrf+BD@nongnu.org
X-Gm-Message-State: AOJu0Yy+0Z6CEG+WGky03MaxgnWhwLO+QSMvV/AUA+cAoIDbMjCRJKyv
 HUuOyv4jSTYBLzfFKn3gdU+yx6V05Gc7+QBSdLs3Swg/B6VR+ZZVLYtY6xdecVeGq/Xc+Uv1UeA
 dayjaeXHpuslH2FdoKcNnllW+R0c=
X-Google-Smtp-Source: AGHT+IGe7zT2Sl1Ne+x4r2zlPDst6FC/fvioeWdGgtWe5fTINxJAP58O1pWiEEQ+An94dVRHzbhTWbMuEkrDFzKRwRg=
X-Received: by 2002:a2e:b889:0:b0:2f6:5868:808a with SMTP id
 38308e7fff4ca-2f787ed5b1fmr74307951fa.19.1726467201565; Sun, 15 Sep 2024
 23:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <20240912052953.2552501-33-alistair.francis@wdc.com>
 <ccf73096-0fad-4bcb-bff4-e9e0ee6944dd@ventanamicro.com>
In-Reply-To: <ccf73096-0fad-4bcb-bff4-e9e0ee6944dd@ventanamicro.com>
From: Ajeet Singh <itachis6234@gmail.com>
Date: Mon, 16 Sep 2024 16:13:09 +1000
Message-ID: <CALmJt6GYwv=PT8C=muNwBCPFV=gK_pYcOhWJnBmG2jXtb5a9XA@mail.gmail.com>
Subject: Re: [PULL 32/47] bsd-user: Add RISC-V signal trampoline setup function
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Mark Corbin <mark@dibsco.co.uk>, Ajeet Singh <itachis@freebsd.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000440f2506223678e2"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=itachis6234@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000440f2506223678e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I had already fixed it and sent a patchv6,

I will send another one with the other changes.

On Mon, 16 Sept, 2024, 5:51=E2=80=AFam Daniel Henrique Barboza, <
dbarboza@ventanamicro.com> wrote:

>
>
> On 9/12/24 2:29 AM, Alistair Francis wrote:
> > From: Mark Corbin <mark@dibsco.co.uk>
> >
> > Implemented the 'setup_sigtramp' function for setting up the signal
> > trampoline code in the RISC-V architecture.
> >
> > Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-ID: <20240907031927.1908-8-itachis@FreeBSD.org>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   bsd-user/riscv/target_arch_sigtramp.h | 42 ++++++++++++++++++++++++++=
+
> >   1 file changed, 42 insertions(+)
> >   create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
> >
> > diff --git a/bsd-user/riscv/target_arch_sigtramp.h
> b/bsd-user/riscv/target_arch_sigtramp.h
> > new file mode 100644
> > index 0000000000..83345f3961
> > --- /dev/null
> > +++ b/bsd-user/riscv/target_arch_sigtramp.h
> > @@ -0,0 +1,42 @@
> > +/*
> > + * RISC-V sigcode
> > + *
> > + * Copyright (c) 2019 Mark Corbin
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef TARGET_ARCH_SIGTRAMP_H
> > +#define TARGET_ARCH_SIGTRAMP_H
> > +
> > +/* Compare with sigcode() in riscv/riscv/locore.S */
> > +static inline abi_long setup_sigtramp(abi_ulong offset, unsigned
> sigf_uc,
> > +        unsigned sys_sigreturn)
> > +{
> > +    int i;
>
> There's no 'i' var being used. This will throw an 'unused variable'
> warning when building.
>
> > +    uint32_t sys_exit =3D TARGET_FREEBSD_NR_exit;
> > +
> > +    static const uint32_t sigtramp_code[] =3D {
> > +    /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
> > +    /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi
> a0,a0,sigf_uc*/
> > +    /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li
> t0,sys_sigreturn*/
> > +    /*4*/ const_le32(0x00000073),                        /*ecall*/
> > +    /*5*/ const_le32(0x00000293 + (sys_exit << 20)),     /*li
> t0,sys_exit*/
> > +    /*6*/ const_le32(0x00000073),                        /*ecall*/
> > +    /*7*/ const_le32(0xFF1FF06F)                         /*b -16*/
> > +    };
>
>
> And this will throw the following error:
>
> ../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer elemen=
t
> is not a compile-time constant
>     32 |     /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi
> a0,a0,sigf_uc*/
>                        ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> /tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from
> macro 'const_le32'
>    168 | # define const_le32(_x) (_x)
>        |                          ^~
> 1 error generated.
>
>
> One solution is to remove the 'static const' qualifier from the array, li=
ke
> bsd-user/arm/target_arch_sigtramp.h is doing.
>
>
> This diff will fix the build:
>
>
> diff --git a/bsd-user/riscv/target_arch_sigtramp.h
> b/bsd-user/riscv/target_arch_sigtramp.h
> index 83345f3961..dfe5076739 100644
> --- a/bsd-user/riscv/target_arch_sigtramp.h
> +++ b/bsd-user/riscv/target_arch_sigtramp.h
> @@ -24,10 +24,9 @@
>   static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_u=
c,
>           unsigned sys_sigreturn)
>   {
> -    int i;
>       uint32_t sys_exit =3D TARGET_FREEBSD_NR_exit;
>
> -    static const uint32_t sigtramp_code[] =3D {
> +    uint32_t sigtramp_code[] =3D {
>       /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
>       /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi
> a0,a0,sigf_uc*/
>       /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li
> t0,sys_sigreturn*/
>
>
>
>
> Thanks,
>
> Daniel
>
>
>
> > +
> > +    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
> > +}
> > +#endif /* TARGET_ARCH_SIGTRAMP_H */
>

--000000000000440f2506223678e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">Hi, I had already fixed it and sent a patch=
v6,</p><p>I will send another one with the other changes.</p></div>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, 16 Sept, 2024, 5:51=E2=80=AFam Daniel Henrique Barboza, &lt;<a href=3D"ma=
ilto:dbarboza@ventanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<br>
<br>
On 9/12/24 2:29 AM, Alistair Francis wrote:<br>
&gt; From: Mark Corbin &lt;<a href=3D"mailto:mark@dibsco.co.uk" rel=3D"nore=
ferrer" target=3D"_blank">mark@dibsco.co.uk</a>&gt;<br>
&gt; <br>
&gt; Implemented the &#39;setup_sigtramp&#39; function for setting up the s=
ignal<br>
&gt; trampoline code in the RISC-V architecture.<br>
&gt; <br>
&gt; Signed-off-by: Mark Corbin &lt;<a href=3D"mailto:mark@dibsco.co.uk" re=
l=3D"noreferrer" target=3D"_blank">mark@dibsco.co.uk</a>&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" rel=3D"noreferrer" target=3D"_blank">richard.henderson@linaro.=
org</a>&gt;<br>
&gt; Message-ID: &lt;20240907031927.1908-8-itachis@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis=
@wdc.com" rel=3D"noreferrer" target=3D"_blank">alistair.francis@wdc.com</a>=
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/riscv/target_arch_sigtramp.h | 42 +++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 42 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/riscv/target_arch_sigtramp.h<b=
r>
&gt; <br>
&gt; diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/ta=
rget_arch_sigtramp.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..83345f3961<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/riscv/target_arch_sigtramp.h<br>
&gt; @@ -0,0 +1,42 @@<br>
&gt; +/*<br>
&gt; + * RISC-V sigcode<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Mark Corbin<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
p://www.gnu.org/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef TARGET_ARCH_SIGTRAMP_H<br>
&gt; +#define TARGET_ARCH_SIGTRAMP_H<br>
&gt; +<br>
&gt; +/* Compare with sigcode() in riscv/riscv/locore.S */<br>
&gt; +static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf=
_uc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned sys_sigreturn)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
<br>
There&#39;s no &#39;i&#39; var being used. This will throw an &#39;unused v=
ariable&#39; warning when building.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint32_t sys_exit =3D TARGET_FREEBSD_NR_exit;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 static const uint32_t sigtramp_code[] =3D {<br>
&gt; +=C2=A0 =C2=A0 /*1*/ const_le32(0x00010513),=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*mv a0, sp*/<b=
r>
&gt; +=C2=A0 =C2=A0 /*2*/ const_le32(0x00050513 + (sigf_uc &lt;&lt; 20)),=
=C2=A0 =C2=A0 =C2=A0 /*addi a0,a0,sigf_uc*/<br>
&gt; +=C2=A0 =C2=A0 /*3*/ const_le32(0x00000293 + (sys_sigreturn &lt;&lt; 2=
0)),/*li t0,sys_sigreturn*/<br>
&gt; +=C2=A0 =C2=A0 /*4*/ const_le32(0x00000073),=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*ecall*/<br>
&gt; +=C2=A0 =C2=A0 /*5*/ const_le32(0x00000293 + (sys_exit &lt;&lt; 20)),=
=C2=A0 =C2=A0 =C2=A0/*li t0,sys_exit*/<br>
&gt; +=C2=A0 =C2=A0 /*6*/ const_le32(0x00000073),=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*ecall*/<br>
&gt; +=C2=A0 =C2=A0 /*7*/ const_le32(0xFF1FF06F)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*b -16*/<br=
>
&gt; +=C2=A0 =C2=A0 };<br>
<br>
<br>
And this will throw the following error:<br>
<br>
../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer element =
is not a compile-time constant<br>
=C2=A0 =C2=A0 32 |=C2=A0 =C2=A0 =C2=A0/*2*/ const_le32(0x00050513 + (sigf_u=
c &lt;&lt; 20)),=C2=A0 =C2=A0 =C2=A0 /*addi a0,a0,sigf_uc*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0~~~~~~~~~~~^~~~~~~~~~~~~~~~~<br>
/tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from macro=
 &#39;const_le32&#39;<br>
=C2=A0 =C2=A0168 | # define const_le32(_x) (_x)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~<br>
1 error generated.<br>
<br>
<br>
One solution is to remove the &#39;static const&#39; qualifier from the arr=
ay, like<br>
bsd-user/arm/target_arch_sigtramp.h is doing.<br>
<br>
<br>
This diff will fix the build:<br>
<br>
<br>
diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_=
arch_sigtramp.h<br>
index 83345f3961..dfe5076739 100644<br>
--- a/bsd-user/riscv/target_arch_sigtramp.h<br>
+++ b/bsd-user/riscv/target_arch_sigtramp.h<br>
@@ -24,10 +24,9 @@<br>
=C2=A0 static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sig=
f_uc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned sys_sigreturn)<br>
=C2=A0 {<br>
-=C2=A0 =C2=A0 int i;<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t sys_exit =3D TARGET_FREEBSD_NR_exit;<br>
<br>
-=C2=A0 =C2=A0 static const uint32_t sigtramp_code[] =3D {<br>
+=C2=A0 =C2=A0 uint32_t sigtramp_code[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 /*1*/ const_le32(0x00010513),=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*mv a0, sp*/<b=
r>
=C2=A0 =C2=A0 =C2=A0 /*2*/ const_le32(0x00050513 + (sigf_uc &lt;&lt; 20)),=
=C2=A0 =C2=A0 =C2=A0 /*addi a0,a0,sigf_uc*/<br>
=C2=A0 =C2=A0 =C2=A0 /*3*/ const_le32(0x00000293 + (sys_sigreturn &lt;&lt; =
20)),/*li t0,sys_sigreturn*/<br>
<br>
<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return memcpy_to_target(offset, sigtramp_code, TARGET_S=
ZSIGCODE);<br>
&gt; +}<br>
&gt; +#endif /* TARGET_ARCH_SIGTRAMP_H */<br>
</blockquote></div>

--000000000000440f2506223678e2--

