Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4619CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLH-0005tT-MV; Sat, 13 Sep 2025 04:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLE-0005sa-Gk
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLC-0004yW-HA
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9LFx7bmrkJaI6Kk2QaXpZhH5Ca/LoygYTM5U9wxaBM=;
 b=f5WM0OKNrj4BW9VPf74CtMLbegVrWIr4I0pvaWH1V9IPou4WjiDyHAq3cQhxy35ASuQBNC
 kr1nkhg3+HxPf0GIKOCBM7J6lfJGghjdr7ZfjUZFJbAT9q1K8U6ZsJiQuEHkVbMANrfSi9
 VRdIZvsx6+C8yirWrXI4xCwNW2Pn9ow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-CHn6vNDOPQWC7-OTEL4ZTw-1; Sat, 13 Sep 2025 04:10:36 -0400
X-MC-Unique: CHn6vNDOPQWC7-OTEL4ZTw-1
X-Mimecast-MFC-AGG-ID: CHn6vNDOPQWC7-OTEL4ZTw_1757751035
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45dd66e1971so23559405e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751034; x=1758355834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9LFx7bmrkJaI6Kk2QaXpZhH5Ca/LoygYTM5U9wxaBM=;
 b=fHDeEBB0AwH3dQh2Jljx8vAtz9RtuhAwttCEchqSTkyuKhJ/Prq4S4L3m72clwj3AL
 RBtVywYPRJBAAfxGgsATVnyB7zvK0vk8KwTd3iWN5qKPKSv6IrBDsw5v+lRb2xAQtndb
 +OlYE8HdZrjBaVc4SDvsq4ElBFKfEwRhlfCowNutwvGSZzQ3dAUOQB+LDdbMgYLxZVCA
 h8HuntGgybVZccHkbtjiSNbLUNjkXupSf7blLM+6Uk8aCeb3pTgHJFCXr4+WPzTDneO8
 I78t5RZi+rG35ZAbycl7dVw89TYCBrCWAFweYvn3jbXPGaWJAe+2FqW4AN91PmPUdTgC
 LT0g==
X-Gm-Message-State: AOJu0Yw/S2FSjIBxiunEelhRSgpbU6Xd3H2NyDWddHlq95i/HnbtaY75
 B+sF0T45wMyjiZWaV6vHdFBPqMM9XUpnPhPTFaoeKmooQBdB+184ppx58+yJZ16YDGGNSUfXYRs
 5d7xtiDGWVNrV01Wqi1j1iSD87OmlEFDyqRw7aBmcgnuHm1jOXwAGKzx8giYdHjgkKeFlOAMIC5
 yZ7QsWCLKckpcV1fXtaupUhH3GPPPJbw38AUHb9Vz8
X-Gm-Gg: ASbGncvoyaT8q2qlzHGI4Et4rw2xFUnobozLwlkvm+RWi1Zehd0i5NeP3uzzvXM5q7K
 +z/6WNhm0hKaR0KjRE8RBWOEQ7WV/zl6FgyKgF8qftIeI1SunX/E6YPs5CIkNtzjpU4u+QD1WIM
 AUC/9rJlIiOXLPp6YScPSVDhLDUCteRDhhmD+F4VlQ4He9+3bnkKMN//zpVsWpZhSwkOBf/1nHc
 vEBH1XoF99A57ebgqhNmbQ0JUDNocKoP/GOa4ZbGYJh3zWlVD25kT0xPB4p7AGWgikWSBAkm9I9
 j4n4iKa7tT/i8hQCzkvcMPFGmOTKlvSiIVJn49yfq0qK7J5gxcWIhtsFwF2/TJlF6qNqOGAWOUz
 T8FRNNaZxdiLJDgxhtObyzF0+1i5GSytpfg0+0572S1E=
X-Received: by 2002:a05:600c:4453:b0:45d:e6b6:55fe with SMTP id
 5b1f17b1804b1-45f2120955fmr47073395e9.34.1757751034454; 
 Sat, 13 Sep 2025 01:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmT50FAY19tzEwnUvi0NX5UzwtuBrS5Ph1Xwo7hY+/6ulw179xLwpr0AtHSwb5PTr5xp9zjA==
X-Received: by 2002:a05:600c:4453:b0:45d:e6b6:55fe with SMTP id
 5b1f17b1804b1-45f2120955fmr47073185e9.34.1757751033870; 
 Sat, 13 Sep 2025 01:10:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8237cfdddsm2678806f8f.60.2025.09.13.01.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/61] accel: make all calls to qemu_process_cpu_events look
 the same
Date: Sat, 13 Sep 2025 10:08:59 +0200
Message-ID: <20250913080943.11710-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There is no reason for some accelerators to use qemu_process_cpu_events_common
(which is separated from qemu_process_cpu_events() specifically for round
robin TCG).  They can also check for events directly on the first pass through
the loop, instead of setting cpu->exit_request to true.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/dummy-cpus.c                |  2 +-
 accel/hvf/hvf-accel-ops.c         |  2 +-
 accel/kvm/kvm-accel-ops.c         |  3 ++-
 accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
 accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
 target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
 target/i386/whpx/whpx-accel-ops.c |  6 ++---
 7 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 225a47c31fd..5752f6302c8 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -43,6 +43,7 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_process_cpu_events(cpu);
         bql_unlock();
 #ifndef _WIN32
         do {
@@ -57,7 +58,6 @@ static void *dummy_cpu_thread_fn(void *arg)
         qemu_sem_wait(&cpu->sem);
 #endif
         bql_lock();
-        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug);
 
     bql_unlock();
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 7a27bdadb4f..8b794c2d418 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -192,13 +192,13 @@ static void *hvf_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
             r = hvf_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 65a7f76a69a..8ed6945c2f7 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -47,13 +47,14 @@ static void *kvm_vcpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_process_cpu_events(cpu);
+
         if (cpu_can_run(cpu)) {
             r = kvm_cpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     kvm_destroy_vcpu(cpu);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 342917c5f6e..cf1ee7ac258 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -84,10 +84,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, true);
-
     do {
+        qemu_process_cpu_events(cpu);
+
         if (cpu_can_run(cpu)) {
             int r;
             bql_unlock();
@@ -112,8 +111,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
                 break;
             }
         }
-
-        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     tcg_cpu_destroy(cpu);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 7dbdba7b514..2fb46439971 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -211,13 +211,30 @@ static void *rr_cpu_thread_fn(void *arg)
 
     cpu = first_cpu;
 
-    /* process any pending work */
-    qatomic_set(&cpu->exit_request, true);
-
     while (1) {
         /* Only used for icount_enabled() */
         int64_t cpu_budget = 0;
 
+        if (cpu) {
+            /*
+             * This could even reset exit_request for all CPUs, but in practice
+             * races between CPU exits and changes to "cpu" are so rare that
+             * there's no advantage in doing so.
+             */
+            qatomic_set(&cpu->exit_request, false);
+        }
+
+        if (icount_enabled() && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
+             * in the main_loop, wake it up in order to start the warp timer.
+             */
+            qemu_notify_event();
+        }
+
+        rr_wait_io_event();
+        rr_deal_with_unplugged_cpus();
+
         bql_unlock();
         replay_mutex_lock();
         bql_lock();
@@ -292,26 +309,6 @@ static void *rr_cpu_thread_fn(void *arg)
 
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
-
-        if (cpu) {
-            /*
-             * This could even reset exit_request for all CPUs, but in practice
-             * races between CPU exits and changes to "cpu" are so rare that
-             * there's no advantage in doing so.
-             */
-            qatomic_set(&cpu->exit_request, false);
-        }
-
-        if (icount_enabled() && all_cpu_threads_idle()) {
-            /*
-             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
-             * in the main_loop, wake it up in order to start the warp timer.
-             */
-            qemu_notify_event();
-        }
-
-        rr_wait_io_event();
-        rr_deal_with_unplugged_cpus();
     }
 
     g_assert_not_reached();
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index d066364b989..dd5d5428b1c 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -42,16 +42,14 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_process_cpu_events(cpu);
+
         if (cpu_can_run(cpu)) {
             r = nvmm_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait_bql(cpu->halt_cond);
-        }
-        qemu_process_cpu_events_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     nvmm_destroy_vcpu(cpu);
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 2ca4ee02636..f75886128d0 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -42,16 +42,14 @@ static void *whpx_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
+        qemu_process_cpu_events(cpu);
+
         if (cpu_can_run(cpu)) {
             r = whpx_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait_bql(cpu->halt_cond);
-        }
-        qemu_process_cpu_events_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     whpx_destroy_vcpu(cpu);
-- 
2.51.0


