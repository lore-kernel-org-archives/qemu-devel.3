Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D931C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSO-0000o0-KO; Mon, 17 Mar 2025 10:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSG-0000fs-GB
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSC-0001DX-DB
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so10336575e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221710; x=1742826510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IGKVMeg4aDxvbEQfJftU83jMmdBHS/KLNHZo9WpIB6Q=;
 b=KgPl5X+vBGiWG4s0QK/MBma0/dJNievroG8yTAHVEzk3Zt5NYmkFyX1i9H20fgGTa3
 2DCPfEN3tMKbQofs3wuuM2z7HUEOuld0l0JNs+xzL2u3s2XXgXEOUA9OEqK5TBV16mTZ
 dn4maArEOH2BcVQO9T0ywJAiL9K77e5gRGzkp9xiyeLKMXFbAHb7JuwO/mPUvxea3doB
 MInur6daRYUBA7axJm2mzUjd+WpbX5nJI38dXvS4s7cpZOwB6KxqmjZc8vfAhGzBgkgF
 TO6zzCj0pC3/GS4cca1FM/dP7/DjHGa+mKx3IJbAF8Dp8Ps1liUK2o4f9FWYJXqHxoeY
 BnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221710; x=1742826510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGKVMeg4aDxvbEQfJftU83jMmdBHS/KLNHZo9WpIB6Q=;
 b=EgZRMA0d8bg/VrZeDCfO+Ttms5VehwLfAtlqEreO6Wv7Uty5j29oPx7QnVWkOPazSN
 Dsn07cvJPnbaSNpK5dWtI6luvcLhro23FkF/O+X04I2Bf1F1Df42KBZJWdfQ8eRq1+bz
 i157JVaGTgv12IzVAzUhE9JS5LUIyHVL2MiPYDJ85/pYdGK7FHoCNUbImcl28ocVfQDX
 9jaDzxLxeFtTC77XLuVMf3vN++GYutSMjpBFs0S/h3iYcwB9x7PCjcCa5lXCXRSdzxRq
 v4THRDlB9i9PWoel8YKSw/I/zNZE52lr2g+ReGss4SK2wmvZL+1+j9+URGmbids/y9Vb
 RyHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9zBg6MIZZ0F4mq3cqKq42GxbFvxRxQVDOOGt5dBf3+LY+wKEMKgkj4wnQB/dsi13Wmc6bbHVOW/3F@nongnu.org
X-Gm-Message-State: AOJu0Yx0ehbhQoseVqqkdhdYiPs/bDMOOsio3XCnj7ZBXNXebGDgRN28
 CUEVme3XPnDo69B9kCHZ+pall4mWgbwDgwjfXM+VU1jqdjZ1FY1BiyaF50Mk/EnPWYugAfP4JeG
 1
X-Gm-Gg: ASbGncu91MbLvMD5wmbbkVwdAt6l5cFzeZ7K7SIdv/A21H/Nhxl4EkCAtvSr9aD4eLh
 7cWwRXijdM7ghQAyammZQYxgVfcy4csdx7XTQQVJ4OybVCb/DfWCICJjos80/ZgcWFKUl2sb5Vm
 8FUEAnQSg5fbMkja+MosvafQrapc6NUvtvF+uX0vlKatEXkuXhKu8q8Rjhlrz2iBhZAVe/YQxBa
 alXgpnqvJnDfVi/11Npn5ISgG4XyPRnURmJlsmBo5vsKYc68SleODs5Z1gozJ5IuMS+A/ieQ4bH
 pbZn9b+FzR0UYbQZskOdvbIaGFLm83AvMZH/zpjRJqVnnQYuhJG2LOYj1eTaSQ==
X-Google-Smtp-Source: AGHT+IHjQSceXaoTiB7jwNXtux+dMPc0ELOg/8WD+nn1wAZVcN96rMvzmT0XM0yTabxYV+MCitMQYg==
X-Received: by 2002:a05:600c:3c99:b0:43c:f597:d565 with SMTP id
 5b1f17b1804b1-43d3897499bmr577705e9.12.1742221710402; 
 Mon, 17 Mar 2025 07:28:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 9/9] target/arm: Remove TYPE_AARCH64_CPU
Date: Mon, 17 Mar 2025 14:28:19 +0000
Message-ID: <20250317142819.900029-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The TYPE_AARCH64_CPU class is an abstract type that is the parent of
all the AArch64 CPUs.  It now has no special behaviour of its own, so
we can eliminate it and make the AArch64 CPUs directly inherit from
TYPE_ARM_CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h   |  5 -----
 target/arm/cpu.h       |  4 ----
 target/arm/internals.h |  1 -
 target/arm/cpu64.c     | 49 +-----------------------------------------
 target/arm/tcg/cpu64.c |  2 +-
 5 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index b497667d61e..2fcb0e12525 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -28,11 +28,6 @@ OBJECT_DECLARE_CPU_TYPE(ARMCPU, ARMCPUClass, ARM_CPU)
 
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
 
-#define TYPE_AARCH64_CPU "aarch64-cpu"
-typedef struct AArch64CPUClass AArch64CPUClass;
-DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
-                       TYPE_AARCH64_CPU)
-
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8f52380c88c..c9c53a6294b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1161,10 +1161,6 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
-struct AArch64CPUClass {
-    ARMCPUClass parent_class;
-};
-
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a18d87fa28b..0c24208f183 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -350,7 +350,6 @@ static inline int r14_bank_number(int mode)
 }
 
 void arm_cpu_register(const ARMCPUInfo *info);
-void aarch64_cpu_register(const ARMCPUInfo *info);
 
 void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 49cf06a7bdc..200da1c489b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -781,59 +781,12 @@ static const ARMCPUInfo aarch64_cpus[] = {
 #endif
 };
 
-static void aarch64_cpu_finalizefn(Object *obj)
-{
-}
-
-static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
-{
-}
-
-static void aarch64_cpu_instance_init(Object *obj)
-{
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
-
-    acc->info->initfn(obj);
-    arm_cpu_post_init(obj);
-}
-
-static void cpu_register_class_init(ObjectClass *oc, void *data)
-{
-    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
-
-    acc->info = data;
-}
-
-void aarch64_cpu_register(const ARMCPUInfo *info)
-{
-    TypeInfo type_info = {
-        .parent = TYPE_AARCH64_CPU,
-        .instance_init = aarch64_cpu_instance_init,
-        .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = (void *)info,
-    };
-
-    type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register_static(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo aarch64_cpu_type_info = {
-    .name = TYPE_AARCH64_CPU,
-    .parent = TYPE_ARM_CPU,
-    .instance_finalize = aarch64_cpu_finalizefn,
-    .abstract = true,
-    .class_init = aarch64_cpu_class_init,
-};
-
 static void aarch64_cpu_register_types(void)
 {
     size_t i;
 
-    type_register_static(&aarch64_cpu_type_info);
-
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        aarch64_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i]);
     }
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 29ab0ac79da..5d8ed2794d3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1316,7 +1316,7 @@ static void aarch64_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        aarch64_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i]);
     }
 }
 
-- 
2.43.0


