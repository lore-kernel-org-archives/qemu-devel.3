Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73CC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNW-00079M-Qn; Fri, 22 Mar 2024 14:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNT-0006vZ-Tq
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNS-00075A-AH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8T782BA5iZwu9R16VfQESMUjXFbn2RSCtEb11ZrGhY=;
 b=Hyq76vVMlxqyNGWz0GAV9VFhsOsX5tLn50XJy/ItExrNZ9y7aJcEozlRMg4kTGI6zxAox3
 /ugVJ7Xb6CEUnv196Myuq3UF/rpvcUESojLgF4YJUqdSmbgHh5LvRxPWtQz4xpUJNbFq16
 4LHJaDjGBXmpO9/Fbq64poJ/XZcmdHA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-cpzz4nKqPXGx01OgVP50RA-1; Fri, 22 Mar 2024 14:12:23 -0400
X-MC-Unique: cpzz4nKqPXGx01OgVP50RA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a47347d159cso57669766b.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131141; x=1711735941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8T782BA5iZwu9R16VfQESMUjXFbn2RSCtEb11ZrGhY=;
 b=dksyT0HGfycUTsGbSlLdK9GD9gaq4/+mnmLdlfztOGlQ2ndz5nsxc5aeQ5aDm6/1/m
 XOCtaPacPlfyLscy63M1Y/5IUAebeEm2Wxr8WD9YZxL1flGiOI7ZwkEVYgFHkGmPy+Qq
 8286bOTjZneEm8z/aLRjEAN4B/TmS57EZAbQB5pRKpjQWwcJxi+Cl+nwZK+uuhoCdNES
 0i8pOJ/6F40oVHtBdWewST2rOtf/hLp5Vu5o8g9QpL0AlfI3FoPC8m1fipRRAbZ12QJR
 m68F58/Wr8CRjPcX8ItypxRXvli6VTgxK7O9lg83/hM+roLb4xa9SySau7yrAP5C3alj
 2uPA==
X-Gm-Message-State: AOJu0Ywaneud2WbjU5Hbl9TM+xCXHZPRG6jni+6YC5xKjmZM0KSjySgK
 NfIIgP1OGewS0TvVuvbcs5MA/Z0NabcvmaOraYVjE8mE8HfVldA5aKL396PhCbYyS7SXXSRAG/c
 8Fbub7XqpsIrf/tTjehlzBTi7I2qFRjvV+5Aa9rdHVVkulJ03EB5J1BB9sXS3mNLOjmICXsGBB0
 YeYIxEezwJqf4nyTArDfYf3cQvu8ZRytmtKDrn
X-Received: by 2002:a17:906:4ece:b0:a47:345f:de7b with SMTP id
 i14-20020a1709064ece00b00a47345fde7bmr333450ejv.59.1711131141711; 
 Fri, 22 Mar 2024 11:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYmB4fu24KDNPa+E4XmYDo9UBZUZ3dO8eKY159KjJRpwytMln2k9I1kppl1UluDUso2RjlHw==
X-Received: by 2002:a17:906:4ece:b0:a47:345f:de7b with SMTP id
 i14-20020a1709064ece00b00a47345fde7bmr333431ejv.59.1711131141449; 
 Fri, 22 Mar 2024 11:12:21 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170906830800b00a46a9c38a64sm76122ejx.65.2024.03.22.11.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 20/26] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
Date: Fri, 22 Mar 2024 19:11:10 +0100
Message-ID: <20240322181116.1228416-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.

With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
backend'ed both by hva-based shared memory and guest memfd based private
memory.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240320083945.991426-10-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm_int.h |  2 ++
 accel/kvm/kvm-all.c      | 46 +++++++++++++++++++++++++++++++++-------
 accel/kvm/trace-events   |  2 +-
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 3496be7997a..a5a3fee4119 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -30,6 +30,8 @@ typedef struct KVMSlot
     int as_id;
     /* Cache of the offset in ram address space */
     ram_addr_t ram_start_offset;
+    int guest_memfd;
+    hwaddr guest_memfd_offset;
 } KVMSlot;
 
 typedef struct KVMMemoryUpdate {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6aa0608805b..7fbaf31cbaf 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -284,35 +284,58 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
 static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
 {
     KVMState *s = kvm_state;
-    struct kvm_userspace_memory_region mem;
+    struct kvm_userspace_memory_region2 mem;
     int ret;
 
     mem.slot = slot->slot | (kml->as_id << 16);
     mem.guest_phys_addr = slot->start_addr;
     mem.userspace_addr = (unsigned long)slot->ram;
     mem.flags = slot->flags;
+    mem.guest_memfd = slot->guest_memfd;
+    mem.guest_memfd_offset = slot->guest_memfd_offset;
 
     if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size = 0;
-        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+
+        if (kvm_guest_memfd_supported) {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+        } else {
+            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        }
         if (ret < 0) {
             goto err;
         }
     }
     mem.memory_size = slot->memory_size;
-    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    if (kvm_guest_memfd_supported) {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
+    } else {
+        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+    }
     slot->old_flags = mem.flags;
 err:
     trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
                               mem.guest_phys_addr, mem.memory_size,
-                              mem.userspace_addr, ret);
+                              mem.userspace_addr, mem.guest_memfd,
+                              mem.guest_memfd_offset, ret);
     if (ret < 0) {
-        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
-                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
-                     __func__, mem.slot, slot->start_addr,
-                     (uint64_t)mem.memory_size, strerror(errno));
+        if (kvm_guest_memfd_supported) {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
+                        " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
+                        " flags=0x%" PRIx32 ", guest_memfd=%" PRId32 ","
+                        " guest_memfd_offset=0x%" PRIx64 ": %s",
+                        __func__, mem.slot, slot->start_addr,
+                        (uint64_t)mem.memory_size, mem.flags,
+                        mem.guest_memfd, (uint64_t)mem.guest_memfd_offset,
+                        strerror(errno));
+        } else {
+                error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
+                            " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
+                            __func__, mem.slot, slot->start_addr,
+                            (uint64_t)mem.memory_size, strerror(errno));
+        }
     }
     return ret;
 }
@@ -467,6 +490,10 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
+    if (memory_region_has_guest_memfd(mr)) {
+        assert(kvm_guest_memfd_supported);
+        flags |= KVM_MEM_GUEST_MEMFD;
+    }
     return flags;
 }
 
@@ -1393,6 +1420,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
+        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
+
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 9f599abc172..e8c52cb9e7a 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,7 +15,7 @@ kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
-kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
+kvm_set_user_memory(uint16_t as, uint16_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint32_t fd, uint64_t fd_offset, int ret) "AddrSpace#%d Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " guest_memfd=%d" " guest_memfd_offset=0x%" PRIx64 " ret=%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"PRId32" start 0x%"PRIx64" size 0x%"PRIx32
 kvm_resample_fd_notify(int gsi) "gsi %d"
 kvm_dirty_ring_full(int id) "vcpu %d"
-- 
2.44.0


