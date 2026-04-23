Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9F8FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzOO-0006yv-Od; Thu, 23 Apr 2026 15:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFzOL-0006yQ-DB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:07:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wFzOH-000565-Gh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:07:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b458ca2296so45516475ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776971224; cv=none;
 d=google.com; s=arc-20240605;
 b=LG7nrII7kU5LMEH5ADY4Swd4XpmQaIRcMumUuTEj+471BaOgOVdR0C3pQWGsDskiWN
 A0pZhLOnp5H1xzXUZlRJPSwo8QUIET65xjfDwHGnkXGfvsY/d4vtRMTS4FVXNWghIdse
 6cE5C6ojtwl46QQF96tedPRQcJkDmRMmpvdLycSWPrEHb4cM7I+uzcnSfBhBWno9W9OR
 LX1y7uoG987uAVWzxjGsCfEJOvq3i/8cWX4MePvv3jBi0k7BjHDAHZPDjsfO3F4JA5DP
 dCW0A8AZm7rusnk7wpU+RbOU2RlK+6PC0A8Sc3ZK14LTX+Av1T5o1Wx2gjbz5ETfC6Bv
 EQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RMLPa9YCz6XSMvUbc9rD0oVTb6kQ+qzbQg8vqeQXTGQ=;
 fh=MNYNL2jc9rj6nMVEdYKAOHNNeblzjZXP0FsF/H43J3o=;
 b=hMUiMen5CvTwRhLe9Yi5fY4yKUZdT5+np9tHbnFvaKwsTMe5b6Y/oPqae89C2Q+jYP
 NpDtzQJk9EclI+pHh9SSnfuiJq/lOuX5CkU9viBmcTSmuaTkyczhosMw87y5190GBh47
 4J5ZYKqtQffoHdpTK/aU9Gqbs5dvF7dlJw+t3ef/Rnz/yE7t8J0YMt++AnEyt7X11JRv
 JkMFMtnYIDlgGKZJ7TwR/qi1DApZvBGv5wtaqwbrT3LFM8x4qHxfl34BSAixsG31cXpB
 4xtGJCZ4ZmKolTTs2xDHAy6cKa9iAr/AM+3iEmTsQxcWnHYJLphcBvf4aysoHg0/xocS
 b7Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971224; x=1777576024; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RMLPa9YCz6XSMvUbc9rD0oVTb6kQ+qzbQg8vqeQXTGQ=;
 b=oAGEMcrb6K9iMjcc2WT8bbHXNbXZBUQvcj2F+NiJWPZvIGiC5ixWPvqIvx+LhsZilw
 r+402T9iYn/kjN7xa4uwKjcfFb127cY5rpmwi9bdrTB8wISxLwWLFaSEVaNET3Y9hhGd
 gdhV5BtXUoSZZBaGYBVQFDN0fRoziPIdT+oKn2u75wzALIezswx8oJ5iSUsAuLnpvXN1
 Vmy5TV7EfcaJlH7inplqgu5t0jfy94KXdL1QCF3LMWA4j21SCEmA3lfUNmR21U8lmSN7
 +XgXuK/fGV8SysuUvpq2UYsuaq9uP5SBedZRdoOBaHubeVUVHDGkbo6Jx/8DvyImvuB4
 eRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971224; x=1777576024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMLPa9YCz6XSMvUbc9rD0oVTb6kQ+qzbQg8vqeQXTGQ=;
 b=oQLXvGu6wy1Yf5B/dIU1hEOM1mmYw5jZnrC5uy8EjT3Uhm1K+5BuhYKruoqn0/Mq7G
 jb2EopEBSMmbu+z1I5l244V4fNHcE3O3/TRDoB1eAxBUfuPNN84e3JZz8pFPLXXT4mEH
 Baf/mWA0XNwDk0eqziRslfnhZ9U679Uv0HwVfiTEndVwBloFHW5rEvAs04O16aTXypNh
 KsvkkBEODRO+tef29e3TK6NyhBxfxM5OEeHJW1l65DFYQWOLrWsBQsqHEyg7FUGStqXT
 Z8kPR9T62Rw/+jOHBwpmDDLCLfCo5xVgE4JWSBvexK1kNnQcR6pFaiZfWDv63yUBIhx0
 0VYQ==
X-Gm-Message-State: AOJu0YyregD7vT4gXCLISbdm7U0/Zo2bOUj1XALl3HaMqDPIUltoXTlT
 B5zsaMX1VEiNxJyuXzs4ycRr68oEIfyq+Q6sz7AN2ONTRj4TMwf6at2JY8RoA4r4L4q9gF6deNa
 TbmsnkNFbAwII8eJ84QYGcQAgoFwniKg=
X-Gm-Gg: AeBDies4qVzCb5szHIeyaoMfZc/OoYI6WgAodAfjTQFm7w1JG+AJFRQz8YvfIbevkJw
 Da1FJbLkS2HXLMaCGDUDV8uTL1IzNs2rdezg2b3x9y+BTc7c8I5EX5Ih/4lNit7z89yoD/MmblL
 vC3VDJXo3whBap9W9yvIZ/tabfBiA9c1omZ/n4A68kMs4zDGb2e4il15NbeHTl/08coYcAfJvg/
 YtzZm6j5u5sXhbYmN3R/uIYwravUnOH3k16Zk/tUgq5lq5JH9NW16JUPNN4qEoZDPnhqSje/AMW
 2XNW3vjOQ4UNYB8A4Gyh9Z8Dps6B8cdkDhZH8S+0Cz+yTNpdzFw=
X-Received: by 2002:a17:903:2ec3:b0:2b2:eae2:db38 with SMTP id
 d9443c01a7336-2b5f9ef2317mr268394345ad.18.1776971224189; Thu, 23 Apr 2026
 12:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260423180304.53789-1-lucaaamaral@gmail.com>
 <CAFEAcA-mqtqcgMVeNgMawjN+RJF9DsfXvnLw5ncB9fRvTo2iJA@mail.gmail.com>
In-Reply-To: <CAFEAcA-mqtqcgMVeNgMawjN+RJF9DsfXvnLw5ncB9fRvTo2iJA@mail.gmail.com>
From: Lucas Pereira do Amaral <lucaaamaral@gmail.com>
Date: Thu, 23 Apr 2026 16:06:53 -0300
X-Gm-Features: AQROBzC_bEOhWhYdNxgKuda6__I5CwuBGMuMHiO0C3q2NhcGJqtq8h4i0cE6OfM
Message-ID: <CAFO1s2OoAe=qktioe9uWLWR5bHL+LEzrrc3DuXzremfWPQigzA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000980f8e0650255a99"
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=lucaaamaral@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000980f8e0650255a99
Content-Type: text/plain; charset="UTF-8"

I don't mean to be a pain, the contributor guidelines says to ping weekly
if not reviewed, I just included that in my todo list (and doing every two
weeks).

Lucas Pereira do Amaral

Em qui., 23 de abr. de 2026, 16:01, Peter Maydell <peter.maydell@linaro.org>
escreveu:

> On Thu, 23 Apr 2026 at 19:03, Lucas Amaral <lucaaamaral@gmail.com> wrote:
> >
> > Ping. This series has Reviewed-by from Mohamed Mediouni on all 6
> > patches and addresses all v5 review feedback from Richard Henderson.
> > Patches still apply cleanly on current master.
> >
> > https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/
>
> Yep, it's on my list to look at (along with 27 other series...):
> I'm just waiting for my current pullreq to land before I start
> assembling the next one.
>
> thanks
> -- PMM
>

--000000000000980f8e0650255a99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I don&#39;t mean to be a pain, the contributor guide=
lines says to ping weekly if not reviewed, I just included that in my todo =
list (and doing every two weeks).</div><div><br></div><div data-smartmail=
=3D"gmail_signature">Lucas Pereira do Amaral</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Em =
qui., 23 de abr. de 2026, 16:01, Peter Maydell &lt;<a href=3D"mailto:peter.=
maydell@linaro.org">peter.maydell@linaro.org</a>&gt; escreveu:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">On Thu, 23 Apr 2026 at 19:03, Lucas Amaral &lt;=
<a href=3D"mailto:lucaaamaral@gmail.com" target=3D"_blank" rel=3D"noreferre=
r">lucaaamaral@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Ping. This series has Reviewed-by from Mohamed Mediouni on all 6<br>
&gt; patches and addresses all v5 review feedback from Richard Henderson.<b=
r>
&gt; Patches still apply cleanly on current master.<br>
&gt;<br>
&gt; <a href=3D"https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral=
@gmail.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patche=
w.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/</a><br>
<br>
Yep, it&#39;s on my list to look at (along with 27 other series...):<br>
I&#39;m just waiting for my current pullreq to land before I start<br>
assembling the next one.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000980f8e0650255a99--

