Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F306C02195
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY3-0006Bm-OD; Sat, 01 Feb 2025 11:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXv-00064u-O6
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXs-000161-TL
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso20997105e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428035; x=1739032835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kx1dXlR2BEB9cLV8DknkSNZdxULxeneGoMVDz4ondQ8=;
 b=X8h46/jVSSyBaEOnQJbs95+uhs5c6HKmJqX7/3GEVr2UJquotjZ5KJbnilBtM0prq9
 swCulroyz4AI7ffd7kgkrHwpgn/rYg3XeoQHYOu16yHJPhNn3eVFNmYV7L4X6tP+rQWO
 bXrlGh20abBgTS/p+XXkO6pVUMTiyvJsCresbaJz3DlOjPP16BZXjnOJkZIioDJmV7nW
 rKW+u7JVJd8Ys/03esnnYRb8mjNxqF4Y7OdzpdvT+o0SKPjIWPWTObKadf/71q83NyyV
 Wentc4o7S5G4pJrRartDpz4yhP1fkx5ys7R6rQmbPNtnOPMzdYfXLxAE5lSlL4ZUhun6
 zKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428035; x=1739032835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kx1dXlR2BEB9cLV8DknkSNZdxULxeneGoMVDz4ondQ8=;
 b=L0oSm1Gu+2Rf6OcyHs1DCn7hSuTIW3W1PzW35uL4s9A6f20TdPMHzm1BQ6GGae2a9d
 FezJNQWRYZBo9CtHxeQjwfzF7DymEFOwz85/ZyjKUxSeY/4JPnrcstXoPk1hqiBomXJF
 DCGJrUvT0kyo/rtbWKhtsXrSSKtqGRYXcyT/8uIU9Esg/EkTbu/V+ZNi0KvyRXFAb7Xo
 rh6LdklOEclZ/zuibDQSCKeeg1juFuRVaWSL5pH98X9VkyM6yd+VgwmhupH2AKloTO9c
 /BAvp/qE/S0kuoBcpgFivVPSk6Tn/LnuR+ynhXlHRG1sxBC+m7G8H1o/EAqKPYpuwL0e
 K9/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2OD5DDBSP8Htoif/eG5Su7WsBTS/rnAwTAFrPGmmAfbNqSPdrq7+3spPGsFxmOID2WBsmk+owVk0J@nongnu.org
X-Gm-Message-State: AOJu0YzxRYomfc3QfP658F0RpPf0IopbcAUg4pHqOOUsESe6sNjAXcJ1
 Y4InjIb+mDDr3g5XqKXJNdiZG8/gcstxT1iJfoHj60VRlROFpFtVmWEuFaZ/2rlVsKZAlJ+xw5k
 Z
X-Gm-Gg: ASbGncs7G7z7t2XNaDqhxjWiq9ykWIyCNTfWdGqHP/jWTMOGrDENyWXg/eA7fqGGPIg
 nkzjxYstBqBUe8svBqdVRS6zpUN2KbKx5OpiNfiIuIYA7DUtKEGdN70zZmIXv5A1zSDMg/AJ9Ea
 KQkBUvgRnljCRRci+IYkekzsizHWrqW+E4vsVZrZEXR/rLYay1xWSg55RfOgLwJXaYUp262aFS0
 GD4+VFLfYJ0+cgzN5/orPpvHCaMvjtccM282brOqLjy8P2fsfyaWk6kjgjLURhRWVysVLrD8qZ9
 mdD09Q4m3aoezWTETjw0
X-Google-Smtp-Source: AGHT+IG8L+yG+WRyRLRZgFTyXFKb2ABNWaFQk60CV+oqmdUI63lKB2NRY5z0MYuhj9JwJ1jqFgQKYQ==
X-Received: by 2002:a05:600c:35d3:b0:438:d9f1:f5cc with SMTP id
 5b1f17b1804b1-438dc3c3983mr143210595e9.8.1738428034807; 
 Sat, 01 Feb 2025 08:40:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/69] target/arm: Use FPST_FPCR_AH for BFMLAL*,
 BFMLSL* insns
Date: Sat,  1 Feb 2025 16:39:17 +0000
Message-Id: <20250201164012.1660228-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

When FPCR.AH is 1, use FPST_FPCR_AH for:
 * AdvSIMD BFMLALB, BFMLALT
 * SVE BFMLALB, BFMLALT, BFMLSLB, BFMLSLT

so that they get the required behaviour changes.

We do this by making gen_gvec_op4_fpst() take an ARMFPStatusFlavour
rather than a bool is_fp16; existing callsites now select
FPST_FPCR_F16_A64 vs FPST_FPCR_A64 themselves rather than passing in
the boolean.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 20 +++++++++++++-------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bb32ccabf0e..1da6e2b9456 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -765,10 +765,11 @@ static void gen_gvec_op4_env(DisasContext *s, bool is_q, int rd, int rn,
  * an out-of-line helper.
  */
 static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
-                              int rm, int ra, bool is_fp16, int data,
+                              int rm, int ra, ARMFPStatusFlavour fpsttype,
+                              int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5837,7 +5838,8 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, false, a->q,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_AH : FPST_A64, a->q,
                           gen_helper_gvec_bfmlal);
     }
     return true;
@@ -5870,7 +5872,8 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      a->esz == MO_16, a->rot, fn[a->esz]);
+                      a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      a->rot, fn[a->esz]);
     return true;
 }
 
@@ -6450,7 +6453,8 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      esz == MO_16, (a->idx << 1) | neg,
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
 }
@@ -6585,7 +6589,8 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     }
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
-        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd, 0,
+        gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
+                          s->fpcr_ah ? FPST_AH : FPST_A64,
                           (a->idx << 1) | a->q,
                           gen_helper_gvec_bfmlal_idx);
     }
@@ -6614,7 +6619,8 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     }
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16, (a->idx << 2) | a->rot, fn);
+                          a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                          (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index be2b5528ba0..e38a49dd31c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7117,7 +7117,8 @@ TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
-                              a->rd, a->rn, a->rm, a->ra, sel, FPST_A64);
+                              a->rd, a->rn, a->rm, a->ra, sel,
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7127,7 +7128,8 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
-                              (a->index << 1) | sel, FPST_A64);
+                              (a->index << 1) | sel,
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.34.1


