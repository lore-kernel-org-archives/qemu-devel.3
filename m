Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9978CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGt-0007kB-F1; Sat, 30 Aug 2025 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryj2-0001KS-8j
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiw-0008UB-Nx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F5hm8v7zXpZYbYyWZdrwBknlR9l4Miea3uWC7N5NvE=;
 b=BAHaV1itdMhzp9vXTvStDiJ7NjzilNX1gVqvcVi6XgHsD72kFRBLH2h/LwKkJ8N5o1pVzM
 3jXRWewvjpltg4u4bDckqgTQRsT9Lv/c+drTjnhDE7l/u01bIbPcUKGMBssPnBkzW1vLqf
 jfdJcT255k6yhaI7pQCjyAzk+9SD07c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-aojYK-moPyGZUcDjwihraw-1; Fri, 29 Aug 2025 09:00:49 -0400
X-MC-Unique: aojYK-moPyGZUcDjwihraw-1
X-Mimecast-MFC-AGG-ID: aojYK-moPyGZUcDjwihraw_1756472448
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3cba0146f7aso1034896f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472447; x=1757077247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F5hm8v7zXpZYbYyWZdrwBknlR9l4Miea3uWC7N5NvE=;
 b=VV6/NSRQS3QpiweRX7qMUsAgPl3xL2rcBvMmIYx95+8fzsgQmfNswaEG70EbO/u4aV
 33tJKF1Fv+FOyZ9WdBfK0g2xlhAnHbysQ8CPvga581C1E2bCd4r1Yqo4CXFGCDimCdLo
 MvykKMw8y143ywzNedBY2lz8bsC4zuEbVgauYjyrGB3OicaQsz6i5+TLYgmKDF4AJS0e
 6Ca24+BWmEV+5l3KoNEwiv7z6oCm7NhETuBEftVbzIOvw7ghWVAmMtcvc2wwv96ENbXX
 D1UTRHp3n1w4QNQsDdJBbJ00ZksZsmDUDGinY7tYUrvfmv8HUGfmYpMvtDG4elNun6BL
 bUjw==
X-Gm-Message-State: AOJu0YxTewAFJH0r5aIKYgPbH/IAapeYb9ptR6A1LX3wxAuH+/Plowry
 CCVVWOXCQOObcRl/+7ySlcrJQnC1Pag7E7jIUDKS2d4+3RAeHmmNEbQrp3oTQoTxU9ERljnIyzl
 U5e3YzoKox05x7/p4dZt4GsjwAb75qZVTHM+6htfZqGSqKVVtjeNDs/Wpuvgw4PLozY6UyD0DTw
 AeDvn8QwLZLR9KPROxGyrtlxxHYzo+72RpRoM/9S5y
X-Gm-Gg: ASbGncvvFfFQ/Pep/u2yW3RnBegR3zLIkuD1KjymoBwfmlKkguMh8wgCUdqssd5w+FI
 KbOQTP9yve8Et8TF8XqRVwFf7Q8K3TXPi1VxBd71TFhJPrnwof4s/jorAUoK+51NfsdhU4CFh0k
 9/T84didtBik3qg5etNO+4Xjb8jkGCmyT+AScqQE2iKvN2DttdcBqpbpON4oM9Z9Kx6vlaZv0IG
 OZSHKoffyCDn48TtN2t1WPYKKmf9DNribASbxomqU3XdGccb43kZCv3i8W+AjgVIcuuhZe5xgbK
 zJ2UmnXT4rL5twoQCOqDOukSjXB9MpAIhTLvkASaqiejxPp2nrcnxwsBBuE56UIpNy04B6YhvYC
 PDTwWT/yXVBZkNTcN/6Y4/RqYFdaA/c2w3MDLTmomMDg=
X-Received: by 2002:a05:6000:1a8a:b0:3ce:db36:607f with SMTP id
 ffacd0b85a97d-3cedb37566amr2766314f8f.37.1756472446356; 
 Fri, 29 Aug 2025 06:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqkMrqp/M7ykiWTyHyiK2DQWuABLTm4dTNWHIO5LdIntDuArYv4nTXQOnuGaDDb9UEWb+vHA==
X-Received: by 2002:a05:6000:1a8a:b0:3ce:db36:607f with SMTP id
 ffacd0b85a97d-3cedb37566amr2766258f8f.37.1756472445360; 
 Fri, 29 Aug 2025 06:00:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc4b5sm3310026f8f.8.2025.08.29.06.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PULL 21/28] add cpu_test_interrupt()/cpu_set_interrupt() helpers and
 use them tree wide
Date: Fri, 29 Aug 2025 14:59:28 +0200
Message-ID: <20250829125935.1526984-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

The helpers form load-acquire/store-release pair and ensure
that appropriate barriers are in place in case checks happen
outside of BQL.

Use them to replace open-coded checkers/setters across the code,
to make sure that barriers are not missed.  Helpers also make code a
bit more readable.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Link: https://lore.kernel.org/r/20250821155603.2422553-1-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h               | 22 +++++++++++++++++++
 accel/tcg/cpu-exec.c                | 12 +++++-----
 accel/tcg/tcg-accel-ops.c           |  2 +-
 hw/intc/s390_flic.c                 |  2 +-
 hw/openrisc/cputimer.c              |  2 +-
 system/cpus.c                       |  9 +++++++-
 target/alpha/cpu.c                  |  8 +++----
 target/arm/cpu.c                    | 20 ++++++++---------
 target/arm/helper.c                 | 18 +++++++--------
 target/arm/hvf/hvf.c                |  6 ++---
 target/avr/cpu.c                    |  2 +-
 target/hppa/cpu.c                   |  2 +-
 target/i386/hvf/hvf.c               |  4 ++--
 target/i386/hvf/x86hvf.c            | 21 +++++++++---------
 target/i386/kvm/kvm.c               | 34 ++++++++++++++---------------
 target/i386/nvmm/nvmm-all.c         | 24 ++++++++++----------
 target/i386/tcg/system/seg_helper.c |  2 +-
 target/i386/tcg/system/svm_helper.c |  2 +-
 target/i386/whpx/whpx-all.c         | 34 ++++++++++++++---------------
 target/loongarch/cpu.c              |  2 +-
 target/m68k/cpu.c                   |  2 +-
 target/microblaze/cpu.c             |  2 +-
 target/mips/cpu.c                   |  6 ++---
 target/mips/kvm.c                   |  2 +-
 target/openrisc/cpu.c               |  3 +--
 target/ppc/cpu_init.c               |  2 +-
 target/ppc/kvm.c                    |  2 +-
 target/rx/cpu.c                     |  3 +--
 target/rx/helper.c                  |  2 +-
 target/s390x/cpu-system.c           |  2 +-
 target/sh4/cpu.c                    |  2 +-
 target/sh4/helper.c                 |  2 +-
 target/sparc/cpu.c                  |  2 +-
 target/sparc/int64_helper.c         |  4 ++--
 34 files changed, 145 insertions(+), 119 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f73b4357c7b..b01a0cffd64 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -943,6 +943,28 @@ CPUState *cpu_by_arch_id(int64_t id);
 
 void cpu_interrupt(CPUState *cpu, int mask);
 
+/**
+ * cpu_test_interrupt:
+ * @cpu: The CPU to check interrupt(s) on.
+ * @mask: The interrupts to check.
+ *
+ * Checks if any of interrupts in @mask are pending on @cpu.
+ */
+static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
+{
+    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
+}
+
+/**
+ * cpu_set_interrupt:
+ * @cpu: The CPU to set pending interrupt(s) on.
+ * @mask: The interrupts to set.
+ *
+ * Sets interrupts in @mask as pending on @cpu.  Unlike @cpu_interrupt,
+ * this does not kick the vCPU.
+ */
+void cpu_set_interrupt(CPUState *cpu, int mask);
+
 /**
  * cpu_set_pc:
  * @cpu: The CPU to set the program counter for.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b44dd1e8205..96c124aa720 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -779,9 +779,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
 #ifdef CONFIG_USER_ONLY
-    g_assert(!qatomic_read(&cpu->interrupt_request));
+    assert(!cpu_test_interrupt(cpu, ~0));
 #else
-    if (unlikely(qatomic_read(&cpu->interrupt_request))) {
+    if (unlikely(cpu_test_interrupt(cpu, ~0))) {
         int interrupt_request;
         bql_lock();
         interrupt_request = cpu->interrupt_request;
@@ -789,7 +789,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
         }
-        if (interrupt_request & CPU_INTERRUPT_DEBUG) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
             cpu->exception_index = EXCP_DEBUG;
             bql_unlock();
@@ -797,7 +797,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         }
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
-        } else if (interrupt_request & CPU_INTERRUPT_HALT) {
+        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
             replay_interrupt();
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
             cpu->halted = 1;
@@ -807,7 +807,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         } else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-            if (interrupt_request & CPU_INTERRUPT_RESET) {
+            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
                 replay_interrupt();
                 tcg_ops->cpu_exec_reset(cpu);
                 bql_unlock();
@@ -842,7 +842,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
              * reload the 'interrupt_request' value */
             interrupt_request = cpu->interrupt_request;
         }
-        if (interrupt_request & CPU_INTERRUPT_EXITTB) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
             /* ensure that no TB jump will be modified as
                the program flow was changed */
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3b0d7d298e6..9c37266c1e0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -97,7 +97,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_set_interrupt(cpu, mask);
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 8f4c9fd52e8..1eed5125d17 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -190,7 +190,7 @@ static void qemu_s390_flic_notify(uint32_t type)
     CPU_FOREACH(cs) {
         S390CPU *cpu = S390_CPU(cs);
 
-        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+        cpu_set_interrupt(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
         if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 6331997d56b..51da226fcde 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -105,7 +105,7 @@ static void openrisc_timer_cb(void *opaque)
         CPUState *cs = CPU(cpu);
 
         cpu->env.ttmr |= TTMR_IP;
-        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+        cpu_set_interrupt(cs, CPU_INTERRUPT_TIMER);
     }
 
     switch (cpu->env.ttmr & TTMR_M) {
diff --git a/system/cpus.c b/system/cpus.c
index 256723558d0..437848b5eb4 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -254,9 +254,16 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
+void cpu_set_interrupt(CPUState *cpu, int mask)
+{
+    /* Pairs with cpu_test_interrupt(). */
+    qatomic_store_release(&cpu->interrupt_request,
+        cpu->interrupt_request | mask);
+}
+
 void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_set_interrupt(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index bf1787a69dd..932cddac055 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -86,10 +86,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
        assume that if a CPU really wants to stay asleep, it will mask
        interrupts at the chipset level, which will prevent these bits
        from being set in the first place.  */
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD
-                                    | CPU_INTERRUPT_TIMER
-                                    | CPU_INTERRUPT_SMP
-                                    | CPU_INTERRUPT_MCHK);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD
+                                  | CPU_INTERRUPT_TIMER
+                                  | CPU_INTERRUPT_SMP
+                                  | CPU_INTERRUPT_MCHK);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399c..a29c3facbfd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -142,11 +142,11 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
-        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-         | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
-         | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
-         | CPU_INTERRUPT_EXITTB);
+        && cpu_test_interrupt(cs,
+               CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+               | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
+               | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
+               | CPU_INTERRUPT_EXITTB);
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -958,7 +958,7 @@ void arm_cpu_update_virq(ARMCPU *cpu)
         !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
         } else {
@@ -980,7 +980,7 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
         !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
         } else {
@@ -1002,7 +1002,7 @@ void arm_cpu_update_vinmi(ARMCPU *cpu)
                       (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VINMI);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VINMI) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
         } else {
@@ -1022,7 +1022,7 @@ void arm_cpu_update_vfnmi(ARMCPU *cpu)
     bool new_state = (arm_hcr_el2_eff(env) & HCR_VF) &&
                       (arm_hcrx_el2_eff(env) & HCRX_VFNMI);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFNMI) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFNMI);
         } else {
@@ -1041,7 +1041,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu)
 
     bool new_state = env->cp15.hcr_el2 & HCR_VSE;
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VSERR) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VSERR);
         } else {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff841..4cd36e950aa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -833,40 +833,40 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t ret = 0;
 
     if (hcr_el2 & HCR_IMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
             ret |= CPSR_I;
         }
-        if (cs->interrupt_request & CPU_INTERRUPT_VINMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
             ret |= ISR_IS;
             ret |= CPSR_I;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
             ret |= CPSR_I;
         }
 
-        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
             ret |= ISR_IS;
             ret |= CPSR_I;
         }
     }
 
     if (hcr_el2 & HCR_FMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
             ret |= CPSR_F;
         }
-        if (cs->interrupt_request & CPU_INTERRUPT_VFNMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
             ret |= ISR_FS;
             ret |= CPSR_F;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIQ)) {
             ret |= CPSR_F;
         }
     }
 
     if (hcr_el2 & HCR_AMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VSERR) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
             ret |= CPSR_A;
         }
     }
@@ -9147,7 +9147,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a351..b77db99079e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1782,13 +1782,13 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
 
 static int hvf_inject_interrupts(CPUState *cpu)
 {
-    if (cpu->interrupt_request & CPU_INTERRUPT_FIQ) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
         trace_hvf_inject_fiq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_FIQ,
                                       true);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         trace_hvf_inject_irq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_IRQ,
                                       true);
@@ -1840,7 +1840,7 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
-    if (cpu->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
         /* Interrupt pending, no need to wait */
         return;
     }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 6995de6a12b..a6df71d0205 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -45,7 +45,7 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
 
 static bool avr_cpu_has_work(CPUState *cs)
 {
-    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET))
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
             && cpu_interrupts_enabled(cpu_env(cs));
 }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 24777727e62..0ca79ee5e23 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -135,7 +135,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 818b50419f4..8445cadecec 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -773,9 +773,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
                 (env->eflags & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu->halted = 1;
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 17fce1d3cdd..9e05e0e5765 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -395,7 +395,7 @@ bool hvf_inject_interrupts(CPUState *cs)
         };
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
@@ -406,7 +406,7 @@ bool hvf_inject_interrupts(CPUState *cs)
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+        cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(env);
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
@@ -415,11 +415,10 @@ bool hvf_inject_interrupts(CPUState *cs)
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         vmx_set_int_window_exiting(cs);
     }
-    return (cs->interrupt_request
-            & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR);
 }
 
 int hvf_process_events(CPUState *cs)
@@ -432,25 +431,25 @@ int hvf_process_events(CPUState *cs)
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_INIT)) {
         cpu_synchronize_state(cs);
         do_cpu_init(cpu);
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 0;
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
         cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
         cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8d..a7b5c8f81bc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5453,8 +5453,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     int ret;
 
     /* Inject NMI */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
             bql_lock();
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             bql_unlock();
@@ -5465,7 +5465,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                         strerror(-ret));
             }
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
             bql_lock();
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
             bql_unlock();
@@ -5486,12 +5486,12 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
             cpu->exit_request = 1;
         }
     }
@@ -5499,7 +5499,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -5523,7 +5523,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -5595,7 +5595,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_MCE)) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -5618,7 +5618,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -5628,20 +5628,20 @@ int kvm_arch_process_async_events(CPUState *cs)
         return 0;
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 0;
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
@@ -5656,9 +5656,9 @@ static int kvm_handle_halt(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
 
-    if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 1;
         return EXCP_HLT;
     }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 92e3b8b2f45..c1ac74c4f04 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -413,11 +413,11 @@ nvmm_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests
      * or commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         cpu->exit_request = 1;
     }
 
-    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+    if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         if (nvmm_can_take_nmi(cpu)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             event->type = NVMM_VCPU_EVENT_INTR;
@@ -426,7 +426,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
         }
     }
 
-    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         if (nvmm_can_take_int(cpu)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
             event->type = NVMM_VCPU_EVENT_INTR;
@@ -436,7 +436,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Don't want SMIs. */
-    if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
     }
 
@@ -651,9 +651,9 @@ nvmm_handle_halted(struct nvmm_machine *mach, CPUState *cpu,
 
     bql_lock();
 
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
           (cpu_env(cpu)->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
         ret = 1;
@@ -691,25 +691,25 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Some asynchronous events must be handled outside of the inner
      * VCPU loop. They are handled here.
      */
-    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT)) {
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
         /* set int/nmi windows back to the reset state */
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(x86_cpu->apic_state);
     }
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
         nvmm_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index d4ea890c124..794a23ddfc4 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -133,7 +133,7 @@ bool x86_cpu_exec_halt(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
         apic_poll_irq(x86_cpu->apic_state);
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index dea039b87a6..3569196bdda 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -403,7 +403,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     env->hflags2 |= HF2_GIF_MASK;
 
     if (ctl_has_irq(env)) {
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+        cpu_set_interrupt(cs, CPU_INTERRUPT_VIRQ);
     }
 
     if (virtual_gif_set(env)) {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b72dcff3c8d..878cdd1668c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1436,9 +1436,9 @@ static int whpx_handle_halt(CPUState *cpu)
     int ret = 0;
 
     bql_lock();
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
           (cpu_env(cpu)->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
         ret = 1;
@@ -1469,15 +1469,15 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Inject NMI */
     if (!vcpu->interruption_pending &&
-        cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
         }
     }
@@ -1486,12 +1486,12 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests or
      * commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
             cpu->exit_request = 1;
         }
     }
@@ -1501,7 +1501,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         if (!vcpu->interruption_pending &&
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
-            if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
                 irq = cpu_get_pic_interrupt(env);
                 if (irq >= 0) {
@@ -1519,7 +1519,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_count += 1;
         }
     } else if (vcpu->ready_for_pic_interrupt &&
-               (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+               cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
         irq = cpu_get_pic_interrupt(env);
         if (irq >= 0) {
@@ -1546,7 +1546,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Update the state of the interrupt delivery notification */
     if (!vcpu->window_registered &&
-        cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
                 .InterruptNotification = 1
@@ -1599,30 +1599,30 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *vcpu = cpu->accel;
 
-    if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
         vcpu->interruptable = true;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
         whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c0547..3a7621c0ea0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -376,7 +376,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
         has_work = true;
     }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 6a09db3a6f6..f1b673119d6 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -74,7 +74,7 @@ static void m68k_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ee0a869a94a..22231f09e60 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -129,7 +129,7 @@ static void mb_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1f6c41fd340..5989c3ba177 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -145,7 +145,7 @@ static bool mips_cpu_has_work(CPUState *cs)
      * check for interrupts that can be taken. For pre-release 6 CPUs,
      * check for CP0 Config7 'Wait IE ignore' bit.
      */
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
             (env->CP0_Config7 & (1 << CP0C7_WII)) ||
@@ -160,7 +160,7 @@ static bool mips_cpu_has_work(CPUState *cs)
          * The QEMU model will issue an _WAKE request whenever the CPUs
          * should be woken up.
          */
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_WAKE)) {
             has_work = true;
         }
 
@@ -170,7 +170,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     /* MIPS Release 6 has the ability to halt the CPU.  */
     if (env->CP0_Config5 & (1 << CP0C5_VP)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_WAKE)) {
             has_work = true;
         }
         if (!mips_vp_active(env)) {
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index ec53acb51a1..450947c3fa5 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -144,7 +144,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
     bql_lock();
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
             cpu_mips_io_interrupts_pending(cpu)) {
         intr.cpu = -1;
         intr.irq = 2;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dfbb2df643a..9bbfe22ed3a 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -78,8 +78,7 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_TIMER);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0e77f2673e..db841f12603 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7225,7 +7225,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 015658049e6..d145774b09a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1354,7 +1354,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         FIELD_EX64(env->msr, MSR, EE)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c6dd5d6f832..da02ae7bf88 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -75,8 +75,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
 
 static bool rx_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
-        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
 static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0640ab322b5..ce003af4219 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
-    int do_irq = cs->interrupt_request & INT_FLAGS;
+    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
 
     env->in_sleep = 0;
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 709ccd52992..f3a9ffb2a27 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -49,7 +49,7 @@ bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         return false;
     }
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 4f561e8c912..21ccb86df48 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -108,7 +108,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index fb7642bda1b..1744ef0e6d8 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -58,7 +58,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     CPUSH4State *env = cpu_env(cs);
-    int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
+    int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 245caf2de02..c9773f15401 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -783,7 +783,7 @@ static void sparc_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index bd14c7a0db9..49e4e51c6dc 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -89,7 +89,7 @@ void cpu_check_irqs(CPUSPARCState *env)
      * the next bit is (2 << psrpil).
      */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -120,7 +120,7 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
                                               env->interrupt_index);
         env->interrupt_index = 0;
-- 
2.51.0


