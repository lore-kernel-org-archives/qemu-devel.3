Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBEC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDC9-00034s-Bk; Tue, 23 Jul 2024 06:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDC7-0002pe-9Q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDC4-0001iW-Oc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcwAVQlpIclpTqaGgIStn6XGFvx5TOswyNM1MDIov58=;
 b=bweogRqnx3PCECCs62pe9P+vtFzYQP0SyMr3minTO0bpuUXdreUNjIox5twfAnTdZlSgxe
 wAD6VCh+MJ+UJ2iIEoBSHTbR2YR1Xuv/jTrIX4FgYCHP2pOnkhO0ADEu+vjuebRFLHYaU6
 gljrnRmF80cDZ2Y2wHxqyDd+Z9woP0c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-7rnGWBXNMB2FbSX766miUQ-1; Tue, 23 Jul 2024 06:56:30 -0400
X-MC-Unique: 7rnGWBXNMB2FbSX766miUQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa56d8b14so3855366b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732189; x=1722336989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcwAVQlpIclpTqaGgIStn6XGFvx5TOswyNM1MDIov58=;
 b=TSqmvFE0c29jOoJreLRpp9ZLaVT3avn0fOdwsMp0ogYRJqZ9h92mw81FHdlvDeFXWM
 LsEu24I/+X+byA0E8MN6mQyYMFtQ9T9CzioE5bSvOmiqDu9zfBaxZZvWaALyhvYeTvxx
 /Dw2FSU4mcpo0upoKrpmFzv8xW2BY2um6dZVla6BvPb4b67wczoQsPMRPNa23L4DbDED
 TDghby3PkrrrgOkR88hwZ/yOJ/dlvOBFWRFy50TJojO9CcX73TRtTI2xQ4pJanm4zTF5
 VmEskgL9kOjEJvRlGAaT48sbnNG0f4kAtKmRsoy0J3WNsOqlBkxiUZFHP6LsJIz+OjiU
 XHTw==
X-Gm-Message-State: AOJu0YypV1g7wGbkN2A3v/rLsTkqlcR04K+2B9pSJFoqmTLimIWiGUuw
 duzuKuDHQZhO1+BMmM6wWkd2ISsVVApO97C5tKDLGJfaLpj4YApSBQnaZNQe/idurmD5+nxj77E
 +zOXxRMWNSc8qJMJbrn9QKh9cV6ajWhTVTiWA5VOJ/DqVHNkrNRr+5nOCA0pZWoQ6KBmLLUjGUC
 OxUNpfmmwWvyvUh0oZTgq/fkLktlXqQw==
X-Received: by 2002:a17:907:7244:b0:a77:e48d:bc2 with SMTP id
 a640c23a62f3a-a7a4bfbdd2amr701568066b.3.1721732188859; 
 Tue, 23 Jul 2024 03:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf+miQGCVRG1jmn9x+RTL/R3CVN6tV/LegxzmAHCZ9fZe0CjwURjHc3usx6/AR5EKEY/xaBQ==
X-Received: by 2002:a17:907:7244:b0:a77:e48d:bc2 with SMTP id
 a640c23a62f3a-a7a4bfbdd2amr701565166b.3.1721732187897; 
 Tue, 23 Jul 2024 03:56:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c94edb4sm523962266b.196.2024.07.23.03.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 14/61] hw/cxl: Support firmware updates
Message-ID: <3c1e1e5e240e683f0611b96cd325471639f22c6d.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Davidlohr Bueso <dave@stgolabs.net>

Implement transfer and activate functionality per 3.1 spec for
supporting update metadata (no actual buffers). Transfer times
are arbitrarily set to ten and two seconds for full and part
transfers, respectively.

cxl update-firmware mem0 -F fw.img

<on-going fw update>

cxl update-firmware mem0
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":true,
    "remaining_size":22400
  }
}

<completed fw update>

cxl update-firmware mem0
{
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":2,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "slot_2_version":"BWFW VERSION 1",
    "fw_update_in_progress":false
  }
}

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20240627164912.25630-1-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  15 +++
 hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5cae7159e6..fdd0f4e62b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -181,6 +181,21 @@ typedef struct CXLCCI {
         uint64_t runtime;
         QEMUTimer *timer;
     } bg;
+
+    /* firmware update */
+    struct {
+        uint8_t active_slot;
+        uint8_t staged_slot;
+        bool slot[4];
+        uint8_t curr_action;
+        uint8_t curr_slot;
+        /* handle partial transfers */
+        bool transferring;
+        size_t prev_offset;
+        size_t prev_len;
+        time_t last_partxfer;
+    } fw;
+
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0621f686f4..b752920ec8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -63,6 +63,8 @@ enum {
         #define SET_INTERRUPT_POLICY   0x3
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -622,6 +624,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_FW_SLOTS 2
+#define CXL_FW_SIZE  0x02000000 /* 32 mb */
+
 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -652,15 +657,192 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
 
     fw_info = (void *)payload_out;
 
-    fw_info->slots_supported = 2;
-    fw_info->slot_info = BIT(0) | BIT(3);
-    fw_info->caps = 0;
-    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    fw_info->slots_supported = CXL_FW_SLOTS;
+    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
+            ((cci->fw.staged_slot & 0x7) << 3);
+    fw_info->caps = BIT(0);  /* online update supported */
+
+    if (cci->fw.slot[0]) {
+        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    }
+    if (cci->fw.slot[1]) {
+        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
+    }
 
     *len_out = sizeof(*fw_info);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
+#define CXL_FW_XFER_ALIGNMENT   128
+
+#define CXL_FW_XFER_ACTION_FULL     0x0
+#define CXL_FW_XFER_ACTION_INIT     0x1
+#define CXL_FW_XFER_ACTION_CONTINUE 0x2
+#define CXL_FW_XFER_ACTION_END      0x3
+#define CXL_FW_XFER_ACTION_ABORT    0x4
+
+static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+        uint8_t rsvd1[2];
+        uint32_t offset;
+        uint8_t rsvd2[0x78];
+        uint8_t data[];
+    } QEMU_PACKED *fw_transfer = (void *)payload_in;
+    size_t offset, length;
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
+        /*
+         * At this point there aren't any on-going transfers
+         * running in the bg - this is serialized before this
+         * call altogether. Just mark the state machine and
+         * disregard any other input.
+         */
+        cci->fw.transferring = false;
+        return CXL_MBOX_SUCCESS;
+    }
+
+    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
+    length = len - sizeof(*fw_transfer);
+    if (offset + length > CXL_FW_SIZE) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (cci->fw.transferring) {
+        if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
+            fw_transfer->action == CXL_FW_XFER_ACTION_INIT) {
+            return CXL_MBOX_FW_XFER_IN_PROGRESS;
+        }
+        /*
+         * Abort partitioned package transfer if over 30 secs
+         * between parts. As opposed to the explicit ABORT action,
+         * semantically treat this condition as an error - as
+         * if a part action were passed without a previous INIT.
+         */
+        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
+            cci->fw.transferring = false;
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    } else if (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+               fw_transfer->action == CXL_FW_XFER_ACTION_END) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* allow back-to-back retransmission */
+    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
+        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
+        /* verify no overlaps */
+        if (offset < cci->fw.prev_offset + cci->fw.prev_len) {
+            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
+        }
+    }
+
+    switch (fw_transfer->action) {
+    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
+    case CXL_FW_XFER_ACTION_END:
+        if (fw_transfer->slot == 0 ||
+            fw_transfer->slot == cci->fw.active_slot ||
+            fw_transfer->slot > CXL_FW_SLOTS) {
+            return CXL_MBOX_FW_INVALID_SLOT;
+        }
+
+        /* mark the slot used upon bg completion */
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+        if (offset != 0) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        cci->fw.transferring = true;
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL) {
+        cci->bg.runtime = 10 * 1000UL;
+    } else {
+        cci->bg.runtime = 2 * 1000UL;
+    }
+    /* keep relevant context for bg completion */
+    cci->fw.curr_action = fw_transfer->action;
+    cci->fw.curr_slot = fw_transfer->slot;
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
+static void __do_firmware_xfer(CXLCCI *cci)
+{
+    switch (cci->fw.curr_action) {
+    case CXL_FW_XFER_ACTION_FULL:
+    case CXL_FW_XFER_ACTION_END:
+        cci->fw.slot[cci->fw.curr_slot - 1] = true;
+        cci->fw.transferring = false;
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        time(&cci->fw.last_partxfer);
+        break;
+    default:
+        break;
+    }
+}
+
+/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
+static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+    } QEMU_PACKED *fw_activate = (void *)payload_in;
+    QEMU_BUILD_BUG_ON(sizeof(*fw_activate) != 0x2);
+
+    if (fw_activate->slot == 0 ||
+        fw_activate->slot == cci->fw.active_slot ||
+        fw_activate->slot > CXL_FW_SLOTS) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    /* ensure that an actual fw package is there */
+    if (!cci->fw.slot[fw_activate->slot - 1]) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    switch (fw_activate->action) {
+    case 0: /* online */
+        cci->fw.active_slot = fw_activate->slot;
+        break;
+    case 1: /* reset */
+        cci->fw.staged_slot = fw_activate->slot;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
@@ -2494,6 +2676,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                       ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
+    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
+        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
+        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2622,7 +2808,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                 h == cmd_media_get_poison_list ||
                 h == cmd_media_inject_poison ||
                 h == cmd_media_clear_poison ||
-                h == cmd_sanitize_overwrite) {
+                h == cmd_sanitize_overwrite ||
+                h == cmd_firmware_update_transfer ||
+                h == cmd_firmware_update_activate) {
                 return CXL_MBOX_MEDIA_DISABLED;
             }
         }
@@ -2667,6 +2855,9 @@ static void bg_timercb(void *opaque)
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
         switch (cci->bg.opcode) {
+        case 0x0201: /* fw transfer */
+            __do_firmware_xfer(cci);
+            break;
         case 0x4400: /* sanitize */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -2738,6 +2929,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.runtime = 0;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+
+    memset(&cci->fw, 0, sizeof(cci->fw));
+    cci->fw.active_slot = 1;
+    cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
-- 
MST


