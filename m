Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABEBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWImz-0005MP-AW; Tue, 23 Jul 2024 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sWImx-0005J1-In
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:54:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sWImu-0004IY-TO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:54:59 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso644947a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721753695; x=1722358495;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1hb9BOcBTqfHVfcj46hxxqLO6V6CosuvZFQr83C4NBc=;
 b=gl79ooI3FhzcEyTfcpJtj905g0DPS+utlMdJOFK8zbZE+PyPDaWalzLalS1rJ/4GhZ
 YXY72VKaUyXTNOn+EH4MC5ucj20ocg4t5eJQSqpEXyIFfQIrAcXtzwHW8cL4Auz6CPFk
 lSk0jnxrverDHxJ+KEALPvH/ZZXQX8bJC2L1FRTLBrIM94b9ytdyZcFR5oQacVO7tqp1
 iPXL7c2LrUc2SldreqH4riQVCL43amdettbq8T0EQpId8Y8RvZrqgtFWAMVfsNxievrB
 HVJsVcjL6qCC/26AAkR5eJwl4xLrnm5s2ZIZTUGIlXKvUV9wvjf8NNPBG6M6OvNqcU6a
 ld5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721753695; x=1722358495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hb9BOcBTqfHVfcj46hxxqLO6V6CosuvZFQr83C4NBc=;
 b=SKUOcIt5bqhQab47hVrhxaZ+Zo7WA465Xmg49yvoCro5ov8XJSyaCRphcZI37gJXHZ
 YfyDyvT+GAagKKS/3rISB2XFx3+48qLe0hz3Hsk9Xa1lwUUTCXJc0iX6JBrlQ/gh4fIo
 bBvBCNbeiv9AyhJ3Uek0bEljhwHcJQeWQ+YiR4ZqVgxI/TCfwyK6A6lkCO12DeOOIboX
 sjuKU4aeM/yFy42E3JD8zes1CwcXPYOO5oOEft0J5cvx91uzSuy4jIldkwOlR6Jqn2l+
 Oz8BTYfGx6Kon2ojPdeBxhmI2zTrODZBQ2xRvYq/rX3zs5q8GN38Zz6+EUPw7JzJqpYA
 WcPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUke3USDYllvrDB1tn1NeewUn7muMhm/3oiar4bcXn47Emen41bGiVwUHzp4o953cT59qBFjHxGD2EBg/jbmfKrix8yzjk=
X-Gm-Message-State: AOJu0YxRtin9FYeMD0B5PAdHECNrpw6MdjRaN/ttzme3LG7SbPwtr2oX
 50TKJJRbklcpIk04j7s/0agKaQLTS1cCnOhLerozspAALZ4l4FS79SaB20XiWiUqZL6RIkyEF30
 ogMilraXVx6iz0JBtwTZFbNop0UiRd/b07pD4bQ==
X-Google-Smtp-Source: AGHT+IGgyhuUB1npcdyxZ7rpLmtC9yT8bf7WWyB3Z22ZFYn1j2vsNYU88pM9gNbfbCux//TiNQfinL/MRVsysNsKaXQ=
X-Received: by 2002:a05:6a20:3942:b0:1c0:f288:4903 with SMTP id
 adf61e73a8af0-1c44f84ddbdmr5067352637.17.1721753695083; Tue, 23 Jul 2024
 09:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
 <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
 <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
 <f2f6c27e-7625-471f-b888-0f3a870bb0c4@linaro.org>
 <0b7514dc-f9ed-4c48-be37-5a5de7b26229@linaro.org>
 <2bfad60f-6484-4716-95be-7b847bcdb6e6@linaro.org>
In-Reply-To: <2bfad60f-6484-4716-95be-7b847bcdb6e6@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 23 Jul 2024 10:54:44 -0600
Message-ID: <CANCZdfovJD5rMyUeW1PbYZ6y=SKLtKiaUeA8UAX3oJ0EcqVSww@mail.gmail.com>
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000063029e061ded05fd"
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--00000000000063029e061ded05fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:38=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 23/7/24 03:17, Richard Henderson wrote:
> > On 7/23/24 08:11, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 23/7/24 00:06, Warner Losh wrote:
> >>>
> >>>
> >>> On Mon, Jul 22, 2024 at 3:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> >>> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >>>
> >>>     Hi Warner,
> >>>
> >>>     On 22/7/24 23:43, Warner Losh wrote:
> >>>      > Add the aarch64 bsd-user fragments needed to build the new
> >>>     aarch64 code.
> >>>      >
> >>>      > Signed-off-by: Warner Losh <imp@bsdimp.com
> >>> <mailto:imp@bsdimp.com>>
> >>>      > ---
> >>>      >   configs/targets/aarch64-bsd-user.mak | 3 +++
> >>>      >   1 file changed, 3 insertions(+)
> >>>      >   create mode 100644 configs/targets/aarch64-bsd-user.mak
> >>>
> >>>     Can we build aarch64 on Cirrus-CI? (not clear on
> >>>     https://cirrus-ci.org/guide/FreeBSD/
> >>>     <https://cirrus-ci.org/guide/FreeBSD/>). If so, could you add
> >>>     a follow-up patch to build that on our CI, patching
> >>>     .gitlab-ci.d/cirrus.yml?
> >>>
> >>>
> >>> We can build aarch64 host for bsd-user for sure. I'll see if we can
> >>> do it in cirrus CI.
> >>> If so, I'll try to add it to cirrus.yml.
> >>>
> >>> This patch series adds aarch64 guest...
> >>
> >> Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD
> >> aarch64 bsd-user guest and test it. Am I wrong?
> >>
> >
> > This is adding guest support, so your suggestion is orthogonal.
>
> Ah, got it I guess, this series adds support for aarch64 user-mode
> emulation on any FreeBSD kernels, so IIUC we can test it on the current
> FreeBSD x86 job we have. Currently the x64-freebsd-13-build job uses:
>
>    CONFIGURE_ARGS:
>
> --target-list-exclude=3Darm-softmmu,i386-softmmu,microblaze-softmmu,mips6=
4el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-so=
ftmmu
>    TEST_TARGETS: check
>
> So the aarch64-bsd-user target should be selected automatically,
> is that correct?
>

Yes. It's automatically added to the build just by this file existing.

So it should at least be compile tested by everything.

Warner


> (got it, my request to test aarch64 FreeBSD *host* is orthogonal).
>

--00000000000063029e061ded05fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 23, 2024 at 12:38=E2=80=
=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 23/7/24 03:17, Richard Henderson wrote:<br>
&gt; On 7/23/24 08:11, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt; On 23/7/24 00:06, Warner Losh wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Mon, Jul 22, 2024 at 3:54=E2=80=AFPM Philippe Mathieu-Daud=
=C3=A9 <br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">phi=
lmd@linaro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=
=3D"_blank">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 Hi Warner,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 On 22/7/24 23:43, Warner Losh wrote:<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Add the aarch64 bsd-user fragmen=
ts needed to build the new<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 aarch64 code.<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Signed-off-by: Warner Losh &lt;<=
a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a> <br>
&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank"=
>imp@bsdimp.com</a>&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ---<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0configs/targets/aarc=
h64-bsd-user.mak | 3 +++<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A01 file changed, 3 in=
sertions(+)<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 c=
onfigs/targets/aarch64-bsd-user.mak<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 Can we build aarch64 on Cirrus-CI? (not cle=
ar on<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 <a href=3D"https://cirrus-ci.org/guide/Free=
BSD/" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.org/guide/Free=
BSD/</a><br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cirrus-ci.org/guide/=
FreeBSD/" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.org/guide/=
FreeBSD/</a>&gt;). If so, could you add<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 a follow-up patch to build that on our CI, =
patching<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 .gitlab-ci.d/cirrus.yml?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We can build aarch64 host for bsd-user for sure. I&#39;ll see =
if we can <br>
&gt;&gt;&gt; do it in cirrus CI.<br>
&gt;&gt;&gt; If so, I&#39;ll try to add it to cirrus.yml.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch series adds aarch64 guest...<br>
&gt;&gt;<br>
&gt;&gt; Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD<b=
r>
&gt;&gt; aarch64 bsd-user guest and test it. Am I wrong?<br>
&gt;&gt;<br>
&gt; <br>
&gt; This is adding guest support, so your suggestion is orthogonal.<br>
<br>
Ah, got it I guess, this series adds support for aarch64 user-mode<br>
emulation on any FreeBSD kernels, so IIUC we can test it on the current<br>
FreeBSD x86 job we have. Currently the x64-freebsd-13-build job uses:<br>
<br>
=C2=A0 =C2=A0CONFIGURE_ARGS: <br>
--target-list-exclude=3Darm-softmmu,i386-softmmu,microblaze-softmmu,mips64e=
l-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-soft=
mmu<br>
=C2=A0 =C2=A0TEST_TARGETS: check<br>
<br>
So the aarch64-bsd-user target should be selected automatically,<br>
is that correct?<br></blockquote><div><br></div><div>Yes. It&#39;s automati=
cally added to the build just by this file existing.</div><div><br></div><d=
iv>So it should at least be compile tested by everything.</div><div><br></d=
iv><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
(got it, my request to test aarch64 FreeBSD *host* is orthogonal).<br>
</blockquote></div></div>

--00000000000063029e061ded05fd--

