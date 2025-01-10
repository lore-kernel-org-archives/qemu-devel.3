Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2CFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2t-0000il-PJ; Fri, 10 Jan 2025 13:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2O-0000HS-CB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2M-00019u-5R
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PzOKGHTdjqT/fLNp0Y32SFtMZUofMI3zc+qmo4xiFc=;
 b=YRA67H0TPi1ST4vsCp2EPL1cHA7+FFjxFAnPOKgttMmmDeGhaphoW8D9VMAla7nqWoZo4L
 a5852W4YcnhkacYdd7IbmGrRGdxk5wPQ11PBFBnrDDpy7cmee7pbdwipv7J3HapIzrFyba
 X1yCIwSj89IPPcheXc7Lkw+t/aJUa58=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-HnZTJNAPORq9GBivPgjqPA-1; Fri, 10 Jan 2025 13:47:10 -0500
X-MC-Unique: HnZTJNAPORq9GBivPgjqPA-1
X-Mimecast-MFC-AGG-ID: HnZTJNAPORq9GBivPgjqPA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d90b88322aso2681036a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534828; x=1737139628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PzOKGHTdjqT/fLNp0Y32SFtMZUofMI3zc+qmo4xiFc=;
 b=MwkuN3HRdYOPIj2Cv7BTzCl7AAxYkJFFxNXdg+GHJ1Ff2cqdohskSwzXFJhCHmx9Xg
 nmE1hcunh8HdtqpxLThibRXhXyXhhjUHGB0X9fQbbbT4y7niLzSiVWH6xyyyQ6lC+k7/
 mXLF+sRMME9zqiJnzIB5tU7G5VS6592wCJjF5QvDXDd5yNnMGhsAEBi4OlRmElifn1Iv
 O136kZYSSo/qvcJriskTG8NU8zRZcRtJfmQSPDIcefGWqDOGs/FI5SHoa1SQZGP3ByLP
 RqS3O48AhmqNBsKi3oLwMgccZvgV9OWPGWNl5zWlufWHP0wwGrt66uYIRMI0PFdMGOBG
 CtJA==
X-Gm-Message-State: AOJu0YxaBafWEnr24Vn9iZRDBv/nIM3dbrliRrANWgAtZlkarq7Pipzf
 WuyzCQel8B9Hh6wa1R970YC7apb7zgzK20ahwYHZIZOL8I7UPe/+DNs9J4qjkP/2uMur9byXgyF
 yBE5Yz5Y562luKb96E0q86Vr7S9rTbep33owzcl0RE7G8/KrjrWVcx4DTB0P0N+f0yTGyIjEUiS
 2Wi2/6DOye16660cQyx3jfuB77hvbc91kY+3bmik4=
X-Gm-Gg: ASbGncuxplwbByRzUiXV9vi03bCLp3aFI0NRH7BYKpcMEp7myVhpUIm2UwU82PIG5MX
 Xsm+fVowbl/qzoMGPVaCWC8O01dUyb2+E5+Gjy0PZYI9ZUMI6QOvW0McqlLCnIwzStCvDSDG1Eo
 N961jjZN435eFhlx+3FfxG0sS4fmq+cqK06kcQ/xAq8Huch9Q2Kq8xJV1CyP5EUS6qlKAgy3+81
 /5shFYc09xSpM9y6TJ1rhXeSktBYCTSrISogUxDkZGdaLKfyAUPpyBokQ8=
X-Received: by 2002:a05:6402:274d:b0:5cf:420a:9 with SMTP id
 4fb4d7f45d1cf-5d972dfb8bamr10380524a12.5.1736534827946; 
 Fri, 10 Jan 2025 10:47:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHt1zOfjWnlkKsG7HnWG4EE1yHppd0C4HckyeXQyQLMTHKfs/mkwTPwyqoG5yH/8B5AhB52w==
X-Received: by 2002:a05:6402:274d:b0:5cf:420a:9 with SMTP id
 4fb4d7f45d1cf-5d972dfb8bamr10380504a12.5.1736534827478; 
 Fri, 10 Jan 2025 10:47:07 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99083fbd7sm1910524a12.73.2025.01.10.10.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PULL 20/38] target/i386/kvm: Add feature bit definitions for KVM
 CPUID
Date: Fri, 10 Jan 2025 19:46:01 +0100
Message-ID: <20250110184620.408302-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add feature definitions for KVM_CPUID_FEATURES in CPUID (
CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
offset calculations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 23 +++++++++++++++++++++++
 hw/i386/kvm/clock.c   |  5 ++---
 target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dbd8f1ffc79..f41462d8c19 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -29,6 +29,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
+#include "standard-headers/asm-x86/kvm_para.h"
 
 #define XEN_NR_VIRQS 24
 
@@ -1010,6 +1011,28 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
 
+/* (Old) KVM paravirtualized clocksource */
+#define CPUID_KVM_CLOCK            (1U << KVM_FEATURE_CLOCKSOURCE)
+/* (New) KVM specific paravirtualized clocksource */
+#define CPUID_KVM_CLOCK2           (1U << KVM_FEATURE_CLOCKSOURCE2)
+/* KVM asynchronous page fault */
+#define CPUID_KVM_ASYNCPF          (1U << KVM_FEATURE_ASYNC_PF)
+/* KVM stolen (when guest vCPU is not running) time accounting */
+#define CPUID_KVM_STEAL_TIME       (1U << KVM_FEATURE_STEAL_TIME)
+/* KVM paravirtualized end-of-interrupt signaling */
+#define CPUID_KVM_PV_EOI           (1U << KVM_FEATURE_PV_EOI)
+/* KVM paravirtualized spinlocks support */
+#define CPUID_KVM_PV_UNHALT        (1U << KVM_FEATURE_PV_UNHALT)
+/* KVM host-side polling on HLT control from the guest */
+#define CPUID_KVM_POLL_CONTROL     (1U << KVM_FEATURE_POLL_CONTROL)
+/* KVM interrupt based asynchronous page fault*/
+#define CPUID_KVM_ASYNCPF_INT      (1U << KVM_FEATURE_ASYNC_PF_INT)
+/* KVM 'Extended Destination ID' support for external interrupts */
+#define CPUID_KVM_MSI_EXT_DEST_ID  (1U << KVM_FEATURE_MSI_EXT_DEST_ID)
+
+/* Hint to KVM that vCPUs expect never preempted for an unlimited time */
+#define CPUID_KVM_HINTS_REALTIME    (1U << KVM_HINTS_REALTIME)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 63be5088420..17443552e91 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 
 #include <linux/kvm.h>
-#include "standard-headers/asm-x86/kvm_para.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_CLOCK "kvmclock"
@@ -333,8 +332,8 @@ void kvmclock_create(bool create_always)
 
     assert(kvm_enabled());
     if (create_always ||
-        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
-                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
+        cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
+                                       CPUID_KVM_CLOCK2)) {
         sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
     }
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2f66e63b880..d6fb3bee86d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -564,13 +564,13 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * be enabled without the in-kernel irqchip
          */
         if (!kvm_irqchip_in_kernel()) {
-            ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
+            ret &= ~CPUID_KVM_PV_UNHALT;
         }
         if (kvm_irqchip_is_split()) {
-            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
+            ret |= CPUID_KVM_MSI_EXT_DEST_ID;
         }
     } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
-        ret |= 1U << KVM_HINTS_REALTIME;
+        ret |= CPUID_KVM_HINTS_REALTIME;
     }
 
     if (current_machine->cgs) {
@@ -3978,20 +3978,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
         kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
         kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+        if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+        if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
+        if (env->features[FEAT_KVM] & CPUID_KVM_PV_EOI) {
             kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
+        if (env->features[FEAT_KVM] & CPUID_KVM_STEAL_TIME) {
             kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
         }
 
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+        if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
@@ -4456,19 +4456,19 @@ static int kvm_get_msrs(X86CPU *cpu)
 #endif
     kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
     kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+    if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+    if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
+    if (env->features[FEAT_KVM] & CPUID_KVM_PV_EOI) {
         kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
+    if (env->features[FEAT_KVM] & CPUID_KVM_STEAL_TIME) {
         kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+    if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
     if (has_architectural_pmu_version > 0) {
@@ -6195,7 +6195,7 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
         return address;
     }
     env = &X86_CPU(first_cpu)->env;
-    if (!(env->features[FEAT_KVM] & (1 << KVM_FEATURE_MSI_EXT_DEST_ID))) {
+    if (!(env->features[FEAT_KVM] & CPUID_KVM_MSI_EXT_DEST_ID)) {
         return address;
     }
 
-- 
2.47.1


