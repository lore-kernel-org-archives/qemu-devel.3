Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982E2CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jQ2-0004Ke-Qh; Fri, 03 Oct 2025 13:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLg-0007i9-OV
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKD-0007ui-8t
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3495375b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511524; x=1760116324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=JHK2p7tKJAFNh9fpzutI8AGUdj0SSJZQa2NnAdIxKl2+yhDIyIHdkcfc+S4M2lJ7t0
 tLxdwpi/cqtt6/dywg0IXl4VbcRoLe6B/ccBEuORvV7odZTISS9eoVR8ugwiNYKpUjK8
 2MTNvrBpf+NEY3QpncH6tYGK7V4wupOttEuTTNs1lWNsrn+jxLBStpu1DEshjVC/riSp
 mkGH1tOwpGK5Qxl1OU8/p3zz/xJLoGWLGmzUFlTRL7HznrD52Xipju+Z7LhUdRvCgLzD
 CmyujaupDQdO6c+OYfRPTPEtqewlxpByXmuWNF/Pxi/OyR6lz5xoYoC1GddNYpxgj4dF
 19Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511524; x=1760116324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=tSfVI/+uGGhnqJ1MJa9K7A2nYRxma9w/OiUUm+/l3ybP0cxzAyCngE9JWagu7Vbx2o
 xgVBoLT+UULgFQkDF/JYm9Z9qDo7sIOePcG163gmyaa8uIaxGzObVTdDphgHRvnYmfQ0
 gl9EA/Z+brPmCDHm6/PCJFdSSA+NwrtLQmPahIiiuxo7j5vzzMAzk8p64b8Of0Y3Cdch
 XD+CFy/+EGbc6W0K1pX8q9oMVHQm1ziza9ZcJcu1U9ydPR6BusTcnbpTwW3T8avDHPaU
 Yrf/OyZ3CTVpm1PQiO0P0aV2zaoZHz8K68yEJVJ64N479o/EWxzvNoQ1T9YU5IKG6Eif
 UAFw==
X-Gm-Message-State: AOJu0YyXy5acUYJT7ktP16KYsCwt+sqtwFnwEe9c6ZjTusDLd0kNKq3Q
 isIyRbm4jl0U0ZmipYpb1k97yiKJ66D4vIJIh7TvYiuVT7EIjVr26H2pwZ5Xu6DoLRJ7jGvxfoV
 rFE/wZUg=
X-Gm-Gg: ASbGncu2wlEfIj/sqkYJJv9eVvdld/X37IfMZJIdbM70haud8Ib9IA52/7tlNfHLVYA
 I3Sxa2iXksJ6tBxrIJg3M1+DXdNCOVIQQnWazudb2UOKmvA6ugEsFvA3VpoVEGGNIDfcbgckPGi
 +x4fy2upZCVMJdRa5HC5s/GzC7tZa8vCT0hqXQzeIx8w01uKdwf+BKKU4A9tJ3mh9ztntGt7w02
 1b4iuXxqLr0B4FesCqWttDxIKnP7ocILr/E+Ss35XGbAuwu/wd+J8krGIBrDer4iRtmFpeE6h5W
 14Pv0vwGEawr4gzKmbEFOBdPycx44qPRYAOsAv1VjrTe+o+Dr9IJ5SRMtlRcBUYthpybPNyN88P
 uOWt5wTZK7HoIbG/lO90zr3zGosLUyYhnfGGRq17RDBO8g4qW+cGXpc9V
X-Google-Smtp-Source: AGHT+IHbH4XO0Yea9T8dtr6uh5NXxNJef2q4j7J/42XXfaicsF2bWwMMI9CE/FH6o4m5d01uKf7qug==
X-Received: by 2002:a05:6a00:b8c:b0:77f:4b9b:8c3e with SMTP id
 d2e1a72fcca58-78c98dfda99mr4570476b3a.22.1759511523862; 
 Fri, 03 Oct 2025 10:12:03 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:12:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 69/73] linux-user/aarch64: Generate GCS signal records
Date: Fri,  3 Oct 2025 10:07:56 -0700
Message-ID: <20251003170800.997167-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Here we must push and pop a cap on the GCS stack as
well as the gcs record on the normal stack.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 138 ++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index ef97be3ac7..f7edfa249e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -22,6 +22,7 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 #include "target/arm/cpu-features.h"
+#include "gcs-internal.h"
 
 struct target_sigcontext {
     uint64_t fault_address;
@@ -152,6 +153,16 @@ struct target_zt_context {
 QEMU_BUILD_BUG_ON(TARGET_ZT_SIG_REG_BYTES != \
                   sizeof_field(CPUARMState, za_state.zt0));
 
+#define TARGET_GCS_MAGIC       0x47435300
+#define GCS_SIGNAL_CAP(X)      ((X) & TARGET_PAGE_MASK)
+
+struct target_gcs_context {
+    struct target_aarch64_ctx head;
+    uint64_t gcspr;
+    uint64_t features_enabled;
+    uint64_t reserved;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -322,6 +333,35 @@ static void target_setup_zt_record(struct target_zt_context *zt,
     }
 }
 
+static bool target_setup_gcs_record(struct target_gcs_context *ctx,
+                                    CPUARMState *env, uint64_t return_addr)
+{
+    uint64_t mode = gcs_get_el0_mode(env);
+    uint64_t gcspr = env->cp15.gcspr_el[0];
+
+    if (mode & PR_SHADOW_STACK_ENABLE) {
+        /* Push a cap for the signal frame. */
+        gcspr -= 8;
+        if (put_user_u64(GCS_SIGNAL_CAP(gcspr), gcspr)) {
+            return false;
+        }
+
+        /* Push a gcs entry for the trampoline. */
+        if (put_user_u64(return_addr, gcspr - 8)) {
+            return false;
+        }
+        env->cp15.gcspr_el[0] = gcspr - 8;
+    }
+
+    __put_user(TARGET_GCS_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(gcspr, &ctx->gcspr);
+    __put_user(mode, &ctx->features_enabled);
+    __put_user(0, &ctx->reserved);
+
+    return true;
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -502,6 +542,64 @@ static bool target_restore_zt_record(CPUARMState *env,
     return true;
 }
 
+static bool target_restore_gcs_record(CPUARMState *env,
+                                      struct target_gcs_context *ctx,
+                                      bool *rebuild_hflags)
+{
+    TaskState *ts = get_task_state(env_cpu(env));
+    uint64_t cur_mode = gcs_get_el0_mode(env);
+    uint64_t new_mode, gcspr;
+
+    __get_user(new_mode, &ctx->features_enabled);
+    __get_user(gcspr, &ctx->gcspr);
+
+    /*
+     * The kernel pushes the value through the hw register:
+     * write_sysreg_s(gcspr, SYS_GCSPR_EL0) in restore_gcs_context,
+     * then read_sysreg_s(SYS_GCSPR_EL0) in gcs_restore_signal.
+     * Since the bottom 3 bits are RES0, this can (CONSTRAINED UNPREDICTABLE)
+     * force align the value.  Mirror the choice from gcspr_write().
+     */
+    gcspr &= ~7;
+
+    if (new_mode & ~(PR_SHADOW_STACK_ENABLE |
+                     PR_SHADOW_STACK_WRITE |
+                     PR_SHADOW_STACK_PUSH)) {
+        return false;
+    }
+    if ((new_mode ^ cur_mode) & ts->gcs_el0_locked) {
+        return false;
+    }
+    if (new_mode & ~cur_mode & PR_SHADOW_STACK_ENABLE) {
+        return false;
+    }
+
+    if (new_mode & PR_SHADOW_STACK_ENABLE) {
+        uint64_t cap;
+
+        /* Pop and clear the signal cap. */
+        if (get_user_u64(cap, gcspr)) {
+            return false;
+        }
+        if (cap != GCS_SIGNAL_CAP(gcspr)) {
+            return false;
+        }
+        if (put_user_u64(0, gcspr)) {
+            return false;
+        }
+        gcspr += 8;
+    } else {
+        new_mode = 0;
+    }
+
+    env->cp15.gcspr_el[0] = gcspr;
+    if (new_mode != cur_mode) {
+        *rebuild_hflags = true;
+        gcs_set_el0_mode(env, new_mode);
+    }
+    return true;
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -511,8 +609,10 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_za_context *za = NULL;
     struct target_tpidr2_context *tpidr2 = NULL;
     struct target_zt_context *zt = NULL;
+    struct target_gcs_context *gcs = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
+    bool rebuild_hflags = false;
     int sve_size = 0;
     int za_size = 0;
     int zt_size = 0;
@@ -582,6 +682,15 @@ static int target_restore_sigframe(CPUARMState *env,
             zt_size = size;
             break;
 
+        case TARGET_GCS_MAGIC:
+            if (gcs
+                || size != sizeof(struct target_gcs_context)
+                || !cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
+                goto err;
+            }
+            gcs = (struct target_gcs_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -612,6 +721,10 @@ static int target_restore_sigframe(CPUARMState *env,
         goto err;
     }
 
+    if (gcs && !target_restore_gcs_record(env, gcs, &rebuild_hflags)) {
+        goto err;
+    }
+
     /* SVE data, if present, overwrites FPSIMD data.  */
     if (sve && !target_restore_sve_record(env, sve, sve_size, &svcr)) {
         goto err;
@@ -631,6 +744,9 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     if (env->svcr != svcr) {
         env->svcr = svcr;
+        rebuild_hflags = true;
+    }
+    if (rebuild_hflags) {
         arm_rebuild_hflags(env);
     }
     unlock_user(extra, extra_datap, 0);
@@ -701,7 +817,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -720,6 +836,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                        &layout);
     }
 
+    if (env->cp15.gcspr_el[0]) {
+        gcs_ofs = alloc_sigframe_space(sizeof(struct target_gcs_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -779,6 +900,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        return_addr = ka->sa_restorer;
+    } else {
+        return_addr = default_rt_sigreturn;
+    }
+
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
     if (esr_ofs) {
@@ -786,6 +913,10 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         /* Leave ESR_EL1 clear while it's not relevant. */
         env->cp15.esr_el[1] = 0;
     }
+    if (gcs_ofs &&
+        !target_setup_gcs_record((void *)frame + gcs_ofs, env, return_addr)) {
+        goto give_sigsegv;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
@@ -811,11 +942,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     __put_user(env->xregs[29], &fr->fp);
     __put_user(env->xregs[30], &fr->lr);
 
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        return_addr = ka->sa_restorer;
-    } else {
-        return_addr = default_rt_sigreturn;
-    }
     env->xregs[0] = usig;
     env->xregs[29] = frame_addr + fr_ofs;
     env->xregs[30] = return_addr;
-- 
2.43.0


