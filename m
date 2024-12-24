Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E155E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 14:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ5pS-0006bq-9r; Tue, 24 Dec 2024 09:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pQ-0006bc-Ef
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:08 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ5pP-0005Kw-0U
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 09:24:08 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id D052B11400BA;
 Tue, 24 Dec 2024 09:24:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 24 Dec 2024 09:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735050245; x=1735136645; bh=lk
 E6mkgrjtuEEbjlS/Yx0GmZWPR2XtIWhgtYaHpI/Tw=; b=HMx6RTloxE4VevaRDG
 458uDBULUt6wjjAMCDHLqWl7QtY6XHl8cjXqEhfCGRUQEE7RRYqGYbieS/rSqM8B
 VHYg5jbCNbY5rT6yROXmiHR6KT1IInVlBn9PFHaT4UiuzCVlK/CCH1jfu09YdtH1
 Abv2bqy/pNVFLg63sUICy/tKXPm2bRnJRYKUs70Hha0EYqV91zyq1deiqGYoxJVF
 /4rRL6E+NFX7Ulsa2jPGukmn2WPr23TNuSdrmaUmp/4Tqco+hSKbUCQBln9F4NZT
 iWSn1aQL17cF7QvSCnv3WRFGjt758SxVHlF8SfWrUkmiuaXuTg+/wdnjvIBeCaFn
 LtSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735050245; x=1735136645; bh=lkE6mkgrjtuEEbjlS/Yx0GmZWPR2
 XtIWhgtYaHpI/Tw=; b=ik5a0zjM/3aeOLGac3Zg8hCkmehGCxQReVvV5SMyJf1f
 WwHuc9AJmO9Z0A3mm6Iru/5U9byANUuOmcbxrpnK5ab7R5W/HsFRcZW4OyArvtxJ
 W3QAUeRR49PlEJViDIcG9VXYxNWoSovOU7OwjH0J8x60oJqJNndVLYGB0H1fQ5ZP
 gJ2Xcnxpe7GFqILkktVnzf3+Nc2JuAgMGYiSJnACvotZ9nDQySmdNE5VSTNBdHVQ
 C3n/kXa5lQ55MSknn+7l0iny1c1RLIvDhYTK0nlnKH4IiIET1keHser8wmvABCYA
 YTQHMs/so4vyARUU3WK7PxQqGUXcRRFHKlYYnzC7Sg==
X-ME-Sender: <xms:BcRqZ8lanQF9JbxI0MmHu21FHTU11KLQ1QtsRxZba96Q25MSzU-wEQ>
 <xme:BcRqZ71Z0lZbdoOo-3bUoKvqmO3V6Vs7szH4lho5jF37wfO_aZ5axmT7kb8gBbGy0
 THpBYwhkRrf5Pk5l2Y>
X-ME-Received: <xmr:BcRqZ6pbzItHD0KUYVxqCjoRms45aqxntziSCok0NycwrGOpPlmAy2Ua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeu
 gfegvdeuueejkeejteekkedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdr
 tghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtph
 htthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohep
 mhgrohgsihgsoheslhhoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:BcRqZ4kv-VEAgKBck8odYr2VrqhRQfBShLcV4sUzVCFwyE9X1XQL4A>
 <xmx:BcRqZ60XXqQJg3af-yJleWqVhQux64sneX9zNHKfN01NOF0FKqemUQ>
 <xmx:BcRqZ_seuN96Tt7HicLixcFE9LzUVAZebUSi0MgU2braHgds0tRVsQ>
 <xmx:BcRqZ2VEPFk_2Nh1HSaV1EItVwuTTp_C9IINv_DWoR5QGHu5wnr78w>
 <xmx:BcRqZ9QayuEpxgsNKo9wLrXsUROJT7nyyrEH_RORnzp4M0JQ10lJt89T>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Dec 2024 09:24:04 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/3] hw/loongarch/booting: Booting protocol refactoring
Date: Tue, 24 Dec 2024 14:23:59 +0000
Message-Id: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/DamcC/03MQQ6CMBCF4auQWVtTBmLFlfcwLFo6wCTYmrZpJ
 IS7W4kLl/9L3rdBpMAU4VZtEChzZO9KNKcKhlm7iQTb0oAS2xrrTixaGO8Tu0nYi722qLRSnYR
 yeAUa+X1gj770zDH5sB52xu/6YxD/mYxCCkMjkla2MQ3ex2WdvE7nwT+h3/f9A1pt4IqmAAAA
X-Change-ID: 20241219-la-booting-d6d8427a7790
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1+wvide4/TXHgPFmiMc1grRBJWFJH2m+Hfp9L+zWyiU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSsI6xSC27W2yk6z9nSJBu90TFY09shwbN6h8JTlWkzk
 88/b63vKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgImkizAydH5es9czKP37opt7
 F5vbVmucZu78x396s82qWw+zauxFvzAyvF01i5nx3/Qn61MVY6fmWFwtOnPV/+eey2qbPnvf/fr
 pFSMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b3-smtp.messagingengine.com
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

Hi all,

This series refactored booting protocol generation code
to better accommodate different host ABI / Alignment and
endianess.

It also enhanced LoongArch32 support.

Thanks

---
v2: Fix building on 32 bit host

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

---
Changes in v3:
- v3: Split PATCH 2 to ease reviewing
- Link to v2: https://lore.kernel.org/r/20241222-la-booting-v2-0-bef2ea7d3b32@flygoat.com

---
Jiaxun Yang (3):
      hw/loongarch/boot: Refactor EFI booting protocol generation
      hw/loongarch/boot: Take care of host endian for boot code
      hw/loongarch/boot: Support 32bit boot code

 hw/loongarch/boot.c         | 323 ++++++++++++++++++++++++++++----------------
 include/hw/loongarch/boot.h | 106 ++++++++++++---
 2 files changed, 295 insertions(+), 134 deletions(-)
---
base-commit: 3e9793ab01904144c204589811e0e879109a9713
change-id: 20241219-la-booting-d6d8427a7790

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


