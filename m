Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135CC4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra8Dn-0001XR-7q; Wed, 14 Feb 2024 00:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony@atomide.com>)
 id 1ra8Dk-0001Wx-EH; Wed, 14 Feb 2024 00:54:12 -0500
Received: from mail5.25mail.st ([74.50.62.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony@atomide.com>)
 id 1ra8Di-0007pN-TJ; Wed, 14 Feb 2024 00:54:12 -0500
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
 by mail5.25mail.st (Postfix) with ESMTPSA id 238AC60476;
 Wed, 14 Feb 2024 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
 s=25mailst; t=1707890047;
 bh=Fw5oQJ5HFO1ECMibd3OJwI8fxtVq/TOpOYMhoS5tAZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kmOQU0I4oJFiUx/7Ocp1oV0U029yuPjmVuTvIgts4mq+VS57ZlO6BiRampfUYIF2f
 lNDfC3pCeowqAzniITV5/dyWDMGtgP9ZpZw4+EynxVsnFG7q1LLSzStNxHAJ4MNWjO
 IpevMOFtYXvP1vglmOOrs3Oh6clkfm7U60Y2r3l/PRpiimTuA7WNB4Z8wcpugUdpFV
 h+VxKH4WkVYSRPaVNnbEIyglrN3Pp/gnS/ZBaA/dOxuqQlnmIB+RjjFPsrv157JAQu
 WGfnXmW/Ym8F6wvxPYR8MM36pvll6f2jI0xrQ7FCvGJyO0qPQplVvXvMsqZ2Ao6Eon
 jDPwoc+ufnKCg==
Date: Wed, 14 Feb 2024 07:53:16 +0200
From: Tony Lindgren <tony@atomide.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stefan Lehner <stefan-lehner@aon.at>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <20240214055316.GL52537@atomide.com>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <20240214012749.GA203324@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214012749.GA203324@darkstar.musicnaut.iki.fi>
Received-SPF: permerror client-ip=74.50.62.9; envelope-from=tony@atomide.com;
 helo=mail5.25mail.st
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

* Aaro Koskinen <aaro.koskinen@iki.fi> [240214 01:27]:
> On Tue, Feb 13, 2024 at 09:11:38PM +0100, Arnd Bergmann wrote:
> > I think Tony still tests these on both hardware and qemu.
> > The platform side here is much more modern than any of the
> > others above since it does use DT and it has enough RAM
> > to be somewhat usable.
> 
> I have also these boards (real hardware) and test them frequently with
> mainline Linux. However, QEMU support I haven't used/needed. I recall it
> was a bit buggy, and some changes in mainline made the kernel unbootable.
> Unless Tony needs the support, I guess they are good to go.

I've only used real hardware to test omap1 for at least 10 years, and I
have currently no omap1 devices booting. Still hoping to add n770 and
osk back at some point though for basic boot testing.

I could see qemu being handy for automating boot testing for git bisect,
but as far as I'm concerned no objections to dropping old device support
for qemu.

IMO it's best to concentrate on where there is activity and users, and try
to make thing easier to maintain in the long run. Anything with users and
active development happening we should try to help and encourage :)

Regards,

Tony

