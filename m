Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD7C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRx05-0004cn-7D; Thu, 11 Jul 2024 12:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwzy-0004c6-P6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:50:26 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwzw-0007ZR-Mt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:50:26 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77c349bb81so139140366b.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720716623; x=1721321423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/j3lNShtALXOvDq3Q07KZQ9iHfjEvWoLEM/AjRM3SI=;
 b=GUs/A/5yRs436oxeptjeCrX4Hq/1RvIkf47mUiSwXUDQlY6zxgU1ptm786/I/b8G4g
 sd4cPjzenujI8a0OzPJG4X7mPMXjkLS844rMJhUWFENMTcnujMLo54F+kHaJF/tSgoRG
 nAvKpjQCuOKJicgaddbL2sSUYNmNCbrxWE3YkXoNhk8fItbw6YzmrIHBi6IxrFg7FNNb
 3e4MZJ9VVMz32ST1FGtMeJ0ZcQwUDCEgyfow5FzrcI83WqREDWx4Es34urmBIIQPQz17
 9VS6BGek9cbEzgXbEavpzbsqntZuL/sfH4Jy09tyufJMZoKpGaEFkUpMSoAyqfGlZkAN
 mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716623; x=1721321423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/j3lNShtALXOvDq3Q07KZQ9iHfjEvWoLEM/AjRM3SI=;
 b=w9K9YIc238OFRDIY02/K5sjIcTozb3Ak9J0a/qjW5kuSCsbb/mEBGDl4qnsquQ5qgD
 BwjPX2z421dR/W0Bn30DAcJeOeZan7HrLDkW5v+lLNR4ntccCy4iU32fLeWZR/lJv3/q
 Z87X+etzFHxk2FvuRE8cgxzEcwdPaZA0BMjFVHAq5u+FTPUhZL3bzWq0lzTJH1KKE6Yl
 0IXmeLinWDMah6ImKo8T3QVdnvCxR6KuReXIxOyL2hs/BWYP8uh9Ovd/YJWu5nGzYCyc
 m6n8XZ0Cqhubp1th8uqkivJh4JUBa6GQT1tfbZLYzylH0N0a7EqKqIWSSODU0mAgi5nr
 1shg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9g0l6bD73quk6dJAwdq85SYgazydfDukZ/fljP7dfvqL/yiltLHqTFBaopk5ouC1xyO/65G+37cxIwLlu2Wyja09Or+c=
X-Gm-Message-State: AOJu0YzQEReAt5R0AqLJsViH94ayJP0ElhBqPePHLt9slhoCIeS0CIZS
 HZcq0a3GHh/R990nVHAu2lehPv6mddsdJl6szG+gWctiSdlDRsgaCXSWSpXrz6oe4RXas54yLPY
 u3+72drUOnUh4Rw1zrWxOGx4c2rc=
X-Google-Smtp-Source: AGHT+IExNe4LTSt5zAUP1CXE7fQ60S4x63+zYZNDfuWVVKmNNr6+ii8DFKEa2YLkBJLw+hxvNdclyKOv3WrjghdW8VI=
X-Received: by 2002:a17:906:6a25:b0:a77:c657:5942 with SMTP id
 a640c23a62f3a-a780b88b3d8mr783441766b.52.1720716622504; Thu, 11 Jul 2024
 09:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
 <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
 <399b661a-9bf4-4f97-be9b-f3d633b8b665@daynix.com>
 <ZpAIyMW-ieaRjN34@redhat.com>
In-Reply-To: <ZpAIyMW-ieaRjN34@redhat.com>
From: junjiehua <halouworls@gmail.com>
Date: Fri, 12 Jul 2024 00:49:46 +0800
Message-ID: <CA+TA2aW3RUz71hH+VTwO2k+FfX8226PyFW7=jJouNcTivSrQEw@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 junjiehua <junjiehua@tencent.com>
Content-Type: multipart/alternative; boundary="0000000000000b2928061cfb8fef"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=halouworls@gmail.com; helo=mail-ej1-x62c.google.com
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

--0000000000000b2928061cfb8fef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:31=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
> wrote:

On Thu, Jul 11, 2024 at 04:53:50PM +0900, Akihiko Odaki wrote:
> > On 2024/07/10 17:02, hellord wrote:
> > >
> > > note:
> > > 1. The path of buggy msvcrt.dll is c:\windows\system32\msvcrt.dll(
> > > mingw64 links to it );
> > > 2. fwrite implementation in another msvc library which is called
> > > ucrtbase.dll is correct(msvc links to it by default).
> >
> > I don't object to this change but you should use ucrt whenever possible=
.
> I'm
> > not confident that elf2dmp and other QEMU binaries would work well with
> > mvcrt.
> >
> > I even would like to force users to use ucrt and call setlocale(LC_ALL,
> > ".UTF8") to fix text encoding, but I haven't done that yet because
> Fedora,
> > which cross-compiles QEMU for CI, still uses msvcrt.
>
> Our native Windows builds are also validating with msvcrt, and Stefan's
> Windows packages for QEMU are also msvcrt.
>
> Users getting QEMU packages from msys can choose whether to pull the
> msvcrt build or the ucrt build, but forcing ucrt is a non-starter IMHO.
>
>
I will also submit a ticket to Microsoft to report this bug next week.
I believe they should fix it, as this file is distributed along with the
operating system,
and many of the OS's own components are also linked to it.

--0000000000000b2928061cfb8fef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jul 12, 2024 at 1=
2:31=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redh=
at.com">berrange@redhat.com</a>&gt; wrote:</blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Thu, Jul 11, 2024 at 04:53:50PM +0900, Aki=
hiko Odaki wrote:<br>
&gt; On 2024/07/10 17:02, hellord wrote:<br>
&gt; &gt; <br>
&gt; &gt; note:<br>
&gt; &gt; 1. The path of buggy msvcrt.dll is c:\windows\system32\msvcrt.dll=
(<br>
&gt; &gt; mingw64 links to it );<br>
&gt; &gt; 2. fwrite implementation in another msvc library which is called<=
br>
&gt; &gt; ucrtbase.dll is correct(msvc links to it by default).<br>
&gt; <br>
&gt; I don&#39;t object to this change but you should use ucrt whenever pos=
sible. I&#39;m<br>
&gt; not confident that elf2dmp and other QEMU binaries would work well wit=
h<br>
&gt; mvcrt.<br>
&gt; <br>
&gt; I even would like to force users to use ucrt and call setlocale(LC_ALL=
,<br>
&gt; &quot;.UTF8&quot;) to fix text encoding, but I haven&#39;t done that y=
et because Fedora,<br>
&gt; which cross-compiles QEMU for CI, still uses msvcrt.<br>
<br>
Our native Windows builds are also validating with msvcrt, and Stefan&#39;s=
<br>
Windows packages for QEMU are also msvcrt.<br>
<br>
Users getting QEMU packages from msys can choose whether to pull the<br>
msvcrt build or the ucrt build, but forcing ucrt is a non-starter IMHO.<br>=
<br></blockquote><div><br></div><div>I will also submit a ticket to Microso=
ft to report this bug next week.=C2=A0</div><div>I believe they should fix =
it, as this file is distributed along with the operating system,=C2=A0</div=
><div>and many of the OS&#39;s own components are also linked to it.<br></d=
iv><div><br></div></div></div>

--0000000000000b2928061cfb8fef--

