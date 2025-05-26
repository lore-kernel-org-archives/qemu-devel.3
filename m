Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CA4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcWW-0005d9-En; Mon, 26 May 2025 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uJcWD-0005aY-Gb; Mon, 26 May 2025 14:25:49 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uJcW9-0008K0-Ej; Mon, 26 May 2025 14:25:48 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7024A11401AC;
 Mon, 26 May 2025 14:25:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 14:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1748283942;
 x=1748370342; bh=DbEvi04odDkuYge9ibqPaf9mltgovXntUpZFPNGgi6U=; b=
 UW+tLw3I1ml65YKuSDFR1ENJFM8EPh0ipmLyw5EfrLZj59wNQKQgWskufD2diC2G
 fIrcjHUEi69jlNIoa5MIUuRsgFbwc0cKfuwEM0cbGCtWd0NrEbh4SJSXBqWg9WwH
 B1Bd0oxx/9h8rigtPOetNybxdKiMXyPLelJgvDzs8bUH3IrdQiQHpLT4lvAsDT2m
 +Qhl80Zb5461siGOEdMJY16psMU4iUzo1+ZgKUbHxAqA4OlVw0YBa816bYAe30YX
 GqketwbGT4D2dwGrFCrcEhKZtepGbVrwTt18zySN0odo1pbLmyxCL3GEugSUwHTb
 OGymZKFKuf51kQb4m4KvNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748283942; x=
 1748370342; bh=DbEvi04odDkuYge9ibqPaf9mltgovXntUpZFPNGgi6U=; b=E
 ZU6xW0Lo5nSXVsZEJk4O6UNDZ/ODY9B4usiUCnaFKXlqD5lrXo0sOhv5pnMEOZdh
 gCoAobCp7EGSMfE4eYDexk6dq8i7FJlXv78MKKVOUWE8i7Mq8PsB4JW8riWu0ak+
 y/Y9asDblkBQhWq20VO98LkPPU8Sv9UrtOWLGZHiv8+HIKuQqlPNJI8TnxxI8Zfn
 wJrfpaHv5hMdcOCfgAvb5cIF/ugrsFsvejEQJwyA9BsFYTe/+XUy9KqsXnwyhBic
 5e/5VAPzm4CkGGgi2C+qgSK6nzyC7xrrm7/GrLdvgyk/71o03qQFur70Bl8dUelY
 0mxDxdDg8hysLYn1y/lQw==
X-ME-Sender: <xms:JrI0aDEcBKKPRq-qrpWgpCROqVGulfvhCJEXKVdI-XYfErUTcuaRKw>
 <xme:JrI0aAUjNnAHkKh0GDNOZWDkuPHhp55s52G3g6tAWNKOYZfYgX28qd-NwyVq6KD7p
 5jD_N9tXL2IprMissA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukedvfeculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
 jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoe
 hjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhn
 peejheefuddvtdfggfdvffekteehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvg
 epshhmthhpohhuthdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhr
 tghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhsnhhofies
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomh
 dprhgtphhtthhopehlvhhivhhivghrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehp
 sghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrrhhoshgrshessh
 hushgvrdguvg
X-ME-Proxy: <xmx:JrI0aFK_fwB4JVdOIlCrJkZ1vSq-I9eg_j1DqEZQbDRWWWqOq03IdA>
 <xmx:JrI0aBGOw7wrnh8n2nUs2ntzorqWAY7etJZPJZfiaXScKZ7DgiSA8A>
 <xmx:JrI0aJWH1gIe_f8BxmuLAJhETDg_03-rvtrkLNfBM4cNTzT_Isjb5Q>
 <xmx:JrI0aMM0aqexDeObuW6dHZbaGU9Q-egmfYgBHW8mqrWzitDbo3iJRg>
 <xmx:JrI0aEoaV2oRQzuU0LZniM3sFpsfjd_4F1GoQel79ZEfa83culQOlSCk>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 137821EA005E; Mon, 26 May 2025 14:25:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T8a47643d8fea1639
Date: Mon, 26 May 2025 19:25:20 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "John Snow" <jsnow@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Laurent Vivier" <lvivier@redhat.com>, qemu-block@nongnu.org,
 "Fabiano Rosas" <farosas@suse.de>, "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <9bfb089e-6bbb-45dd-8da1-14ba4e28d935@app.fastmail.com>
In-Reply-To: <20250526180558.65613-1-philmd@linaro.org>
References: <20250526180558.65613-1-philmd@linaro.org>
Subject: Re: [RFC PATCH 0/2] hw/ide/ahci: Delay a bit before completing reset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82025=E5=B9=B45=E6=9C=8826=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=
=8D=887:05=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> Intented to help SeaBIOS development; untested there
> (except with QEMU test suite).
>
> Jiaxun, is it helpful to you?


Hi Philippe,

Thanks for the proposal!

The spec says:

```
HBA Reset (HR): When set by SW, this bit causes an internal reset of the=
 HBA. All
state machines that relate to data transfers and queuing shall return to=
 an idle
condition, and all ports shall be re-initialized via COMRESET (if stagge=
red spin-up is
not supported). If staggered spin-up is supported, then it is the respon=
sibility of
software to spin-up each port after the reset has completed.

When the HBA has performed the reset action, it shall reset this bit to =
=E2=80=980=E2=80=99. A software
write of =E2=80=980=E2=80=99 shall have no effect. For a description on =
which bits are reset when this bit is
set, see section 10.4.3.
```

I do believe QEMU's current implementation is also in conformance to the=
 spec,
as the reset process itself is done instantly in QEMU.

I don't know if it's worth it to introduce extra complexity in QEMU to m=
odel
a very specific hardware behaviour. Even some hardware is working in QEM=
U's way.

[...]

Thanks
--=20
- Jiaxun

