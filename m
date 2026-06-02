Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B0ECD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULH3-0000nl-53; Tue, 02 Jun 2026 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGm-0000Yq-GP
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:49 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGh-0007YG-HL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:42 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304d7f31215so4950162eec.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780391914; x=1780996714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WxnG1ZaVTxzKCs44ZH++uO0YK7iL7fr4U5+9la7l0s=;
 b=nQw3AdRAVZyZHrjCr3Z3dZ/x8jx1i0QiHI6WFMqUHKqnacfh3BcHHSsIkm8UUjpR7T
 EeCVOcNOTlqBHb5qOw1LdCBz5s5MCmd1vx4ZLrQyBxZ0LylSEO/kBOngb+2ks6/4jgf5
 AMTxOVg48E8AVHsLFD6SYB/z5/67uIb8wGMloWRneXP98SpxzRISuBD2blZMqXD3ScrX
 iSnUZeubIyrZF1Vuh5ngUFcgGMaF3BfW34NR63VHbstg9ZmW2CKBFwoqajQHKKGragGD
 NUYHMQ03wJumKGyPtfNjSbaY5j1op3HKD4MGmWyDCDURylbyS1Dg7SWVtW6AQFbVXq37
 tZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391915; x=1780996715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WxnG1ZaVTxzKCs44ZH++uO0YK7iL7fr4U5+9la7l0s=;
 b=PY1A01igVMMd4Jt0QrOijeS1LCqpKKDBb6xovqu11eUNg37te1AEHMn9rIHOBbBk2h
 G4YPpVmKcjD3TYf6vFaNCaRWUyg1HiBmyVq2WotMqlUcZBmLa98RraQ8eYcUN5+/Kebv
 KWPBLvevcJuGjvoWzEVl9hrM8NZGY6i2s9CrLYu9/ljiRb8WVtxzfazsJYGCp5Vfj/nW
 LKIA9WMW0yxEvfIUMs79LTDPef1NqdgNWWfbwLTlEM3+xDPNHIRLIaL3G/8I73bUHEJQ
 +LZcVsEZseUQSs16HZhWWfUVgwOrkYjWMVbzGvCraYpUX27wykC/mGw6SaWGaExEHJFz
 G0fQ==
X-Gm-Message-State: AOJu0YxoNGUWbTDGtpFHs75Hjq6O4kJvlTbNUdfKj1LpMarUXMXGvKLC
 x6YGu5Q7y8lF60OCocjYfIfFvsM4e/m09qZRiVvmET2BidERFN2AulsZX0SOOqVuBl1KOw==
X-Gm-Gg: Acq92OE4Fcp549xcKyZuCED14a5P8ppGo78bu7G4V1cMZ5Rbm+XnKCktxOYAcfWtVaj
 qOq0yTOS+R99vxcPPCaXE7E7stvweBiw2X9/CgOxwXKMy25k4lJif0hsot+8jnzPFNHkHu2wLk5
 WH4SSJkyYlLlK2jNO6rXxwVt7KPp22stcUlq6OMlJTekW4lhGlqvRosL809UloJAc/ppO7Vo15R
 s76BAS1wI0m8+yvUKop7R2AnghoBJa1mvCLqJm37ISsgW0X2qcZkhnv1VA04BZceFNfs3X8X1Fn
 MmRSMVRbh7QoNF44UHP8XWBmd0/ijB/YsJTzsJkxqIl1LE1APsyAnN0k4+YWEvBK7cOvnfiVOBD
 o1NtO3ZO+DM6wey6ad9M9xQVuSS6eassNfxTDSzfxsmGtAbtfclRa7iQko5I4sNo7+azzCKWUq9
 sSCAUY4LRWeF2/7wVeS9ACTk1MFDXLCyy7kXAby0bl8sJL6dXMVLacl9vWaG9RCfYv38HkEz7rP
 idZqnmBp0zx78G5P1qPYzMJsLY=
X-Received: by 2002:a05:7300:f18f:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-304fa632e0dmr6146120eec.23.1780391914520; 
 Tue, 02 Jun 2026 02:18:34 -0700 (PDT)
Received: from openkylin..
 (ec2-54-176-108-193.us-west-1.compute.amazonaws.com. [54.176.108.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm11419146eec.5.2026.06.02.02.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:18:34 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@linaro.org, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3 3/6] target/riscv: move riscv_raise_exception() out of
 op_helper.c
Date: Tue,  2 Jun 2026 17:17:50 +0800
Message-ID: <20260602091753.3209261-4-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
References: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

riscv_raise_exception() is referenced by RISC-V internal code, but its
current implementation relies on TCG's cpu_loop_exit_restore(). Move it to
cpu_helper.c so op_helper.c can become TCG-only. The actual exception
unwind still relies on TCG's cpu_loop_exit_restore(), so the non-TCG path
remains unreachable.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu.h        |  4 ----
 target/riscv/cpu_helper.c | 19 +++++++++++++++++++
 target/riscv/debug.c      |  1 +
 target/riscv/internals.h  |  4 ++++
 target/riscv/op_helper.c  | 15 ---------------
 target/riscv/zce_helper.c |  1 +
 6 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2273567139..98bda189e6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -662,10 +662,6 @@ void riscv_translate_init(void);
 void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
 
-G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      RISCVException exception,
-                                      uintptr_t pc);
-
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, target_ulong address);
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 678c106ae5..752752d520 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -39,6 +39,25 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+/* Exceptions processing helpers */
+G_NORETURN void riscv_raise_exception(CPURISCVState *env,
+                                      RISCVException exception,
+                                      uintptr_t pc)
+{
+    CPUState *cs = env_cpu(env);
+
+    trace_riscv_exception(exception,
+                          riscv_cpu_get_trap_name(exception, false),
+                          env->pc);
+
+    cs->exception_index = exception;
+#ifdef CONFIG_TCG
+    cpu_loop_exit_restore(cs, pc);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft = get_float_exception_flags(&env->fp_status);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..1a74aedeab 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internals.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 7f28190c29..1863012807 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -193,6 +193,10 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
+G_NORETURN void riscv_raise_exception(CPURISCVState *env,
+                                      RISCVException exception,
+                                      uintptr_t pc);
+
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong val);
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..d17a8bbf10 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,21 +28,6 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
-/* Exceptions processing helpers */
-G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      RISCVException exception,
-                                      uintptr_t pc)
-{
-    CPUState *cs = env_cpu(env);
-
-    trace_riscv_exception(exception,
-                          riscv_cpu_get_trap_name(exception, false),
-                          env->pc);
-
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, pc);
-}
-
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
     riscv_raise_exception(env, exception, 0);
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index 15bf0a99c8..152a7a63ef 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
 
-- 
2.43.0


