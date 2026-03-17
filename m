Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B23BFED9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2XKF-0007Zx-DD; Tue, 17 Mar 2026 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2XK9-0007ZK-A4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:31:22 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w2XK7-0003Mo-JW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:31:17 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DC89B7A01B1;
 Tue, 17 Mar 2026 12:31:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 12:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773765072; x=1773851472; bh=AIO1LzrlbhyJISzLPxbp6eJsfmHEXX5X
 K5UDBVyTKJU=; b=hXJy1rleclxlDmtiCYy1CQEmo0OI5chIe5ThMdGEZXNngjTf
 FzPm+4Emjhtfk3353OVC2ZIrIsuHc7+axr2c3OGb4njh6pr5/PsdhkGIO9TzSvnz
 gHb8gMebDvTSCE0rCPWJwi8P16sJ8mVIOOj/3ow9wzwOEtUS7HHbFVkbQiN6bOcH
 Joi2t4djS2O/HX4DgjERApIJ93J21eYaii1e5onR/UrQBCmnJjaLSQ5T0WtdQOl0
 ffk8q8lg5H/uqYcizonDxwibXZnU2IlFmcVWk6EvD/m4o8v3DOrnIyACAaCSDYiY
 v3uOqo66c28LoyHCboYMpK7VjvZg+M4vpwTIfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773765072; x=
 1773851472; bh=AIO1LzrlbhyJISzLPxbp6eJsfmHEXX5XK5UDBVyTKJU=; b=Z
 n8dXTi1lT/FK9Qi7i8EBQ3Nt3kslgdRhVP8eIOXGNrDeB4yIUlbl7aPsIa0RZ/ZY
 UxzPdjni9FbChUUEI2JAh1qI2cdH7PJigbkoE0unL4EFyoKWzx26q8sof74gX/0n
 8NhdmrlST6mjUruRc/3yEYXHx9hHdy8/lD55ITyToxeLNhNzoK7VtwCpNGnNdaoq
 3qHbpRzdAEeplmFi5UO+2O1QKOCXsxG2SJbuqdoVd9p20ofSDQKHhjJLfVjHvTzU
 mqw28sOGEOfP7Th44jsT/W3v/JPDWADNJU7EfAQv/jPGWmaWI9bh78OFbCp+lZto
 YcEPGXB3uIX5qXxmjksUA==
X-ME-Sender: <xms:0IG5aYUXX3pXhc8rLspodWp4SXeSrBA7OPV2U-_8yfyw4-K9ZK25tg>
 <xme:0IG5aQTDq4Uh3eB6ivAP1RHt1fiNYAKL6JIOVnVZngMil3rX_K-6WVTJx-yP279II
 xVJnYhokLl0r_gdUC3kAkqwjzPpcdMOc7IuJD4OZKN3ZHlpmZQ6Psg>
X-ME-Received: <xmr:0IG5aWP7ysPnqTbEoo1vKEpo8wPJjhOspHiQp6Mxb4oEM3iwv9ln_-7UFPe_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehphhhilhhmugeslhhi
 nhgrrhhordhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipd
 hrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghl
 rghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluh
 hrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:0IG5aeRqeThKBO4TKIhFJMfmyK-huYUn5QUEWkMgBrls3T3UClb7jw>
 <xmx:0IG5aUgqYcp78tergSwOFPLv7BRoOjwqdPfzMzkBcK5AEE0XNhFaRA>
 <xmx:0IG5aX_P63DYqPs8WbZYyPoH8Cjq9vkc-F2_TeKEqvk2uMXYDcoa6A>
 <xmx:0IG5abHp72kBvEqGtLLkHK2LqLraxBq9ClloVIqzVwAy87d633Tu8g>
 <xmx:0IG5aXWjJXDlgO0pFmRT-0Gagq6o-ir_kEnkkI61Ac89ng4bMCHe_PbX>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:31:11 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9d894004;
 Tue, 17 Mar 2026 16:31:11 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 12:31:11 -0400
Message-Id: <DH578OG8RPS8.PFREUK5BRSF5@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] ati-vga: Fix colors when frame buffer endianness
 does not match host
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1773618848.git.balaton@eik.bme.hu>
 <5837ddb9d354004465216a39b6b6189c2ee5c8f4.1773618848.git.balaton@eik.bme.hu>
In-Reply-To: <5837ddb9d354004465216a39b6b6189c2ee5c8f4.1773618848.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b7-smtp.messagingengine.com
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

This works in the 24/32bpp case. Before this I see a yellow background in
fluxbox, after I see gray.

I did notice that the existing big_endian_fb boolean in ati_vga_switch_mode
doesn't distinguish between big endian 32-bit and 16-bit swapping. In the 1=
6bpp
case I see a black background in fluxbox. I did a quick and dirty test and
replaced the bswap32s with a 16-bit byte swap and then 16bpp displays the g=
ray
background correctly.

This is a pre-existing issue but I thought it was worth pointing out. That =
said
this fixes things for 24/32bpp and is an improvement.

Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

