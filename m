Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7696CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMzS-0003Tg-Rd; Wed, 24 Jun 2026 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMz7-00038k-CO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMz1-0006O7-Kv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so6729115e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782305133; x=1782909933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGo6vKVJEYEOj+aiq6rUlEcybCfYIVgnGO/BD7j/21A=;
 b=DNOxWnSS5d2NjHCbIuPgOEJ6R9ppgjqi34IcNLxulYOQp1YnfPjlJsubE9LWAdb1OQ
 w3VHk1JdlokCa5Re0ZyZXaG+l9paAvsT9S/HX4bJJBEr7/G/wNmlEmsgFZ45lssjVcU+
 9vsc2ljGjH5Ujl1z738mklxRDo+r5GtCEVK5aokQW2SHi3vFt8r42FGpTROoutyHrUME
 g9RM/j0u/hDNEsR05ZbkD60ln1AV36xiQmqk9gI+l0ruQ7Tg6EsXSpH4VKhlKzxSp0Nl
 LBHQ9VxDgKh81lRI+ps9kW0RG3Z9IpuJJe4/BHKosHldXL+Hewxf7yCiS5nyU6Ny6PPY
 Nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782305133; x=1782909933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HGo6vKVJEYEOj+aiq6rUlEcybCfYIVgnGO/BD7j/21A=;
 b=lzsR7EsrRbJeQvyv6XJEHfDFMYykwaT3llDAsDlyDFXbxi+++6geOZkwDFu+ByY7BD
 AyMFqLKY1aYDAI4SEfeS4XlbGJapCu/wVnZBNL4N0AQEXePxb1UQffzoEdYNhb/7jPaF
 V/Lm70nY38d7yJvCUOJha9jyQXKgIzGa8dRurp16avxqdCS9HSDy/WJXX7yl++rh7fwc
 zAG0Iz1GYvM58qfRag1BsKVGdBVIguzLiNG5PzVzr/QiCA8OvzVSq4Rk7yurJxh4qUyx
 4ZDxVPo+UrOsLU55+Tlkkg14FSWWLyJvK4QCBmIXgf3cNNiLznbVvowbqrK2Dd6AEzLO
 nQsA==
X-Gm-Message-State: AOJu0YwviG5lYV3bWxsuJk65jcG0hovTAaYqEEzmYsBEAKYVEplByKC6
 ihtebB/FTFUwHcOG0hH9QL4wBpaesci/dz4KsC6k/K6WwzsnHg5m4tqj9cTypk3SJqM=
X-Gm-Gg: AfdE7clCDOaHUUbvfwzn3IZZdlKFhg8OrjleTbU3ZftUCYKDvvIRA2tAt9X5o9gkI3/
 JhmKhUHkmiXiWFN2lC4zt84JVpXSZtv3bf2dg9xJGUDk+I6L4mLayQBKSf1febjCKRmiTjVcaRo
 4Wu9onNe4RUkED957psHUl37ULqVhxBIp4+ZYqH7naAJ9LYjB4zZBssW/zq5lgGWbdz2IQahnJy
 O81Iq64zZGQPR0xRwOkztU59ByJGeaY6VUyK2aCvSjOV/SIgAPCF13GpzBdkqK4t3B2bmfjTWoF
 BiNB0lvaJy0iVCH7bFfJfm/f6h6+UCFrnG2r5GXPwrzuCvGsUT0/Ma1lw0KaL5tDjAwzr2KPAux
 9ouI1Zdl9ZN07T/b3elgHi2qxzVLlcqizwMdLWXXL872YTojtm2OHlLfPjx432aO7PiE4u5Ysvl
 56A6MRQhoj5qeo
X-Received: by 2002:a05:600d:8443:20b0:492:1e36:85dd with SMTP id
 5b1f17b1804b1-4926088044bmr32603205e9.37.1782305132781; 
 Wed, 24 Jun 2026 05:45:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d46sm5782310f8f.13.2026.06.24.05.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C35D5FA5C;
 Wed, 24 Jun 2026 13:45:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/6] target/arm: trigger timer recalc on HCR:(E2H|TGE)
 changes
Date: Wed, 24 Jun 2026 13:45:26 +0100
Message-ID: <20260624124527.1018912-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624124527.1018912-1-alex.bennee@linaro.org>
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Toggling the HCR state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - defer calling gt_recalc_timer until after we set hcr_el2
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4273e3c5395..b163dc5764f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3716,6 +3716,7 @@ static const ARMCPRegInfo v8_aa32_el1_reginfo[] = {
 static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
 {
     ARMCPU *cpu = env_archcpu(env);
+    bool hcr_change_timer;
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         valid_mask |= MAKE_64BIT_MASK(0, 34);  /* ARMv8.0 */
@@ -3807,6 +3808,10 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT | HCR_FWB | HCR_NV | HCR_NV1)) {
         tlb_flush(CPU(cpu));
     }
+    hcr_change_timer = (env->cp15.hcr_el2 ^ value) &
+                       (HCR_E2H | HCR_TGE);
+
+    /* update */
     env->cp15.hcr_el2 = value;
 
     /*
@@ -3828,6 +3833,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         arm_cpu_update_vinmi(cpu);
         arm_cpu_update_vfnmi(cpu);
     }
+    if (hcr_change_timer) {
+#ifndef CONFIG_USER_ONLY
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+#endif
+    }
 }
 
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
-- 
2.47.3


