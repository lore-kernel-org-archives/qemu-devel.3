Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41B5C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNY-0007SI-8B; Fri, 22 Mar 2024 14:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNV-00076r-FF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNP-00074o-KR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8M25bfa3MCpTrd05qF2EjoVKP9JaLf2Ju/AIb/9D7g=;
 b=eCCGPI2z7u/fnZAYxSb74+DzHSaa4LggtmI5s0u0g56Q5gkvXEExwLSjLVZojJ80Z80XjE
 H9H6YddNBW8ygd+z3n4KEYghOLq0hVIfuL+jASAUS3j+QlMsoPDh37GCfdxUHeH2j1UYGM
 GbUMRZ/0RxEsHHIOu9UE5ovJEWDhHiw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-dyDKNFwENK2GpffING0GIw-1; Fri, 22 Mar 2024 14:12:21 -0400
X-MC-Unique: dyDKNFwENK2GpffING0GIw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4739b1e746so42575566b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131139; x=1711735939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8M25bfa3MCpTrd05qF2EjoVKP9JaLf2Ju/AIb/9D7g=;
 b=j3Ll6A3H9VJAWbLsrA3gpwbWy9kasGMf6gTVAaHzTJez4XBk3y9KM7CQugh46IcOFl
 5uOHwPn5vEwrp0S4Uaf6gw4Xo72jfKzJE967MyA19+MubQDFAMeVE4rVn1F1aW/Rldx/
 JSBDsbbUnk3De1qve0zCq9/YRzaXU4yoC9csWkRtLH/xmeOZQyUWUVlF1i98+sWTIoxr
 uW4MSLmb1vf/qButpPqIlTp25EHdWpesbg9aTSRrsDYqaXznklhjfXUMBxNU+/m1lRT8
 JfQ/7zy3Bqz/hdbQR3ty7y/sqONEewrwywVUm7S1UerO9ylWvi9pQCy7ar7neC6mxnn/
 /Vng==
X-Gm-Message-State: AOJu0Yx+twS/PUGAxgvQNZ14kTAxnXLUF++MTZ0dGjf1m5+yXJRjGiDC
 IZbY1ac5jtdv5L7O/d9l+7/4roBViZNixseWRiJakOd0UaTDm0p32ysEY9vGIPmDV/dwyYZwIyi
 sPSpZuNaW8KpVZ/q+/3p4RHjD8OmfmQsWdkdevQ2fkE39yymPjOXEHvlcmCzPZ3LXZf9JzkDZC2
 AdqE43HDhvl+aQg7LquLSypn8u20lDBV6r3xzl
X-Received: by 2002:a17:907:7208:b0:a47:34a5:822c with SMTP id
 dr8-20020a170907720800b00a4734a5822cmr2099408ejc.2.1711131139582; 
 Fri, 22 Mar 2024 11:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDQS2C4QrrtcQsBk64CktRDywUn7oAua3Vb1E+COK+YtPkSApycmg0yis3wGo49e+nz2vQSw==
X-Received: by 2002:a17:907:7208:b0:a47:34a5:822c with SMTP id
 dr8-20020a170907720800b00a4734a5822cmr2099383ejc.2.1711131139279; 
 Fri, 22 Mar 2024 11:12:19 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 jo16-20020a170906f6d000b00a44e2f3024bsm77758ejb.68.2024.03.22.11.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 19/26] RAMBlock: Add support of KVM private guest memfd
Date: Fri, 22 Mar 2024 19:11:09 +0100
Message-ID: <20240322181116.1228416-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Add KVM guest_memfd support to RAMBlock so both normal hva based memory
and kvm guest memfd based private memory can be associated in one RAMBlock.

Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM ioctl to
create private guest_memfd during RAMBlock setup.

Allocating a new RAM_GUEST_MEMFD flag to instruct the setup of guest memfd
is more flexible and extensible than simply relying on the VM type because
in the future we may have the case that not all the memory of a VM need
guest memfd. As a benefit, it also avoid getting MachineState in memory
subsystem.

Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
confidential guests, such as TDX VM. How and when to set it for memory
backends will be implemented in the following patches.

Introduce memory_region_has_guest_memfd() to query if the MemoryRegion has
KVM guest_memfd allocated.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240320083945.991426-7-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h   | 20 +++++++++++++++++---
 include/exec/ram_addr.h |  2 +-
 include/exec/ramblock.h |  1 +
 include/sysemu/kvm.h    |  3 ++-
 accel/kvm/kvm-all.c     | 28 ++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c  |  5 +++++
 system/memory.c         |  5 +++++
 system/physmem.c        | 34 +++++++++++++++++++++++++++++++---
 8 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b31..679a8476852 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -243,6 +243,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM FD is opened read-only */
 #define RAM_READONLY_FD (1 << 11)
 
+/* RAM can be private that has kvm guest memfd backend */
+#define RAM_GUEST_MEMFD   (1 << 12)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -1307,7 +1310,8 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
- * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE.
+ * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
+ *             RAM_GUEST_MEMFD.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1369,7 +1373,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1399,7 +1403,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1722,6 +1726,16 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  */
 bool memory_region_is_protected(MemoryRegion *mr);
 
+/**
+ * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
+ *     associated
+ *
+ * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_has_guest_memfd(MemoryRegion *mr);
+
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
  *
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index de45ba7bc96..07c8f863750 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -110,7 +110,7 @@ long qemu_maxrampagesize(void);
  *  @mr: the memory region where the ram block is
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 848915ea5bf..459c8917de2 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -41,6 +41,7 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     uint64_t fd_offset;
+    int guest_memfd;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index bda309d5ffa..2cb31925091 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -537,7 +537,8 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+
 int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
 int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
-
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 36e39fd6514..6aa0608805b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -92,6 +92,7 @@ static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
+static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2413,6 +2414,11 @@ static int kvm_init(MachineState *ms)
     }
 
     kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
+    kvm_guest_memfd_supported =
+        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
+        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
     s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
@@ -4131,3 +4137,25 @@ void kvm_mark_guest_state_protected(void)
 {
     kvm_state->guest_state_protected = true;
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    int fd;
+    struct kvm_create_guest_memfd guest_memfd = {
+        .size = size,
+        .flags = flags,
+    };
+
+    if (!kvm_guest_memfd_supported) {
+        error_setg(errp, "KVM doesn't support guest memfd\n");
+        return -1;
+    }
+
+    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "Error creating kvm guest memfd");
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ca381728840..8e0eb22e61c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -129,3 +129,8 @@ bool kvm_hwpoisoned_mem(void)
 {
     return false;
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    return -ENOSYS;
+}
diff --git a/system/memory.c b/system/memory.c
index a229a79988f..c756950c0c0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1850,6 +1850,11 @@ bool memory_region_is_protected(MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
+bool memory_region_has_guest_memfd(MemoryRegion *mr)
+{
+    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+}
+
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
diff --git a/system/physmem.c b/system/physmem.c
index a4fe3d2bf89..f5dfa20e57e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1808,6 +1808,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     const bool shared = qemu_ram_is_shared(new_block);
     RAMBlock *block;
     RAMBlock *last_block = NULL;
+    bool free_on_error = false;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
@@ -1837,6 +1838,19 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 return;
             }
             memory_try_enable_merging(new_block->host, new_block->max_length);
+            free_on_error = true;
+        }
+    }
+
+    if (new_block->flags & RAM_GUEST_MEMFD) {
+        assert(kvm_enabled());
+        assert(new_block->guest_memfd < 0);
+
+        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
+                                                        0, errp);
+        if (new_block->guest_memfd < 0) {
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
         }
     }
 
@@ -1888,6 +1902,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
+    return;
+
+out_free:
+    if (free_on_error) {
+        qemu_anon_ram_free(new_block->host, new_block->max_length);
+        new_block->host = NULL;
+    }
 }
 
 #ifdef CONFIG_POSIX
@@ -1902,7 +1923,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD)) == 0);
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1939,6 +1960,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
+    new_block->guest_memfd = -1;
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
                                      errp);
     if (!new_block->host) {
@@ -2018,7 +2040,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
     align = qemu_real_host_page_size();
@@ -2033,6 +2055,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
+    new_block->guest_memfd = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2055,7 +2078,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
@@ -2083,6 +2106,11 @@ static void reclaim_ramblock(RAMBlock *block)
     } else {
         qemu_anon_ram_free(block->host, block->max_length);
     }
+
+    if (block->guest_memfd >= 0) {
+        close(block->guest_memfd);
+    }
+
     g_free(block);
 }
 
-- 
2.44.0


