Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C39C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJs-0003mM-8Z; Tue, 30 Jul 2024 12:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJr-0003i2-6D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJo-0000Hd-3y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so17930545e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355398; x=1722960198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u/1r/oeOEIAX2gVU8SoWnDp6iCu5q8o/SWMbeXFkLdU=;
 b=XhRvqy8JslX+a0T971HQhfSvFmuFR9lctr81xCuSIMvOyvMduFb29uvBRWhMRxQdL1
 AZtRSmum/sBOzOO/3LNNbOZ9ZpgDoNTEc7yLZviih7a5BJ01p+SfrufyxcrNDojsnDcJ
 T+WfWrzVeTYWuGbPJkgkC97b+bsZYgu5HYey7RkDxRcmc+kTlMp6PIwcb5sK72W11t5r
 fzSEIM+z1kWczybpV6MT423jjRCuR+cBExj2GaPa9rY0t9EhWDh5Uy8I1ZImzyfcX0Om
 gwxrX0mpuGrS8nXLzToFRJ7Y8nqSc3ScJtmYszWcMxPiWv8o13LTHW/CBzi0t3MfLraY
 g0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355398; x=1722960198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/1r/oeOEIAX2gVU8SoWnDp6iCu5q8o/SWMbeXFkLdU=;
 b=AyDmFEdYlDukcGKw0n4Is7+9JmzXcdy3HHRE7A+YZPHHCENWhCJiWwNSK5kDziGVP1
 X60uptgGOuSYgWSzCpPpRIVeEBTmB8l0ZCfLhK0sOkRIIvq+IwMfhYNwJdHaD5vYJBAq
 N+Vfkkt1oVHMsegDvXiXm7768BM8sZsMIQT4Tyd9TXnEaMnrexc8d1Gitzmy86b6bGqj
 zX4Sp2mBjBwLlyd9TL2qCTW0nRCd8Gzx77gnp99Kwg5OKMfMgBXjXF3kjqrx8vtAL9Zd
 LmDxedbrtTP0RnWepKasJZkZbDLSO9UeTrYQqJi/1g1LfAn2wcFGJjB5IXDz4VIao8rN
 zDHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnjA+ULUV0Wni8OmcDasS33PzwZGL6sFBEZoeQ2A4pAuwEtC1PQcy5rIRDJN4TSiM3k56wPSjsiO9oUV6g1/ZIghic4eQ=
X-Gm-Message-State: AOJu0Yyf6CFeiDfxE9PElE90AjnCzTD0iLibud7Q6ks8AP3ipfzIuWqe
 rD+om8EePdCF+7mgBhgChSx10+9/L2AP3oCF8A8R/pouAkG2k3kv0RDsCTpdnPM=
X-Google-Smtp-Source: AGHT+IGbDB84jhqyhx1wPLgBsFnr2qZy88dXU8Oz4wWTo4/y8BYNNlCQJwdAfmu5RfYWLFfj8AcdNQ==
X-Received: by 2002:a05:6000:1a51:b0:362:2af4:43cc with SMTP id
 ffacd0b85a97d-36b8c8e6637mr1913162f8f.19.1722355398465; 
 Tue, 30 Jul 2024 09:03:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/8] target/arm: Pass env pointer through to gvec_bfmmla helper
Date: Tue, 30 Jul 2024 17:03:03 +0100
Message-Id: <20240730160306.2959745-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Pass the env pointer through to the gvec_bfmmla helper,
so we can use it to add support for FEAT_EBF16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 4 ++--
 target/arm/tcg/translate-a64.c  | 2 +-
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/translate-sve.c  | 2 +-
 target/arm/tcg/vec_helper.c     | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 386cf8686ea..93b830d2cce 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1032,8 +1032,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a4e9740c921..33d49f524f4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5630,7 +5630,7 @@ TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfdot)
-TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfmmla)
+TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfmmla)
 TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
 TRANS_FEAT(UMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_ummla_b)
 TRANS_FEAT(USMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usmmla_b)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 7de157c539c..13cd31aad42 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3730,8 +3730,8 @@ static bool trans_VMMLA_b16(DisasContext *s, arg_VMMLA_b16 *a)
     if (!dc_isar_feature(aa32_bf16, s)) {
         return false;
     }
-    return do_neon_ddda(s, 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_bfmmla);
+    return do_neon_ddda_env(s, 7, a->vd, a->vn, a->vm, 0,
+                            gen_helper_gvec_bfmmla);
 }
 
 static bool trans_VFMA_b16(DisasContext *s, arg_VFMA_b16 *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8876d1f91a9..95e938662ed 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7123,7 +7123,7 @@ TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
-TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
                         gen_helper_gvec_bfmmla, a, 0)
 
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 1edde9792f0..77efb5f47d8 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2847,7 +2847,8 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
+void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
+                         void *envp, uint32_t desc)
 {
     intptr_t s, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
-- 
2.34.1


