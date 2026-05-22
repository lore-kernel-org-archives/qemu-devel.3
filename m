Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFE5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY0r-0004w0-9M; Fri, 22 May 2026 18:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxx-0007lh-3U
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxu-0008Ka-Ta
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so5145291a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487412; x=1780092212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaaVtxE8Td6jvB18Vve34OKkbWHvZ7daRwPQB8xezVs=;
 b=B0pDWkxSw+q85S1yFsX6czeqCmSamHxO80zf/EOsYAo26y093zmpvudV3Nel4/HosO
 RVZfv3vYO6EaHEftX3NebC3tyaBqFA3LX3w6zTOuC52/YIdCPyZELOOcsinMdjbtFZPs
 3S8SbdazRAUdIa5bKzmLnQ/isgNF1NsJHy/oDyhvxwSqFNplLZ5vgC41gWZvbKHGASCo
 NYnO66bFdDFkt5dO8JyCYZa9IZdTXgs9joldqNsMjhlbt4fio3z4UEqUnIrpOXs/A88R
 W4umDmMILiFYpH+bNFJDvoXOD/HOMixLaGPOz8P8CIgbaz2YCdFRHfRZFwfjmdRXlSQO
 b2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487412; x=1780092212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gaaVtxE8Td6jvB18Vve34OKkbWHvZ7daRwPQB8xezVs=;
 b=gaiTaYTVGNpGcDAJ9yjKoHJ5ExGpLyB+UQPTKqvfPIaTnid7DZ7ISAHLCldap+QmJD
 qtnCW/yAQ/CcKQqc5KkQQq2gF+5ZQU0+GWzQzeuCR87ppvvBwoMOKpduAQHAy/G0LlLg
 QEqF1sd6IbuxLV30XaFLin8iVkQKtkZK2S/xLLO/PWBaPLVqWJ/5a+eVBKzNCqoX+Fsp
 ZaNZCAcuzevoh5siZ+qFTIfnTtBDjQdR/FWqBt0nC47BB0oviR2h7Aw1DGcgDLoAOq0e
 sFTPZCAYesR2Pvl/TfBE6USwO1QOShm3S5+S018arAssMCLYo5trlQTp/Uf9sU49rzX3
 hdfQ==
X-Gm-Message-State: AOJu0YwBXIsrsbT4uOtr4glF79E/3s7v36ONKJpHmbxYQpHHTPvB63cV
 6VhFruH6oWHI5770LWcZM4if/3RUWhqMLFpHPZfRwDyUYHQOED7EsskzUS0cER87v9HKDy1Oacy
 QIpzD
X-Gm-Gg: Acq92OGwG3+ukQO4Lxg/Xa7SZfF0KtJORHjrMwTngX1lBEi1XCas72PTPpTxCBdDHhO
 w7FiDalxC5ERY5s4bxmilBqUkBgQvxULfs+6jLTxtMECyRhKzt+keTwLfy1Jx+RytQ1qtUZgBiz
 Vs5haEV5iY3tp281S6A1TmKIm5dgbCfyukvSqSg8NrIxVR2JfVupmhbFjx6tp1O1EBY9OJGWOVk
 iODZcDmte7qVgd+yC5T0vWxeXhdbo4kaj53hJ1AFAH+HTHXRV/Ah4deVFwJDpGy0PEMRMV6fK8v
 AW5euiKsXsixR8qLsuqGKr4Rv7wIzeAGdO75QeqbU5IWacSypj3yrE6ReZGyAB9fSkpzDdy2pHN
 Ie65dXFn/QoGy7T8eQELZiAyTiD87UhYdpIfqmgFwZdK/K7aR+LYavnl//q7BReZOCiXKpBPrJa
 U1bzScuzUOyKqyu7xZW0niusVS015O
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-36a6787b0dcmr5279630a91.23.1779487411892; 
 Fri, 22 May 2026 15:03:31 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 24/64] target/arm: Introduce arm_init_fp_status
Date: Fri, 22 May 2026 15:02:26 -0700
Message-ID: <20260522220306.235200-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initialize all of a float_status settings in one place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a..4ea076fe4b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -304,6 +304,22 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
+static void arm_init_fp_status(float_status *s, bool ah, bool fz, bool dn)
+{
+    memset(s, 0, sizeof(*s));
+
+    if (ah) {
+        arm_set_ah_fp_behaviours(s);
+    } else {
+        arm_set_default_fp_behaviours(s);
+    }
+    set_flush_to_zero(fz, s);
+    set_flush_inputs_to_zero(fz, s);
+    set_default_nan_mode(dn, s);
+
+    /* We want 0 for all other settings. */
+}
+
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -626,24 +642,17 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
-    set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
-    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
-    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
-    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
-    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
-    set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
-    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
-    set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_A32], false, false, false);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_A32_F16], false, false, false);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_STD], false, true, true);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_STD_F16], false, false, true);
+
+    arm_init_fp_status(&env->vfp.fp_status[FPST_A64], false, false, false);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_A64_F16], false, false, false);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_ZA], false, false, true);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_ZA_F16], false, false, true);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_AH], true, true, false);
+    arm_init_fp_status(&env->vfp.fp_status[FPST_AH_F16], true, false, false);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
-- 
2.43.0


