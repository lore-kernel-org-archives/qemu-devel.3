Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19F606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UlPK6VtX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaH7-00082z-Sa; Tue, 27 Oct 2026 02:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Vj7gagoKCrEjkRecVpaYlXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG3-0007pe-NI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:06 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Vj7gagoKCrEjkRecVpaYlXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG0-00067x-Vg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:03 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-8a01ea9e318so5378171b3a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080919; x=1793685719; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BFY+bA0qsHUbVR6vyGfTOqdgqE3nwT9nGY9B/UCmqYY=;
 b=UlPK6VtXReqCJPfQTQ3UeJWB3LqcKsw6czr/rZPGf+eCbIIXlXpHOF8IsfVJ4l+cLC
 7xk5JdXri/xfEyzZovu8Mi/dRhjAzSvU1WyBUFVkSiPj8c8x7CF210w46PInC2U30D0j
 Wm9P9bbBQoeOfN+cqR5MJMCIciDnyHWSC+hDkEPVyuWs942QfaLJox267iLFC+iHjLie
 5u76mcXPdeQlHiqTkAEHsletSYRa0FbxocYRwPzs9rhVAzPdeofaO5mB8zlRZnP7NHDb
 ttbkAvMbnlyryALAgR1A6Zore251l3g9Y/Gk7sj6YPl43jzhQ/tSZl6IXd/puD3pDkWY
 C29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080919; x=1793685719;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BFY+bA0qsHUbVR6vyGfTOqdgqE3nwT9nGY9B/UCmqYY=;
 b=AXSpNenOVqj8KluNezn/KsGprplVs99/YRHs2BB4j9icW63fwpRiq9Hm5TsaUT81XD
 9e/egSZxC2jPJI+Lo6srkX+yfNcyDmcDL2YC0CzFcpN6BGOWrG9cCTFsyNEh1kQX7u+d
 MwJLpoBHk9bcsz28aEYlNAZsGKrU5KWDylR32R/K0GsPcLcvRAYd+HkwCJ1tDFkCgbJP
 6wyT/ZmUhMFU2Uavoiz1NhtugmA8SFwNlyuq838TegvBsy8uavckAUbADv4ifHGMRU3F
 hTouqhDiXH28VdGyhL9YiosxEyt/7VK+a2RhK5+bdy8M9XF4ypmH6stWyR7uB2d4R9oQ
 7BhA==
X-Gm-Message-State: AFq9FYIM32t8p5HI8qv1rG+uT+lYpyCkySZMUhEz35BDYgpoq4owvzb5
 3DwUQJ5WGd9BkNz+wHxt4Ujtsptc7eiuG/BWxZ7IreqhXAkvnkZnrDyqcKGqNcZ+pe54Yln0O8B
 H5pMa/U5CqFb04Zhqj5WBdg==
X-Received: from pfbcb8.prod.google.com ([2002:a05:6a00:4308:b0:8a0:8d65:ebfc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12d6:b0:89f:7ac5:9d4f with SMTP id
 d2e1a72fcca58-8a364e5d92dmr7137893b3a.2.1793080918670; 
 Mon, 26 Oct 2026 23:01:58 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:47 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-3-stanleyjhu@google.com>
Subject: [PATCH 2/7] hw/ufs: Add RPMB unit descriptor and SECURITY PROTOCOL
 IN/OUT dispatch
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3Vj7gagoKCrEjkRecVpaYlXffXcV.TfdhVdl-UVmVcefeXel.fiX@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UFS device model creates the RPMB well-known logical unit (W-LUN
0xc4), but leaves bLUEnable set to 0 in RpmbUnitDescriptor, leaves
bSecurityLU set to 0 in DeviceDescriptor, and rejects SECURITY PROTOCOL
IN and SECURITY PROTOCOL OUT commands with ILLEGAL REQUEST.

Set bSecurityLU to 0x01 in DeviceDescriptor (JESD220H Table 14.4),
enable four 4 MiB RPMB regions (32 * 128 KiB each, 256-byte logical
blocks) in RpmbUnitDescriptor, and populate the big-endian block count
fields during unit descriptor reads using shared UFS_RPMB_* geometry
constants. Add per-region state in UfsHc with an embedded Result
Register frame, wire SECURITY PROTOCOL IN and SECURITY PROTOCOL OUT CDB
validation, PRDT buffer capacity validation via ufs_fit_data_buffer(),
and Result Read (0x0005) handling in hw/ufs/rpmb.c per JESD220H Section
12.4.6.1, and clear volatile RPMB state in ufs_hce_reset(). Requests
not yet implemented return UFS_RPMB_RES_GENERAL_FAILURE (0x0001).

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/lu.c         |  34 +++++++++
 hw/ufs/meson.build  |   2 +-
 hw/ufs/rpmb.c       | 170 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/trace-events |   3 +
 hw/ufs/ufs.c        |  21 +++++-
 hw/ufs/ufs.h        |  24 +++++++
 6 files changed, 250 insertions(+), 4 deletions(-)
 create mode 100644 hw/ufs/rpmb.c

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 4fe1247547..0e99ec5f7b 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -1137,6 +1137,40 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
                                    true);
         scsi_status = GOOD;
         break;
+    case SECURITY_PROTOCOL_IN:
+        if (lun == UFS_UPIU_RPMB_WLUN) {
+            uint32_t transferred_len = 0;
+            UfsReqResult ret;
+
+            ret = ufs_rpmb_sec_in(req->hc, req, &scsi_status, sense_buf,
+                                  &transferred_len);
+            if (ret != UFS_REQUEST_SUCCESS) {
+                return ret;
+            }
+            ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf),
+                                         transferred_len, scsi_status);
+            return UFS_REQUEST_SUCCESS;
+        }
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_OPCODE));
+        scsi_status = CHECK_CONDITION;
+        break;
+    case SECURITY_PROTOCOL_OUT:
+        if (lun == UFS_UPIU_RPMB_WLUN) {
+            uint32_t transferred_len = 0;
+            UfsReqResult ret;
+
+            ret = ufs_rpmb_sec_out(req->hc, req, &scsi_status, sense_buf,
+                                   &transferred_len);
+            if (ret != UFS_REQUEST_SUCCESS) {
+                return ret;
+            }
+            ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf),
+                                         transferred_len, scsi_status);
+            return UFS_REQUEST_SUCCESS;
+        }
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_OPCODE));
+        scsi_status = CHECK_CONDITION;
+        break;
     case START_STOP:
         /* TODO: Revisit it when Power Management is implemented */
         if (lun == UFS_UPIU_UFS_DEVICE_WLUN) {
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index a84627b96a..9e5e6ad913 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1,3 +1,3 @@
-system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c', 'rpmb.c'))
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
 system_ss.add(when: 'CONFIG_UFS_SYSBUS', if_true: files('ufs-sysbus.c'))
diff --git a/hw/ufs/rpmb.c b/hw/ufs/rpmb.c
new file mode 100644
index 0000000000..3032e0e098
--- /dev/null
+++ b/hw/ufs/rpmb.c
@@ -0,0 +1,170 @@
+/*
+ * QEMU UFS RPMB Well-Known Logical Unit Emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "ufs.h"
+
+static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
+                                const UfsRpmbFrame *frames,
+                                uint32_t nframes)
+{
+    const UfsRpmbFrame *req = &frames[0];
+    uint16_t req_type = lduw_be_p(&req->req_resp);
+    uint16_t result = UFS_RPMB_RES_GENERAL_FAILURE;
+
+    if (req_type == UFS_RPMB_REQ_READ_RESULT) {
+        trace_ufs_rpmb_request(req_type, lduw_be_p(&r->resp.result));
+        return;
+    }
+
+    r->read_pending = false;
+    memset(&r->resp, 0, sizeof(r->resp));
+
+    switch (req_type) {
+    default:
+        r->resp.req_resp = cpu_to_be16(req_type);
+        result = UFS_RPMB_RES_GENERAL_FAILURE;
+        break;
+    }
+
+    if (r->write_counter == 0xffffffff) {
+        result |= UFS_RPMB_RES_COUNT_EXPIRED;
+    }
+    r->resp.result = cpu_to_be16(result);
+
+    trace_ufs_rpmb_request(req_type, result);
+}
+
+static bool ufs_rpmb_parse_cdb(const uint8_t *cdb, uint8_t *region_out,
+                               uint32_t *xfer_len_out, uint8_t *sense_buf)
+{
+    uint8_t sec_proto = cdb[1];
+    uint16_t spsp = lduw_be_p(&cdb[2]);
+    uint8_t region = (spsp >> 8) & 0xff;
+    uint8_t proto_id = spsp & 0xff;
+    bool inc_512 = (cdb[4] & 0x80) != 0;
+
+    /*
+     * JESD220H Section 12.4.6.1 (Table 12.14) and Section 12.4.7.1/.2
+     * (Tables 12.16/12.17; JESD220F Tables 12.21/12.22): when SECURITY
+     * PROTOCOL is ECh, INC_512 (CDB byte 4 bit 7) shall be set to 0;
+     * otherwise terminate with CHECK CONDITION / ILLEGAL REQUEST /
+     * INVALID FIELD IN CDB.
+     */
+    if (sec_proto != UFS_RPMB_SEC_PROTOCOL ||
+        proto_id != UFS_RPMB_SEC_PROTOCOL_ID ||
+        region >= UFS_RPMB_MAX_REGIONS || inc_512) {
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        return false;
+    }
+
+    *region_out = region;
+    *xfer_len_out = ldl_be_p(&cdb[6]);
+    return true;
+}
+
+void ufs_rpmb_reset(UfsHc *u)
+{
+    for (int i = 0; i < UFS_RPMB_MAX_REGIONS; i++) {
+        u->rpmb[i].read_pending = false;
+        memset(&u->rpmb[i].resp, 0, sizeof(u->rpmb[i].resp));
+    }
+}
+
+UfsReqResult ufs_rpmb_sec_out(UfsHc *u, UfsRequest *req, uint8_t *scsi_status,
+                              uint8_t *sense_buf, uint32_t *transferred_len)
+{
+    g_autofree UfsRpmbFrame *frames = NULL;
+    dma_addr_t residual = 0;
+    uint8_t region;
+    uint32_t xfer_len;
+    uint32_t nframes;
+    uint8_t max_rw = u->geometry_desc.rpmb_read_write_size;
+    uint16_t req_type;
+
+    *transferred_len = 0;
+    if (!ufs_rpmb_parse_cdb(req->req_upiu.sc.cdb, &region, &xfer_len,
+                            sense_buf)) {
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+    if (xfer_len == 0 || (xfer_len % UFS_RPMB_FRAME_LEN) != 0 ||
+        xfer_len > (uint32_t)max_rw * UFS_RPMB_FRAME_LEN) {
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+    if (!ufs_fit_data_buffer(req, xfer_len)) {
+        return UFS_REQUEST_MISMATCH_DATA_BUF;
+    }
+
+    nframes = xfer_len / UFS_RPMB_FRAME_LEN;
+    frames = g_new0(UfsRpmbFrame, nframes);
+    if (dma_buf_write(frames, xfer_len, &residual, req->sg,
+                      MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
+    }
+
+    req_type = lduw_be_p(&frames[0].req_resp);
+    if (req_type != UFS_RPMB_REQ_AUTH_DATA_WRITE && nframes != 1) {
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+
+    ufs_rpmb_handle_req(u, &u->rpmb[region], frames, nframes);
+    *transferred_len = xfer_len - residual;
+    *scsi_status = GOOD;
+    return UFS_REQUEST_SUCCESS;
+}
+
+UfsReqResult ufs_rpmb_sec_in(UfsHc *u, UfsRequest *req, uint8_t *scsi_status,
+                             uint8_t *sense_buf, uint32_t *transferred_len)
+{
+    UfsRpmbRegion *r;
+    dma_addr_t residual = 0;
+    uint8_t region;
+    uint32_t alloc_len;
+    uint32_t in_frames;
+    uint8_t max_rw = u->geometry_desc.rpmb_read_write_size;
+
+    *transferred_len = 0;
+    if (!ufs_rpmb_parse_cdb(req->req_upiu.sc.cdb, &region, &alloc_len,
+                            sense_buf)) {
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+    if (alloc_len < UFS_RPMB_FRAME_LEN ||
+        (alloc_len % UFS_RPMB_FRAME_LEN) != 0 ||
+        alloc_len > (uint32_t)max_rw * UFS_RPMB_FRAME_LEN) {
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+
+    r = &u->rpmb[region];
+    in_frames = alloc_len / UFS_RPMB_FRAME_LEN;
+
+    if (in_frames != 1) {
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        *scsi_status = CHECK_CONDITION;
+        return UFS_REQUEST_SUCCESS;
+    }
+    if (!ufs_fit_data_buffer(req, alloc_len)) {
+        return UFS_REQUEST_MISMATCH_DATA_BUF;
+    }
+
+    if (dma_buf_read(&r->resp, alloc_len, &residual, req->sg,
+                     MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
+    }
+
+    *transferred_len = alloc_len - residual;
+    *scsi_status = GOOD;
+    return UFS_REQUEST_SUCCESS;
+}
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index e1d29d6670..cb7aaa765f 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -67,3 +67,6 @@ ufs_zbc_report_zones(uint8_t lun, uint64_t lba, uint32_t alloc_len, uint8_t opti
 ufs_zbc_zone_op(uint8_t lun, uint8_t action, uint64_t zone_id, bool all) "lun 0x%"PRIx8", action 0x%"PRIx8", zone id %"PRIu64", all %d"
 ufs_zbc_write_rejected(uint8_t lun, uint64_t lba, uint32_t len, uint64_t wp, uint8_t cond, uint8_t asc, uint8_t ascq) "lun 0x%"PRIx8", lba %"PRIu64", len %"PRIu32", wp %"PRIu64", cond 0x%"PRIx8", asc 0x%"PRIx8", ascq 0x%"PRIx8""
 ufs_zbc_write_undone(uint8_t lun, uint64_t zone_start, uint64_t wp) "lun 0x%"PRIx8", zone start %"PRIu64", wp back to %"PRIu64""
+
+# rpmb.c
+ufs_rpmb_request(uint16_t req, uint16_t result) "req 0x%04"PRIx16", result 0x%04"PRIx16""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index f8da7c9554..bc0f2ce4eb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -961,6 +961,7 @@ static void ufs_hce_reset(UfsHc *u)
             scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));
         }
     }
+    ufs_rpmb_reset(u);
 
     /* 3. Reset standard request list slots, doorbells, and status registers */
     for (i = 0; i < u->params.nutrs; i++) {
@@ -2325,9 +2326,18 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
 
 static const RpmbUnitDescriptor rpmb_unit_desc = {
     .length = sizeof(RpmbUnitDescriptor),
-    .descriptor_idn = 2,
+    .descriptor_idn = UFS_QUERY_DESC_IDN_UNIT,
     .unit_index = UFS_UPIU_RPMB_WLUN,
-    .lu_enable = 0,
+    .lu_enable = 0x01,
+    .memory_type = 0x0f,
+    .rpmb_region_enable = (1U << UFS_RPMB_MAX_REGIONS) - 1,
+    .logical_block_size = UFS_RPMB_LOGICAL_BLOCK_SIZE,
+    .rpmb_region_size = {
+        UFS_RPMB_REGION_UNITS,
+        UFS_RPMB_REGION_UNITS,
+        UFS_RPMB_REGION_UNITS,
+        UFS_RPMB_REGION_UNITS,
+    },
 };
 
 static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
@@ -2342,7 +2352,11 @@ static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
     }
 
     if (lun == UFS_UPIU_RPMB_WLUN) {
-        memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.length);
+        RpmbUnitDescriptor desc = rpmb_unit_desc;
+
+        desc.logical_block_count = cpu_to_be64(UFS_RPMB_TOTAL_BLOCKS);
+        desc.phy_mem_resource_count = cpu_to_be64(UFS_RPMB_TOTAL_BLOCKS);
+        memcpy(&req->rsp_upiu.qr.data, &desc, desc.length);
     } else {
         memcpy(&req->rsp_upiu.qr.data, &u->lus[lun]->unit_desc,
                sizeof(u->lus[lun]->unit_desc));
@@ -3162,6 +3176,7 @@ static void ufs_init_hc(UfsHc *u)
     /* TODO: Revisit it when Power Management is implemented */
     u->device_desc.init_power_mode = 0x01; /* Active Mode */
     u->device_desc.high_priority_lun = 0x7F; /* Same Priority */
+    u->device_desc.security_lu = 0x01;
     u->device_desc.spec_version = cpu_to_be16(UFS_SPEC_VER);
     u->device_desc.manufacturer_name = 0x00;
     u->device_desc.product_name = 0x01;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index a1e63bd0c8..5120ade082 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -245,6 +245,24 @@ typedef struct UfsWb {
     uint64_t pinned_total_written_bytes;
 } UfsWb;
 
+/* Each region unit in bRPMBRegionXSize is 128 KiB = 512 x 256 B blocks */
+#define UFS_RPMB_REGION_UNITS       32
+#define UFS_RPMB_REGION_BLOCKS      (UFS_RPMB_REGION_UNITS * \
+                                     UFS_RPMB_BLOCKS_PER_UNIT)
+#define UFS_RPMB_REGION_BYTES       (UFS_RPMB_REGION_BLOCKS * \
+                                     UFS_RPMB_DATA_LEN)
+#define UFS_RPMB_TOTAL_BLOCKS       (UFS_RPMB_MAX_REGIONS * \
+                                     UFS_RPMB_REGION_BLOCKS)
+
+typedef struct UfsRpmbRegion {
+    uint8_t key[UFS_RPMB_KEY_MAC_LEN];
+    uint8_t *storage;
+    uint32_t write_counter;
+    bool key_set;
+    bool read_pending;
+    UfsRpmbFrame resp;
+} UfsRpmbRegion;
+
 typedef struct UfsHc {
     DeviceState *dev;
     AddressSpace *dma_as;
@@ -262,6 +280,7 @@ typedef struct UfsHc {
     UfsLu dev_wlu;
     UfsLu boot_wlu;
     UfsLu rpmb_wlu;
+    UfsRpmbRegion rpmb[UFS_RPMB_MAX_REGIONS];
     DeviceDescriptor device_desc;
     GeometryDescriptor geometry_desc;
     Attributes attributes;
@@ -412,6 +431,11 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 bool ufs_fit_data_buffer(UfsRequest *req, uint64_t len);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
+UfsReqResult ufs_rpmb_sec_in(UfsHc *u, UfsRequest *req, uint8_t *scsi_status,
+                             uint8_t *sense_buf, uint32_t *transferred_len);
+void ufs_rpmb_reset(UfsHc *u);
+UfsReqResult ufs_rpmb_sec_out(UfsHc *u, UfsRequest *req, uint8_t *scsi_status,
+                              uint8_t *sense_buf, uint32_t *transferred_len);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
                  Error **errp);
 void ufs_unrealize(UfsHc *u);
-- 
2.56.0.307.g5fe7bd680c-goog


