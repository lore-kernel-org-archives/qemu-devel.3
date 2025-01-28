Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28125C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcryw-0003ea-Rw; Tue, 28 Jan 2025 15:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry3-0002MH-5y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxz-0001eK-9F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso43264265e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095226; x=1738700026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZkhUreTLUpDn93S9pdTAdl/J0HU+hgVWVgZI7ELtdc=;
 b=sJcfkkukfeix0+pgsa9OHocChTDm8uLB69nZXAFUfYWWcN0+03AkR1wyzXKNTdJoL8
 NlTJbqUtzgs3TnpiGk5wNFqZ2Z1i632spFkC1gejct5p5+DBxyIlN/il1c8M+hnv2D4+
 y6mXtD/Nc7N8y7PE1ksG3BooikeDQdN7mokBoZV/t5H5ciCg6mchMULLMUsX850vCnL7
 WPhZH3j7CTXrRko52MHZXusfsDYQ4AItT6FeKrWh6jLG17ONWXslW7uXr25LiEmnZBbz
 ld6LmgPN3/I5qQgv9Wqz5HxqbYFSlUU7wWelQkk3FopmiEaBttU3Eq8fHfIqSFZSFoa7
 nFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095226; x=1738700026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZkhUreTLUpDn93S9pdTAdl/J0HU+hgVWVgZI7ELtdc=;
 b=RS+TCx3QMJEdV8Ux1S+PtVY/XXJH+IJEn8BfUXWkDOd5i5klNt/fOrxpbEDZPckUGp
 yQgW03Qs+ZWqlabwlTIngfasGae7f8pQGQXXyQz6O/GYztvBoT63JWywboouyFwj2U3U
 1qdeGCfWRb9dyC6WNyQ/t0gahfXGRP+wgUjnlpdykftjeF7TNpo3CQdvGZ6N43In6Lil
 Fywbu12XpvQt4PtILPKyDPxr2vfhylQOjabCUW2us9WCa0zKNfwScnFRUbXTS698kJx9
 7Eh6asHgZ/xL7bgNbY8TdMs8/Zm1v4Ds1vYBtoubB7ldBwlhJSZGJATqRbo96JH6x8et
 6dqA==
X-Gm-Message-State: AOJu0YwAfNiVOuUWL0e23qf4YuHLRvVVpTg7DimQUlJ6gROX1jXR0n4X
 6//VeNmyaujvW5oFsWNIoCO0ASPpV5+4O9XPSsU+uH1Wvw7DMM/q9StkLCg9ZzNXMrDV+YRxZxO
 I
X-Gm-Gg: ASbGncvP30N4BK9WL1/APPY34rkxSkH7Y+tEd3XfpXsJ8IqpuBkm4xgMTjHavV/wbFU
 FSeknL2thJuia4WFpfvp879tickM8ebWWlzAnPgRBNZqt5G5Xogdv6QxWYuS2Sygj+wwwA4vMmh
 8NJF9rgSASyhgrkSCFPgOi31wSLsiCkLpWlsUTtBJC3phngzvJI5u5lp/rcp3ERJSX6BPk8/LHH
 iVNFu+GNBzh+cE73zCFZtJwD6KZn7ff1UeFp5FKooA54d4Ot2/vQssz5elSXz4nzj43jlbP4t0M
 wGQ7XmRRceLQXNKtM8CZgQ==
X-Google-Smtp-Source: AGHT+IFMI2sBf1NlSdHQGMa7Ay/HvY0t8LTlA9nZRedwM60TALxEOb/TyLYJkkaO04qxjQAw1R9UZg==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-438dc3a40d3mr2626545e9.5.1738095225798; 
 Tue, 28 Jan 2025 12:13:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/36] target/arm: Use FPST_A32_F16 in A32 decoder
Date: Tue, 28 Jan 2025 20:13:06 +0000
Message-Id: <20250128201314.44038-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the A32 decoder, use FPST_A32_F16 rather than FPST_FPCR_F16.
By doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_A32_F16/g' target/arm/tcg/translate-vfp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-17-peter.maydell@linaro.org
---
 target/arm/tcg/translate-vfp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index c82f41234cd..8d9d1ab877a 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -460,7 +460,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
+        fpst = fpstatus_ptr(FPST_A32_F16);
     } else {
         fpst = fpstatus_ptr(FPST_A32);
     }
@@ -527,7 +527,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     if (sz == 1) {
-        fpst = fpstatus_ptr(FPST_FPCR_F16);
+        fpst = fpstatus_ptr(FPST_A32_F16);
     } else {
         fpst = fpstatus_ptr(FPST_A32);
     }
@@ -1433,7 +1433,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     /*
      * Do a half-precision operation. Functionally this is
      * the same as do_vfp_3op_sp(), except:
-     *  - it uses the FPST_FPCR_F16
+     *  - it uses the FPST_A32_F16
      *  - it doesn't need the VFP vector handling (fp16 is a
      *    v8 feature, and in v8 VFP vectors don't exist)
      *  - it does the aa32_fp16_arith feature test
@@ -1456,7 +1456,7 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
 
     vfp_load_reg16(f0, vn);
     vfp_load_reg16(f1, vm);
@@ -2122,7 +2122,7 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negh(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2424,7 +2424,7 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16));
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_A32_F16));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
@@ -2706,7 +2706,7 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_rinth(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2779,7 +2779,7 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2859,7 +2859,7 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg16(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     gen_helper_rinth_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2983,7 +2983,7 @@ static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     if (a->s) {
         /* i32 -> f16 */
         gen_helper_vfp_sitoh(vm, vm, fpst);
@@ -3105,7 +3105,7 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3273,7 +3273,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    fpst = fpstatus_ptr(FPST_A32_F16);
     vm = tcg_temp_new_i32();
     vfp_load_reg16(vm, a->vm);
 
-- 
2.34.1


