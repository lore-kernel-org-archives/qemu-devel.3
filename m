Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B91C88E64
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aEt-0002GS-HT; Sat, 12 Sep 2026 22:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEM-00012o-Lu
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEK-0002li-MM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caced6038eso21451065ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267567; x=1789872367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=peMxRXLmjGFHHFpoRpREeVZ1QUty/aG4EzAXvBC0g7M=;
 b=nk9twgwpaD76vnJpVXxv9C9MXvD4MYWPMIYp6cVjVe8tCi0dQj3efbRnOvn48eyBlD
 kMMM0lZD0W4eu/fpChP2oFR7MX43DVn8ix4LAWuY3YEtz60zd2Yms2uBZv9KF/S6e/Zo
 2o9hAHaLOSN1bIA6t9sHoYiuKtMKucNVR4Zl3sAeRxwWBQ4q6tZoLPllI98ZQV40+c7m
 54+WMRnf7JlNX/E/8yLEOXjjfXh9OKxBZ1DS/Lo7UfULH09FHIR/rLaH50h4i9DVyoa5
 A3PrgU2E/r/3p8o4RWCVZo/OO291cvf0EtMAabU1A36KJgapaPdBnA6h5nfBBSF8xM4A
 h05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267567; x=1789872367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=peMxRXLmjGFHHFpoRpREeVZ1QUty/aG4EzAXvBC0g7M=;
 b=JcgOxxxnth/dESqeIN+A0dzaR1PNrmlMxQiLuMflyzDqQGkpciNEBDKUG3829JRixZ
 XudUbgT+odQ7eVjFbofjiZf8rXgJK/u59yH5mod4clDvb9mwTd2DZWLXSl3jVEGVYy+c
 FzCINM4so1umCXgdthvQ+H/aF5VtqwmcLWKgcl0LVVQfGheBWgXlESaHBZLuo8MHVwQ+
 RJW0D+AowOjIXlPrivk1WsW9zJEmW/nhh8Ky28pYO0BAoVxGnibhIJCCFFIJUX0kMAKe
 BJFRk8Q1QvR0h9SU0ax8kHwuzTO7d6IXElDXtqIsyXsZmOQzBMXfsKwMjkjHSvH0VyIY
 JKmA==
X-Gm-Message-State: AFuF++mxL3Qx7Wt1+1+Df43PM+w2iwEInvcqA5JfO/ugZLJaNqG/dNCm
 9StbNQNUtnWpUq2OIxSdGBEZilYfIv6eDpRFgRmgdYs6TVhSBE3Dlinmq7T6qD1t9I6toO8LYip
 csmR9l1Y=
X-Gm-Gg: AYBFou2XYM5km4avDDO+8+aLfK1HR2fRLjT7eb8LVYIrFv1ndk7nMQqG6uEnYt6yqTu
 qIugOJjMt5bJkHEARHUxT5FeUxLKe84kc92qG1Vcc8J6/pS7qeTYrBI7juMAatSJ+Zb/c60NF0u
 94tTL1fjltZpVTYl2yZO8LTLacbgvZKZJCrmnDj740iilIVoDUslTrn8mMb1eUzgaLrjTAY0KUt
 ySHd8ItmD3XAD/VAcQPrMHXoV3wwg6ZbHwunGRVsRZFJ48ss9x/kw2lukKUUQVaWAbawO123Z2I
 B9bqRXE+Q+KEmdFBECQ5mYzcB/bSh10OTXiMRp1TkFbSG/RpENfvNXmx6akJoIZKh3B2txMRbky
 ZwdbXO/QT6yZSH0kfezRfi3VfaCNLPCClJDS6uTGJCS1NW8UZjxcRIYdjq+DtQ99wacJAFDN2L+
 onvkHoreyjQErbE5U0tMPMUlwSS9mq+ci1bod1EkhA9HgwmgYXrSUz53akSy+EQOvLAU8F1+1YN
 nLLAymk
X-Received: by 2002:a17:903:2352:b0:2d9:2b1b:878a with SMTP id
 d9443c01a7336-2dd5f0a8a92mr7992475ad.10.1789267567063; 
 Sat, 12 Sep 2026 19:46:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm17811679eec.31.2026.09.12.19.46.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:46:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 80/86] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Sat, 12 Sep 2026 16:38:31 -1000
Message-ID: <20260913023837.741866-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 86 +++++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e087737ccb2..9e49d29cd03 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -157,7 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5a472a910c6..75ada0d0473 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 26c92f5b27a..89fbc21709b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -135,6 +135,13 @@ static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
                        temp_arg(t2), a3, a4);
 }
 
+static TCGOp *gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                          TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), temp_arg(t3));
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -899,6 +906,44 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_extu_i32_i64(t0, src1);
+        gen_extu_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    } else {
+        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+
+        tcg_temp_free_internal(t);
+    }
+}
+
 static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1311,28 +1356,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1818,25 +1841,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


