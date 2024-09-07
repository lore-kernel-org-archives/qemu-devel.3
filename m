Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F693ECE56F
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 20:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn2SG-0004sW-33; Sat, 07 Sep 2024 16:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2SE-0004s0-C3
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:54:46 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1sn2SC-00022W-G2
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:54:46 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f761cfa5d8so2239731fa.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725742482; x=1726347282; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q2oSzy5zJ2Di+yknjnoFl8CnTzeLtLP8vcCHeBw9Oh8=;
 b=C6D6xzMoD4UKGQ+QdybpHIxOXHfQcLziGB22QJXZYiil5cYl7J8YumRcOItwYd5Y3u
 /pDLk6VSQ9GSdXHDb+nByvF+qTTNgozRq5/VpkhyU5T+zGhZJjYBVlpnkAIUi8K3NAj+
 TY4oi8pvj1x3gwh+dOcxzWkuIodpd9KGuo0N7vs7In2k5ZtGnxsz7sZhjpJConieYKLp
 sSPP1mlI3k7o1oUyAEohFoLp7RhVWIZoHqm2S0hlZdoDRUJBkXZp+PwAXww5EkA2pdar
 7DiTZXndhKep7ymc9yQ8Lu2ZES6Oa3p6qxmcr4hLCX0oSxfCkMzDoxUxvK3JfZAnyxOf
 Kc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725742482; x=1726347282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2oSzy5zJ2Di+yknjnoFl8CnTzeLtLP8vcCHeBw9Oh8=;
 b=vuvWbhcKYPPXvyvftOlvQZD0x1Ttuif4GkSJLzoawEYGZ2vlq28iTNkXT8kZGZg9WM
 buO9d62dNWUmwsuO8NAz2t1eCbeVYiJQAxTNS3xPJfssGwwqJ0V/LUephiInusvOzSRR
 mspEpiX7F0vrdgsYLHy0S/Pdo6hM4NH+eV/Wbo1ZfCSY7PccvEvwALuVts6nJYqKeqDQ
 EZrS9kyD+Kc4s1Dc6FtGJIPcSgBJZOCdAvLT0sr2s32xUJCIy7zbTfco3f3XCwDcwicb
 7UuVmu7BJ6muHOpOKdA3+UNX11iROAUKp0sCeUFpH7JIMM3XceYqw0KFY3MVamaC7cjg
 Kwkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8uwi2KpmUlwbYQFF1nWAdq1rLHAEDeWHUewZQmRw+vB/aFF9LP/AOC5o7cP5N8Y52Y69mj2WANIOt@nongnu.org
X-Gm-Message-State: AOJu0Yw32wwWOrbFikAS0/9oqFg1q3Q3kak4FLqbGi5RPyNq5q3kmytb
 eWNpOPrznloPW+fA4+wQ6Li/WeIJ2kCv1SHE+dxsq39wl7xUqbkBshgSGdSg8c8/7RjNoOW+Nkz
 OdoLcB7BiP9OKBQuZ/Ao84gFxMa4=
X-Google-Smtp-Source: AGHT+IERYgoGLjz1pD0Kize5Ji249TiRqZA4JIxAPqGez35NFq5KKSJ3FyMWPzDJP75vd6oCAcke4UEV2w5hzJBjZlo=
X-Received: by 2002:a2e:b893:0:b0:2ef:2e90:29f9 with SMTP id
 38308e7fff4ca-2f751ee1e18mr46943411fa.17.1725742481874; Sat, 07 Sep 2024
 13:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7rcp8YkeRisKBTfV0nenk6WvsG2Vwsqnm+=B=KD6rHuSqfog@mail.gmail.com>
 <bc2ab18b-0e26-40c5-af01-98616fcddb2e@tls.msk.ru>
 <CAFEAcA_-nV6zVq5Qo6XoF3gtnLNHaHBbMWJZOsUyrg_U=-fJDg@mail.gmail.com>
In-Reply-To: <CAFEAcA_-nV6zVq5Qo6XoF3gtnLNHaHBbMWJZOsUyrg_U=-fJDg@mail.gmail.com>
From: Kenneth Adam Miller <kennethadammiller@gmail.com>
Date: Sat, 7 Sep 2024 14:54:30 -0600
Message-ID: <CAK7rcp8-ZJ8q=iR_6jBntVacdq5Erjxap5b=GgQQvAD1i4sxRQ@mail.gmail.com>
Subject: Re: Build failure due to xen
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000009b2ae806218dbbf4"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=kennethadammiller@gmail.com; helo=mail-lj1-x230.google.com
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

--0000000000009b2ae806218dbbf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I got this to build following option 2 listed and it built with ubuntu
18.04.

On Sat, Sep 7, 2024 at 4:45=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Sat, 7 Sept 2024 at 07:39, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 07.09.2024 02:59, Kenneth Adam Miller wrote:
> > > Hello,
> > >
> > > I'm on commit bd80b59 and my host is:
> >
> > $ git desc bd80b59
> > v2.4.0-rc3-9-gbd80b5963f
> >
> > Date:   Mon Aug 3 11:44:07 2015 +0100
>
> Wow, that is very old. So the answer, in order of preference, is:
>
> (1) don't try to build such an ancient QEMU version: use
>     recent QEMU instead.
> (2) build on (a container of) whatever the contemporary Linux
>     distro version of the time would have been: QEMU at that
>     time built on Linux of that time, so it's the mismatch
>     between new host (system headers, compiler, etc) and old
>     QEMU that is causing problems.
> (3) if you must try to build ancient QEMU on a modern host,
>     then you are going to run into a pile of more or less
>     annoying compilation errors, and you're on your own in
>     figuring out how to fix them. Some strategies:
>      - if the issue is in part of QEMU you don't care about
>        then use a configure --disable-foo option to just
>        not try to compile that feature/etc. e.g. here if you
>        don't care about Xen support then disable it.
>      - look through QEMU's commit log and the mailing lists
>        for the compile message -- often the fix will have
>        been made in some later QEMU and you could backport it
>      - otherwise you'll just have to figure out and address
>        whatever the incompatibility is.
>
> thanks
> -- PMM
>

--0000000000009b2ae806218dbbf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I got this to build following option 2 listed and it built=
 with ubuntu 18.04.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Sat, Sep 7, 2024 at 4:45=E2=80=AFAM Peter Maydell &lt=
;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat=
, 7 Sept 2024 at 07:39, Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.r=
u" target=3D"_blank">mjt@tls.msk.ru</a>&gt; wrote:<br>
&gt;<br>
&gt; 07.09.2024 02:59, Kenneth Adam Miller wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m on commit bd80b59 and my host is:<br>
&gt;<br>
&gt; $ git desc bd80b59<br>
&gt; v2.4.0-rc3-9-gbd80b5963f<br>
&gt;<br>
&gt; Date:=C2=A0 =C2=A0Mon Aug 3 11:44:07 2015 +0100<br>
<br>
Wow, that is very old. So the answer, in order of preference, is:<br>
<br>
(1) don&#39;t try to build such an ancient QEMU version: use<br>
=C2=A0 =C2=A0 recent QEMU instead.<br>
(2) build on (a container of) whatever the contemporary Linux<br>
=C2=A0 =C2=A0 distro version of the time would have been: QEMU at that<br>
=C2=A0 =C2=A0 time built on Linux of that time, so it&#39;s the mismatch<br=
>
=C2=A0 =C2=A0 between new host (system headers, compiler, etc) and old<br>
=C2=A0 =C2=A0 QEMU that is causing problems.<br>
(3) if you must try to build ancient QEMU on a modern host,<br>
=C2=A0 =C2=A0 then you are going to run into a pile of more or less<br>
=C2=A0 =C2=A0 annoying compilation errors, and you&#39;re on your own in<br=
>
=C2=A0 =C2=A0 figuring out how to fix them. Some strategies:<br>
=C2=A0 =C2=A0 =C2=A0- if the issue is in part of QEMU you don&#39;t care ab=
out<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0then use a configure --disable-foo option to jus=
t<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0not try to compile that feature/etc. e.g. here i=
f you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0don&#39;t care about Xen support then disable it=
.<br>
=C2=A0 =C2=A0 =C2=A0- look through QEMU&#39;s commit log and the mailing li=
sts<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0for the compile message -- often the fix will ha=
ve<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0been made in some later QEMU and you could backp=
ort it<br>
=C2=A0 =C2=A0 =C2=A0- otherwise you&#39;ll just have to figure out and addr=
ess<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0whatever the incompatibility is.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000009b2ae806218dbbf4--

