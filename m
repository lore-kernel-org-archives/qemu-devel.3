Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPt-0001AL-TZ; Tue, 25 Jun 2024 01:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPp-00015G-D1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPl-0001XW-Uy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9bf484d9fso32033985ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292100; x=1719896900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqgia+CtSFBvxE3hJrzybYSQYNCwJCQTcDGbhjUI0/I=;
 b=ihMCKMp5KQjiO7AFaDQNSbS/+S5dNu7kIFXD3U6mSPQ7miDyrUl/zwKG3w+CsvJ4Nn
 An1TNumIHpBMVZ07F75BqNl/F6XR539s6OkdPgxQEsR94JzDFaiDVI5QBVPs0RQnnxyx
 ZkIRrRuvLX+0/SC3CQHjlQtsorwe9FtpJpy3tf5xyuhiV8RW0asEXWLvFBaOs6RdO4ca
 VcO6rW/jQblK/lv/+ezzSn1FiCbPHfVnOwL71LlOAJ2eA6xuO1OFWKJ6G9dIBE8ev6Rf
 GntNBkpcN3HrEr5Vhgfg2C3QtyQz40ftked05janxlEV7zzTKVOgNVHMUCGvlq55Z4Tf
 qZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292100; x=1719896900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqgia+CtSFBvxE3hJrzybYSQYNCwJCQTcDGbhjUI0/I=;
 b=AFqtGrFi3N0spBjvRQPGWlhIGNsWR9a5vPiXcRKaBvsCK7JOEBh6GXFHsRYW4efk6J
 YMcrnDmbcek0qOaBboaAIRwf3nZzXuR6QR/+FTXf0Pe09sY4gq4TjmoWk5a/tWU9l1vv
 67BqsEqcz9cWF49GmCCkDRYgAsYQxy1mMo/29mIBwGuCGaVTIciivIsISSxcqoy+R67K
 qjAHvTRdUF4h7TYrBymHR2m/fbl1h2/Mh6LRhPW4qiqPINst7ENIUrf6Ix19FvsRa1Q+
 PJGssKoBTNiRjlBvUVlf8/mZI2/YUmWtbi34TYfTRSZj0Q/xxAyg5wnfaTsJ9BUCMPak
 9MVQ==
X-Gm-Message-State: AOJu0YymOTI3B61WksllGY2BBy/+V4bEkqIbzjLAVi0DBxa+iU1yHpxx
 UFfanPpRTaJUJYIuKusQhBMmRBCdD0mydsyobYOAoUlbO4AlnPWOKvX5IIWubkQ+8bpm/mQ/NtT
 4
X-Google-Smtp-Source: AGHT+IEJZWjR+Xi4pwHAJ8FqtDP9cX5VBWEm5RvfTSix7D/0sBintVALB7umSY2uq7VDV3ce95Jtnw==
X-Received: by 2002:a17:902:e80d:b0:1f6:e338:2a6 with SMTP id
 d9443c01a7336-1fa5e6ad2e4mr35991665ad.23.1719292100385; 
 Mon, 24 Jun 2024 22:08:20 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/13] target/arm: Convert BFMLALB, BFMLALT to decodetree
Date: Mon, 24 Jun 2024 22:08:05 -0700
Message-Id: <20240625050810.1475643-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/tcg/a64.decode      |  2 +
 target/arm/tcg/translate-a64.c | 77 +++++++++++++---------------------
 2 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6819fd2587..15344a73de 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -951,6 +951,7 @@ SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
 BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
+BFMLAL_v        0.10 1110 110 ..... 11111 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1031,6 +1032,7 @@ UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
 USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
+BFMLAL_vi       0.00 1111 11 .. .... 1111 . 0 ..... .....   @qrrx_h
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f44cd5aee..95be862dde 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5606,6 +5606,19 @@ TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
 
+static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /* Q bit selects BFMLALB vs BFMLALT. */
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, false, a->q,
+                          gen_helper_gvec_bfmlal);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5946,6 +5959,20 @@ TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
 TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
            gen_helper_gvec_bfdot_idx)
 
+static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
+{
+    if (!dc_isar_feature(aa64_bf16, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /* Q bit selects BFMLALB vs BFMLALT. */
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, 0,
+                          (a->idx << 1) | a->q,
+                          gen_helper_gvec_bfmlal_idx);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10952,23 +10979,13 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = dc_isar_feature(aa64_bf16, s);
         break;
-    case 0x1f:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            feature = dc_isar_feature(aa64_bf16, s);
-            break;
-        default:
-        case 1: /* BFDOT */
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     default:
     case 0x02: /* SDOT (vector) */
     case 0x03: /* USDOT */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
+    case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
     }
@@ -11037,17 +11054,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0xd: /* BFMMLA */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfmmla);
         return;
-    case 0xf:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, false, is_q,
-                              gen_helper_gvec_bfmlal);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return;
-
     default:
         g_assert_not_reached();
     }
@@ -12051,24 +12057,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0f:
-        switch (size) {
-        case 3: /* BFMLAL{B,T} */
-            if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            /* can't set is_fp without other incorrect size checks */
-            size = MO_16;
-            break;
-        default:
-        case 0: /* SUDOT */
-        case 1: /* BFDOT */
-        case 2: /* USDOT */
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
@@ -12089,6 +12077,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
     case 0x0e: /* SDOT */
+    case 0x0f: /* SUDOT / BFDOT / USDOT / BFMLAL */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
@@ -12171,14 +12160,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     switch (16 * u + opcode) {
-    case 0x0f:
-        switch (extract32(insn, 22, 2)) {
-        case 3: /* BFMLAL{B,T} */
-            gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
-                              gen_helper_gvec_bfmlal_idx);
-            return;
-        }
-        g_assert_not_reached();
     case 0x11: /* FCMLA #0 */
     case 0x13: /* FCMLA #90 */
     case 0x15: /* FCMLA #180 */
-- 
2.34.1


