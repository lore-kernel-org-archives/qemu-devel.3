Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E66C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropck-000129-Gj; Mon, 25 Mar 2024 15:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcj-00011x-6K
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcg-0004oH-LW
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so4035286b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393481; x=1711998281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=layG55zMLafcTRE8xI6SUYzjqXvFAco9vucbohotDjM=;
 b=lwA2Gw+khEiSWdBuckbvhj19l0SEtDXSS34o+IZ8bf9n5e4daEniQ5ewuNowUbpkej
 gxAadovJSy2MWVxWPXgOCc7wimpD2U5mlUCUkeEhOsW7DSEOWpRNoLvlHchHPpoIV76y
 Z2YDa7JlG+CY99CkuSpdu/mfM3mPB0wAuZFjuChxckKfsFaZghNUemweO6rzj1cOz9/F
 sDYmSfx9L8wqv123iDhQbkfF/xKooTSIzKPhYh0pxM8vNPvARToXUzm9F5XccAAwPWF9
 26HfpQK7ufk+yaC6E0dMCWHqH9GQ1qnQ3XUDuqH+Ng5ZkL/o7EMTfvKOVxtR3LaD0UaT
 OIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393481; x=1711998281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=layG55zMLafcTRE8xI6SUYzjqXvFAco9vucbohotDjM=;
 b=IoTNuD1FyY4+IniIIBGyn1OBQydimCqYNz4+Gp17h46pPBFYncz4T7ivC82sxSTMCG
 uvktvo4uStr12YLKCi+nrwLSacOGN5rL4x3aTNJGjm6TtV6DbdYNvEqzlN3Q+GqCCZgD
 Fu89BqXkuO1GLznomVuV4wkeWO7HK/1VlKzKZa2eYjcpSCe+hqXG5EHX9MfTlwcJ9sxo
 f6dZKT76QDrRVy4WvUslhBDYUtdM7W2DRv3K8odpGu0Ljwr1DhrcDbM9IbiJLOScff7d
 s9mpX8YvyLg1ROIBuaxAWprKIm+blf5imUjUnReYixo/Jpe/mZwGMYVSWxVXakrJglO9
 oS5g==
X-Gm-Message-State: AOJu0YyD2HSAMqFbcTptNBON3RWs+SaXM4Qxxj2v+PsB5nKFBAAgnLyd
 w47Et3N4AkgVjBtMH0KRlHfCJ+ADHnLgI2IfBOSBiyW7hFpq60lbMuDC43WX
X-Google-Smtp-Source: AGHT+IHqI/jkK13CGXjf0792if5gMi5R2PUQeOfpcRtt/QLX60yi7AFNl7zJT1bkkf2Z+edMOihMNA==
X-Received: by 2002:a05:6a20:c503:b0:1a3:72b5:528 with SMTP id
 gm3-20020a056a20c50300b001a372b50528mr6913095pzb.36.1711393481007; 
 Mon, 25 Mar 2024 12:04:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:04:40 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 06/12] hw/mem/cxl_type3: Add host backend and address space
 handling for DC regions
Date: Mon, 25 Mar 2024 12:02:24 -0700
Message-ID: <20240325190339.696686-7-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Add (file/memory backed) host backend, all the dynamic capacity regions
will share a single, large enough host backend. Set up address space for
DC regions to support read/write operations to dynamic capacity for DCD.

With the change, following supports are added:
1. Add a new property to type3 device "volatile-dc-memdev" to point to host
   memory backend for dynamic capacity. Currently, all dc regions share one
   host backend.
2. Add namespace for dynamic capacity for read/write support;
3. Create cdat entries for each dynamic capacity region;

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++-
 hw/mem/cxl_type3.c          | 187 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   8 ++
 3 files changed, 172 insertions(+), 39 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0f2ad58a14..831cef0567 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -622,7 +622,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t *len_out,
                                                CXLCCI *cci)
 {
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -636,7 +637,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -793,7 +795,8 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -835,9 +838,11 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -1179,7 +1184,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size +
+        ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a9e8bdc436..75ea9b20e1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -45,7 +45,8 @@ enum {
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
                                           int dsmad_handle, uint64_t size,
-                                          bool is_pmem, uint64_t dpa_base)
+                                          bool is_pmem, bool is_dynamic,
+                                          uint64_t dpa_base)
 {
     CDATDsmas *dsmas;
     CDATDslbis *dslbis0;
@@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
+                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
         .DPA_base = dpa_base,
         .DPA_length = size,
     };
@@ -149,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    MemoryRegion *dc_mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
 
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
 
@@ -176,21 +179,54 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         pmr_size = memory_region_size(nonvolatile_mr);
     }
 
+    if (ct3d->dc.num_regions) {
+        if (!ct3d->dc.host_dc) {
+            return -EINVAL;
+        }
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+    }
+
     table = g_malloc0(len * sizeof(*table));
 
     /* Now fill them in */
     if (volatile_mr) {
         ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
-                                      false, 0);
+                                      false, false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
         uint64_t base = vmr_size;
         ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                      pmr_size, true, base);
+                                      pmr_size, true, false, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        int i;
+        uint64_t region_base = vmr_size + pmr_size;
+
+        /*
+         * TODO: we assume the dynamic capacity to be volatile for now,
+         * non-volatile dynamic capacity will be added if needed in the
+         * future.
+         */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
+                                          dsmad_handle++,
+                                          ct3d->dc.regions[i].len,
+                                          false, true, region_base);
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -300,11 +336,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_hi = ct3d->hostpmem->size >> 32;
             range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
+        } else if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi = ct3d->hostpmem->size >> 32;
         range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+        if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi = ct3d->dc.host_dc->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (ct3d->dc.host_dc->size & 0xF0000000);
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -579,11 +628,27 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 {
     int i;
     uint64_t region_base = 0;
-    uint64_t region_len =  2 * GiB;
-    uint64_t decode_len = 2 * GiB;
+    uint64_t region_len;
+    uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
     CXLDCRegion *region;
     MemoryRegion *mr;
+    uint64_t dc_size;
+
+    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+    dc_size = memory_region_size(mr);
+    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
+
+    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
+        error_setg(errp, "host backend size must be multiples of region len");
+        return false;
+    }
+    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region size is unaligned to %lx",
+                   CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
+    decode_len = region_len;
 
     if (ct3d->hostvmem) {
         mr = host_memory_backend_get_memory(ct3d->hostvmem);
@@ -606,6 +671,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
         };
+        ct3d->dc.total_capacity += region->len;
     }
 
     return true;
@@ -615,7 +681,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+        && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -679,9 +746,41 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
-    if (!cxl_create_dc_regions(ct3d, errp)) {
-        error_setg(errp, "setup DC regions failed");
-        return false;
+    ct3d->dc.total_capacity = 0;
+    if (ct3d->dc.num_regions) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+
+        if (!ct3d->dc.host_dc) {
+            error_setg(errp, "dynamic capacity must have a backing device");
+            return false;
+        }
+
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have a backing device");
+            return false;
+        }
+
+        /*
+         * TODO: set dc as volatile for now, non-volatile support can be added
+         * in the future if needed.
+         */
+        memory_region_set_nonvolatile(dc_mr, false);
+        memory_region_set_enabled(dc_mr, true);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+        if (ds->id) {
+            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+        } else {
+            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+        }
+        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+        g_free(dc_name);
+
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_setg(errp, "setup DC regions failed");
+            return false;
+        }
     }
 
     return true;
@@ -773,6 +872,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -791,6 +893,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -869,16 +974,23 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(dc_mr);
     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
 
@@ -886,19 +998,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
+    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-    if (vmr) {
-        if (*dpa_offset < memory_region_size(vmr)) {
-            *as = &ct3d->hostvmem_as;
-        } else {
-            *as = &ct3d->hostpmem_as;
-            *dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (*dpa_offset < vmr_size) {
+        *as = &ct3d->hostvmem_as;
+    } else if (*dpa_offset < vmr_size + pmr_size) {
         *as = &ct3d->hostpmem_as;
+        *dpa_offset -= vmr_size;
+    } else {
+        *as = &ct3d->dc.host_dc_as;
+        *dpa_offset -= (vmr_size + pmr_size);
     }
 
     return 0;
@@ -980,6 +1091,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1046,33 +1159,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
     AddressSpace *as;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
     }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(dc_mr);
+     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
         return false;
     }
 
-    if (vmr) {
-        if (dpa_offset < memory_region_size(vmr)) {
-            as = &ct3d->hostvmem_as;
-        } else {
-            as = &ct3d->hostpmem_as;
-            dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (dpa_offset < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_offset < vmr_size + pmr_size) {
         as = &ct3d->hostpmem_as;
+        dpa_offset -= vmr_size;
+    } else {
+        as = &ct3d->dc.host_dc_as;
+        dpa_offset -= (vmr_size + pmr_size);
     }
 
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index f7f56b44e3..c2c3df0d2a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -467,6 +467,14 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
 
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        /*
+         * total_capacity is equivalent to the dynamic capability
+         * memory region size.
+         */
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
-- 
2.43.0


