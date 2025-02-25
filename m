Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0186C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmj0Y-0004rZ-5l; Mon, 24 Feb 2025 19:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizq-0004ZD-TT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:26 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizp-0003SS-4C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:26 -0500
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 323352540126;
 Mon, 24 Feb 2025 19:40:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Mon, 24 Feb 2025 19:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444024;
 x=1740530424; bh=xq7uqmFNSO+Bhhp9oqXUJHdfuDZb5OWrQSgSK4Sc8OI=; b=
 dZx0go4aNwN1MDN1harSRUdVKqr/3FGWincpXHoOWgvgnZEWlaf0GeC9bzZiNiAA
 /Dh9hbUhxnR0ZyfekYYcbfl2dNm6niczvTw4rVB1Obbp3ocRxie8NHi2Kzr2C0Hg
 j8oNbIotwGxXX1zsc5m3Hc14xAAL/Una6lJJWfa3F25wrKHTHlyN/w6ZaVl7cspQ
 ecUu1Hk2pWBfyj6kXDGMbarL71onnr9sl1kBjYK8FrqWU70Q0J3TxrOV/rfoDZr7
 x5v1iarSEndqKAFQ8G+VbTmm70+GtgqqKa2rENZiquUZXF4QUUEDgttW5BY2a5By
 kzkui86hoqrUOScZqnY1pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444024; x=
 1740530424; bh=xq7uqmFNSO+Bhhp9oqXUJHdfuDZb5OWrQSgSK4Sc8OI=; b=V
 ehTQlMuvosEER7ngDpQrjhw7AFmmyi3UBphXRtSZAi/fG8HPmWn/P9d7KXfS/W3k
 1WHJslAWYcK7y/cEzXCaj3M2guAIiTU69btlwtdf7YdvXRRHZqaL5+un7+3MOLb+
 mrNkKPpuUJ0bnRaXdiccxNcuGUx7n7wqgFrXqDzbeSpYSJCDyTAHnA6A834+mW8P
 xQhz1m1bPBj4+8IDFw8BCcJ9mGT/upJ6VeLcxxynZZjufhaD7xKU7v2zaIirkY1v
 8csgiyjpNXnkxziOEJvbEZ8fQlWir1j9G9bJqeL/587qSqZK54/QUhOcw0hzJaNt
 8Al0CAYIqf/TaFgCGSfKQ==
X-ME-Sender: <xms:dxG9Z2KWhgqnMmuI5mGXhXqBYIK-dPs6RMKAbv7Bb5LoNLQfuj7baw>
 <xme:dxG9Z-IvuExHxga5ero2XAkFOKWAGA-unzxQMDHHLLlYcco-uvc-x8p28LH-TN4qd
 K6zLt0bvdb8LLnJf1M>
X-ME-Received: <xmr:dxG9Z2vHKT0fhQzeTM83oXHJJClOlz3k7rgsCYsHoaA4anHB5_qJy7I>
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
X-ME-Proxy: <xmx:dxG9Z7Z2e3kVvVOy4_YupAsHQ6IQnQRHp5QPl2GW9YKLN5mkNc0rQQ>
 <xmx:dxG9Z9bTRCa2sASJrAiqrWIHfVTSGk31Do5mBFNI6TJq2dEG9Xb90Q>
 <xmx:dxG9Z3ASz3-dmYJ7KpIWAXopj4DNmaZyCa6yd0N0x6h4joxgSUpG6Q>
 <xmx:dxG9ZzYLmQdUP6-mRmNzGL5EQPxxkS91cK5KwwMDa6RroKTLIQzZWA>
 <xmx:eBG9ZxFW_TUjDnArmHgVUTnRvffB8o1d54-PlZdmb1H98GjYXTL0cs23>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:23 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:19 +0000
Subject: [PATCH v2 6/9] target/loongarch: Fix some modifiers for log formatting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-6-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

target_ulong -> TARGET_FMT_ld
vaddr -> VADDR_PRIx
uint32_t -> PRIx32

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
 target/loongarch/tcg/tlb_helper.c                  | 2 +-
 target/loongarch/tcg/translate.c                   | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index c35f6f3ce47877ab6ad84fa2cbc50b46c0b23ad1..8584441b543712af8a56aa234c90fd6370c8df01 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -56,7 +56,7 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     if (a->rd != 0 && (a->rj == a->rd || a->rk == a->rd)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Warning: source register overlaps destination register"
-                      "in atomic insn at pc=0x" TARGET_FMT_lx "\n",
+                      "in atomic insn at pc=0x%016"VADDR_PRIx"\n",
                       ctx->base.pc_next - 4);
         return false;
     }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391338ba4b76115b142fa76d89e45cd62..a1426b46f36c99e300ab924cb487875ec21ab226 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -517,7 +517,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "Attepted LDDIR with level %"PRId64"\n", level);
+                      "Attepted LDDIR with level "TARGET_FMT_ld"\n", level);
         return base;
     }
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 1fca4afc731c048816618d87610a0cc0fe7579b1..3939670e18d01bd9fc08861532166882fbd3f890 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -287,9 +287,8 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->opcode = translator_ldl(cpu_env(cs), &ctx->base, ctx->base.pc_next);
 
     if (!decode(ctx, ctx->opcode)) {
-        qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
-                      TARGET_FMT_lx ": 0x%x\n",
-                      ctx->base.pc_next, ctx->opcode);
+        qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. %016"VADDR_PRIx
+                      ": 0x%08"PRIx32"\n", ctx->base.pc_next, ctx->opcode);
         generate_exception(ctx, EXCCODE_INE);
     }
 

-- 
2.43.0


