Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0015606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D95GQesB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAL-0006Xn-2G; Wed, 21 Oct 2026 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9A-0004lC-S8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:34 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX97-0001aU-Oy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so710611f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592303; x=1793197103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u3Z7OyRFHPHjfXOHJ+jFlBbeGREx5gLWvrwqK6K0NUI=;
 b=D95GQesBMZ1/XNFSzHLyLmWw53jqXF/7JvReOfjra0gmTxLiGizFkzhcgwQGShe9qz
 hvoQjOFdJKeIK+Iwby2o94O1DbA9E2pF6k5rHYBegpXxg0UDb13tUZRl3aVmefsTlq42
 tPzeayl3sJynIy4bQqNwF6Njl8Gt4s7DtjM/FsdOzccvL6kCgXNoFr/gbGeW1iLM5qhg
 223rCrJf0aqF3ioIf1JhEqab5qHE9yxjldGBBYCtZfIYhG8lLvDitPvm/7QNeGsdbQYc
 dd8cyOXqtX7mHskeCXVsCbx4sBviy7hgJHkhuVcMHIkIzpjn99Gem4byPYy1kMLEZFO6
 CcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592303; x=1793197103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u3Z7OyRFHPHjfXOHJ+jFlBbeGREx5gLWvrwqK6K0NUI=;
 b=0rIPdH5LFY263sVeQnWsjji6w19AZ41Bkgddnbd2orVG3F90Agv00IbiTrtxD+LLRo
 anQUwdAgd0tIIMIjkaSpq7etXyT/A4To3Si3CvGF6eYtNswiuRg4mp62zmNVTwysqMNj
 6HJPvQd3OItQC/zUPpXrnSE8u+XDlAeSTv8Iivm3WUQsH8WkfR95gWJHdqpibToVMU3q
 HbD7uhZeO24PzVo87Nl77EJ9W+QgHEDf5tNOFA0dkLhuvmsfXwwyKqYji/qXlwVaVr2b
 PieYI/bILLjZJ0Cr1LTeONzEBMk+/wb1uruPbbd4X/fO4e/RD9F7ZSQJFjasIObX4NA3
 GOdw==
X-Gm-Message-State: AFq9FYL047pKJN0vsQk3JfQX94pB+Ztjc9KouWPMzaZKUG13pBClarnp
 fAwLsKoYxOtkGZPUpMy80wWwlufvV27cw5Wm9oma6G/3qowLNEZoFgfTjLicEfICUN38fWrnz1g
 lSR8eaZY=
X-Gm-Gg: AYBFou1mPY2CqwaFNRUc56LSD8v9QL4XCAby68nB7Wt2YU8TKWNKOtAP2qiuM3l3lzV
 E0ZfWdM2dQ9p2op/vZaXQqqLbVsFggCSMtwvdhxUCATl6VtN28LTXOo66yfFvLBeBouH75B5BeV
 VtbewbM82zAGEZpNicrRexrwaygaO8jxzYwHZ34rcrE9CMoU4KYbLWAs6TAUN7qL1/9mFca2bL8
 fnFSHR3FYEyDnA0zMLVb2zVLinNrPJwxjQXyLj/KWCatdqn7OtrDlXpS6/QlxQ69D+CoeYY1bSd
 usktLHQF9ftoaX2WoWVl8QRewql1lwSVh9wFNJaCsLnLbjm2wLhQu0Buh5j4Jtby9W3EeSd9ox7
 kINmEFY+eKeVrNxUsk8NEXB0ICXC7xDIBZ3Qe2ZLYa+kcGjW+G935x+cY+OeLotI2ySoehYaDif
 HMd6LaRffqZjP0w7lmbIFEuqsbnzs+cIIlgyVT0NfVHNxWvGDxLYFKsznGkU+1c8WUkmHMrx221
 6NxwFESrIcIkIjwI+rBJq3LN9rS+g0m7lsJ4nSH7FB3dS24RSS2bljTbo/U4hU4QkGICIS15qiB
 JemfT6iZawJYxqpHcz777r6XeCnxvLkr2AO8VcT9p7/02tfX
X-Received: by 2002:a05:600c:3b17:b0:4a1:fb2f:eff with SMTP id
 5b1f17b1804b1-4a1fdd3a0abmr51629415e9.18.1792592303015; 
 Wed, 21 Oct 2026 07:18:23 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 025/100] tcg: Generic expansion of tcg_gen_sari_*
Date: Wed, 21 Oct 2026 16:15:37 +0200
Message-ID: <20261021141652.363109-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e0a93144cb..7ca448b922 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ea641158ae..2108082ce6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b3f688228d..8c298ae79a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -419,6 +419,16 @@ void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -540,16 +550,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


