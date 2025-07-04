Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D657EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEx-0001me-4a; Fri, 04 Jul 2025 12:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEh-00014k-N4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEd-0006QH-Ox
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so869366f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646358; x=1752251158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mr02KBcb0q1s0QBC40YxEnfsn/Cfw2nIIEa5P/5YfrM=;
 b=vTtnmAvXfCfb9qbdxmQBy0YThqN9jprh4Y9LcPEUHIGW91ceEelPReoedYzm0ZjxnR
 pHNb9Y5sNVazKAQ2jIGKdMHnpJRXetPmGS1ANRDsMFNykVquiuwT0/mI97Lr4m5aIGsD
 Nyh7Ttoe+nH4dw8lLnqpxFF03Al6nACLw+tuLo3HDvDL6ReIyJx8iI4jDcU6k2x31LKM
 ugK3qKzGpCe9/Xb4v8UQ1hnWErakZtGnzFKkg3juJxnXc9kxJ7Ol98yPjG0HmAKX8haq
 Ddm5g0tGYzn18Fr2NXSmlG9yUxCbY3WW45xYtD66CjQJR+SJEYGQMI5FzQhuyXx6AdWU
 /WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646358; x=1752251158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mr02KBcb0q1s0QBC40YxEnfsn/Cfw2nIIEa5P/5YfrM=;
 b=Z++89wUgBZOFsO6707IXWFyTeYEJAFXX97zrpGKi2M78HpuqCeG6yTrl9vLWNCFMTA
 P5nHrTBDhFNvM+5aaGkwAor7j64WSbsH3LOd1GWOQaXRbWPg4NuIO8PzYdxGbNIZWyKy
 4fBulEaV/nhYAVqJqC9io3cxjzJLk8RU88Xs0Sl+8Vx3l4+Kv1VEdGD/Xf2Euy26IrqM
 7S3tKtVPC2LO8gIe3e7Uo0QpfEChtfK5gDLkykH68r4Tq+V2BJPmbGpVHx3+MnOmwCEt
 Kj3GoP8+bDsfrbgSh4yrgE8MYWCABq34JduP//cJc01vw8Mg6FJUiAyS88Qgkdxut2L2
 X/YA==
X-Gm-Message-State: AOJu0YzNHGWtl46/9nnSqDb9HRGUUNoJTDA8k5DSgTbcOCBCgnewaAur
 2S431QLX6NDwYum1tIpL9EXf19IaXCX+fRo3DUg1meSJJc/zgHwYT1DF/cBs2Xs6MhVXwn8qz0g
 rx3vx
X-Gm-Gg: ASbGncvlNnk3n0SbG2hKBxEn3JQp0l/w2PHXVRLgHjt6YQ45VgOIC/dKKB3p98Ds3KA
 L7Ez4DOUnebiHLAFF8Cldk/chCdS7luHcaBKO1js9gqZUc2zN0fhP4u/e0gg+2saf8PEPlIlZsj
 zxFA3DlkHijh+m4E9Wv4gEgLgGcyKMAISGV5OFW0dc3iS/OxuuHeVktv14x/B0O8kXcFATN8bkO
 OqKT2PuvokBtAJ933PgfbouqQL+2Iz15tH0HQxeUhd+u/UYXf++1C+hgR8kaiwSet8aDH8XHp7K
 w6/6A+PfMErMGA8q5hN+CjuDLjTrJss/5fAvh9Nomse93XY1Sz7RHljCEHoenXmELR2w
X-Google-Smtp-Source: AGHT+IFN1h/RXdA0Jh/hV1pLVHPzTmznkgzvx+yQ+GGylgd2kWPJ3MPDAEGHjOBPhdHduMd2wJcQ9Q==
X-Received: by 2002:a05:6000:2910:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b497038e99mr2315760f8f.31.1751646357808; 
 Fri, 04 Jul 2025 09:25:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 059/119] target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
Date: Fri,  4 Jul 2025 17:23:59 +0100
Message-ID: <20250704162501.249138-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Emphasize the non-fused nature of these multiply-add.
Matches other helpers such as gvec_rsqrts_nf_[hs].

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-48-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h         | 8 ++++----
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index c4a208e3ba8..b741470b517 100644
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
index ea043367976..844d2e29e4c 100644
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
index baea6d8b894..4b7de5016ee 100644
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


