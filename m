Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C4C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmizr-0004ZZ-EU; Mon, 24 Feb 2025 19:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizn-0004Wh-3y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:23 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizk-0003Rq-Tw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:22 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id C84E011400C5;
 Mon, 24 Feb 2025 19:40:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 19:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444018;
 x=1740530418; bh=J5Os7FcfxuL0lY+KefWBE+pEYPFluDZ4pINxkioG6GM=; b=
 RRWCfP2uUjs9AqmIkrB0Vjck3laluVjxYgKRtp5fkvFwJjE+BLP4styv92lzNHWD
 Ggf+Sv+MvtYARy9VlaVnCrNAd3jliiUGE2v97ZfDU4y7utBD8OqE7UNrgc2B6S3N
 cE5Q6wiHxesbnD+gqRQF4PbKZJ773wCbtEsrx4KUom3+vBOjHqhO18Lj6yyTdfiD
 cLJUpp41qM4QIfaxVkOKtZMnRdWn4t859mkMTLPlr0f/VviywlU6UJ9o46Cot7QK
 L476krKI1iKYQQInwe1Y0/+NWwnjdoqQROKKoJGpUB/i2y7Awn0OTFuzxePr80r6
 sBQk9/+QMMAOCS+p40QOdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444018; x=
 1740530418; bh=J5Os7FcfxuL0lY+KefWBE+pEYPFluDZ4pINxkioG6GM=; b=q
 iAWeWHue0euJ1fT0erGDcECnl2NzRzyTqq5ziHBSlUUtlGxvOAXwuHTt0pVzwUU1
 5K+c0JyKNQOmADkChwd06ZtlbF5C6iG1QCcWgLWjG9iPmFeTpwUCYT0xEWLQiUnb
 F+RTBC4lSPFwCF3THh46cprxD0QfTdzeU3COWkaNyo02R2ZU3562ia5nDJfHPOEG
 6hBIY3LO9562dE6Rsg++XiTlOWyyZvupa+JciAHoUyFMRSp2lhHPZ6Y5wyXgC2Or
 /pxIQhbBZ2FjT0RsZIQM6wiUJONdWl42F7VpUMyZevxOpWBPCd4qL6YrAIPl8j32
 blq9nizcwjmUvsG5ov/gA==
X-ME-Sender: <xms:chG9ZzR9iBw6asK3HOnnGWhaTov_7_ltMt-DFXVT1eVp7gGgR2vwyg>
 <xme:chG9Z0wjgJJZo-T3FeQDMwsexqyWFo8FKziznokgjGEt7uX6QOKeNpo4r0botJ-yN
 e7oacQQ6BxBsVljCE8>
X-ME-Received: <xmr:chG9Z42ntemmipReE2ze7rlq2yyi4kPgn6DLAkcvY7hDSSOboSTMGgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgr
 ohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:chG9ZzBxwLfoXBp9-VsPpiCNjMT1M0lbbMPi8GEbgVAwpuIBY6sHVg>
 <xmx:chG9Z8gVJVeGljrzpPCzU-AS6W-5Ckftpti8oZ0aSuCKpRNpu22i6g>
 <xmx:chG9Z3qSonE4AgfQIIKlXK5CYJV4jK_xAMx2cmgyUa0_VUMGWJG1Ow>
 <xmx:chG9Z3iL57i_C9stMnmnnReIETAwNVteinZCaHbb2zRIj201QNrxSw>
 <xmx:chG9Z1sNOXZZ2BU-UY8cmei0XEmB0XwmIUTyEFUTuQ5UlBtf75yRMKCS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:18 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:14 +0000
Subject: [PATCH v2 1/9] target/loongarch: Enable rotr.w/rotri.w for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-1-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b6-smtp.messagingengine.com
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

As per "LoongArch Reference Manual Volume 1: Basic Architecture" v1.1.0,
"2.2 Table 2. Application-level basic integer instructions in LA32",
rotr.w and rotri.w is a part of LA32 basic integer instructions.

Note that those instructions are indeed not in LA32R subset, however QEMU
is not performing any check against LA32R so far.

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


