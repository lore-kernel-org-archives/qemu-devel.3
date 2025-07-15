Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81EEC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublX1-0008NY-Bu; Tue, 15 Jul 2025 15:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubl2n-0007Y9-B8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:10:25 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1ubl2l-0002Gp-Cs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:10:24 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3F39514002DD;
 Tue, 15 Jul 2025 15:10:21 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 15:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1752606621;
 x=1752693021; bh=RPtF1g5C2CuUdiTxaNPOm74cUCy+x7CnlQHfmQKa0Y0=; b=
 B+iBeWjofw7hrcW1oUL5PXYvU/2ehoplhsAMok+7TxOWAgVwIO6MVEY8pnnAwmxN
 5L/rhDALHjHTQA33ekj5xkuxuuZUQcdgTYdIFa6VqeQo6mi+3JScfJ4t1tQ484WQ
 f0yFOPvu+P+EraT4JSqmTENXtC3zgqcaj6VHtNmAe8KRPFm2BCM4DLV7KtyOqGtv
 ukwojWRnnqQrePPT6K71irBrGwIYPK4ZeomkSqv5msbEPTtD/QycVST5KmG9Yyv4
 7pEWYVRgUM1R66Pk+ZORqaUT04rtV/Xg4TtkR63hSNCnfMGSbSsCDV8mpE8BlS9F
 44UuXG9AJxPVyt1G5aArLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752606621; x=
 1752693021; bh=RPtF1g5C2CuUdiTxaNPOm74cUCy+x7CnlQHfmQKa0Y0=; b=C
 zos33v8Rc8MVjVDZtPEaMD7s8UZAeXe8LfmjJwJunJvXbYz9u7IkS5PgRkmyQ3XX
 MLmxbcx0rnCCC3+IpauE4H7NhLaNHwYMg86oqbHG7bRvHE739pAYKtxPOVo89BH4
 Bk4szDAzqs3FNrKXLS8RXHcqNebC4TxNXiJSHEVEsctnkxmxUXJMaQM9v4iyUrDp
 6oExcup97m72oZeTIny51UdIPkqC9TwSTKigUTvqAlJHXHJuqMBgCRiraShW4d1A
 c0Z0vdj9b7aS4aQt2KkMJ2U4UO46/2OrmbTgnvcN81M1xZPoseLHyMrbkHGKAFKQ
 0jl15U3FSDH+AW8TIyT2A==
X-ME-Sender: <xms:nKd2aA6hSziXfqwel7FEO7CCNqFCmkWcos4HoqpFjhyiHLO2iIsBbA>
 <xme:nKd2aB5DxM9_g0VMdCm7s75fqJsI8jpcuyilDOTm4PpBN3tpoMfW9IRgW7v6bnYgj
 JjwQ02kxalFTF9bbW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeigecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflihgrgihu
 nhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffekteehhfelgfdvvedvkeeuffefkeeh
 heegvefhveetjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphht
 thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgvnhhhuhgrtggrih
 eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:nad2aBDEAKS9TEhfv2wnnH08gpekEOCHko6SjBpQSOStdaH8P0hnGg>
 <xmx:nad2aCzjt1chNuPpYdRmk2EOkoiyS_5bMuJF0_jxDXjeT1kymPOrAg>
 <xmx:nad2aGDFvwxfydgxgS30gdyM6Etb_ZgzbdG-zw-Cm-27SGbj6YaNCg>
 <xmx:nad2aHbF3FddiGkQr7KHXNTEIKwNl9RWI3t8RnNw5gvem_ZlxnQFLg>
 <xmx:nad2aES3urvcAQ_Bpc0GXsJriIwX0ozQbK23boQF6881bfU3qnWFIUtF>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E3AEC2CE0071; Tue, 15 Jul 2025 15:10:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T86cbbd2d33d83f19
Date: Tue, 15 Jul 2025 20:09:58 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <a972b6c1-5e66-41a9-b3ae-094fd98d6388@app.fastmail.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
Subject: Re: [PATCH 0/5] hw/pci-host/bonito: Improve various emulation
 functions
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



=E5=9C=A82025=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=
=8D=883:46=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series addressed a couple of missing Bonito functionalities
> I found when I was trying to test NetBSD against QEMU.
>
> Please review.

Another ping :-)

Thanks
Jiaxun

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

