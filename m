Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328E5C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwi3-0002sc-Ut; Wed, 02 Jul 2025 08:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgS-0008Qw-1c
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:28 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgA-00018u-5S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:26 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73a44512c8aso1536899a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459699; x=1752064499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcfx0Rug4rrD3mpx1vWRP1AZ5OZLQ91BzLxLARSGtZE=;
 b=SjY2wOALeuro8c1qIjxaH9DYBhQ8/+0yjiKZhdASNDT3sA6Gz6MM3rj084ATrUtIM1
 92hqsC72bnVj+PlGEQ2uYCK5zs3jqYN6loK0ovbNM3ZoR8SOoTIaYAh/TmaftzUSxZS0
 QaS8nIsfo0Yn6rBcs39OmVJCeY1oLBwzyb75f94ONVL8mxs6EvrZBbx/yegS0+jtdwRG
 EUWBwc8JkDq3y9mY/s/3AhYaVB7Byll+D7dTIRfGAxgytn+LVSqjfEGH2WCAxhxKtOjU
 GRSFTmrXf+p4BZPZu9s5BFaelIgn0wSQ6TSXC6FHJk1gBH/m65xN+iACO3sdytEukt6G
 flSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459699; x=1752064499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcfx0Rug4rrD3mpx1vWRP1AZ5OZLQ91BzLxLARSGtZE=;
 b=TT5A5WxSyDTN5hz8Uf5rL6X97VGJ5WIrOaslrl/rwPdF1OohRd+QcEowb10SpkRgee
 6+A/u92zbACrGjcm6OyfpuS0H2oh4aIrXjsn4M7SNNLzE3WDi9CQs4P0qlbLMEjtm7rP
 kJWOA5mrPfQSZ7+U2DlNKjT7zoHofZAB8G4JAgcaQLtl45zGV7VEgKCG/5c8VeBTSKS5
 +bC9g/cUJpIcSixr74fZOb+JZLqyqSa1gPHrGpYalPi9oNpYEmiTHofp/Te/1gE0wiUr
 +wHWr81RrAeGt6+XetbOuaXqPZPonnrDzATYkq2IrwSlVQJX+KSFGaKiqKDuOJtq0Rwy
 kjVQ==
X-Gm-Message-State: AOJu0YzV0lRhywksL8WUvAWMt3O5J7JYvntJsa9xWFS8jEUFagI+H6R2
 xLFMsaJqE2Qy2x3pRY4SiAhWiHSWv4cVJwzSh0/M3XLm5yMtHSb9R5OUbiLYlLLpGIYJ20jCqDq
 AOLoZWPc=
X-Gm-Gg: ASbGnct2LmgLT5iCdAZUKtn5p1IXztiapz2V/5ITbgtCZDHO+T4GGmnORY7ZNvTuxgM
 3Wh8Gt7CuKiFxoysQULzndO+zgoFMURXld90/kidb5petGbxxFM5bu9WcdrNADqQB9Fl0pirPa2
 +i/Wg/UT34IOZgUPqO9jP7XbekZ8Y3nmsFCYa5LBey9+urVq+lplgJ8973AwpC+qlOb62Icm37C
 WKRkabI9ijXi1NDmEEq+54QOwVHnEakYYlOFOhrm+9wG2w1wOAAz8AULOZKJlY+Nt8ARkaN4wWq
 Ac0d5b7fGsWFTZbLtu2KZroUx8IWJHUKN570sdf0xaO33sExIIJ9Fs41Gk87LBVbN+e7eriqf5h
 Zj3tt
X-Google-Smtp-Source: AGHT+IHa2Je7GEhuqIe65DvyfuIKRZLmVH9cBztSrfOdoLB78aSVYaRei+0CIQSLIEXMTlQIiXda1w==
X-Received: by 2002:a05:6830:6c0f:b0:72b:7cc8:422 with SMTP id
 46e09a7af769-73b4ccf6ab7mr2002568a34.20.1751459698128; 
 Wed, 02 Jul 2025 05:34:58 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 37/97] target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
Date: Wed,  2 Jul 2025 06:33:10 -0600
Message-ID: <20250702123410.761208-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Emphasize the non-fused nature of these multiply-add.
Matches other helpers such as gvec_rsqrts_nf_[hs].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h         | 8 ++++----
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index c4a208e3ba..b741470b51 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -790,11 +790,11 @@ DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index ea04336797..844d2e29e4 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1010,8 +1010,8 @@ DO_3S_FP_GVEC(VACGE, gen_helper_gvec_facge_s, gen_helper_gvec_facge_h)
 DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
 DO_3S_FP_GVEC(VMAX, gen_helper_gvec_fmax_s, gen_helper_gvec_fmax_h)
 DO_3S_FP_GVEC(VMIN, gen_helper_gvec_fmin_s, gen_helper_gvec_fmin_h)
-DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_s, gen_helper_gvec_fmla_h)
-DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
+DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_nf_s, gen_helper_gvec_fmla_nf_h)
+DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_nf_s, gen_helper_gvec_fmls_nf_h)
 DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index c9d1b09268..e03db47ef7 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1668,11 +1668,11 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-DO_MULADD(gvec_fmla_h, float16_muladd_nf, float16)
-DO_MULADD(gvec_fmla_s, float32_muladd_nf, float32)
+DO_MULADD(gvec_fmla_nf_h, float16_muladd_nf, float16)
+DO_MULADD(gvec_fmla_nf_s, float32_muladd_nf, float32)
 
-DO_MULADD(gvec_fmls_h, float16_mulsub_nf, float16)
-DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
+DO_MULADD(gvec_fmls_nf_h, float16_mulsub_nf, float16)
+DO_MULADD(gvec_fmls_nf_s, float32_mulsub_nf, float32)
 
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
-- 
2.43.0


