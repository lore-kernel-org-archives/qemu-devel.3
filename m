Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEAC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1g8q-0000jX-HR; Wed, 02 Sep 2026 04:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TNuXagoKCr0vwdqoh1mkxjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--stanleyjhu.bounces.google.com>)
 id 1x1g8n-0000jH-Fr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:16:18 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TNuXagoKCr0vwdqoh1mkxjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--stanleyjhu.bounces.google.com>)
 id 1x1g8l-0002rD-Bd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:16:17 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso798201a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788336973; x=1788941773; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+DqXSiXSd5Ap8jDYZFTtLp1p/eHTiuNOtfvZN48ftLs=;
 b=QpalH68CU/1ebQbKJg5vwkphME2lLER7AnrCW5FuwhXZJDr/aHR22FhgESnrfdgM0G
 /4b76TQ3E8shID81KfK8L0lhgZxmg7n+qzv8CZnJYJiSMOd44ZfiBtuubTv5lDngEhqV
 uj+UhRDuArDix/zedF7IJ8dZ/w2wuleWyIjWGcnqEHvxKfQF76fuRDYIbCT015UdnFBn
 lfTt2gLXD5hXXdCh8Ay2vNeNLE2XhJMRdMnIBKcI4WrKqJ180Cw9zoA0undIs5vb6lGv
 AaxPX5nGBvvpvKC3EPbs4CcOq2ugMCUglfYIXuqh1WmsAvNUiJJJQgSGYpfi9Mel6nvM
 Vm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788336973; x=1788941773;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+DqXSiXSd5Ap8jDYZFTtLp1p/eHTiuNOtfvZN48ftLs=;
 b=TbndPTNKfFIQA2Q0sdS3jtA3qNytbCxIboJDUvYq4TavOevaft4vEgxiRMiuXuePqV
 ViLyb6G1eVELzn5Mj74vj+7lyDQf8Kt2LOsfiG/DWsoppBQvQPVn/JmN0n28HMP0p/n9
 WD51fH7Vx9dzRo2SuC/ffqXBhB6tgzkf1PtK3KzBVYuRTu9d0sxiXGWZ3Clp51Q1TAPX
 +fUGVdwBTnqJh9B8CNlnNEB/X/vf55nrQP6oP0QVp96v1WJlEZwrZSLO7vfpcAlmjoan
 AzhxtXKoubI8eT8lfPrdDW+MHjnch+uGKd43NSz2gRCa7bwvQzB2smflAURxuScCk1iQ
 YPvA==
X-Gm-Message-State: AFuF++lwOSaxTOFvbw4I3ew2hMiSFGgW7WqsobvxPXemzSG4PrLkDvWT
 wOtPMXk9YRhgNNlP3luj4oIVJ+xYEK5EFuuj88rW8mCbUmDrgch8U1N9JyTbtlxzAjw5nakS+Id
 PGBTLanlyt16GLHueRBKGHg==
X-Received: from pgbaz16.prod.google.com ([2002:a05:6a02:50:b0:cbe:9dc7:9ee8])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a120:b0:3d3:afd9:6197 with SMTP id
 adf61e73a8af0-3d9b0f41d74mr4274774637.27.1788336972411; 
 Wed, 02 Sep 2026 01:16:12 -0700 (PDT)
Date: Wed,  2 Sep 2026 16:16:10 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902081610.2290123-1-stanleyjhu@google.com>
Subject: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE transition
 to 0
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@gmail.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3TNuXagoKCr0vwdqoh1mkxjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
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

According to the JEDEC Universal Flash Storage Host Controller Interface
(UFSHCI) specification (Section 5.2.1 "Host Controller Enable"):
when Host Controller Enable (HCE) transitions from 1 to 0, a host
controller reset is initiated. The host controller shall abort all
active transfers, return internal state machines to idle, and de-assert
all interrupts.

Currently, QEMU's UFS emulator only clears HCS and HCE registers upon
HCE=0, leaving internal state active. Specifically:
- Outstanding SCSI requests in the block layer are not purged.
- Active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq BHs)
  remain scheduled.
- Allocated MCQ Submission and Completion Queues (sq and cq) are
  not freed.
- Dynamic MCQ queue registers, legacy UTRL request states, and status
  registers (UTRLCNR, UTRLRSR) remain stale.

Implement ufs_hce_reset() to:
1. Implement .cancel callback in ufs_scsi_info to properly unref
   scsi_req and prevent reference leaks when SCSI requests are purged.
2. Cancel active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq
   BHs) and guard them with a resetting flag before purging requests,
   ensuring blk_drain() cannot run or reschedule request-producing BHs.
3. Purge outstanding SCSI requests for all logical units via
   scsi_device_purge_requests().
4. Clear standard request list slots and release SGLs via
   ufs_clear_req(), and clear doorbells and status registers (UTRLCNR,
   UTRLRSR).
5. Free allocated MCQ queues and clear dynamic queue registers while
   preserving static capability offsets.
6. De-assert interrupts via ufs_irq_check().
7. Add a trace_ufs_hce_reset() trace event.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
v2 -> v3:
- Rebased on top of current upstream master (resolving context conflict
  with recently merged Write Booster in hw/ufs/ufs.h).
- Fixed patch formatting and line-wrapping issues.

v1 -> v2:
- Added ufs_scsi_command_cancelled() as .cancel callback in ufs_scsi_info
  to drop scsi_req reference and avoid leaks upon purge (Jeuk Kim).
- Reordered sequence to cancel all active BHs before
  scsi_device_purge_requests() and introduced resetting flag to prevent
  CQ BH from rescheduling SQ BH during blk_drain() (Jeuk Kim).
- Cleared UTRLCNR and UTRLRSR registers upon reset (Jeuk Kim).
- Guarded ufs_process_req() and ufs_complete_req() against execution while
  resetting is in progress.
- Cleaned up array address-of idiom in mcq_op_reg memset.
---
 hw/ufs/lu.c         |  7 ++++
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 96 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |  2 +
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index eeca865..bdb1650 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -188,6 +188,12 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     scsi_req_unref(scsi_req);
 }
 
+static void ufs_scsi_command_cancelled(SCSIRequest *scsi_req)
+{
+    scsi_req->hba_private = NULL;
+    scsi_req_unref(scsi_req);
+}
+
 static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
 {
     UfsRequest *req = scsi_req->hba_private;
@@ -202,6 +208,7 @@ static const struct SCSIBusInfo ufs_scsi_info = {
 
     .get_sg_list = ufs_get_sg_list,
     .complete = ufs_scsi_command_complete,
+    .cancel = ufs_scsi_command_cancelled,
 };
 
 static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 0cd3ba9..9222933 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -14,6 +14,7 @@ ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32
 ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
 ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
+ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 160a4ac..3c4d742 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -452,6 +452,10 @@ static void ufs_mcq_process_sq(void *opaque)
     uint16_t head = ufs_mcq_sq_head(u, sq->sqid);
     int err;
 
+    if (u->resetting) {
+        return;
+    }
+
     while (!(ufs_mcq_sq_empty(u, sq->sqid) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->addr + head;
         err = ufs_addr_read(sq->u, addr, (void *)&sqe, sizeof(sqe));
@@ -525,7 +529,7 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);
 
-        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+        if (!u->resetting && QTAILQ_EMPTY(&req->sq->req_list) &&
             !ufs_mcq_sq_empty(u, req->sq->sqid)) {
             /* Dequeueing from SQ was blocked due to lack of free requests */
             qemu_bh_schedule(req->sq->bh);
@@ -722,6 +726,87 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
     return true;
 }
 
+static void ufs_hce_reset(UfsHc *u)
+{
+    int i;
+
+    trace_ufs_hce_reset();
+
+    u->resetting = true;
+
+    /* 1. Cancel active Bottom Halves before purging requests */
+    if (u->doorbell_bh) {
+        qemu_bh_cancel(u->doorbell_bh);
+    }
+    if (u->complete_bh) {
+        qemu_bh_cancel(u->complete_bh);
+    }
+    if (u->params.mcq) {
+        for (i = 0; i < ARRAY_SIZE(u->sq); i++) {
+            if (u->sq[i] && u->sq[i]->bh) {
+                qemu_bh_cancel(u->sq[i]->bh);
+            }
+        }
+        for (i = 0; i < ARRAY_SIZE(u->cq); i++) {
+            if (u->cq[i] && u->cq[i]->bh) {
+                qemu_bh_cancel(u->cq[i]->bh);
+            }
+        }
+    }
+
+    /* 2. Purge outstanding SCSI requests for all logical units */
+    for (i = 0; i < UFS_MAX_LUS; i++) {
+        if (u->lus[i] && u->lus[i]->scsi_dev) {
+            scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));
+        }
+    }
+
+    /* 3. Reset standard request list slots, doorbells, and status registers */
+    for (i = 0; i < u->params.nutrs; i++) {
+        ufs_clear_req(&u->req_list[i]);
+        u->req_list[i].state = UFS_REQUEST_IDLE;
+    }
+    u->reg.utrldbr = 0;
+    u->reg.utmrldbr = 0;
+    u->reg.utrlcnr = 0;
+    u->reg.utrlrsr = 0;
+    u->reg.is = 0;
+
+    /* 4. Free MCQ Queues and reset MCQ dynamic registers */
+    if (u->params.mcq) {
+        for (i = 0; i < ARRAY_SIZE(u->sq); i++) {
+            if (u->sq[i]) {
+                ufs_mcq_free_sq(u->sq[i]);
+                u->sq[i] = NULL;
+            }
+        }
+        for (i = 0; i < ARRAY_SIZE(u->cq); i++) {
+            if (u->cq[i]) {
+                ufs_mcq_free_cq(u->cq[i]);
+                u->cq[i] = NULL;
+            }
+        }
+
+        /* Clear dynamic queue configuration registers without overwriting static capability offsets */
+        for (i = 0; i < ARRAY_SIZE(u->mcq_reg); i++) {
+            u->mcq_reg[i].sqattr = 0;
+            u->mcq_reg[i].sqlba = 0;
+            u->mcq_reg[i].squba = 0;
+            u->mcq_reg[i].sqcfg = 0;
+            u->mcq_reg[i].cqattr = 0;
+            u->mcq_reg[i].cqlba = 0;
+            u->mcq_reg[i].cquba = 0;
+            u->mcq_reg[i].cqcfg = 0;
+        }
+        memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
+    }
+
+    u->resetting = false;
+
+    /* 5. De-assert IRQ */
+    ufs_irq_check(u);
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
 {
     switch (offset) {
@@ -739,6 +824,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 1);
         } else if (FIELD_EX32(u->reg.hce, HCE, HCE) &&
                    !FIELD_EX32(data, HCE, HCE)) {
+            ufs_hce_reset(u);
             u->reg.hcs = 0;
             u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 0);
         }
@@ -2089,6 +2175,10 @@ static void ufs_process_req(void *opaque)
     UfsRequest *req;
     int slot;
 
+    if (u->resetting) {
+        return;
+    }
+
     for (slot = 0; slot < u->params.nutrs; slot++) {
         req = &u->req_list[slot];
 
@@ -2115,6 +2205,10 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 
     req->state = UFS_REQUEST_COMPLETE;
 
+    if (u->resetting) {
+        return;
+    }
+
     if (ufs_mcq_req(req)) {
         trace_ufs_mcq_complete_req(req->sq->sqid);
         QTAILQ_INSERT_TAIL(&req->sq->cq->req_list, req, entry);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index aa8361d..6f2693b 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -173,6 +173,8 @@ typedef struct UfsHc {
     UfsSq *sq[UFS_MAX_MCQ_QNUM];
     UfsCq *cq[UFS_MAX_MCQ_QNUM];
 
+    bool resetting;
+
     /* Extended features */
     UfsWb wb;
 
-- 
2.55.0.970.g62bdec98f9-goog


