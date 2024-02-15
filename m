Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044C1C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabmb-0003gP-EZ; Thu, 15 Feb 2024 08:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1raX9V-0002E7-UG; Thu, 15 Feb 2024 03:31:30 -0500
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1raX9U-0005lr-Af; Thu, 15 Feb 2024 03:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mdYToYuDmh6OlwRD6Ej97k/1spumBy4m+atUuj+qy98=; b=vKwC6cNZjEDmW0ViWp1hf3tqE9
 yo6U1M34Lj0sObd4osD1B7ykNVCDPgSw1bBmtIYRWlZcAhsxD4pgW/Mdf+p2vb6oEGb/7UwNj7sqs
 AJ2n6XTA7bPq164DfJpODrHHMuLwi4gwJaYLOLMAENs9TCTIxo08ySygVsDKeeZ26XxlaKo1UJmID
 NYtVT5GjUemWScsjCzCyfwUN7WdVg/ftxexJiFvP2tA2K9UBAWBRkoIpz0nx/gb5KXXrZkBUBmEKM
 B1ag33DesNwkdZse+VTfAZzwKerIhD46b22JpcIdkDlrmt8NErdiz4twj2s2CaOu+sLSBl+LGPF/D
 V5YG4V8g==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de
 ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
 by mail.andi.de1.cc with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <andreas@kemnade.info>)
 id 1raX9I-009SKj-Ee; Thu, 15 Feb 2024 09:31:16 +0100
Date: Thu, 15 Feb 2024 09:31:13 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Dmitry Baryshkov" <dbaryshkov@gmail.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, paul.eggleton@linux.intel.com, "Andrea Adami"
 <andrea.adami@gmail.com>, "Guenter Roeck" <linux@roeck-us.net>, "Peter
 Maydell" <peter.maydell@linaro.org>, "QEMU Developers"
 <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>, "Aaro Koskinen"
 <aaro.koskinen@iki.fi>, "Janusz Krzysztofik" <jmkrzyszt@gmail.com>, "Tony
 Lindgren" <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik"
 <robert.jarzmik@free.fr>, "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Stefan Lehner" <stefan-lehner@aon.at>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <20240215093113.5c58cabe@aktux>
In-Reply-To: <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
 <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a02:c205:3004:2154::1;
 envelope-from=andreas@kemnade.info; helo=mail.andi.de1.cc
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 08:28:07 -0500
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

On Wed, 14 Feb 2024 23:42:58 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Feb 14, 2024, at 13:26, Dmitry Baryshkov wrote:
> > On Tue, 13 Feb 2024 at 23:22, Linus Walleij <linus.walleij@linaro.org> =
wrote: =20
> >> On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote: =20
> >> > On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote: =20
> >> > > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote: =20
> >>
> >> Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
> >> modernize it a bit, and Russell helped out. I was under the impression
> >> that they only used real hardware though! =20
> >
> > I used both Qemu and actual hardware (having collie, poodle, tosa and
> > c860 that was easy).
> >
> > The biggest issue with Zaurus PDAs was that supporting interesting
> > parts of the platform (PCMCIA, companion chips) required almost
> > rebootstrapping of the corresponding drivers.
> > E.g. I had a separate driver for the LoCoMo chip which worked properly
> > with the DT systems.
> > PCMCIA was a huuuge trouble and it didn't play well at all. The driver
> > must be rewritten to use the component framework. =20
>=20
> If we want to actually go there, I think the best option for PCMCIA
> support is likely to replace the entire "soc_common" pcmcia driver
> with a simple drivers/pata/ storage driver and no support for
> other cards. There was a driver until commit 38943cbd25a2
> ("ata: remove palmld pata driver") that could serve as an
> template.
>=20
hmm, main usage for PCMCIA/CF in those devices was often something else,
not storage, at least on the IPAQ h2200. Wondering wether that road is
actually good. When I was mainly using those devices, I was not good in
mainlining things.
I loved that daylight-visible display.

Regards,
Andreas=20

