Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5686C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKe33-0003wn-NU; Fri, 21 Jun 2024 09:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe32-0003wW-J0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:24 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe30-0003lc-GR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:24 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 73EC61140210;
 Fri, 21 Jun 2024 09:11:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 21 Jun 2024 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1718975481; x=1719061881; bh=u9
 nLIxTxlEETiGDfpuynZrOn25XladFpzBT9nm4Dsiw=; b=j1dlvxJWxYCRYWmwu3
 OEytXWOIKKWUS2i7DNUkdsEAZsCdj2JCHThp25+kAjXAmP1wGjmdDHV0Ju2d1qfC
 DeRZEfXCwHY7FALUbRzbHLycuWuXHdxF3kEjl4XspF1RBDAIEjdXfRadd1kFiLi2
 X4N0n+IkpAevC7rV5c31GI0Yi5cUdAzxd4zBt3A6PVU4/+7OS0g8FRe2qaPrYxC3
 u3o34pa3LMECGFbqseu9qyNOtPResG6lG6kTpoCtPiMgFaQmTB3XIQ9MpWYgmBtt
 n89lRrt7yUZ3lt/dYCbFBN5lRE2u7RRoZonGHWxcP4J+FXoI15BYHZGQPb1nY1T4
 fCqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1718975481; x=1719061881; bh=u9nLIxTxlEETi
 GDfpuynZrOn25XladFpzBT9nm4Dsiw=; b=EsOfVZWmi/yVcax38wdNjG++J1gax
 FaJCUREXREm5RtzGdYe0G/96gqWhKOale8lK01djFf83naCZbmwFThSLonbpoa8C
 kooo5JcaSDOI4g4VP/tvRby9cIRbBqmKpytLq4wdNTDedyUhavAV8GhvvMilGIiz
 3dDi9+APTuglyXJaY+F0nX724zNw98ViQimi0U9u8uB5cD09LNaaFLCWuwhfkVY0
 ZbL2rbn4dpoT9cb0PQ523bVDuvVyv9LTqtaTSABA6wo9cz41VEYWAqdhXbJMcqOQ
 ptNThjcq2OGjcKSE2QISnFjPefjWqYiD5rhfFCBz3RjLGZfFLs+1BFb/g==
X-ME-Sender: <xms:-Ht1ZpKSNggVkSZdLdU6Y-NxvbqLWtP4pwEHFR0qJjZRBCcz2meFXg>
 <xme:-Ht1ZlKweYm42JWNV6frgpaBvh9M9avbI8ERnO0CPnN-w7BSLLFUJXXqrX_OQvsyF
 it21KxSN4WIjka8TC0>
X-ME-Received: <xmr:-Ht1ZhsXMnz47AJFnitlyq_q0ev_lIAQ8SdWELAnQp8oGWTYectIYGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-Xt1ZqaE3d1xyeT0M5U-JhQyqY_g6WoT9zh4VCPjZJGDJBTa2OGZjQ>
 <xmx:-Xt1ZgZjyvUg8X4z1F_3YJwSNplSSlael5eQgg3dHXPtIDTSGUuu0A>
 <xmx:-Xt1ZuApkno2o8SA_bQE2lKRbDkvB5uV2W_z_LQTvYoHyL0ODH_pkw>
 <xmx:-Xt1Zual-M6GB0FkV9Zo8IbCCuUFW11F7L_9m9nb1q4Ar4SzoOyupg>
 <xmx:-Xt1ZlPAlVggB5HlbCB4psjTGmqCZbjc0KeOQVHfI13jluvjYIaF5kQT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/3] MIPS misc patches
Date: Fri, 21 Jun 2024 14:11:12 +0100
Message-Id: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPB7dWYC/4WNQQ6CMBBFr0Jm7Rg6NAiuvIdhgdjCJLVDWoIS0
 rtbuYDL93/++ztEE9hEuBY7BLNyZPEZ6FTAMPV+NMjPzEAl6bImhU7Ej1F8hTwzWnFO3qisblW
 b66YhyNM5GMufQ3vvMk8cFwnb8bKqX/pHuCoscajNpbL0oEbrm3XbKP1yHuQFXUrpC9G6hn26A
 AAA
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8PfpE7R1R+XFwAqMiTgcG76EEadaddiSWZMhGn1FyXI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p83DXYZ6pp/SlI7ernj/IJksX6DZp6ry+0ffF3Cm
 nx6/qvCjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIvNkM/wN2HGH/1cd0bu5R
 7u7Ajat75ukbeuit0dsjFmsq0PVvThQjQ8fnfs7eJVUHt6iIfVrNFfvkhdq0CVK/qs6x1+kWCHa
 Y8wMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Changes in v2:
- v1 was sent in mistake, b4 messed up with QEMU again
- Link to v1: https://lore.kernel.org/r/20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com

---
Jiaxun Yang (3):
      hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
      hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
      linux-user/mips64: Use MIPS64R2-generic as default CPU type

 hw/mips/loongson3_virt.c       | 5 ++++-
 linux-user/mips64/target_elf.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 02d9c38236cf8c9826e5c5be61780c4444cb4ae0
change-id: 20240621-loongson3-ipi-follow-1f4919621882

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


