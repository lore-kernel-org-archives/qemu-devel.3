Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F9ECEFCE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdBf3-0000IK-HM; Tue, 06 Jan 2026 13:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdBf0-0000Dz-92; Tue, 06 Jan 2026 13:20:03 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdBey-0004rl-4D; Tue, 06 Jan 2026 13:20:01 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0EBA37A013A;
 Tue,  6 Jan 2026 13:19:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 13:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767723594; x=1767809994; bh=NoDuRKoYsa+91obY3mizZI2TEelrBYex
 aPe1wdu0fVk=; b=nD9CabwWPQG5jzsTR06szCfUvWfWRr0xgd2OcXGPzk4IV9B7
 EwB9k0zwZ/QLs0DaMU/i8NAh8amzeTNImbNrbBJjVFtGP4PTPkXlAWhqtYTna7+M
 JkJJzwLSQTihRhFHNp1Hk6IFppR9yW59hmcuuosYk2+8A+mS6R+TV0EZ9WclXk61
 4Lkg+xL1wmmFl7pAME8d57r5+RDYLYYMhz4XU31ULTe72JnoVW+JXmx8/oQ0hI3j
 sRa+04PdZ98bL6+v7A9Z0/90aRsp+b4I6h86m1FnCXs9xPosHIdnNN71N9nnqhP7
 g+RMM7I/6xOdwgq5xDpskBFgVInCyWJ3HMnf5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767723594; x=
 1767809994; bh=NoDuRKoYsa+91obY3mizZI2TEelrBYexaPe1wdu0fVk=; b=s
 G8RSfX7lYZtEa7tXvRX38ndtu8KzNDuK7HytBPfxLTqoSOFpzP2rmZirw2xMoiLr
 M//jx703mqoo81E7416B9u7MdFikXw5cULsxBZ7lxr9EwQRLMAQDFdkU+NqDF2yz
 OKEpGjXr39N7jS1ENZFr8Psl0WPDjXIu83jeIZPpsqbboxbHh9MxaIuoCbzltFVh
 fKJWP+VucgDwFhLBuXrtZwYWrHr1jx3NDo29Kb4sbeiGXjdYDnShlK7+Hh4Ip6W3
 c58P8fKVKAJMoCCIiCmfNmjUsHCnkeoEPNehbiZ2HQ+dWggqTlvMIseJA1R3bFu3
 ikshTjix3pawfeDGVKaAA==
X-ME-Sender: <xms:SlJdacgIsbXpiY-9FzHTSi8s4NcIkBMKgy0xCkXE8Kd3zUm-nDx3ew>
 <xme:SlJdacAt01XWNYf5SGnfNW-cn6Pb95Z9rM-23Nl3a25Wk0MUiZYFfFQ_NmO8LW5Pz
 ReY6CXq2w5UulDAV-NuPH6NF7DoB-9Vs7JhQ2002zCMVjtIUpy9DPI>
X-ME-Received: <xmr:SlJdaZEI72B9owvm3y6Z217NVrJDYVmU4xFtZn1Y0fjDs_S02gbSZAJQsZHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggs
 lhhonhhskhhirdighiiisehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:SlJdacL5RIRGGtxlrVkpr-Ei41OtSq2gHPgBjddrifZ2HGd_cZ3TFA>
 <xmx:SlJdaVnZ23HLKSHMSfxOzfzF9aYO_8Bydc4HVVFYp4YUdIkIv17FGw>
 <xmx:SlJdacTOg9q_rDH1vG0yzMEAo3i60O4tDjHoBvQtBuIuy8bZY7gA_Q>
 <xmx:SlJdafI0fpKiQvyoLxbXHEUFoukk5goUgcG75HvzqKhzG4iIAXIlYg>
 <xmx:SlJdaYrueWymfs_c7ukYbm7V22auNMuH_-tnMG609I_A7aeVKPMul0Nc>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:19:53 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0433964a;
 Tue, 6 Jan 2026 18:19:53 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 13:19:53 -0500
Message-Id: <DFHPPRS7DTVW.2PTTBH4FJ3B36@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v3 11/11] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-12-chad@jablonski.xyz>
 <52c0918b-dd96-2a47-5221-2bd34eeaa7f7@eik.bme.hu>
In-Reply-To: <52c0918b-dd96-2a47-5221-2bd34eeaa7f7@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>
> I've tested it with MorphOS and TVPaint but it does not seem to work for=
=20
> that driver. It never writes HOST_DATA_LAST, only 0 or 0 1 or sometimes=
=20
> 0-7 but never LAST so it must rely on results being flushed after enough=
=20
> writes. I got some traces like these below in case you can guess what=20
> might be needed for it.
>

This has been _very_ helpful. I was able to track down a few issues
based on this trace output. Yes, MorphOS doesn't seem to be following
the docs and sending HOST_DATA_LAST which is unfortunate. But they do (at
least based on these traces) seem to be sending HOST_DATA aligned to
128-bits. So the accumulator is flushed correctly at that point.

The big issue here was that this exercised another code path by setting
blit settings on the DP_MIX and DP_DATATYPE registers directly rather
than through DP_GUI_MASTER_CNTL like Xorg. That surfaced an issue where
those registers were being treated as independent state when really
DP_GUI_MASTER_CNTL is just an alias of sorts to some DP_MIX and
DP_DATATYPE registers. This was an existing issue so V4 will contain a
patch early in the series that addresses it. The path I took was to
break these fields out into their own values on the register struct.
Which makes for less shifting and masking. Curious how you feel about it
though when you get a chance to take a look.

The second issue, which was invisible because of the first was that bit
ordering was broken. I had made the mistake of ordering the bits across
the entire 32-bit word rather than for each byte. Unfortunately my test
cases were simple enough that the problem didn't become apparent until I
saw this trace output!

All that to say V4 will render bitmap fonts for TVPaint correctly. There
are some places (like buttons) that use transparency and HOST_DATA which
is not yet implemented but at least now we see the UNIMPL messages in
the log.

This was a great excuse to get MorphOS up and running so I'll be
able to test against it going forward! Thanks again for capturing these
traces.

I've also addressed all of your other feedback and will send V4 shortly.

