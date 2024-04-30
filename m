Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99245C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbQ-0006cP-M4; Tue, 30 Apr 2024 08:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbO-0006M5-Lx
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbL-0001ml-Rm
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:53 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo744872866b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480130; x=1715084930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QG9ucb92ZcQwmYoVuXz0eICf2+cSWUN0kpwrk3Psu28=;
 b=BGTdl9/8H48bbUYBp/hQv6OPg9C0EF3K1rzpakyvDz3ipDu6uDwmBfcDRTCu3YP3+J
 g5n0KKfBNo1b7MfwmPjwOqJZQ85zyMCtrqvyuXzWKN3TE/As5r57SuUdWjkr5CcN9WV7
 n/14Kf61NH7byx3ol4iq6+3XWfC2TdtqqiyQspOldATouXYRjR/OrddxvgC0pOQm1z1I
 n2Xncc/8uFZPoAn0HYlxnLMX+0npM9c/eI5X6sNrmB79l1PLJKCs02rrb61drIH4i3Yk
 9qbxAhdT1uGlAXI5hKjaT0itLTLzcfZzBr8ayh6vEB0byAo5++MD9UoJS7Yn26wH4vY6
 5/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480130; x=1715084930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QG9ucb92ZcQwmYoVuXz0eICf2+cSWUN0kpwrk3Psu28=;
 b=Ce74XU9BE0s5gk1flm/SwWwFvnHSM1H6Ir+Uwwzff/vOwd0FbcLese2KDSYBJZGGr0
 yYaPc6BfdhaDY3TeB1P+6mU82E9HYZwxcI5r7j8a5QKeGx+Q0W98iJcic5EUWt5EtzTH
 kwvwjD7R0I9zs08VGVNu/j34QDD89CmJ/0UCm/DU+NsQt5i9YRWM6EWtcz7tGrwPXdmY
 DcqpButghrJ+BIZP+TH/Tq6daGIcGH/PNc4P/uVajQbG1xOWEwrjmO7N49EPPduVzL3l
 f1rVoWo5SwEtFvGX6ytk2TVng7nmQdE6TK0tf9eEjn756PbYHGsMYSk7pdZxK43jFSjI
 X6iQ==
X-Gm-Message-State: AOJu0YxSWBcQPLgMpNOMa6wsyvjRXJFrhfqFg0+c0E2EFjgknga6oPI+
 vmP0KT42Dq5uspYbFpCeU5sWqONx0HNKEiGcr6tHnnzIQrGfi7xnIjxI5FoXDW3nAsuez299+z3
 R
X-Google-Smtp-Source: AGHT+IH0mlYPeKO/91einC09WEWZCaHGm+jjC8bXo0smZnLfh2mPKEvFmUhdxGKj+XhBDnQX0FnOHA==
X-Received: by 2002:a17:906:cec7:b0:a55:358f:783c with SMTP id
 si7-20020a170906cec700b00a55358f783cmr1726302ejb.24.1714480130003; 
 Tue, 30 Apr 2024 05:28:50 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 q21-20020a170906771500b00a51d408d446sm15063232ejm.26.2024.04.30.05.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/13] accel/tcg: Move @jmp_env from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:28:01 +0200
Message-ID: <20240430122808.72025-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

@jmp_env is specific to TCG accelerator, move it to its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-17-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 1 +
 accel/tcg/tcg-accel-ops.h   | 1 +
 accel/tcg/vcpu-state.h      | 2 ++
 include/hw/core/cpu.h       | 1 -
 accel/tcg/cpu-exec-common.c | 2 +-
 accel/tcg/cpu-exec.c        | 6 +++---
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 867426500f..cb507053f5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -11,6 +11,7 @@
 
 #include "exec/cpu-common.h"
 #include "exec/translation-block.h"
+#include "accel/tcg/vcpu-state.h"
 
 extern int64_t max_delay;
 extern int64_t max_advance;
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 44c4079972..ed41a087a3 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -13,6 +13,7 @@
 #define TCG_ACCEL_OPS_H
 
 #include "sysemu/cpus.h"
+#include "accel/tcg/vcpu-state.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 35c2695a77..3a0ea2d47a 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -13,6 +13,8 @@
  * @plugin_state: per-CPU plugin state
  */
 struct AccelCPUState {
+    sigjmp_buf jmp_env;
+
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
 #endif /* !CONFIG_USER_ONLY */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 47b499f9f1..f1fe43dbea 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -475,7 +475,6 @@ struct CPUState {
     int64_t icount_budget;
     int64_t icount_extra;
     uint64_t random_seed;
-    sigjmp_buf jmp_env;
 
     QemuMutex work_mutex;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bc9b1a260e..ec45482305 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -38,7 +38,7 @@ void cpu_loop_exit(CPUState *cpu)
     cpu->neg.can_do_io = true;
     /* Undo any setting in generated code.  */
     qemu_plugin_disable_mem_helpers(cpu);
-    siglongjmp(cpu->jmp_env, 1);
+    siglongjmp(cpu->accel->jmp_env, 1);
 }
 
 void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index eedba056ba..443b688c01 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -554,7 +554,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
      * support such a thing.  We'd have to properly register unwind info
      * for the JIT for EH, rather that just for GDB.
      *
-     * Alternative 2: Set and restore cpu->jmp_env in tb_gen_code to
+     * Alternative 2: Set and restore cpu->accel->jmp_env in tb_gen_code to
      * capture the cpu_loop_exit longjmp, perform the cleanup, and
      * jump again to arrive here.
      */
@@ -578,7 +578,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags, cflags;
     int tb_exit;
 
-    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+    if (sigsetjmp(cpu->accel->jmp_env, 0) == 0) {
         start_exclusive();
         g_assert(cpu == current_cpu);
         g_assert(!cpu->running);
@@ -1039,7 +1039,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
-    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+    if (unlikely(sigsetjmp(cpu->accel->jmp_env, 0) != 0)) {
         cpu_exec_longjmp_cleanup(cpu);
     }
 
-- 
2.41.0


