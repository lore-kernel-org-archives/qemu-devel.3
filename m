Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC5C9EC98
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJRw-0008MC-2k; Mon, 12 Jan 2026 10:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJRs-0008L3-90
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:03:16 -0500
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJRq-0002dG-LQ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:03:15 -0500
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-11b992954d4so6827631c88.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768230193; x=1768834993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Js9FkE6Rpg+Afxr1rVQLBvxMp5sno1UOtMm22+hAn4Y=;
 b=iMJfQTCYqCtU1TZUx1ahX4X7nsTOk44QqhQ57BZHd3y3CCnPQRPhGxc2wF7IRsGGy7
 RAzclySChQNa+T4dCFQxa8AtGezdJMB6Bdy9ccSSEBuVycEDBzet5URU1niOqC6Yh7ph
 cpKIO6KnOb6zmFHuA2nGszT+wUESpPuKRsN48Hen84M4j+b7Bg9TRTb4tloAHa5O426j
 5RiSZUj7OwwNoXYnOMBuMoi0rtK/oxjHqPwZYri3OgjcjcOQSUlL2Srb7YSVOQ7KGSA4
 jiTL/avhf0mLbu3uoNwN5gHTH24UQxNlC8q1NrdMzpHJgWg5GfZzsHGkreZ2OnKjb9iv
 cKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230193; x=1768834993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Js9FkE6Rpg+Afxr1rVQLBvxMp5sno1UOtMm22+hAn4Y=;
 b=PCwTKwIX0U51SeNZf0n00PI069xNLZosKpygmFGUMXxSdP5k0C7j/Vj31YAOXexk11
 Dx/1lB1IP9UyrQ6PlJdu//BsypOrSngUv7ItZbVRcFkCZ816wEqQN8fEgg8SfVziqlGi
 bgXsrcBeEkPyEBXdMv5TJQXSaDgsGO+B2h5eFWH7Z8WyeZfAX0lXR/VjnyDZuvVT0h+N
 Numu747Oel7NEOyqfBnBVIq8ZBqVe19nAGDkCKNEfNqsR18DXIX7OfDeW25oXRGiyAwb
 E8aX6b+a9lHm8aZVnHyuTXRbUb0bgXj6abVtLPU8IogFI1onATEXPsz4q5Qk6LrUGq/H
 fL8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGWKB6y0fgc2QxrvLyUmzw3gusK5VGPxjs7hambg/kBgfORjP390+uRouxAFOlubUOOF/1rJ7Foube@nongnu.org
X-Gm-Message-State: AOJu0YwdN/NB2kImiAhBf5cH5dYGQfOfekM7p7fLjuJxlbFtTpDjNkPj
 ptMt9/770/0nfILdr1s1zmVnt99Ejegy4TKM60KfeH3rvIRJiRC0NDwZmD80KsDHsBnPY3JJ+T5
 srtAiWWGV6iu6mSkiDk4xEPyEcRpk/BE=
X-Gm-Gg: AY/fxX6aI1IJ04gJm4qk39d1Yx8/JbAKI+0gX9nSrHd6ueLroUlWPgqvc3Db4f/QmLd
 tg4tpT1UI6/Km0j6iLAtowcYowNlbheLYOi6Di1rHHXwvo/azoBEYbZBSzdZGFXyN1xm6MYQ+Lg
 WOksjhS4UPblsx+j4rcuyfD6/ho1TR22U0HAO377jzWhZY1x8ZZKZpAPzNzHz4vvFUqqKnVyFkA
 aXxCBSjMT2pD/CdwlzL0SWGr9k3DuUkUgYx2Jdny1lqL6rbLOi6aGXPE983m4PcmAt7ntLgEzKi
 D5kLkbMQXxogjI7jC8LiInjiKw==
X-Google-Smtp-Source: AGHT+IEjXtBkkn3IWuDJbHwqAf+glrN0SNybsVjP/MQ9wdgguRZOlouYt34wIhHiwrP3y8gFqiXcoA2saLZf6enWOrI=
X-Received: by 2002:a05:7022:387:b0:119:e56c:189d with SMTP id
 a92af1059eb24-121f8afbcdfmr16762334c88.5.1768230192760; Mon, 12 Jan 2026
 07:03:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
 <bd5596d373b9b801c5ca838d316bea4c5aba4674.1767886100.git.ktokunaga.mail@gmail.com>
 <23d64b20-01ec-4237-8816-7adb1fa3141b@linaro.org>
In-Reply-To: <23d64b20-01ec-4237-8816-7adb1fa3141b@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 13 Jan 2026 00:03:00 +0900
X-Gm-Features: AZwV_Qit0ZmDeGR9aIPnClXzqndkNyQIzutklTp-knwf4k6t9L51jlHbQ0K0bVc
Message-ID: <CAEDrbUaA1MMoWUdY4NGWNYX46zfLeu0mzcBn3Xt65d_je=MNnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000854d2c0648322cd1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1229.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000854d2c0648322cd1
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> On 1/9/26 04:11, Kohei Tokunaga wrote:
> > @@ -46,6 +49,16 @@ pkgconfig = ['pkg-config', '--static']
> >   EOT
> >   EOF
> >
> > +FROM build-base-common AS build-base-wasm32
> > +
> > +FROM build-base-common AS build-base-wasm64
> > +ARG WASM64_MEMORY64
> > +ENV CFLAGS="$CFLAGS -sMEMORY64=${WASM64_MEMORY64}"
> > +ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=${WASM64_MEMORY64}"
> > +ENV LDFLAGS="$LDFLAGS -sMEMORY64=${WASM64_MEMORY64}"
>
> You've added this control as a configure flag.
> Why do you also need it as an environment variable?

They are used for compiling the dependencies. But they are not needed for
QEMU itself so I'll add a separated stage for the QEMU compilation without
those flags.


Regards,
Kohei

--000000000000854d2c0648322cd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard,<br><br>&gt; On 1/9/26 04:11, =
Kohei Tokunaga wrote:<br>&gt; &gt; @@ -46,6 +49,16 @@ pkgconfig =3D [&#39;p=
kg-config&#39;, &#39;--static&#39;]<br>&gt; &gt; =C2=A0 EOT<br>&gt; &gt; =
=C2=A0 EOF<br>&gt; &gt; =C2=A0<br>&gt; &gt; +FROM build-base-common AS buil=
d-base-wasm32<br>&gt; &gt; +<br>&gt; &gt; +FROM build-base-common AS build-=
base-wasm64<br>&gt; &gt; +ARG WASM64_MEMORY64<br>&gt; &gt; +ENV CFLAGS=3D&q=
uot;$CFLAGS -sMEMORY64=3D${WASM64_MEMORY64}&quot;<br>&gt; &gt; +ENV CXXFLAG=
S=3D&quot;$CXXFLAGS -sMEMORY64=3D${WASM64_MEMORY64}&quot;<br>&gt; &gt; +ENV=
 LDFLAGS=3D&quot;$LDFLAGS -sMEMORY64=3D${WASM64_MEMORY64}&quot;<br>&gt;<br>=
&gt; You&#39;ve added this control as a configure flag.<br>&gt; Why do you =
also need it as an environment variable?<br><br>They are used for compiling=
 the dependencies. But they are not needed for<br>QEMU itself so I&#39;ll a=
dd a separated stage for the QEMU compilation without<br>those flags.<br><b=
r><br>Regards,<br>Kohei<br><br></div></div>

--000000000000854d2c0648322cd1--

