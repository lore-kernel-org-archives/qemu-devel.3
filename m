Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE6CA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNus-0002rc-Mb; Sat, 30 Aug 2025 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELT-0005oM-HU
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:50 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELR-00042W-2e
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:47 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so2364977a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532503; x=1757137303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDcksatZM68Ouj9vpX+nhU7BNGlQ6N61jHkn+W4tDM0=;
 b=KRcAf6AYnZD/izpg1u3zrqtmzIQ5/Dq2R/nD4xXnQm1pKp+Ug+7wcovKOG2TaidI0m
 QZlUUpVDsLC6sjUQEuxCPqkG0hgk4ZjJfY6w4dtWFp6BB43Pis6vXm2nPu1BWYOChDvh
 SiRG+74/2bkzu17Li6pptw5Kc+uyrWUKT+cFU22Awlxnra894V6s2ilaaAZ1kElmQwMW
 Vj9NSVwUFwJvhlifckkXkM9wi1gxx2JbmeqF9sM2wxz52Mx/T1lGXlxrx3OGWuty1qS8
 dhPptsPppCOsmAneT9q2u+QMH7QS/nqSbejKzjTcXaW/fmbzZFJIWJyo5TWVP2VisDI6
 jbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532503; x=1757137303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDcksatZM68Ouj9vpX+nhU7BNGlQ6N61jHkn+W4tDM0=;
 b=OZZzoC5iYQJ7hvEZGAfUfYJWYjBjEL3qLBKStoNDSv/LtD7x+r83by3LmyjecdElvK
 7lCTP6nQYLpx4LAtiUwY+YBaVFp3D8K9dfL8xIuX4aiEdQTj7ROUF3L7az17yX+CveKj
 qRgsbQZHpmO9DpYsFbsqH/rNjefP7xKs6mD3oAjYFKNLYrc1CihYLY8FEUCcbJfOyCKZ
 70mHiF4PmNR26PFKSmwxCx6Lnn0p/oMEECeKAtoqvrMPxRm4bLfKbiubeXoDAw8p4OC6
 FDQRrx0NN89nwT2hBJQSmmtaxIrIY5w+cdBmZfLHEL7xMskvZsiK1VAKSDGwZ+i44G4a
 zJCg==
X-Gm-Message-State: AOJu0YxI6OT+LXvwG47DOqwoVKjuROTnxfGhTheqiP7jDpNRi3CMoAcS
 a13hSiMiYnEoK67VCPT62T8ZCBeheaZtf2DkFunCyRRgZvxX8pIHmUrgQaqzCguov6QPIVTG9xI
 4pCyNN8U=
X-Gm-Gg: ASbGncstMBxHSUYvvnLMUgxn2/qC0KzDgBOFu69i5Dcp6MQtY+ciA5KJUBxkC7+iYA8
 hJmzU1h0Xzi70zOziq7JigCyXtAHzqjZ5Us+NlltxhLgSmT2/WINkGh4gYjr5o0qxZQdXHZ7dc3
 gu72KCE1PQQDQwsnT6JLH/aHf82cNAV7+u/sIV1l7Mhi2b5ur/7Fy50PFHjOKco7D87W1Gc342p
 wsVyWvSsJauqBOWAlruu+2KRVxYQjbFhEWNsmNQIDOGsDa633duO9xAe2RIacpzEA6E6U7DiluJ
 BeYBsFcWAGwNILV6uYILOfCnyCKIvHzfK35C7SP/9OzZl2SAEV9MuHTyAUnPyC1eNUxXBhWZyWN
 WwCpoa7D0JG6+4O29ee7hQVxxm8HyEV09/V9MInUpT6GoDvqXE6z5HU4vPTKXTfMqGS8th8A=
X-Google-Smtp-Source: AGHT+IGOyvRwLXmZhane5c2TsXXguA2/Ksos3xEUyokraPWcqT6Ro/J3wNnbFwyEbDtB0iZMRYNI4A==
X-Received: by 2002:a17:90b:52cf:b0:31f:5ebe:fa1c with SMTP id
 98e67ed59e1d1-3281531fb6emr1499463a91.0.1756532503144; 
 Fri, 29 Aug 2025 22:41:43 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 03/84] linux-user/aarch64: Generate ESR signal records
Date: Sat, 30 Aug 2025 15:40:07 +1000
Message-ID: <20250830054128.448363-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  3 +++
 linux-user/aarch64/signal.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7ad26316de..6060572eed 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -33,6 +33,9 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
     uint32_t syn = env->exception.syndrome;
     int si_code, si_signo;
 
+    /* Let signal delivery see that ESR is live. */
+    env->cp15.esr_el[1] = syn;
+
     switch (syn_get_ec(syn)) {
     case EC_DATAABORT:
     case EC_INSNABORT:
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 668353bbda..ef97be3ac7 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -65,6 +65,13 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
+#define TARGET_ESR_MAGIC    0x45535201
+
+struct target_esr_context {
+    struct target_aarch64_ctx head;
+    uint64_t esr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -201,6 +208,14 @@ static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
     }
 }
 
+static void target_setup_esr_record(struct target_esr_context *ctx,
+                                    CPUARMState *env)
+{
+    __put_user(TARGET_ESR_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(env->cp15.esr_el[1], &ctx->esr);
+}
+
 static void target_setup_extra_record(struct target_extra_context *extra,
                                       uint64_t datap, uint32_t extra_size)
 {
@@ -531,6 +546,9 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_ESR_MAGIC:
+            break; /* ignore */
+
         case TARGET_SVE_MAGIC:
             if (sve || size < sizeof(struct target_sve_context)) {
                 goto err;
@@ -683,7 +701,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -693,6 +711,15 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fpsimd_ofs = alloc_sigframe_space(sizeof(struct target_fpsimd_context),
                                       &layout);
 
+    /*
+     * In user mode, ESR_EL1 is only set by cpu_loop while queueing the
+     * signal, and it's only valid for the one sync insn.
+     */
+    if (env->cp15.esr_el[1]) {
+        esr_ofs = alloc_sigframe_space(sizeof(struct target_esr_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -754,6 +781,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    if (esr_ofs) {
+        target_setup_esr_record((void *)frame + esr_ofs, env);
+        /* Leave ESR_EL1 clear while it's not relevant. */
+        env->cp15.esr_el[1] = 0;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
-- 
2.43.0


