Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B68C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 06:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXF3r-0006gq-6f; Tue, 06 Feb 2024 01:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rXF3l-0006g5-0l; Tue, 06 Feb 2024 01:35:57 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rXF3i-0006sH-Fq; Tue, 06 Feb 2024 01:35:56 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56002e7118dso4023650a12.0; 
 Mon, 05 Feb 2024 22:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707201351; x=1707806151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGQIu2iyXKbqQB4wKmIpxYdLhXtJhWt5CE5JBqYuUY4=;
 b=gd7AVOmtSIVo7TciqVeDyupNuDt9VpJqbfKqWDAl5kxO5cNIoE7zl6fJPr/h8maxSS
 YF0f15yXG/r07kFbQHHduPj43a0sfNP5f/P+x4FmO4s5wJGgYQeHkAFPw3kOH7x+N5nQ
 y1e3icaDwFp/CZJdcqCOn/KtU/5nUH9snfPaeWhRqlGUBP6071Po6k4+C5dl0mLtvAm8
 h1WROYvJNptL6DLOjoCVrdUdpLOTtuLflXDFV31yvxi0+312GX57z0/R57zbiK2zoZZz
 9vNi1nqMZClzjwTYXwWB9PRLPq1b+1dje1lfbFn/MsYykFwW4L/+cbjjSCTFl56sz+z7
 x2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707201351; x=1707806151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGQIu2iyXKbqQB4wKmIpxYdLhXtJhWt5CE5JBqYuUY4=;
 b=skKZKj3A3P3q25KAXbHOhZtyaL0eilCB4rZVmnv6soixNNWTSepY6yhAlnQS+XSiZO
 uoUGEFk73QqSGPIdES49FYHCD5oD9Cx+RD66GQbNtKVZo2pxhVdfZhyXtHxGZ3qDuV4k
 dVYM88vHA0o2qSJjjrNS1Sono1xSkkJjNp0ESzfmBPyfq6yVVDkN2kohLaYAVgncB2ZR
 UPn+dZ/HGbhMFAH2ZfxohyZzZ0T8afehCqZO1VuA+6xvZ46FPwIML3Xo/Trx4CiO9jyL
 cuooSvuK0oE/DyqDb5UVGGXlx3Jl9wWhU4BuQnyqf28cBIEZo8+BnAlVicEcAhdGiZUS
 2WXg==
X-Gm-Message-State: AOJu0YyaAB9oZh6SMSrVwhesO44A5GV4BBAbdznXfX5g9c/Idgj8UyOE
 prrwWAYeREtifKDWZxHP15hNZ9gBfAweHgZ5/RsTeizES/HeH97ChcjUkxjC0vwJENgfDBGoZuo
 Pv/iBJccbyCOTjSsaZLenyr2Wg7g=
X-Google-Smtp-Source: AGHT+IFhOVhZAet7S6z7zrOCiL7z2MGz0c0IFJh1TE4UjhivuyLgj//yqIC7blrmqtjkiNqo6sUUA60tlWs/zCE/Rk4=
X-Received: by 2002:a17:906:53cf:b0:a38:32cf:1c9e with SMTP id
 p15-20020a17090653cf00b00a3832cf1c9emr196601ejo.52.1707201350557; Mon, 05 Feb
 2024 22:35:50 -0800 (PST)
MIME-Version: 1.0
References: <94cf974b-05ec-41c2-8d0b-43ffbc8bdeac@gmail.com>
 <904ef958-0e3d-48da-a4a7-5c1514c04472@tls.msk.ru>
 <e441b771-0a08-4f2c-b7a7-f6fdd787bc1c@tls.msk.ru>
 <CAFEAcA-C-pGGYY1bfE0ZatZP-imGmq=4-579TEnEZWFLeLxZLQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-C-pGGYY1bfE0ZatZP-imGmq=4-579TEnEZWFLeLxZLQ@mail.gmail.com>
From: Zhang Wen <zhw2101024@gmail.com>
Date: Tue, 6 Feb 2024 14:35:38 +0800
Message-ID: <CAKjfnjrCu1R6LE46AYf0+SGXs6994APhRvgSNWR8wfp=mnp3Fw@mail.gmail.com>
Subject: Re: building qemu on a system with libxkbcommon installed but not
 xkeyboard-config produces an core dump
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhw2101024@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2024=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 1 Feb 2024 at 12:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 01.02.2024 15:11, Michael Tokarev wrote:
> > > 31.01.2024 11:13, Zhang Wen:
> > >> With this patch, qemu requires keyboard-config when libxkbcommon is =
found on the system. So if the qemu is configured when libxkbcommon is inst=
alled
> > >> but not keyboard-config, the configure stage will produce an error m=
essage, thus avoid coredump in the build stage.
> > >
> > > I'm not sure what you're talking about.  What *is* keyboard-config an=
yway?
> > >
> > > On a debian system there's no such thing.  There's keyboard-configura=
tion
> > > package but it has nothing to do with that.  It looks like if we appl=
y
> > > such patch, it will be impossible to build qemu on debian.
> >
> > Aha, I found it.  On debian it is /usr/share/pkgconfig/keyboard-config.=
pc,
> > which is a part of xkb-data package.  And libxkbcommon Depends on xkb-d=
ata.
> > It looks like the distribution here is wrong, there should be no libxkb=
common
> > without xkb-data which includes keyboard-config.
>
> Are we talking about "keyboard-config" or "xkeyboard-config" here?
> The commit message says "keyboard-config" but the patch itself
> says "xkeyboard-config".
>
> Zhang: it would be helpful if you could tell us which distro
> you are building on where you see this problem.
>
> thanks
> -- PMM

I'm so sorry for the misspelling in my initial post and the confusion
caused by that.
I'm building my own system following the Linux From Scratch package, which =
is at
https://www.linuxfromscratch.org.
I accidently built libxkbcommon package but not xkeyboard-config
package, and then
while building qemu I saw this problem. it's a little difficult to
find the root cause from
this error message, so I sent this patch to seek for help from upstream.

--=20
Key fingerprint:
419F 72F3 F3A9 36EE 1B72  B00B C1C3 4BD4 FDA3 362F

