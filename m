Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E12E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHE-0003og-Km; Thu, 26 Dec 2024 16:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHD-0003oJ-Ck
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:15 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHB-0003C1-Bf
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:14 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C2F3F1140192;
 Thu, 26 Dec 2024 16:20:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 16:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248011;
 x=1735334411; bh=PUVE1pSS+sOSIryhoVTJh6X+Hzy5tNSPJV1bnADnqgo=; b=
 TREBfV5ggXjKH8XIxJ7pbpb1KxWuD7KxaR8kmyL5En4oxAvC1BdcXU+mcmZOgpg1
 UjCFZSuxkalH20BeCKnLY7t9ZdngkslFeoYgqrDObeQR3+27w48jxXyc/lkFvljC
 iQGmDJovZOP3uRuQSYAz4QQS0r0RhPI3DlGk0mtqKg+sM7HTLdLZYGZLTB3ezOtk
 c+4q4ktc1hDzVDP2v5mxQEOQ3Tx0b5yDJvV1aGeskJxOlJtnD+6A8oFc4MGYtWE1
 1Hq9O8zLwK7dyiHvWXkm0PIz6jlDlySLHMuzcJwZ6vpxrLLTCzl70G/2eAkAcnz4
 nAz/nKbivskH8fHzXWgtKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248011; x=
 1735334411; bh=PUVE1pSS+sOSIryhoVTJh6X+Hzy5tNSPJV1bnADnqgo=; b=g
 YT1sj4CAvKlWG3v6YAfnKUM0XouN2o7NLTX4p1Ig6+eOucygUNvLsO+7lx3Dsz6p
 1aV6edn7GBkbJKixMDrIaRYHwpbXYRV9So9QP8uDx6L1WCORuxLNCeIupvr+SFNa
 b6dC/XU8hnSiJxLp8R9Yap+MkzWJKD2Cn8fNgMaesqMTW6S33UMJGfYASOAKz1sA
 JlTg5GghCio5Kj4pXvDvxmFWQmpdu2FOsRGVVCxkj/EwwMif35b7IAa0FDHYYa2Z
 e1+xs7i5Z5s5KJpAIzecZz3sSErcwnr9lRJ0rULxPRzoWoEtBaT44iwng5J6xlPp
 HNTzr2HOgX1GTcqGhVVXA==
X-ME-Sender: <xms:i8htZ0ZxwTRrenl9fMXWQ1uMRchL7LA1Z7NLAzgHRM0fRZaeONE4TA>
 <xme:i8htZ_Y6oKpKDSHjT_uigFvU18N6Hez4NlPQGsObYqZpIh54TZdIAESi49M3HXuy7
 D2v3YIJ6_cAHeZjg6c>
X-ME-Received: <xmr:i8htZ-92WkFQHZGYGP7ADXDMO0CSRWbKY2FYjzCfMMaOvHQIStiHARbD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghrtggv
 lhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopegvsghlrghkvgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigrnhhghigrnh
 grnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:i8htZ-rJlkWod37vkg3boeeRP0Bd22l5N_aGlVQdjuu8nwCSzmfBVw>
 <xmx:i8htZ_r4l2bAo7G4n8h_4nYHPSPouhd2H_D9Dv2ZBmOlWRF6NiDxNg>
 <xmx:i8htZ8Q6xAstjJ0mrE5TEg_cdFGdVn2TvP-zshRAxHFlWaYQ4OO1LA>
 <xmx:i8htZ_qupuZX3J8ZRXsg1hfLfJgKICOJauuims63boDJVPC49ocm-g>
 <xmx:i8htZ9hhpI3wWQgEoKOTgoeBRmOBO9H_4qxiWji-D41pxTh-H6AMidxT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:10 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:45 +0000
Subject: [PATCH v2 14/23] target/loongarch: Scrutinise TCG arithmetic
 translation for 32 bit build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-14-0414594f8cb5@flygoat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
In-Reply-To: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2974;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6W6xZHMD9TUqnyCi3WqD0AQhiiXReR5lG9SU3o/mijs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9mfp9wJ/OV9u91VaXvtmuW1kfvm3T1u/vrTkoOPV
 xfavn71pKOUhUGMi0FWTJElRECpb0PjxQXXH2T9gZnDygQyhIGLUwAm4rGbkWGf9oTChQr6Rl5l
 ZgtXqipM3RzteUL88drZL+eu6isyedvGyDBLJadYXcc2eV6hZ3PgnD0nDoj8mnwnKM+4ZNZTfZ3
 ll5gA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a4-smtp.messagingengine.com
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

mulh.w and mulh.wu are handled with tcg_gen_muls2_i32 and tcg_gen_mulu2_i32
to adopt different TARGET_LONG size.

min value of divisor is generated from TARGET_LONG_BITS to adopt different
long size as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_arith.c.inc | 25 +++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
index 2be057e9320a9b722c173b0352e1631543147d68..a2360c5fdd2003ca0e458743348e687987f421d4 100644
--- a/target/loongarch/tcg/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
@@ -92,8 +92,24 @@ static void gen_sltu(TCGv dest, TCGv src1, TCGv src2)
 
 static void gen_mulh_w(TCGv dest, TCGv src1, TCGv src2)
 {
-    tcg_gen_mul_i64(dest, src1, src2);
-    tcg_gen_sari_i64(dest, dest, 32);
+#ifdef TARGET_LOONGARCH64
+    tcg_gen_mul_tl(dest, src1, src2);
+    tcg_gen_sari_tl(dest, dest, 32);
+#else
+    TCGv_i32 discard = tcg_temp_new_i32();
+    tcg_gen_muls2_i32(discard, dest, src1, src2);
+#endif
+}
+
+static void gen_mulh_wu(TCGv dest, TCGv src1, TCGv src2)
+{
+#ifdef TARGET_LOONGARCH64
+    /* Signs are handled by the caller's EXT_ZERO */
+    gen_mulh_w(dest, src1, src2);
+#else
+    TCGv_i32 discard = tcg_temp_new_i32();
+    tcg_gen_mulu2_i32(discard, dest, src1, src2);
+#endif
 }
 
 static void gen_mulh_d(TCGv dest, TCGv src1, TCGv src2)
@@ -113,6 +129,7 @@ static void prep_divisor_d(TCGv ret, TCGv src1, TCGv src2)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv zero = tcg_constant_tl(0);
+    target_long min = 1ull << (TARGET_LONG_BITS - 1);
 
     /*
      * If min / -1, set the divisor to 1.
@@ -121,7 +138,7 @@ static void prep_divisor_d(TCGv ret, TCGv src1, TCGv src2)
      * This avoids potential host overflow trap;
      * the required result is undefined.
      */
-    tcg_gen_setcondi_tl(TCG_COND_EQ, ret, src1, INT64_MIN);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, ret, src1, min);
     tcg_gen_setcondi_tl(TCG_COND_EQ, t0, src2, -1);
     tcg_gen_setcondi_tl(TCG_COND_EQ, t1, src2, 0);
     tcg_gen_and_tl(ret, ret, t0);
@@ -275,7 +292,7 @@ TRANS(sltu, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sltu)
 TRANS(mul_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_SIGN, tcg_gen_mul_tl)
 TRANS(mul_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, tcg_gen_mul_tl)
 TRANS(mulh_w, ALL, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, gen_mulh_w)
-TRANS(mulh_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_w)
+TRANS(mulh_wu, ALL, gen_rrr, EXT_ZERO, EXT_ZERO, EXT_NONE, gen_mulh_wu)
 TRANS(mulh_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_d)
 TRANS(mulh_du, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_mulh_du)
 TRANS(mulw_d_w, 64, gen_rrr, EXT_SIGN, EXT_SIGN, EXT_NONE, tcg_gen_mul_tl)

-- 
2.43.0


