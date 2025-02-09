Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120D5C02198
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 03:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgy44-0005sD-Mt; Sat, 08 Feb 2025 22:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3p-0005pA-Hk; Sat, 08 Feb 2025 22:32:45 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3k-0001PT-Go; Sat, 08 Feb 2025 22:32:43 -0500
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f6d2642faso19270845ad.1; 
 Sat, 08 Feb 2025 19:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739071958; x=1739676758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40hOV1XLmKGFFIuKf1SgFgrMU4Y3jviwBqNER7UevnM=;
 b=tbFTHo7Zr34NV16sxBEzvLubokqveC+FpZTN1CZjG5hJb7umQC7c7HZKRT2alM2T25
 dTu42Sl3tvQ6M9n+6aPy69of2S7nKnrsSyDlzZ8AdvJkrFCk9AEA2hMUdDfpJfJMpn97
 aBVjDy4U/IGzhV+x5q6P4SRKvhfLxQwFSCu+U7JHxIr2EmhnzQwkz0HpmV0oDs18RCc3
 WXR/xtYhEQSCQojHAOVVrlHtgCD74VbEVAJsmPHg77RGZeLQLwULILGxAkxyoW/4tsKi
 i27idnB/UPeBoR3NbYKd9GSdkpiOPMorKV9dwUgj+9z+l8RPf2HcQD/aZInVJB/2E9Ql
 KBAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw7W3svtQqN6Y2RutvgMDNXZWGNnn4kwL/WVVLU/rw+ZtKPl7NJsUJucKKclnPLGNIA7KF/+PzCQ==@nongnu.org
X-Gm-Message-State: AOJu0YyXz0vLcHmADaPNF3wjb9LMxHzx510K3IHyUyLNpP8N6LzQikt1
 SdxF18eb9ellu8eg8oASLE4DQ5stjRK03N5GjIjVKVFQuW6w/Cq/YVec8Gh3
X-Gm-Gg: ASbGnctMe7LJIW6zXUpG3HpiCMopOBqS7ga6OIWK5f8XNSMG1JKTjWKuAl7DQpuLNVP
 up24VQdd6y57ktvFSxb4xVYB7rhrl9lWQ8ZikZFXmBZmxQ1HolYgrqyueVZsLiIeS5KwkKFlWgT
 v5QCchmsisRPa6kB84PX3D8n3UfC/KodjadNd7lMjAtzLyZ3TpJRZaQ96XoNpj5vmDE4TXnbrBa
 b4kXjNNNC8AtCkt2TNMW2RqdzyrWsbVMtsAntO/joY1A3MCOU6JLuC8+n/R9iRjajM79bkGnddT
 lGKwo8Mo/xA7oZJkFuh6NwaOe0fPkP/+nn43JFALty0Z0AM=
X-Google-Smtp-Source: AGHT+IH+ALL7cX3DTai2279KB0dFYtI4aVNWY7NNbmRvoL6IvzpattoDFsNJlsAfIqIRWpUroDR/Dw==
X-Received: by 2002:a05:6a21:9211:b0:1ed:a4e2:8638 with SMTP id
 adf61e73a8af0-1ee03b78d70mr16423609637.39.1739071958132; 
 Sat, 08 Feb 2025 19:32:38 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:9e97:4903:dc10:4530:8a3f:fdb6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad5453e2366sm1333610a12.47.2025.02.08.19.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 19:32:37 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH RFC 1/4] cpu-exec: support single-step without debug
Date: Sat,  8 Feb 2025 19:32:30 -0800
Message-ID: <20250209033233.53853-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250209033233.53853-1-j@getutm.app>
References: <20250209033233.53853-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.177; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f177.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, single-stepping is tied to GDB debugging. This means that when
EXCP_DEBUG is returned, a debug exception is triggered in many cases. We
define a new EXCP_SINGLESTEP to differentiate the case where we want a
single step to not be tied to a debug exception. We also define a new flag
for cpu->singlestep_enabled called SSTEP_NODEBUG which is set when we want
to use single-step for purposes other than debugging.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/exec/cpu-common.h |  1 +
 include/hw/core/cpu.h     |  1 +
 target/arm/internals.h    |  3 ++-
 accel/tcg/cpu-exec.c      | 35 +++++++++++++++++++++++++----------
 cpu-target.c              |  7 +++++--
 5 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b1d76d6985..e1c798b07d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -22,6 +22,7 @@
 #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+#define EXCP_SINGLESTEP 0x10006 /* singlestep without debugging */
 
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc5..e3c8450f8f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1072,6 +1072,7 @@ void qemu_init_vcpu(CPUState *cpu);
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
 #define SSTEP_NOTIMER 0x4  /* Do not Timers while single stepping */
+#define SSTEP_NODEBUG 0x8  /* Single-stepping is not for debugging */
 
 /**
  * cpu_single_step:
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 863a84edf8..961cd9927a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -57,7 +57,8 @@ static inline bool excp_is_internal(int excp)
         || excp == EXCP_HALTED
         || excp == EXCP_EXCEPTION_EXIT
         || excp == EXCP_KERNEL_TRAP
-        || excp == EXCP_SEMIHOST;
+        || excp == EXCP_SEMIHOST
+        || excp == EXCP_SINGLESTEP;
 }
 
 /*
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8b773d8847..6b4e63e69e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -349,7 +349,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
      * so that one could (gdb) singlestep into the guest kernel's
      * architectural breakpoint handler.
      */
-    if (cpu->singlestep_enabled) {
+    if (cpu->singlestep_enabled && !(cpu->singlestep_enabled & SSTEP_NODEBUG)) {
         return false;
     }
 
@@ -529,7 +529,11 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
      * is handled in cpu_handle_exception.
      */
     if (unlikely(cpu->singlestep_enabled) && cpu->exception_index == -1) {
-        cpu->exception_index = EXCP_DEBUG;
+        if (!(cpu->singlestep_enabled & SSTEP_NODEBUG)) {
+            cpu->exception_index = EXCP_DEBUG;
+        } else {
+            cpu->exception_index = EXCP_SINGLESTEP;
+        }
         cpu_loop_exit(cpu);
     }
 
@@ -781,13 +785,20 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         cpu->exception_index = -1;
 
         if (unlikely(cpu->singlestep_enabled)) {
-            /*
-             * After processing the exception, ensure an EXCP_DEBUG is
-             * raised when single-stepping so that GDB doesn't miss the
-             * next instruction.
-             */
-            *ret = EXCP_DEBUG;
-            cpu_handle_debug_exception(cpu);
+            if (!(cpu->singlestep_enabled & SSTEP_NODEBUG)) {
+                /*
+                 * After processing the exception, ensure an EXCP_DEBUG is
+                 * raised when single-stepping so that GDB doesn't miss the
+                 * next instruction.
+                 */
+                *ret = EXCP_DEBUG;
+                cpu_handle_debug_exception(cpu);
+            } else {
+                /*
+                 * In case of non-debug single step, just return
+                 */
+                *ret = EXCP_SINGLESTEP;
+            }
             return true;
         }
     } else if (!replay_has_interrupt()) {
@@ -892,7 +903,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                  * next instruction.
                  */
                 if (unlikely(cpu->singlestep_enabled)) {
-                    cpu->exception_index = EXCP_DEBUG;
+                    if (!(cpu->singlestep_enabled & SSTEP_NODEBUG)) {
+                        cpu->exception_index = EXCP_DEBUG;
+                    } else {
+                        cpu->exception_index = EXCP_SINGLESTEP;
+                    }
                     bql_unlock();
                     return true;
                 }
diff --git a/cpu-target.c b/cpu-target.c
index 667688332c..6293477ed9 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -322,9 +322,12 @@ void list_cpus(void)
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
 {
-    if (cpu->singlestep_enabled != enabled) {
-        cpu->singlestep_enabled = enabled;
+    int previous = cpu->singlestep_enabled;
+    bool prev_debug_en = previous && !(previous & SSTEP_NODEBUG);
+    bool cur_debug_en = enabled && !(enabled & SSTEP_NODEBUG);
 
+    cpu->singlestep_enabled = enabled;
+    if (prev_debug_en != cur_debug_en) {
 #if !defined(CONFIG_USER_ONLY)
         const AccelOpsClass *ops = cpus_get_accel();
         if (ops->update_guest_debug) {
-- 
2.41.0


