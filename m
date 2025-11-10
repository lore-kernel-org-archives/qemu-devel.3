Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB5CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 20:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIYnK-0007ky-AK; Mon, 10 Nov 2025 15:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vIYNV-0000pe-OE
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 15:20:41 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vIYNU-0007On-8T
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 15:20:41 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 4F2F5EC211C;
 Mon, 10 Nov 2025 15:20:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 10 Nov 2025 15:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762806039; x=1762892439; bh=WVkiEB4DLWig2hejoiE0Y+aSPyZxBSpi
 Mm3w7gK49SQ=; b=UK1ANjmpCnpjRrWvvdHLiFX4mg61onR5Gl05MgLnRo3qQFF8
 aeUVOC6R9TU8WtmUbiim7dctG0/A92SQgW1ZS3NoAg61fw6Dp8s/Zs1w7jjbsztW
 CccuE9wJn/Ql+1R9FYNTEqnIPDIQzVEksYxYyMH/Wx8OQQ2d0D+I/IBrG+ihgnpa
 RACETkinWlzVF4kVZcxSrJgjjsrcKa69IJbfUMz8JXM21ZIgPaj3lKLHEVDru3no
 b+kUfkULehikIX/Bgn/j8Mo6tZd40VPJihSwDHLt6IlSGXx2KtmpQtywjWcXJDrU
 RM0R/kL72hsDqPe2+S17M52IO10YvewR7laW3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762806039; x=
 1762892439; bh=WVkiEB4DLWig2hejoiE0Y+aSPyZxBSpiMm3w7gK49SQ=; b=j
 Vof4Wyn0yE30k3MKGAvdE4cyK2FARw3ltCltbGYuFE2nAt5BpF7PP62VRhtjVouK
 RMXciWY7ftl7o9IZ80Dwbm52MT9kPnQfKAx2w2Luhxb43sa3myBIlp8bUu3nKYlI
 gVjA4F0BkEl+3zCOVWxo714FaOFFKGz7yuJhpJf3F3A0b3tc17I/rCG9hHVbge1o
 Xsos4AOPUDI9iBFx36adtzlxaU3KGCbrE6TV7ILUWYnw3X8xeRii0tIbZTti204u
 6kDEverfXruRlA8/i47o1oS9jWx+OxV69CNZWVw+cbKfFjCu4ysP0DTDYsZjJiKJ
 wMVQRwafm2/kGHlQLCHdg==
X-ME-Sender: <xms:FkkSaXKFdlKwleKhKa--_oRwCp1e_kkG5ZA4Tcz6rp3t4iyiLa5D_g>
 <xme:FkkSaSk1RStLS4sJzI2fdLHiLEp97yTAUPXXPmyEDA2LE78PojjtoX9rV0pwuKXxn
 z4MlCu5ck_PsKAO2qblBNB8kOcHIaYb5AZIMNDNmdn7G-VYwNxkTiaW>
X-ME-Received: <xmr:FkkSadGAhF6Y2TmwI2eh-m4ozdcY9cCku3XAthxJiFyhAGkcBPN6SPT9YZCH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:FkkSaaEinTEdC0BLfHORMOFyBtYothnC-GbeN1dtusavTxePxE779w>
 <xmx:FkkSaSPg0UGXF5QN-ztYERvW2RTj6PdIiTlLKFeaneR5ElDRUtG-gw>
 <xmx:FkkSaRFikZpseNasprYktLHHLLlDOu-IH3g43-g9pcqPd0YHL1TozQ>
 <xmx:FkkSaRMRgQG4E9jW0cFIHN43ZrNEhracaFT5HrgqXGf_JrYdLi5xTw>
 <xmx:F0kSaRxIeBFlnUCJ-a4pBLUMggs_5bPahzUAWOSV618OZqEkiKuwSNFx>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 15:20:38 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0502ed33;
 Mon, 10 Nov 2025 20:20:37 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 15:20:37 -0500
Message-Id: <DE5AL5W1M9CA.3MMWLQ2TMEF1V@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 6/7] ati-vga: Add expand_colors() helper for
 monochrome color expansion
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-7-chad@jablonski.xyz>
 <8b027a95-a5d1-3bc9-07be-93fbf8f8b266@eik.bme.hu>
In-Reply-To: <8b027a95-a5d1-3bc9-07be-93fbf8f8b266@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=chad@jablonski.xyz;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

>> +    int bytes_per_row =3D ((width + 31) / 32) * 4;
>
> I think there's some QEMU_ALIGN macro for that maybe in qemu/osdep.h?
>
>> +
>> +    for (i =3D 0; i < height; i++) {
>> +        for (j =3D 0; j < width; j++) {
>> +            byte =3D mono_src[i * bytes_per_row + (j / 8)];
>> +            bit =3D lsb_to_msb ? 7 - (j % 8) : j % 8;
>> +            color =3D (byte >> bit) & 0x1 ? fg_color : bg_color;
>> +            pixel =3D &color_dst[(i * width + j) * 4];
>> +            memcpy(pixel, &color, sizeof(color));
>
> Since it's just writing a 32 bit value maybe cast and =3D would be faster=
=20
> than calling memcpy for this.
>

Yep, good call! I'll make these changes in v3 also.

