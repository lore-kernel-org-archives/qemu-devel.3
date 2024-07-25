Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F438C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ai-0001K9-2e; Thu, 25 Jul 2024 19:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ac-0000vu-KH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:50 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Aa-0005P3-Mf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:50 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-396eb81a1cfso4662425ab.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951207; x=1722556007;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1RafRXULaoeGB+gXsUlffAxqhChP6/g1AGQdC0LRV0=;
 b=26/NHMHNVKWjvOi0FcWMOY3yGlWGPjC0bf4CgWBl9GclR5uu+drvebaCA9BWQ9rdmi
 pB9bxyqTbz6dssu6sT7xnE80zS2CjNC7VqrfZeIEjO2jGi36k/xr5ftzcii9vKrWo/DM
 8ThAMVe8FPdnRd0sjq3VLHxOnIERmkb/K34iF5xl9nHpUqt1ApR+LITSdXpTLaOuZ0Z4
 wuBjiWeNZK4GzsMFrj0t5avJuqirgXsIUKQ84K+INlqKE9FTVf/4L2Aw2ggWTSAMIPGb
 bCIXSkw02mWKYghSpLQEkUtdkTF35Q7jJQmnqp89EQgDs6DCF84YoxH6H6Ng6ODCDkyY
 FCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951207; x=1722556007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1RafRXULaoeGB+gXsUlffAxqhChP6/g1AGQdC0LRV0=;
 b=BbUNrjJ9C7DQTf1tLnb9WcWzz8QyCQfDbQgxo6y3Fb2AE9oujh5VUQaqi5it93/VFx
 3MuLr43BWZxgm7hxIv53VeJuDP8xf9L5yf8gpE2FfTgzACs9FVufxxv6vlQ7GvsbzfHe
 0Nli37c36LXVNcKoCg4Nub6iTkpyWy+MeukapFSJufLf+z9SbJk4Co7B9vB/zQfHJ9Ge
 b//8MTpy8vAE3QrNLaBtJ0mDI8ZZxpGGZZE80R9jQ66uYWQGoPOITtDHXwRfte8S0n0j
 8ZGXqTaTh/UgD5lBkjumcPo3tC3Ouzr3lC3RtrBP62TBDtFCeV5F7RSy0VsqezKuRDoX
 WBLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUZQeMHctZv8BH5is2kAlbDyfzRTxjf1pZft99g/muqtoAUhSuHukaahrw263Fe558H/x4+GmRG6g43vBDX5RltWuNdiY=
X-Gm-Message-State: AOJu0YyUZ53WuIUjqd10JJZMPB0+Qfba1DxyQFlsRsI1BDcPrdoBjadw
 vhIX+6+/PegHJAWcfEYmt7MBFsM/tWzpTxPUAJYIcXySFEzKQxysDv+ok8tprtE=
X-Google-Smtp-Source: AGHT+IGy9MqWIDoryJ9a1TUhuvKpi76++J/YXW9VofOVUL5C6siHdDEm9/l6rf1Bb14RQ6thdTsBTA==
X-Received: by 2002:a05:6e02:12e2:b0:396:b0d:8018 with SMTP id
 e9e14a558f8ab-39a217e0d7amr59304055ab.6.1721951207117; 
 Thu, 25 Jul 2024 16:46:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 18/24] linux-user/riscv: setup/teardown zicfiss shadow stack
 for qemu-user
Date: Thu, 25 Jul 2024 16:46:07 -0700
Message-ID: <20240725234614.3850142-19-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=debug@rivosinc.com; helo=mail-il1-x12b.google.com
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


