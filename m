Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D44C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIW-0000Ze-5I; Fri, 24 May 2024 19:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0007Oe-VP
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHf-0006sf-69
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f4f2b1c997so3796536b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593107; x=1717197907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvCIuypfJNI340RGyci/PzKT1veZ7P8AmkoVbzz/TlM=;
 b=TlrMB86fFTZwZc24CYD5pKUwB+ergOLERy+eVTC+elIo3EUr+5Y3943it2UP2VuLqU
 pAEfVe2zLHHW0BJOzd2YOuXvto9yMs7biv3qgvgSkV05vN/ZkAmvVUqP2vUrsci9b4vU
 T8xSpbxi5Uxs0YsJ/SWf5dV0sGdlxr8LvHPbyXqoZr11rTmmcldgC0FtDIcTt1pSpLWd
 SIy1+y1MBphvzjdCGoo5qHz8dM/QSLDfy827RcNmxh0H3CY5WcQIKHIBwboJ28MUeDUu
 x4JLulCqO/T4cVUKnCpWzdnvT+bFVn2JZJhyAbW+uVsfyTg8iBWDjS8zmGFAP/VyIWQN
 Q4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593107; x=1717197907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvCIuypfJNI340RGyci/PzKT1veZ7P8AmkoVbzz/TlM=;
 b=EZdAQOwG7nmYqSZmCgqQHnrDM4wTaDVmNiSwfQGC4DN/4doVoZQmrsPhYf8/S/co14
 1oJFbStBn5TtD1EteMYU9QeF2aZVrxRDeCp28wdLk5NY3lxuuDe9y9OhPgJkPmH75Jv1
 RB88tMMaoHZ3zYatiH4zDxKsLvQjECtY2OQYxrXhvLfzJusspLwb6Ou+xlyMp4MXunbO
 qDOp/NXQNldU/gOVZ1U+PYCA41AyX4VkbrmsMREwqLJVc+igoHhlQi/z7Yg0YeB5JUdw
 CtTtBuny3KDrBMoIYnjIRox4Hl6frVFz+sNiO/DkJhhAi5cQBoNldD+j3/ekBxfHtDn0
 m2DA==
X-Gm-Message-State: AOJu0YykW/Spf6qVt5PFXSxhbzsQcF3Sr1S5LcQYArcYNb2EH+BBuMrl
 mebZIo+popOm+uAYgSsY4psxfyVsZa6XBotsP4Pj+7NjwMJPQHqgYPAhao7ctJ0ERkq3Ft4ILIk
 t
X-Google-Smtp-Source: AGHT+IEofddKEJJM/G1T3HuEBcZMGEc30OD8eSPBb9ncGFqACyQbbWlei6xpMBvZWpoYvsn10/tR+g==
X-Received: by 2002:a05:6a21:1f24:b0:1b0:25b6:a749 with SMTP id
 adf61e73a8af0-1b212e1711cmr4099335637.48.1716593107213; 
 Fri, 24 May 2024 16:25:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 50/67] target/arm: Convert ADD, SUB (vector) to decodetree
Date: Fri, 24 May 2024 16:21:04 -0700
Message-Id: <20240524232121.284515-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++++
 target/arm/tcg/translate-a64.c | 34 +++++++++++-----------------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 96ce35ad40..44383b4fc7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -765,6 +765,9 @@ UQSHL_s         0111 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
 SQRSHL_s        0101 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 UQRSHL_s        0111 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 
+ADD_s           0101 1110 111 ..... 10000 1 ..... ..... @rrr_d
+SUB_s           0111 1110 111 ..... 10000 1 ..... ..... @rrr_d
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -895,6 +898,9 @@ UQSHL_v         0.10 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
 SQRSHL_v        0.00 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 UQRSHL_v        0.10 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 
+ADD_v           0.00 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+SUB_v           0.10 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b76682cabf..77a64923e7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5118,6 +5118,8 @@ TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
 TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
 TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
+TRANS(ADD_s, do_int3_scalar_d, a, tcg_gen_add_i64)
+TRANS(SUB_s, do_int3_scalar_d, a, tcg_gen_sub_i64)
 
 typedef struct ENVScalar2 {
     NeonGenTwoOpEnvFn *gen_bhs[3];
@@ -5432,6 +5434,8 @@ TRANS(UQSHL_v, do_gvec_fn3, a, gen_neon_uqshl)
 TRANS(SQRSHL_v, do_gvec_fn3, a, gen_neon_sqrshl)
 TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
+TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
+TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -9444,13 +9448,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            tcg_gen_sub_i64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_add_i64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     default:
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
@@ -9458,6 +9455,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         g_assert_not_reached();
     }
 }
@@ -9482,7 +9480,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
-    case 0x10: /* ADD, SUB (vector) */
         if (size != 3) {
             unallocated_encoding(s);
             return;
@@ -9501,6 +9498,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10958,6 +10956,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
+    case 0x08: /* SSHL, USHL */
+    case 0x09: /* SQSHL, UQSHL */
+    case 0x0a: /* SRSHL, URSHL */
+    case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         unallocated_encoding(s);
         return;
     }
@@ -10995,13 +10998,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
         }
         return;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
-        }
-        return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
@@ -11044,14 +11040,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                          vec_full_reg_offset(s, rm),
                          is_q ? 16 : 8, vec_full_reg_size(s));
         return;
-
-    case 0x01: /* SQADD, UQADD */
-    case 0x05: /* SQSUB, UQSUB */
-    case 0x08: /* SSHL, USHL */
-    case 0x09: /* SQSHL, UQSHL */
-    case 0x0a: /* SRSHL, URSHL */
-    case 0x0b: /* SQRSHL, UQRSHL */
-        g_assert_not_reached();
     }
 
     if (size == 3) {
-- 
2.34.1


