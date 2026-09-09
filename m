Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CF9C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jo-0002yP-Hm; Tue, 08 Sep 2026 23:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3oc6gagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com>)
 id 1x48jm-0002xq-K4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:38 -0400
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3oc6gagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com>)
 id 1x48jj-00054q-Kq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:38 -0400
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso6323927a91.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923553; x=1789528353; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OmGKFSWpBnh3pzqw8uQ1uKWiOY/3YtQWeeyFZ1xLu44=;
 b=cQhcsD4XgTBkE5eA3gLPzLqm7wGFVH3PfDllYl3ulxWPdCDYDkvhccOEBlc9e0NqY5
 oQ2fHlI6SdQXDbHk8fJzXoU4HY89jxEH39w2YYhNvqRmjNThbTpcq62qIuioYhiw2VEF
 OKp15ECkSI+6cyvJPbj29IDpqv21CdJ3BBzniVZNj9ehaZpvOiOvMNouELxALoR3TB4z
 zMg5WtndoaI7B63a5GcUIXFVPAEDAok2qxwEuz0V30xq9EgYAvZqxnXtz8TRoTk2a3gQ
 5bakElfEmhyRq2dXfa9YFVVokC6LkiFOqpTRfLjQXGNq+CUB2mRzyNySrpnehDpM3Udq
 TGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923553; x=1789528353;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OmGKFSWpBnh3pzqw8uQ1uKWiOY/3YtQWeeyFZ1xLu44=;
 b=V0n2g//AJhkWTGW36JlxdmD0bcEadtmosFNu4spSmvqD7qcSEYtdCuP9LLJxP4aHeS
 0RZAg4OMh1/asstKcn/cg1clYNSOfuPn3650XmtSk6QirRNoN9yAnMbIFObDcDaBLRRU
 IodSo5Khfkj9laUBe0/y3+jIh3iyIZrRUn2ggQ8ATLvnG7K6zWEVouf73EWnbIUjr5o4
 JctwvmdJ/SI2QEPP+3Xh44CsnFc1Ibzd2aIqqzV/kp9RxW91Ghm05y0BWHfYcy9ZqwVu
 3TvUeE66rabg/E9QbMJoRRruNydnwv4cjcBuH8AxrRgOMUel8GvnK3/Ia762OI0DerSS
 yKpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM1bP5A+KWPNHJNmvY5Y6q0qeDWUcS8+kcu98jPd1N6mYUSVX73zvrHwRwQbj190NX4vgVxfuOCArv@nongnu.org
X-Gm-Message-State: AFuF++lCLcE9o3tuh6pfYhoPo+SbviAqa5F1SEQ9pSPN8uxGyZqnWlLm
 h6HCjOuDwyV8Kr2a9sDJd/AHyMvnR52V9UXpjSgfg4kHRCYtryHFhg6LVujhFZ9yJ8JfJVBMDM/
 1bA81tGnDbDK2rgkYJG/phQ==
X-Received: from pjqs9.prod.google.com ([2002:a17:90a:ad89:b0:381:1b76:a387])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a81:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-39b2612eaa4mr45504979a91.10.1788923553153; 
 Tue, 08 Sep 2026 20:12:33 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:12:28 +0800
In-Reply-To: <20260909031229.1650315-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260909031229.1650315-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031229.1650315-2-stanleyjhu@google.com>
Subject: [PATCH v2 1/2] hw/ufs: Add experimental fault injection properties
 for task abort testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1048;
 envelope-from=3oc6gagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1048.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add experimental properties x-hold-tag and x-hold-mode to ufs-pci and
ufs-sysbus devices to facilitate end-to-end testing of host driver error
handling, task aborts, and SCSI recovery routines.

When x-hold-tag is set to a specific tag (0..255), the controller holds
the matching transfer request until a Task Management Request (TMR) targeting
the held request is issued by the host driver. If x-hold-tag=0xfffffffe
(UFS_HOLD_TAG_ANY), the controller intercepts the first READ_10/WRITE_10
request with LBA >= 512, avoiding guest boot-time metadata requests. The default
value is 0xffffffff (UFS_HOLD_TAG_NONE), which disables fault injection.

The x-hold-mode property controls how the held request and subsequent
recovery are resolved:
- "abort-success": TMR ABORT_TASK aborts the held request, clears its
  state, and returns SUCCESS (COMPL).
- "abort-failed": TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED.
- "in-transition": TMR QUERY_TASK / ABORT_TASK completes the held request
  successfully and returns COMPL (simulating a command completing in transition).
- "timeout": TMR ABORT_TASK does not complete, triggering TMR timeout.

Both properties support runtime modification via QOM (e.g., QMP qom-set),
enabling continuous fault injection testing within a single running VM.

Together with the companion Linux kernel patch:
  "[PATCH] scsi: ufs: core: Add fault injection for task abort failures"
  Link: https://lore.kernel.org/r/20260903235308.1240963-1-stanleyjhu@google.com/
these changes provide a deterministic testbed for automated CI/CD validation
across driver error recovery and emulation layers.

Based-on: <20260909031146.1646684-1-stanleyjhu@google.com>

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   3 +
 hw/ufs/ufs-pci.c    |   4 +
 hw/ufs/ufs-sysbus.c |   4 +
 hw/ufs/ufs.c        | 289 +++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h        |  54 +++++++++
 5 files changed, 339 insertions(+), 15 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 5e5a54a3fb..a2c8f80811 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -16,6 +16,9 @@ ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
 ufs_process_tmr(uint8_t func, uint32_t tag, uint8_t resp) "query_func 0x%"PRIx8", task_tag %"PRIu32", tm_resp 0x%"PRIx8""
+ufs_inject_hold_req(uint8_t tag, uint32_t lba) "held command tag %"PRIu8", lba %"PRIu32""
+ufs_set_hold_tag(uint32_t tag) "hold-tag set to 0x%"PRIx32""
+ufs_set_hold_mode(const char *mode) "hold-mode set to %s"
 ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
index 8abd7d98e3..fe6c497dc2 100644
--- a/hw/ufs/ufs-pci.c
+++ b/hw/ufs/ufs-pci.c
@@ -72,6 +72,10 @@ static const Property ufs_pci_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", UfsPciState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-hold-tag", UfsPciState, ufs.params.x_hold_tag,
+                         UFS_HOLD_TAG_NONE, ufs_prop_hold_tag, uint32_t),
+    DEFINE_PROP("x-hold-mode", UfsPciState, ufs.params.x_hold_mode,
+                ufs_prop_hold_mode, char *),
 };
 
 static const VMStateDescription ufs_pci_vmstate = {
diff --git a/hw/ufs/ufs-sysbus.c b/hw/ufs/ufs-sysbus.c
index 84de2e95ac..f0e4dfcd71 100644
--- a/hw/ufs/ufs-sysbus.c
+++ b/hw/ufs/ufs-sysbus.c
@@ -45,6 +45,10 @@ static const Property ufs_sysbus_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-hold-tag", SysbusUfsState, ufs.params.x_hold_tag,
+                         UFS_HOLD_TAG_NONE, ufs_prop_hold_tag, uint32_t),
+    DEFINE_PROP("x-hold-mode", SysbusUfsState, ufs.params.x_hold_mode,
+                ufs_prop_hold_mode, char *),
 };
 
 static const VMStateDescription ufs_sysbus_vmstate = {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ca5f6f2e96..3bdfe5762e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
 #include "trace.h"
@@ -816,6 +817,14 @@ static void ufs_hce_reset(UfsHc *u)
         memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
     }
 
+    if (u->held_req) {
+        u->held_req = NULL;
+        u->active_hold_tag = UFS_HOLD_TAG_NONE;
+        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
+    } else {
+        u->active_hold_tag = u->params.x_hold_tag;
+    }
+
     u->resetting = false;
 
     /* 5. De-assert IRQ */
@@ -873,27 +882,95 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
             task_tag = be32_to_cpu(desc.upiu_req.input_param2);
 
             if (tm_func == UFS_QUERY_TASK) {
-                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
-
-                if (req) {
-                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+                if (u->held_req && task_tag == u->active_hold_tag) {
+                    if (u->hold_mode == UFS_HOLD_IN_TRANSITION) {
+                        UfsRequest *hreq = u->held_req;
+                        u->held_req = NULL;
+                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
+                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                        if (hreq) {
+                            uint16_t data_seg_len =
+                                sizeof(hreq->rsp_upiu.sr.sense_data_len);
+                            hreq->rsp_upiu.sr.sense_data_len = 0;
+                            hreq->rsp_upiu.sr.residual_transfer_count = 0;
+                            ufs_build_upiu_header(hreq,
+                                                  UFS_UPIU_TRANSACTION_RESPONSE,
+                                                  0,
+                                                  UFS_COMMAND_RESULT_SUCCESS,
+                                                  0,
+                                                  data_seg_len);
+                            ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
+                        }
+                    } else {
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+                    }
                 } else {
-                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                    UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
+
+                    if (req) {
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+                    } else {
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                    }
                 }
             } else if (tm_func == UFS_ABORT_TASK) {
-                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
-
-                if (req) {
-                    ufs_clear_req(req);
-                    req->state = UFS_REQUEST_IDLE;
-                    if (ufs_mcq_req(req)) {
-                        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
-                        qemu_bh_schedule(req->sq->bh);
+                if (u->held_req && task_tag == u->active_hold_tag) {
+                    if (u->hold_mode == UFS_HOLD_ABORT_FAILED) {
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED;
+                    } else if (u->hold_mode == UFS_HOLD_TIMEOUT) {
+                        continue;
+                    } else if (u->hold_mode == UFS_HOLD_IN_TRANSITION) {
+                        UfsRequest *hreq = u->held_req;
+                        u->held_req = NULL;
+                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
+                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                        if (hreq) {
+                            uint16_t data_seg_len =
+                                sizeof(hreq->rsp_upiu.sr.sense_data_len);
+                            hreq->rsp_upiu.sr.sense_data_len = 0;
+                            hreq->rsp_upiu.sr.residual_transfer_count = 0;
+                            ufs_build_upiu_header(hreq,
+                                                  UFS_UPIU_TRANSACTION_RESPONSE,
+                                                  0,
+                                                  UFS_COMMAND_RESULT_SUCCESS,
+                                                  0,
+                                                  data_seg_len);
+                            ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
+                        }
                     } else {
-                        u->reg.utrldbr &= ~(1 << req->slot);
+                        /* UFS_HOLD_ABORT_SUCCESS or default */
+                        UfsRequest *hreq = u->held_req;
+                        u->held_req = NULL;
+                        ufs_clear_req(hreq);
+                        hreq->state = UFS_REQUEST_IDLE;
+                        if (ufs_mcq_req(hreq)) {
+                            QTAILQ_INSERT_TAIL(&hreq->sq->req_list,
+                                               hreq, entry);
+                            qemu_bh_schedule(hreq->sq->bh);
+                        } else {
+                            u->reg.utrldbr &= ~(1 << hreq->slot);
+                        }
+                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
+                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
+                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                    }
+                } else {
+                    UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
+
+                    if (req) {
+                        ufs_clear_req(req);
+                        req->state = UFS_REQUEST_IDLE;
+                        if (ufs_mcq_req(req)) {
+                            QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
+                            qemu_bh_schedule(req->sq->bh);
+                        } else {
+                            u->reg.utrldbr &= ~(1 << req->slot);
+                        }
                     }
+                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
                 }
-                tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
             } else {
                 tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_NOT_SUPPORTED;
             }
@@ -2327,6 +2404,42 @@ static void ufs_exec_req(UfsRequest *req)
         return;
     }
 
+    if (unlikely(req->hc->active_hold_tag != UFS_HOLD_TAG_NONE)) {
+        if (req->hc->active_hold_tag == UFS_HOLD_TAG_ANY) {
+            if (req->req_upiu.header.trans_type ==
+                UFS_UPIU_TRANSACTION_COMMAND) {
+                uint8_t op = req->req_upiu.sc.cdb[0];
+
+                if (op == READ_10 || op == WRITE_10) {
+                    /*
+                     * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
+                     * encode the 32-bit Logical Block Address (LBA) in
+                     * big-endian.
+                     */
+                    uint32_t lba = ldl_be_p(&req->req_upiu.sc.cdb[2]);
+
+                    /*
+                     * Only intercept target I/O targeting LBA >=
+                     * UFS_HOLD_MIN_LBA. Skips guest boot-time partition table
+                     * and superblock scanning.
+                     */
+                    if (lba >= UFS_HOLD_MIN_LBA) {
+                        req->hc->active_hold_tag =
+                            req->req_upiu.header.task_tag;
+                        req->hc->held_req = req;
+                        trace_ufs_inject_hold_req(req->req_upiu.header.task_tag,
+                                                  lba);
+                        return;
+                    }
+                }
+            }
+        } else if (req->req_upiu.header.task_tag == req->hc->active_hold_tag) {
+            req->hc->held_req = req;
+            trace_ufs_inject_hold_req(req->req_upiu.header.task_tag, 0);
+            return;
+        }
+    }
+
     switch (req->req_upiu.header.trans_type) {
     case UFS_UPIU_TRANSACTION_NOP_OUT:
         req_result = ufs_exec_nop_cmd(req);
@@ -2947,8 +3060,140 @@ static void ufs_init_hc(UfsHc *u)
 
     timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+
+    u->active_hold_tag = u->params.x_hold_tag;
+    u->held_req = NULL;
+}
+
+static void ufs_prop_get_hold_tag(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, x_hold_tag);
+    UfsHc *u = container_of(params, UfsHc, params);
+
+    visit_type_uint32(v, name, &u->active_hold_tag, errp);
+}
+
+static void ufs_prop_set_hold_tag(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t val;
+
+    if (!visit_type_uint32(v, name, &val, errp)) {
+        return;
+    }
+
+    *ptr = val;
+    UfsParams *params = container_of(ptr, UfsParams, x_hold_tag);
+    UfsHc *u = container_of(params, UfsHc, params);
+    u->active_hold_tag = val;
+    trace_ufs_set_hold_tag(val);
+}
+
+static void ufs_prop_set_default_hold_tag(ObjectProperty *op,
+                                          const Property *prop)
+{
+    object_property_set_default_uint(op, prop->defval.u);
 }
 
+const PropertyInfo ufs_prop_hold_tag = {
+    .type = "uint32",
+    .description = "Task tag to hold for fault injection",
+    .get = ufs_prop_get_hold_tag,
+    .set = ufs_prop_set_hold_tag,
+    .set_default_value = ufs_prop_set_default_hold_tag,
+    .realized_set_allowed = true,
+};
+
+static void ufs_prop_get_hold_mode(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, x_hold_mode);
+    UfsHc *u = container_of(params, UfsHc, params);
+    const char *str;
+    char *val;
+
+    switch (u->hold_mode) {
+    case UFS_HOLD_ABORT_FAILED:
+        str = "abort-failed";
+        break;
+    case UFS_HOLD_IN_TRANSITION:
+        str = "in-transition";
+        break;
+    case UFS_HOLD_TIMEOUT:
+        str = "timeout";
+        break;
+    case UFS_HOLD_ABORT_SUCCESS:
+    default:
+        str = "abort-success";
+        break;
+    }
+
+    val = g_strdup(str);
+    visit_type_str(v, name, &val, errp);
+    g_free(val);
+}
+
+static void ufs_prop_set_hold_mode(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+    char *str;
+    UfsHoldMode mode;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    if (!str || g_strcmp0(str, "abort-success") == 0) {
+        mode = UFS_HOLD_ABORT_SUCCESS;
+    } else if (g_strcmp0(str, "abort-failed") == 0) {
+        mode = UFS_HOLD_ABORT_FAILED;
+    } else if (g_strcmp0(str, "in-transition") == 0) {
+        mode = UFS_HOLD_IN_TRANSITION;
+    } else if (g_strcmp0(str, "timeout") == 0) {
+        mode = UFS_HOLD_TIMEOUT;
+    } else {
+        error_setg(errp, "invalid x-hold-mode: %s", str);
+        g_free(str);
+        return;
+    }
+
+    g_free(*ptr);
+    *ptr = str;
+    UfsParams *params = container_of(ptr, UfsParams, x_hold_mode);
+    UfsHc *u = container_of(params, UfsHc, params);
+    u->hold_mode = mode;
+    trace_ufs_set_hold_mode(str ? str : "abort-success");
+}
+
+static void ufs_prop_release_hold_mode(Object *obj, const char *name,
+                                       void *opaque)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+
+    g_free(*ptr);
+    *ptr = NULL;
+}
+
+const PropertyInfo ufs_prop_hold_mode = {
+    .type = "str",
+    .description = "Fault injection mode: abort-success, abort-failed, "
+                   "in-transition, timeout",
+    .get = ufs_prop_get_hold_mode,
+    .set = ufs_prop_set_hold_mode,
+    .release = ufs_prop_release_hold_mode,
+    .realized_set_allowed = true,
+};
+
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
 {
     u->dev = dev;
@@ -2958,6 +3203,20 @@ bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
         return false;
     }
 
+    if (!u->params.x_hold_mode ||
+        g_strcmp0(u->params.x_hold_mode, "abort-success") == 0) {
+        u->hold_mode = UFS_HOLD_ABORT_SUCCESS;
+    } else if (g_strcmp0(u->params.x_hold_mode, "abort-failed") == 0) {
+        u->hold_mode = UFS_HOLD_ABORT_FAILED;
+    } else if (g_strcmp0(u->params.x_hold_mode, "in-transition") == 0) {
+        u->hold_mode = UFS_HOLD_IN_TRANSITION;
+    } else if (g_strcmp0(u->params.x_hold_mode, "timeout") == 0) {
+        u->hold_mode = UFS_HOLD_TIMEOUT;
+    } else {
+        error_setg(errp, "invalid x-hold-mode: %s", u->params.x_hold_mode);
+        return false;
+    }
+
     qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, dev, dev->id);
     u->bus.hc = u;
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 265a43faaa..6edeab9db9 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -12,6 +12,7 @@
 #define HW_UFS_UFS_H
 
 #include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "block/ufs.h"
 #include "scsi/constants.h"
@@ -88,6 +89,48 @@ typedef struct UfsLu {
     UfsScsiOp scsi_op;
 } UfsLu;
 
+/*
+ * Fault injection modes for x-hold-mode property.
+ * Controls how the held transfer request and subsequent Task Management
+ * Request (TMR) are resolved by the controller:
+ *
+ * UFS_HOLD_ABORT_SUCCESS: TMR ABORT_TASK aborts the held request, clears its
+ *                         state, and returns SUCCESS (COMPL).
+ * UFS_HOLD_ABORT_FAILED:  TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED,
+ *                         forcing host driver to escalate to Host Reset.
+ * UFS_HOLD_IN_TRANSITION: TMR QUERY_TASK / ABORT_TASK completes the held
+ *                         request successfully and returns COMPL (simulating
+ *                         a command completing in transition / grace period).
+ * UFS_HOLD_TIMEOUT:       TMR ABORT_TASK does not complete or clear doorbell,
+ *                         triggering hardware-level TMR timeout.
+ */
+typedef enum UfsHoldMode {
+    UFS_HOLD_ABORT_SUCCESS = 0,
+    UFS_HOLD_ABORT_FAILED,
+    UFS_HOLD_IN_TRANSITION,
+    UFS_HOLD_TIMEOUT,
+} UfsHoldMode;
+
+/*
+ * Sentinel values for x-hold-tag property.
+ * Task Tags in UFS are 8-bit (0..255). Values >= 256 are reserved as
+ * sentinel flags to preserve full testability of Tag 0.
+ *
+ * UFS_HOLD_TAG_NONE: Disable fault injection (default).
+ * UFS_HOLD_TAG_ANY:  Automatically intercept the first user-space READ_10
+ *                    or WRITE_10 command targeting LBA >= UFS_HOLD_MIN_LBA.
+ */
+#define UFS_HOLD_TAG_NONE 0xffffffff
+#define UFS_HOLD_TAG_ANY  0xfffffffe
+
+/*
+ * Minimum Logical Block Address (LBA) for automatic fault injection.
+ * Skip early disk blocks (LBA 0..511, e.g. MBR, GPT partition tables, EFI,
+ * and filesystem superblocks) to ensure guest OS boot-time disk discovery
+ * and partition scanning complete cleanly without being held.
+ */
+#define UFS_HOLD_MIN_LBA 512
+
 typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
@@ -97,6 +140,8 @@ typedef struct UfsParams {
     uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
     uint32_t wb_max_size; /* WB Maximum allocation units */
     uint32_t wb_min_size; /* WB Minimum allocation units */
+    uint32_t x_hold_tag;
+    char *x_hold_mode;
 } UfsParams;
 
 /*
@@ -186,6 +231,11 @@ typedef struct UfsHc {
     uint32_t hid_fragment_count; /* Remaining fragmented 4KB units */
     uint32_t hid_defrag_total; /* Requested units at defrag start */
     uint32_t hid_defrag_remaining; /* Requested units left to move */
+
+    /* Test and fault injection properties */
+    uint32_t active_hold_tag;
+    UfsHoldMode hold_mode;
+    UfsRequest *held_req;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
@@ -309,4 +359,8 @@ void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
                  Error **errp);
 void ufs_unrealize(UfsHc *u);
+
+extern const PropertyInfo ufs_prop_hold_tag;
+extern const PropertyInfo ufs_prop_hold_mode;
+
 #endif /* HW_UFS_UFS_H */
-- 
2.55.0.1007.g17ff1f9808-goog


