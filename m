Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3098ACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrP-0001Vn-PM; Fri, 10 Oct 2025 09:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqs-000898-Bt
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpf-00043T-Rp
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1246604f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101606; x=1760706406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j0iNpEPyOXoxR+HD7jDgER++00Zbwcp5HlXjOGIfHEU=;
 b=iBBjw/HTOpymW8i9dXCoiHNpdYOu9UkNHnYEejd8HDvCgRfkJfOmFZ4mEcsqVj8+Tf
 oAt+jDeExpcvTDdu760Lfsn02BNvbVoBjbGv8wtmvFZKy3izrfdOsmLQJW4tJoSOEFLL
 SKNf70Lv6UXKKuEZ0XjW6c4pl/A7qhdfeqI62Gl8ntlEJpY8H6hj1eCLi/IgLwGrZqeh
 hKZt5Udt3SzCRohd1qTLOXI8bvcjvNsk4/gasNexPbRUXT+dgHxFsBIg771SDlN7Xs7r
 hDeYkzYtEeOWV33pItrTPpyGOj/eR4uwvNTWOIZn5EfLODTbLgQGVMLjyWhY1U/n2b2d
 gxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101606; x=1760706406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0iNpEPyOXoxR+HD7jDgER++00Zbwcp5HlXjOGIfHEU=;
 b=wyzLqea4v/8fksPddyoJz1APzUb7fsrgUvt4H2u0/j4mtdbbUxOXspg2OjRJjPYACX
 3KtdJ+pwdw7A8ylL3JbmD4TwzM0V34tvH7QJ7KkKl/iwM8585/hH9BYOOLGAMDXOstfN
 qbE5EfUQ3XKWteBfheXT7w7NrGIzz78ZRCQB9SnFPDr2HfLMoRYTvQOpppnNeBtV78ld
 GQgo2CL5FfULvz1dwrFzXvf2FvOVqB01PQoHvCPRrGyuRmNRxLRTfZZ6qAhLRvUTOps9
 J6vUWQEYICr0QB3FLsxJQLt6D0XY/4yxLSnpLiISBQWMb+eM4Ih1nCCZdkDPeN63G4Rl
 3L7g==
X-Gm-Message-State: AOJu0Ywo2tkRbHUdvZaCKJRxxN64ZQ/PfnZZJrscfgRqRCgPSlnoAq5+
 LnqKmWzXHQfQwxNaxdj9yYodqC4+XgBF24NOZVYLmQsTURPFzCKqtYhJDvyj9caxf0gYgrVQPjW
 FtQIl
X-Gm-Gg: ASbGnctMohOkU+qCc6q8SNQMztAzwuzPUI5aaduOa/anYIi447ZGEbtFylOf/W++hBa
 WD/EMqtfacI7VVuHYw5x5YsQKgBwqaNgmeJY1dNwlNs7WCuR/CRrXxU+eO35Ah7ZzJVi5HJyOv9
 VD18lcwX/Hkl63/CnXvqkXvIQxtALNHEhMOADSsJt0A6BJa6Ubf3IAKSO7J3PdUiyTz8xmcai2D
 wikxpaJ1hYyLL7FTVUUd5OlQt22swOQbRa7Zdi0xVOEi2gZiIVXcUgmysCrvH5k2TKYTipJbrJT
 sc1zMd3iRGhhbnuuLu9I3s1GKSd75ZN5DCeRGWeCERpGc1j7Z1h3HfYzYF8eF60xTrntI8qjAmB
 Xe2WZPw3K8G+ro1vwMqnNWEL0wv5XhlmDurFSAr7fN23pSapebnM=
X-Google-Smtp-Source: AGHT+IHouSz6WizVy+7+iM0oXDtlpmujPA+EG7ZiKu0LB1y3O8T9A5WHtKMRDFv78HqVYJUJyqUh9g==
X-Received: by 2002:a05:6000:2305:b0:3e9:9f7f:6c36 with SMTP id
 ffacd0b85a97d-4266e8db5f6mr6843595f8f.54.1760101605967; 
 Fri, 10 Oct 2025 06:06:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/76] linux-user/aarch64: Generate GCS signal records
Date: Fri, 10 Oct 2025 14:05:20 +0100
Message-ID: <20251010130527.3921602-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Here we must push and pop a cap on the GCS stack as
well as the gcs record on the normal stack.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-70-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 138 ++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index ef97be3ac7b..f7edfa249e5 100644
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


