Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B54E77198
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTyi-0007ZO-0K; Thu, 02 Jan 2025 17:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyY-0007OH-9J; Thu, 02 Jan 2025 17:47:38 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTTyW-00048d-4S; Thu, 02 Jan 2025 17:47:33 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 12502138021C;
 Thu,  2 Jan 2025 17:47:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 02 Jan 2025 17:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735858049; x=1735944449; bh=aO
 Y9g5jXdu9zzShoF+aNqJo7EJnPSCrSF3E04R/CtUA=; b=VO323dKrSdAoiLph0y
 mrjAI/plr/FUNS5hBB63iFzpPJXO2W+PuHzPGItEW8TNpmkNEujHIYR0kCHe5Fsy
 jxNHyyJLa/qVoqruHfevA15WTDVVNPxELr8E7XxDctwbyI3A/UB6FV8xRcfCJQPu
 PUB50KtoS1ypV1xAZ8HMbC2bC/tJ8ZEaqBFuB3jaIP6Aylov94zoR4JbybSsMoaQ
 CCkYTBViVaMvN/v3Z2xHRlATjTwOkLZm0Uiyh+q1LZ2RHfJwjyv5GFJVxHWFz/3i
 adP5JgdM0urKGEFgm2xLpm6ffpxbe+5oFyloNRoTJSJg12TtBEO9SPkJf/RZo+ht
 Wikg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735858049; x=1735944449; bh=aOY9g5jXdu9zzShoF+aNqJo7EJnP
 SCrSF3E04R/CtUA=; b=St1LqHmfgWk/ADDSgSyQu7LwZA2cpfHRqBdS9+9wtR51
 0BZzuTaicrPNbqu+qo4OD48j0R0zK1S50RUcB3QxEGo+wPnMPpNDbSX44Rds1syF
 utlQ99vBI1sK3GZ8eFS+e9FiA0ICwfQ/uJuWxNOUT7DTO0NrdrrK4sosJa+DJ2gQ
 4AgfLNJFpT9MajWTHwSP0ng+yUypee40sgEvcADHqSrvPlsaKicAemSUJwpXOPpr
 +DAkGZhl2cyrceg4x5ZXfvlSfliDYkTsVJ06mkO/VXWHjHfHIqL0ocnpGrH38TY4
 tArHIetZD5hu8waF6olFmSfq1jBDswsXwtvPw/1/cg==
X-ME-Sender: <xms:gBd3Z11rBqG5SX4jt_Id1NaW2pzU_6HJgP4X5Q9SpQ-4kIeyG6lkGw>
 <xme:gBd3Z8Fg4ztoOd0omB0dteryDShAfYvqDZRFw46-nIbGmNWa9jwS5nNIwUo4zJBgJ
 3r6qkUrnefnltSgaz4>
X-ME-Received: <xmr:gBd3Z17wCVDXMTEZ9hvORobGCMuWbhJsVAtIJ67tPo4xs3pesZqyUikK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeu
 gfegvdeuueejkeejteekkedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhn
 sehlihhnrghrohdrohhrghdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonh
 drtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtth
 hopehmrghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepjhhirgiguhhn
 rdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdqrghrmhesnh
 honhhgnhhurdhorhhg
X-ME-Proxy: <xmx:gBd3Zy04u2EyywOlQAW1Gk-KUQcHuX-j35GUahxvq4HbsoBhHG6PEQ>
 <xmx:gBd3Z4Ed79zrGLy5pyWqOueSejRYTdiNUPu4ekmTSD1b2cxuTKPZOA>
 <xmx:gBd3Zz8SJHhRoRUDtEFkC5_tzJy1goUrb-zSu8E0CaVGC3pwIDi9pA>
 <xmx:gBd3Z1nwcXbbg5X9IdsjIZsQLe8aRAYELf1ksbgU7PzwSJ_Szx71Wg>
 <xmx:gRd3Zz2dWiXlsiJmgEVypOz9wa4Vr8HLxjeNA5bs9JvgAOULM9ncUZVF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 17:47:27 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/2] hw/loongarch/boot: Support Linux raw boot image
Date: Thu, 02 Jan 2025 22:47:20 +0000
Message-Id: <20250102-la-direct-kernel-boot-v3-0-40dbc45d633a@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgXd2cC/3XNywqDMBCF4VeRrDvF3Lx01fcoXcQ4aqg1JQmhI
 r57o1BoFy7/A/PNQjw6g55csoU4jMYbO6Xgp4zoQU09gmlTE5YzQRljMCpojUMd4IFuwhEaawN
 oWVesECXNsSTp9uWwM+/dvd1TD8YH6+b9TaTb+hX5gRgpUFBlXdeyrRoq8dqNc29VOGv7JJsZ2
 a8jjhyWHI4V54WWQhf5v7Ou6wdc+4/NBAEAAA==
X-Change-ID: 20241222-la-direct-kernel-boot-c598264710e7
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=973;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CMfSb3UmwYSdpeH/UrrBYQfSLrMR6+LctM7LDapLWpo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvRy8fq5bVrvrJ42L79qGf2epS19xuLOKbXT39x6WLBoW
 qan5KyIjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI3M+MDPsE7BaZFCZVdBrF
 hZ9d9nFXnu65bpc815Jvlg/v/tvxm4Hhv9OeFc9tExq6w38+eDx53Rrf9et+7Pq9l1k5ZNJ8y4C
 0r2wA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v3:
- Added PATCH 1 (Richard)
- Link to v2: https://lore.kernel.org/r/20241224-la-direct-kernel-boot-v2-1-3e8336c54c60@flygoat.com

Changes in v2:
- Use extract API for getting bit fields (philmd)
- Mimic arm's load_aarch64_image to handle vmlinuz.efi
- Link to v1: https://lore.kernel.org/r/20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com

---
Jiaxun Yang (2):
      hw/core/loader: Use ssize_t for efi zboot unpacker
      hw/loongarch/boot: Support Linux raw boot image

 hw/arm/boot.c       |  2 +-
 hw/core/loader.c    |  4 ++--
 hw/loongarch/boot.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loader.h |  2 +-
 4 files changed, 73 insertions(+), 4 deletions(-)
---
base-commit: c69612063e1844b76ac01e3a781b979548c3585c
change-id: 20241222-la-direct-kernel-boot-c598264710e7

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


