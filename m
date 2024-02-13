Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69832C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 21:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra0Jt-0004QN-Iv; Tue, 13 Feb 2024 16:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1ra0Jt-0004Pl-0A
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 16:28:01 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1ra0Jr-0000WW-Gc
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 16:28:00 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4c02af5c068so181082e0c.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707859678; x=1708464478; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlHB/C070gQJYtZKeDqoDoUjH6sfS2fU7WC1adPgbS0=;
 b=bsJoYDQ/Xe6S7tXAxDoWSXxUI6FQtpELKetC13Eimo7aXQoOVJrcAR7k7pc2mD9KnP
 mIj9KaeVY2Rq6lhOIKWAYnbe1qUrPgEkxLx2H6NGfGM5HHUTeXEkmzEQ5PnAW9/viZg7
 pP0e7HzP+uk1YmcRYyeViN+AiUljR6/llIegRBP+RhD4BxINALpL8/P/qAU0ye21cw6D
 3myQzKftsDrY9NXQ4x1MW9DjMvHIb8zJOTanClZMRURg6mjhIdg8ukyKPImA3X8Lbs6M
 2zFhxaxfpSQoOtY9aoV97jiYIJzCwMzEpxS8qW1vxIrX8vI1K60fYYDxP6Cu3IqwSLSp
 pX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707859678; x=1708464478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlHB/C070gQJYtZKeDqoDoUjH6sfS2fU7WC1adPgbS0=;
 b=TumTuJ7+Zjmkl4Roj17SSaa9gmV7U3hhb5ANSyuahzy+431HJLX5/Kro6RinOhfbFs
 DD1vZI3BujA/l7RcMy8bQ6dzSVttjuo8y6oNYPlqoDiXW2nqpfjMu7RAF8TqO4mVkYd1
 4Q6WUcqru/rqyavZ8DLJ7Gr/qSBQOHfl3/gaCPm6FcgoRp7mrXorRAwHqoIk8819En8w
 jFbRwejCxd4DRjAzIGkFaYZ+L4gD0+RgVlVAkkz4KWS2Vj40hstx2Hd7Ft+Ui53th47f
 sWOeCg737+cbpK3TyggzsQJvLBp3Oi7Z5YpkL5rD09HXpLYZmD8Q8Jqj/ZSJhQuWszH1
 9SJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP8tFnZkRd0mmBEMqk9SoTle+/C0zEOWoi/y/UKGApfI1qBCUxtzfdOz35QFe1DUdgbFTAH2nhj9Qur7cctLM08qWtbj8=
X-Gm-Message-State: AOJu0YwnOmxd/Ur/Gd489CsWVNi5Ao3G0qquO+ATJ/1hi9nBmSKZreCu
 9XXyUx7VC1maBpCKM4rKy5tFLmGVxLAl1qMa1dApsAxcwpWFfRnmm3J8pBnd5gIbkH6OxCUOksQ
 6DKjGdxyKVRlIzrKWMRuq/k3R5YI/gekXXhxmEu3fQQ6nxwcu00uwjg==
X-Google-Smtp-Source: AGHT+IH8ZG9tqZjTbdsy3Wqrys0PBwBznAy2Pz0Y2bk6bYZ1+os+eqaytoO7CwQNH6qFjH86PnfRQiXqoe3DvRCfVb0=
X-Received: by 2002:a5b:54a:0:b0:dc6:cd76:5ddf with SMTP id
 r10-20020a5b054a000000b00dc6cd765ddfmr468191ybp.39.1707859321685; Tue, 13 Feb
 2024 13:22:01 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
In-Reply-To: <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 22:21:50 +0100
Message-ID: <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Arnd Bergmann <arnd@arndb.de>, paul.eggleton@linux.intel.com, 
 Andrea Adami <andrea.adami@gmail.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 Linux-OMAP <linux-omap@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, 
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Stefan Lehner <stefan-lehner@aon.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=linus.walleij@linaro.org; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
> > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> >> On Mon, 12 Feb 2024 at 14:36, Guenter Roeck <linux@roeck-us.net> wrote=
:
> >> > On 2/12/24 04:32, Peter Maydell wrote:

> >> > > The one SA1110 machine:
> >> > >
> >> > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> >> > >
> >> > I do test collie.
>
> Adding Linus Walleij and Stefan Lehner to Cc, as they were
> interested in modernizing sa1100 back in 2022. If they
> are still interested in that, they might want to keep collie
> support.

I'm not personally interested in the Collie, I have a SA1100 hardware
but not that one.

> Surprisingly, at the time I removed unused old board files,
> there was a lot more interest in sa1100 than in the newer
> pxa platform, which I guess wasn't as appealing for
> retrocomputing yet.

Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
modernize it a bit, and Russell helped out. I was under the impression
that they only used real hardware though!

The Collie is popular because it is/was easy to get hold of and
easy to hack. PXA was in candybar phones (right?) which
are just veritable fortresses and really hard to hack so that is why
there is no interest (except for the occasional hyperfocused Harald
Welte), so those are a bit like the iPhones: you *can* boot something
custom on them, but it won't be easy or quick, and not as fun and
rewarding.

The thriving world of PostmarketOS only exist because Google was
clever to realize devices should have a developer mode.

Yours,
Linus Walleij

