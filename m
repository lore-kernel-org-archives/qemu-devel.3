Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B8DC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabma-0003dK-JY; Thu, 15 Feb 2024 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hns@goldelico.com>)
 id 1raZyR-0001sC-9d; Thu, 15 Feb 2024 06:32:15 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hns@goldelico.com>)
 id 1raZyK-0002GH-VJ; Thu, 15 Feb 2024 06:32:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1707996686; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=c3VQEsPMq3q2V3jBVlpEJMCwmm5bzCDbbu9hGzrS+FTVW/1ld8poJb/XER4TENNHJ/
 w0Y4CbKYodbhTItYVbXAQZ+lkf0I+hC8dDFBych/AXyXzI8rOiie0C4lRIccBcuFC+br
 Y36ALabQ8KSfu5GQzcVAv+Hhx+OqgFYcNe3Rrv03ZK/DRo8eK2c7GmWWDhOILg8OCut2
 DKjU0/o22Aou07FKnwNFS++e4ShfKxxMY6lRPs57/bL6GbAleYgeQd28mp3hxM7Qcixu
 C4ug2zF7dauCZdWZM8JGx8yLpCCJCcg55VliJphxRa3k6NxC7+Rk7vAykEoLz3tJeJR6
 Zsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707996686;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=a4mzxkEyzudwkHg8/Q5jsJVAmdLVIouP56wdNlx5Klk=;
 b=mPraINUrMWmxdml54QQuPIeKFvYew36uKGGMKfFemUK1Xcq0guXJNsr6RWhZ1RX9x2
 7qhEZZ1TRITZM1NC/iCn9RmGQM9Ribu4BFA/3pwOQEfXf2Ukh9XvQfAlr9bTxhMp3g99
 2sMJsAUAVjqaHV9m8esPviRYWzhwGaZivqyVrYx7r/hd2yBeSn1uzhHTySco3OhnxPp7
 WNU3aBCa9D1sFmNlyilQEmTcAdjxTGS6akN6ot8DOIxfbFWh0HeX4SbcKpOWHPYF6pu8
 cGnP5qLy1BblhFfe/3KQcsYw1xrpgx0yp8pmNXzYIcMndZGBYi9K+aXP2yfop5ECaRrf
 WfhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707996686;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=a4mzxkEyzudwkHg8/Q5jsJVAmdLVIouP56wdNlx5Klk=;
 b=s/Bn9hov0Chy9Cze5Qc8SbV/U/KJHbSWGp1V7d4/R6BwvwHFqKRVUzTR7Xq2lWp17O
 iNpLA+yZC3thSSbW5AkcE7pmCJu93InvIIFfWa6wjhB7vOcpdUEv3JtV+lnHQ3+AowKV
 Uzyf7bNYElYUJfPoB+T1oInAgQb81IpQ7Q/vTjftUuJLuMO+WpJCqPUII6tJWpzOGw25
 trvodr48HM0PgxFFKrx/naXpQYU7OhVivrIHXHdaXbHVx29XmWbphS5alMGGk6IlaPue
 qdPRDR5Ddr6u1whdIRVYIRzoz5sZMTZCf9E1LKeheR3RpjX1eyNRfamdS9u2UwbDbch9
 kKYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707996686;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=a4mzxkEyzudwkHg8/Q5jsJVAmdLVIouP56wdNlx5Klk=;
 b=7/ucvTxnf39LJF99iPUhyiY8bbAZfU3SP4Gt9NuDvfXYjThK2jbU/MbwqdQ/NAPoYu
 TQgr7JuMoPgKCs1PKqAA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qviAxtjc3+iDRKYXYiBKB+t+xHWJ5dYFU7T2iPf8ad6Lg=="
Received: from smtpclient.apple by smtp.strato.de (RZmta 49.11.2 AUTH)
 with ESMTPSA id z5997c01FBVO8Hg
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 15 Feb 2024 12:31:24 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20240215093113.5c58cabe@aktux>
Date: Thu, 15 Feb 2024 12:31:13 +0100
Cc: Arnd Bergmann <arnd@arndb.de>, Dmitry Baryshkov <dbaryshkov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, paul.eggleton@linux.intel.com,
 Andrea Adami <andrea.adami@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <313D5846-3F4E-485C-AD93-172CCD1F48F5@goldelico.com>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
 <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
 <20240215093113.5c58cabe@aktux>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=85.215.255.50; envelope-from=hns@goldelico.com;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> Am 15.02.2024 um 09:31 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 14 Feb 2024 23:42:58 +0100
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>=20
>> On Wed, Feb 14, 2024, at 13:26, Dmitry Baryshkov wrote:
>>> On Tue, 13 Feb 2024 at 23:22, Linus Walleij =
<linus.walleij@linaro.org> wrote: =20
>>>> On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann =
<arnd@arndb.de> wrote: =20
>>>>> On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote: =20
>>>>>> On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote: =20=

>>>>=20
>>>> Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
>>>> modernize it a bit, and Russell helped out. I was under the =
impression
>>>> that they only used real hardware though! =20
>>>=20
>>> I used both Qemu and actual hardware (having collie, poodle, tosa =
and
>>> c860 that was easy).
>>>=20
>>> The biggest issue with Zaurus PDAs was that supporting interesting
>>> parts of the platform (PCMCIA, companion chips) required almost
>>> rebootstrapping of the corresponding drivers.
>>> E.g. I had a separate driver for the LoCoMo chip which worked =
properly
>>> with the DT systems.
>>> PCMCIA was a huuuge trouble and it didn't play well at all. The =
driver
>>> must be rewritten to use the component framework. =20
>>=20
>> If we want to actually go there, I think the best option for PCMCIA
>> support is likely to replace the entire "soc_common" pcmcia driver
>> with a simple drivers/pata/ storage driver and no support for
>> other cards. There was a driver until commit 38943cbd25a2
>> ("ata: remove palmld pata driver") that could serve as an
>> template.
>>=20
> hmm, main usage for PCMCIA/CF in those devices was often something =
else,
> not storage, at least on the IPAQ h2200. Wondering wether that road is

There was a WiFi CF card for the Zaurus devices and I remember having
donated one to someone who could make the drivers work.

Unfortunately my devices are collecting dust and the batteries may be
bad now.

> actually good. When I was mainly using those devices, I was not good =
in
> mainlining things.

Same for me...

BR,
Nikolaus



