Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870A1CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpBu-0007k8-O5; Wed, 04 Sep 2024 08:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpBo-0007Nr-RO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpBm-0007r3-1r
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725453163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hs8UEmOhjZhsT4bHEFTB4w8fw7ILBNMs3ZZtiuWZjhk=;
 b=QDIORDGRemjTQgd0hGao+p4EMpW4eMl+6vQdbuttYcP8TzlHPtWZDs4Y0dASclrxq03tbN
 K9pcl2f1AyTCY6+MvOqCkMwTO90mK5stjQfEtnrx8GSe++U27BN7wnsIjmtK5tT5Z9e9Bv
 7vZBAPBiIz9WdWN8L9sQ+Lc8wMR4MlY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-w6cM_o3pN4GOpHqD92cLpA-1; Wed, 04 Sep 2024 08:32:42 -0400
X-MC-Unique: w6cM_o3pN4GOpHqD92cLpA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f3ea8692a4so7474641fa.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725453161; x=1726057961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hs8UEmOhjZhsT4bHEFTB4w8fw7ILBNMs3ZZtiuWZjhk=;
 b=Rzf6OjZf8adsHhk4Z6k01MCeJcJw2VLc5M8Smm4ROU+ePrZaSekQpmx2jX2RbpXb+x
 8xeru6QPc+rLBZhK4eyZvmwKSXkTS8BFfE2x66bkXP+bqhRBmZPq76h3f//zb/uwVU/O
 Zepdyg+H5zV23yRQqJdyaQ5S8YSBeI3VCYFcttUTHwqkZmJnkArONcxMNl8hnMqL8LEq
 IpgA1Q16ldbkvJuA0cusk7g/0Sqq72fg1rWuL8ui4rO4FH1YaM9PprSKbYZXjYaheU0L
 JqkLGvia96eutg30e94CSsf24SQnlXpkS4XU7eXZRCeBYxFtELFvViT1KnIpTGz09H76
 7rkg==
X-Gm-Message-State: AOJu0Yx/sr9QE3CojoFuLvM9epGQhyA0522nQGnJK3QxZHTjbA8cR+rj
 VDDzif0KKNB0qLUMGd6jIPtiwuHCFX+HQyrSjTfuVcycN0XIDhrhySiKkEOIHfktSs4BRNetfQN
 SKz+V6JowQf8bziHHVQ12o0o+WIPtLF2iu8uBcp1OWW2AHeLN9mkfNo1QrnVQ4MMZ7UKaHnosVU
 pWv9bofGNabmo4iSMS5DZ0L6IkKS8VNdPkZMOFKPs=
X-Received: by 2002:a05:651c:19ab:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2f651d54329mr20251731fa.6.1725453160497; 
 Wed, 04 Sep 2024 05:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFHc4fli4H0WR6wgclARKVOI1sB4Ukyp8M1xC4lRGn3JbttN5QV5j7hG030Dzta9UVJIrqVg==
X-Received: by 2002:a05:651c:19ab:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2f651d54329mr20251431fa.6.1725453159734; 
 Wed, 04 Sep 2024 05:32:39 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226c6a462sm7497112a12.14.2024.09.04.05.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:32:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PATCH] kvm/i386: replace identity_base variable with a constant
Date: Wed,  4 Sep 2024 14:32:38 +0200
Message-ID: <20240904123238.283627-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 599faf0ac6e..5422fd7fa7d 100644
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
@@ -3195,7 +3195,6 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    uint64_t identity_base = 0xfffbc000;
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3263,18 +3262,19 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
2.46.0


