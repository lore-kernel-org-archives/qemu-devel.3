Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C6D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacQ-0001n0-KG; Thu, 15 Jan 2026 22:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacP-0001fw-97
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:25 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacL-0006GM-Av
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:24 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so753759a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534520; x=1769139320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/I60gyIokTIrbunC9gly6yzJgKVfoNKqDR47yyL6wsE=;
 b=YaEnnrQAZbEkWjtxHyrPWar3ieEMZCbf4GqGuHC9TySJOZMDFbdq8Y0SiopzWw7lwp
 YOBu23NK+dXL4tNS852j9Pjhz0/XCt+WLv+/MANSxkbNzl98iLHklX32AcA+KitzejyI
 qrxoh/gdrICyyIY5Y4DZ0akrZqCuo1TNzgiUZ6Z/kKT5ddFjrIDsj7RrnR/Rn4SsbAa7
 CBqb3dK2Qx+1Ab3KEAVZeaqYXPrA0/okC9dVaHD2lpxIvXK9xHzsuMM5xE92tfCKTOSa
 CXoX9I9StuvpOmwD3RVE4QHqkTnrtiLf2ky/NeUlhag5smrJxw4/ssR3Ag/C35I3vQIf
 NpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534520; x=1769139320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/I60gyIokTIrbunC9gly6yzJgKVfoNKqDR47yyL6wsE=;
 b=FttgWICsyFX0GnWESfmo2W8NN9VzxSkBT7cdII9YEKyrCnqZtf+JoFL165KW5+8OLc
 9HVyE9R4RNo94H9OL74LUuR/nt8IWuVJizanNY4ruyUxNiYNX6m9JvTLP77A8GAHDCzd
 1/tykQP3SlmftaeUGuCJrr+KigDh00wvZGzCAO+sGxXVbnzQ+BqvzeFMLBCTfolHogpB
 m8ipXWyFB1Os2I6lbEtreKkkyp58dVr5Aho4GJNj//o3fMFufPl6bcvonz++zD2vMQg0
 1ktPQkEYHrKr8aq+XLprB1ugdIrxpEnmR0JYaMD4gdsbEeaUpsj/PfxX3yB5bGq4Otma
 7fww==
X-Gm-Message-State: AOJu0YxupwEIHJ0Pt38hkYW0LMcG2Esg9uxUSd10iRxHDgK5T/4QZW1l
 MoSo6gutUUC5JBxT/wiQCgXa9qegyb0dbrChN+1wTczHQcB9IEoX4yUl2ZUAPECzU/mQw/OmpWp
 w4FBR2jD6Ng==
X-Gm-Gg: AY/fxX5U/7G9CUXjTlUUm5o4J7J2A60HO3vou0r8ccHbVrLULn/1nLnd+04QnOy5WwK
 7AfBoDDfZNFOadqnL6Cp79IwF4MMvgqmvTfO+eGlgQ7u9f9FCGh2wRZh1unEM4F/XKQSfD0XqhV
 3ImEfyNSlsBLc9fV6/tai4T5WhXmJJtau3108GZUZWTfHVwdS6rAJ29D1KLfbqJ45w920J6ADPb
 2VwHayAzqDpdUU2IKayGVAYm8MUnFT2RuM33KcXGu9vz1fjhApPt/ssYpo+IWAoN4I7cXx78Gm/
 j1fKkNI8T83jLzL6QBDFOmH4ZOWA4FmtA/8JLfSA5HRQQV0QwGrwSTcsnxNh+5ZXdj6oZGhg1YD
 8QTGbbLMsUCWFm9yGKbSn8ye2vd49g6w97AHJZiDr0QqjdRzcWuA/9XZIOK+TlAoFuHsPXbN9Fl
 edWMygmJg1Bbo/tRTZ0UIOYq4G/oIa
X-Received: by 2002:a17:90b:58cf:b0:349:162d:ae1e with SMTP id
 98e67ed59e1d1-3527327df4fmr1354959a91.33.1768534519498; 
 Thu, 15 Jan 2026 19:35:19 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 32/58] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op.c
Date: Fri, 16 Jan 2026 14:32:38 +1100
Message-ID: <20260116033305.51162-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 686 +++++++--------------------------------------------
 1 file changed, 90 insertions(+), 596 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d20888dd8f..8d67acc4fc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1154,7 +1154,7 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
-    } else if (TCG_TARGET_REG_BITS == 64) {
+    } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t0, arg1);
@@ -1163,8 +1163,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_extr_i64_i32(rl, rh, t0);
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
-    } else {
-        g_assert_not_reached();
     }
 }
 
@@ -1178,24 +1176,6 @@ void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
-    } else if (TCG_TARGET_REG_BITS == 32) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t2 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t3 = tcg_temp_ebb_new_i32();
-        tcg_gen_mulu2_i32(t0, t1, arg1, arg2);
-        /* Adjust for negative inputs.  */
-        tcg_gen_sari_i32(t2, arg1, 31);
-        tcg_gen_sari_i32(t3, arg2, 31);
-        tcg_gen_and_i32(t2, t2, arg2);
-        tcg_gen_and_i32(t3, t3, arg1);
-        tcg_gen_sub_i32(rh, t1, t2);
-        tcg_gen_sub_i32(rh, rh, t3);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
-        tcg_temp_free_i32(t3);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -1210,29 +1190,14 @@ void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t2 = tcg_temp_ebb_new_i32();
-        tcg_gen_mulu2_i32(t0, t1, arg1, arg2);
-        /* Adjust for negative input for the signed arg1.  */
-        tcg_gen_sari_i32(t2, arg1, 31);
-        tcg_gen_and_i32(t2, t2, arg2);
-        tcg_gen_sub_i32(rh, t1, t2);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_ext_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
+    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    tcg_gen_ext_i32_i64(t0, arg1);
+    tcg_gen_extu_i32_i64(t1, arg2);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_extr_i64_i32(rl, rh, t0);
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
 }
 
 void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -1414,263 +1379,119 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 
 void tcg_gen_discard_i64(TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
-    } else {
-        tcg_gen_discard_i32(TCGV_LOW(arg));
-        tcg_gen_discard_i32(TCGV_HIGH(arg));
-    }
+    tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
 void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (ret == arg) {
-        return;
-    }
-    if (TCG_TARGET_REG_BITS == 64) {
+    if (ret != arg) {
         tcg_gen_op2_i64(INDEX_op_mov, ret, arg);
-    } else {
-        TCGTemp *ts = tcgv_i64_temp(arg);
-
-        /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
-        if (ts->kind == TEMP_CONST) {
-            tcg_gen_movi_i64(ret, ts->val);
-        } else {
-            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-        }
     }
 }
 
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-    } else {
-        tcg_gen_movi_i32(TCGV_LOW(ret), arg);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), arg >> 32);
-    }
+    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
 }
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-    } else {
-        tcg_gen_ld8u_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
 }
 
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
-    } else {
-        tcg_gen_ld8s_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
 }
 
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-    } else {
-        tcg_gen_ld16u_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
 }
 
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
-    } else {
-        tcg_gen_ld16s_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld16s, ret, arg2, offset);
 }
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
-    } else {
-        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld32u, ret, arg2, offset);
 }
 
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
-    } else {
-        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
-    /*
-     * For 32-bit host, since arg2 and ret have different types,
-     * they cannot be the same temporary -- no chance of overlap.
-     */
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
-    } else if (HOST_BIG_ENDIAN) {
-        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
-        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
-    } else {
-        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset + 4);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_ld, ret, arg2, offset);
 }
 
 void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-    } else {
-        tcg_gen_st8_i32(TCGV_LOW(arg1), arg2, offset);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
 }
 
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-    } else {
-        tcg_gen_st16_i32(TCGV_LOW(arg1), arg2, offset);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
 }
 
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
-    } else {
-        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
 }
 
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
-    } else if (HOST_BIG_ENDIAN) {
-        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
-        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
-    } else {
-        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
-        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset + 4);
-    }
+    tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
-    } else {
-        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
-                         TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
-    }
+    tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
 }
 
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-    } else {
-        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
-                         TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
-    }
+    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
 }
 
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_and_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    }
+    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
 }
 
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    }
+    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
 }
 
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    }
+    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
 }
 
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-    } else {
-        gen_helper_shl_i64(ret, arg1, arg2);
-    }
+    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
 }
 
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-    } else {
-        gen_helper_shr_i64(ret, arg1, arg2);
-    }
+    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
 }
 
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-    } else {
-        gen_helper_sar_i64(ret, arg1, arg2);
-    }
+    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
 }
 
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    TCGv_i64 t0;
-    TCGv_i32 t1;
-
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-        return;
-    }
-
-
-    t0 = tcg_temp_ebb_new_i64();
-    t1 = tcg_temp_ebb_new_i32();
-
-    tcg_gen_mulu2_i32(TCGV_LOW(t0), TCGV_HIGH(t0),
-                      TCGV_LOW(arg1), TCGV_LOW(arg2));
-
-    tcg_gen_mul_i32(t1, TCGV_LOW(arg1), TCGV_HIGH(arg2));
-    tcg_gen_add_i32(TCGV_HIGH(t0), TCGV_HIGH(t0), t1);
-    tcg_gen_mul_i32(t1, TCGV_HIGH(arg1), TCGV_LOW(arg2));
-    tcg_gen_add_i32(TCGV_HIGH(t0), TCGV_HIGH(t0), t1);
-
-    tcg_gen_mov_i64(ret, t0);
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i32(t1);
+    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1678,12 +1499,8 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
-        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
-                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
+        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1691,12 +1508,8 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
         tcg_gen_neg_i64(ret, arg2);
-    } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     } else {
-        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
-                         tcg_constant_i32(arg1), tcg_constant_i32(arg1 >> 32),
-                         TCGV_LOW(arg2), TCGV_HIGH(arg2));
+        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     }
 }
 
@@ -1707,23 +1520,11 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-    } else {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
-                         zero, zero, TCGV_LOW(arg), TCGV_HIGH(arg));
-    }
+    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
 }
 
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_andi_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
-        tcg_gen_andi_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
-        return;
-    }
-
     /* Some cases can be optimized here.  */
     switch (arg2) {
     case 0:
@@ -1754,11 +1555,6 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_ori_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
-        tcg_gen_ori_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
-        return;
-    }
     /* Some cases can be optimized here.  */
     if (arg2 == -1) {
         tcg_gen_movi_i64(ret, -1);
@@ -1771,11 +1567,6 @@ void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_xori_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
-        tcg_gen_xori_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
-        return;
-    }
     /* Some cases can be optimized here.  */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
@@ -1788,48 +1579,10 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
-                                      unsigned c, bool right, bool arith)
-{
-    tcg_debug_assert(c < 64);
-    if (c == 0) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-    } else if (c >= 32) {
-        c -= 32;
-        if (right) {
-            if (arith) {
-                tcg_gen_sari_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), c);
-                tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), 31);
-            } else {
-                tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), c);
-                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-            }
-        } else {
-            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
-            tcg_gen_movi_i32(TCGV_LOW(ret), 0);
-        }
-    } else if (right) {
-        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
-                             TCGV_HIGH(arg1), c);
-        if (arith) {
-            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
-        } else {
-            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
-        }
-    } else {
-        tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
-                             TCGV_HIGH(arg1), 32 - c);
-        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-    }
-}
-
 void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_shifti_i64(ret, arg1, arg2, 0, 0);
-    } else if (arg2 == 0) {
+    if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
         tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
@@ -1839,9 +1592,7 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_shifti_i64(ret, arg1, arg2, 1, 0);
-    } else if (arg2 == 0) {
+    if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
         tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
@@ -1851,9 +1602,7 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_shifti_i64(ret, arg1, arg2, 1, 1);
-    } else if (arg2 == 0) {
+    if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
         tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
@@ -2034,14 +1783,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_bswap16_i32(TCGV_LOW(ret), TCGV_LOW(arg), flags);
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-        } else {
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        }
-    } else if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2084,14 +1826,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_bswap32_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        if (flags & TCG_BSWAP_OS) {
-            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-        } else {
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        }
-    } else if (tcg_op_supported(INDEX_op_bswap32, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_bswap32, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap32, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2127,18 +1862,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  */
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        TCGv_i32 t0, t1;
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
-
-        tcg_gen_bswap32_i32(t0, TCGV_LOW(arg));
-        tcg_gen_bswap32_i32(t1, TCGV_HIGH(arg));
-        tcg_gen_mov_i32(TCGV_LOW(ret), t1);
-        tcg_gen_mov_i32(TCGV_HIGH(ret), t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    } else if (tcg_op_supported(INDEX_op_bswap64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_bswap64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3i_i64(INDEX_op_bswap64, ret, arg, 0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2207,10 +1931,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
-    } else if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
         tcg_gen_op2_i64(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
@@ -2219,10 +1940,7 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2234,10 +1952,7 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
@@ -2247,10 +1962,7 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
@@ -2260,10 +1972,7 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
@@ -2273,10 +1982,7 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
-        tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2297,18 +2003,7 @@ void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32
-        && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
-        tcg_gen_addi_i32(t, t, 32);
-        tcg_gen_clz_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), t);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
+    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
@@ -2342,18 +2037,9 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
-    if (TCG_TARGET_REG_BITS == 32
-        && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t32 = tcg_temp_ebb_new_i32();
-        tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
-        tcg_gen_addi_i32(t32, t32, 32);
-        tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        tcg_temp_free_i32(t32);
-    } else if (arg2 == 64
-               && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-               && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+    if (arg2 == 64
+        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
+        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
         /* This equivalence has the advantage of not requiring a fixup.  */
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_subi_i64(t, arg1, 1);
@@ -2381,21 +2067,11 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 
 void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-            tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-            return;
-        }
+    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
     } else {
-        if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-            tcg_gen_ctpop_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-            tcg_gen_ctpop_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-            tcg_gen_add_i32(TCGV_LOW(ret), TCGV_LOW(ret), TCGV_HIGH(ret));
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-            return;
-        }
+        gen_helper_ctpop_i64(ret, arg1);
     }
-    gen_helper_ctpop_i64(ret, arg1);
 }
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
@@ -2485,24 +2161,9 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
-            tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-            return;
-        }
-    } else {
-        if (ofs >= 32) {
-            tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
-                                TCGV_LOW(arg2), ofs - 32, len);
-            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg1));
-            return;
-        }
-        if (ofs + len <= 32) {
-            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
-                                TCGV_LOW(arg2), ofs, len);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1));
-            return;
-        }
+    if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
+        return;
     }
 
     t1 = tcg_temp_ebb_new_i64();
@@ -2545,24 +2206,10 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_shli_i64(ret, arg, ofs);
     } else if (ofs == 0) {
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_REG_BITS == 64 &&
-               TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
+    } else if (TCG_TARGET_deposit_valid(TCG_TYPE_I64, ofs, len)) {
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
-        if (TCG_TARGET_REG_BITS == 32) {
-            if (ofs >= 32) {
-                tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg),
-                                      ofs - 32, len);
-                tcg_gen_movi_i32(TCGV_LOW(ret), 0);
-                return;
-            }
-            if (ofs + len <= 32) {
-                tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-                return;
-            }
-        }
         /*
          * To help two-operand hosts we prefer to zero-extend first,
          * which allows ARG to stay live.
@@ -2597,32 +2244,6 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* Look for a 32-bit extract within one of the two words.  */
-        if (ofs >= 32) {
-            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_HIGH(arg), ofs - 32, len);
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-            return;
-        }
-        if (ofs + len <= 32) {
-            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-            return;
-        }
-
-        /* The field is split across two words. */
-        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg),
-                             TCGV_HIGH(arg), ofs);
-        if (len <= 32) {
-            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(ret), 0, len);
-            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-        } else {
-            tcg_gen_extract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg),
-                                ofs, len - 32);
-        }
-        return;
-    }
-
     if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
@@ -2668,38 +2289,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* Look for a 32-bit extract within one of the two words.  */
-        if (ofs >= 32) {
-            tcg_gen_sextract_i32(TCGV_LOW(ret), TCGV_HIGH(arg), ofs - 32, len);
-        } else if (ofs + len <= 32) {
-            tcg_gen_sextract_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-        } else if (ofs == 0) {
-            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-            tcg_gen_sextract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg), 0, len - 32);
-            return;
-        } else if (len > 32) {
-            TCGv_i32 t = tcg_temp_ebb_new_i32();
-            /* Extract the bits for the high word normally.  */
-            tcg_gen_sextract_i32(t, TCGV_HIGH(arg), ofs + 32, len - 32);
-            /* Shift the field down for the low part.  */
-            tcg_gen_shri_i64(ret, arg, ofs);
-            /* Overwrite the shift into the high part.  */
-            tcg_gen_mov_i32(TCGV_HIGH(ret), t);
-            tcg_temp_free_i32(t);
-            return;
-        } else {
-            /* Shift the field down for the low part, such that the
-               field sits at the MSB.  */
-            tcg_gen_shri_i64(ret, arg, ofs + len - 32);
-            /* Shift the field down from the MSB, sign extending.  */
-            tcg_gen_sari_i32(TCGV_LOW(ret), TCGV_LOW(ret), 32 - len);
-        }
-        /* Sign-extend the field from 32 bits.  */
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-        return;
-    }
-
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
         return;
@@ -2763,20 +2352,8 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
 
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_gen_op3_i32(INDEX_op_addco, TCGV_LOW(t0),
-                            TCGV_LOW(al), TCGV_LOW(bl));
-            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(t0),
-                            TCGV_HIGH(al), TCGV_HIGH(bl));
-            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(rh),
-                            TCGV_LOW(ah), TCGV_LOW(bh));
-            tcg_gen_op3_i32(INDEX_op_addci, TCGV_HIGH(rh),
-                            TCGV_HIGH(ah), TCGV_HIGH(bh));
-        } else {
-            tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-            tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        }
-
+        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
+        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
     } else {
@@ -2795,68 +2372,27 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
-            TCGv_i64 discard = tcg_temp_ebb_new_i64();
-            TCGv_i64 zero = tcg_constant_i64(0);
-            TCGv_i64 mone = tcg_constant_i64(-1);
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+        TCGv_i64 discard = tcg_temp_ebb_new_i64();
+        TCGv_i64 zero = tcg_constant_i64(0);
+        TCGv_i64 mone = tcg_constant_i64(-1);
 
-            tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
-            tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
-            tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
-            tcg_temp_free_i64(discard);
-        } else {
-            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-
-            tcg_gen_add_i64(t0, a, b);
-            tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
-            tcg_gen_add_i64(r, t0, ci);
-            tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
-            tcg_gen_or_i64(co, t0, t1);
-
-            tcg_temp_free_i64(t0);
-            tcg_temp_free_i64(t1);
-        }
+        tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
+        tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
+        tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
+        tcg_temp_free_i64(discard);
     } else {
-        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-            TCGv_i32 discard = tcg_temp_ebb_new_i32();
-            TCGv_i32 zero = tcg_constant_i32(0);
-            TCGv_i32 mone = tcg_constant_i32(-1);
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
-            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);
-            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(r),
-                            TCGV_LOW(a), TCGV_LOW(b));
-            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(r),
-                            TCGV_HIGH(a), TCGV_HIGH(b));
-            tcg_gen_op3_i32(INDEX_op_addci, TCGV_LOW(co), zero, zero);
-            tcg_temp_free_i32(discard);
-        } else {
-            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
-            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
+        tcg_gen_add_i64(t0, a, b);
+        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add_i64(r, t0, ci);
+        tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or_i64(co, t0, t1);
 
-            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
-            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);
-
-            tcg_gen_add_i32(t0, TCGV_LOW(a), TCGV_LOW(b));
-            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_LOW(a));
-            tcg_gen_add_i32(TCGV_LOW(r), t0, c1);
-            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), c1);
-            tcg_gen_or_i32(c1, c1, c0);
-
-            tcg_gen_add_i32(t0, TCGV_HIGH(a), TCGV_HIGH(b));
-            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_HIGH(a));
-            tcg_gen_add_i32(TCGV_HIGH(r), t0, c1);
-            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1);
-            tcg_gen_or_i32(TCGV_LOW(co), c0, c1);
-
-            tcg_temp_free_i32(t0);
-            tcg_temp_free_i32(c0);
-            tcg_temp_free_i32(c1);
-        }
-        tcg_gen_movi_i32(TCGV_HIGH(co), 0);
+        tcg_temp_free_i64(t0);
+        tcg_temp_free_i64(t1);
     }
 }
 
@@ -2866,20 +2402,8 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
 
-        if (TCG_TARGET_REG_BITS == 32) {
-            tcg_gen_op3_i32(INDEX_op_subbo, TCGV_LOW(t0),
-                            TCGV_LOW(al), TCGV_LOW(bl));
-            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_HIGH(t0),
-                            TCGV_HIGH(al), TCGV_HIGH(bl));
-            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_LOW(rh),
-                            TCGV_LOW(ah), TCGV_LOW(bh));
-            tcg_gen_op3_i32(INDEX_op_subbi, TCGV_HIGH(rh),
-                            TCGV_HIGH(ah), TCGV_HIGH(bh));
-        } else {
-            tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-            tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        }
-
+        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
+        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
         tcg_gen_mov_i64(rl, t0);
         tcg_temp_free_i64(t0);
     } else {
@@ -3002,57 +2526,32 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(ret, TCGV_LOW(arg));
-    } else {
-        tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                    tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    }
+    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
+                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
-    } else {
-        tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                    tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    }
+    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
+                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), arg);
-        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-    } else {
-        tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                    tcgv_i64_arg(ret), tcgv_i32_arg(arg));
-    }
+    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
+                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(ret), arg);
-        tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
-    } else {
-        tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                    tcgv_i64_arg(ret), tcgv_i32_arg(arg));
-    }
+    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
+                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
 {
-    TCGv_i64 tmp;
+    TCGv_i64 tmp = tcg_temp_ebb_new_i64();
 
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(TCGV_LOW(dest), low);
-        tcg_gen_mov_i32(TCGV_HIGH(dest), high);
-        return;
-    }
-
-    tmp = tcg_temp_ebb_new_i64();
     /* These extensions are only needed for type correctness.
        We may be able to do better given target specific information.  */
     tcg_gen_extu_i32_i64(tmp, high);
@@ -3070,13 +2569,8 @@ void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
 
 void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg)
 {
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_mov_i32(lo, TCGV_LOW(arg));
-        tcg_gen_mov_i32(hi, TCGV_HIGH(arg));
-    } else {
-        tcg_gen_extrl_i64_i32(lo, arg);
-        tcg_gen_extrh_i64_i32(hi, arg);
-    }
+    tcg_gen_extrl_i64_i32(lo, arg);
+    tcg_gen_extrh_i64_i32(hi, arg);
 }
 
 void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg)
-- 
2.43.0


