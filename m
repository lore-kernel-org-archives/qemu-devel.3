Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC0ED3001B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pbR-0003nm-PO; Fri, 18 Oct 2024 12:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbP-0003ly-No
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:23 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbK-0004P2-KQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:22 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b1467af9dbso154627885a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1729267997; x=1729872797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg1P4kmuxtDkOe9Icy7EtGIDk1BBaBntSPvV2yBw5Vg=;
 b=P8YUQt0osLg50ZMDdyYJozJeqJdyGW6KWVuW8kUu4mmLYx6WPrbCeX+VRnZuv0yHHB
 kY39/7caafGJ+lMsbZ3TvZsGYgFYomdlpei0syt0e2PHGSeSz5/rFLqMfW7g3QPh5i2r
 i6TWZ4w4BwQovt+HOEvHY7Bus8kSVHthhm18t32tWfFyxdxCBcn/ZzOOSVDuG4Vu/JLU
 +5l0TOK6k3jTTQMF96Wjvt5TFMG9e9OTSlYR7b3SfkvdGDoBU5BEd8aQ0NDXX1QrdOQ4
 xVtgtSR4bSV3QSPvAujRz0piF3+W4rE+u+ZCD6cJDpmAzHHvB4hXHc21++R98wYwMjNV
 qCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729267997; x=1729872797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yg1P4kmuxtDkOe9Icy7EtGIDk1BBaBntSPvV2yBw5Vg=;
 b=BL/ox9MfhLkLUtosD7qPYe1EhlG2ApiMOOjKdXvHbJRf0C08tXtsrZy4ifJN+ww45F
 Lu4vQCJKeWLY5VUU/DPPssWD7KBdYp6d5sl+IdKIuVnNsx8SmBavEfZcEHSdUabR0VMr
 UFH8rve7YuB2sfS1TpI63MOCQn3arrEslfWY00mguv8N4Zkhe+8jz3IDHNQHEYK+zZw5
 ajv3uSx+1CaBV9kgutSKPBt6SmRm+ioelhj/v7Tpg3Q8Trzbf7i2fwLYA8yQsFMiin8w
 LL65eKx20gONR1nb/sR/WuITTWJWEaM1dF4LOnmq97TBaLCztcVSbQFzuyrAf2jsHKC2
 NzwQ==
X-Gm-Message-State: AOJu0YwfMeKsR5miskUHoQ8I16GNo+AWrSABxmLgE2na1wj+mGOlGgni
 sqWH6yZAIYNNNYRrsz00Aef2WnG6FnMKBg5s/3/AKSQOWic7xOY8uMsOzHu59pM=
X-Google-Smtp-Source: AGHT+IGikF7stO1WCXDYt/0EcUOjzFHMh+z2T+w/8SlImKWFClQj57CqBtAj2rgWTq3cnNRp87CkTA==
X-Received: by 2002:a05:620a:4007:b0:7ac:c359:f132 with SMTP id
 af79cd13be357-7b157b72801mr259516085a.26.1729267996520; 
 Fri, 18 Oct 2024 09:13:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 09:13:16 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, svetly.todorov@memverge.com,
 jonathan.cameron@huawei.com, nifan.cxl@gmail.com
Subject: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Date: Fri, 18 Oct 2024 12:12:52 -0400
Message-ID: <20241018161252.8896-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018161252.8896-1-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Svetly Todorov <svetly.todorov@memverge.com>

Using a shared-memory bytemap, validates that DC adds, releases,
and reclamations happen on extents belonging to the appropriate
host.

The MHSLD device inherits from the CXL_TYPE3 class and adds the following
configuration options:
--mhd-head=<u32>
--mhd-state_file=<str>
--mhd-init=<bool>

--mhd-head specifies the head ID of the host on the given device.

--mhd-state_file is the name of the shared-memory-backed file used
to store the MHD state.

--mhd-init indicates whether this QEMU instance should initialize
the state_file; if so, the instance will create the file if it does
not exist, ftruncate it to the appropriate size, and initialize its
header. It is assumed that the --mhd-init instance is run and allowed
to completely finish configuration before any other guests access the
shared state.

The shared state file only needs to be intialized once. Even if a guest
dies without clearing the ownership bits associated with its head-ID,
future guests with that ID will clear those bits in cxl_mhsld_realize(),
regardless of whether mhd_init is true or false.

The following command line options create an MHSLD with 4GB of
backing memory, whose state is tracked in /dev/shm/mhd_metadata.
--mhd-init=true tells this instance to initialize the state as
described above.

./qemu-system_x86-64 \
[... other options ...] \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
-qmp unix:/tmp/qmp-sock-1,server,nowait

Once this guest completes setup, other guests looking to access the
device can be booted with the same configuration options, but with
--mhd-head != 0,
--mhd-init=false,
and a different QMP socket.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
---
 hw/cxl/Kconfig           |   1 +
 hw/cxl/meson.build       |   1 +
 hw/cxl/mhsld/Kconfig     |   4 +
 hw/cxl/mhsld/meson.build |   3 +
 hw/cxl/mhsld/mhsld.c     | 456 +++++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h     |  75 +++++++
 6 files changed, 540 insertions(+)
 create mode 100644 hw/cxl/mhsld/Kconfig
 create mode 100644 hw/cxl/mhsld/meson.build
 create mode 100644 hw/cxl/mhsld/mhsld.c
 create mode 100644 hw/cxl/mhsld/mhsld.h

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index e603839a62..919e59b598 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,4 @@
+source mhsld/Kconfig
 source vendor/Kconfig
 
 config CXL
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e8c8c1355a..394750dd19 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -16,4 +16,5 @@ system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
 
+subdir('mhsld')
 subdir('vendor')
diff --git a/hw/cxl/mhsld/Kconfig b/hw/cxl/mhsld/Kconfig
new file mode 100644
index 0000000000..dc2be15140
--- /dev/null
+++ b/hw/cxl/mhsld/Kconfig
@@ -0,0 +1,4 @@
+config CXL_MHSLD
+    bool
+    depends on CXL_MEM_DEVICE
+    default y
diff --git a/hw/cxl/mhsld/meson.build b/hw/cxl/mhsld/meson.build
new file mode 100644
index 0000000000..c595558f8a
--- /dev/null
+++ b/hw/cxl/mhsld/meson.build
@@ -0,0 +1,3 @@
+if host_os == 'linux'
+	system_ss.add(when: 'CONFIG_CXL_MHSLD', if_true: files('mhsld.c',))
+endif
diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
new file mode 100644
index 0000000000..2a3023607e
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.c
@@ -0,0 +1,456 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#include <sys/file.h>
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/hostmem.h"
+#include "mhsld.h"
+
+#define TYPE_CXL_MHSLD "cxl-mhsld"
+OBJECT_DECLARE_TYPE(CXLMHSLDState, CXLMHSLDClass, CXL_MHSLD)
+
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ *
+ * This command retrieves the number of heads, number of supported LDs,
+ * and Head-to-LD mapping of a Multi-Headed device.
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI * cci)
+{
+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
+    MHDGetInfoInput *input = (void *)payload_in;
+    MHDGetInfoOutput *output = (void *)payload_out;
+
+    uint8_t start_ld = input->start_ld;
+    uint8_t ldmap_len = input->ldmap_len;
+    uint8_t i;
+
+    if (start_ld >= s->mhd_state->nr_lds) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_lds = s->mhd_state->nr_lds;
+    output->nr_heads = s->mhd_state->nr_heads;
+    output->resv1 = 0;
+    output->start_ld = start_ld;
+    output->resv2 = 0;
+
+    for (i = 0; i < ldmap_len && (start_ld + i) < output->nr_lds; i++) {
+        output->ldmap[i] = s->mhd_state->ldmap[start_ld + i];
+    }
+    output->ldmap_len = i;
+
+    *len_out = sizeof(*output) + output->ldmap_len;
+    return CXL_MBOX_SUCCESS;
+}
+
+static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
+    [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
+};
+
+static Property cxl_mhsld_props[] = {
+    DEFINE_PROP_UINT32("mhd-head", CXLMHSLDState, mhd_head, ~(0)),
+    DEFINE_PROP_STRING("mhd-state_file", CXLMHSLDState, mhd_state_file),
+    DEFINE_PROP_BOOL("mhd-init", CXLMHSLDState, mhd_init, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static int cxl_mhsld_state_open(const char *filename, int flags)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_open(name, flags, 0666);
+}
+
+static int cxl_mhsld_state_unlink(const char *filename)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_unlink(name);
+}
+
+static int cxl_mhsld_state_create(const char *filename, size_t size)
+{
+    int fd, rc;
+
+    fd = cxl_mhsld_state_open(filename, O_RDWR | O_CREAT);
+    if (fd == -1) {
+        return -1;
+    }
+
+    rc = ftruncate(fd, size);
+
+    if (rc) {
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static bool cxl_mhsld_state_set(CXLMHSLDState *s, size_t block_start,
+                                size_t block_count)
+{
+    uint8_t prev, val, *block;
+    size_t i;
+
+    val = (1 << s->mhd_head);
+
+    /*
+     * Try to claim all extents from start -> start + count;
+     * break early if a claimed extent is encountered
+     */
+    for (i = 0; i < block_count; ++i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        prev = __sync_val_compare_and_swap(block, 0, val);
+        if (prev != 0) {
+            break;
+        }
+    }
+
+    if (prev == 0) {
+        return true;
+    }
+
+    /* Roll back incomplete claims */
+    for (;; --i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        __sync_fetch_and_and(block, ~(1u << s->mhd_head));
+        if (i == 0) {
+            break;
+        }
+    }
+
+    return false;
+}
+
+static void cxl_mhsld_state_clear(CXLMHSLDState *s, size_t block_start,
+                                  size_t block_count)
+{
+    size_t i;
+    uint8_t *block;
+
+    for (i = 0; i < block_count; ++i) {
+        block = &s->mhd_state->blocks[block_start + i];
+        __sync_fetch_and_and(block, ~(1u << s->mhd_head));
+    }
+}
+
+static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
+{
+    if (!s->mhd_init) {
+        cxl_mhsld_state_clear(s, 0, dc_size / MHSLD_BLOCK_SZ);
+        return;
+    }
+
+    memset(s->mhd_state, 0, s->mhd_state_size);
+    s->mhd_state->nr_heads = MHSLD_HEADS;
+    s->mhd_state->nr_lds = MHSLD_HEADS;
+    s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
+}
+
+/* Returns starting index of region in MHD map. */
+static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
+                                                    CXLDCRegion *r)
+{
+    CXLType3Dev *dcd = CXL_TYPE3(d);
+    size_t start = 0;
+    uint8_t rid;
+
+    for (rid = 0; rid < dcd->dc.num_regions; ++rid) {
+        if (&dcd->dc.regions[rid] == r) {
+            break;
+        }
+        start += dcd->dc.regions[rid].len / dcd->dc.regions[rid].block_size;
+    }
+
+    return start;
+}
+
+static MHSLDSharedState *cxl_mhsld_state_map(CXLMHSLDState *s)
+{
+    void *map;
+    size_t size = s->mhd_state_size;
+    int fd = s->mhd_state_fd;
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (map == MAP_FAILED) {
+        return NULL;
+    }
+
+    return (MHSLDSharedState *)map;
+}
+
+/*
+ * Triggered during an add_capacity command to a CXL device:
+ * takes a list of extent records and preallocates them,
+ * in anticipation of a "dcd accept" response from the host.
+ *
+ * Extents that are not accepted by the host will be rolled
+ * back later.
+ */
+static bool cxl_mhsld_reserve_extents(PCIDevice *d,
+                                      CxlDynamicCapacityExtentList *records,
+                                      uint8_t rid)
+{
+    uint64_t len, dpa;
+    bool rc;
+
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CxlDynamicCapacityExtentList *list = records, *rollback = NULL;
+
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLDCRegion *region = &ct3d->dc.regions[rid];
+
+    for (; list; list = list->next) {
+        len = list->value->len / MHSLD_BLOCK_SZ;
+        dpa = (list->value->offset + region->base) / MHSLD_BLOCK_SZ;
+
+        rc = cxl_mhsld_state_set(s, dpa, len);
+
+        if (!rc) {
+            rollback = records;
+            break;
+        }
+    }
+
+    /* Setting the mhd state failed. Roll back the extents that were added */
+    for (; rollback; rollback = rollback->next) {
+        len = rollback->value->len / MHSLD_BLOCK_SZ;
+        dpa = (list->value->offset + region->base) / MHSLD_BLOCK_SZ;
+
+        cxl_mhsld_state_clear(s, dpa, len);
+
+        if (rollback == list) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool cxl_mhsld_reclaim_extents(PCIDevice *d,
+                                      CXLDCExtentGroupList *ext_groups,
+                                      CXLUpdateDCExtentListInPl *in)
+{
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLDCExtentGroup *ext_group = QTAILQ_FIRST(ext_groups);
+    CXLDCExtent *ent;
+    CXLDCRegion *region;
+    g_autofree unsigned long *blk_bitmap = NULL;
+    uint64_t dpa, off, len, size, i;
+
+    /* Get the DCD region via the first requested extent */
+    ent = QTAILQ_FIRST(&ext_group->list);
+    dpa = ent->start_dpa;
+    len = ent->len;
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    size = region->len / MHSLD_BLOCK_SZ;
+    blk_bitmap = bitmap_new(size);
+
+    /* Set all requested extents to 1 in a bitmap */
+    QTAILQ_FOREACH(ent, &ext_group->list, node) {
+        off = ent->start_dpa - region->base;
+        len = ent->len;
+        bitmap_set(blk_bitmap, off / MHSLD_BLOCK_SZ, len / MHSLD_BLOCK_SZ);
+    }
+
+    /* Clear bits associated with accepted extents */
+    for (i = 0; i < in->num_entries_updated; i++) {
+        off = in->updated_entries[i].start_dpa - region->base;
+        len = in->updated_entries[i].len;
+        bitmap_clear(blk_bitmap, off / MHSLD_BLOCK_SZ, len / MHSLD_BLOCK_SZ);
+    }
+
+    /*
+     * Reclaim only the extents that belong to unaccepted extents,
+     * i.e. those whose bits are still raised in blk_bitmap
+     */
+    for (off = find_first_bit(blk_bitmap, size); off < size;) {
+        len = find_next_zero_bit(blk_bitmap, size, off) - off;
+        cxl_mhsld_state_clear(s, off, len);
+        off = find_next_bit(blk_bitmap, size, off + len);
+    }
+
+    return true;
+}
+
+static bool cxl_mhsld_release_extent(PCIDevice *d, uint64_t dpa, uint64_t len)
+{
+    cxl_mhsld_state_clear(CXL_MHSLD(d), dpa / MHSLD_BLOCK_SZ,
+        len / MHSLD_BLOCK_SZ);
+    return true;
+}
+
+static bool cxl_mhsld_access_valid(PCIDevice *d, uint64_t addr,
+                                   unsigned int size)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLMHSLDState *s = CXL_MHSLD(d);
+    CXLDCRegion *r = cxl_find_dc_region(ct3d, addr, size);
+    size_t i;
+
+    addr = addr / r->block_size;
+    size = size / r->block_size;
+
+    for (i = 0; i < size; ++i) {
+        if (s->mhd_state->blocks[addr + i] != (1 << s->mhd_head)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+    MemoryRegion *mr;
+    int fd = -1;
+    size_t dc_size;
+
+    ct3_realize(pci_dev, errp);
+
+    /* Get number of blocks from dcd size */
+    mr = host_memory_backend_get_memory(s->ct3d.dc.host_dc);
+    if (!mr) {
+        return;
+    }
+    dc_size = memory_region_size(mr);
+    if (!dc_size) {
+        error_setg(errp, "MHSLD does not have dynamic capacity to manage");
+        return;
+    }
+
+    s->mhd_state_size = (dc_size / MHSLD_BLOCK_SZ) + sizeof(MHSLDSharedState);
+
+    /* Sanity check the head idx */
+    if (s->mhd_head >= MHSLD_HEADS) {
+        error_setg(errp, "MHD Head ID must be between 0-7");
+        return;
+    }
+
+    /* Create the state file if this is the 'mhd_init' instance */
+    if (s->mhd_init) {
+        fd = cxl_mhsld_state_create(s->mhd_state_file, s->mhd_state_size);
+    } else {
+        fd = cxl_mhsld_state_open(s->mhd_state_file, O_RDWR);
+    }
+
+    if (fd < 0) {
+        error_setg(errp, "failed to open mhsld state errno %d", errno);
+        return;
+    }
+
+    s->mhd_state_fd = fd;
+
+    /* Map the state and initialize it as needed */
+    s->mhd_state = cxl_mhsld_state_map(s);
+    if (!s->mhd_state) {
+        error_setg(errp, "Failed to mmap mhd state file");
+        close(fd);
+        cxl_mhsld_state_unlink(s->mhd_state_file);
+        return;
+    }
+
+    cxl_mhsld_state_initialize(s, dc_size);
+
+    /* Set the LD ownership for this head to this system */
+    s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
+    return;
+}
+
+
+static void cxl_mhsld_exit(PCIDevice *pci_dev)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+
+    ct3_exit(pci_dev);
+
+    if (s->mhd_state_fd) {
+        munmap(s->mhd_state, s->mhd_state_size);
+        close(s->mhd_state_fd);
+        cxl_mhsld_state_unlink(s->mhd_state_file);
+        s->mhd_state = NULL;
+    }
+}
+
+static void cxl_mhsld_reset(DeviceState *d)
+{
+    CXLMHSLDState *s = CXL_MHSLD(d);
+
+    ct3d_reset(d);
+    cxl_add_cci_commands(&s->ct3d.cci, cxl_cmd_set_mhsld, 512);
+
+    cxl_mhsld_state_clear(s, 0, s->mhd_state->nr_blocks);
+}
+
+/*
+ * Example: DCD-add events need to validate that the requested extent
+ *          does not already have a mapping (or, if it does, it is
+ *          a shared extent with the right tagging).
+ *
+ * Since this operates on the shared state, we will need to serialize
+ * these callbacks across QEMU instances via a mutex in shared state.
+ */
+
+static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = cxl_mhsld_realize;
+    pc->exit = cxl_mhsld_exit;
+    device_class_set_legacy_reset(dc, cxl_mhsld_reset);
+    device_class_set_props(dc, cxl_mhsld_props);
+
+    CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
+    cvc->mhd_get_info = cmd_mhd_get_info;
+    cvc->mhd_access_valid = cxl_mhsld_access_valid;
+    cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
+    cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
+    cvc->mhd_release_extent = cxl_mhsld_release_extent;
+}
+
+static const TypeInfo cxl_mhsld_info = {
+    .name = TYPE_CXL_MHSLD,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLMHSLDClass),
+    .class_init = cxl_mhsld_class_init,
+    .instance_size = sizeof(CXLMHSLDState),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_mhsld_register_types(void)
+{
+    type_register_static(&cxl_mhsld_info);
+}
+
+type_init(cxl_mhsld_register_types)
diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
new file mode 100644
index 0000000000..e7ead1f0d2
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.h
@@ -0,0 +1,75 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#ifndef CXL_MHSLD_H
+#define CXL_MHSLD_H
+#include <stdint.h>
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "qemu/units.h"
+
+#define MHSLD_BLOCK_SZ (2 * MiB)
+
+/*
+ * We limit the number of heads to prevent the shared state
+ * region from becoming a major memory hog.  We need 512MB of
+ * memory space to track 8-host ownership of 4GB of memory in
+ * blocks of 2MB.  This can change if the block size is increased.
+ */
+#define MHSLD_HEADS  (8)
+
+/*
+ * The shared state cannot have 2 variable sized regions
+ * so we have to max out the ldmap.
+ */
+typedef struct MHSLDSharedState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[MHSLD_HEADS];
+    uint64_t nr_blocks;
+    uint8_t blocks[];
+} MHSLDSharedState;
+
+struct CXLMHSLDState {
+    CXLType3Dev ct3d;
+    bool mhd_init;
+    char *mhd_state_file;
+    int mhd_state_fd;
+    size_t mhd_state_size;
+    uint32_t mhd_head;
+    MHSLDSharedState *mhd_state;
+};
+
+struct CXLMHSLDClass {
+    CXLType3Class parent_class;
+};
+
+enum {
+    MHSLD_MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+};
+
+/*
+ * MHD Get Info Command
+ * Returns information the LD's associated with this head
+ */
+typedef struct MHDGetInfoInput {
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+} QEMU_PACKED MHDGetInfoInput;
+
+typedef struct MHDGetInfoOutput {
+    uint8_t nr_lds;
+    uint8_t nr_heads;
+    uint16_t resv1;
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+    uint16_t resv2;
+    uint8_t ldmap[];
+} QEMU_PACKED MHDGetInfoOutput;
+#endif
-- 
2.43.0


