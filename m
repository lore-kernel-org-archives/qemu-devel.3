Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD5FCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpmz-0003G5-Dw; Thu, 11 Jun 2026 20:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpmx-0003Fl-SJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:23 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wXpmv-0007UK-Gg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 20:30:23 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so239120a91.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781224220; x=1781829020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1jFVNmGFzQzMnwgvLR0wLKTwpvD8Q8QkiWJzOncf8A=;
 b=hU3+4X6+1kZjybyeKZh7nF7g5E9kf2KZoxhtv9npfJMKVhwlYDLpYN0T0OSgMRHJ7l
 wjLBRmDNYUl5fzCaMkwAIe34azmmLx/EK8jdGiE6bf0rEOWN6Tn0MbpzL2c71EsDPICA
 FPpAu8CKb3b24Rqm9AGzI1AY4vCr4ooE1KpviDmVeFL/k34s4K0q73hsRLDk9UW/a/L4
 l0xKZxNk8UubFgXvfp0m7TG2dUBT3HY9ZLsvsg2rl0QBK4wOuVos+9RpXHgTGgEOcj6i
 tr70PSNwr8CneJ9Bwbxakdp3KIp2adorOqqv4l8SZs6dJ2seZ46YK+CNmoNX8U5qm+Cj
 AgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781224220; x=1781829020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1jFVNmGFzQzMnwgvLR0wLKTwpvD8Q8QkiWJzOncf8A=;
 b=Gugw5dAgIv6vz59LfpPPfS+mhVH5AyGYibFJfqOqOrU/QCdZj+to/fOVg4HAAcEBV6
 1gds4DXOEwOHWkchPiJrNYB0b2QQvEx9abrmtvmw0B+T/rz6sVzJRS4j/4drkP6A443O
 avTqElxZ54J2cjXpTQusqxOjCFCae7Kp5pPCtBXfsJ6jIiILZNpXZtTb2Nk8c6ga6Bs+
 ej9n88ijoEPUwTjGyXnedpVAfX4KncIc9APmhGA5aoLJfD7HlbwOPQi4DZPH2rop0smb
 7KIcTpyeYzQgMGEPmd8dK9+3eKoOwryIypg4euNkVWHGnwDumxuSA50WAMeEFF1Ps9fN
 YEGQ==
X-Gm-Message-State: AOJu0YwqkdFu+ip5rbwbSe/ULS8F9Xy0aIsDX3hrtqVnXJnr7r7JkqWA
 Fe75ZXDR+HOaVNvEsanlj6q/azWjbEP85cOGkkVJsbiJjPuP7/oZuLrlZ8jHPw==
X-Gm-Gg: Acq92OEBrI0GlDDBb2Y1sFre6LG+/Gm3ERXaSDxTxh8iqDSMUsBCGa45SsJGhdwA6BZ
 JTtEvt0PZlsjnckOEn9nGCae5ApoHdjAJU0XhiEoV3SkDVB4lFglagTxWRaETju8j3R22ys02qG
 /9IGl3aeCSmSCi7ylG5PykXBo+lTxp5hA2CHRQCz9CgigsmhT2k3OmwK0Q57KwTKfahlzR/tJIW
 SI+Ed3yz2zQz7fyoL0m4y4LMW1e4GnZCV04rHDZ8d2gDn7q2QV5RQC69u5PzRwp00FOE67hLc6i
 f9F1tB1k1OWgMXAYm6YdO5X68D30aZDKdnKAPyG7BPtLJyLtI4E1/LzK0bPm1ueO4V8vLN6XLKm
 4/c49tzp4YruyXrsMs+92r/XP+5HxKbW5Jz/RAgl4eWARL1KvAHptv2LBXpTwHXPp1Y/clIhkcI
 7TtMfI9oV8BXZ/NRukKXa/+ekYzZ8h
X-Received: by 2002:a17:90b:5106:b0:368:a297:bd3d with SMTP id
 98e67ed59e1d1-37a01845ed2mr700446a91.3.1781224219577; 
 Thu, 11 Jun 2026 17:30:19 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-379e79396d7sm336989a91.1.2026.06.11.17.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:30:19 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, Keoseong Park <keosung.park@samsung.com>
Subject: [PULL 1/2] hw/ufs: Add Host Initiated Defragmentation (HID) support
Date: Fri, 12 Jun 2026 09:29:55 +0900
Message-ID: <08c6d46621cca906fa701714de87a3de93955d95.1781223925.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781223925.git.jeuk20.kim@samsung.com>
References: <cover.1781223925.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Keoseong Park <keosung.park@samsung.com>

Emulate the UFS HID extended feature. Host interacts via five
attributes (IDN 0x35-0x39):

  bDefragOperation   trigger: Disable / Analysis / Defrag
  dHIDAvailableSize  fragmented 4KB units (published by analysis)
  dHIDSize           host-requested defrag target (4KB units)
  bHIDProgressRatio  0-100%; reading 100 resets HID
  bHIDState          current state; terminal-state read resets HID

Successful user-data SCSI WRITE commands increment an internal
fragment counter; HID analysis publishes the counter through
dHIDAvailableSize. Defrag operates on min(dHIDSize,
dHIDAvailableSize), so a small dHIDSize yields a partial defrag.
bDefragOperation auto-clears on terminal state. The state machine
advances from ufs_process_idle(); transitions occur only while the
device is idle.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c         |  16 ++++-
 hw/ufs/trace-events |   4 ++
 hw/ufs/ufs.c        | 154 ++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |   4 ++
 include/block/ufs.h |  18 ++++++
 5 files changed, 188 insertions(+), 8 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index f13fc6e342..1e75b1eb4d 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -154,15 +154,29 @@ static void ufs_wb_process_write_req(UfsRequest *req, uint32_t transfered_len)
     ufs_wb_update_avail_buffer(u);
 }
 
+#define UFS_HID_MAX_FRAGMENTS 1024
+static void ufs_hid_count_fragments(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+
+    if (!ufs_is_write_req(req)) {
+        return;
+    }
+
+    u->hid_fragment_count =
+        MIN(u->hid_fragment_count + 1, UFS_HID_MAX_FRAGMENTS);
+}
+
 static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 {
     UfsRequest *req = scsi_req->hba_private;
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
-    /* WB accounting should only happen for successful commands */
+    /* WB / HID accounting should only happen for successful commands */
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
+        ufs_hid_count_fragments(req);
     }
 
     ufs_build_scsi_response_upiu(req, scsi_req->sense, scsi_req->sense_len,
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 6f7ea9c95f..662d9afee3 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -51,3 +51,7 @@ ufs_err_mcq_create_cq_already_exists(uint8_t qid) "mcq cqid %"PRIu8 "already exi
 ufs_err_mcq_delete_cq_invalid_cqid(uint8_t qid) "invalid mcq cqid %"PRIu8""
 ufs_err_mcq_delete_cq_not_exists(uint8_t qid) "mcq cqid %"PRIu8 "not exists"
 ufs_err_mcq_delete_cq_sq_not_deleted(uint8_t sqid, uint8_t cqid) "mcq sq %"PRIu8" still has cq %"PRIu8""
+
+# HID (Host Initiated Defragmentation)
+ufs_hid_defrag_operation(uint8_t op, uint8_t state) "HID defrag operation 0x%"PRIx8", new state 0x%"PRIx8""
+ufs_hid_defrag_progress(uint32_t remaining, uint8_t progress) "HID defrag remaining %"PRIu32", progress %"PRIu8"%%"
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 6780d73174..35c2444385 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -40,6 +40,9 @@
 #define UFS_TOO_HIGH_TEMP_BOUNDARY 160
 #define UFS_TOO_LOW_TEMP_BOUNDARY 60
 
+#define UFS_HID_DEFRAG_BATCH_DIV 10 /* ~10% of remaining per tick */
+#define UFS_HID_PROGRESS_COMPLETE 100
+
 static void ufs_exec_req(UfsRequest *req);
 static void ufs_clear_req(UfsRequest *req);
 
@@ -1288,10 +1291,9 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
     [UFS_QUERY_ATTR_IDN_REFRESH_UNIT] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_TIMESTAMP] = UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_EXCEPTION_ID] = UFS_QUERY_ATTR_READ,
-    /* host initiated defragmentation is not supported */
-    [UFS_QUERY_ATTR_IDN_DEFRAG_OP] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_DEFRAG_OP] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE] = UFS_QUERY_ATTR_READ,
-    [UFS_QUERY_ATTR_IDN_HID_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HID_SIZE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_HID_PROG_RATIO] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_HID_STATE] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT] = UFS_QUERY_ATTR_READ,
@@ -1371,8 +1373,31 @@ static inline uint32_t ufs_wb_read_resize_status(UfsHc *u)
     return value;
 }
 
+static void ufs_hid_reset(UfsHc *u)
+{
+    u->attributes.defrag_op = UFS_HID_OP_DISABLE;
+    u->attributes.hid_state = UFS_HID_STATE_IDLE;
+    u->attributes.hid_prog_ratio = 0;
+    u->attributes.hid_avail_size = cpu_to_be32(0xFFFFFFFF);
+    u->hid_defrag_total = 0;
+    u->hid_defrag_remaining = 0;
+}
+
+static uint32_t ufs_hid_read_progress_ratio(UfsHc *u)
+{
+    uint32_t value = u->attributes.hid_prog_ratio;
+
+    if (value == UFS_HID_PROGRESS_COMPLETE) {
+        ufs_hid_reset(u);
+    }
+
+    return value;
+}
+
 static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
 {
+    uint8_t state;
+
     switch (idn) {
     case UFS_QUERY_ATTR_IDN_BOOT_LU_EN:
         return u->attributes.boot_lun_en;
@@ -1451,9 +1476,16 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     case UFS_QUERY_ATTR_IDN_HID_SIZE:
         return be32_to_cpu(u->attributes.hid_size);
     case UFS_QUERY_ATTR_IDN_HID_PROG_RATIO:
-        return u->attributes.hid_prog_ratio;
+        return ufs_hid_read_progress_ratio(u);
     case UFS_QUERY_ATTR_IDN_HID_STATE:
-        return u->attributes.hid_state;
+        state = u->attributes.hid_state;
+
+        if (state == UFS_HID_STATE_DEFRAG_COMPLETED ||
+            state == UFS_HID_STATE_DEFRAG_NOT_REQUIRED) {
+            ufs_hid_reset(u);
+        }
+
+        return state;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT:
         return u->attributes.wb_buffer_resize_hint;
     case UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS:
@@ -1604,6 +1636,26 @@ static bool ufs_wb_pinned_min_size(UfsHc *u, uint32_t value)
     return true;
 }
 
+static QueryRespCode ufs_hid_write_defrag_operation(UfsHc *u, uint32_t value)
+{
+    switch (value) {
+    case UFS_HID_OP_DISABLE:
+        ufs_hid_reset(u);
+        break;
+    case UFS_HID_OP_ANALYSIS:
+    case UFS_HID_OP_DEFRAG:
+        u->attributes.defrag_op = value;
+        u->attributes.hid_state = UFS_HID_STATE_ANALYSIS_IN_PROGRESS;
+        u->attributes.hid_prog_ratio = 0;
+        break;
+    default:
+        return UFS_QUERY_RESULT_INVALID_VALUE;
+    }
+
+    trace_ufs_hid_defrag_operation(value, u->attributes.hid_state);
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
 static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
 {
     switch (idn) {
@@ -1668,6 +1720,11 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
             return UFS_QUERY_RESULT_INVALID_VALUE;
         }
         break;
+    case UFS_QUERY_ATTR_IDN_DEFRAG_OP:
+        return ufs_hid_write_defrag_operation(u, value);
+    case UFS_QUERY_ATTR_IDN_HID_SIZE:
+        u->attributes.hid_size = cpu_to_be32(value);
+        break;
     default:
         g_assert_not_reached();
         return 0;
@@ -2211,11 +2268,92 @@ static void ufs_wb_process_resize(UfsHc *u)
     u->attributes.wb_buffer_resize_status = UFS_WB_RESIZE_COMPLETED;
 }
 
+static void ufs_hid_process(UfsHc *u)
+{
+    uint32_t requested, batch, done;
+
+    switch (u->attributes.hid_state) {
+    case UFS_HID_STATE_ANALYSIS_IN_PROGRESS:
+        u->attributes.hid_avail_size = cpu_to_be32(u->hid_fragment_count);
+        if (u->hid_fragment_count > 0) {
+            u->attributes.hid_state = UFS_HID_STATE_DEFRAG_REQUIRED;
+        } else {
+            u->attributes.hid_state = UFS_HID_STATE_DEFRAG_NOT_REQUIRED;
+        }
+
+        if (u->attributes.defrag_op == UFS_HID_OP_ANALYSIS ||
+            u->attributes.hid_state == UFS_HID_STATE_DEFRAG_NOT_REQUIRED) {
+            u->attributes.defrag_op = UFS_HID_OP_DISABLE;
+        }
+
+        trace_ufs_hid_defrag_operation(u->attributes.defrag_op,
+                                       u->attributes.hid_state);
+        break;
+
+    case UFS_HID_STATE_DEFRAG_REQUIRED:
+        if (u->attributes.defrag_op != UFS_HID_OP_DEFRAG) {
+            break;
+        }
+
+        requested = MIN(be32_to_cpu(u->attributes.hid_size),
+                        be32_to_cpu(u->attributes.hid_avail_size));
+        if (!requested) {
+            u->attributes.hid_state = UFS_HID_STATE_DEFRAG_COMPLETED;
+            u->attributes.defrag_op = UFS_HID_OP_DISABLE;
+            u->attributes.hid_prog_ratio = UFS_HID_PROGRESS_COMPLETE;
+
+            trace_ufs_hid_defrag_operation(u->attributes.defrag_op,
+                                           u->attributes.hid_state);
+            break;
+        }
+
+        u->attributes.hid_state = UFS_HID_STATE_DEFRAG_IN_PROGRESS;
+        u->hid_defrag_total = requested;
+        u->hid_defrag_remaining = requested;
+        u->attributes.hid_prog_ratio = 0;
+        break;
+
+    case UFS_HID_STATE_DEFRAG_IN_PROGRESS:
+        if (u->hid_defrag_remaining > 0) {
+            batch = u->hid_defrag_remaining / UFS_HID_DEFRAG_BATCH_DIV;
+            if (batch == 0) {
+                batch = 1;
+            }
+
+            u->hid_defrag_remaining -= batch;
+            u->hid_fragment_count -= batch;
+
+            done = u->hid_defrag_total - u->hid_defrag_remaining;
+            u->attributes.hid_prog_ratio =
+                ((uint64_t)done * UFS_HID_PROGRESS_COMPLETE) /
+                u->hid_defrag_total;
+
+            trace_ufs_hid_defrag_progress(u->hid_defrag_remaining,
+                                          u->attributes.hid_prog_ratio);
+        }
+
+        if (!u->hid_defrag_remaining) {
+            u->attributes.hid_state = UFS_HID_STATE_DEFRAG_COMPLETED;
+            u->attributes.defrag_op = UFS_HID_OP_DISABLE;
+            u->attributes.hid_prog_ratio = UFS_HID_PROGRESS_COMPLETE;
+
+            trace_ufs_hid_defrag_operation(u->attributes.defrag_op,
+                                           u->attributes.hid_state);
+        }
+
+        break;
+
+    default:
+        break;
+    }
+}
+
 static void ufs_process_idle(UfsHc *u)
 {
     ufs_wb_process_flush(u);
     ufs_wb_process_resize(u);
     ufs_wb_sync_buffer_size(u);
+    ufs_hid_process(u);
 }
 
 static inline bool ufs_check_idle(UfsHc *u)
@@ -2384,8 +2522,8 @@ static void ufs_init_hc(UfsHc *u)
     uint32_t mcqconfig = 0;
     uint32_t mcqcap = 0;
     uint32_t ext_wb_sup = WB_RESIZE | WB_FIFO | WB_PINNED;
-    uint32_t ext_ufs_feat_sup =
-        UFS_DEV_WB_SUPPORT | UFS_DEV_HIGH_TEMP_NOTIF | UFS_DEV_LOW_TEMP_NOTIF;
+    uint32_t ext_ufs_feat_sup = UFS_DEV_WB_SUPPORT | UFS_DEV_HIGH_TEMP_NOTIF |
+                                UFS_DEV_LOW_TEMP_NOTIF | UFS_DEV_HID_SUPPORT;
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
 
     u->reg_size = pow2ceil(ufs_reg_size(u));
@@ -2487,6 +2625,8 @@ static void ufs_init_hc(UfsHc *u)
     u->attributes.max_num_of_rtt = 0x02;
     u->attributes.device_too_high_temp_boundary = UFS_TOO_HIGH_TEMP_BOUNDARY;
     u->attributes.device_too_low_temp_boundary = UFS_TOO_LOW_TEMP_BOUNDARY;
+    u->attributes.hid_avail_size = cpu_to_be32(0xFFFFFFFF);
+    u->attributes.hid_size = cpu_to_be32(0xFFFFFFFF);
 
     memset(&u->flags, 0, sizeof(u->flags));
     u->flags.permanently_disable_fw_update = 1;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 8743501810..feb47f460d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -175,6 +175,10 @@ typedef struct UfsHc {
     uint8_t temperature;
 
     QEMUTimer idle_timer;
+
+    uint32_t hid_fragment_count; /* Remaining fragmented 4KB units */
+    uint32_t hid_defrag_total; /* Requested units at defrag start */
+    uint32_t hid_defrag_remaining; /* Requested units left to move */
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 0f7cc9c21b..6dd91181e5 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -951,6 +951,23 @@ enum attr_idn {
     UFS_QUERY_ATTR_IDN_COUNT,
 };
 
+/* HID (Host Initiated Defragmentation) operation values for bDefragOperation */
+enum ufs_hid_op {
+    UFS_HID_OP_DISABLE = 0x00,
+    UFS_HID_OP_ANALYSIS = 0x01,
+    UFS_HID_OP_DEFRAG = 0x02,
+};
+
+/* HID state values for bHIDState */
+enum ufs_hid_state {
+    UFS_HID_STATE_IDLE = 0x00,
+    UFS_HID_STATE_ANALYSIS_IN_PROGRESS = 0x01,
+    UFS_HID_STATE_DEFRAG_REQUIRED = 0x02,
+    UFS_HID_STATE_DEFRAG_IN_PROGRESS = 0x03,
+    UFS_HID_STATE_DEFRAG_COMPLETED = 0x04,
+    UFS_HID_STATE_DEFRAG_NOT_REQUIRED = 0x05,
+};
+
 /* Descriptor idn for Query requests */
 enum desc_idn {
     UFS_QUERY_DESC_IDN_DEVICE = 0x0,
@@ -1142,6 +1159,7 @@ enum {
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
     UFS_DEV_WB_SUPPORT = BIT(8),
+    UFS_DEV_HID_SUPPORT = BIT(13),
 };
 
 /* WriteBooster buffer mode */
-- 
2.43.0


