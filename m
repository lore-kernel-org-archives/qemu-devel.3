Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77311C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDeP-0002vZ-Um; Wed, 28 May 2025 06:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uKDeK-0002tj-Mm
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:04:40 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uKDeI-0006kX-Qx
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:04:40 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EE2521140119;
 Wed, 28 May 2025 06:04:34 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1748426674;
 x=1748513074; bh=n1PjCzJbRqMmKmrT5Xf405DSGFhgs1F5DNO5tqJqYCI=; b=
 nf0j7z98Zy0yAEBXDFBr62JJEDOIjU1GcOEkrtIF2i8kCnYk1RU4d/2FSYn0Zg+r
 i9BbhuTVywtWpBJbPDNNbE61ZAzNgpfQLQYoIRSaCJp5xxIZ+7QH0Ico//YpmMyQ
 PYYfVN7Mc/EDuUm3Eb3CE9VnXM243DGzEsP3G2SDPzy9RU0UBVDCM0SYX+ki4JYQ
 i6mvC94JdbwEOEO4+uVrfdmSqWiDOuagZGTNBRbjtaXkzeWUpkYtC53MTebDTqMV
 NbAd0f+gQC6mSp7D/UH0zBEprbXh6Pi2bfrKl87pC2aEjwwIbgST3g76/FmLm6uD
 z6Bzr6juU65hkA8gmzsc4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748426674; x=
 1748513074; bh=n1PjCzJbRqMmKmrT5Xf405DSGFhgs1F5DNO5tqJqYCI=; b=W
 Bb/wVgfjCXxWWCCo5avZYVVxRqRf3HQXfTgPI//770QVdcd5RI4OBYAsaJ3BFq6o
 o+sanKfe0USqakTxuw8UiyMmhGr19HBwlgBPO258ghm/qokbW/SO/wFYBkqDRiH4
 7s+s/fZBwyFQcJPyuA4EBKw0YjNGRSOZ5sPCfoC7axzX8++b6tOHCYrgp1Jo9OU/
 KpIq9bmuLpVv/dFEbRiaUoCNssQAWYWhUxTOdV5zPovy9EbpALT0rbsmf8pxWLOI
 bcz3jlC7J+h9qdQPScxcMWW4glhmC8f32P5o0nDpdQH94VgvO8ck023I8qJZXuQg
 HBVs84IO+TCwZ2/d1SDdg==
X-ME-Sender: <xms:st82aHrqkGIVhigTJ25Y0WTtLrZzlGB3cMQE4wWNY6hQUFN99U43qw>
 <xme:st82aBqOy2YJdKEeQJI9ZMOqxhogp9uMKmq3UhiE5rfjIuOgqgAbRCHq1vfbqg7fV
 Mdv0e1Sx9X23AvGMwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdelkeculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
 jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoe
 hjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhn
 peejheefuddvtdfggfdvffekteehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
 epshhmthhpohhuthdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:st82aEM1ryky6_K5b6QEkUjj4PL_OC7pINrB7I8Czsw38fJ7yK7Jeg>
 <xmx:st82aK5LG6LsUA92Cs24eX3G7bSlYYiaku3HGF8RX0y8UYvbWdqTzg>
 <xmx:st82aG5RSXBlWB1pGg7vcPTkkCbEb0Ind2wg1m9EpVFawjA2nmj51A>
 <xmx:st82aCgcr6Q3i_WFcfCIalALPTlW9tS2N967a0ZzLv74z_plBx-cDA>
 <xmx:st82aENHvRPID1Dp4vvDFCqTuTh2SYbhVDH6ssnLjczpkJ7D8cZoH30P>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id A135B2CE005F; Wed, 28 May 2025 06:04:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T86cbbd2d33d83f19
Date: Wed, 28 May 2025 11:04:13 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <71237b8f-bd04-44dd-8d60-b09f7882721d@app.fastmail.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
Subject: Re: [PATCH 0/5] hw/pci-host/bonito: Improve various emulation
 functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



=E5=9C=A82025=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=
=8D=883:46=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series addressed a couple of missing Bonito functionalities
> I found when I was trying to test NetBSD against QEMU.

Hi Philippe,

A gentle ping :-)

Do you have bandwidth on MIPS recently?

I'm planning to respin my CPS SMP series as well.

Thanks
Jiaxun

>
> Please review.
>
> Thanks
> Jiaxun
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (5):
>       hw/pci-host/bonito: Implement ICU
>       hw/pci-host/bonito: Implement PCIMAP register
>       hw/pci-host/bonito: Implement DMA address translation
>       hw/pci-host/bonito: Rework PCI config space accessor
>       hw/pci-host/bonito: Add comments about documentation
>
>  hw/pci-host/bonito.c     | 453 +++++++++++++++++++++++++++++---------=
---------
>  hw/pci-host/trace-events |   3 -
>  2 files changed, 284 insertions(+), 172 deletions(-)
> ---
> base-commit: c5e2c4042e3c50b96cc5eaa9683325c5a96913b0
> change-id: 20250507-bonito-482759b2b52f
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun

