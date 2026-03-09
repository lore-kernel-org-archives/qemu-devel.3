Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDF8EA8542
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 02:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzQZi-0002VK-1h; Sun, 08 Mar 2026 22:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzQZf-0002VB-8i
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:42:27 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vzQZc-00080w-QL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:42:25 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 29CA31D00133;
 Sun,  8 Mar 2026 22:42:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 08 Mar 2026 22:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773024137; x=1773110537; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=RnLLM9OYfSayeAq+MV17c52bludvqSuuFa+xBHfGWmp03POa
 /yrv/W2aNAJ4urjuWzw8eyK7Uy3VYxzsV+BAGoIxIEqb3mq43jGhZjcnZhjhS7Mt
 YT890WcJpoc69AB+qpuSwNYZLeQJa/4TUTf/U4Mx3kGK7LcIEZW1PDybGS/KMluW
 6vKKwBNvU5G5k9+bW+fI9yIdP1rmEXdM7MEulB4kf9sKGrjjHqLTVHyFlMW6Tpwn
 pb7zlnniKDJ87+DZoxIwliUBeDO2Gh2tsgLBLILwCCp+465/EzvKMVTng/chfnR2
 5dMXeDD6k1x2FDyY/RT/POv+5A+Ys4mmEn3Lsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773024137; x=
 1773110537; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=H
 AgVbd511rtEpvvMQy1XmipT5oGg9E6wR9IC2rIoqQb7tzg2QQDX3NjCiLkMMuePM
 ZGZXUnW+x11zF3d4p4cgLbWjxeodESPtaRgwBhGOo5rBkH9Ot8IACBi5Li5u5nzD
 liLH5EoHtEN8NAn7RV4+idklzqdzuhn+Ku47u/TL97GNifjBFnRq8uVM0+fA7Aei
 jYPRhwOZ2vqnbx5VCqZyC4e6/0nYBpC0ggy5DuYZvzZ5/e+Z/V+ITYo+Yde71Ryd
 y9/B0d1mtPtd2w95WpbmntFEh2N+6QwID686xQ4OjshX64CLNe8q90/qBWRD/koV
 mLmuOUyZs1uqpI1PD0nEA==
X-ME-Sender: <xms:iTOuaRWDc3KCiKXp3QeSE4RYf_eyLcIOdiHQjEt_ZWhPYAPFyLr5lw>
 <xme:iTOuaYeUfKs1haImzOAUgHdn70WncHEn9_ZEug7mYRoQK7JdamTzjbDCG-cBy2wH5
 5veuAKrsN21rwh1lmthokzKFTn-vwolYcm7Xmophn5d03v7eyJpyVU>
X-ME-Received: <xmr:iTOuaVsaA5Nxn4kcpnrbq37vF2HpHLQ_148oRNBqbvDAzuMEbtb1sMia3Qn1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkuffhvfevofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeekkeekfedujefgleeguddtuefg
 hedvhfehhfdutdekffdujeelfeefkeegleejhfenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
 gtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghl
 rghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:iTOuaf8khR0u31Mz6RU98etMPzCi6XmNPajwAu5wUx0iwhKwhA3Sjw>
 <xmx:iTOuaY2XF6P_1Zcyj6WhP6E24RPBaM7kveMtymwO9ZN92qNC0JURsw>
 <xmx:iTOuacCOLKNGcn06GEYWcjN7MeYZH_jpRbHNrhVTK47iunJz7nwjOQ>
 <xmx:iTOuacePcvGVBOJz-8NYjF5haw9yGKJkCO5xwrK695G2I5X02AXqxA>
 <xmx:iTOuaQ5wPaDKAWxGQ6vWrFznQ1_yqyEtKu8GQQf6r0MTunyfaEgb3lyj>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 22:42:17 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 85c9c94c;
 Mon, 9 Mar 2026 02:42:16 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Mar 2026 22:42:16 -0400
Message-Id: <DGXWLNVJONOP.2H6YZDMRWSCOD@jablonski.xyz>
Subject: Re: [PATCH 2/2] ati-vga: Do not access pixel outside the screen
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <cover.1773009887.git.balaton@eik.bme.hu>
 <26db0715a6b9f6504f394010513facc9a37882ad.1773009887.git.balaton@eik.bme.hu>
In-Reply-To: <26db0715a6b9f6504f394010513facc9a37882ad.1773009887.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

