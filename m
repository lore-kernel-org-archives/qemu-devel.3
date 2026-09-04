Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087EBC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NOS-0008JK-Kb; Fri, 04 Sep 2026 02:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wWSaagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOQ-0008Ix-Qf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:18 -0400
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wWSaagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOO-0005GL-7b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:18 -0400
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so1369917a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788503234; x=1789108034; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oSxdKRCoxJ45xFJYh1BrvaQrPuHDiqV9wvIaYazWdJs=;
 b=twqzY8BZqgS1hL1z6DInEte7SDjLYc9lsiOi1glximJGYW6Pnpn1U57WRXGqcUgXI5
 Izc05ZiNEuC4BMjPaaskAlLOWFcNbe6Twy0VVmW8rARKJp+DzAAtYBU1Noe0HFKgFLF8
 CUwKUu3L169dmL6zUGC4pMIiwXTvD3MMFpH+x6acMutfEVVm3ETeqP4ZAqle5LIOffD9
 JMIYbJoRA4/2w8kXVYUTN6KOFh329Kb86PS68aEw8HKHjlQdldldOrHHER+5JzxEIOlF
 p67maJx8uOiKPanoOpD+g89gdY8xRZUQUjGaXpl0ltJjO2xF820gNJTw/IMeTp82tWe+
 OwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503234; x=1789108034;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oSxdKRCoxJ45xFJYh1BrvaQrPuHDiqV9wvIaYazWdJs=;
 b=fX9QhPASA0vZqZBVDrGykuqhLVHIUq8WR9n5fCpMfKJW3tevJ6EAPsc5IIIzXEPf3I
 DBRleIw9LjojHUh68VavSFVWETmWdVzuE3Vsq3i7wLSMVFjvFGG8gVdycGdVyWuOVIK0
 n6gxr4AnfZciowdWuzl2D7a6R5BkSgE1MHAwic270jXkNwis/rZbWtqeEH7nGVsMpXAm
 d0ZuXnZevVnm01eBM1i1zZA0d5vjGjFY0QlLbbj7m2k1KRC6tFPGRdR+eibsFs8wVtI7
 973/qgul/Hh1r+G+qOxEU3Z7lJOol7ZwaiR2t2DVLlt1kDeqcKCwg6Y+AxjhCZkrz31V
 Q6nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWTY0ka1zA02EOWUPMWJJFVoAXD5hvQ+HtA/WGxNmbwK8X9iL/7a7nQbyumK281mQe32EoNrc0cYvK@nongnu.org
X-Gm-Message-State: AFuF++nIunzXKuThO88nVvYjxnsxwSBOTGPw39XF9BOd+1HFY+fDnqNR
 bAgu8Idcl3Ng0OKH7pagyAafgpcZ//MW3ZBtEkRbRF/DISwlEXYsAcI+kbq0KMRrVKaFEy9apHG
 uSBOV9HuL7WLwCPB+oCpf7Q==
X-Received: from pjbmv9.prod.google.com ([2002:a17:90b:1989:b0:398:c7c7:ede1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3809:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39b261014e2mr5300992a91.7.1788503233771; 
 Thu, 03 Sep 2026 23:27:13 -0700 (PDT)
Date: Fri,  4 Sep 2026 14:27:06 +0800
In-Reply-To: <20260904062706.2684958-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260904062706.2684958-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904062706.2684958-4-stanleyjhu@google.com>
Subject: [PATCH 3/3] hw/ufs: Add experimental fault injection properties for
 task abort testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@gmail.com>, Jinyoung Choi <j-young.choi@samsung.com>, 
 qemu-block@nongnu.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1045;
 envelope-from=3wWSaagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1045.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
handling and task abort recovery routines.

When x-hold-tag is set to a specific tag (0..255), the controller holds
(delays completing) the matching transfer request until a Task
Management Request (TMR) targeting the held request is issued by the
host driver. If x-hold-tag=0xfffffffe (UFS_HOLD_TAG_ANY), the
controller automatically intercepts the first READ_10/WRITE_10 request
with LBA >= 512, avoiding guest boot-time metadata requests. The default
value is 0xffffffff (UFS_HOLD_TAG_NONE), which disables fault injection
while preserving full testability of Tag 0.

The x-hold-mode property controls how the held request and subsequent
TMR are resolved:
- "abort-success": TMR ABORT_TASK aborts the held request, clears its
  state, and returns SUCCESS (COMPL).
- "abort-failed": TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED.
- "in-transition": TMR QUERY_TASK / ABORT_TASK completes the held request
  successfully and returns COMPL (simulating a command completing in transition).
- "timeout": TMR ABORT_TASK does not complete, triggering TMR timeout.

Both properties allow runtime modification on realized devices via QOM
(e.g., QMP qom-set), enabling continuous, multi-case fault injection
testing within a single running VM without requiring reboot cycles.

Together with the companion Linux kernel patch:
  "[PATCH] scsi: ufs: core: Add fault injection for task abort failures"
  Link: https://lore.kernel.org/r/20260903235308.1240963-1-stanleyjhu@google.com/
these QEMU changes provide a deterministic testbed to verify UFS exception
cases and ensure controller/driver health. This setup is particularly
useful for establishing automated CI/CD pipelines to prevent regressions
across future Linux kernel UFS driver and QEMU emulation changes.

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
index c7064f1825..2c3d608c1e 100644
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
@@ -2323,6 +2400,42 @@ static void ufs_exec_req(UfsRequest *req)
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
@@ -2942,8 +3055,140 @@ static void ufs_init_hc(UfsHc *u)
 
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
@@ -2953,6 +3198,20 @@ bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
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
2.55.0.979.g7e5102b832-goog


