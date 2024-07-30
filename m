Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFE3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJr-0003jT-Gb; Tue, 30 Jul 2024 12:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJp-0003bk-Ji
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJn-0000HW-Oh
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso28658955e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355398; x=1722960198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HZaZuKw6MIHzrJiZQtNTqpnwcvq+BC4Z/9tdatLyulU=;
 b=ejB9alhiGOaIMtWcnK3ZApZyZoIJH7BBbymuu7t7lPxTy/B8mw4OSdoNRa8SX5sXLi
 r2mOz2di7l1Gqwk69zYwJJ52RT+ckbd+la8h3FDXxK4s3I+/3rNN680pJbUzskxdNbj0
 akzncUY8g186td7hGNEQoYkMy28pn+Cyvx86zFcLRA4cXZ1KeyKTng9PzJNzaGaACDgw
 RH4ZdEUHR8nWtOrzYgDZwVUCFg1eeVF/pE1b2sAlkqYz6Xvp6OXYGJHm7mM+dEXgq6oo
 +d2omKqJg9o1FI/PhCkG4AKtgMPu0ATuIRaaV3I72/jyQGoWV0HWmgCyY5SI9dxJCgJ5
 lzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355398; x=1722960198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZaZuKw6MIHzrJiZQtNTqpnwcvq+BC4Z/9tdatLyulU=;
 b=cbWobvdA3og4JYUq41wpqU7Y6pVLWl1/Pn0vptO61Xnun4JhJzVdSRYtGAF9efugHe
 TmN4fg+u00kXpWGvJAvpcNDzKOzzLeopPtdVa6FNcc6zEdwLOqr8DXrreVeJdkVsCoZ7
 UADcnSqOwlBxsg9sCnbwzSWMT8+r6fBu3vQ1KZP/3d2H/7d9wXZP5mExibJAO5do8+Gw
 Cw2Rw4cBF+/VimJ2ZUYkF4KSvoaf6MWzL0B1iBjv+uoW+8sEN6kqneOFG5loZgzvmPFQ
 OuB7Kje08AuuOCyyW6DFxFPqFE1Yc6KocGQxX3fxkusLMj6IMYZlU5P0GWGiWIX0xHRT
 mfog==
X-Forwarded-Encrypted: i=1;
 AJvYcCULadMRyktjy4Ov54CS+8BDIPGdziulpTrgb2j+Hn4cthvRUzhMktU7EfYU2HHdn6T30g9ElxZosS4XztA2FY7tjTRu1/k=
X-Gm-Message-State: AOJu0YyhkOyas2pHB7PlMXtNx21sS0ee21SfcA2y95sK5CUmvHLP2Ni8
 weQ7qgtheX6ZDsDww+8wFARKuBdp6BE7dC2WZr//JlaMOu27k3M9f76TaxMCnDNLBvG0ai+26vm
 K
X-Google-Smtp-Source: AGHT+IH3MNtcyOKIVE8kmGH8g/FwWt73Y62hrB/XF93if0TLcn2gIfKF/ZkughpzD9Py3xUZcw8UvQ==
X-Received: by 2002:a5d:698b:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-36b5cee2e4emr7735591f8f.7.1722355390195; 
 Tue, 30 Jul 2024 09:03:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/8] target/arm: Pass env pointer through to gvec_bfdot_idx
 helper
Date: Tue, 30 Jul 2024 17:03:02 +0100
Message-Id: <20240730160306.2959745-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Pass the env pointer through to the gvec_bfdot_idx helper,
so we can use it to add support for FEAT_EBF16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  4 ++--
 target/arm/tcg/translate-a64.c  | 11 ++++++++++-
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/translate-sve.c  |  8 +++++++-
 target/arm/tcg/vec_helper.c     |  2 +-
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aece9fd4aa7..386cf8686ea 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1029,8 +1029,8 @@ DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_bfdot_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4aef8b9211a..a4e9740c921 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6403,13 +6403,22 @@ static bool do_dot_vector_idx(DisasContext *s, arg_qrrx_e *a,
     return true;
 }
 
+static bool do_dot_vector_idx_env(DisasContext *s, arg_qrrx_e *a,
+                                  gen_helper_gvec_4_ptr *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_env(s, a->q, a->rd, a->rn, a->rm, a->rd, a->idx, fn);
+    }
+    return true;
+}
+
 TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
 TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
 TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_sudot_idx_b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_usdot_idx_b)
-TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
+TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx_env, a,
            gen_helper_gvec_bfdot_idx)
 
 static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 454380f01d7..7de157c539c 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -391,8 +391,8 @@ static bool trans_VDOT_b16_scal(DisasContext *s, arg_VDOT_b16_scal *a)
     if (!dc_isar_feature(aa32_bf16, s)) {
         return false;
     }
-    return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_bfdot_idx);
+    return do_neon_ddda_env(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
+                            gen_helper_gvec_bfdot_idx);
 }
 
 static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4fb0bd077b4..8876d1f91a9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -251,6 +251,12 @@ static bool gen_gvec_env_arg_zzzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
     return gen_gvec_env_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
 }
 
+static bool gen_gvec_env_arg_zzxz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
+                                  arg_rrxr_esz *a)
+{
+    return gen_gvec_env_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index);
+}
+
 /* Invoke an out-of-line helper on 4 Zregs, 1 Preg, plus fpst. */
 static bool gen_gvec_fpst_zzzzp(DisasContext *s, gen_helper_gvec_5_ptr *fn,
                                 int rd, int rn, int rm, int ra, int pg,
@@ -7114,7 +7120,7 @@ TRANS_FEAT_NONSTREAMING(UMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
 
 TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
-TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
 TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_ool_arg_zzzz,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 37aad4be4b0..1edde9792f0 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2828,7 +2828,7 @@ void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
-                            void *va, uint32_t desc)
+                            void *va, void *envp, uint32_t desc)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t index = simd_data(desc);
-- 
2.34.1


