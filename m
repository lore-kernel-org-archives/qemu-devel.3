Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E0CC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEW-0006hZ-6v; Fri, 24 May 2024 19:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEO-0006ZV-Ot
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEK-0005oI-07
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f32864bcc7so24957845ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592901; x=1717197701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2xFCppnIKFVialQo7UwJzgtJAAgE8nOt0WWcTAkceY=;
 b=gypTIJB68epyoYNrlrB18NUvsUl+V/DfYWda8p+nzYMjg1Rlm1dXKZsUm6r5riPG4s
 5UHyKzMrCBh2UNYdWwuGRjVL9zT4E74lBW/9LwzLp9UntgFG+GVQ09nt9f2GWPA9i6qr
 32PIuJpvhAbxhypmtWJLIi7OhaCXRzRntAUb0hNi7Hq9Is8fhzO3ygqIXzArthRZc1Ah
 ZD07f00gS+aknSg21gbvqc/So5pQ0VVM61EGNiLAQ0jVw1wRbwvtMGgbY4l9ThDVjae1
 O3Fl5vF9PPU0KQZle5RpT6kDbW8IGlOG/lqJml8/rEeFi/KPw3dumDSg6YhQphcazrKD
 qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592901; x=1717197701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2xFCppnIKFVialQo7UwJzgtJAAgE8nOt0WWcTAkceY=;
 b=BGtVFOIgMXoApLrfgB6Jg6KsS5UMejK1PuoQTftMWU/WmlAmUkxLRRr5xl3enrkZ0O
 KXgg6L2+1ni3CT08+D5QO12LX5WlMPDNcaiXSKhI+asGBV7ncimgzjiTO1iOiS0hRQUF
 U3qlHAuB1lbvKV7g8xtNI4ZQacEV+EI1JKlei+C/NK62PmcFHK8O5n9Z8hqfbS7qyP03
 YNdG2ylK0qO4vWsNzUoW2qzLbvW7POl/pGlzvgm648fvBcfniMU8FIo49F5fFTFGKNeT
 Jckvj1XiaiKtW4vc7VOUKDljMTekYZgzAoDFhHuKVRuno/BKPF7/bC44K8cr2kHxaVn5
 qRmw==
X-Gm-Message-State: AOJu0Yz8YI3M9luWRJtEAvpgTVxhmvD/ySFaxg+Ae960kN6c0XvROw62
 +8yTXLiF1kPQXNWQAe8YunCvtQNWSz2sU3eMoWB5jZVMLXqyRQbJ4+7PqGUm9q91ncr6VAnFV5i
 H
X-Google-Smtp-Source: AGHT+IEUVQbtE+LbmuqaYkwk0mABelVPtxg6b32Rz8NKZ0x+edBJl4L8XrOYNrtT0uF0znPpRBAnmw==
X-Received: by 2002:a17:902:eccd:b0:1e3:e39a:2e49 with SMTP id
 d9443c01a7336-1f4486da10bmr43862815ad.18.1716592901494; 
 Fri, 24 May 2024 16:21:41 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 21/67] target/arm: Introduce vfp_load_reg16
Date: Fri, 24 May 2024 16:20:35 -0700
Message-Id: <20240524232121.284515-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Load and zero-extend float16 into a TCGv_i32 before
all scalar operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 39 +++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b9af03b7c3..8e755fcde8 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -48,6 +48,12 @@ static inline void vfp_store_reg32(TCGv_i32 var, int reg)
     tcg_gen_st_i32(var, tcg_env, vfp_reg_offset(false, reg));
 }
 
+static inline void vfp_load_reg16(TCGv_i32 var, int reg)
+{
+    tcg_gen_ld16u_i32(var, tcg_env,
+                      vfp_reg_offset(false, reg) + HOST_BIG_ENDIAN * 2);
+}
+
 /*
  * The imm8 encodes the sign bit, enough bits to represent an exponent in
  * the range 01....1xx to 10....0xx, and the most significant 4 bits of
@@ -902,8 +908,7 @@ static bool trans_VMOV_half(DisasContext *s, arg_VMOV_single *a)
     if (a->l) {
         /* VFP to general purpose register */
         tmp = tcg_temp_new_i32();
-        vfp_load_reg32(tmp, a->vn);
-        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        vfp_load_reg16(tmp, a->vn);
         store_reg(s, a->rt, tmp);
     } else {
         /* general purpose register to VFP */
@@ -1453,11 +1458,11 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     fd = tcg_temp_new_i32();
     fpst = fpstatus_ptr(FPST_FPCR_F16);
 
-    vfp_load_reg32(f0, vn);
-    vfp_load_reg32(f1, vm);
+    vfp_load_reg16(f0, vn);
+    vfp_load_reg16(f1, vm);
 
     if (reads_vd) {
-        vfp_load_reg32(fd, vd);
+        vfp_load_reg16(fd, vd);
     }
     fn(fd, f0, f1, fpst);
     vfp_store_reg32(fd, vd);
@@ -1633,7 +1638,7 @@ static bool do_vfp_2op_hp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     }
 
     f0 = tcg_temp_new_i32();
-    vfp_load_reg32(f0, vm);
+    vfp_load_reg16(f0, vm);
     fn(f0, f0);
     vfp_store_reg32(f0, vd);
 
@@ -2106,13 +2111,13 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i32();
 
-    vfp_load_reg32(vn, a->vn);
-    vfp_load_reg32(vm, a->vm);
+    vfp_load_reg16(vn, a->vn);
+    vfp_load_reg16(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negh(vn, vn);
     }
-    vfp_load_reg32(vd, a->vd);
+    vfp_load_reg16(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negh(vd, vd);
@@ -2456,11 +2461,11 @@ static bool trans_VCMP_hp(DisasContext *s, arg_VCMP_sp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i32();
 
-    vfp_load_reg32(vd, a->vd);
+    vfp_load_reg16(vd, a->vd);
     if (a->z) {
         tcg_gen_movi_i32(vm, 0);
     } else {
-        vfp_load_reg32(vm, a->vm);
+        vfp_load_reg16(vm, a->vm);
     }
 
     if (a->e) {
@@ -2700,7 +2705,7 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
@@ -2773,7 +2778,7 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
@@ -2853,7 +2858,7 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
@@ -3270,7 +3275,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
 
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     vm = tcg_temp_new_i32();
-    vfp_load_reg32(vm, a->vm);
+    vfp_load_reg16(vm, a->vm);
 
     if (a->s) {
         if (a->rz) {
@@ -3383,8 +3388,8 @@ static bool trans_VINS(DisasContext *s, arg_VINS *a)
     /* Insert low half of Vm into high half of Vd */
     rm = tcg_temp_new_i32();
     rd = tcg_temp_new_i32();
-    vfp_load_reg32(rm, a->vm);
-    vfp_load_reg32(rd, a->vd);
+    vfp_load_reg16(rm, a->vm);
+    vfp_load_reg16(rd, a->vd);
     tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
     vfp_store_reg32(rd, a->vd);
     return true;
-- 
2.34.1


