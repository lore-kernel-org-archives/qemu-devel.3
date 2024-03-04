Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD2AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5D9-0007SC-Vo; Mon, 04 Mar 2024 05:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D8-0007Rp-Ha
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:18 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D4-0006Gb-MG
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:16 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso219474b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709546773; x=1710151573;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVQqFC9D2KqJlxw+A6UHxs7gFanVhnkmzHqHRZSs/iE=;
 b=KrxowlEDfhPf/75KGLEA+Eim8j1dbMN8T3hykC6xn4mklRNBSFOmTfQkT+x4dTth9e
 skjoVN7oH4wfTycWo8fK7gp5HoWw9aVY3Gnyvu9YUkEww8rE1V2sMvvU1o1Rfn32D8ts
 uy8rLCRSFRNteu8+EWsjpaAvDl3wrltG0Qz+FzSxkKgWP6tSM6yJ3/mpmyfBufAKgoIq
 gi3DGMcySMnhfqefxCaTe/C5iMmejjpZFfKF66ULXE12DwT+1OigmlWqaWQ2Mk1H32Z2
 8pqSKQicQ965TYWTUt4de1f8FBDehJT9zd6V8HtTwzVcUhkXdFicQ+ZyPFXM8amCDuLL
 IOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546773; x=1710151573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVQqFC9D2KqJlxw+A6UHxs7gFanVhnkmzHqHRZSs/iE=;
 b=Up1h4873ECYcQC8GRSNc306+/vGGEE5tDoXa7qyiMUXWqC29BQqiC3dDSDwkcBpSnN
 aQ9pznmAee9Z8vOsOhJAn+x890ZCf7FheX0uAYtxvJfOCsb3tKEi2LBtOr1YDXDcPvlZ
 PMVwrdrtjrxt4Wdiyrhxp0YaurPnDWTn7M02Mg5kEPrMVYe7Lii+t9Jk6idgQVLvMopY
 /i9YVARm57o+6VxRXRQDmiz7hwQHAjq410pFaclAdTjbLbYviVoIq5oh2XtnS2voap4B
 c819q4T88qfoA2O/gfnihq4SflkshXbhj2NQeHHsE0FYNvtPciFfWgvGX7KnZSUqxO6F
 wn0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0cjt7dFaDUruoudTAzVSatXyLIVVavajJjGPaYRJHL4LnOg08yyhy8KA7Zs6htwuSjs5ysik+Ua3lrNHByllTJUiXkMY=
X-Gm-Message-State: AOJu0Yy3GAcc1DHDjFw657Tuogb6flkGtIK8TmeMQIWWKxJm1j/SV4fK
 58ojSiGuxKMG/ECnUD7M/mb5Y5ZsYPMRSFNGoWPUTvy+k1f4lztSYYzopfShovo=
X-Google-Smtp-Source: AGHT+IE3Vyv8Rh6+TEPY69pRZfA5wr/jcS6SYCq/G6FJGy62c8yTDdVdh/oDjk3Du1gttRtFkpzjIA==
X-Received: by 2002:a05:6a20:d48e:b0:1a0:fab6:41d0 with SMTP id
 im14-20020a056a20d48e00b001a0fab641d0mr10372763pzb.42.1709546773177; 
 Mon, 04 Mar 2024 02:06:13 -0800 (PST)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902e19200b001dc95e7e191sm8091570pla.298.2024.03.04.02.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:06:12 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 2/5] softmmu: Support concurrent bounce buffers
Date: Mon,  4 Mar 2024 02:05:51 -0800
Message-Id: <20240304100554.1143763-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304100554.1143763-1-mnissler@rivosinc.com>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/pci/pci.c                |  8 ++++
 include/exec/memory.h       | 14 +++----
 include/hw/pci/pci_device.h |  3 ++
 system/memory.c             |  5 ++-
 system/physmem.c            | 80 +++++++++++++++++++++++++------------
 5 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca..036b3ff822 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
+                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1203,6 +1205,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                        "bus master container", UINT64_MAX);
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
+    pci_dev->bus_master_as.max_bounce_buffer_size =
+        pci_dev->max_bounce_buffer_size;
 
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
@@ -2632,6 +2636,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+    object_class_property_set_description(
+        klass, "x-max-bounce-buffer-size",
+        "Maximum buffer size allocated for bounce buffers used for mapped "
+        "access to indirect DMA memory");
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0658846555..3fe0e2824c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1111,13 +1111,7 @@ typedef struct AddressSpaceMapClient {
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
@@ -1137,8 +1131,10 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Bounce buffer to use for this address space. */
-    BounceBuffer bounce;
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint64_t max_bounce_buffer_size;
+    /* Total size of bounce buffers currently allocated, atomically accessed */
+    uint64_t bounce_buffer_size;
     /* List of callbacks to invoke when buffers free up */
     QemuMutex map_client_list_lock;
     QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..f4027c5379 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -160,6 +160,9 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint64_t max_bounce_buffer_size;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/system/memory.c b/system/memory.c
index ad0caef1b8..1cf89654a1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3133,7 +3133,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
-    as->bounce.in_use = false;
+    as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;
+    as->bounce_buffer_size = 0;
     qemu_mutex_init(&as->map_client_list_lock);
     QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
@@ -3143,7 +3144,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
-    assert(!qatomic_read(&as->bounce.in_use));
+    assert(qatomic_read(&as->bounce_buffer_size) == 0);
     assert(QLIST_EMPTY(&as->map_client_list));
     qemu_mutex_destroy(&as->map_client_list_lock);
 
diff --git a/system/physmem.c b/system/physmem.c
index 2972b83ab0..5dcf4910cf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2971,6 +2971,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
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
@@ -2996,9 +3010,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     qemu_mutex_lock(&as->map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&as->map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
+    /* Write map_client_list before reading bounce_buffer_size. */
     smp_mb();
-    if (!qatomic_read(&as->bounce.in_use)) {
+    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
         address_space_notify_map_clients_locked(as);
     }
     qemu_mutex_unlock(&as->map_client_list_lock);
@@ -3128,28 +3142,38 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&as->bounce.in_use, true)) {
+        size_t size = qatomic_add_fetch(&as->bounce_buffer_size, l);
+        if (size > as->max_bounce_buffer_size) {
+            /*
+             * Note that the overshot might be larger than l if threads are
+             * racing and bump bounce_buffer_size at the same time.
+             */
+            size_t excess = MIN(size - as->max_bounce_buffer_size, l);
+            l -= excess;
+            qatomic_sub(&as->bounce_buffer_size, excess);
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
@@ -3164,12 +3188,11 @@ void *address_space_map(AddressSpace *as,
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
@@ -3179,15 +3202,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
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
2.34.1


