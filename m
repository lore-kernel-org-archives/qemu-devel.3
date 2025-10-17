Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46768CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9miu-000898-C6; Fri, 17 Oct 2025 11:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mir-00086a-J2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:50:30 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9mif-0003hV-Vt
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:50:29 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8FCE67A016F;
 Fri, 17 Oct 2025 11:50:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 11:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760716213; x=1760802613; bh=MemuM44g6vd+9z1axHaKVlzw9Ddtk/AU
 q78NGmilkwE=; b=2xIxksBdmmh80naJTmKQhJRY9Vs+CzJQ2Cx8wODFt0H426de
 NSMPt758xEKv8xVVLyHNSD2wo0GdxXkFoT02cjpRqRJK9hXze4h/4dqrhlxNR8LK
 xxqnRu864o2EKMss7aJCwdTBBk0hsZJb1vzQdHLNkAwtQegvLLbn89zic8Wwosoe
 2nUbJZDph/KcdyG8sG87wVHVq4k/TF+uJGJGewuWhV2Pr4ANFDT1RxHhiYtwVt/c
 jVdV1tiGl7Pyal4PCgbWM0dhN6x6Q9Rw6EbPIyc4NV2CaHvtcUZ1ZzCz6ymRJqs+
 4ovBUVAiwUEk35bhG/Mwa9yp0uA7+8/iR5jh1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760716213; x=
 1760802613; bh=MemuM44g6vd+9z1axHaKVlzw9Ddtk/AUq78NGmilkwE=; b=T
 Rln/RfJ5S7WLo/Akw+JfJ5Cqge2QB7vTRxpqru1XU9VWoJBDy6Go2fDVYnZo5gbL
 OnaumIsvX/GgJSQYcLF93cUTB6B11BMqEZ4DmVbjXClfpjOkiWVLuGfNGjF5xavw
 7HfMb48VVzNxqz78WqLLO/G5wwIG5FyKKq8l6lN2HsIz0uPEEwEhoa8KchXindrz
 uiXoGRpgc31EJ76/5F+oFND4B5ohjFjm2ajNy9QTMmOE0ItM0VQtEDN+CSlk+YMs
 v11z84DSHBa/Y31LTMVerYEQzU+uh45CVIoDqdphICIv1dUaaWGLC3LDB0gmEbPN
 kI/yLnvK+wCJFF+quNK/A==
X-ME-Sender: <xms:tGXyaFtDcLt-fRm4KCD3SUFyGHClNYByTQ6jZvt3dODpORSX1mfmzQ>
 <xme:tGXyaFVWYchMEk30l5THJxh7Ke46veLtIINAugLjzjsaW6LYq93_HXQLT6AKyme_G
 IM2JscDJ1IWit7IvgsmJ63X23oBCKPaf8ITfS8LKpJS0UxWitokyAM>
X-ME-Received: <xmr:tGXyaBGzcLQHIHxvAQFdfvZimBszPIJqOMCp4zuickgRxMwvuwMLjwMwJqvf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
 gtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghm
 uhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvg
 hikhdrsghmvgdrhhhupdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:tGXyaH2uKmw8tkjSE8ex2q94FrhFwmuqt6Z__2x_w-mPYL2ewGm00A>
 <xmx:tGXyaDNWQt2l57_s3X-FYccVVHYingvV1QrHUjhjcIqtk1mLGt3wrw>
 <xmx:tGXyaG7fsINx4KbSm5v0NXGwjHvvuGPMXcisjf1J89fTLV2CwDEkCg>
 <xmx:tGXyaN09ra6g_i5A0zX_ga7Gb5C0Jp4zAU6kKT40omOaJ8ZuGzeP0Q>
 <xmx:tWXyaDz3tNVY8KukI5t-wU7JAjc1xTNSUucG6NZOPlzG_i8MahYejWnX>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 11:50:11 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 38e69554;
 Fri, 17 Oct 2025 15:50:09 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 11:50:09 -0400
Message-Id: <DDKPSZZMSXAH.2OQFS388R366I@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <kraxel@redhat.com>, <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 1/1] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251017145012.1948363-1-chad@jablonski.xyz>
 <20251017145012.1948363-2-chad@jablonski.xyz>
 <29d6945e-4e55-4ded-a1a5-33e614a3145f@eik.bme.hu>
In-Reply-To: <29d6945e-4e55-4ded-a1a5-33e614a3145f@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01,
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
> So can't we just use here memory_region_size(&s->linear_aper) / 2 like fo=
r=20
> CONFIG_REG_APER_SIZE? With that
>

Yep! That makes a lot more sense. Sending v4.

> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Thank you for testing and finding out all this.
>

Thank you for taking the time to review!

- Chad

