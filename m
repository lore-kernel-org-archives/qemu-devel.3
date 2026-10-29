Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F21606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=OiCzYPxk;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=mJgZuV+T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU8d-0003ZT-7W; Thu, 29 Oct 2026 13:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8W-0003Xs-A6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:01 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8Q-0003HD-TU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:41:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=nGjbx5C
 i4D1FlqCVBNbmP/DjExWe6lkmy3BlJc2S/gGma0Cu5rwiqa3ruGc7aKXxff/hsFgh4H59T
 PEIzSJfYD5699J6f6Fka3xMNzilLUwCPrLVWc4mr02Qg6AMIrYHmfrFgHvZoLS6opqt7NT
 x91if76sT56oOHNdaB+BNgwB4lDBcnMOUFENSzPXgHxL8y7rNc4IDpcQ553MHAEEldHUFB
 0UBHdubzF4B+JaWhqnA9WMWK9IGGUKyXG+Wbh4bFflMqT01ZkE9SSMbGo6WBj54JB+Oz4P
 jTaXDjgS48sAMzZQYMx+xJ0sWqL/jTRs/wrFoG6qCexp5iReyA2LeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=w
 rE8uhA873fBXxD6A4Pqm0uVdETQPSaFbfMX+M902sA=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=M4LJGIWRQkTmp9dqIUlJFHnumtTtHFrcfQ5n7VV/2hkvqUqyTgU/DumSDWwTr9FUBeXS
 h60cFrfI2PXfnPDskE01VMr3jkvoL37rA5VIE9OngpsSz6dQpMVlblT8q28Xxhkzn5ufiQ
 r5JjCC2q1HXEEqdvmt1GFpafOPZWEvJiUy+E97/ffj0FoEIc1RacyaNKRPjaQXYKSulv4q
 DCOnCQrdtj4GtB9GO/KMy9NxejTEW+P+cVUfQc3AhdF7+ZcV70DTQPxBZ8RJ2j6fCbdS1Y
 nnqMCmVc6uE4vhCka82/SesHELX+F4R9sb08mI5gNaqDujewMbwLB0ea+Z0bpbpA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=OiCzYPxk; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mJgZuV+T;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=wrE8uhA8
 73fBXxD6A4Pqm0uVdETQPSaFbfMX+M902sA=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=OiCzYPxkj3WzotVcSlWzdt/5/rJq1OgY5tP
 eSOxB4Zy7CNQYt1wOKR+7KNaryj1HkRgUga2rFSSpx7uvYheHn6T+P7RTwolCzC5fCuo9p
 84Evx1WQh9TOgZgiufdYxrXRe0bFQgQXErJ7XiOZwC8UB+37Kp35UsLateu0LAwYk/PNTf
 hZq8nINAJ4lOsZ2fQd8laF0tEr/SIIvYhQKjLUqwTQwXYwF8G1sPJBouYm/fxX7iYj8IRs
 NqkbAfDJd3J/M7JuIZJlFBZaO5fmH0sHMK51O9+h4pJA9HMYekPQPekqtQo/czoPzpjIj5
 ZUZB7oAe84ivsTzsKaaMNGIuFyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=wrE8uhA873fBXxD6A4Pqm0uVdETQPSaFbfMX+M902sA=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=mJgZuV+TBz+m7ncbEb
 mkd6Odm25AwC3He+ENlAcgCA/wovIK4KtKp9jBNQF+rCWyVoT0SCb5XumBKY+FHOXKCw==
Received: by mx1.catap.net (OpenSMTPD) id 3fc0701b;
 Thu, 29 Oct 2026 18:41:49 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id c049d7c5;
 Thu, 29 Oct 2026 18:41:47 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 01/26] target/mips: make CP0 interrupt state atomic
Date: Thu, 29 Oct 2026 18:36:01 +0100
Message-ID: <20261029174139.44302-2-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MTTCG lets interrupt inputs and timer callbacks update CP0_Cause,
CP0_Status, and CP0_Count while a vCPU checks interrupt state.

Use qatomic accessors for CP0 fields that participate in interrupt and
timer decisions, and kick remote CPUs explicitly after raising a hard
interrupt; MIPS interrupt line updates no longer depend on taking the
BQL.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/mips_int.c                      | 17 +++++++------
 target/mips/internal.h                  | 13 ++++++----
 target/mips/system/cp0.c                | 27 +++++++++++++--------
 target/mips/system/cp0_timer.c          | 32 ++++++++++++++-----------
 target/mips/tcg/system/special_helper.c | 17 +++++++------
 target/mips/tcg/system/tlb_helper.c     | 21 +++++++++-------
 6 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 26e7dd6d5f..537394c8fd 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -21,30 +21,33 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "hw/core/irq.h"
 #include "target/mips/cpu.h"
+#include "target/mips/internal.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
 {
     MIPSCPU *cpu = opaque;
     CPUMIPSState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    int32_t irq_bit;
 
     if (irq < 0 || irq > 7) {
         return;
     }
 
-    BQL_LOCK_GUARD();
-
+    irq_bit = 1 << (irq + CP0Ca_IP);
     if (level) {
-        env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
+        qatomic_or(&env->CP0_Cause, irq_bit);
     } else {
-        env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
+        qatomic_and(&env->CP0_Cause, ~irq_bit);
     }
 
-    if (env->CP0_Cause & CP0Ca_IP_mask) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    if (qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask) {
+        cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
+        if (!qemu_cpu_is_self(cs)) {
+            qemu_cpu_kick(cs);
+        }
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index a302fc0c20..eb726bd5e3 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -8,6 +8,7 @@
 #ifndef MIPS_INTERNAL_H
 #define MIPS_INTERNAL_H
 
+#include "qemu/atomic.h"
 #include "exec/memattrs.h"
 #ifdef CONFIG_TCG
 #include "tcg/tcg-internal.h"
@@ -168,9 +169,11 @@ extern const VMStateDescription vmstate_mips_cpu;
 
 static inline bool cpu_mips_hw_interrupts_enabled(const CPUMIPSState *env)
 {
-    return (env->CP0_Status & (1 << CP0St_IE)) &&
-        !(env->CP0_Status & (1 << CP0St_EXL)) &&
-        !(env->CP0_Status & (1 << CP0St_ERL)) &&
+    int32_t status = qatomic_read(&env->CP0_Status);
+
+    return (status & (1 << CP0St_IE)) &&
+        !(status & (1 << CP0St_EXL)) &&
+        !(status & (1 << CP0St_ERL)) &&
         !(env->hflags & MIPS_HFLAG_DM) &&
         /*
          * Note that the TCStatus IXMT field is initialized to zero,
@@ -187,8 +190,8 @@ static inline bool cpu_mips_hw_interrupts_pending(const CPUMIPSState *env)
     int32_t status;
     bool r;
 
-    pending = env->CP0_Cause & CP0Ca_IP_mask;
-    status = env->CP0_Status & CP0Ca_IP_mask;
+    pending = qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask;
+    status = qatomic_read(&env->CP0_Status) & CP0Ca_IP_mask;
 
     if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
         /*
diff --git a/target/mips/system/cp0.c b/target/mips/system/cp0.c
index ff7d3db00c..6f222ad586 100644
--- a/target/mips/system/cp0.c
+++ b/target/mips/system/cp0.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/cputlb.h"
+#include "qemu/atomic.h"
 
 /* Called for updates to CP0_Status.  */
 void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
@@ -61,7 +62,8 @@ void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
 void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
 {
     uint32_t mask = env->CP0_Status_rw_bitmask;
-    target_ulong old = env->CP0_Status;
+    target_ulong old;
+    target_ulong status;
 
     if (env->insn_flags & ISA_MIPS_R6) {
         bool has_supervisor = extract32(mask, CP0St_KSU, 2) == 0x3;
@@ -77,9 +79,11 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
         mask &= ~(((1 << CP0St_SR) | (1 << CP0St_NMI)) & val);
     }
 
-    env->CP0_Status = (old & ~mask) | (val & mask);
+    old = qatomic_read(&env->CP0_Status);
+    status = (old & ~mask) | (val & mask);
+    qatomic_set(&env->CP0_Status, status);
 #if defined(TARGET_MIPS64)
-    if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
+    if ((status ^ old) & (old & (7 << CP0St_UX))) {
         /* Access to at least one of the 64-bit segments has been disabled */
         tlb_flush(env_cpu(env));
     }
@@ -93,8 +97,9 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
 
 void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
 {
-    uint32_t mask = 0x00C00300;
-    uint32_t old = env->CP0_Cause;
+    int32_t mask = 0x00C00300;
+    int32_t old;
+    int32_t cause;
     int i;
 
     if (env->insn_flags & ISA_MIPS_R2) {
@@ -104,10 +109,12 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
         mask &= ~((1 << CP0Ca_WP) & val);
     }
 
-    env->CP0_Cause = (env->CP0_Cause & ~mask) | (val & mask);
+    old = qatomic_fetch_and(&env->CP0_Cause, ~mask);
+    qatomic_or(&env->CP0_Cause, (int32_t)(val & mask));
+    cause = qatomic_read(&env->CP0_Cause);
 
-    if ((old ^ env->CP0_Cause) & (1 << CP0Ca_DC)) {
-        if (env->CP0_Cause & (1 << CP0Ca_DC)) {
+    if ((old ^ cause) & (1 << CP0Ca_DC)) {
+        if (cause & (1 << CP0Ca_DC)) {
             cpu_mips_stop_count(env);
         } else {
             cpu_mips_start_count(env);
@@ -116,8 +123,8 @@ void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val)
 
     /* Set/reset software interrupts */
     for (i = 0 ; i < 2 ; i++) {
-        if ((old ^ env->CP0_Cause) & (1 << (CP0Ca_IP + i))) {
-            cpu_mips_soft_irq(env, i, env->CP0_Cause & (1 << (CP0Ca_IP + i)));
+        if ((old ^ cause) & (1 << (CP0Ca_IP + i))) {
+            cpu_mips_soft_irq(env, i, cause & (1 << (CP0Ca_IP + i)));
         }
     }
 }
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index 6aed5d3af2..622fee357d 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
+#include "qemu/atomic.h"
 #include "internal.h"
 
 /* MIPS R4K timer */
@@ -31,7 +32,7 @@ static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
     MIPSCPU *cpu = env_archcpu(env);
     int64_t now_ns;
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    return env->CP0_Count +
+    return qatomic_read(&env->CP0_Count) +
             (uint32_t)clock_ns_to_ticks(cpu->count_clock, now_ns);
 }
 
@@ -56,15 +57,15 @@ static void cpu_mips_timer_expire(CPUMIPSState *env)
 {
     cpu_mips_timer_update(env);
     if (env->insn_flags & ISA_MIPS_R2) {
-        env->CP0_Cause |= 1 << CP0Ca_TI;
+        qatomic_or(&env->CP0_Cause, 1 << CP0Ca_TI);
     }
     qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
 
 uint32_t cpu_mips_get_count(CPUMIPSState *env)
 {
-    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
-        return env->CP0_Count;
+    if (qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) {
+        return qatomic_read(&env->CP0_Count);
     } else {
         uint64_t now_ns;
 
@@ -86,12 +87,13 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
      * So env->timer may be NULL, so treat timer as disabled in that case.
      */
     MIPSCPU *cpu = env_archcpu(env);
-    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
-        env->CP0_Count = count;
+    if ((qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) || !env->timer) {
+        qatomic_set(&env->CP0_Count, count);
     } else {
         /* Store new count register */
-        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
-                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        qatomic_set(&env->CP0_Count,
+                    count - (uint32_t)clock_ns_to_ticks(cpu->count_clock,
+                            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)));
         /* Update timer timer */
         cpu_mips_timer_update(env);
     }
@@ -100,26 +102,28 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
 void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value)
 {
     env->CP0_Compare = value;
-    if (!(env->CP0_Cause & (1 << CP0Ca_DC))) {
+    if (!(qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC))) {
         cpu_mips_timer_update(env);
     }
     if (env->insn_flags & ISA_MIPS_R2) {
-        env->CP0_Cause &= ~(1 << CP0Ca_TI);
+        qatomic_and(&env->CP0_Cause, ~(1 << CP0Ca_TI));
     }
     qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
 }
 
 void cpu_mips_start_count(CPUMIPSState *env)
 {
-    cpu_mips_store_count(env, env->CP0_Count);
+    cpu_mips_store_count(env, qatomic_read(&env->CP0_Count));
 }
 
 void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
     MIPSCPU *cpu = env_archcpu(env);
-    env->CP0_Count += (uint32_t)clock_ns_to_ticks(cpu->count_clock,
-                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+
+    qatomic_add(&env->CP0_Count,
+                (uint32_t)clock_ns_to_ticks(cpu->count_clock,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)));
 }
 
 static void mips_timer_cb(void *opaque)
@@ -128,7 +132,7 @@ static void mips_timer_cb(void *opaque)
 
     env = opaque;
 
-    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
+    if (qatomic_read(&env->CP0_Cause) & (1 << CP0Ca_DC)) {
         return;
     }
 
diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
index cc46542806..fe3111fb54 100644
--- a/target/mips/tcg/system/special_helper.c
+++ b/target/mips/tcg/system/special_helper.c
@@ -24,21 +24,22 @@
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "internal.h"
+#include "qemu/atomic.h"
 
 /* Specials */
 target_ulong HELPER(di)(CPUMIPSState *env)
 {
-    target_ulong t0 = env->CP0_Status;
+    target_ulong t0 = qatomic_read(&env->CP0_Status);
 
-    env->CP0_Status = t0 & ~(1 << CP0St_IE);
+    qatomic_set(&env->CP0_Status, t0 & ~(1 << CP0St_IE));
     return t0;
 }
 
 target_ulong HELPER(ei)(CPUMIPSState *env)
 {
-    target_ulong t0 = env->CP0_Status;
+    target_ulong t0 = qatomic_read(&env->CP0_Status);
 
-    env->CP0_Status = t0 | (1 << CP0St_IE);
+    qatomic_set(&env->CP0_Status, t0 | (1 << CP0St_IE));
     return t0;
 }
 
@@ -103,13 +104,15 @@ bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb)
 
 static inline void exception_return(CPUMIPSState *env)
 {
+    target_ulong status = qatomic_read(&env->CP0_Status);
+
     debug_pre_eret(env);
-    if (env->CP0_Status & (1 << CP0St_ERL)) {
+    if (status & (1 << CP0St_ERL)) {
         mips_env_set_pc(env, env->CP0_ErrorEPC);
-        env->CP0_Status &= ~(1 << CP0St_ERL);
+        qatomic_set(&env->CP0_Status, status & ~(1 << CP0St_ERL));
     } else {
         mips_env_set_pc(env, env->CP0_EPC);
-        env->CP0_Status &= ~(1 << CP0St_EXL);
+        qatomic_set(&env->CP0_Status, status & ~(1 << CP0St_EXL));
     }
     compute_hflags(env);
     debug_post_eret(env);
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 0ff0c9c871..9e01c07609 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -1106,7 +1106,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         env->hflags &= ~(MIPS_HFLAG_KSU);
         /* EJTAG probe trap enable is not implemented... */
         if (!(env->CP0_Status & (1 << CP0St_EXL))) {
-            env->CP0_Cause &= ~(1U << CP0Ca_BD);
+            qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));
         }
         env->active_tc.PC = env->exception_base + 0x480;
         set_hflags_for_handler(env);
@@ -1134,7 +1134,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         env->hflags |= MIPS_HFLAG_CP0;
         env->hflags &= ~(MIPS_HFLAG_KSU);
         if (!(env->CP0_Status & (1 << CP0St_EXL))) {
-            env->CP0_Cause &= ~(1U << CP0Ca_BD);
+            qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));
         }
         env->active_tc.PC = env->exception_base;
         set_hflags_for_handler(env);
@@ -1148,7 +1148,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
                 offset = 0x200;
             } else {
                 uint32_t vector = 0;
-                uint32_t pending = (env->CP0_Cause & CP0Ca_IP_mask) >> CP0Ca_IP;
+                uint32_t pending =
+                    (qatomic_read(&env->CP0_Cause) & CP0Ca_IP_mask) >>
+                    CP0Ca_IP;
 
                 if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
                     /*
@@ -1246,8 +1248,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
     case EXCP_CpU:
         cause = 11;
         update_badinstr = 1;
-        env->CP0_Cause = (env->CP0_Cause & ~(0x3 << CP0Ca_CE)) |
-                         (env->error_code << CP0Ca_CE);
+        qatomic_and(&env->CP0_Cause, (int32_t)~(0x3U << CP0Ca_CE));
+        qatomic_or(&env->CP0_Cause,
+                   (int32_t)(env->error_code << CP0Ca_CE));
         goto set_EPC;
     case EXCP_OVERFLOW:
         cause = 12;
@@ -1305,9 +1308,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
                 set_badinstr_registers(env);
             }
             if (env->hflags & MIPS_HFLAG_BMASK) {
-                env->CP0_Cause |= (1U << CP0Ca_BD);
+                qatomic_or(&env->CP0_Cause, (int32_t)(1U << CP0Ca_BD));
             } else {
-                env->CP0_Cause &= ~(1U << CP0Ca_BD);
+                qatomic_and(&env->CP0_Cause, (int32_t)~(1U << CP0Ca_BD));
             }
             env->CP0_Status |= (1 << CP0St_EXL);
             if (env->insn_flags & ISA_MIPS3) {
@@ -1333,8 +1336,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
 
         env->active_tc.PC += offset;
         set_hflags_for_handler(env);
-        env->CP0_Cause = (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
-                         (cause << CP0Ca_EC);
+        qatomic_and(&env->CP0_Cause, (int32_t)~(0x1f << CP0Ca_EC));
+        qatomic_or(&env->CP0_Cause, cause << CP0Ca_EC);
         break;
     default:
         abort();
-- 
2.56.0


