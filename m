Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DA4D3748A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 13:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1QhD-0001Gi-NU; Thu, 17 Oct 2024 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t1QhB-0001GK-Gy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:37:41 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t1Qh8-0005rw-7y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:37:40 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c935ca63ceso112102a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729172253; x=1729777053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hleX9Z6kUNSmicJHS6U24zttm7CPXbnRsCx2CvaCguE=;
 b=JZrLmnG4oACU2nt8e/5wJRiZJIaqvlMlBbulVnAmQz4ror9iyOaottwXSy+upOXfO/
 goGdaDOXZfELdQntlkT7OamEuvcUcHIjLMuRNpYYWWPwJIpZ0IZ0U1K4xpGNqIJ8hFd0
 nKKmAz3t1MKkoVqCmusPY9I2Y97K9vpsfVcgv6Ox0vDvkYwmYBdDQ4sR9XE+Vz65nySD
 LQbi6eTB07fi2itI57NGhDZ3NJ150tBx2Xghn3j8Vw/pVqBbijPSjRm06Z/n5zmB+80C
 TXPqL00/fAV2ER1dMQXR4bpEwrQRdg16du1WgEdDZr2aSbKwrpH9GKrvGpcPHbeP4L7R
 FMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729172253; x=1729777053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hleX9Z6kUNSmicJHS6U24zttm7CPXbnRsCx2CvaCguE=;
 b=kwf/byygePnmfclnbuuplqU0feuLKign608cGNB5c0zPoXlnhtiGisy+q/lkFsaX6y
 ZNkzThgLvwX4Nd5oyP2oXmLSGXb2b7b7FhCdiVIElVmFQ/8WvT7Xk4vJC/NtsQRdRcIk
 MKR6xOkvylyl8+68rCA05ZiEATIYEkM9E2A4Zb0DGYJq9qg6hGguFKAUexATmwymUnGP
 ApJBPxlqCtmNoaZlSn24pZy6S9DT0V7uPwutSfdA43r0VMTaqsfsTOZufvbXaXV2wVAu
 hrIkdJHcoM7MWJECBeUeS8gKcGqeQcCeIIt5uyAJ0SbVKtkD9Zbbq9ssTexTVhvDaPza
 yGNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhXsGCRqAUn1lPfGskqJeI6ntWJdOzjSLeegBvAphsY0++94US/GA2bxk/OJJo10mbV9mGrZAlEjvX@nongnu.org
X-Gm-Message-State: AOJu0YxOoGhKCQ1RmTd6Q6HXa0VmdbnrJe2lZJzk8EqrMlE0D2hPaHcp
 YzQM+IjJ3kn30cwYDRXIQAppAvi6TgOUCW3kzrx1N2/y9mGoUe8RB/s1+ye9igUv5C9uOn3C9S2
 sfl53C76Ff7bGLg78vzGSVkPipHM=
X-Google-Smtp-Source: AGHT+IGc/eFsCKO1yj4XVSf8zjsq0olAGsjNboqC+lqIyeqYcsfoxXqD3vTxFwvJQA2nEYECckCHANcIZV1XDGLK3os=
X-Received: by 2002:a05:6402:1ec8:b0:5c3:eb29:83ce with SMTP id
 4fb4d7f45d1cf-5c9a5e893d1mr1075058a12.9.1729172252890; Thu, 17 Oct 2024
 06:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241016163439.1130168-1-htafreit@gmail.com>
 <CAKmqyKPUUgF1tLKCFF1FiT5HHEDDDg+=Yha2e38wSto4mKh_BA@mail.gmail.com>
 <ZxDgGsjRkLEA8r6_@redhat.com>
In-Reply-To: <ZxDgGsjRkLEA8r6_@redhat.com>
From: =?UTF-8?Q?=C3=81gatha_Freitas?= <htafreit@gmail.com>
Date: Thu, 17 Oct 2024 10:37:21 -0300
Message-ID: <CALKrZCJ6cnocjddg4uu=0q0+vtVCzkEzC0=scnRWhLpGX4zQ8w@mail.gmail.com>
Subject: Re: [PATCH 0/1] Insert LibSPDM in QEMU enabling in-tree compilation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e3a21e0624ac49a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=htafreit@gmail.com; helo=mail-ed1-x52c.google.com
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

--000000000000e3a21e0624ac49a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:00=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Oct 17, 2024 at 02:00:35PM +1000, Alistair Francis wrote:
> > On Thu, Oct 17, 2024 at 2:35=E2=80=AFAM htafr <htafreit@gmail.com> wrot=
e:
> > >
> > > (I) Summary
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >
> > > This patch is the beginning of the support of the Security Protocol a=
nd
> > > Data Model (SPDM). There are some known issues (see II), but it's
> > > usable and not many users are going to use this functionality for now=
,
> > > but for those who will it may facilitate the development.
> > >
> > > There are some people working with LibSPDM to implement the SPDM on
> > > emulated devices, however current works that use QEMU compile LibSPDM
> > > out-of-tree [1][2][3]. This patch enables the compilation of LibSPDM
> when
> > > user pass the parameter '--enable-libspdm' to configure file, this
> option
> > > is disabled by default. The following parameters were also added:
> > >
> > >   --libspdm-crypto=3DCHOICE  set LibSPDM crypto algorithm [mbedtls]
> (choices:
> > >                            mbedtls/openssl)
> > >   --libspdm-toolchain=3DVALUE
> > >                            toolchain to use for LibSPDM compilation
> [GCC]
> > >
> > > In order to facilitate future code development using LibSPDM API, thi=
s
> > > patch also provides the definition of the macro 'CONFIG_LIBSPDM'.
> >
> > We have talked about this before, see
> > https://patchew.org/QEMU/cover.1691509717.git.alistair.francis@wdc.com/
> >
> > The general agreement seemed to be that it will be hard to do SPDM
> > configuration inside QEMU, hence the external library (like the QEMU
> > TPM support).
>
> More generally, seeing this libspdm proposed for QEMU, without any
> corresponding usage of it it dubious. It is hard to judge whether
> it makes any sense, without seeing how it will be used in real
> device code inside QEMU.
>

Currently, I'm working with EDK2 and QEMU so I have a branch [1] with
ongoing
modifications in files backends/spdm.c and hw/nvme/auth.c. Although the
current
modifications are able to exchange SPDM messages, it's far from being
complete
and it's not following better code practices yet. I'm making use of
Alistair's and
Mallawa's previous work in NVMe to authenticate it through PCI [2].

[1]  WIP: SPDM integration
      Link: https://github.com/htafr/qemu/tree/libspdm-dev
[2] WIP: SPDM in OVMF
      Link: https://github.com/htafr/edk2/tree/ovmf-spdm


>
> On the cryptography side, I'm not a fan of linking another
> crypto library to QEMU, that's different from what we already
> support in our crypto layer. openssl in particular is a problem
> due to its licensing - people tend to hand-waive away the
> licensing incompatibility by pretending openssl is a "system library"
> but I disagree with that interpretation.
>
> > > (II) Known Limitations
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >
> > > 1. This patch enables LibSPDM in-tree compilation for Linux systems
> only.
> > > 2. LibSPDM compilation uses CMake, so meson build system is making us=
e
> > >    of the CMake module [4].
> > > 3. Some problems may occur when compiling LibSPDM with MbedTls such a=
s:
> > >     error: "_GNU_SOURCE" redefined [-Werror]
> > >       10 | #define _GNU_SOURCE
> > >
> > >    It's possible to compile using --disable-werror.
> > >
> > > (III) Sample configuration
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >
> > > ../configure \
> > >   --disable-werror \
> > >   --enable-libspdm \
> > >   --libspdm-crypto=3Dmbedtls \
> > >   --enable-gcov
> > >
> > > References:
> > > [1] riscv-spdm
> > >   Link: https://github.com/htafr/riscv-spdm
> > > [2] spdm-benchmark
> > >   Link: https://github.com/rcaalves/spdm-benchmark
> > > [3] qemu-spdm-emulation-guide
> > >   Link: https://github.com/twilfredo/qemu-spdm-emulation-guide
> >
> > This one has been merged upstream and mainline QEMU supports it now:
> >
> > https://www.qemu.org/docs/master/specs/spdm.html
>
> So with that merged, is this proposal for linking to libspdm redundant ?
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
I'm not sure if I understood the redundancy. Would it be against QEMU
practices
to have another openssl as well as mbedtls linked inside it?

Also, I didn't know the LibSPDM insertion was already discussed previously
as
Alistair pointed out. I think I should have sent this patch as RFC instead.
As this is
my first interaction in any mail list, I'm sorry for any mistakes I made.

--000000000000e3a21e0624ac49a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 17, 2024 at 7:00=E2=80=AF=
AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Thu, Oct 17, 202=
4 at 02:00:35PM +1000, Alistair Francis wrote:<br>
&gt; On Thu, Oct 17, 2024 at 2:35=E2=80=AFAM htafr &lt;<a href=3D"mailto:ht=
afreit@gmail.com" target=3D"_blank">htafreit@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; (I) Summary<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; This patch is the beginning of the support of the Security Protoc=
ol and<br>
&gt; &gt; Data Model (SPDM). There are some known issues (see II), but it&#=
39;s<br>
&gt; &gt; usable and not many users are going to use this functionality for=
 now,<br>
&gt; &gt; but for those who will it may facilitate the development.<br>
&gt; &gt;<br>
&gt; &gt; There are some people working with LibSPDM to implement the SPDM =
on<br>
&gt; &gt; emulated devices, however current works that use QEMU compile Lib=
SPDM<br>
&gt; &gt; out-of-tree [1][2][3]. This patch enables the compilation of LibS=
PDM when<br>
&gt; &gt; user pass the parameter &#39;--enable-libspdm&#39; to configure f=
ile, this option<br>
&gt; &gt; is disabled by default. The following parameters were also added:=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0--libspdm-crypto=3DCHOICE=C2=A0 set LibSPDM crypto al=
gorithm [mbedtls] (choices:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbedtls/openssl)<br>
&gt; &gt;=C2=A0 =C2=A0--libspdm-toolchain=3DVALUE<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 toolchain to use for LibSPDM compilation [G=
CC]<br>
&gt; &gt;<br>
&gt; &gt; In order to facilitate future code development using LibSPDM API,=
 this<br>
&gt; &gt; patch also provides the definition of the macro &#39;CONFIG_LIBSP=
DM&#39;.<br>
&gt; <br>
&gt; We have talked about this before, see<br>
&gt; <a href=3D"https://patchew.org/QEMU/cover.1691509717.git.alistair.fran=
cis@wdc.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU=
/cover.1691509717.git.alistair.francis@wdc.com/</a><br>
&gt; <br>
&gt; The general agreement seemed to be that it will be hard to do SPDM<br>
&gt; configuration inside QEMU, hence the external library (like the QEMU<b=
r>
&gt; TPM support).<br>
<br>
More generally, seeing this libspdm proposed for QEMU, without any<br>
corresponding usage of it it dubious. It is hard to judge whether<br>
it makes any sense, without seeing how it will be used in real<br>
device code inside QEMU.<br></blockquote><div><br></div><div>Currently, I&#=
39;m working with EDK2 and QEMU so I have a branch [1] with ongoing</div><d=
iv>modifications in files backends/spdm.c and hw/nvme/auth.c. Although the =
current</div><div>modifications are able to exchange SPDM messages, it&#39;=
s far from being complete</div><div>and it&#39;s not following better code =
practices yet. I&#39;m making use of Alistair&#39;s and</div><div>Mallawa&#=
39;s previous work in NVMe to authenticate it through PCI [2].=C2=A0</div><=
div><br></div><div>[1] =C2=A0WIP: SPDM integration</div><div>=C2=A0 =C2=A0 =
=C2=A0 Link:=C2=A0<a href=3D"https://github.com/htafr/qemu/tree/libspdm-dev=
">https://github.com/htafr/qemu/tree/libspdm-dev</a></div><div>[2] WIP: SPD=
M in OVMF</div><div>=C2=A0 =C2=A0 =C2=A0 Link:=C2=A0<a href=3D"https://gith=
ub.com/htafr/edk2/tree/ovmf-spdm">https://github.com/htafr/edk2/tree/ovmf-s=
pdm</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex">
<br>
On the cryptography side, I&#39;m not a fan of linking another<br>
crypto library to QEMU, that&#39;s different from what we already<br>
support in our crypto layer. openssl in particular is a problem<br>
due to its licensing - people tend to hand-waive away the<br>
licensing incompatibility by pretending openssl is a &quot;system library&q=
uot;<br>
but I disagree with that interpretation.<br>
<br>
&gt; &gt; (II) Known Limitations<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; 1. This patch enables LibSPDM in-tree compilation for Linux syste=
ms only.<br>
&gt; &gt; 2. LibSPDM compilation uses CMake, so meson build system is makin=
g use<br>
&gt; &gt;=C2=A0 =C2=A0 of the CMake module [4].<br>
&gt; &gt; 3. Some problems may occur when compiling LibSPDM with MbedTls su=
ch as:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0error: &quot;_GNU_SOURCE&quot; redefined [-Wer=
ror]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A010 | #define _GNU_SOURCE<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 It&#39;s possible to compile using --disable-werror.=
<br>
&gt; &gt;<br>
&gt; &gt; (III) Sample configuration<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
&gt; &gt;<br>
&gt; &gt; ../configure \<br>
&gt; &gt;=C2=A0 =C2=A0--disable-werror \<br>
&gt; &gt;=C2=A0 =C2=A0--enable-libspdm \<br>
&gt; &gt;=C2=A0 =C2=A0--libspdm-crypto=3Dmbedtls \<br>
&gt; &gt;=C2=A0 =C2=A0--enable-gcov<br>
&gt; &gt;<br>
&gt; &gt; References:<br>
&gt; &gt; [1] riscv-spdm<br>
&gt; &gt;=C2=A0 =C2=A0Link: <a href=3D"https://github.com/htafr/riscv-spdm"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/htafr/riscv-spdm</=
a><br>
&gt; &gt; [2] spdm-benchmark<br>
&gt; &gt;=C2=A0 =C2=A0Link: <a href=3D"https://github.com/rcaalves/spdm-ben=
chmark" rel=3D"noreferrer" target=3D"_blank">https://github.com/rcaalves/sp=
dm-benchmark</a><br>
&gt; &gt; [3] qemu-spdm-emulation-guide<br>
&gt; &gt;=C2=A0 =C2=A0Link: <a href=3D"https://github.com/twilfredo/qemu-sp=
dm-emulation-guide" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twilfredo/qemu-spdm-emulation-guide</a><br>
&gt; <br>
&gt; This one has been merged upstream and mainline QEMU supports it now:<b=
r>
&gt; <br>
&gt; <a href=3D"https://www.qemu.org/docs/master/specs/spdm.html" rel=3D"no=
referrer" target=3D"_blank">https://www.qemu.org/docs/master/specs/spdm.htm=
l</a><br>
<br>
So with that merged, is this proposal for linking to libspdm redundant ?<br=
>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br></blockquote><div><br></div><div>I&#39;m not sure if I understood the r=
edundancy. Would it be against QEMU practices</div><div>to have another ope=
nssl as well as mbedtls linked inside it?</div><div><br></div><div>Also, I =
didn&#39;t know the LibSPDM insertion was already discussed previously as</=
div><div>Alistair pointed out. I think I should have sent this patch as RFC=
 instead. As this is=C2=A0</div><div>my first interaction in any mail list,=
 I&#39;m sorry for any mistakes I made.</div></div></div>

--000000000000e3a21e0624ac49a9--

