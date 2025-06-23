Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB82C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRt-00063r-L4; Mon, 23 Jun 2025 16:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRq-00063D-T3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRo-0003YV-9h
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TZkEPcKUD0IF2Ws/fLavANEe8cHL59ROo6m22DohYw=;
 b=RbkUstfi3Fo/A2Mo8LILuLDj48x+nQKBDIeyQc8MtBlCvbvGJ5hDPECAI0FM4xsj9O1N/d
 VRTET0NRFM7gO16nnfpuryG5ZlRVBzuaM8de8SoxBl8TfZ+snisNiOP79A2H71DAxYRGdb
 smQR5cyJp+xiapFAXIcRs2ozDbi4Lqk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-PAze08d5MLyDQ2nET_RuoQ-1; Mon, 23 Jun 2025 16:07:15 -0400
X-MC-Unique: PAze08d5MLyDQ2nET_RuoQ-1
X-Mimecast-MFC-AGG-ID: PAze08d5MLyDQ2nET_RuoQ_1750709235
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6faeebe9c5bso39565096d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709235; x=1751314035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TZkEPcKUD0IF2Ws/fLavANEe8cHL59ROo6m22DohYw=;
 b=aHfhajgFmS0Ai/rutBBCGuWpEZ4joiDMGkhIbeMKNS7+1/S/rvsfpKeyBTCXTd9snX
 iuCdtVvwy8ELt4fYCDDXQDdVk6hRBZqrhaP1zAl2UTB3iNA1VKo9wq1/G9g3JUJRRePD
 7V07joAzPbrRopIpKqeEZvQPkmcr2eTGw+/qcApt5JtzLQjomoTltiyw7KNFN1TR8bBX
 yXOa3G7qgI0hrpHkD1SjuguPDa9ZOPewwusOoE1Cfm0hw6LDtBM4qoq4exiv6q3M/asL
 /1qsg2xh3AVIhloR1Cc6Am4ddG7ht0r4GObrz9xkUxRu6ACuZpSS3NwI8hqb8xZVs3YE
 +bWg==
X-Gm-Message-State: AOJu0Yx3bl4rpMBQqZsevNs/7uhjE5x2VJEKIxijbVrORVJXwoTQmdHK
 Q2yh0OD9g+ZFboFV81umBe62edH2TwMq0dj8oCPVemcqCCqxO36xdj3LLuY2rCb/U4+NrAnzNaK
 je7pXxHKkm6cN2N/5I8sUNj1hlbtshzMZXOjP2QCmQNoBY7nEtTF8Efki/mwzFAd4UnOskjDOXa
 gF5vqUIANG5NpwvNw0BpiLI62n7xIN5kuzj6XX7g==
X-Gm-Gg: ASbGnctMagorayO6BTaqTXS3IXsBVxOh3NYs8VyBPd2h1ioYJinqsREJtpcGGc4TJSp
 1Y6R8iuzt1QGOlYi7LTGv2c5z6atDx+UIZg7YFjznefwqvakHBEJodqaOIePhUyl8eqEx+wC99l
 SF333VINpDStvO48RBGp0DAupoK8JdtISq/3L7pCQhFsGy+/R8j3rCSfvLLVEzTy8DzYbPon9dC
 SK0DRw7BSBqIsR4yhktUqvL01mqfvZfnAeD+GEhVWtICq28lERa4FEUxsl5pA/NXDOy9TrfVumD
 vRr4KhlfZdw=
X-Received: by 2002:a05:6214:e4a:b0:6fa:ccb6:6036 with SMTP id
 6a1803df08f44-6fd0a591efbmr225451886d6.35.1750709234574; 
 Mon, 23 Jun 2025 13:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3TN3WkHGTyhYJHWfv4+tN4GuJlRo6W5GEPVNknNlrNa2p3zvRp/ov9wjd3lJAl1/zV8HjTQ==
X-Received: by 2002:a05:6214:e4a:b0:6fa:ccb6:6036 with SMTP id
 6a1803df08f44-6fd0a591efbmr225450936d6.35.1750709233687; 
 Mon, 23 Jun 2025 13:07:13 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 10/11] ram-block-attributes: Introduce RamBlockAttributes to
 manage RAMBlock with guest_memfd
Date: Mon, 23 Jun 2025 16:06:55 -0400
Message-ID: <20250623200656.1882674-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
discard") highlighted that subsystems like VFIO may disable RAM block
discard. However, guest_memfd relies on discard operations for page
conversion between private and shared memory, potentially leading to
the stale IOMMU mapping issue when assigning hardware devices to
confidential VMs via shared memory. To address this and allow shared
device assignement, it is crucial to ensure the VFIO system refreshes
its IOMMU mappings.

RamDiscardManager is an existing interface (used by virtio-mem) to
adjust VFIO mappings in relation to VM page assignment. Effectively page
conversion is similar to hot-removing a page in one mode and adding it
back in the other. Therefore, similar actions are required for page
conversion events. Introduce the RamDiscardManager to guest_memfd to
facilitate this process.

Since guest_memfd is not an object, it cannot directly implement the
RamDiscardManager interface. Implementing it in HostMemoryBackend is
not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
have a memory backend while others do not. Notably, virtual BIOS
RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
backend.

To manage RAMBlocks with guest_memfd, define a new object named
RamBlockAttributes to implement the RamDiscardManager interface. This
object can store the guest_memfd information such as the bitmap for
shared memory and the registered listeners for event notifications. A
new state_change() helper function is provided to notify listeners, such
as VFIO, allowing VFIO to do dynamically DMA map and unmap for the shared
memory according to conversion events. Note that in the current context
of RamDiscardManager for guest_memfd, the shared state is analogous to
being populated, while the private state can be considered discarded for
simplicity. In the future, it would be more complicated if considering
more states like private/shared/discarded at the same time.

In current implementation, memory state tracking is performed at the
host page size granularity, as the minimum conversion size can be one
page per request. Additionally, VFIO expected the DMA mapping for a
specific IOVA to be mapped and unmapped with the same granularity.
Confidential VMs may perform partial conversions, such as conversions on
small regions within a larger one. To prevent such invalid cases and
until support for DMA mapping cut operations is available, all
operations are performed with 4K granularity.

In addition, memory conversion failures cause QEMU to quit rather than
resuming the guest or retrying the operation at present. It would be
future work to add more error handling or rollback mechanisms once
conversion failures are allowed. For example, in-place conversion of
guest_memfd could retry the unmap operation during the conversion from
shared to private. For now, keep the complex error handling out of the
picture as it is not required.

Tested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20250612082747.51539-5-chenyi.qiang@intel.com
[peterx: squash fixup from Chenyi to fix builds]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS                   |   1 +
 include/system/ramblock.h     |  21 ++
 system/ram-block-attributes.c | 444 ++++++++++++++++++++++++++++++++++
 system/meson.build            |   1 +
 system/trace-events           |   3 +
 5 files changed, 470 insertions(+)
 create mode 100644 system/ram-block-attributes.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c4076127..27f4fe3f25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3175,6 +3175,7 @@ F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
 F: system/memory-internal.h
+F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index d8a116ba99..1bab9e2dac 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -22,6 +22,10 @@
 #include "exec/cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
+#include "system/hostmem.h"
+
+#define TYPE_RAM_BLOCK_ATTRIBUTES "ram-block-attributes"
+OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttributes, RAM_BLOCK_ATTRIBUTES)
 
 struct RAMBlock {
     struct rcu_head rcu;
@@ -91,4 +95,21 @@ struct RAMBlock {
     ram_addr_t postcopy_length;
 };
 
+struct RamBlockAttributes {
+    Object parent;
+
+    RAMBlock *ram_block;
+
+    /* 1-setting of the bitmap represents ram is populated (shared) */
+    unsigned bitmap_size;
+    unsigned long *bitmap;
+
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
+};
+
+RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
+void ram_block_attributes_destroy(RamBlockAttributes *attr);
+int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
+                                      uint64_t size, bool to_discard);
+
 #endif
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
new file mode 100644
index 0000000000..68e8a02703
--- /dev/null
+++ b/system/ram-block-attributes.c
@@ -0,0 +1,444 @@
+/*
+ * QEMU ram block attributes
+ *
+ * Copyright Intel
+ *
+ * Author:
+ *      Chenyi Qiang <chenyi.qiang@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/ramblock.h"
+#include "trace.h"
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
+                                          ram_block_attributes,
+                                          RAM_BLOCK_ATTRIBUTES,
+                                          OBJECT,
+                                          { TYPE_RAM_DISCARD_MANAGER },
+                                          { })
+
+static size_t
+ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
+{
+    /*
+     * Because page conversion could be manipulated in the size of at least 4K
+     * or 4K aligned, Use the host page size as the granularity to track the
+     * memory attribute.
+     */
+    g_assert(attr && attr->ram_block);
+    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
+    return attr->ram_block->page_size;
+}
+
+
+static bool
+ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
+                                      const MemoryRegionSection *section)
+{
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const uint64_t first_bit = section->offset_within_region / block_size;
+    const uint64_t last_bit =
+        first_bit + int128_get64(section->size) / block_size - 1;
+    unsigned long first_discarded_bit;
+
+    first_discarded_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
+                                           first_bit);
+    return first_discarded_bit > last_bit;
+}
+
+typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
+                                               void *arg);
+
+static int
+ram_block_attributes_notify_populate_cb(MemoryRegionSection *section,
+                                        void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    return rdl->notify_populate(rdl, section);
+}
+
+static int
+ram_block_attributes_notify_discard_cb(MemoryRegionSection *section,
+                                       void *arg)
+{
+    RamDiscardListener *rdl = arg;
+
+    rdl->notify_discard(rdl, section);
+    return 0;
+}
+
+static int
+ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
+                                                MemoryRegionSection *section,
+                                                void *arg,
+                                                ram_block_attributes_section_cb cb)
+{
+    unsigned long first_bit, last_bit;
+    uint64_t offset, size;
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    int ret = 0;
+
+    first_bit = section->offset_within_region / block_size;
+    first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                              first_bit);
+
+    while (first_bit < attr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_bit * block_size;
+        last_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
+                                      first_bit + 1) - 1;
+        size = (last_bit - first_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            break;
+        }
+
+        first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                                  last_bit + 2);
+    }
+
+    return ret;
+}
+
+static int
+ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
+                                                MemoryRegionSection *section,
+                                                void *arg,
+                                                ram_block_attributes_section_cb cb)
+{
+    unsigned long first_bit, last_bit;
+    uint64_t offset, size;
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    int ret = 0;
+
+    first_bit = section->offset_within_region / block_size;
+    first_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
+                                   first_bit);
+
+    while (first_bit < attr->bitmap_size) {
+        MemoryRegionSection tmp = *section;
+
+        offset = first_bit * block_size;
+        last_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
+                                 first_bit + 1) - 1;
+        size = (last_bit - first_bit + 1) * block_size;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            break;
+        }
+
+        ret = cb(&tmp, arg);
+        if (ret) {
+            error_report("%s: Failed to notify RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            break;
+        }
+
+        first_bit = find_next_zero_bit(attr->bitmap,
+                                       attr->bitmap_size,
+                                       last_bit + 2);
+    }
+
+    return ret;
+}
+
+static uint64_t
+ram_block_attributes_rdm_get_min_granularity(const RamDiscardManager *rdm,
+                                             const MemoryRegion *mr)
+{
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+
+    g_assert(mr == attr->ram_block->mr);
+    return ram_block_attributes_get_block_size(attr);
+}
+
+static void
+ram_block_attributes_rdm_register_listener(RamDiscardManager *rdm,
+                                           RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    int ret;
+
+    g_assert(section->mr == attr->ram_block->mr);
+    rdl->section = memory_region_section_new_copy(section);
+
+    QLIST_INSERT_HEAD(&attr->rdl_list, rdl, next);
+
+    ret = ram_block_attributes_for_each_populated_section(attr, section, rdl,
+                                    ram_block_attributes_notify_populate_cb);
+    if (ret) {
+        error_report("%s: Failed to register RAM discard listener: %s",
+                     __func__, strerror(-ret));
+        exit(1);
+    }
+}
+
+static void
+ram_block_attributes_rdm_unregister_listener(RamDiscardManager *rdm,
+                                             RamDiscardListener *rdl)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    int ret;
+
+    g_assert(rdl->section);
+    g_assert(rdl->section->mr == attr->ram_block->mr);
+
+    if (rdl->double_discard_supported) {
+        rdl->notify_discard(rdl, rdl->section);
+    } else {
+        ret = ram_block_attributes_for_each_populated_section(attr,
+                rdl->section, rdl, ram_block_attributes_notify_discard_cb);
+        if (ret) {
+            error_report("%s: Failed to unregister RAM discard listener: %s",
+                         __func__, strerror(-ret));
+            exit(1);
+        }
+    }
+
+    memory_region_section_free_copy(rdl->section);
+    rdl->section = NULL;
+    QLIST_REMOVE(rdl, next);
+}
+
+typedef struct RamBlockAttributesReplayData {
+    ReplayRamDiscardState fn;
+    void *opaque;
+} RamBlockAttributesReplayData;
+
+static int ram_block_attributes_rdm_replay_cb(MemoryRegionSection *section,
+                                              void *arg)
+{
+    RamBlockAttributesReplayData *data = arg;
+
+    return data->fn(section, data->opaque);
+}
+
+static int
+ram_block_attributes_rdm_replay_populated(const RamDiscardManager *rdm,
+                                          MemoryRegionSection *section,
+                                          ReplayRamDiscardState replay_fn,
+                                          void *opaque)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == attr->ram_block->mr);
+    return ram_block_attributes_for_each_populated_section(attr, section, &data,
+                                            ram_block_attributes_rdm_replay_cb);
+}
+
+static int
+ram_block_attributes_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                          MemoryRegionSection *section,
+                                          ReplayRamDiscardState replay_fn,
+                                          void *opaque)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
+
+    g_assert(section->mr == attr->ram_block->mr);
+    return ram_block_attributes_for_each_discarded_section(attr, section, &data,
+                                            ram_block_attributes_rdm_replay_cb);
+}
+
+static bool
+ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
+                                    uint64_t size)
+{
+    MemoryRegion *mr = attr->ram_block->mr;
+
+    g_assert(mr);
+
+    uint64_t region_size = memory_region_size(mr);
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+
+    if (!QEMU_IS_ALIGNED(offset, block_size) ||
+        !QEMU_IS_ALIGNED(size, block_size)) {
+        return false;
+    }
+    if (offset + size <= offset) {
+        return false;
+    }
+    if (offset + size > region_size) {
+        return false;
+    }
+    return true;
+}
+
+static void ram_block_attributes_notify_discard(RamBlockAttributes *attr,
+                                                uint64_t offset,
+                                                uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        rdl->notify_discard(rdl, &tmp);
+    }
+}
+
+static int
+ram_block_attributes_notify_populate(RamBlockAttributes *attr,
+                                     uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        ret = rdl->notify_populate(rdl, &tmp);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+int ram_block_attributes_state_change(RamBlockAttributes *attr,
+                                      uint64_t offset, uint64_t size,
+                                      bool to_discard)
+{
+    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    const unsigned long last_bit = first_bit + nbits - 1;
+    const bool is_discarded = find_next_bit(attr->bitmap, attr->bitmap_size,
+                                            first_bit) > last_bit;
+    const bool is_populated = find_next_zero_bit(attr->bitmap,
+                                attr->bitmap_size, first_bit) > last_bit;
+    unsigned long bit;
+    int ret = 0;
+
+    if (!ram_block_attributes_is_valid_range(attr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%" PRIx64 ", size "
+                     "0x%" PRIx64, __func__, offset, size);
+        return -EINVAL;
+    }
+
+    trace_ram_block_attributes_state_change(offset, size,
+                                            is_discarded ? "discarded" :
+                                            is_populated ? "populated" :
+                                            "mixture",
+                                            to_discard ? "discarded" :
+                                            "populated");
+    if (to_discard) {
+        if (is_discarded) {
+            /* Already private */
+        } else if (is_populated) {
+            /* Completely shared */
+            bitmap_clear(attr->bitmap, first_bit, nbits);
+            ram_block_attributes_notify_discard(attr, offset, size);
+        } else {
+            /* Unexpected mixture: process individual blocks */
+            for (bit = first_bit; bit < first_bit + nbits; bit++) {
+                if (!test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                clear_bit(bit, attr->bitmap);
+                ram_block_attributes_notify_discard(attr, bit * block_size,
+                                                    block_size);
+            }
+        }
+    } else {
+        if (is_populated) {
+            /* Already shared */
+        } else if (is_discarded) {
+            /* Completely private */
+            bitmap_set(attr->bitmap, first_bit, nbits);
+            ret = ram_block_attributes_notify_populate(attr, offset, size);
+        } else {
+            /* Unexpected mixture: process individual blocks */
+            for (bit = first_bit; bit < first_bit + nbits; bit++) {
+                if (test_bit(bit, attr->bitmap)) {
+                    continue;
+                }
+                set_bit(bit, attr->bitmap);
+                ret = ram_block_attributes_notify_populate(attr,
+                                                           bit * block_size,
+                                                           block_size);
+                if (ret) {
+                    break;
+                }
+            }
+        }
+    }
+
+    return ret;
+}
+
+RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
+{
+    const int block_size  = qemu_real_host_page_size();
+    RamBlockAttributes *attr;
+    MemoryRegion *mr = ram_block->mr;
+
+    attr = RAM_BLOCK_ATTRIBUTES(object_new(TYPE_RAM_BLOCK_ATTRIBUTES));
+
+    attr->ram_block = ram_block;
+    if (memory_region_set_ram_discard_manager(mr, RAM_DISCARD_MANAGER(attr))) {
+        object_unref(OBJECT(attr));
+        return NULL;
+    }
+    attr->bitmap_size =
+        ROUND_UP(int128_get64(mr->size), block_size) / block_size;
+    attr->bitmap = bitmap_new(attr->bitmap_size);
+
+    return attr;
+}
+
+void ram_block_attributes_destroy(RamBlockAttributes *attr)
+{
+    g_assert(attr);
+
+    g_free(attr->bitmap);
+    memory_region_set_ram_discard_manager(attr->ram_block->mr, NULL);
+    object_unref(OBJECT(attr));
+}
+
+static void ram_block_attributes_init(Object *obj)
+{
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(obj);
+
+    QLIST_INIT(&attr->rdl_list);
+}
+
+static void ram_block_attributes_finalize(Object *obj)
+{
+}
+
+static void ram_block_attributes_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
+
+    rdmc->get_min_granularity = ram_block_attributes_rdm_get_min_granularity;
+    rdmc->register_listener = ram_block_attributes_rdm_register_listener;
+    rdmc->unregister_listener = ram_block_attributes_rdm_unregister_listener;
+    rdmc->is_populated = ram_block_attributes_rdm_is_populated;
+    rdmc->replay_populated = ram_block_attributes_rdm_replay_populated;
+    rdmc->replay_discarded = ram_block_attributes_rdm_replay_discarded;
+}
diff --git a/system/meson.build b/system/meson.build
index 7514bf3455..6d21ff9faa 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -17,6 +17,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'ioport.c',
+  'ram-block-attributes.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
diff --git a/system/trace-events b/system/trace-events
index be12ebfb41..82856e44f2 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -52,3 +52,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+# ram-block-attributes.c
+ram_block_attributes_state_change(uint64_t offset, uint64_t size, const char *from, const char *to) "offset 0x%"PRIx64" size 0x%"PRIx64" from '%s' to '%s'"
-- 
2.49.0


