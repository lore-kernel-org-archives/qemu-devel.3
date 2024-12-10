Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E74E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL31V-0005Jx-0r; Tue, 10 Dec 2024 11:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31L-0004qT-1I
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:36 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31I-0007MM-EG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:34 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so2527209e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847811; x=1734452611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYWISUXxM/3Drujw1rOpjgKt5oRl+JDgu9IdrFJ+rCM=;
 b=CF94pKOju8m6JqoD8NitpRcwOqQKFWSJzm8giSdspYZBBBRJl9z4nMH6tuKiEn7aSZ
 L05jItDE8c1E2AUiDlj+Tm/I2Lx3M6qpGvkzE20MU407u6KNha4m+OeL/vCQWmClQEvV
 76AM+IZBqqZmCTtAYmwKKWKo5uhbW6HOx/UWP2/IgHEnawG8PbuRbL24hoYDoZ/8VOjx
 g02F37QfKo875tplF8VqmKum2H1Xsexhq6ZCQze6z5OeVOTZvy4VgIePeKmcrLzbEErp
 7DYUYre9A5V1LNv9DBdoHmoooX4LhslfFC3my38fEXW+FTJ2dDQIEe0TUH+iHe4EpLSN
 4zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847811; x=1734452611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYWISUXxM/3Drujw1rOpjgKt5oRl+JDgu9IdrFJ+rCM=;
 b=UL2+n1aJWE/zybOYHYProd/DmhU1Y+X3U2k00et8Che+EqjCZZ1/jy+/8HqCezJaJ3
 fn1vgDew1iKXtNS57iNs+qDr6+rYU+I4k/bDOaDeO0kLQI7Ob0kJHqRVMNm0Ec9RZKBq
 k6OkdbeBI/C9Mkp8tBtd9wdODu2hpSSXUD6G9mDs1pkrkQYJHuqF2Cmj76LEGxfto6rT
 cvJitAejkHCe7w1zuYg5CJ/BeJmiIIeztSdVgiGUi3IcG1mElhIBYBnHiXkCK3c4SzJW
 AdXLwsOWOn69gbf68ELtuD+M9Ztz4gfRHSbqqxYM4JNVEey/hrEhBEHeH7IX0/z5nCu9
 ArrA==
X-Gm-Message-State: AOJu0Ywug04x5xWI/0YTdqRiirUVMv5c3yXr+DRh+HE24JW1AseAmM4c
 T1Kd0IkGWXprYlFMQBXdb2ju5Cb8aAEoR6wVQS8sCpdz6Lm0nfLOQwgmWtRj1FlrMGdcekTkVrV
 FB70V4s3V
X-Gm-Gg: ASbGncv7JBN6jaC9Fl0msrBU90KlbN26Jak6UI0NvdsTSLkZeXDmovAxZGOVd8R9/Kt
 DyjnFo3tBekZocrpe4QZErH6Cf/O05PrVuyd7GUPBu11flKnbvuK6QDBnoIPkRsjHR7qDsv/EgQ
 Wqr1p+FtBWrD8DMGc71/Wwe5A9FkwAVyDQpLh41nxS/nzcBPU/kRM0wW9ptDraK1A9n4GlB/4OD
 0vkDugv/80l6SClkEyUfpaWcd/9XJku3sVTNa6wXcHgRb6/Z+N40AjwZgw=
X-Google-Smtp-Source: AGHT+IEX+MKC6w/61yyp7cvk6N4SSdr9ZDW6CDRmTwasrhCLYF83aeOHAKcEtmwWVgVuyicZFrIFcQ==
X-Received: by 2002:a05:6512:3da3:b0:53e:350a:7298 with SMTP id
 2adb3069b0e04-540240d2de6mr1384800e87.25.1733847810812; 
 Tue, 10 Dec 2024 08:23:30 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:23:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 41/69] target/arm: Convert CMGT, CMGE, GMLT, GMLE,
 CMEQ (zero) to decodetree
Date: Tue, 10 Dec 2024 10:17:05 -0600
Message-ID: <20241210161733.1830573-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 94 +++++++++++-----------------------
 target/arm/tcg/a64.decode      | 10 ++++
 2 files changed, 40 insertions(+), 64 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 894c33ed1f..c737a35121 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8902,6 +8902,22 @@ static bool do_scalar1_d(DisasContext *s, arg_rr *a, ArithOneOp *f)
 TRANS(ABS_s, do_scalar1_d, a, tcg_gen_abs_i64)
 TRANS(NEG_s, do_scalar1_d, a, tcg_gen_neg_i64)
 
+static bool do_cmop0_d(DisasContext *s, arg_rr *a, TCGCond cond)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        tcg_gen_negsetcond_i64(cond, t, t, tcg_constant_i64(0));
+        write_fp_dreg(s, a->rd, t);
+    }
+    return true;
+}
+
+TRANS(CMGT0_s, do_cmop0_d, a, TCG_COND_GT)
+TRANS(CMGE0_s, do_cmop0_d, a, TCG_COND_GE)
+TRANS(CMLE0_s, do_cmop0_d, a, TCG_COND_LE)
+TRANS(CMLT0_s, do_cmop0_d, a, TCG_COND_LT)
+TRANS(CMEQ0_s, do_cmop0_d, a, TCG_COND_EQ)
+
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
     if (!a->q && a->esz == MO_64) {
@@ -8918,6 +8934,11 @@ TRANS(NEG_v, do_gvec_fn2, a, tcg_gen_gvec_neg)
 TRANS(NOT_v, do_gvec_fn2, a, tcg_gen_gvec_not)
 TRANS(CNT_v, do_gvec_fn2, a, gen_gvec_cnt)
 TRANS(RBIT_v, do_gvec_fn2, a, gen_gvec_rbit)
+TRANS(CMGT0_v, do_gvec_fn2, a, gen_gvec_cgt0)
+TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
+TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
+TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
+TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9229,21 +9250,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * The caller only need provide tcg_rmode and tcg_fpstatus if the op
      * requires them.
      */
-    TCGCond cond;
-
     switch (opcode) {
-    case 0xa: /* CMLT */
-        cond = TCG_COND_LT;
-    do_cmop:
-        /* 64 bit integer comparison against zero, result is test ? -1 : 0. */
-        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_constant_i64(0));
-        break;
-    case 0x8: /* CMGT, CMGE */
-        cond = u ? TCG_COND_GE : TCG_COND_GT;
-        goto do_cmop;
-    case 0x9: /* CMEQ, CMLE */
-        cond = u ? TCG_COND_LE : TCG_COND_EQ;
-        goto do_cmop;
     case 0x2f: /* FABS */
         gen_vfp_absd(tcg_rd, tcg_rn);
         break;
@@ -9290,6 +9297,9 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x4: /* CLS, CLZ */
     case 0x5: /* NOT */
     case 0x7: /* SQABS, SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         g_assert_not_reached();
     }
@@ -9633,19 +9643,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0xa: /* CMLT */
-        if (u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-        if (size != 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x12: /* SQXTUN */
         if (!u) {
             unallocated_encoding(s);
@@ -9731,6 +9728,9 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     default:
     case 0x3: /* USQADD / SUQADD */
     case 0x7: /* SQABS / SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
@@ -10103,19 +10103,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         handle_shll(s, is_q, size, rn, rd);
         return;
-    case 0xa: /* CMLT */
-        if (u == 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10289,6 +10276,9 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
     case 0x7: /* SQABS, SQNEG */
+    case 0x8: /* CMGT, CMGE */
+    case 0x9: /* CMEQ, CMLE */
+    case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
         unallocated_encoding(s);
         return;
@@ -10309,30 +10299,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         tcg_rmode = NULL;
     }
 
-    switch (opcode) {
-    case 0x8: /* CMGT, CMGE */
-        if (u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cgt0, size);
-        }
-        return;
-    case 0x9: /* CMEQ, CMLE */
-        if (u) {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cle0, size);
-        } else {
-            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_ceq0, size);
-        }
-        return;
-    case 0xa: /* CMLT */
-        gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
-        return;
-    case 0x4: /* CLZ, CLS */
-    case 0x5: /* CNT, NOT, RBIT */
-    case 0xb:
-        g_assert_not_reached();
-    }
-
     if (size == 3) {
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bac81eec7e..247d3a7bda 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1635,6 +1635,11 @@ SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
 SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
 ABS_s           0101 1110 111 00000 10111 0 ..... .....     @rr
 NEG_s           0111 1110 111 00000 10111 0 ..... .....     @rr
+CMGT0_s         0101 1110 111 00000 10001 0 ..... .....     @rr
+CMGE0_s         0111 1110 111 00000 10001 0 ..... .....     @rr
+CMEQ0_s         0101 1110 111 00000 10011 0 ..... .....     @rr
+CMLE0_s         0111 1110 111 00000 10011 0 ..... .....     @rr
+CMLT0_s         0101 1110 111 00000 10101 0 ..... .....     @rr
 
 # Advanced SIMD two-register miscellaneous
 
@@ -1647,3 +1652,8 @@ CLZ_v           0.10 1110 ..1 00000 01001 0 ..... .....     @qrr_e
 CNT_v           0.00 1110 001 00000 01011 0 ..... .....     @qrr_b
 NOT_v           0.10 1110 001 00000 01011 0 ..... .....     @qrr_b
 RBIT_v          0.10 1110 011 00000 01011 0 ..... .....     @qrr_b
+CMGT0_v         0.00 1110 ..1 00000 10001 0 ..... .....     @qrr_e
+CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
+CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
+CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
+CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
-- 
2.43.0


