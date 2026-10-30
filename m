Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ysIc9Dpu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrmH-00070o-Ec; Fri, 30 Oct 2026 14:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlp-0006sL-C2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:09 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrln-0004oa-6o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:08 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso9413537b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386566; x=1793991366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q7yVmOjDkEbe0BVZGoC/5nOMtAyC/kW47+ufduY/aMM=;
 b=ysIc9DpuAUX8XtE+nB4aZ8Dp1uYjKsPiQqBzljl43VP7QH8GNG/qjZfr6MPvQHapOQ
 f1biuTkyb2RIpH7v1F7MProelc7nmEuDr+wzGa8aD83KanDrE6YclxleOhRQymc/0ijY
 LnPYhEUNWAGM5iZK7rq0Pc55SucTO4B2PeLb14cxyKhtEp3Oeo7WPjePVqAzZg48sLLc
 1DmlEHt8nFREk7ks5fMdnwEt/CbkefdPpCCae3FozkEgJWLXJOHgsKC/jr71JMiQhXus
 vJjXR8qp0XWuRqMp2lq0Lk4xMyh/NwGN4wMJ4MqUE9y0EULHRUZ1cWqTYVl5ApVgyNEe
 A7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386566; x=1793991366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q7yVmOjDkEbe0BVZGoC/5nOMtAyC/kW47+ufduY/aMM=;
 b=QYtQnlIMxw3Rg8XkhIT4jpxRRfQXmiTSFLyYn4SdhZQ/ECM6Z7Ioy7ZoGUBKXAk/G+
 Lrlfrs9TSy9ukR9KCNS3mvkblVOzPQrokJcL8sPGc1LbRQpeRUaIyPhbAPK27gJ7BAjN
 bJZW/VGg66FLT/RtWq2JbssU6pVj9RXbbjCtz2RWDRs2VP+7MCesi1oe77N6isXEWVc4
 5kMMEv43LQ1CmL72+zD63x3RamJ909b/fRYL5QY67hSyV/K9tQGlgCwQiLsNxLkhZCZV
 oWR98UhrL+aYkPXy+magk8D7rgiKpz46WBPP/Ub8gFODK3Uj4L56JHfkx79exvXXN+eg
 LrDQ==
X-Gm-Message-State: AFq9FYJH1Y0mzJ+XcqcSmkHOrr7SUhCeZJqjn1CXgS+3oYVSowp6cLpT
 veLlZFlnMAnUZIz1fZu51meYbsOvsCdq8R/Vsnk7MgHt+NEVyPP879Rzf4ECRCwgtY30hTgZhM8
 08nRh
X-Gm-Gg: AYBFou07GEKZgfOk3xH51wQtej2X4tsfoZrYZoTzRecBtG+p/iM2LsPEaKnHFO3Zc6M
 GZlu79VKACqxpDp6jq1yTqp8Vmz2TPOY9vnXs7jLVMs/vbXUkvWoxa2FcDwYw0LcqWDAHG+fmPR
 86tv6vZq+ZHiSvXRq2y6Y2iEPIVFZ17wZwkq3hu3Jeu0KGi7irF2YYlGRsazb3hJ3iRGT0arrs+
 Ci+rttPfB9ynH/t2bupqTvxwjliwSgTRni91kKU868Ha9Tk1NOgcQE31G5PW7YbFfhXZ1mAnbQe
 xPhT8Af8mDadEdeRWNNZLAW58Cw8tRLK0pZJ4YVpHzeGYAB5l3xopWi5RAErofZfoLDp6/V7x/S
 31k6dqe7YxXq9lxb99HIZ7FCzxkCRXar8fT0a4wBrHppvJbwzxbjtNbqEGFJBeSGAYX8zEUNUfm
 Lq3rV5ldVnBz9+szCvbUznqEoh/5bfCQmOpyplE5LEkNNwAbwajPfzF6Sp9BQN94fAKhJPFQzy8
 nAEK21y7IJ+R6JT3ZGalsO8NOOECkfqEIGj6z3Q3K4tCj3j/MJqpSLZ7El7TiV/9X9YipIBP2eJ
 DUpbjLQDyINZEcaX5E9PCZKLRLlJXqjnLsg=
X-Received: by 2002:a05:690c:348a:b0:88f:df4:1c8e with SMTP id
 00721157ae682-8b2b66c5d61mr19291407b3.22.1793386565880; 
 Fri, 30 Oct 2026 11:56:05 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 07/14] accel/tcg: add CF_NO_GOTO_JC,
 set while a breakpoint is present
Date: Fri, 30 Oct 2026 13:55:44 -0500
Message-ID: <20261030185551.193092-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matt Turner <mattst88@gmail.com>

The next patch dispatches a goto_jc by probing the TB jump cache from
generated code. That probe cannot check everything helper_lookup_tb_ptr()
checks, and the one that matters is breakpoints: check_for_breakpoints()
raises EXCP_DEBUG on an exact pc match and selects CF_BP_PAGE cflags for the
rest of the page, and inserting a breakpoint deliberately invalidates no TB.

The probe compares the destination's cflags against the cflags of the block
doing the dispatching, and only takes the destination when they are equal.
So a cflag is all that is needed.  Add CF_NO_GOTO_JC, set it in
CPUState::tcg_cflags while cpu->breakpoints is non-empty, and blocks
translated from then on both decline to dispatch inline themselves -- the
next patch makes them emit the plain helper call -- and are unreachable from
blocks that do, because their cflags no longer match.

The two ends of the flag are cpu_breakpoint_insert() and
cpu_breakpoint_remove_by_ref(), which are the only places the list changes.
Both already run either on the CPU's own thread or with it stopped, or reach
another CPU exactly as cpu_single_step() does, which is where the previous
patch put the same kind of update.

That leaves blocks translated before the breakpoint was inserted, which are
still live and still chain to each other. They do so on the old cflags, so
inline dispatch among them keeps working until the vCPU reaches its main
loop, which then looks up with the new cflags and translates afresh. In
system mode gdb inserts breakpoints with the vCPUs stopped, so there is no
window at all. In user mode the window is the one goto_tb chaining already
has: a chained direct jump consults nothing either, and is not broken by
inserting a breakpoint.

Nothing reads CF_NO_GOTO_JC yet; the next patch does.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-6-mattst88@gmail.com>
---
 include/exec/translation-block.h |  5 +++--
 accel/tcg/cpu-exec-common.c      | 13 ++++++++++++-
 accel/tcg/cpu-exec.c             |  2 +-
 cpu-common.c                     | 27 +++++++++++++++++++++++++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5a7a638b08..4406db5ab2 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -76,8 +76,8 @@ struct TranslationBlock {
 #define CF_COUNT_MASK    0x000001ff
 #define CF_NO_GOTO_TB    0x00000200 /* Do not chain with goto_tb */
 #define CF_NO_GOTO_PTR   0x00000400 /* Do not chain with goto_ptr */
-#define CF_SINGLE_STEP   0x00000800 /* gdbstub single-step in effect */
-#define CF_MEMI_ONLY     0x00001000 /* Only instrument memory ops */
+#define CF_NO_GOTO_JC    0x00000800 /* Do not dispatch via the inline probe */
+#define CF_SINGLE_STEP   0x00001000 /* gdbstub single-step in effect */
 #define CF_USE_ICOUNT    0x00002000
 #define CF_INVALID       0x00004000 /* TB is stale. Set with @jmp_lock held */
 #define CF_PARALLEL      0x00008000 /* Generate code for a parallel context */
@@ -85,6 +85,7 @@ struct TranslationBlock {
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
 #define CF_STEP_ATOMIC   0x00080000 /* Running in cpu_exec_step_atomic */
+#define CF_MEMI_ONLY     0x00100000 /* Only instrument memory ops */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 4e5e69649a..32e76d5f41 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -33,7 +33,7 @@ bool tcg_allowed;
  * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
  */
 #define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
-                     CF_SINGLE_STEP)
+                     CF_NO_GOTO_JC | CF_SINGLE_STEP)
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 {
@@ -65,6 +65,17 @@ void tcg_update_cflags(CPUState *cpu)
         cflags |= CF_NO_GOTO_TB;
     }
 
+    /*
+     * A block that dispatches through the jump cache inline does not consult
+     * cpu->breakpoints, and inserting a breakpoint deliberately invalidates
+     * nothing.  Give blocks translated while one is set a distinct cflags, so
+     * that they neither dispatch inline themselves nor are reached by a block
+     * that does, and check_for_breakpoints() gets to run on every dispatch.
+     */
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        cflags |= CF_NO_GOTO_JC;
+    }
+
     cpu->tcg_cflags = cflags;
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index cf690e0e11..4c20091ef5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -593,7 +593,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR |
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NO_GOTO_JC |
                     CF_NOIRQ | CF_STEP_ATOMIC | 1;
 
         /*
diff --git a/cpu-common.c b/cpu-common.c
index adb76b3a78..81a302ace9 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -22,6 +22,7 @@
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
+#include "system/tcg.h"
 #include "trace/trace-root.h"
 
 QemuMutex qemu_cpu_list_lock;
@@ -429,6 +430,11 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
         *breakpoint = bp;
     }
 
+    /* The first breakpoint takes the CPU off the inline dispatch path. */
+    if (tcg_enabled()) {
+        tcg_update_cflags(cpu);
+    }
+
     trace_breakpoint_insert(cpu->cpu_index, pc, flags);
     return 0;
 }
@@ -452,7 +458,7 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
 }
 
 /* Remove a specific breakpoint by reference.  */
-void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
+static void cpu_breakpoint_remove_by_ref_int(CPUState *cpu, CPUBreakpoint *bp)
 {
     QTAILQ_REMOVE(&cpu->breakpoints, bp, entry);
 
@@ -460,14 +466,31 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
     g_free(bp);
 }
 
+void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
+{
+    cpu_breakpoint_remove_by_ref_int(cpu, bp);
+
+    /* The last breakpoint puts the CPU back on the inline dispatch path. */
+    if (tcg_enabled()) {
+        tcg_update_cflags(cpu);
+    }
+}
+
 /* Remove all matching breakpoints. */
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
 {
     CPUBreakpoint *bp, *next;
+    bool removed = false;
 
     QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
         if (bp->flags & mask) {
-            cpu_breakpoint_remove_by_ref(cpu, bp);
+            cpu_breakpoint_remove_by_ref_int(cpu, bp);
+            removed = true;
         }
     }
+
+    /* The last breakpoint puts the CPU back on the inline dispatch path. */
+    if (tcg_enabled() && removed) {
+        tcg_update_cflags(cpu);
+    }
 }
-- 
2.53.0


