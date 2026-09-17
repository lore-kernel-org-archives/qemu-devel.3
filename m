Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD61C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Um-000494-PD; Thu, 17 Sep 2026 05:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Uc-00043e-DE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:23 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UZ-00018N-Nt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:21 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so552320a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637598; x=1790242398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOcERuk2GjTtsePJxD33EGjnCJ29zdvSiTMyHHnMb+o=;
 b=mZslImvhLAHIimFf1/f823piOxDxDCbsvJCtTyKogU5E5y8zTHn/LEajD5g69rUked
 KbN0o45r/y1XAh3SJysqSoNdlAg9nYxzi4G/qF4P6WtZ2r8YQDfzvIlfbR+OeiWdmlbq
 9GqZRVaHrkSUUCsK0AOqWDM+BdERK3RHBhGC+o1rmAcsWZ3Njbr1wFqLf4SvC01c/rz+
 oy22NmZsr/drnzNj3y5TSRYqMdMZGUQM/TIu7RzqNZrTYcr39d/0YVT7liSBNGURS9lf
 adQa4Yb5bYVFcDRpAqDAcDP/u6n8KOvn5djhKmanSSGpjuiqchsiReyX/AWwvC30Yaa0
 EkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637598; x=1790242398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iOcERuk2GjTtsePJxD33EGjnCJ29zdvSiTMyHHnMb+o=;
 b=JgHnXGmmibw4WzNBhZjlkmfeNDGbcHN8umKfOUgLhyx1Ah62c1RNpX6HpQOuuY2QBH
 u8imvtQ/pBRQ9YatkqTFiBRoarEBufJyoNdvgGyyDRTn0cp4vfv4B3SNhLgRtAq8rgsy
 RC+9+Ctw2tRdCJouW9TvL6Q89HteQgazpQtbqPcgJGNnAM0y7Q9p3Zt1ulJw7PNruJn+
 toXWZbbKDTFKwoQcA4rM3tPXH2PPPHy1sQ9Gg0krg4eT1RPA9bHqjYQkCwDUwPaRfulE
 1H7v4gmyVOr5U9eL2v+Qpm97Kk2qa8PFPkMizg+JnFBNTLFRkmOvfgFsOw6KWQBdYHDs
 SCEQ==
X-Gm-Message-State: AFuF++nl+097sXFDhzVW4iUqreFweE1Km50VC7JGnL/wwXYPQL6Ixwfl
 lbct3D/AVbaSqtrecVPVT1eHb3tO312JdDuQalfRqPkKiQklsO0FKbnmFfHFK6RaTzL0d3RocLz
 GCfjgDNg=
X-Gm-Gg: AYBFou2ENdvVHR2SPOrg1X//T5BVZ4PpI4/IzvxdM9L1FxrEPqqzOsnq4k+oc9y6meM
 XLKxznappeEyiHwKO18zy+OhF3wUDSHCZsLL2/xQaut7LxmjPidPevcpKyf4l7OX6xFIoiIJLIo
 V+TNZWRY1rc2+cbutEE8iY5SeqeS1MRKZlvoRas5rVs4qexdzTcf6iyDoY2boTOxTzEZwVq24RL
 4iWZoLUZfqe4rCisTogGPyfNYQEjhObVkzabxIVXSe+luzHi9GVYMdErUWOjwNDUnJ0o7ASdGX8
 lNZSEkzNjWY3MBlrZp5qz3unfUpy31jKIYW1qM78B28xSu+3aAZfEn4+pejmvWwZ/hpgJrq0P+t
 Af93dNgQroRdPm5lADmALtlKXKjSOqGynkYK7uT5xY7TjXmUnAqJfG+RiYuC6e2ElPGdQFUgUkj
 JAgzXX7R9MtWa2e1y2hfmgfq73V4HViB2DqANfhp0RANhT3qbMUvm/qRcwukyo4Rbp6fGYTj56f
 h5eTtA=
X-Received: by 2002:a17:90a:1c97:b0:39e:1fb6:9659 with SMTP id
 98e67ed59e1d1-39e1fb6994cmr8876622a91.22.1789637598212; 
 Thu, 17 Sep 2026 02:33:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 07/13] accel/tcg: add CF_NO_GOTO_JC,
 set while a breakpoint is present
Date: Wed, 16 Sep 2026 23:33:01 -1000
Message-ID: <20260917093307.1092084-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
 accel/tcg/cpu-exec-common.c      | 16 ++++++++++++++--
 cpu-common.c                     | 25 ++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc6990318..f3410dbcb93 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -76,14 +76,15 @@ struct TranslationBlock {
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
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
+#define CF_MEMI_ONLY     0x00080000 /* Only instrument memory ops */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 9f3517f36b6..9f9555e34f6 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -38,10 +38,11 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
 
 /*
  * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, because
- * they are derived from gdb single-step, one-insn-per-tb and -d nochain.
+ * they are derived from gdb single-step, one-insn-per-tb and -d nochain,
+ * or from various cpu parameters.
  */
 #define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
-                     CF_SINGLE_STEP)
+                     CF_NO_GOTO_JC | CF_SINGLE_STEP)
 
 void tcg_update_cflags(CPUState *cpu)
 {
@@ -62,6 +63,17 @@ void tcg_update_cflags(CPUState *cpu)
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
 
diff --git a/cpu-common.c b/cpu-common.c
index adb76b3a786..909f8d059b4 100644
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
             cpu_breakpoint_remove_by_ref(cpu, bp);
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


