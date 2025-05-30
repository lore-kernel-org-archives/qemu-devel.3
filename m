Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5044AC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvy-0000lo-Ti; Fri, 30 May 2025 03:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvw-0000eg-FR
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvu-0006rZ-8P
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6D0STza/xJvr/NndOlulUJwfHPggJklIbtRTxYMFHE=;
 b=GsGpkugdozbKttdE7rgO616N5EUTHaCQcjxLPcV7PMAT39SLqmoiA1gBjkaYPweourwsAL
 Wnd6vf8DhRy3178FZ9pS+uo6mFFDRJPXVnYSEq2V1cyxXtNgAWxoinQESNfV+uBHIkTz6+
 Z/NCHKyeWkEmufLQJWpwYjdFA7nDeg8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-SYZR2QpHNC6HH5PwzBEkxg-1; Fri, 30 May 2025 03:13:35 -0400
X-MC-Unique: SYZR2QpHNC6HH5PwzBEkxg-1
X-Mimecast-MFC-AGG-ID: SYZR2QpHNC6HH5PwzBEkxg_1748589214
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso130579766b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589213; x=1749194013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6D0STza/xJvr/NndOlulUJwfHPggJklIbtRTxYMFHE=;
 b=U1zd2/SZlaz6A41mHl7VEt/x3k7z9sxbNEGcqe/nV21mzLIx2cA2BwWuhKlYt0bo6q
 tYyJuSFYeYzcRJcn0YlGADBtD/RKMACz69l81m2oisQYGGGpYqZfmrHv/kutlXJQ8ElO
 NzMdXyuYt915YGLTKPUhkDKOyjmvX+VNse2anon8+cJfeTa1d7+UEZQ7ial1FTRta54Q
 ChRdkmoKxIC5G1jOGd8nfWnAAxudq8BYu3cN/ffDsAn+fTney0XepNfowB8Wftzm+FnW
 hj4TigmCvqAY8z3/uYDu6KwBcqm56oCX/UfjLIblJB3yA8jYmnb/rEPcu/izGKhFWqv1
 4hwA==
X-Gm-Message-State: AOJu0YzvMVx42jkS7lFXwJjG61WxcbY8uMSu3u2YAlkJ+Rb5rTY6Q6EF
 am6encCXq5LpvCLaXvtguHxUAOM5saYN/JV55L4siZmYlgo8qolYO/dQV0rRta9m58NsYhxfbFC
 tQp9JxOPTLG/GA8P/2Q8ZdrCbPBrK44xH30IB69V2mbCBOutAnv/L251j1nv3FmfoQBzyZOiKif
 Fz1kAZGM7a2skebO7+VUPqh4N25tSS+0zV8s0WKtDa
X-Gm-Gg: ASbGncs6epQtkcpyrGdPAg9d7DtsJQR3qKTYGie5pBk9A26ZmingR6ffO3FC3AMHom1
 ESxhzOR0fbvrw4XSScV7PQyOQsQ6cjsbjQ/+cVRvC9Ef95V3SoR9bRtJWi8JgtZ2jUhcP6YIGJj
 5XvXdGPlu4FEYKfOoaRRHbhZEaAw6kBYqGMRBh/ScsdZb4N6zrcmXyMmXCFiGzo1CUbUs5zaB3H
 mb6zibKuNpGj2OrbjfZAbkjBtN6ih9FnqqGlOiV9ObQjFBzzj2hiLm/G8gXY76fq+hj/zt5aaj+
 WhtJxRhZWduOEw==
X-Received: by 2002:a17:907:97d1:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-adb32436821mr214117466b.54.1748589213499; 
 Fri, 30 May 2025 00:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxR8+Y/lUM8gUcKPyxh+lz9FQtrmqloAOYaupEnkmzlwZoWGQ5yXzwi4xZgNTSOCOVsBxnog==
X-Received: by 2002:a17:907:97d1:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-adb32436821mr214115566b.54.1748589213073; 
 Fri, 30 May 2025 00:13:33 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fee08sm279466866b.8.2025.05.30.00.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 17/77] i386/tdx: Get tdx_capabilities via KVM_TDX_CAPABILITIES
Date: Fri, 30 May 2025 09:11:47 +0200
Message-ID: <20250530071250.2050910-18-pbonzini@redhat.com>
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

KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
TDX context. It will be used to validate user's setting later.

Since there is no interface reporting how many cpuid configs contains in
KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
and abort when it exceeds KVM_MAX_CPUID_ENTRIES.

Besides, introduce the interfaces to invoke TDX "ioctls" at VCPU scope
in preparation.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-6-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h |   2 +
 target/i386/kvm/kvm.c      |   2 -
 target/i386/kvm/tdx.c      | 109 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 88565e8dbac..ed1e61fb8ba 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,6 +13,8 @@
 
 #include "system/kvm.h"
 
+#define KVM_MAX_CPUID_ENTRIES  100
+
 /* always false if !CONFIG_KVM */
 #define kvm_pit_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d29376c5992..6d88495d476 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1780,8 +1780,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 
 static Error *invtsc_mig_blocker;
 
-#define KVM_MAX_CPUID_ENTRIES  100
-
 static void kvm_init_xsave(CPUX86State *env)
 {
     if (has_xsave2) {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 2b060fb52b9..f8ec4fa217e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -10,19 +10,124 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qom/object_interfaces.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 
-static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static struct kvm_tdx_capabilities *tdx_caps;
+
+enum tdx_ioctl_level {
+    TDX_VM_IOCTL,
+    TDX_VCPU_IOCTL,
+};
+
+static int tdx_ioctl_internal(enum tdx_ioctl_level level, void *state,
+                              int cmd_id, __u32 flags, void *data,
+                              Error **errp)
 {
-    kvm_mark_guest_state_protected();
+    struct kvm_tdx_cmd tdx_cmd = {};
+    int r;
+
+    const char *tdx_ioctl_name[] = {
+        [KVM_TDX_CAPABILITIES] = "KVM_TDX_CAPABILITIES",
+        [KVM_TDX_INIT_VM] = "KVM_TDX_INIT_VM",
+        [KVM_TDX_INIT_VCPU] = "KVM_TDX_INIT_VCPU",
+        [KVM_TDX_INIT_MEM_REGION] = "KVM_TDX_INIT_MEM_REGION",
+        [KVM_TDX_FINALIZE_VM] = "KVM_TDX_FINALIZE_VM",
+        [KVM_TDX_GET_CPUID] = "KVM_TDX_GET_CPUID",
+    };
+
+    tdx_cmd.id = cmd_id;
+    tdx_cmd.flags = flags;
+    tdx_cmd.data = (__u64)(unsigned long)data;
+
+    switch (level) {
+    case TDX_VM_IOCTL:
+        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+        break;
+    case TDX_VCPU_IOCTL:
+        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+        break;
+    default:
+        error_setg(errp, "Invalid tdx_ioctl_level %d", level);
+        return -EINVAL;
+    }
+
+    if (r < 0) {
+        error_setg_errno(errp, -r, "TDX ioctl %s failed, hw_errors: 0x%llx",
+                         tdx_ioctl_name[cmd_id], tdx_cmd.hw_error);
+    }
+    return r;
+}
+
+static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data,
+                               Error **errp)
+{
+    return tdx_ioctl_internal(TDX_VM_IOCTL, NULL, cmd_id, flags, data, errp);
+}
+
+static inline int tdx_vcpu_ioctl(CPUState *cpu, int cmd_id, __u32 flags,
+                                 void *data, Error **errp)
+{
+    return  tdx_ioctl_internal(TDX_VCPU_IOCTL, cpu, cmd_id, flags, data, errp);
+}
+
+static int get_tdx_capabilities(Error **errp)
+{
+    struct kvm_tdx_capabilities *caps;
+    /* 1st generation of TDX reports 6 cpuid configs */
+    int nr_cpuid_configs = 6;
+    size_t size;
+    int r;
+
+    do {
+        Error *local_err = NULL;
+        size = sizeof(struct kvm_tdx_capabilities) +
+                      nr_cpuid_configs * sizeof(struct kvm_cpuid_entry2);
+        caps = g_malloc0(size);
+        caps->cpuid.nent = nr_cpuid_configs;
+
+        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps, &local_err);
+        if (r == -E2BIG) {
+            g_free(caps);
+            nr_cpuid_configs *= 2;
+            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
+                error_report("KVM TDX seems broken that number of CPUID entries"
+                             " in kvm_tdx_capabilities exceeds limit: %d",
+                             KVM_MAX_CPUID_ENTRIES);
+                error_propagate(errp, local_err);
+                return r;
+            }
+            error_free(local_err);
+        } else if (r < 0) {
+            g_free(caps);
+            error_propagate(errp, local_err);
+            return r;
+        }
+    } while (r == -E2BIG);
+
+    tdx_caps = caps;
 
     return 0;
 }
 
+static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    int r = 0;
+
+    kvm_mark_guest_state_protected();
+
+    if (!tdx_caps) {
+        r = get_tdx_capabilities(errp);
+    }
+
+    return r;
+}
+
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
 {
     /* Do the object check */
-- 
2.49.0


