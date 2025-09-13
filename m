Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28826CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKw-0005mj-Gb; Sat, 13 Sep 2025 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKu-0005m3-Ti
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKs-0004s9-79
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9F9omlNx3zkAVVgrXaGDIxi/SyKkxZLJobZOnZwp8BQ=;
 b=gufRBsp/zjf77L3hwY7Tcgn2VJikdjbgUcJP6fNxOxx1Wsk7L0S6gDQ46s0CZh61DylOlF
 G6vq9JoOrztfSQXddXvpWNZB4r3QE6/Q3cGLkzUxs7hisXcG7tQrEfTgOqdx7G1clQxyeg
 JDWd00bcpPDIJ86WCYk0NtKCx7EPzJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-4VAWEx9SNPKoK2TqitXKkQ-1; Sat, 13 Sep 2025 04:10:15 -0400
X-MC-Unique: 4VAWEx9SNPKoK2TqitXKkQ-1
X-Mimecast-MFC-AGG-ID: 4VAWEx9SNPKoK2TqitXKkQ_1757751014
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e3f8616125so2192858f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751013; x=1758355813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F9omlNx3zkAVVgrXaGDIxi/SyKkxZLJobZOnZwp8BQ=;
 b=A/qQnugEqS7pbfYY9Gy6YqGH/eApYYOd3Bv11XW4OifWLfRsqlqg8HJkccjz7rQqX+
 yB0BmvopYVveDzTTWQXUdhWFrMtXrjn0AImN8U8ht7hpBdDxeLqqXuCEm2c18EmUAGW8
 1eOxIqs91TijnmPj5IuS+2SqhJz+X2GCK79ICir+vw0PnpmzJAXdq8BejOVhZkdbgIad
 hK/cN98OZjMFJoUcAZhZss3keRq3Qhj+a+Y02+JcxUIg5xnGsjh135ipcbjTQMs8J+uT
 +X5zbKyRNjmhx+m0r/Lywb5WMJ+QatJrapYAU3HqT2zGbwEzxrZYCnjB51Gx6sGs4+vG
 9qUw==
X-Gm-Message-State: AOJu0YyoouI5RfddpEryxE11bDEspHo+6DWhTbxv3NGaVIEjUqu6WYOB
 oX3tkz0nEa5h4bSMJNMpoKfzhvd9AmD2Q8tCQpwT9HFkS2gTzqZnr8dE0F7IUQA1eGPOyIUNIuw
 ZGNdRHfDdue1DbcSkNg4XBK4FoVB7+Z1VR7hl8vaRGT52K5Sg4A81NFCaCy1P5DMdFd3KJngyr7
 D8b8IABF97QOm5lgTu5vH1hITtC+OIhwLpachT47Cr
X-Gm-Gg: ASbGncs7Z7tpfQLdC3dwZ7aF5yG8mL55vi64V86nc1viec2pduKSQHH1tYMSEmv93l/
 g9CJUkF6wdSRuH2jDtyXiPkjKVOMdyj4Hy96JI93COKvohTiDcmfjc4XqWK7DkOvKzQDdK3O3pz
 RUZIU5zp8tt32L++wIXzndgiX3sTjk8VOYtjRoILU8Q9oyugIh8i1yMIu8tLpCvtXJEc/VDUWDx
 K2w0qE4hr0Hy2r/awmpsAzamncH7AozsFHwK9Qeq2Xhb+hJRe2h0oewGgSV9bfl5CT/kzNClEYY
 Z2gUCgtIqM3MqPtmb4W4tz+AxLOCzc8VHBJ7O6T4vWS+hkpbGAVb+edsUXUatUb5D3q5jxvCvxd
 aQvQ659NDs7PUlN2Ik086Agm/TVdsLRuuhESwy/qvBFU=
X-Received: by 2002:a05:6000:1a8b:b0:3c2:d7f0:9c4e with SMTP id
 ffacd0b85a97d-3e75e0fadc1mr7329908f8f.8.1757751013141; 
 Sat, 13 Sep 2025 01:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXC4hRamxAw63vppAtkFxStLfoZeku86uBGbkc/h6C8B0vUuUgXVBrCLzimKy30/EbjBmptA==
X-Received: by 2002:a05:6000:1a8b:b0:3c2:d7f0:9c4e with SMTP id
 ffacd0b85a97d-3e75e0fadc1mr7329882f8f.8.1757751012673; 
 Sat, 13 Sep 2025 01:10:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e01832af1sm50553365e9.3.2025.09.13.01.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 10/61] accel: use atomic accesses for exit_request
Date: Sat, 13 Sep 2025 10:08:51 +0200
Message-ID: <20250913080943.11710-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

CPU threads write exit_request as a "note to self" that they need to
go out to a slow path.  This write happens out of the BQL and can be
a data race with another threads' cpu_exit(); use atomic accesses
consistently.

While at it, change the source argument from int ("1") to bool ("true").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h             | 9 +++++++++
 accel/kvm/kvm-all.c               | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
 accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
 hw/ppc/spapr_hcall.c              | 6 +++---
 target/i386/kvm/kvm.c             | 6 +++---
 target/i386/nvmm/nvmm-accel-ops.c | 2 +-
 target/i386/nvmm/nvmm-all.c       | 2 +-
 target/i386/whpx/whpx-all.c       | 6 +++---
 9 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8b57bcd92c9..338757e5254 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -422,6 +422,15 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @halt_cond: condition variable sleeping threads can wait on.
+ * @exit_request: Another thread requests the CPU to call qemu_wait_io_event().
+ *   Should be read only by CPU thread with load-acquire, to synchronize with
+ *   other threads' store-release operation.
+ *
+ *   In some cases, accelerator-specific code will write exit_request from
+ *   within the same thread, to "bump" the effect of qemu_cpu_kick() to
+ *   the one provided by cpu_exit(), especially when processing interrupt
+ *   flags.  In this case, the write and read happen in the same thread
+ *   and the write therefore can use qemu_atomic_set().
  * @interrupt_request: Indicates a pending interrupt request.
  *   Only used by system emulation.
  * @halted: Nonzero if the CPU is in suspended state.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bd9e5e3886d..e4167d94b4f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3730,7 +3730,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
     have_sigbus_pending = true;
     pending_sigbus_addr = addr;
     pending_sigbus_code = code;
-    qatomic_set(&cpu->exit_request, 1);
+    qatomic_set(&cpu->exit_request, true);
     return 0;
 #else
     return 1;
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 337b993d3da..b12b7a36b5d 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -85,7 +85,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
 
     do {
         if (cpu_can_run(cpu)) {
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index e8b0e370a8d..d13e0d8b44d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -212,7 +212,7 @@ static void *rr_cpu_thread_fn(void *arg)
     cpu = first_cpu;
 
     /* process any pending work */
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
 
     while (1) {
         /* Only used for icount_enabled() */
@@ -293,7 +293,7 @@ static void *rr_cpu_thread_fn(void *arg)
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
-        if (cpu && cpu->exit_request) {
+        if (cpu && qatomic_read(&cpu->exit_request)) {
             qatomic_set_mb(&cpu->exit_request, 0);
         }
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1e936f35e44..51875e32a09 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -509,7 +509,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
-        cs->exit_request = 1;
+        qatomic_set(&cs->exit_request, true);
         ppc_maybe_interrupt(env);
     }
 
@@ -531,7 +531,7 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     }
     cs->halted = 1;
     cs->exception_index = EXCP_HALTED;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, true);
     ppc_maybe_interrupt(&cpu->env);
 
     return H_SUCCESS;
@@ -624,7 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     cs->exception_index = EXCP_YIELD;
-    cs->exit_request = 1;
+    qatomic_set(&cs->exit_request, true);
     cpu_loop_exit(cs);
 
     return H_SUCCESS;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8420c4090ef..34e74f24470 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5486,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
-            qatomic_set(&cpu->exit_request, 1);
+            qatomic_set(&cpu->exit_request, true);
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-            qatomic_set(&cpu->exit_request, 1);
+            qatomic_set(&cpu->exit_request, true);
         }
     }
 
@@ -5604,7 +5604,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         if (env->exception_nr == EXCP08_DBLE) {
             /* this means triple fault */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-            cs->exit_request = 1;
+            qatomic_set(&cs->exit_request, true);
             return 0;
         }
         kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 3799260bbde..86869f133e9 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -77,7 +77,7 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
  */
 static void nvmm_kick_vcpu_thread(CPUState *cpu)
 {
-    cpu->exit_request = 1;
+    qatomic_set(&cpu->exit_request, true);
     cpus_kick_thread(cpu);
 }
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 10bd51d9b59..7e36c42fbb4 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -414,7 +414,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
      * or commit pending TPR access.
      */
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, true);
     }
 
     if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2106c29c3a0..00fb7e23100 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1489,10 +1489,10 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, true);
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
-            cpu->exit_request = 1;
+            qatomic_set(&cpu->exit_request, true);
         }
     }
 
@@ -1539,7 +1539,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
-        cpu->exit_request = 1;
+        qatomic_set(&cpu->exit_request, true);
         reg_names[reg_count] = WHvX64RegisterCr8;
         reg_count += 1;
     }
-- 
2.51.0


