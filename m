Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2648BC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZS-0006T1-2M; Mon, 29 Jul 2024 13:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZK-0005j5-A6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZG-0000NM-Lk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:57 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-79b530ba612so2113827a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275633; x=1722880433;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1RafRXULaoeGB+gXsUlffAxqhChP6/g1AGQdC0LRV0=;
 b=VeW08BU0rSCYZA3pfdYzVyrERPsXZgIi/yGIi0EVh914s9m9nuBkjuFRYViaYQ8wzG
 26qmnYgUw0UsEFHwukRjkfmUkj9n25NX5ju5/SW3KYu12aqdD5xVW75zJWwXkfeV5hNZ
 oR/Kejzhxxl0iZjiXN/vqwoT7Xj1beIeUNrjs0ZBPSlUVDo24WBmL5eP8TdEvHEnViyh
 vp6aeS94bZEYvXiNRNFQATF73jRKPbPuThaw+Ee6OnvbL7idVQCwznAJEgugf3eRwiKs
 RjMHsw1V6TSpcozwGMOeNOVIjvptu/pMGa7grM3ASWZEZnFesiajmaWUR++z6imuPxHo
 +Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275633; x=1722880433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1RafRXULaoeGB+gXsUlffAxqhChP6/g1AGQdC0LRV0=;
 b=CLytI0oTzgbOvGRLIQBxxD3bb1x6jCzTP69yX2jquJkGtd7tMXSaO2EZZ3O/HWDf9v
 8LRoomlacONVnIECOSHRJqy/fyAH1qAoScEq4jXV+E3V//DJ+bjS7g5G8adcNG8zMaKE
 yCsUM0yG1k4jSo+WD+Tms1WJ1H7razw8krRVZ6v3yh1xuio8tG4x4JfsyM39ouc5J104
 624QFUZmjQ7PaT4jbTpkV5xVmwTa1Ki6412Ty25rVE1bB+rNAu6b+AbqITG2u6EnkEfq
 1n07aGUfk+Ce7ut2k7FfYffmjGQAs3CqWAQKEQLNk5RT8F743XuG7zwEOdKSWlJp5JXj
 6ocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC248Nu6YtxwsxteWz1KgNglTQnbIrkSArqgKc2ZtmAsDnvKWeC+VWmVEtLmFGW5TfFmLQN/fxvtvdBGgYDd+omLYfpqo=
X-Gm-Message-State: AOJu0YwKSPqHNXSw8oIWSSx+EL0G/ar1M/d8xJTiY/8Wgz6DfhLV3FSp
 BJ0bbldpkLR3olKcBPUaVXCLhM6/EYqavz5eMAA0L632VgfWRLQPl4LzpaOaF5o=
X-Google-Smtp-Source: AGHT+IFKApTowdoUj4RwBAGn3nRPUoNa370cveOMxEpQH7lRLOFQGBkMayj4Co2eW0xB5Oqn4ly0Bg==
X-Received: by 2002:a05:6a20:8421:b0:1c0:f648:855f with SMTP id
 adf61e73a8af0-1c4a129fe88mr7352486637.18.1722275633098; 
 Mon, 29 Jul 2024 10:53:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 18/24] linux-user/riscv: setup/teardown zicfiss shadow
 stack for qemu-user
Date: Mon, 29 Jul 2024 10:53:20 -0700
Message-ID: <20240729175327.73705-19-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Implements shadow stack related prctls for qemu-user on riscv. Allocates
shadow stack from host memory using `target_mmap` and tears down when
user issues prctl to disable using `target_munmap`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 linux-user/riscv/cpu_loop.c     | 50 +++++++++++++++++++++++++++++++++
 linux-user/riscv/target_cpu.h   |  7 +++++
 linux-user/riscv/target_prctl.h | 27 ++++++++++++++++++
 target/riscv/cpu.c              |  4 +++
 target/riscv/cpu.h              |  1 +
 5 files changed, 89 insertions(+)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 52c49c2e42..22670b68e0 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -25,6 +25,7 @@
 #include "signal-common.h"
 #include "elf.h"
 #include "semihosting/common-semi.h"
+#include "user-mmap.h"
 
 void cpu_loop(CPURISCVState *env)
 {
@@ -94,6 +95,55 @@ void cpu_loop(CPURISCVState *env)
     }
 }
 
+#define ZICFISS_GUARD_SIZE  (2UL * TARGET_PAGE_SIZE)
+#define ZICFISS_STACK_SIZE  (16UL * TARGET_PAGE_SIZE)
+#define ZICFISS_THREAD_SIZE (ZICFISS_STACK_SIZE + ZICFISS_GUARD_SIZE)
+
+void zicfiss_shadow_stack_alloc(CPUArchState *env)
+{
+    uintptr_t new_base;
+
+    /* SS page should be surrounded by two guard pages */
+    new_base = (uintptr_t) target_mmap(0, ZICFISS_THREAD_SIZE, PROT_NONE,
+                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if ((intptr_t)new_base == -1) {
+        perror("shadow stack alloc failure");
+        exit(EXIT_FAILURE);
+    }
+    new_base += TARGET_PAGE_SIZE;
+    int ret = mprotect((void *)new_base, ZICFISS_STACK_SIZE,
+                       PROT_READ | PROT_WRITE);
+    if (ret == -1) {
+        perror("shadow stack mprotect failure");
+        exit(EXIT_FAILURE);
+    }
+
+    env->ssp_base = new_base;
+    env->ssp = new_base + ZICFISS_STACK_SIZE;
+}
+
+void zicfiss_shadow_stack_release(CPUArchState *env)
+{
+    abi_ulong mmap_base;
+
+    if (env->ssp == 0) {
+        perror("release empty shadow stack");
+        exit(EXIT_FAILURE);
+    }
+
+    /* It should match shadow stack allocation. */
+    mmap_base = env->ssp_base - TARGET_PAGE_SIZE;
+
+    int ret = target_munmap(mmap_base, ZICFISS_THREAD_SIZE);
+    if (ret == -1) {
+        perror("shadow stack release failure");
+        exit(EXIT_FAILURE);
+    }
+
+    env->ssp_base = 0;
+    env->ssp = 0;
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 9c642367a3..bba54d93eb 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,6 +1,9 @@
 #ifndef RISCV_TARGET_CPU_H
 #define RISCV_TARGET_CPU_H
 
+extern void zicfiss_shadow_stack_alloc(CPUArchState *env);
+extern void zicfiss_shadow_stack_release(CPUArchState *env);
+
 static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
                                         unsigned flags)
 {
@@ -9,6 +12,10 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
     }
 
     env->gpr[xA0] = 0;
+
+    if (flags & CLONE_VM) {
+        zicfiss_shadow_stack_alloc(env);
+    }
 }
 
 static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
diff --git a/linux-user/riscv/target_prctl.h b/linux-user/riscv/target_prctl.h
index d7f9f954c9..6293d61519 100644
--- a/linux-user/riscv/target_prctl.h
+++ b/linux-user/riscv/target_prctl.h
@@ -13,6 +13,33 @@ static abi_long do_prctl_cfi(CPUArchState *env,
     if (env_archcpu(env)->cfg.ext_zicfilp) {
 
         switch (option) {
+        case PR_GET_SHADOW_STACK_STATUS:
+            abi_ulong bcfi_status = 0;
+            /* indirect branch tracking is enabled on the task or not */
+            bcfi_status |= (env->ubcfien ? PR_INDIR_BR_LP_ENABLE : 0);
+            return copy_to_user(flag, &bcfi_status, sizeof(bcfi_status)) ? \
+                   -EFAULT : 0;
+
+        case PR_SET_SHADOW_STACK_STATUS:
+            /* if any other bit is set, its invalid param */
+            if (flag & ~PR_SHADOW_STACK_ENABLE) {
+                return -TARGET_EINVAL;
+            }
+
+           if ((flag & PR_SHADOW_STACK_ENABLE)
+                && (env->ssp == 0 && !env->ubcfien)) {
+                    zicfiss_shadow_stack_alloc(env);
+            } else {
+                zicfiss_shadow_stack_release(env);
+            }
+            env->ubcfien = (flag & PR_SHADOW_STACK_ENABLE);
+            tb_flush(env_cpu(env));
+            return 0;
+
+        /* locking not implemented (also not needed for qemu-user) yet */
+        case PR_LOCK_SHADOW_STACK_STATUS:
+            return -TARGET_EINVAL;
+
         case PR_GET_INDIR_BR_LP_STATUS:
             abi_ulong fcfi_status = 0;
             /* indirect branch tracking is enabled on the task or not */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e1ff246c24..5a34eee10c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1001,6 +1001,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* on reset ssp is set to 0 */
     env->ssp = 0;
 
+#ifdef CONFIG_USER_ONLY
+    env->ssp_base = 0;
+#endif
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 82475490ab..af89fc1268 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,7 @@ struct CPUArchState {
     uint32_t elf_flags;
     bool ufcfien;
     bool ubcfien;
+    target_ulong ssp_base;
 #endif
 
 #ifndef CONFIG_USER_ONLY
-- 
2.44.0


