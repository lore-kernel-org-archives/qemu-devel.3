Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A91DC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIc-0002u0-8q; Fri, 06 Jun 2025 08:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIb-0002sS-87
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIW-0005vr-IN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tJhESokGrI0c3s2Vvduq9D3R/2nmUk+GeJRKxZbSbs=;
 b=YOzwNV5qeyth6MlubpNd9fLQecS/AazAno/GPqS84DuHygk0F3Duw5Fi7xXdZAMfXAOuEa
 wzeV9V9ZAuo5ZKRuVlu9T1/sg8e9ND8cW6gjdsNWu8sAZrgR+habO1nvwqr16bWNT3G6oh
 c45wzcUU2wgW5ZfDqnnKB0yjRNMAZFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-H9HlF-aGPE-9seeO9WwUgw-1; Fri, 06 Jun 2025 08:35:44 -0400
X-MC-Unique: H9HlF-aGPE-9seeO9WwUgw-1
X-Mimecast-MFC-AGG-ID: H9HlF-aGPE-9seeO9WwUgw_1749213344
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so16388885e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213343; x=1749818143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tJhESokGrI0c3s2Vvduq9D3R/2nmUk+GeJRKxZbSbs=;
 b=FW1hCa1Eh+ijbjy2Bb1Dza6Gsp7ar6a4VDINvlNC03mH4F20O70HjQTRH7h0HBtHYg
 DGatAgEqX6ewv77KVZkSl1n9zxA22Z5iWFyZmoggG/VKJ0N3OPSRaUAXu7fPsR6hyU0g
 JVV0lNzKQfHIJxx5meAM5Fbgn0ODFn1nl/diOiyjKCKZn9YSgr2xsuewQSccJqvqb/bs
 bVB6mPY/VxYC/Bqrwi7Ns8S2UJ8YAxyEAQGC38lXsOLjG1Ms19y3rdN1jSJuhFo4lRFW
 zEsBWMVvvENp2vxgDeYC8hNRRZUuJflZflr/0AB+MuBogqcjgWYt/K3O61mLNJe42RqN
 S/pQ==
X-Gm-Message-State: AOJu0YwVNnRkC+fwVL9FlFnunZK6y8/7J7zJpP1lO9e6MvbWUYf6jWE9
 SuPLXX6P3TjizMRyS/+e7kqXiql9YW8tvO/DWFx4j6Vg+qjtvsNqWEvSZBpH+gLgdKVL+VW3FGf
 2lZPUCoNDPgTT0jNlGAj57jhQaRnQ+smVn6Hnf7R64zFoPYiAViSdNAGBhq6FlE8unmbeQwzGZ9
 ZazPMiQ2pFL62PCuye2M7N10BhFP7XTPwptbkO/0LA
X-Gm-Gg: ASbGncvERIEIe7fyoLehR3G7wpIETWLx8j8EfRUIxGN1pvoJt6ycWSK1zAyVxaTURXR
 U3mXEhg+xlChgl9hQSsnMCxVZAbetkg2ZbYIrjoo07a0SWmAAi6kkOklOeuB7NUUkqrDN8A62mf
 j4jmryFy5h+DQoq2uLRzaI4twjUvndSfcrrw0QN3J5dO+CEC/Pbimq+rbM+dgy63xz9C1u5YkvE
 N/Wf5zR10byTutQ+1QLhvV2SUIRaqhu6jzIFSq0taNNEiMxnB1hXXIQ+Mhto29qmeCrCz1elC/M
 6MilEKE8lEkD/ADNsg3xfPnI
X-Received: by 2002:a05:600c:1546:b0:442:d9f2:c74e with SMTP id
 5b1f17b1804b1-4520140d6ccmr31504485e9.23.1749213343245; 
 Fri, 06 Jun 2025 05:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm58gwZxajbw7lIBxYn+cNkl8v3eSC/coRZYiNIzBPlJx1hHPFGRKjAufvgZGtk0MrR8FMOw==
X-Received: by 2002:a05:600c:1546:b0:442:d9f2:c74e with SMTP id
 5b1f17b1804b1-4520140d6ccmr31504195e9.23.1749213342759; 
 Fri, 06 Jun 2025 05:35:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e163113sm19954115e9.18.2025.06.06.05.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 16/31] i386/kvm: Prefault memory on page state change
Date: Fri,  6 Jun 2025 14:34:30 +0200
Message-ID: <20250606123447.538131-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Tom Lendacky <thomas.lendacky@amd.com>

A page state change is typically followed by an access of the page(s) and
results in another VMEXIT in order to map the page into the nested page
table. Depending on the size of page state change request, this can
generate a number of additional VMEXITs. For example, under SNP, when
Linux is utilizing lazy memory acceptance, memory is typically accepted in
4M chunks. A page state change request is submitted to mark the pages as
private, followed by validation of the memory. Since the guest_memfd
currently only supports 4K pages, each page validation will result in
VMEXIT to map the page, resulting in 1024 additional exits.

When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for the
size of the page state change in order to pre-map the pages and avoid the
additional VMEXITs. This helps speed up boot times.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h  |  1 +
 accel/kvm/kvm-all.c   |  2 ++
 target/i386/kvm/kvm.c | 31 ++++++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 62ec131d4d8..7cc60d26f24 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -42,6 +42,7 @@ extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
+extern bool kvm_pre_fault_memory_supported;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 51526d301b9..a31778341c2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -99,6 +99,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
+bool kvm_pre_fault_memory_supported;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
@@ -2745,6 +2746,7 @@ static int kvm_init(MachineState *ms)
         kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+    kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a6bc089d020..56a6b9b6381 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6018,9 +6018,11 @@ static bool host_supports_vmx(void)
  * because private/shared page tracking is already provided through other
  * means, these 2 use-cases should be treated as being mutually-exclusive.
  */
-static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
+static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
 {
+    struct kvm_pre_fault_memory mem;
     uint64_t gpa, size, attributes;
+    int ret;
 
     if (!machine_require_guest_memfd(current_machine))
         return -EINVAL;
@@ -6031,13 +6033,32 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
 
     trace_kvm_hc_map_gpa_range(gpa, size, attributes, run->hypercall.flags);
 
-    return kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
+    ret = kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);
+    if (ret || !kvm_pre_fault_memory_supported) {
+        return ret;
+    }
+
+    /*
+     * Opportunistically pre-fault memory in. Failures are ignored so that any
+     * errors in faulting in the memory will get captured in KVM page fault
+     * path when the guest first accesses the page.
+     */
+    memset(&mem, 0, sizeof(mem));
+    mem.gpa = gpa;
+    mem.size = size;
+    while (mem.size) {
+        if (kvm_vcpu_ioctl(CPU(cpu), KVM_PRE_FAULT_MEMORY, &mem)) {
+            break;
+        }
+    }
+
+    return 0;
 }
 
-static int kvm_handle_hypercall(struct kvm_run *run)
+static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
-        return kvm_handle_hc_map_gpa_range(run);
+        return kvm_handle_hc_map_gpa_range(cpu, run);
 
     return -EINVAL;
 }
@@ -6137,7 +6158,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
 #endif
     case KVM_EXIT_HYPERCALL:
-        ret = kvm_handle_hypercall(run);
+        ret = kvm_handle_hypercall(cpu, run);
         break;
     case KVM_EXIT_SYSTEM_EVENT:
         switch (run->system_event.type) {
-- 
2.49.0


