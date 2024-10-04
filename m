Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30B4CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlH5-0008TN-JQ; Fri, 04 Oct 2024 12:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGY-0006mm-Pf
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGV-0006BY-UK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2g4mc95iEC4Fl6ddcqjWYqmR7w+tez1xzg3U9+5sDY=;
 b=DyRhhPtEccfZXmflUQTabBQwMb0kC5rG45QXa8ZIOuhkd6EfK00IrgrWcFW69eku4A1Dg8
 lQM48jlyLsgsmBuHwM+/+xSX1b4eTlrpVrBXNSTbZNqS3omjx6MCRXXkFW+TluVAy0rjt6
 cMVLM1KBcOe6YSzmHRc0t1bMs/Swnfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-0co8HHeFPm6VAlJMQXw-qg-1; Fri, 04 Oct 2024 12:34:50 -0400
X-MC-Unique: 0co8HHeFPm6VAlJMQXw-qg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so17701425e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059687; x=1728664487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2g4mc95iEC4Fl6ddcqjWYqmR7w+tez1xzg3U9+5sDY=;
 b=Guy9vXku0y8tK2Jgq0vJq8bJ4kzY91GPak9r98+UVo0EyoT+H4J/JxaSRv6oceucFf
 618u61Xfp3gqeH4H7xmWFf9L8YYbWJDNUPNWuubiQaEbK0QHB6BCTd487Y/eNb/QPo5m
 UIzDqGfstPv3V22OFlpn6Fd+g+rBhYwqNDJLSYlZ3lVqKnyYDPUTmB6KHUcbXe7qe00d
 h+UExqf0aq8uABI+BhOta4ZoB5aFnwUPO9e9p2zSY47ZlsmdBPdYeV9dXYGximqpfo7U
 G3MlJsod9npXrT5K77mIXbHuEZ6U8lM1DpHZlAE2OemFG8e1AJBrLoA6LSyBKAlPGJGk
 pWRg==
X-Gm-Message-State: AOJu0YyrU3k1p56Khou0aPdV2KIGvCgr7HYbV7MrSAaCFR1i4c7kzXf0
 IRHdIGEWMgdqoyz/l2Iry+lhJXNltagOtef4+ZNDhIIVaUex+VvmfRrFzg2gSuWbUbOxjwEh4OT
 jlyH8wHEvF4ORJ44tDeMB/65K11AHT4RlEi8B8KTi2XbXLgjYBeQPlRpmKsNu5+eex9494sBCjL
 a6U0ErPJI0XIpK/HvQRfAOpJ0FAIkB+HSVlzigozs=
X-Received: by 2002:a5d:6649:0:b0:377:6073:48df with SMTP id
 ffacd0b85a97d-37d0eaea921mr2061381f8f.58.1728059687051; 
 Fri, 04 Oct 2024 09:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF67s4D1Ii/IMMe2GAX9UH7hLrSGGxilQetKOGJqXYtO+ayn0lNPLARd66ttOkIMIvzia1XzQ==
X-Received: by 2002:a5d:6649:0:b0:377:6073:48df with SMTP id
 ffacd0b85a97d-37d0eaea921mr2061365f8f.58.1728059686503; 
 Fri, 04 Oct 2024 09:34:46 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16921aa4sm33780f8f.64.2024.10.04.09.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 09/23] kvm/i386: refactor kvm_arch_init and split it into
 smaller functions
Date: Fri,  4 Oct 2024 18:34:01 +0200
Message-ID: <20241004163415.951106-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

kvm_arch_init() enables a lot of vm capabilities. Refactor them into separate
smaller functions. Energy MSR related operations also moved to its own
function. There should be no functional impact.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240903124143.39345-2-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 327 ++++++++++++++++++++++++++----------------
 1 file changed, 201 insertions(+), 126 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fa0be5537fa..64ef2db9238 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3005,10 +3005,185 @@ int kvm_arch_get_default_type(MachineState *ms)
     return 0;
 }
 
+static int kvm_vm_enable_exception_payload(KVMState *s)
+{
+    int ret = 0;
+    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
+    if (has_exception_payload) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable exception payload cap: %s",
+                         strerror(-ret));
+        }
+    }
+
+    return ret;
+}
+
+static int kvm_vm_enable_triple_fault_event(KVMState *s)
+{
+    int ret = 0;
+    has_triple_fault_event = \
+        kvm_check_extension(s,
+                            KVM_CAP_X86_TRIPLE_FAULT_EVENT);
+    if (has_triple_fault_event) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable triple fault event cap: %s",
+                         strerror(-ret));
+        }
+    }
+    return ret;
+}
+
+static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t *identity_base)
+{
+    /*
+     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
+     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
+     * Since these must be part of guest physical memory, we need to allocate
+     * them, both by setting their start addresses in the kernel and by
+     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+     * so this value allows up to 16M BIOSes.
+     */
+    *identity_base = 0xfeffc000;
+    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, identity_base);
+}
+
+static int kvm_vm_set_nr_mmu_pages(KVMState *s)
+{
+    uint64_t shadow_mem;
+    int ret = 0;
+    shadow_mem = object_property_get_int(OBJECT(s),
+                                         "kvm-shadow-mem",
+                                         &error_abort);
+    if (shadow_mem != -1) {
+        shadow_mem /= 4096;
+        ret = kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
+    }
+    return ret;
+}
+
+static int kvm_vm_set_tss_addr(KVMState *s, uint64_t identity_base)
+{
+    /* Set TSS base one page after EPT identity map. */
+    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base);
+}
+
+static int kvm_vm_enable_disable_exits(KVMState *s)
+{
+    int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
+/* Work around for kernel header with a typo. TODO: fix header and drop. */
+#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
+#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
+#endif
+    if (disable_exits) {
+        disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
+                          KVM_X86_DISABLE_EXITS_HLT |
+                          KVM_X86_DISABLE_EXITS_PAUSE |
+                          KVM_X86_DISABLE_EXITS_CSTATE);
+    }
+
+    return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
+                             disable_exits);
+}
+
+static int kvm_vm_enable_bus_lock_exit(KVMState *s)
+{
+    int ret = 0;
+    ret = kvm_check_extension(s, KVM_CAP_X86_BUS_LOCK_EXIT);
+    if (!(ret & KVM_BUS_LOCK_DETECTION_EXIT)) {
+        error_report("kvm: bus lock detection unsupported");
+        return -ENOTSUP;
+    }
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X86_BUS_LOCK_EXIT, 0,
+                            KVM_BUS_LOCK_DETECTION_EXIT);
+    if (ret < 0) {
+        error_report("kvm: Failed to enable bus lock detection cap: %s",
+                     strerror(-ret));
+    }
+
+    return ret;
+}
+
+static int kvm_vm_enable_notify_vmexit(KVMState *s)
+{
+    int ret = 0;
+    if (s->notify_vmexit != NOTIFY_VMEXIT_OPTION_DISABLE) {
+        uint64_t notify_window_flags =
+            ((uint64_t)s->notify_window << 32) |
+            KVM_X86_NOTIFY_VMEXIT_ENABLED |
+            KVM_X86_NOTIFY_VMEXIT_USER;
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_NOTIFY_VMEXIT, 0,
+                                notify_window_flags);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable notify vmexit cap: %s",
+                         strerror(-ret));
+        }
+    }
+    return ret;
+}
+
+static int kvm_vm_enable_userspace_msr(KVMState *s)
+{
+    int ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
+                                KVM_MSR_EXIT_REASON_FILTER);
+    if (ret < 0) {
+        error_report("Could not enable user space MSRs: %s",
+                     strerror(-ret));
+        exit(1);
+    }
+
+    if (!kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
+                        kvm_rdmsr_core_thread_count, NULL)) {
+        error_report("Could not install MSR_CORE_THREAD_COUNT handler!");
+        exit(1);
+    }
+
+    return 0;
+}
+
+static void kvm_vm_enable_energy_msrs(KVMState *s)
+{
+    bool r;
+    if (s->msr_energy.enable == true) {
+        r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                           kvm_rdmsr_rapl_power_unit, NULL);
+        if (!r) {
+            error_report("Could not install MSR_RAPL_POWER_UNIT \
+                                handler");
+            exit(1);
+        }
+
+        r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                           kvm_rdmsr_pkg_power_limit, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_POWER_LIMIT \
+                                handler");
+            exit(1);
+        }
+
+        r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                           kvm_rdmsr_pkg_power_info, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_POWER_INFO \
+                                handler");
+            exit(1);
+        }
+        r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                           kvm_rdmsr_pkg_energy_status, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_ENERGY_STATUS \
+                                handler");
+            exit(1);
+        }
+    }
+    return;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     uint64_t identity_base = 0xfffbc000;
-    uint64_t shadow_mem;
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3038,24 +3213,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
 
-    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
-    if (has_exception_payload) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
-        if (ret < 0) {
-            error_report("kvm: Failed to enable exception payload cap: %s",
-                         strerror(-ret));
-            return ret;
-        }
+    ret = kvm_vm_enable_exception_payload(s);
+    if (ret < 0) {
+        return ret;
     }
 
-    has_triple_fault_event = kvm_check_extension(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT);
-    if (has_triple_fault_event) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 0, true);
-        if (ret < 0) {
-            error_report("kvm: Failed to enable triple fault event cap: %s",
-                         strerror(-ret));
-            return ret;
-        }
+    ret = kvm_vm_enable_triple_fault_event(s);
+    if (ret < 0) {
+        return ret;
     }
 
     if (s->xen_version) {
@@ -3086,22 +3251,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
 
-    /*
-     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
-     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
-     * Since these must be part of guest physical memory, we need to allocate
-     * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
-     * so this value allows up to 16M BIOSes.
-     */
-    identity_base = 0xfeffc000;
-    ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
+    ret = kvm_vm_set_identity_map_addr(s, &identity_base);
     if (ret < 0) {
         return ret;
     }
 
-    /* Set TSS base one page after EPT identity map. */
-    ret = kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base + 0x1000);
+    ret = kvm_vm_set_tss_addr(s, identity_base + 0x1000);
     if (ret < 0) {
         return ret;
     }
@@ -3109,13 +3264,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
     e820_add_entry(identity_base, 0x4000, E820_RESERVED);
 
-    shadow_mem = object_property_get_int(OBJECT(s), "kvm-shadow-mem", &error_abort);
-    if (shadow_mem != -1) {
-        shadow_mem /= 4096;
-        ret = kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
-        if (ret < 0) {
-            return ret;
-        }
+    ret = kvm_vm_set_nr_mmu_pages(s);
+    if (ret < 0) {
+        return ret;
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
@@ -3126,20 +3277,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (enable_cpu_pm) {
-        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
-/* Work around for kernel header with a typo. TODO: fix header and drop. */
-#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
-#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
-#endif
-        if (disable_exits) {
-            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
-                              KVM_X86_DISABLE_EXITS_HLT |
-                              KVM_X86_DISABLE_EXITS_PAUSE |
-                              KVM_X86_DISABLE_EXITS_CSTATE);
-        }
-
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-                                disable_exits);
+        ret = kvm_vm_enable_disable_exits(s);
         if (ret < 0) {
             error_report("kvm: guest stopping CPU not supported: %s",
                          strerror(-ret));
@@ -3150,16 +3288,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         X86MachineState *x86ms = X86_MACHINE(ms);
 
         if (x86ms->bus_lock_ratelimit > 0) {
-            ret = kvm_check_extension(s, KVM_CAP_X86_BUS_LOCK_EXIT);
-            if (!(ret & KVM_BUS_LOCK_DETECTION_EXIT)) {
-                error_report("kvm: bus lock detection unsupported");
-                return -ENOTSUP;
-            }
-            ret = kvm_vm_enable_cap(s, KVM_CAP_X86_BUS_LOCK_EXIT, 0,
-                                    KVM_BUS_LOCK_DETECTION_EXIT);
+            ret = kvm_vm_enable_bus_lock_exit(s);
             if (ret < 0) {
-                error_report("kvm: Failed to enable bus lock detection cap: %s",
-                             strerror(-ret));
                 return ret;
             }
             ratelimit_init(&bus_lock_ratelimit_ctrl);
@@ -3168,80 +3298,25 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (s->notify_vmexit != NOTIFY_VMEXIT_OPTION_DISABLE &&
-        kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
-            uint64_t notify_window_flags =
-                ((uint64_t)s->notify_window << 32) |
-                KVM_X86_NOTIFY_VMEXIT_ENABLED |
-                KVM_X86_NOTIFY_VMEXIT_USER;
-            ret = kvm_vm_enable_cap(s, KVM_CAP_X86_NOTIFY_VMEXIT, 0,
-                                    notify_window_flags);
-            if (ret < 0) {
-                error_report("kvm: Failed to enable notify vmexit cap: %s",
-                             strerror(-ret));
-                return ret;
-            }
-    }
-    if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
-        bool r;
-
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
-                                KVM_MSR_EXIT_REASON_FILTER);
-        if (ret) {
-            error_report("Could not enable user space MSRs: %s",
-                         strerror(-ret));
-            exit(1);
+    if (kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
+        ret = kvm_vm_enable_notify_vmexit(s);
+        if (ret < 0) {
+            return ret;
         }
+    }
 
-        r = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
-                           kvm_rdmsr_core_thread_count, NULL);
-        if (!r) {
-            error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
-                         strerror(-ret));
-            exit(1);
+    if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
+        ret = kvm_vm_enable_userspace_msr(s);
+        if (ret < 0) {
+            return ret;
         }
 
         if (s->msr_energy.enable == true) {
-            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
-                               kvm_rdmsr_rapl_power_unit, NULL);
-            if (!r) {
-                error_report("Could not install MSR_RAPL_POWER_UNIT \
-                                handler: %s",
-                             strerror(-ret));
+            kvm_vm_enable_energy_msrs(s);
+            if (kvm_msr_energy_thread_init(s, ms)) {
+                error_report("kvm : error RAPL feature requirement not met");
                 exit(1);
             }
-
-            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
-                               kvm_rdmsr_pkg_power_limit, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_POWER_LIMIT \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-
-            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
-                               kvm_rdmsr_pkg_power_info, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_POWER_INFO \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
-                               kvm_rdmsr_pkg_energy_status, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_ENERGY_STATUS \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-            r = kvm_msr_energy_thread_init(s, ms);
-            if (r) {
-                error_report("kvm : error RAPL feature requirement not meet");
-                exit(1);
-            }
-
         }
     }
 
-- 
2.46.1


