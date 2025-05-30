Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1197C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtw5-0000xd-QV; Fri, 30 May 2025 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw3-0000vf-GP
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw1-0006sF-Br
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9U6F9ROkyxmj8G3C6KpcQV9jrfTPF26SEPd5+i+mvo=;
 b=ctAX127KwjidEMInXYOqtD7WH6FQs+mIYplcrdd+SPPOeJa/KJqHKsp8RgRfd3gUH5b1Uz
 ZvWUto5BsYoVSAk7i0fKDWPIosGuO1N7xG++t6aPQpKGpkWFLBIYdxM5q3ONcoUBXJME0e
 RnoaoA9nb/pWDX7556qv7WkHAMtDU9w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-I6c64I-ZO0O840cDmwyijg-1; Fri, 30 May 2025 03:13:42 -0400
X-MC-Unique: I6c64I-ZO0O840cDmwyijg-1
X-Mimecast-MFC-AGG-ID: I6c64I-ZO0O840cDmwyijg_1748589221
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6023d9a86ffso1322147a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589220; x=1749194020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9U6F9ROkyxmj8G3C6KpcQV9jrfTPF26SEPd5+i+mvo=;
 b=O4WydEPbKBYnCgAtSLFcDfYyrmhVlx6YYcYGAolZ4AfkmQg122/VjvaVN79FANRbeN
 3QpG02zxHw5p8Wzq6A5gECunXT6mEu30jNeG94xG6UfdjULfeB+1+F70OJxlD3/LFSB3
 InFkgR2rR8oewDQ7N17c2arIckwORto6bf1y5xie3+CxHR/OTF86rznD8wkj6VgqhZn9
 6MFiyNWvL8el3H960FbKACpt/BADYjXSlf1Ls6O+9KdEIRfbMGR2BjxvTbuEEgtdygAU
 uvdHOtQ2RKmWEni0CrzG/W1a/mXr1aWdof51ba2p78FJvXbZ/I7Ict0SFaAoKWtEh5LM
 qMZQ==
X-Gm-Message-State: AOJu0Yzs/+TVg0w+RI4xdEUXZ82QhXn8xhW85JsKaQ6tV5b2wQxcXnE+
 fHCpNn+Pz/2J2zAFaKafuJqKp6E8n7byTuFvzrjlA9/jBt/rZj4MTZCySTv+xsbfzU/FFhAo2Pr
 I2qwHklygRIbfMEcFNvMRobKSqLYQy411C7VFODZIMwd9xATGQnexSkwLVrOl3+QdNFcKjdqsah
 737wp5Cp8H1eSI9oTmpL1gm2KGf79c6XZ4uvmXsPN7
X-Gm-Gg: ASbGncuaYXdFftE62xL4JCGYyce22VMKhopiY+oEzK+rGHuXhRv40p9mgJMn6lAtDsd
 ZIQlyYKEj9NTn6nMZ9airhmZUWY9gzquIggqaMAp8EGPKvfmLCT3PUPSEjuHXtELT9Dc+ktaBJ0
 5z5v8f6b80B3AczgBi+BWZ5xy52P65qHwQhV1Q9L4+tydp1ZTJ1duQh3f2t1p29xXgCrFtiWYAh
 8TwX8WA6neOjEAPUyMxhJZSNcenNG/OsgNIK0ZkDnUq2FE9RFIJMtGE/IWRLjAVn/ajb5lFsLCC
 ssEfkACpOn5f/w==
X-Received: by 2002:a05:6402:3483:b0:5ff:97dd:21d6 with SMTP id
 4fb4d7f45d1cf-6057c602e45mr993881a12.17.1748589220010; 
 Fri, 30 May 2025 00:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES7dGjVymmNyZrBCi1R1iD3nM2I6KiXKI8iib4reMEMx8MHsO1JPBn3ZsBInaJ7oqcZt3O+Q==
X-Received: by 2002:a05:6402:3483:b0:5ff:97dd:21d6 with SMTP id
 4fb4d7f45d1cf-6057c602e45mr993853a12.17.1748589219514; 
 Fri, 30 May 2025 00:13:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567141d48sm1170388a12.60.2025.05.30.00.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/77] i386/tdx: Initialize TDX before creating TD vcpus
Date: Fri, 30 May 2025 09:11:50 +0200
Message-ID: <20250530071250.2050910-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
CPUID config, and must be executed prior to creating vCPUs.

Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.

Note, this doesn't address the fact that QEMU may change the CPUID
configuration when creating vCPUs, i.e. punts on refactoring QEMU to
provide a stable CPUID config prior to kvm_arch_init().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-9-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h  |   5 ++
 target/i386/kvm/tdx.h       |   6 +++
 target/i386/kvm/kvm.c       |  16 +++---
 target/i386/kvm/tdx-stub.c  |  10 ++++
 target/i386/kvm/tdx.c       | 105 ++++++++++++++++++++++++++++++++++++
 target/i386/kvm/meson.build |   2 +-
 6 files changed, 137 insertions(+), 7 deletions(-)
 create mode 100644 target/i386/kvm/tdx-stub.c

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index ed1e61fb8ba..dc696cb7238 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -59,6 +59,11 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index);
+uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                             uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index de8ae919616..4e2b5c61ff5 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -19,7 +19,11 @@ typedef struct TdxGuestClass {
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
+    QemuMutex lock;
+
+    bool initialized;
     uint64_t attributes;    /* TD attributes */
+    uint64_t xfam;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -28,4 +32,6 @@ bool is_tdx_vm(void);
 #define is_tdx_vm() 0
 #endif /* CONFIG_TDX */
 
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 446f0600d4e..e98f1ee26a6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -38,6 +38,7 @@
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
+#include "tdx.h"
 #include "xen-emu.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -415,9 +416,9 @@ static uint32_t cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry, int reg)
 
 /* Find matching entry for function/index on kvm_cpuid2 struct
  */
-static struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
-                                                 uint32_t function,
-                                                 uint32_t index)
+struct kvm_cpuid_entry2 *cpuid_find_entry(struct kvm_cpuid2 *cpuid,
+                                          uint32_t function,
+                                          uint32_t index)
 {
     int i;
     for (i = 0; i < cpuid->nent; ++i) {
@@ -1822,9 +1823,8 @@ static void kvm_init_nested_state(CPUX86State *env)
     }
 }
 
-static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
-                                    struct kvm_cpuid_entry2 *entries,
-                                    uint32_t cpuid_i)
+uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                             uint32_t cpuid_i)
 {
     uint32_t limit, i, j;
     uint32_t unused;
@@ -2053,6 +2053,10 @@ full:
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
+    if (is_tdx_vm()) {
+        return tdx_pre_create_vcpu(cpu, errp);
+    }
+
     return 0;
 }
 
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
new file mode 100644
index 00000000000..2344433594e
--- /dev/null
+++ b/target/i386/kvm/tdx-stub.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "tdx.h"
+
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 3750889453d..2d2d48c083e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -149,6 +149,109 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
     return KVM_X86_TDX_VM;
 }
 
+static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
+{
+    CPUX86State *env = &x86cpu->env;
+    uint64_t xfam;
+
+    xfam = env->features[FEAT_XSAVE_XCR0_LO] |
+           env->features[FEAT_XSAVE_XCR0_HI] |
+           env->features[FEAT_XSAVE_XSS_LO] |
+           env->features[FEAT_XSAVE_XSS_HI];
+
+    if (xfam & ~tdx_caps->supported_xfam) {
+        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
+                   xfam, tdx_caps->supported_xfam);
+        return -1;
+    }
+
+    tdx_guest->xfam = xfam;
+    return 0;
+}
+
+static void tdx_filter_cpuid(struct kvm_cpuid2 *cpuids)
+{
+    int i, dest_cnt = 0;
+    struct kvm_cpuid_entry2 *src, *dest, *conf;
+
+    for (i = 0; i < cpuids->nent; i++) {
+        src = cpuids->entries + i;
+        conf = cpuid_find_entry(&tdx_caps->cpuid, src->function, src->index);
+        if (!conf) {
+            continue;
+        }
+        dest = cpuids->entries + dest_cnt;
+
+        dest->function = src->function;
+        dest->index = src->index;
+        dest->flags = src->flags;
+        dest->eax = src->eax & conf->eax;
+        dest->ebx = src->ebx & conf->ebx;
+        dest->ecx = src->ecx & conf->ecx;
+        dest->edx = src->edx & conf->edx;
+
+        dest_cnt++;
+    }
+    cpuids->nent = dest_cnt++;
+}
+
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
+    Error *local_err = NULL;
+    int retry = 10000;
+    int r = 0;
+
+    QEMU_LOCK_GUARD(&tdx_guest->lock);
+    if (tdx_guest->initialized) {
+        return r;
+    }
+
+    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
+                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
+
+    r = setup_td_xfam(x86cpu, errp);
+    if (r) {
+        return r;
+    }
+
+    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
+    tdx_filter_cpuid(&init_vm->cpuid);
+
+    init_vm->attributes = tdx_guest->attributes;
+    init_vm->xfam = tdx_guest->xfam;
+
+    /*
+     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
+     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
+     * RDSEED) is busy.
+     *
+     * Retry for the case.
+     */
+    do {
+        error_free(local_err);
+        local_err = NULL;
+        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
+    } while (r == -EAGAIN && --retry);
+
+    if (r < 0) {
+        if (!retry) {
+            error_append_hint(&local_err, "Hardware RNG (Random Number "
+            "Generator) is busy occupied by someone (via RDRAND/RDSEED) "
+            "maliciously, which leads to KVM_TDX_INIT_VM keeping failure "
+            "due to lack of entropy.\n");
+        }
+        error_propagate(errp, local_err);
+        return r;
+    }
+
+    tdx_guest->initialized = true;
+
+    return 0;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -162,6 +265,8 @@ static void tdx_guest_init(Object *obj)
     ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
     TdxGuest *tdx = TDX_GUEST(obj);
 
+    qemu_mutex_init(&tdx->lock);
+
     cgs->require_guest_memfd = true;
     tdx->attributes = 0;
 
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 466bccb9cb1..3f44cdedb75 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -8,7 +8,7 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
-i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'), if_false: files('tdx-stub.c'))
 
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
-- 
2.49.0


