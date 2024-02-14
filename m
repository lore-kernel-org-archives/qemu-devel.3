Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B1C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raO0J-0002rB-Df; Wed, 14 Feb 2024 17:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>)
 id 1raO0D-0002k2-VK; Wed, 14 Feb 2024 17:45:20 -0500
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>)
 id 1raO0C-0002Y2-33; Wed, 14 Feb 2024 17:45:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 5A20F1C0007F;
 Wed, 14 Feb 2024 17:45:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Wed, 14 Feb 2024 17:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1707950707;
 x=1708037107; bh=5IYsIk7ogLkaGYvbkI8VhBzBfBy+gdVcvU7E21EVjY8=; b=
 1Yr7/mbJgRu/HhpfbgOUHOg+uJ5aZcOS01dttWARtkBNr2rVkChrNEqbGxMJIHO3
 wp55mLtXoq5dRfKgAkEzYd8zzQjIOnpEx5uQuwoeXN9+pdltEYqBRf5pValSpttR
 j/FMDxJbE5RcSUg9c132/I43bRqMyff0LZ3AVkGhoDn9Tf0PjXneXo2aL4EE19DR
 e3/a3mnl5ev1C1cOw7NQ5jdkVmyuMFWqzJWG0NykYGPIGpZBHaUlq+FfiwQTxubI
 ZymJ8IuULP88e7NQq0f7eKKXTuz/7196rNk5w9mGmdE/V+sb3MLP6gV0GALhYTVa
 mlJj5y/ToOsrBfR4zWpWMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707950707; x=
 1708037107; bh=5IYsIk7ogLkaGYvbkI8VhBzBfBy+gdVcvU7E21EVjY8=; b=m
 6mrQt2ntzSE6f6WWVUf0/SLbblYyjVzZzLJkiKFZs8edw9cgmsMRIHRpTcjRwgR7
 zE5C6CjkM4qrW1H43JehuxzNMJuw1RJTrtIDS9k9LD6J7phGLo5rIAfgUiE1iZQU
 P9J/RYgM2tvb/lRkTVE6E6Hx3F7ItWrnJNSVJ6E9t1itGDSJj/4kK4LtVhH2c/c5
 z7o9qWSzLHa9a8V2nkcMIQ2q4ix8DochNgCAb6y7b9n8Trbgc70Pb3NzXypIpsV0
 k8kkIy6pjGEskTYeU4XPgr6J895lAJvCeDH/umKT3rhd7mROw7tNnkU6NmeELs3l
 vYJcwI6XYzg4Q/B/XBiow==
X-ME-Sender: <xms:ckLNZT_JJMaIVEZ2IlCnLR8UcjSc_Opv3Bh_2qtyw8ruP2zx-c9ejA>
 <xme:ckLNZftlgtrCdx5yAKOA3_9Sk59fRWoubTKnO3IkKzProJBpR-kugdW7aomPvRQ3f
 EZAqoXsYMuXQsqpv9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedtgfejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggv
X-ME-Proxy: <xmx:ckLNZRBG6dWjBwQiCIHiHIr1d3OD9dqKGI7cBHYYIogHlOxlTaIl8Q>
 <xmx:ckLNZfeg6GSk2ouFPnZZXu0aJylnz6EoMxw0-p_7PUEUEvJCwn9tZw>
 <xmx:ckLNZYM3oslqSs6pvDVxAbUZSmlpwfYYQtk074dm2Eno7XnE9Wm3bw>
 <xmx:c0LNZdf32ndN---QbdHBYSTIIdalud5LQRU3CRDRhLOnd0ueQCbTw9vlqxs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C74C9B60089; Wed, 14 Feb 2024 17:45:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
MIME-Version: 1.0
Message-Id: <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
In-Reply-To: <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
Date: Wed, 14 Feb 2024 23:42:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Baryshkov" <dbaryshkov@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Cc: paul.eggleton@linux.intel.com, "Andrea Adami" <andrea.adami@gmail.com>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "QEMU Developers" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "Marcin Juszkiewicz" <marcin.juszkiewicz@linaro.org>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>, 
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Stefan Lehner" <stefan-lehner@aon.at>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.148; envelope-from=arnd@arndb.de;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 14, 2024, at 13:26, Dmitry Baryshkov wrote:
> On Tue, 13 Feb 2024 at 23:22, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>> On Tue, Feb 13, 2024 at 9:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> > On Tue, Feb 13, 2024, at 16:36, Guenter Roeck wrote:
>> > > On Tue, Feb 13, 2024 at 03:14:21PM +0000, Peter Maydell wrote:
>>
>> Andrea Adami and Dmitry Eremin-Solenikov did the work in 2017 to
>> modernize it a bit, and Russell helped out. I was under the impression
>> that they only used real hardware though!
>
> I used both Qemu and actual hardware (having collie, poodle, tosa and
> c860 that was easy).
>
> The biggest issue with Zaurus PDAs was that supporting interesting
> parts of the platform (PCMCIA, companion chips) required almost
> rebootstrapping of the corresponding drivers.
> E.g. I had a separate driver for the LoCoMo chip which worked properly
> with the DT systems.
> PCMCIA was a huuuge trouble and it didn't play well at all. The driver
> must be rewritten to use the component framework.

If we want to actually go there, I think the best option for PCMCIA
support is likely to replace the entire "soc_common" pcmcia driver
with a simple drivers/pata/ storage driver and no support for
other cards. There was a driver until commit 38943cbd25a2
("ata: remove palmld pata driver") that could serve as an
template.

      Arnd

