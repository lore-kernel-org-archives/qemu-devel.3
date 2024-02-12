Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB1C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRL3-0000rF-Nu; Mon, 12 Feb 2024 03:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRL1-0000qG-S7
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:51 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRKy-00081G-B5
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso21016625ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707725206; x=1708330006;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhSeZ0By9G08zXnbI7Oa8c9OnIcfomhuD1o4c1kLREA=;
 b=XM+hkFUlz9NTm65HQmTEK/BmGWvLWSr0LNvUFTZod3G8eE+52BvCOZQzRLg9IEMA97
 Re/IUx/rzUIX8NlJJsC/StspYrBp09hanHEMRoFt1mhwzb2LGntmbLEbCoEn/lcsWSXG
 djXCf8vEaIGfToNGl7IOc3paQA0twqfxzKwz6xu5Bv44q4mUgbePq8ZM+qaYkfN7cAbg
 pcCs2IFQ04lk/A0FNQyWiWT4WTtK/FCKX5EmFCxZW84MwPpXAcnSE/WbtYh/kcvvsLEK
 aDx2U1KiSgk+T0YOAHYhQUFEl6cRiQxuKQ4lXGbR2J6aXE/RzMG5CZ+O6cRI68cgentM
 9gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725206; x=1708330006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhSeZ0By9G08zXnbI7Oa8c9OnIcfomhuD1o4c1kLREA=;
 b=sQYF2AlCtg+4b1gtP285Q3FjsRAJMgYLGGOHVapROts1oia5qr03mgmY5jSMpPPrQ4
 2wJF31R9qieEBgnFqAV5ZU60BaBkXWBOLTTg5P25jDcBvH8wbJ9b6aG32/XKq7Y2Pc1B
 IMv6+yJhBqlnBt8Oq7gEt2fDkF0AsSN7a7o9hzVqNTQeHbTr5iSMM4oMuAsxOL66HSzQ
 +IH1MbAQJHfPph8Q11x9/OeHZELF8QmzJJJZqGDbGweJJwp56LoTyCFDpR8jJATCs6GD
 JYAw9+OZjf3UflCLnQSVarH2M1QxZLY7wuNL3a06shIqgFFXJHD/LdwxhSGOkIosTj9j
 UdTw==
X-Gm-Message-State: AOJu0Yx4KoQ4Y5KT/B4FMXeZ3EP0zXMJ8iqBZm8aK0N5MhZAujughmUh
 MR3BEe6z3ThrEEHPpeOllIFJ6UhsaYnuFbVcpRvac4COQEnUnXiewBtVTWDaHMBK07XLlx+kYU0
 Rg+E=
X-Google-Smtp-Source: AGHT+IGFo2hz7BE4jJRxzJwBlf3GcS//XNxDV7ozimP4LA4bXuT4QBrlQ4BXqa1v/odCs3PdLgtuGQ==
X-Received: by 2002:a17:902:d505:b0:1da:3266:69bb with SMTP id
 b5-20020a170902d50500b001da326669bbmr1389816plg.60.1707725206119; 
 Mon, 12 Feb 2024 00:06:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVOaTus3hjaTTLmLw07fGZZmeBfWiE9+48GW2gQB/r/IMu7sgkpibsw8IAIRjsyIPfq31GwKXPHP7onL0UzkES2uW59vAMspTTOfKEAcx/FrQoqh4eeGv1AOCUgt+4GkLBkKA5A97muvKqnLBRw80zR3aUW9ET6PuzRRbumxUtgoF23eQ9/6g2EXqcwK/byiD5i5ShSTWN7OiBrHIAX3GJLGMO4L7gyM75+S9D+O03A+viGf4PBNFP7w3HkJ4LpXZxw3W88Krb2t9Xi7CIHI6d2+gRmHeYWwEKUV6uVTxt32PlLLpJLv+E/F09CP0aeDgTI5fWAhHM80/M2Wtd1Nlg0eDEcMnkm1xeb0BwdPDdaWt1CDgxA3lc9rQ8WfMeeOA==
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a17090330cd00b001d9fc53514esm5404649plc.66.2024.02.12.00.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 00:06:45 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org, jag.raman@oracle.com, peterx@redhat.com,
 stefanha@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v7 2/5] softmmu: Support concurrent bounce buffers
Date: Mon, 12 Feb 2024 00:06:14 -0800
Message-Id: <20240212080617.2559498-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212080617.2559498-1-mnissler@rivosinc.com>
References: <20240212080617.2559498-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x633.google.com
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
index 6995a443d3..e7bc4717ea 100644
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
index 7170e3473f..6a3c9de512 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2974,6 +2974,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
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
@@ -2999,9 +3013,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
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
@@ -3131,28 +3145,38 @@ void *address_space_map(AddressSpace *as,
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
@@ -3167,12 +3191,11 @@ void *address_space_map(AddressSpace *as,
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
@@ -3182,15 +3205,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
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


