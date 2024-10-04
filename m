Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A75FCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlHE-0000n2-K9; Fri, 04 Oct 2024 12:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGa-0006mv-Ex
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGY-0006Bg-Q9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxyQuyi8N7jciKzaMKuNNPCxNDYD7MTkwKRlfXHgIsE=;
 b=dYCB7+jlc3aeDprBt4vc+ZmQAvogKgfkz9MNe7EUdiRZZ56Tgk0DqNiz5ClbuGlGAQayVY
 jz1ZAbk5V4HcW549xnlpAchNcgcayND0WZXIAQeDIj1qI/xpvKvxXpYa6EocMpau+jQ4X8
 W+Lfvby+Vi7GnfXRcHC0Ky17f8EHs30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-5INQv13uP7eKcXw1wRS8EA-1; Fri, 04 Oct 2024 12:34:51 -0400
X-MC-Unique: 5INQv13uP7eKcXw1wRS8EA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso13063635e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059690; x=1728664490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxyQuyi8N7jciKzaMKuNNPCxNDYD7MTkwKRlfXHgIsE=;
 b=PidLhJzv5RVz5OIsruCiL+eAXKq01Mal8dM4Rj2+meG1EwES44qJC7svKKFY2cEXiP
 hJQwe2dcUFX4X55P51xu6TsBBBLJEnbZGYENaavvw5RbQqscALP4fZaOTW/onv+M+gR4
 URPsIWvbzOSgFAvJapukgr8wayfcgWz6EogqcwhzzeHdJ92MAllBH1mGeZ1zEXrV4ApK
 Um6J9lgb8yDYf7ZsJEZQ0QLoxwavMn99AFkhP2bCAPUXSQQrxCSCuOAXWJfvz3EA0nRi
 edpvOuFuEBBZJm4wILLS7MmI1hd9LA7mwFov+3zDpj3HHBPQyc78eFESLL6BZfAEaZfJ
 EnEg==
X-Gm-Message-State: AOJu0YylP79WLeg0w8rZXdCG1Qyk7ozZAsKxDiGdqNSaijrJqEnL7G+2
 Si45h+AuNlo6GHoqL+dGAjg0SKMdXkFtLOdiYWZIGOX2AY79jvrfM06WeyB3Ew1Zyw3negRXo4c
 AweRXAKyFLD8UvE8sKk4UnhnepuvMEihFxZly3/h53yJbr/2DFV0gBvcSpM5dVC8AoyMBgXacZ6
 y41MKbQN0itS88gRr7ZoadhbLuWMs2mcOLGHQofgE=
X-Received: by 2002:a05:600c:350c:b0:42f:4f6:f8f3 with SMTP id
 5b1f17b1804b1-42f85aa3a92mr22609325e9.7.1728059689787; 
 Fri, 04 Oct 2024 09:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvufESLsI8uopANpwm26nJMqI24XmFRK0/zowBzanzjJvDJcRgIzaDSXoJBgJ2XsGEMaK26Q==
X-Received: by 2002:a05:600c:350c:b0:42f:4f6:f8f3 with SMTP id
 5b1f17b1804b1-42f85aa3a92mr22609125e9.7.1728059689284; 
 Fri, 04 Oct 2024 09:34:49 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f3b1sm37844f8f.14.2024.10.04.09.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/23] kvm/i386: replace identity_base variable with a constant
Date: Fri,  4 Oct 2024 18:34:02 +0200
Message-ID: <20241004163415.951106-11-pbonzini@redhat.com>
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

identity_base variable is first initialzied to address 0xfffbc000 and then
kvm_vm_set_identity_map_addr() overrides this value to address 0xfeffc000.
The initial address to which the variable was initialized was never used. Clean
everything up, placing 0xfeffc000 in a preprocessor constant.

Reported-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64ef2db9238..7a1f2bda767 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -81,6 +81,16 @@
     do { } while (0)
 #endif
 
+/*
+ * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
+ * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
+ * Since these must be part of guest physical memory, we need to allocate
+ * them, both by setting their start addresses in the kernel and by
+ * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+ * so this value allows up to 16M BIOSes.
+ */
+#define KVM_IDENTITY_BASE 0xfeffc000
+
 /* From arch/x86/kvm/lapic.h */
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
@@ -3036,18 +3046,9 @@ static int kvm_vm_enable_triple_fault_event(KVMState *s)
     return ret;
 }
 
-static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t *identity_base)
+static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t identity_base)
 {
-    /*
-     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
-     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
-     * Since these must be part of guest physical memory, we need to allocate
-     * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
-     * so this value allows up to 16M BIOSes.
-     */
-    *identity_base = 0xfeffc000;
-    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, identity_base);
+    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
 }
 
 static int kvm_vm_set_nr_mmu_pages(KVMState *s)
@@ -3064,10 +3065,9 @@ static int kvm_vm_set_nr_mmu_pages(KVMState *s)
     return ret;
 }
 
-static int kvm_vm_set_tss_addr(KVMState *s, uint64_t identity_base)
+static int kvm_vm_set_tss_addr(KVMState *s, uint64_t tss_base)
 {
-    /* Set TSS base one page after EPT identity map. */
-    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base);
+    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, tss_base);
 }
 
 static int kvm_vm_enable_disable_exits(KVMState *s)
@@ -3183,7 +3183,6 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    uint64_t identity_base = 0xfffbc000;
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3251,18 +3250,19 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
 
-    ret = kvm_vm_set_identity_map_addr(s, &identity_base);
+    ret = kvm_vm_set_identity_map_addr(s, KVM_IDENTITY_BASE);
     if (ret < 0) {
         return ret;
     }
 
-    ret = kvm_vm_set_tss_addr(s, identity_base + 0x1000);
+    /* Set TSS base one page after EPT identity map. */
+    ret = kvm_vm_set_tss_addr(s, KVM_IDENTITY_BASE + 0x1000);
     if (ret < 0) {
         return ret;
     }
 
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    e820_add_entry(identity_base, 0x4000, E820_RESERVED);
+    e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
 
     ret = kvm_vm_set_nr_mmu_pages(s);
     if (ret < 0) {
-- 
2.46.1


