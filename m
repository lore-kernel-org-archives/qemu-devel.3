Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC2FCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLL5-0005pj-8I; Sat, 13 Sep 2025 04:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLL4-0005pG-1e
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLL1-0004v4-Ue
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1MoLYhidqPz8BBKnWQatNMR5EUdXV0h1XydX4W6PIs=;
 b=Xf5WeBZZZ+NL3IFGv1e9hlLKp2S8xXfC8eIep5QBvi8FW5vGoxJ5DofROlVDea+iOXcM6+
 xDpTI8BqLWaBvnPSqP5PXhH22CHPEvjeoMf7UdSJZ8nmRnKhaS255FqT9qFnTFMeM6RSds
 gAYg5KdSXqydR0TLMXf39NivWd05pwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-LmVu5uJfOtqqrnNFhYmadg-1; Sat, 13 Sep 2025 04:10:25 -0400
X-MC-Unique: LmVu5uJfOtqqrnNFhYmadg-1
X-Mimecast-MFC-AGG-ID: LmVu5uJfOtqqrnNFhYmadg_1757751025
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e26b5e3f41so1289269f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751024; x=1758355824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1MoLYhidqPz8BBKnWQatNMR5EUdXV0h1XydX4W6PIs=;
 b=YEQ3P2oJ4gjqBaHzSrnKJOxjAY9GgHXudNuD2WNdVZQChgk+IqpBmKZtm3TErgxWfa
 S73wA6jx3ld8wUxv+TMyo65umZvxMV8T7gT82ctj+h14+eZ20BzLKQ5KSanR6AiJCDD/
 vJA8oS01ag6g9veJgnBjK1xDu5Nh4I0OUtYC+99JsCt68Y6ryJCW4XQ0QOLaZwZ3DYdD
 JQ6V5rg0TLVSzVQB/pcFQPN+n9ZBHnD6sLS59KnQr2O/JIjSzGEBgu/EHHPuTi1Se60k
 si9MuiXUDSrlK721au6dtoVWJpJRcpuJfyUCfWMqIXwJfAEb4Ga5kYexL1Blel3tToK8
 WYsg==
X-Gm-Message-State: AOJu0Yw+5B9XjorohsjVgwgTidLHKw2QetX+KuFQRkYTBkSMrQiIBTmX
 dsZwq77V0nGQghn/hjwHPp+rVpMcWOzhJ2APbcgmKqYq15JEfPUXzuaeH92ikXlXjA4CX241Nyh
 UmyCafq7XjNgTD/12vSsP7PadgPbGkqt5jDyDPdJkfu6TicQXTTyVjUQfJESVawgHVWyWo/NMVE
 f3OqKhsO0Rk3GGHs1uAqnjgUyIN4lnH1pQgh8hzPTN
X-Gm-Gg: ASbGncvmjDVq2Rfl0c5VR3l+YddNimZc00rZC4NTZticw3l/ruHU3Qrx9pxgI5tkigw
 X67xYJGltpqSXsVWM0CoFz9Wfp9pbiNHoQMNdTIVNM8x2IXyMUpu4rdOctiAyChYZovkATYXco5
 Nz/glLhLVnXm84ox+21izgz6jLNZlahcNY3nXFqJsCKobWMTTCx/V5fTV/GCkgkRP77arA1GwE8
 5udhSoQS/1zHneWKEkb5eBLa6DiwdXzjFUydL/mcPYEdEF+bI2VOmg5WQCiQtMI4w/xokTg45Wn
 Lg2OQE29UP/DAkGD1Sh+24a5BT5h6eep5py3TYi5m30eqDNU6sM1NyI+Jjy7UfuKyxVKxqI3DUw
 y7bBqlfAZitf0U4LZZAvaNpyGzE5Fj5SU0Sina7IZyO8=
X-Received: by 2002:a05:6000:230c:b0:3e7:41bf:e5f2 with SMTP id
 ffacd0b85a97d-3e76578240amr6152383f8f.15.1757751024113; 
 Sat, 13 Sep 2025 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5jVnKifYFbc1+yC1k8rKk62hDNy4womPMudFMg+0N0OGemAw/o69LFQCGQdQN5C1mtLAm+g==
X-Received: by 2002:a05:6000:230c:b0:3e7:41bf:e5f2 with SMTP id
 ffacd0b85a97d-3e76578240amr6152336f8f.15.1757751023623; 
 Sat, 13 Sep 2025 01:10:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607cd691sm9654459f8f.32.2025.09.13.01.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/61] cpus: properly kick CPUs out of inner execution loop
Date: Sat, 13 Sep 2025 10:08:55 +0200
Message-ID: <20250913080943.11710-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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

Now that cpu_exit() actually kicks all accelerators, use it whenever
the message to another thread is processed in qemu_wait_io_event().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-common.c                | 3 ++-
 hw/ppc/ppc.c                | 2 ++
 hw/ppc/spapr_hcall.c        | 7 +++----
 hw/ppc/spapr_rtas.c         | 2 +-
 replay/replay-events.c      | 3 ++-
 system/cpu-timers.c         | 6 +++---
 system/cpus.c               | 5 +++--
 target/arm/tcg/mte_helper.c | 2 +-
 target/i386/kvm/hyperv.c    | 1 -
 9 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index ef5757d23bf..152661df8e9 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -137,7 +137,8 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     wi->done = false;
     qemu_mutex_unlock(&cpu->work_mutex);
 
-    qemu_cpu_kick(cpu);
+    /* exit the inner loop and reach qemu_wait_io_event_common().  */
+    cpu_exit(cpu);
 }
 
 void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 43d0d0e7553..3e436c70413 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -190,6 +190,7 @@ static void ppc970_set_irq(void *opaque, int pin, int level)
             if (level) {
                 trace_ppc_irq_cpu("stop");
                 cs->halted = 1;
+                cpu_exit(cs);
             } else {
                 trace_ppc_irq_cpu("restart");
                 cs->halted = 0;
@@ -386,6 +387,7 @@ static void ppc40x_set_irq(void *opaque, int pin, int level)
             if (level) {
                 trace_ppc_irq_cpu("stop");
                 cs->halted = 1;
+                cpu_exit(cs);
             } else {
                 trace_ppc_irq_cpu("restart");
                 cs->halted = 0;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 51875e32a09..c594d4b916e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -509,8 +509,8 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
-        qatomic_set(&cs->exit_request, true);
         ppc_maybe_interrupt(env);
+        cpu_exit(cs);
     }
 
     return H_SUCCESS;
@@ -531,8 +531,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     }
     cs->halted = 1;
     cs->exception_index = EXCP_HALTED;
-    qatomic_set(&cs->exit_request, true);
     ppc_maybe_interrupt(&cpu->env);
+    cpu_exit(cs);
 
     return H_SUCCESS;
 }
@@ -624,8 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     cs->exception_index = EXCP_YIELD;
-    qatomic_set(&cs->exit_request, true);
-    cpu_loop_exit(cs);
+    cpu_exit(cs);
 
     return H_SUCCESS;
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 78309dbb09d..143bc8c3794 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -221,7 +221,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
     cs->halted = 1;
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     kvmppc_set_reg_ppc_online(cpu, 0);
-    qemu_cpu_kick(cs);
+    cpu_exit(cs);
 }
 
 static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spapr,
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 8959da9f1fa..a96e47e7740 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -118,7 +118,8 @@ void replay_add_event(ReplayAsyncEventKind event_kind,
 
     g_assert(replay_mutex_locked());
     QTAILQ_INSERT_TAIL(&events_list, event, events);
-    qemu_cpu_kick(first_cpu);
+    /* Kick the TCG thread out of tcg_cpu_exec().  */
+    cpu_exit(first_cpu);
 }
 
 void replay_bh_schedule_event(QEMUBH *bh)
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index cb35fa62b8a..9919b46230f 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -246,14 +246,14 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 
     if (qemu_in_vcpu_thread()) {
         /*
-         * A CPU is currently running; kick it back out to the
+         * A CPU is currently running; send it out of the
          * tcg_cpu_exec() loop so it will recalculate its
          * icount deadline immediately.
          */
-        qemu_cpu_kick(current_cpu);
+        cpu_exit(current_cpu);
     } else if (first_cpu) {
         /*
-         * qemu_cpu_kick is not enough to kick a halted CPU out of
+         * cpu_exit() is not enough to kick a halted CPU out of
          * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
          * causes cpu_thread_is_idle to return false.  This way,
          * handle_icount_deadline can run.
diff --git a/system/cpus.c b/system/cpus.c
index 9bfbe2b0607..bb13942cbb7 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -604,7 +604,7 @@ void cpu_pause(CPUState *cpu)
         qemu_cpu_stop(cpu, true);
     } else {
         cpu->stop = true;
-        qemu_cpu_kick(cpu);
+        cpu_exit(cpu);
     }
 }
 
@@ -644,6 +644,7 @@ void pause_all_vcpus(void)
 
     while (!all_vcpus_paused()) {
         qemu_cond_wait(&qemu_pause_cond, &bql);
+        /* FIXME: is this needed? */
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
@@ -672,7 +673,7 @@ void cpu_remove_sync(CPUState *cpu)
 {
     cpu->stop = true;
     cpu->unplug = true;
-    qemu_cpu_kick(cpu);
+    cpu_exit(cpu);
     bql_unlock();
     qemu_thread_join(cpu->thread);
     bql_lock();
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0efc18a181e..302e899287c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -591,7 +591,7 @@ static void mte_async_check_fail(CPUARMState *env, uint64_t dirty_ptr,
      * which is rather sooner than "normal".  But the alternative
      * is waiting until the next syscall.
      */
-    qemu_cpu_kick(env_cpu(env));
+    cpu_exit(env_cpu(env));
 #endif
 }
 
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 9865120cc43..f7a81bd2700 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -81,7 +81,6 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          * necessary because memory hierarchy is being changed
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
-        cpu_exit(CPU(cpu));
 
         return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
-- 
2.51.0


