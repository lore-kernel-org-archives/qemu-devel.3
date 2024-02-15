Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E8C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXUR-00018n-F6; Thu, 15 Feb 2024 03:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbaryshkov@gmail.com>)
 id 1raXUP-00016y-Ek; Thu, 15 Feb 2024 03:53:05 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbaryshkov@gmail.com>)
 id 1raXUN-0004LS-It; Thu, 15 Feb 2024 03:53:05 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso253065a12.0; 
 Thu, 15 Feb 2024 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707987181; x=1708591981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjLQlaV8w7UBEfwH5YcxubeTHfuUmicctdfDV7dwdTE=;
 b=m0dL2TZ3Zh68sASdlyaSVN78+ISjysCezBlNnNWtsDT0fJ/XmpccCWungfOsHjc8Oa
 Nzh/nh3D7XFq41mU5/uFPa38gFUAE4UEddoMXeLdyBKtCuugbMOUEbuWdhgw6PQ3TUOY
 hv08jOJ7e6Tf0CHwBl1y5CW0lt+LRnLdVeeiOy/gRMTx+bIMslQnSjFalsJEqpPCe43g
 O9H45eyqAkY49t61UisuW+Rozpr85ck3DJNFWaixYicZEU5VucpNpC0VJ5q3n1nEpYo0
 hoP9FdkBCYlFJyjiZ3cVJLZqXiDf2htpEl4Dvl6EDhAI7HujvIYOY7OUCQc3U5QNaJBv
 DIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707987181; x=1708591981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjLQlaV8w7UBEfwH5YcxubeTHfuUmicctdfDV7dwdTE=;
 b=XiLWmr8FYewNAHFW/W0H3TzSiPxHmUNa575ZoOcr6ut44G81j+UslrU8Xuxoe5yOO5
 0Jt1/dJ0mTDhlo9+27Oo3ls6CzMa+luwI6Pxp0lagBDr4lS4oljd9+TlWKI1sd5quiLG
 oH09KNoQh24eyjomMQizfve3EohMdOhPJN51TDXxFsYIljVThj4fVPGJtmOgbfA69iwN
 B9PecUADbqW820Lw9QYucxXWZP1PLdN7TpN6vKyLiAE0MoAf1dFaksc4EdduutgDjn8i
 Krsxv+5lDjEEUmS2tMt8R+dOoPhyoKv76pTQOWMNePyca+0mqhjLNOpbQTQetj9edduN
 H7/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxABuh7K2W5co1zpUIdUvUqlJJgin1fLqhPzKVJ6kX4Y3GfUYCbU9+APZDa3x2UMWGWcb497bRU3HaCCzajB+m0kFpwdLtUgyePpTScOAIZN0H8lu5r0oG+q8=
X-Gm-Message-State: AOJu0YzsmhxIooxsxcBAFrZru3k4xsTSmSUXCZ9cvj0JKTCZRtSnStAb
 dbAhsHmM0GWYtOrpdbEopFvjLX427A842MTj9mlDsISgiwDze/RU1ZAMPYWnwzCoK6l8vw7QM2S
 EVTep2rND2dUITI9tuv0Bvddz4sI=
X-Google-Smtp-Source: AGHT+IH7yhDqygGkOBZjlnkkmsPexZmUcnfB7dEfwkq0oNkb8Mx/3sHu4Y/cvB1VlTOY6nBJd+sc2mb0SPki6o27D04=
X-Received: by 2002:a50:ee89:0:b0:561:f4e1:8424 with SMTP id
 f9-20020a50ee89000000b00561f4e18424mr667308edr.42.1707987180975; Thu, 15 Feb
 2024 00:53:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
 <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
 <20240215093113.5c58cabe@aktux>
 <7c8a5c5b-a94a-4b87-a043-f1e398b55872@app.fastmail.com>
In-Reply-To: <7c8a5c5b-a94a-4b87-a043-f1e398b55872@app.fastmail.com>
From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Date: Thu, 15 Feb 2024 10:52:50 +0200
Message-ID: <CALT56yPLobsL699K9+DDMBWwi7-iLzaYwuDwV7NmecaTY7Z6Tw@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Linus Walleij <linus.walleij@linaro.org>, 
 paul.eggleton@linux.intel.com, Andrea Adami <andrea.adami@gmail.com>, 
 Guenter Roeck <linux@roeck-us.net>, Peter Maydell <peter.maydell@linaro.org>, 
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=dbaryshkov@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 15 Feb 2024 at 10:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 15, 2024, at 09:31, Andreas Kemnade wrote:
> > On Wed, 14 Feb 2024 23:42:58 +0100
> > "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> On Wed, Feb 14, 2024, at 13:26, Dmitry Baryshkov wrote:
> >> > On Tue, 13 Feb 2024 at 23:22, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> >> >> On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.d=
e> wrote:
> >> >> > On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
> >> >> > > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
> >> >>
> >> >> Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
> >> >> modernize it a bit, and Russell helped out. I was under the impress=
ion
> >> >> that they only used real hardware though!
> >> >
> >> > I used both Qemu and actual hardware (having collie, poodle, tosa an=
d
> >> > c860 that was easy).
> >> >
> >> > The biggest issue with Zaurus PDAs was that supporting interesting
> >> > parts of the platform (PCMCIA, companion chips) required almost
> >> > rebootstrapping of the corresponding drivers.
> >> > E.g. I had a separate driver for the LoCoMo chip which worked proper=
ly
> >> > with the DT systems.
> >> > PCMCIA was a huuuge trouble and it didn't play well at all. The driv=
er
> >> > must be rewritten to use the component framework.
> >>
> >> If we want to actually go there, I think the best option for PCMCIA
> >> support is likely to replace the entire "soc_common" pcmcia driver
> >> with a simple drivers/pata/ storage driver and no support for
> >> other cards. There was a driver until commit 38943cbd25a2
> >> ("ata: remove palmld pata driver") that could serve as an
> >> template.
> >>
> > hmm, main usage for PCMCIA/CF in those devices was often something else=
,
> > not storage, at least on the IPAQ h2200. Wondering wether that road is
> > actually good. When I was mainly using those devices, I was not good in
> > mainlining things.
>
> Do we still support any non-storage CF devices that someone might
> actually use? Do you have a specific example in mind? These are
> the currently supported devices that I see:

The Bluetooth over the PCMCIA UART worked last time I checked it and
according to your grep it is still a valid user.

If we are talking about re-bootstrap of the PCMCIA subsystem, hostap
and orinoco come to my mind. We dropped those drivers a while ago, but
back at that time they were very useful. Also I had the out-of-tree
driver for Sharp 0.3 MP cameras using CF interface (yeah, sure, all of
those are out-of-tree nowadays).

>
> git grep -B4 -w depends.*PCMCIA | grep "Kconfig-\(config\|menuconfig\)" |=
 grep -v ^drivers/pcmcia
> drivers/ata/Kconfig-config PATA_PCMCIA
> drivers/bluetooth/Kconfig-config BT_HCIDTL1
> drivers/bluetooth/Kconfig-config BT_HCIBT3C
> drivers/bluetooth/Kconfig-config BT_HCIBLUECARD
> drivers/comedi/Kconfig-menuconfig COMEDI_PCMCIA_DRIVERS
> drivers/mmc/host/Kconfig-config MMC_SDRICOH_CS
> drivers/mtd/maps/Kconfig-config MTD_PCMCIA
> drivers/mtd/maps/Kconfig-config MTD_PCMCIA_ANONYMOUS
> drivers/net/arcnet/Kconfig-menuconfig ARCNET
> drivers/net/arcnet/Kconfig-config ARCNET_COM20020_CS
> drivers/net/can/sja1000/Kconfig-config CAN_EMS_PCMCIA
> drivers/net/can/sja1000/Kconfig-config CAN_PEAK_PCMCIA
> drivers/net/can/softing/Kconfig-config CAN_SOFTING_CS
> drivers/net/ethernet/3com/Kconfig-config NET_VENDOR_3COM
> drivers/net/ethernet/3com/Kconfig-config PCMCIA_3C574
> drivers/net/ethernet/3com/Kconfig-config PCMCIA_3C589
> drivers/net/ethernet/8390/Kconfig-config PCMCIA_AXNET
> drivers/net/ethernet/8390/Kconfig-config APNE
> drivers/net/ethernet/8390/Kconfig-config PCMCIA_PCNET
> drivers/net/ethernet/amd/Kconfig-config PCMCIA_NMCLAN
> drivers/net/ethernet/fujitsu/Kconfig-config NET_VENDOR_FUJITSU
> drivers/net/ethernet/fujitsu/Kconfig-config PCMCIA_FMVJ18X
> drivers/net/ethernet/smsc/Kconfig-config PCMCIA_SMC91C92
> drivers/net/ethernet/xircom/Kconfig-config NET_VENDOR_XIRCOM
> drivers/net/ethernet/xircom/Kconfig-config PCMCIA_XIRC2PS
> drivers/parport/Kconfig-config PARPORT_PC_PCMCIA
> drivers/scsi/pcmcia/Kconfig-menuconfig SCSI_LOWLEVEL_PCMCIA
> drivers/ssb/Kconfig-config SSB_PCMCIAHOST_POSSIBLE
> drivers/tty/Kconfig-config IPWIRELESS
> drivers/tty/serial/8250/Kconfig-config SERIAL_8250_CS
> drivers/usb/host/Kconfig-config USB_SL811_CS
> sound/pcmcia/Kconfig-menuconfig SND_PCMCIA
>
>      Arnd



--=20
With best wishes
Dmitry

