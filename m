Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D98E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoN6-0003S0-Lf; Thu, 12 Dec 2024 13:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMg-00035U-9e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:47 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMc-0006uM-By
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:46 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728e81257bfso810638b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029800; x=1734634600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXbrBv48FmvVxm7EUcfZTZ2JWJOTl6EXN6xCwbK7DzM=;
 b=BRpDtIKJyWroV2he9v47NPd2s18RnBJtvRWN91NJOGzOC5Rl4w3varEtZ7pt0Hxvcx
 o/Mpn7NFiNno/QhH8i6p7bMWdJuHNrK54d5UOQdHXJS0DqTIPY2GLCIlsIcJAgEzMu0l
 /Wfmzibk1rGgHYK3Xztqq0rFfPJM0Jd3KELRcaWt8I3lLiQyGMGZq14XTBoF+QACLnK5
 2tNOpH74Myc7mrgNPvV7eSoho2kuwTqhPd6aGaYDi10cxHsXe6NBUWy1Q6i4pwY2QxMA
 uhD7WXHBFpGeZk1epNsDp9rwBwA5Cc0b6pk7o5D+5VJ2qgCt8/AjGxwpePaObQYFWPpD
 MhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029800; x=1734634600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXbrBv48FmvVxm7EUcfZTZ2JWJOTl6EXN6xCwbK7DzM=;
 b=oGtVeo3Viv87nrH297yIHjZQOZhCzXvvBnF9d2JxPssWlBK5Zk/LSLwBpM6XYwf94p
 npSiafWd5dBq+fcl4EF7Kx0Xi8OdOU9ToSESG+T3Io0FwLFtHM6DoEnBHuI/YscuTtVC
 9HqUurdGtLFeWyoA9ynIyM/uuPQOuzZz1iL/TVJbKJtf6mdLeT2HBne96H0WCiNHU1Cs
 xOc+uvjwV/PNCF3xn7RCO+9SSpV2ugpG5WrPzYpvpb8eqk6JbF0jUXDDh3TZfKW+BI0y
 IdveUWjq3RBaQPaYVRl7NAgu81JfkRkAd9fORBRpq6oB4pvOKqT5e0KAP4A6+lqWjJBA
 JiAg==
X-Gm-Message-State: AOJu0YxXNeGSvz4cSjyiSJeIohTBy1IVfknj7ItG5WuFvDwShS8WxCgp
 OUF9ungIRWvMcf0ckUADjgW4S0tgTmGs/yGN0JWT3Zvd0gAjffHeC56ls6DqBwpxBxT52dLKyqm
 7
X-Gm-Gg: ASbGncstcdwQm5Z/BhVvAeaZb7XefxqOBqHluDXcgvL/Muut2h1VQiC/EeLWJixm/vQ
 VwrXCe84gnaLKgPp5KD3Dk5bwQttGpNFqTwNCz+Hq+Kkgm4NJ4Ne7CUrQQNs6lh65k0E6+LlobH
 w5k6NuNnhxs0MMxn6KxrlgNYDlblsJ/KIe4lLPxk6mNsjx5cXZV35O8YTm6GNIPl9rIHAQznO++
 weGmq3OtsSX0eAVhhfOXiGJOAF0eP2gnuH913e4CxaRbO2DVwgKFBwbbQbTx2nz4VrSyQltdGMN
 1dMQ6n9eo0pZejXEJFGkLBxfEkoofu0=
X-Google-Smtp-Source: AGHT+IHeEa+zyknpO4K7xgw1SnTYMJEF4cBaeOs3elmpe1j6pEFhJfgL1AHIHemovxsyeCfLPSz6pQ==
X-Received: by 2002:a05:6a00:90a9:b0:727:3935:dc83 with SMTP id
 d2e1a72fcca58-7290696c670mr2222423b3a.10.1734029800451; 
 Thu, 12 Dec 2024 10:56:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e2388d37sm8653945b3a.73.2024.12.12.10.56.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:56:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/18] user: Forward declare target_cpu_copy_regs structure
Date: Thu, 12 Dec 2024 19:53:38 +0100
Message-ID: <20241212185341.2857-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/cpu_loop-common.h      | 5 ++++-
 linux-user/aarch64/cpu_loop.c     | 2 +-
 linux-user/alpha/cpu_loop.c       | 2 +-
 linux-user/arm/cpu_loop.c         | 2 +-
 linux-user/hexagon/cpu_loop.c     | 2 +-
 linux-user/hppa/cpu_loop.c        | 2 +-
 linux-user/i386/cpu_loop.c        | 2 +-
 linux-user/loongarch64/cpu_loop.c | 2 +-
 linux-user/m68k/cpu_loop.c        | 2 +-
 linux-user/microblaze/cpu_loop.c  | 2 +-
 linux-user/mips/cpu_loop.c        | 2 +-
 linux-user/openrisc/cpu_loop.c    | 2 +-
 linux-user/ppc/cpu_loop.c         | 2 +-
 linux-user/riscv/cpu_loop.c       | 2 +-
 linux-user/s390x/cpu_loop.c       | 2 +-
 linux-user/sh4/cpu_loop.c         | 2 +-
 linux-user/sparc/cpu_loop.c       | 2 +-
 linux-user/xtensa/cpu_loop.c      | 2 +-
 18 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
index e644d2ef909..aca51f53238 100644
--- a/linux-user/cpu_loop-common.h
+++ b/linux-user/cpu_loop-common.h
@@ -27,5 +27,8 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs);
+typedef struct target_pt_regs target_pt_regs;
+
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 71cdc8be50c..77f857a8216 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -185,7 +185,7 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 2ea039aa71f..b5403ed0e46 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -173,7 +173,7 @@ void cpu_loop(CPUAlphaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 709f718a99d..be1f11022a7 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -513,7 +513,7 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index d41159e52ad..a1794470113 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -79,7 +79,7 @@ void cpu_loop(CPUHexagonState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     env->gpr[HEX_REG_PC] = regs->sepc;
     env->gpr[HEX_REG_SP] = regs->sp;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 23b38ff9b28..503a204460e 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -188,7 +188,7 @@ void cpu_loop(CPUHPPAState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 1; i < 32; i++) {
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 7a35215278a..e06aa23de4c 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -331,7 +331,7 @@ static void target_cpu_free(void *obj)
     g_free(obj);
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     bool is64 = (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) != 0;
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 73d7b6796a4..935d5bcf2c8 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -97,7 +97,7 @@ void cpu_loop(CPULoongArchState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index f79b8e4ab05..69cdce95518 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -92,7 +92,7 @@ void cpu_loop(CPUM68KState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 212e62d0a62..ee4ba768691 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -127,7 +127,7 @@ void cpu_loop(CPUMBState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     env->regs[0] = regs->r0;
     env->regs[1] = regs->r1;
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a0737..1331a9a2b8d 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -211,7 +211,7 @@ done_syscall:
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index a7aa586c8f9..1bf9542d16a 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 02204ad8beb..e168f1ce947 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -378,7 +378,7 @@ void cpu_loop(CPUPPCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 0af533e186f..a72bc76da3d 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -94,7 +94,7 @@ void cpu_loop(CPURISCVState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
     TaskState *ts = get_task_state(cpu);
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 8b7ac2879ef..42e4d24102e 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -180,7 +180,7 @@ void cpu_loop(CPUS390XState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 0; i < 16; i++) {
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index c805f9db110..937d9fa265d 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,7 +81,7 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
 
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 50424a54df5..58a2464da9f 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -357,7 +357,7 @@ void cpu_loop (CPUSPARCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     env->pc = regs->pc;
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index d51ce053926..7564e25a966 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -238,7 +238,7 @@ void cpu_loop(CPUXtensaState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
 {
     int i;
     for (i = 0; i < 16; ++i) {
-- 
2.45.2


