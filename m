Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C971088E66
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w33EK-0000Tu-Si; Wed, 18 Mar 2026 22:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w33EB-0000Os-IN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:35:19 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1w33EA-0003RT-5J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:35:15 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D356A7A0031;
 Wed, 18 Mar 2026 22:35:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 18 Mar 2026 22:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773887712; x=1773974112; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=gWykBJplMQnbA1EhdJr7xCUPRg8EXO2woatGht6hlvAZqxBh
 nWx7MPcDXX1U/ky4EXmmoABYJbTFhCkce18fuU9FMdjiUR6Ai7qECl60pVPeroMb
 1GIL8ZlPUxfFN7j9gm8DbZamKal2cPtmTOL+v8oRVawa/Cj1V4iEG18kZKkfXU1f
 9cX6VFEmbSCCsg+kEqIUrhSWwv+EUTTxk6mMKm0qN3jGOxJzniNCdAmprGelvuaX
 ZcbxMbJ/sSNXZjB76CoYbsH3QCwzCES1RHYHbk9h+QLbsiSN+MasKWfj5eYkfx0D
 CiIIlf1XczdQ/FBvbrQvj/LQVEa3Qs2/sVU4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773887712; x=
 1773974112; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=j
 Vybbtd5eRhFa2sj/DtZPut8cl5WW3QY8uCTuJLJiMF1dQXQITM0xoTsMQl4qOBRR
 IH09CD6v6Y8o36aa6Ubu5mho/+YByLnUd8aGvX6e9zQK7qJaogspRLZfu5RkXdcm
 GOObvIiJ5IHssYCSqX9vu4Gb851/sjYV26H9AMW2m8cQkzMitUPthorXwtmNNEM4
 IfQ0PJ3a8Bjo0JYfNklMamj8/72sYDDl7uM1XqdgJJlccq8FsLbshRbnKI8zrkrE
 q38Zc47jtX/luLJIsmlKqzU0NAWGz25OYB0RpbgCmYldGKkEvIJEY/vrfHFyipi7
 q90xm9LFfn32gCNjvo3Jg==
X-ME-Sender: <xms:4GC7aQP5Ov-3Pk4FSx0S-1-0D5rhBubLEkx4g7mEow1xjRIZDvdMeQ>
 <xme:4GC7aar5Ccg_kaUp1-jn3By0peH2yaAm1cAiIvN-wGfTTRD20vH_O4TDZeSTzf2bK
 nghck5KQzvJjnLHXzWXlRAP_KJ3fjPCVzXNde4fNY0ORuZ5SxxTkKw>
X-ME-Received: <xmr:4GC7aRFkCQDtMyDqu5ngMsJm_sAZAEoqNYQuqKiaNeTNP-Eelr-sI_6fepBb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrg
 igvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepmhgrrhgtrghn
 ughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:4GC7afpQgFU_Ol3AbUQJSo_MgQsErtGSTxpdnv8_0k1bmfn9hfo1hg>
 <xmx:4GC7aablUIlX86yiukdWJ2p-MZl_ZWFgopC0fX7zTOOm8b269nYcqw>
 <xmx:4GC7aYUK_V0x3t0hl2ZMqlDkObfsXrTQgH917kNkZUo-dtoXh2p6MA>
 <xmx:4GC7aT9v1XLThh-vCv__4zi5qtyeoJjz7jztjXnqjvwDvsZq_Gewyw>
 <xmx:4GC7aeMgirknXUHcwrDNhTzdcO6_zw__41hDMtCgIVcsfmwIWTYvh7aZ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 22:35:12 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 6aef3805;
 Thu, 19 Mar 2026 02:35:11 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 22:35:11 -0400
Message-Id: <DH6EPOOIBB8J.1HT1JGU0TQHND@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 5/6] ati-vga: Fix display updates in non-32 bit modes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <cover.1773797056.git.balaton@eik.bme.hu>
 <91b8c3d6dba4cc5039f98bdc847e4391329f8b32.1773797056.git.balaton@eik.bme.hu>
In-Reply-To: <91b8c3d6dba4cc5039f98bdc847e4391329f8b32.1773797056.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

