Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13472C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnx-0002SQ-2r; Sun, 05 May 2024 21:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mn2-00006z-Uj
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:23 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmT-0002an-Gm
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:10 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b37731c118so1043235a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957476; x=1715562276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fGlg2LZa/YOxlVMc9WbzmX5AYNSpzX03fk1hZlnuv4=;
 b=mdHEjh+CTXBPFCrMM15U1U1WY6zUjldLzHkfXUoGNV3wPSwrLUOkISjx/sF5ZOq0Ah
 t0/IKEJC2otAdkgVmAtEgx3eCK7BqWTk5qbUD65ivF5jhI41RWcPvgU1uSDqiGsnM+jv
 d0LvRsUpdUgNsPVXjr3s7gXSVzvr3y1I6WHdw3S0UTsIwPOcXbykeIBrhPJgZhyl037P
 xOtQrHzHLn4m0JwHVk9QMiL+s5enD4WQpjz4I5/7v2O28Wymof+ZqFtG/UlAXxBaaiQJ
 V7qXDrCgel6EBy8AP95LQVsVjHEQDOryxZfwIZrtyoYm+NoFCEjX2+gt9/3Mb8nGqH9X
 XsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957476; x=1715562276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fGlg2LZa/YOxlVMc9WbzmX5AYNSpzX03fk1hZlnuv4=;
 b=UPGKvLeJN4fWJChjDSX9guTi0elDf3bIeCGhvQR+iKEA7fgXKc+G1NX5C0g675G/FQ
 dNuob41OdZl5zydE0GEPrIruvn121K1uCx+EcEwJYWki6ZlycprtChx9ShczWn9vJn4b
 fwTVkWHcH+kx4/B0ynM6DUfMc7LfMtOW5o9KXDpFVGzo76/3qTuVZR8/DchnnK5mQopp
 +j3E9IzFs5xtnHaE2Pw5Iqu4I4y37GsRj03JDHvpFoGC0m+/yP0rbhAg51nizjGiCGqm
 XGO1Gpw8Zdfm9YRoqBCmeAwASY8jj36CE8IwYnzwGXB1K1AR2LBCkYZlwJtBl4zolXLP
 8kPQ==
X-Gm-Message-State: AOJu0YxYdixn5uz/34gMNKc85ixwYViMG3aMNWLxn2+uix4EnXytNXrS
 jBiew5PCaNJZzg8KbsKncZUksXCoZOWtznH5TWoTOcMOwxDieOqp4fAxUBPc8QwEYzfsFdTUQCb
 F
X-Google-Smtp-Source: AGHT+IGpzFmZ+nDXbLT5bqGr/Nx174La+gXf/hq+kHq3vjiuPbbAX0dgG9YTlZs14chhaNiQ93fQbQ==
X-Received: by 2002:a17:90a:b002:b0:2b5:3ff4:6fa6 with SMTP id
 x2-20020a17090ab00200b002b53ff46fa6mr939610pjq.28.1714957475991; 
 Sun, 05 May 2024 18:04:35 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 38/57] target/arm: Convert SRSHL, URSHL to decodetree
Date: Sun,  5 May 2024 18:03:44 -0700
Message-Id: <20240506010403.6204-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 +++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b98e0a5c5d..6f55e0e300 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -758,6 +758,8 @@ USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 
 SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
 USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
+SRSHL_s         0101 1110 111 ..... 01010 1 ..... ..... @rrr_d
+URSHL_s         0111 1110 111 ..... 01010 1 ..... ..... @rrr_d
 
 ### Advanced SIMD scalar pairwise
 
@@ -882,6 +884,8 @@ USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 
 SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
 USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+SRSHL_v         0.00 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
+URSHL_v         0.10 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index eab28c04b9..8aa691aa30 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5117,6 +5117,8 @@ static bool do_int3_scalar_d(DisasContext *s, arg_rrr_e *a,
 
 TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
+TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
+TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
 
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
@@ -5365,6 +5367,8 @@ TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
 TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
 TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
+TRANS(SRSHL_v, do_gvec_fn3, a, gen_gvec_srshl)
+TRANS(URSHL_v, do_gvec_fn3, a, gen_gvec_urshl)
 
 
 /*
@@ -9378,13 +9382,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
             gen_helper_neon_qshl_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
         }
         break;
-    case 0xa: /* SRSHL, URSHL */
-        if (u) {
-            gen_helper_neon_rshl_u64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            gen_helper_neon_rshl_s64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     case 0xb: /* SQRSHL, UQRSHL */
         if (u) {
             gen_helper_neon_qrshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9403,6 +9400,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
 }
@@ -9427,7 +9425,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
-    case 0xa: /* SRSHL, URSHL */
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
@@ -9447,6 +9444,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
     }
@@ -10931,13 +10929,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SRSHL, URSHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urshl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11019,6 +11010,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x08: /* SSHL, USHL */
+    case 0x0a: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
 
-- 
2.34.1


