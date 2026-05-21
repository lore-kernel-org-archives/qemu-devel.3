Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 01:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPsDs-0007RU-K7; Wed, 20 May 2026 21:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wPsDr-0007R3-9b; Wed, 20 May 2026 21:29:15 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wPsDp-0003Ei-Ic; Wed, 20 May 2026 21:29:15 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E49DE14000A7;
 Wed, 20 May 2026 21:29:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 21:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779326950; x=1779413350; bh=7bINJ5VHmuf5D3gyNqvWroK4Xq1urmEu
 z+OvxsshJ7c=; b=sDdQxCG4Vt7PVCAk5wFoqv3iEpZN3rh4LOpzLI6ncO9TEVuC
 nIjduu9UXcTSD2cbshqenjQbr0NPuI87hOGjvM5Hy2PLfQwR2hMndvmEa8E/lIPy
 kBo/FLuUTfpPvd51o82LAOSzuyP4cfRpxmvzA4rSXgbmZ70vWH8ZD8CpvQXijlWt
 ts67XKBulUSiYJ6/+U36V/mZO9DyZuPt+AP3UVKqcSkJnh1HHyaK/UvOI6CCR9rJ
 c2g7taTpY9Z6ngGEjtY97ceINZ10kPixiyeK+IB/XxBZ4xKQhi/neFvz2tCq13I2
 RKZ81pLqkHJcvjyS82/UzxadjsLDw3JcKxsS6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779326950; x=
 1779413350; bh=7bINJ5VHmuf5D3gyNqvWroK4Xq1urmEuz+OvxsshJ7c=; b=A
 f06FsbodrX1xSIdJW1zFeaEcHyZWll4cT1/Qu4pfkbAn8S4pq0p949EgKBlJzxw2
 dRcerU3HK3dFo4BcEX0siVCOm7kiaWo+gsKodm+sa3Mai2bRtHjWyKxHEiTGHjL3
 zlaIYFgNOANpEsu1nW8PBrg8jK3m/oZtpjbdUD/L8KsSK4r+DJItBU8rqCL8HhhH
 cFMKE21+jWGAL1/GkmgzWf55p3T34hzaIe+yynJgZL4coSNnFgamkck8KxJ3p7N3
 6F9HCyW6KbbP1//A2L53D84WD1l7JmY6t7hEfQrEinYfqtPcRwAXhv+MQa8EiyrC
 Kkq3CYuJv/hcBL8Bw4a4A==
X-ME-Sender: <xms:5l8OagCdTSpvXFbMPh2DFG2zxp97ztivJW7TcufrNhNPTDCmEaJtzw>
 <xme:5l8Oakzd53iZVv9R94jR7diyArErn-hGlEzlm0_beDLamX7FsBa6-Sq5n2B2Cu_hQ
 aK86q5fNfMFtK0UWu_Z4W3G9H4XhSW4qWbr02JLOtcPMyCXkRjU2Vw>
X-ME-Received: <xmr:5l8Oal1d36A91wAd0cJIikIEbzZ5aIG7gw6bvU4lmDghZxFnchah9l8R-_HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehjuhhnjhhivgdrtggrohesihhnthgvlhdrtg
 homhdprhgtphhtthhopegsvggrudgvsehprhhothhonhdrmhgvpdhrtghpthhtohepqhgv
 mhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonh
 esvghikhdrsghmvgdrhhhupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhr
 gh
X-ME-Proxy: <xmx:5l8Oasy8Z3N2ZSN9J4ChD87CuSt_GJfD2W1pk9RPJTl07KpX35ODjw>
 <xmx:5l8OakF_j5LRfKj6BaH20dG9nH8D55Q4jVfJmziBSUbjxS8PkqVI-w>
 <xmx:5l8Oanb0plOI6dsW-FXC3r6PwJW4XfMhw3k1FOyDoSLrFidC2xP2dg>
 <xmx:5l8OauB1WsL99yEAeezPZuJBJjasmBFVw76KVp2yibuMrtJ0TZDSWQ>
 <xmx:5l8OapsD9G4vk5pmSkhhH5JJ3sgkjvu0PTQ49R96cvmMbmGvtZpxgvUH>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 21:29:09 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id b7d8531d;
 Thu, 21 May 2026 01:29:08 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 21:29:08 -0400
Message-Id: <DINYRFRS419I.1L81XJK6N9P6R@jablonski.xyz>
Cc: <balaton@eik.bme.hu>, <chad@jablonski.xyz>, <philmd@linaro.org>,
 <bea1e@proton.me>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/2] hw/display/ati: reset host_data.next in write
 handler after flush
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Junjie Cao" <junjie.cao@intel.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260519023937.439077-1-junjie.cao@intel.com>
 <20260519023937.439077-2-junjie.cao@intel.com>
In-Reply-To: <20260519023937.439077-2-junjie.cao@intel.com>
Received-SPF: pass client-ip=103.168.172.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

Thanks for picking this up and sending a v2.

