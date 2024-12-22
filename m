Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B6DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 23:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPVYy-0000L3-Ez; Sun, 22 Dec 2024 18:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYn-0000JO-C3
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:33 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYl-0006BH-8T
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:33 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 5D074138015F;
 Sun, 22 Dec 2024 18:40:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sun, 22 Dec 2024 18:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734910829;
 x=1734997229; bh=Fqcq7mm54RnYVYakDA1tBHL/YZxGrFp1d66a1ou16Kc=; b=
 bv48mN1GgRf9QFVwezUlVb0bOGCMRXAYC6tZSK5y2oWG6yBLpRe0bR8WJ3JlcKYQ
 KftzHfUauJxeMgGlYuVOceTEpPh61Nji8iVyUwmy42f/R9v6rbTceoO6saw5ei8u
 DqkTtovkyOaHbg0kkIVAU5blShmzNqoI2/XfEkvsLpYIo4FBK2dZM8uuGJNkIev+
 +qUnl4MnmIw6L2Wd42a1JTxc8Jil2TDMnI5qrGuaXfol8Ojd00+kll9KzR5jss3W
 FCP/2a54Ci9M8J8/BUBa8eEJftQHxlF2yF8Md4PFCnjNTKQpKL3VKvSPyFotIdgd
 gN66ZpikPiSRQ+sEQrDU+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734910829; x=
 1734997229; bh=Fqcq7mm54RnYVYakDA1tBHL/YZxGrFp1d66a1ou16Kc=; b=V
 vQg/5K64ISezYS1ezd83PtKHjxs8HxrwcjycvWirZpPygtHaq/zWqUdbywXB/SZR
 0sE7LB5pdKBOf/kvHBzkD8YTRfToyo4GzYe+sDb8fyEiX0I4GeoZS94FQRBiMtlF
 nWVjOYoV1bly2J10mmtV4ZdJmO6AjsUuBCKhdICf+TJqrWHbVYBdaCaSF0iR30Fd
 UeUteWZSJMyr8VaOvbQSa2TmBvBNbl6mW5wQZ/4SX6zBbNgwx32oNbr9CuIqhTQs
 8fCeYuQG0Xkij9hN08yqeevE3Ubx/qwa5LVPviJ60R/IA1FkXswmylTdYueOWbmP
 esSbNv6BSknAELkRdOztg==
X-ME-Sender: <xms:bKNoZ5YOU5X0KWp3vu4XOjv7FXY44ot9_sRpE6kv5Xl_qFuboq213Q>
 <xme:bKNoZwYWtgF6W2g-XrOp6fgirRZvLJF9B3mTgSPV1wND72_TC_emzuyLFwncjD2FB
 8W2UK-kxpPq8DKpI3g>
X-ME-Received: <xmr:bKNoZ78cOct_rqze5RWqfOOBuq7LXXoIz-1sulHl9j04udCT12qCAu-q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledguddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslh
 hoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:baNoZ3pDHD4ISGrUZQiUIULZJKPMc0-l0c4i4ILDrvuSyGfHUFwM0w>
 <xmx:baNoZ0obZBMsKXT6RFU5eS239GxZdogMZNWwsmysVSLcXaGzg346cg>
 <xmx:baNoZ9S2Qgfx_lXFSk6A_2ClPRispdK47BFX5rPaU0SoNc_xtKLfDw>
 <xmx:baNoZ8rht92uzoDymVVFj6AwCX2cr_mw4Jn_B2p43D5rF4cxcCpH_w>
 <xmx:baNoZ_Wic10PP-VQKPVzUPStYgh9g1PYGKh8qHgBotYhpoBqBS7eLecO>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 18:40:28 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 23:40:25 +0000
Subject: [PATCH 1/3] target/loongarch: Enable rotr.w/rotri.w for
 LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-la32-fixes1-v1-1-8c62b7e594db@flygoat.com>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
In-Reply-To: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=2VUWVkFWQi0x23wCvKOUTz7tKvfz5U3tOhLI7LG7rEw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSMxVlvKl2WXBGOrtn0riFm0tkNhWIuFrPNLjSVLZ6yX
 LjoxJqejlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhIXTrD/xCTudLrTfef35ep
 yxjxdOPU5fvvlJy+/17ri1KPSh7Hs70M/z0MW9VbOgUXugrz2Zzul/jW9Orxu1XGWZ9uLGA39jR
 s4gYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

As per "LoongArch Reference Manual Volume 1: Basic Architecture" v1.1.0,
"2.2 Table 2. Application-level basic integer instructions in LA32",
rotr.w and rotri.w is a part of LA32 basic integer instructions.

Make it available to ALL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 377307785aab4837bc181f1691632e7970a9889d..136c4c845527f0e63902a8306dcaf136dd4dd3fc 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
 TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
 TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
 TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
 TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
 TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
@@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
 TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
 TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
 TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)

-- 
2.43.0


