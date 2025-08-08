Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FABC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJD-0006Cf-9z; Fri, 08 Aug 2025 14:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJA-0006C6-Ub
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJ9-0006fX-6T
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKBBDyOhm3KB0EsnURIQG+Cs3th/O37nyJmS8J3TRyU=;
 b=Ky89HJTz4RxlneOpJoKMztUK+MdLkmzJvocPPu0v03ig2UvfpCVndRBqQOums76cG/GU8v
 BlB7S7eZPj6enKbONrxLUQkWCcppaqNUbrZiO3pQqKKhS5fFixccRTHNUbINEzHobIS617
 3EQRh5wczY5JvIzgJo+CDDxScuKCgGc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-2TJqDGNgMoixtesoVMjI9A-1; Fri, 08 Aug 2025 14:59:13 -0400
X-MC-Unique: 2TJqDGNgMoixtesoVMjI9A-1
X-Mimecast-MFC-AGG-ID: 2TJqDGNgMoixtesoVMjI9A_1754679552
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b793f76a46so1652398f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679551; x=1755284351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKBBDyOhm3KB0EsnURIQG+Cs3th/O37nyJmS8J3TRyU=;
 b=jM+ZvOGqH11zhZGnE7LFc9r1DuOjBRG/1sOuSkaEOCYys8LqzXmZQMakGITAsWR8MG
 8CH8Oh6E6THWy1eaolLkbz8Sd5ji/4CZkyW82oJszuu3JLL++l+AWaEKdjEFoLqpl6S5
 JDgIkWv6UB3pA5m6tiWTY12u/1JldsCu+8R95Q8AdSd/NNaa+nQS62IcXjG4fUMouya5
 2/P1mW1UJc7gXJQSBnH6Y1bo3OE4zkFU8/oriyimER+33vcEx0jlK4y0qziFWe6azzml
 IC2mrtsdo7HPfjQ/FzfAvlIOqP97ZKAduA9RApAfNNKhfOigp4cMlpUTm/ILI1KM/Ajk
 jp/A==
X-Gm-Message-State: AOJu0YwPXLfYfg4DyRKTyKNKOEMmm5TKRC0bOesH5Q+ID893wc4WSS3u
 l3xprxlbRgJnsMAdNSjgu/s3FAbxFbwIPIi9n69B3aQADEdH5vRrbR88cc7pF5htSm2gp4zriLv
 8XGy39eZTWnZfuvKMhscKpIrQZSeYz4d+Kw8XguV4TWIU1cP9rDjRl7A3MVXp98MUpMqAyGQldX
 aT+/uMyUq07Bz5urdFz0cIW+UDV+2JomFfZnCHgWkL
X-Gm-Gg: ASbGnctcE3iBm3tNoK48jdRjhS4xg+wCg8nhZUnBKNJJrv6VsU6s9bzoJaFPdyg6JSI
 /lnRw8z+T0qJe1jQhouXAWaRnvLBKDoq0DReXYl49jkeF2icJEZMIaGMjARyB06bjtBrS78+VuA
 36pWUVAPhMfRNudf4X95VBcOwJCGf4vkqXUl6lYDzqtqu9D5IBCFqqlTdhP0kYh8lM16VV3xBTJ
 TW6Y95S1uZf9y005hwmpkdLFjEvSdpapU7z6OV1TvmikiubQEfKbTJiI5tbwN0M3mnPh5asNMD1
 6dfcfGMD8JKBbUMlYOf2ANzPWf4GIhxABrUNoKQJqLmU
X-Received: by 2002:a05:6000:4382:b0:3b8:f863:672c with SMTP id
 ffacd0b85a97d-3b900b7af6amr3729168f8f.33.1754679550822; 
 Fri, 08 Aug 2025 11:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7NUjpOHQx3OSeNP9ENS9vtmkk/K7diUejXGwPcUJxdwJK5fbuDPzGf2XY2kVDBe5teeaeA==
X-Received: by 2002:a05:6000:4382:b0:3b8:f863:672c with SMTP id
 ffacd0b85a97d-3b900b7af6amr3729143f8f.33.1754679550205; 
 Fri, 08 Aug 2025 11:59:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm21594609f8f.31.2025.08.08.11.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 1/8] accel: use store_release/load_acquire for cross-thread
 exit_request
Date: Fri,  8 Aug 2025 20:58:58 +0200
Message-ID: <20250808185905.62776-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
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

cpu->exit_request do not use a load-acquire/store-release pair right now,
but this means that cpu_exit() does not store it after any flags that are
read in the slow path.

Probably everything is protected one way or the other by the BQL, because
after reading cpu->exit_request the CPU thread often goes to sleep
(by waiting on the BQL-protected cpu->halt_cond), but it's not clear.
Use load-acquire/store-release consistently.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 19 +++++++++----------
 accel/tcg/cpu-exec.c         |  7 +++++--
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 hw/core/cpu-common.c         |  3 ++-
 target/i386/nvmm/nvmm-all.c  |  5 ++---
 target/i386/whpx/whpx-all.c  |  3 ++-
 6 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f86..57e35960125 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3029,10 +3029,6 @@ static void kvm_eat_signals(CPUState *cpu)
 
     if (kvm_immediate_exit) {
         qatomic_set(&cpu->kvm_run->immediate_exit, 0);
-        /* Write kvm_run->immediate_exit before the cpu->exit_request
-         * write in kvm_cpu_exec.
-         */
-        smp_wmb();
         return;
     }
 
@@ -3187,7 +3183,8 @@ int kvm_cpu_exec(CPUState *cpu)
         }
 
         kvm_arch_pre_run(cpu, run);
-        if (qatomic_read(&cpu->exit_request)) {
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
             trace_kvm_interrupt_exit_request();
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
@@ -3197,13 +3194,15 @@ int kvm_cpu_exec(CPUState *cpu)
             kvm_cpu_kick_self();
         }
 
-        /* Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
-         * Matching barrier in kvm_eat_signals.
-         */
-        smp_rmb();
-
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
 
+        /*
+         * After writing cpu->exit_request, cpu_exit() sends a signal that writes
+         * kvm->run->immediate_exit.  The signal is always happening after the
+         * write to cpu->exit_request so, if KVM read kvm->run->immediate_exit
+         * as true, cpu->exit_request will always read as true.
+         */
+
         attrs = kvm_arch_post_run(cpu, run);
 
 #ifdef KVM_HAVE_MCE_INJECTION
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 82867f456c1..4bd9ee01c19 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -849,8 +849,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         bql_unlock();
     }
 
-    /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
+    /*
+     * Finally, check if we need to exit to the main loop.
+     * The corresponding store-release is in cpu_exit.
+     */
+    if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..1e551e92d6d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -242,7 +242,7 @@ static void *rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+        while (cpu && cpu_work_list_empty(cpu) && !qatomic_load_acquire(&cpu->exit_request)) {
             /* Store rr_current_cpu before evaluating cpu_can_run().  */
             qatomic_set_mb(&rr_current_cpu, cpu);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca21..f189ce861c9 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -84,7 +84,8 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
 
 void cpu_exit(CPUState *cpu)
 {
-    qatomic_set(&cpu->exit_request, 1);
+    /* Ensure cpu_exec will see the reason why the exit request was set.  */
+    qatomic_store_release(&cpu->exit_request, 1);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
     qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index c1ac74c4f04..a5e3485c1f8 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -743,7 +743,8 @@ nvmm_vcpu_loop(CPUState *cpu)
 
         nvmm_vcpu_pre_run(cpu);
 
-        if (qatomic_read(&cpu->exit_request)) {
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
 #if NVMM_USER_VERSION >= 2
             nvmm_vcpu_stop(vcpu);
 #else
@@ -751,8 +752,6 @@ nvmm_vcpu_loop(CPUState *cpu)
 #endif
         }
 
-        /* Read exit_request before the kernel reads the immediate exit flag */
-        smp_rmb();
         ret = nvmm_vcpu_run(mach, vcpu);
         if (ret == -1) {
             error_report("NVMM: Failed to exec a virtual processor,"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 878cdd1668c..9f88e368d4d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1714,7 +1714,8 @@ static int whpx_vcpu_run(CPUState *cpu)
         if (exclusive_step_mode == WHPX_STEP_NONE) {
             whpx_vcpu_pre_run(cpu);
 
-            if (qatomic_read(&cpu->exit_request)) {
+            /* Corresponding store-release is in cpu_exit. */
+            if (qatomic_load_acquire(&cpu->exit_request)) {
                 whpx_vcpu_kick(cpu);
             }
         }
-- 
2.50.1


