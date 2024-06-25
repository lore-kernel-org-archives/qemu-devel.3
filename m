Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E68C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 21:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBzR-0008Ss-L3; Tue, 25 Jun 2024 15:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMByM-0008Bd-8t
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:37:03 -0400
Received: from [2607:f8b0:4864:20::c2d] (helo=mail-oo1-xc2d.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBxf-0004wV-5C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:36:42 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5c21f3fbdd3so140145eaf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719344093; x=1719948893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO8S7b7Lc2zYJ5YuH/uyew7KLH8ZATkGu/zVIu9bhOw=;
 b=KF1/iPLwMvGnba+5VVDm/w+NbAXjqjY6APH59mphvdyUeHUuIxfF/tTTl6O6vfNzSR
 yzTxYuCR2qQ5cPsdQjq1GSCdbTL0nHdUha3zUJeKfXRkUDOT+IDeJnW1ravE7riSxkOa
 CkphCmyawKcNrkSg00qorFZMhtobWIdA6fUo0xxmRzWSHCMCOoOj3qnvlZ8MCnBGkEK8
 JwFC54r47Cywt15LzpFLDeFtKn1B4mFZ25i+KSekkxtLKcOyKy2z7XGsYnvmJWTxQqRv
 HyvrwfM0ZkYYwOVTdz6vw3Mmk5fB2pPeVPA+sURJNMa7aLPlMJs9EohM5qiAexN4f00t
 s1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719344093; x=1719948893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO8S7b7Lc2zYJ5YuH/uyew7KLH8ZATkGu/zVIu9bhOw=;
 b=su/Ko+TTVZvZL/v1LsBfW8mjdYG4rDPc4nbK5unmnHmz1rTgr/0TNbPtu59N1TyMAI
 Jc04Khu4wKujQ4N+Itsg8sS9IlCsYB7EMQ5GrMJv2rCvnEgG9NdcD7aWNVI2DOY+jyq9
 VMqi23j6i/prOXpQfndHdOJH4oZTfr3vEDkjehyfNlIq9V1PvPlGCIUJqvAsRBNzsdKp
 8pHxEhltgIMjl9DuMPS1lFkaenotctEAV0VNmvLauJBnklZVDfCFyE2MDWdTwn+3Vrs1
 HnZ62wg+xLdKF86+XP/IiGuCTH5kDnYoBaAyDpP7l3bq/C4SwqI5E3JGax8aSkqBlS9O
 6Qpg==
X-Gm-Message-State: AOJu0YzL9xvzBJzXmGfmKd6kwHc0RjvMihI8IGXbXSOQyRMZm4xgXW2O
 itIINH2INi3QmI1AWYgLKlct9O9LtSlzuwUFws7rpQ1NHEdj4izfyKt/yYafL+jXQiHm3f2u2A7
 P
X-Google-Smtp-Source: AGHT+IEZESXdMDpgCdRWY14uSmLYthzzVVuhnprWD09BpoP2ADUSgtjTQOqVKmCpvHDp+YW2a/rE7A==
X-Received: by 2002:a17:903:32ce:b0:1fa:2420:33ed with SMTP id
 d9443c01a7336-1fa24203694mr94894665ad.65.1719340545240; 
 Tue, 25 Jun 2024 11:35:45 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/13] target/arm: Convert BFMLALB, BFMLALT to decodetree
Date: Tue, 25 Jun 2024 11:35:31 -0700
Message-Id: <20240625183536.1672454-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::c2d
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


