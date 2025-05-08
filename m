Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6043AC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2W3-0005q8-LR; Thu, 08 May 2025 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vz-0005lJ-H2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:23 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1uD2Vt-0005Qe-Rv
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:46:21 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 9C19C1140186;
 Thu,  8 May 2025 10:46:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 08 May 2025 10:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1746715576;
 x=1746801976; bh=xgYGUe5aVPbLGV1KO4i6XTjmOUixoOut3Ubry1WEeqo=; b=
 UD8o5DwaK1v3X+MasI+5HO8UTKifcsECC867xeiU3BFJcjtjz4kqNTETRoB1ytvd
 /IyV0L5aYm3FkrBGwoBWjlGWmDHg4faVSQPFodX+2gcxeU8vXhguq1B/vpkVxhpz
 DWugllj23h7jnNThnfLAmuIlBPprueXM+6h9jIrFhXqN4IbGFJNaOGGepoq0K16+
 VzOpC7YxMa6P5WGSnoFB0MsNuou7Xi8sBQy82j4NO4ixsg2dm3rKZFzqUl8VzTch
 wzrPjzPpXR/kYrJoFbuRavTEPui4dh8Ffb+fEVGmB+H0FOTS02KgDrQVAq1KInTo
 eiMOCsI2wOkhHYVeRCr0Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746715576; x=
 1746801976; bh=xgYGUe5aVPbLGV1KO4i6XTjmOUixoOut3Ubry1WEeqo=; b=A
 CEF2GBTL3WNaXAqLW3XIWFqAn8IVTp5rPnMJvUCq59aGxAfsdTsvh+lKgscSW37j
 h6rHHR4O6qqLmMX+WGYiiLlphx62+pV7VKEMc8dgshf/S92mg814JkAQiVP2uOqN
 wVBBqwUVhss1K0/enBtl729t901dbFWgtT7ggi5IsJpLAtkR1l7o8xNk3054w1+Q
 fpP0VObRNsrzSzPjzty8jk+WQmDjzMjk/CMAgaewAkIAiI1z3ILDk+G2O0Q6ubls
 rKaSQClJ9H1b7uhDijbawkMS7VENAbUUeAx4m+8PQmpVYiPYPnRh0O1bLEn7d8OD
 oulIfd8DME0SkU5sk0NLg==
X-ME-Sender: <xms:uMMcaI8byTFkEp4_xtJioh_r5Hek0QArUnFIrdEGMDxDqqWF-uZmgg>
 <xme:uMMcaAtSLZNL8b6TfQQBzu3E9vT-DcUv_GmU4QiYoFwyIZ53mlaIbRYr-MIzoQJBI
 Nb4a6llRHPIN_ift2o>
X-ME-Received: <xmr:uMMcaOAohoXEDuTPa27PYz_NoszPG4TVGaPGSf8JvkzQScwduteCKvTFIPq97UI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
 tdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffegieduteefgfduheegkeeh
 vdejfefhvedvudfhtdefjedufeekteevjeejffefnecuffhomhgrihhnpehqvghmuhdroh
 hrghdptghiphhunhhithgvugdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
 uhhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhope
 gthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhn
 rdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:uMMcaIcTPJYn5at2o31Jawi5pOm3dqKcRqmkWQzjY8Arc6MHjVWdfg>
 <xmx:uMMcaNNe1z9iA8GnfMrzuFvcPuCLmNaCfKBszVIJN5g2EN-sNtiuJg>
 <xmx:uMMcaCmOT5Mdm6irRPqDFqFYUoZQj2AtqXIe-Hq630Umj9rJAb6I9w>
 <xmx:uMMcaPvuAUFbIoDTieDyKYZVV0S3rp_oq-Lq-dF3IueUu3YARtHjVg>
 <xmx:uMMcaPheWgwcPJz8pJoX27YRcvjfVraD-j3Y7V4cYeI6-WxfDpipX7J7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:46:15 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 08 May 2025 15:46:10 +0100
Subject: [PATCH 5/5] hw/pci-host/bonito: Add comments about documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-bonito-v1-5-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
In-Reply-To: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=MU1PXw79l+PqaNzCUo78gxclfibVJ+777pGeiHAtmdo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhgyZwxtObTwRZb/lyJfMk1li2rKRJ93kV+U/nhq4d98sk
 3INPrNvHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRlEuMDN/3+Za1HFq549mL
 5VkFPFFfWVtCy9MFj6UUupzmmPUmZzbDL6YTrAe3eTx+suPf24nH4w9pa8U/KG5RkH6wqsjO5U1
 OADcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b7-smtp.messagingengine.com
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
 hw/pci-host/bonito.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 49b4be26393a08eda4f99c8e2ef8a0c455c57bc0..918ee39661004d902d2deb25dd5e782855a11854 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -1,5 +1,5 @@
 /*
- * bonito north bridge support
+ * Algorithmics Ltd BONITO north bridge emulation
  *
  * Copyright (c) 2008 yajin (yajin@vm-kernel.org)
  * Copyright (c) 2010 Huacai Chen (zltjiangshi@gmail.com)
@@ -8,10 +8,21 @@
  *
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
- */
-
-/*
- * fuloong 2e mini pc has a bonito north bridge.
+ *
+ * For 32-bit variant:
+ * "BONITO - PCI/SDRAM System Controller for Vr43xx"
+ * https://wiki.qemu.org/File:Bonito-spec.pdf
+ *
+ * "BONITO - Companion Chip for Vr43xx and Vr5xxx" (uPD65949S1-P00-F6)
+ * https://repo.oss.cipunited.com/archives/docs/NEC/U15789EE1V0DS00.pdf
+ *
+ * For 64-bit variant:
+ * "BONITO64 - "north bridge" controller for 64-bit MIPS CPUs"
+ * https://wiki.qemu.org/File:Bonito-spec.pdf
+ *
+ * For Godson (Loongson) 2E variant:
+ * "Godson 2E North Bridge User Manual" (in Chinese)
+ * https://github.com/loongson-community/docs/blob/master/2E/Godson_2E_NB_UM.pdf
  */
 
 #include "qemu/osdep.h"

-- 
Git-154)


