Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F83C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Yb9-0007Pf-7M; Mon, 29 Apr 2024 17:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yaz-0007GS-95
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:33 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yav-0003Ky-9g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:32 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so63637931fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426285; x=1715031085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYPfGXZr1iKLCXnvsM1Vv5K3/IiXPZq2vFweDAU8m9c=;
 b=D07eTFat21zZAYlewc9516MY2EhHb0bl7s/iZyy8PPwhqWtvEzMmac5pjD2IlF0368
 /3T+PHlfwsvBaPnWvragha5+arv91PgdmOG3Z3duilcaY10m/R8S8JwSuzxwsWId76Rq
 oSic/yc5cqMyRt9ICci6+l6pEjFbJsJyqcSiriHRUdL1ONh3L2JHAl6xvx/6gYUp5Gt1
 977QHJDvLKASTalcUe9ZUcesVwm+wuvAPyNaLQAu8B8Yho41bMUqwvyccOY98LNlyIMm
 OzPP2oKq2vujTcVFphdL0zFq/w3jET2XvyY24lvLbcMnSqKemIVH3CQQYzuHFSRxbQm6
 lwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426285; x=1715031085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYPfGXZr1iKLCXnvsM1Vv5K3/IiXPZq2vFweDAU8m9c=;
 b=sfv0rxR/HK/xe9y9zLeEF/2GiBpWV2uVD+hzTNRq33hPfcweH9OnZCaT56HP3QjcDr
 D4Fkt3znGsLmPVNDOqeIFMyYX2cwsBh9ZZ02eEqQYaj7ja4noT5LecF1rzjvg8FMe/c0
 ztBY1ql3EgOBQPq0RgZBxyOrlMg91Y/oMj7vGIDvxYIQcKkBU8fz+a2il8SevGXnIv9W
 bnlkKCwzTXcCIFIcEspLZRXy5gKB+UkyZVPn1qTXQYEjHzCKpdzMKGJ2juWZJWofedxu
 CHjhs4geOHJMxXHItgU7aC3liKIVcoOtTR3W7qtXha5rfP52J2gVlxGjB5yaYJc9W7Y8
 NkDA==
X-Gm-Message-State: AOJu0Yw4MSX0+VfaWOVp1IftruY9mx8urZEUphk2zVHp/INus5naTeH2
 bJ1Q4Ol/3l2Kk23nyL+7e4Yg+QTyVJK5eDmo8o0Js0YOhg4kV88cGiSZ2K9hKTssZ+OyAFVs5a4
 0piY=
X-Google-Smtp-Source: AGHT+IGmN6GQjpyPj47kRc+StCLffY4XShyytKAZ187wz4d7h/kpP+lx0wDnBCbJrFZGMYJv3NPZ1g==
X-Received: by 2002:a2e:9e07:0:b0:2de:4cb4:2601 with SMTP id
 e7-20020a2e9e07000000b002de4cb42601mr8383973ljk.43.1714426284729; 
 Mon, 29 Apr 2024 14:31:24 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 a9-20020a05600c348900b0041bb11ff5a7sm12390100wmq.8.2024.04.29.14.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/13] accel/tcg: Move @jmp_env from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 23:30:43 +0200
Message-ID: <20240429213050.55177-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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
index 9af66bc191..46ad16f911 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -553,7 +553,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
      * support such a thing.  We'd have to properly register unwind info
      * for the JIT for EH, rather that just for GDB.
      *
-     * Alternative 2: Set and restore cpu->jmp_env in tb_gen_code to
+     * Alternative 2: Set and restore cpu->accel->jmp_env in tb_gen_code to
      * capture the cpu_loop_exit longjmp, perform the cleanup, and
      * jump again to arrive here.
      */
@@ -577,7 +577,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags, cflags;
     int tb_exit;
 
-    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+    if (sigsetjmp(cpu->accel->jmp_env, 0) == 0) {
         start_exclusive();
         g_assert(cpu == current_cpu);
         g_assert(!cpu->running);
@@ -1038,7 +1038,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
 static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
 {
     /* Prepare setjmp context for exception handling. */
-    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+    if (unlikely(sigsetjmp(cpu->accel->jmp_env, 0) != 0)) {
         cpu_exec_longjmp_cleanup(cpu);
     }
 
-- 
2.41.0


