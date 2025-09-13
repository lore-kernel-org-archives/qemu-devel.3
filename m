Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CECAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLE-0005si-PR; Sat, 13 Sep 2025 04:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLD-0005sM-7q
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLA-0004xp-Io
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlij/+xB1jeZ/DQJ1zSRVc1BKfDXu58VvWt1lqi6rrQ=;
 b=H9a8Cnn8OpaDSmt9OLLQaBLwAzAAXt6v1lg5HncBcwe7YoohpCOxrXHJI8+qv3LJjneIM5
 5XKtoCRCDl02sFLCWlkBM3Cde2sPO66zPkYn6ZzEaizw4A/o3XLkOHihxdTxpMuGF5pK7G
 j9sYMLcpVFFZA7ifmE6auKaQuVGN2PY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Rj42i-a8MxGcrB9HFP8sCQ-1; Sat, 13 Sep 2025 04:10:34 -0400
X-MC-Unique: Rj42i-a8MxGcrB9HFP8sCQ-1
X-Mimecast-MFC-AGG-ID: Rj42i-a8MxGcrB9HFP8sCQ_1757751033
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e7622483f6so1785617f8f.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751032; x=1758355832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlij/+xB1jeZ/DQJ1zSRVc1BKfDXu58VvWt1lqi6rrQ=;
 b=ZBMvBIzLrB3OsvHW5pjD1NchpdQTZjqp6mSUhBBSjtESOJl/z5TYu0hg29YIvDww/z
 nvwidKnjR13oCJEaALAn2EXSoV41+f3WnVGC84sjR4iJLQSSeWYrnQuXkv3/osIrZ9cK
 U9SD4UAJngmoOlBKGCK0bMqxD7a4YYdjDPuqggHeztHDA+mdkfPN+QgF40O3tIa3Plwe
 wuKgRa/lSv/ALPgLbX8SnvhqlhQ6KYM+sKnS1LqFBu/P9csiENe+tC/HXXQIWQdLoiPH
 Q6QEQkIMzzGfdWFZUXtfM7usG545Wk0I3AtTtAS3XCAHZ9fHHw8rEOufps0zrFpGV30E
 5yZQ==
X-Gm-Message-State: AOJu0YwLaadzf+iXkGRPm7lBsTqJvexAc62NhrrMbq4i8xTkrOx6n8XO
 OLAZVSg57lQnkLNgl3ZawpwK0ii3ZzTjz0+lVJQTnIf4vbJvYLxbD9FTmPD1jovYEcVW7ddlApI
 bdUeq17PFWfD1MAkfFO56gmgGeVFMkMsC0CqxcwkKg/F65x/lS0Q/kVOKLGfW/ZU1JOMqAdOSR4
 Dss0VOCEdW3T2906ieBksWAWMZZgVmUEyHJIYC5u3D
X-Gm-Gg: ASbGncuI/ahM4NeETtUxeo/6dAZKYNq7dDRObRz++MbcD0N9RX2E1sOHDiyvnICcjrJ
 hH5MZMqcLEtwr/3g1dd0X7/5Yl7xrGzoI384BVgAJRdznTphVIFXA4trLxn1yWwoeR7ZWDOz71p
 ODqtEpN+Z7UuJ8eA1sBvGbI4bvQXOgZ2rm5hGKGTB95jYL7rx8/5G14EW5J+MixiFLCxs9hYxbD
 ElhwC6C8vne6ldiRlUzkYwm0ptn8mEjb/3+h4Zqt1j5wIyOVa2f0Y7vLvzQ+JVwYBgMT3kxnfA6
 r/wQCAlHAE9PrEr6v5Gw/KZYu2KWnoshxpJs2gvCqlZNb10o25H0X6IaR7CF7XM6fhlV2vDz0Z/
 TwEEP1Y7daLkFnTj1Ey6aHX7XwvQCsJwnuaiUSiPTaKQ=
X-Received: by 2002:a05:6000:208a:b0:3e7:48ab:7660 with SMTP id
 ffacd0b85a97d-3e7659e1746mr5571278f8f.27.1757751032090; 
 Sat, 13 Sep 2025 01:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs0A6G9erfdifU1kcjBAd7hvo2ey9GUIl1kJph9U2xkO5r0vraXtaRBeFm8qIhQ0iTdhsX+g==
X-Received: by 2002:a05:6000:208a:b0:3e7:48ab:7660 with SMTP id
 ffacd0b85a97d-3e7659e1746mr5571245f8f.27.1757751031550; 
 Sat, 13 Sep 2025 01:10:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760776bb8sm9684681f8f.3.2025.09.13.01.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/61] cpus: clear exit_request in qemu_process_cpu_events
Date: Sat, 13 Sep 2025 10:08:58 +0200
Message-ID: <20250913080943.11710-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Make the code common to all accelerators: after seeing cpu->exit_request
set to true, accelerator code needs to reach qemu_process_cpu_events_common().

So for the common cases where they use qemu_process_cpu_events(), go ahead and
clear it in there.  Note that the cheap qatomic_set() is enough because
at this point the thread has taken the BQL; qatomic_set_mb() is not needed.
In particular, this is the ordering of the communication between
I/O and vCPU threads is always the same.

In the I/O thread:

(a) store other memory locations that will be checked if cpu->exit_request
    or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
    for cpu->exit_request)

(b) cpu_exit(): store-release cpu->exit_request, or
(b) cpu_interrupt(): store-release cpu->interrupt_request

>>> at this point, cpu->halt_cond is broadcast and the BQL released

(c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
    pthread_kill for KVM, etc.)

In the vCPU thread instead the opposite order is respected:

(c) the accelerator's execution loop exits thanks to the kick

(b) then the inner execution loop checks cpu->interrupt_request
    and cpu->exit_request.  If needed cpu->interrupt_request is
    converted into cpu->exit_request when work is needed outside
    the execution loop.

(a) then the other memory locations are checked.  Some may need to
    be read under the BQL, but the vCPU thread may also take other
    locks (e.g. for queued work items) or none at all.

qatomic_set_mb() would only be needed if the halt sleep was done
outside the BQL (though in that case, cpu->exit_request probably
would be replaced by a QemuEvent or something like that).

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 2 --
 accel/tcg/cpu-exec.c         | 1 -
 accel/tcg/tcg-accel-ops-rr.c | 9 +++++++--
 accel/tcg/tcg-accel-ops.c    | 2 --
 accel/tcg/user-exec.c        | 1 +
 system/cpus.c                | 1 +
 target/i386/nvmm/nvmm-all.c  | 2 --
 target/i386/whpx/whpx-all.c  | 2 --
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e4167d94b4f..d13156bee87 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3155,7 +3155,6 @@ int kvm_cpu_exec(CPUState *cpu)
     trace_kvm_cpu_exec();
 
     if (kvm_arch_process_async_events(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         return EXCP_HLT;
     }
 
@@ -3345,7 +3344,6 @@ int kvm_cpu_exec(CPUState *cpu)
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    qatomic_set(&cpu->exit_request, 0);
     return ret;
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3ae545e888f..ad94f96b252 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -872,7 +872,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * The corresponding store-release is in cpu_exit.
      */
     if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
         }
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 813b313859a..7dbdba7b514 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -293,8 +293,13 @@ static void *rr_cpu_thread_fn(void *arg)
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
-        if (cpu && qatomic_read(&cpu->exit_request)) {
-            qatomic_set_mb(&cpu->exit_request, 0);
+        if (cpu) {
+            /*
+             * This could even reset exit_request for all CPUs, but in practice
+             * races between CPU exits and changes to "cpu" are so rare that
+             * there's no advantage in doing so.
+             */
+            qatomic_set(&cpu->exit_request, false);
         }
 
         if (icount_enabled() && all_cpu_threads_idle()) {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1f662a9c745..3bd98005042 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -82,8 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
 
-    qatomic_set_mb(&cpu->exit_request, 0);
-
     return ret;
 }
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 65f5da6c506..916f18754f6 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -54,6 +54,7 @@ void qemu_cpu_kick(CPUState *cpu)
 
 void qemu_process_cpu_events(CPUState *cpu)
 {
+    qatomic_set(&cpu->exit_request, false);
     process_queued_cpu_work(cpu);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index fd804e07327..aa7bfcf56e5 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -463,6 +463,7 @@ void qemu_process_cpu_events(CPUState *cpu)
 {
     bool slept = false;
 
+    qatomic_set(&cpu->exit_request, false);
     while (cpu_thread_is_idle(cpu)) {
         if (!slept) {
             slept = true;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 7e36c42fbb4..ed424251673 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -817,8 +817,6 @@ nvmm_vcpu_loop(CPUState *cpu)
     cpu_exec_end(cpu);
     bql_lock();
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 00fb7e23100..2a85168ed51 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2050,8 +2050,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         whpx_last_vcpu_stopping(cpu);
     }
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
-- 
2.51.0


