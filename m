Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD942C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHA-0000yp-J0; Tue, 01 Jul 2025 10:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGx-0000HI-0E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGo-0007bo-DE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso2865423f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381256; x=1751986056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpv50l7yaHCoJwYiAxub8xGPwFsrO1DyFzsXKdjPyNw=;
 b=SWlOWGitGpo9rN0a8KjukzF31fjZBcHuk+isaCnHfvW8RrRkPb11TTNdCCo/X1T3IC
 N1NfF5NjBQuxMsENGMbnx1KaPDmEJxWFdfcIIcEiyhVzXFz6jVJFyXA+t5fkeQcVPDNh
 oGjjvMTZpaTCyI6or7R7BzwY4nBHBrGXC0KRtGBfg+u3ZK6fj5FzR2yJTYJI0GPPw7gN
 88x/BvgOT6AaNHHaQ0wx67l0zg3fumXBMmwDpocOVPVpoC7QvVRAKeLhFkBTkBule0Vm
 QGL7smfIaJpt4uPxFF+hxAa8rLVcCgY6sz6KszM+DpwgAqd4krh/8EbLiap+/Jm9CDyK
 12vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381256; x=1751986056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mpv50l7yaHCoJwYiAxub8xGPwFsrO1DyFzsXKdjPyNw=;
 b=pgSX7CLdIUIa73S3aOO+KF4zGieDmCO5wJ6/Ct1hkmRosKx/9EqZPZ35nxItRgmS0Q
 4TJtyQGgmkmYytTdAi7bozXjKghbDhbqp2SpnJfmOc7815fvuIDeL5NftHiMXsaEeeIE
 5TCewVS+jq1C5tDMQ3JmWzIFhj5NWRtCuBiqgufAgJmhhkV5GZWKoxPdkV0yI8kysI4T
 8iHe1UT4Z41c1sb+wMgp38uasbsID3JnsBEy1axr6+9+8vuT3JZHPIICZ4ibjHQXVrxM
 bGjrNcMrjaoOCH2RbIHUPriV335p/yoGVBs29rgdsSijp76vptOaANWL8TSrVZTOpuOV
 ceZg==
X-Gm-Message-State: AOJu0YzR71Z0jIvhFlAykKaJ+89SYiESLHznX7RSpPuJ4z9ptYAiKYCX
 ubJ43hJJxxAhe10+MRlhPk3GKd42geaYXn34Kn04CSGjCYn6oclvonf4Jis58wUCrWe9oikL0TX
 LkPn7
X-Gm-Gg: ASbGncveVaQ9SJBvSjhsoqJHY4sDJWRevxtR4KqBcIH6VtrwfXI+i0gNyVtqnYdIRDD
 zEejMyFn2tg76IbjgJFNhriNGx5PBwX377JMx8wpQec44btkjXHsbyvZNSPnYeh3Hbd3SZAWk+I
 qBu/pALR4xxS6/8sf23PX4alcxVGFxc71E0dNaiZDpbeKFnLeqt1Why/cNJOlMgMeeisK7n9HSn
 yztEJ0iqO0GMTQrdT35o9wLxt+Tuu0LF3uBSQWPz0fOGp3RhqGgIhUnUaGG28h3MgK7AgGwoVy5
 XdetbVyzEuSp8agDNsrT5aUf0MN7tI9yA5vP/bzrd+cnDTuZMQ5fJLYaN9cxpk8UYUyCqx73ljJ
 jB5D6Z2Fn6cPnSq0s1ZUHRVb0nQjIkg24/9g1
X-Google-Smtp-Source: AGHT+IGAimK/bp5oKDNri93ZMnidtGHKW9w6njOxHk3ejsoqgunMlkmBoutNZ0P2bFNBBBktfeI9fg==
X-Received: by 2002:a05:6000:23c4:b0:3a4:f038:af74 with SMTP id
 ffacd0b85a97d-3a8feb70384mr10774562f8f.51.1751381255625; 
 Tue, 01 Jul 2025 07:47:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7518sm13283817f8f.2.2025.07.01.07.47.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 67/68] accel: Have each accelerator implement the
 handle_interrupt() hook
Date: Tue,  1 Jul 2025 16:40:15 +0200
Message-ID: <20250701144017.43487-68-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Better to make the interrupt handler an explicit implementation
rather than depending on some generic handler.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/dummy-cpus.h                |  1 +
 include/system/accel-ops.h        |  1 +
 accel/dummy-cpus.c                |  7 +++++++
 accel/hvf/hvf-accel-ops.c         |  8 ++++++++
 accel/kvm/kvm-accel-ops.c         |  8 ++++++++
 accel/qtest/qtest.c               |  1 +
 accel/xen/xen-all.c               |  1 +
 system/cpus.c                     | 15 ++-------------
 target/i386/nvmm/nvmm-accel-ops.c |  8 ++++++++
 target/i386/whpx/whpx-accel-ops.c |  8 ++++++++
 10 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
index c2f9fee164c..98a1a30f9ca 100644
--- a/accel/dummy-cpus.h
+++ b/accel/dummy-cpus.h
@@ -11,5 +11,6 @@
 
 void dummy_thread_precreate(CPUState *cpu);
 void *dummy_cpu_thread_routine(void *arg);
+void dummy_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
 
 #endif
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 9d2577fe67f..14861eae60c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -70,6 +70,7 @@ struct AccelOpsClass {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
+    /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
 
     void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index f637ab05e32..e9076851c58 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -71,3 +71,10 @@ void dummy_thread_precreate(CPUState *cpu)
     qemu_sem_init(&cpu->sem, 0);
 #endif
 }
+
+void dummy_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d2b3217f145..a9ed93fe8eb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -207,6 +207,13 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void hvf_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
@@ -358,6 +365,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
     ops->exec_vcpu_thread = hvf_vcpu_exec;
     ops->destroy_vcpu_thread = hvf_vcpu_destroy;
+    ops->handle_interrupt = hvf_handle_interrupt;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 21ff3af306f..749c4f244a1 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -68,6 +68,13 @@ static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
     return !kvm_halt_in_kernel();
 }
 
+static void kvm_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
@@ -85,6 +92,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
+    ops->handle_interrupt = kvm_handle_interrupt;
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 9f30098d133..19eea8d8daa 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -68,6 +68,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
+    ops->handle_interrupt = dummy_handle_interrupt;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 5ff72d9532c..6a967a8c63d 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -153,6 +153,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->thread_precreate = dummy_thread_precreate;
     ops->cpu_thread_routine = dummy_cpu_thread_routine;
+    ops->handle_interrupt = dummy_handle_interrupt;
 }
 
 static const TypeInfo xen_accel_ops_type = {
diff --git a/system/cpus.c b/system/cpus.c
index 8c2647f5f19..e217e42ba03 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -246,13 +246,6 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
-{
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     int old_mask = cpu->interrupt_request;
@@ -260,12 +253,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
     g_assert(bql_locked());
 
     cpu->interrupt_request |= mask;
-
-    if (cpus_accel->handle_interrupt) {
-        cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
-    } else {
-        generic_handle_interrupt(cpu, old_mask, cpu->interrupt_request);
-    }
+    cpus_accel->handle_interrupt(cpu, old_mask, cpu->interrupt_request);
 }
 
 /*
@@ -674,6 +662,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
     assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
+    assert(ops->handle_interrupt);
     cpus_accel = ops;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index bef6f61b776..62fc6438c60 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -61,6 +61,13 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void nvmm_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
 /*
  * Abort the call to run the virtual processor by another thread, and to
  * return the control to that thread.
@@ -77,6 +84,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
+    ops->handle_interrupt = nvmm_handle_interrupt;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 8cbc6f4e2d8..e9969ef2cf3 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -61,6 +61,13 @@ static void *whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void whpx_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
 static void whpx_kick_vcpu_thread(CPUState *cpu)
 {
     if (!qemu_cpu_is_self(cpu)) {
@@ -80,6 +87,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
+    ops->handle_interrupt = whpx_handle_interrupt;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
-- 
2.49.0


