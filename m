Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C4DECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkjw-0008Vg-2N; Mon, 09 Sep 2024 16:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkju-0008QW-Pp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjs-0004zn-Hf
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBQjFfFzHVzxG0I3N5y9yf1md/tdpjRtkmvTgUYzVGI=;
 b=H4g07S1D2CxCZT1A429vAGGrv+obXMV0xz05/Mf7I8HiVbVV8zOxrjf1g0BR5yjfsOPDLD
 9EIf5TGueXXJo7a8OgLhE2GG/H0CFfauGYPBjFLkI0dHy/7hDrZd9fGqhVm1D8OIW6zob5
 NmzJuqBKZFtrbiEm8yw/qW0AZ0w+uHo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-IXDKOEhjOWG97pt3NoZ_6g-1; Mon, 09 Sep 2024 16:11:53 -0400
X-MC-Unique: IXDKOEhjOWG97pt3NoZ_6g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4582493b3f7so33478571cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912712; x=1726517512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBQjFfFzHVzxG0I3N5y9yf1md/tdpjRtkmvTgUYzVGI=;
 b=a/H46KFvZgE8sIOeIoaQCFcV/UHQjCZh7yNba66lA6WVOw1oH/ptbc20rMj+b7Phwk
 G4qeeKYSML0Dw1gOy0m+DXC0tnDGz+bmyZ61fwNYt6ykwMUof3rzPGgabgNrI/P+iIH9
 MVLAUaM8Mm2doeYjEFS42J53606Ru32dWI3HmVzQcjWa4OPS/iAb0SnRrZv0nZejO+OQ
 IaW840nSbEz4nlwkWlr5v4mkjGn9rhh501r6VKo1ZvzHN1agYo9295hQtjA7azRbDEHj
 xToatCyhhegbYdbQXIyqrr1sOsZ7VYtvpMZmwiZzUnJIoBV/P+7P7sZdSOEa4CguwAwe
 YWgQ==
X-Gm-Message-State: AOJu0YzsCDhn4p4iCAxAgT691g56UuseQolllVKR3ggfMBhspkWkOfMV
 URpu5aYHsAsHraFzQVtmA2IwL/vdeS1j8e1COSlIZpWfNJ+Png1FSrqUmsvDiG0tCrO5/v8RJAc
 hR134WolhuSHXG4DJ7mMbGTs+FYzWlvG59heiytS8jp/gwdXfSC2Z6LJ+FaxPRblvnsgOGMVaBV
 HaZYu1qE88XLjSHs+LgLNWT0+mbAc4M1BTRg==
X-Received: by 2002:a05:622a:198e:b0:458:2a05:6b71 with SMTP id
 d75a77b69052e-4582a056d83mr77020211cf.44.1725912711972; 
 Mon, 09 Sep 2024 13:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvJyf1WHaTw38FN7uUbFJR+Ockz72jyW878REbF7+6/sbDtbcD9uu/LfV2N0imB9FMGfr8PA==
X-Received: by 2002:a05:622a:198e:b0:458:2a05:6b71 with SMTP id
 d75a77b69052e-4582a056d83mr77019761cf.44.1725912711415; 
 Mon, 09 Sep 2024 13:11:51 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mattias Nissler <mnissler@rivosinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] softmmu: Support concurrent bounce buffers
Date: Mon,  9 Sep 2024 16:11:39 -0400
Message-ID: <20240909201147.3761639-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mattias Nissler <mnissler@rivosinc.com>

When DMA memory can't be directly accessed, as is the case when
running the device model in a separate process without shareable DMA
file descriptors, bounce buffering is used.

It is not uncommon for device models to request mapping of several DMA
regions at the same time. Examples include:
 * net devices, e.g. when transmitting a packet that is split across
   several TX descriptors (observed with igb)
 * USB host controllers, when handling a packet with multiple data TRBs
   (observed with xhci)

Previously, qemu only provided a single bounce buffer per AddressSpace
and would fail DMA map requests while the buffer was already in use. In
turn, this would cause DMA failures that ultimately manifest as hardware
errors from the guest perspective.

This change allocates DMA bounce buffers dynamically instead of
supporting only a single buffer. Thus, multiple DMA mappings work
correctly also when RAM can't be mmap()-ed.

The total bounce buffer allocation size is limited individually for each
AddressSpace. The default limit is 4096 bytes, matching the previous
maximum buffer size. A new x-max-bounce-buffer-size parameter is
provided to configure the limit for PCI devices.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240819135455.2957406-1-mnissler@rivosinc.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h       | 14 +++----
 include/hw/pci/pci_device.h |  3 ++
 hw/pci/pci.c                |  8 ++++
 system/memory.c             |  5 ++-
 system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
 5 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 296fd068c0..e5e865d1a9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1084,13 +1084,7 @@ typedef struct AddressSpaceMapClient {
     QLIST_ENTRY(AddressSpaceMapClient) link;
 } AddressSpaceMapClient;
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
+#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
 
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
@@ -1110,8 +1104,10 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Bounce buffer to use for this address space. */
-    BounceBuffer bounce;
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    size_t max_bounce_buffer_size;
+    /* Total size of bounce buffers currently allocated, atomically accessed */
+    size_t bounce_buffer_size;
     /* List of callbacks to invoke when buffers free up */
     QemuMutex map_client_list_lock;
     QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 15694f2489..91df40f989 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -167,6 +167,9 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint32_t max_bounce_buffer_size;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fab86d0567..d2caf3ee8b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
+                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1204,6 +1206,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                        "bus master container", UINT64_MAX);
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
+    pci_dev->bus_master_as.max_bounce_buffer_size =
+        pci_dev->max_bounce_buffer_size;
 
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
@@ -2633,6 +2637,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+    object_class_property_set_description(
+        klass, "x-max-bounce-buffer-size",
+        "Maximum buffer size allocated for bounce buffers used for mapped "
+        "access to indirect DMA memory");
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
diff --git a/system/memory.c b/system/memory.c
index 5e6eb459d5..f6f6fee6d8 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3148,7 +3148,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
-    as->bounce.in_use = false;
+    as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;
+    as->bounce_buffer_size = 0;
     qemu_mutex_init(&as->map_client_list_lock);
     QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
@@ -3158,7 +3159,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
-    assert(!qatomic_read(&as->bounce.in_use));
+    assert(qatomic_read(&as->bounce_buffer_size) == 0);
     assert(QLIST_EMPTY(&as->map_client_list));
     qemu_mutex_destroy(&as->map_client_list_lock);
 
diff --git a/system/physmem.c b/system/physmem.c
index 94600a33ec..971bfa0855 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3095,6 +3095,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
+/*
+ * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
+ * to detect illegal pointers passed to address_space_unmap.
+ */
+#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
+
+typedef struct {
+    uint64_t magic;
+    MemoryRegion *mr;
+    hwaddr addr;
+    size_t len;
+    uint8_t buffer[];
+} BounceBuffer;
+
 static void
 address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
@@ -3120,9 +3134,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     QEMU_LOCK_GUARD(&as->map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&as->map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
+    /* Write map_client_list before reading bounce_buffer_size. */
     smp_mb();
-    if (!qatomic_read(&as->bounce.in_use)) {
+    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
         address_space_notify_map_clients_locked(as);
     }
 }
@@ -3251,28 +3265,40 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&as->bounce.in_use, true)) {
+        size_t used = qatomic_read(&as->bounce_buffer_size);
+        for (;;) {
+            hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
+            size_t new_size = used + alloc;
+            size_t actual =
+                qatomic_cmpxchg(&as->bounce_buffer_size, used, new_size);
+            if (actual == used) {
+                l = alloc;
+                break;
+            }
+            used = actual;
+        }
+
+        if (l == 0) {
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
-        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        as->bounce.addr = addr;
-        as->bounce.len = l;
 
+        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
+        bounce->magic = BOUNCE_BUFFER_MAGIC;
         memory_region_ref(mr);
-        as->bounce.mr = mr;
+        bounce->mr = mr;
+        bounce->addr = addr;
+        bounce->len = l;
+
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                          as->bounce.buffer, l);
+                          bounce->buffer, l);
         }
 
         *plen = l;
-        return as->bounce.buffer;
+        return bounce->buffer;
     }
 
-
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
@@ -3287,12 +3313,11 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != as->bounce.buffer) {
-        MemoryRegion *mr;
-        ram_addr_t addr1;
+    MemoryRegion *mr;
+    ram_addr_t addr1;
 
-        mr = memory_region_from_host(buffer, &addr1);
-        assert(mr != NULL);
+    mr = memory_region_from_host(buffer, &addr1);
+    if (mr != NULL) {
         if (is_write) {
             invalidate_and_set_dirty(mr, addr1, access_len);
         }
@@ -3302,15 +3327,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         memory_region_unref(mr);
         return;
     }
+
+
+    BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
+    assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
+
     if (is_write) {
-        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            as->bounce.buffer, access_len);
-    }
-    qemu_vfree(as->bounce.buffer);
-    as->bounce.buffer = NULL;
-    memory_region_unref(as->bounce.mr);
-    /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&as->bounce.in_use, false);
+        address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
+                            bounce->buffer, access_len);
+    }
+
+    qatomic_sub(&as->bounce_buffer_size, bounce->len);
+    bounce->magic = ~BOUNCE_BUFFER_MAGIC;
+    memory_region_unref(bounce->mr);
+    g_free(bounce);
+    /* Write bounce_buffer_size before reading map_client_list. */
+    smp_mb();
     address_space_notify_map_clients(as);
 }
 
-- 
2.45.0


