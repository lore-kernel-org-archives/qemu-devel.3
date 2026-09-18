Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DEBC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M9t-0001Kp-E5; Thu, 17 Sep 2026 20:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7M9l-0000wj-CQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:08:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7M9j-00053T-2J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:08:45 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd77300825so1701615ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690121; x=1790294921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GbkI346fxcHA/nXGhCmqFivbP5y+/rqRpb0D7kL2b0w=;
 b=cEV5JpBkoi10Z5nSKi/cnht8t2tZx0e1tcfrSPfNBBIZRoXXT1d2PuPGDCJPpqCllY
 co/cxx76Kc5vbTRMEhklLY2E69BvZ9cOWKWBHogjcb9F3dJ/Q1mr8lpdVkne1Uorq0v7
 IdT9+uyLkSepisa6bMWfACZt9bElCWAxanqi61xPreQWiERIxSypeMvlrogm59vrzwr5
 kc1b7daGKFJzotU5XOFF8iVGFB6wDRViptcilpucZEFFxggLeFRO6wYfNkJSSAgxgwLk
 YTs8D6U2ivcSofT3mAjKcbis9eSvQgnw2m1NWEAqFhN6lc0Do053Jb8ettLGCStwxre4
 3EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690121; x=1790294921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GbkI346fxcHA/nXGhCmqFivbP5y+/rqRpb0D7kL2b0w=;
 b=1ARcr+XK0mZMAbTOjGrwjonJsbzCHUzNTTwNHpOSnh/XJp0/fNfMufsRykpn2l/pkH
 8lMUP4Fmi09awIqeewV6qeCH6XIuYd/rKHh9D2zdrsH3tPZ/W6doD2PjsjbUGEg1wXjG
 BWdH1cxBlHZ2DRZoFx3Fmyrk49havfJdELhmG8JQax3EZYa9YwZYrfG5W6fw8991Q0yY
 Ps+GsBrZagpMV/f9h0P9ELOrfGKWF85rJi2mLDUeQQxdb5RYvTkGPDkcvqvVBVRgc7cy
 YJKPk7F5fHnowLRuJWdW4L0S6KS844PScnnGYUFaFMgDwGT1Uf0SgvfG2U3Z2jx8KA5z
 fQGQ==
X-Gm-Message-State: AFuF++mQHvFLmZZ9rL+6Q1qD7Pi/P3FVHPs/qL5r7Wda104fiC6RMtUe
 7OE7eH5Ib2jL27tO3T50td9lnai8PgaA9B2qPDsguvE6rhA498Iwbzlr5zVPAw==
X-Gm-Gg: AYBFou2kZ6KvmRYnKVzfEB4wBHn2JXDEYdqx+iP4NVOHdsB9LGHirCkYcnj326NHPBO
 Jq8zlBGOjO4t+grvQn3bRbleaPi49BgzGmsL95NV2D115Zf3S6LZZkXB9GmO/1qe8X+QTb2NWPt
 aQgW1qDK3+78pgc15dErZyUPU96q7T7H6Y3DptmVLn9pKekAp+cvBcUT084bC5xkLFu88ZWkOy9
 cIErLfFQbdLxQBR4CMIK2h8hcifKfsloL52hUEj35B9VtKlAGJzuwojPoU1mB4wpR1LfjG9W70X
 +AMVJA2/qZzeQVCvlpE055UCTu6pmwAdf8qGu7IhtGvf9ffEgsUk+ceOAYJEKL3Fhyr/jM0DNQs
 Bg9KP2jVUiXr7rN+V3l/d/YTC6P0+o+KwouUpCCElcPJRqrL2VWmWa0OWLMCpseifhWQ6LlVfOZ
 h29+ym0t46/BkHjz/ZcJbS+u13iwNXDjraHpH7sNj2I+jzO5owoTq3Ke7Zmy7NdJNyEP1PKso6M
 o2p
X-Received: by 2002:a17:90b:3f84:b0:39e:4c7e:f042 with SMTP id
 98e67ed59e1d1-39e54f91d4amr1528550a91.31.1789690121325; 
 Thu, 17 Sep 2026 17:08:41 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e5a5993bbsm33827a91.17.2026.09.17.17.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:08:41 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 stanleyjhu@google.com, richard.henderson@linaro.org, stefanha@redhat.com
Subject: [PULL 1/1] hw/ufs: Reset controller and MCQ state on HCE transition
 to 0
Date: Fri, 18 Sep 2026 09:08:17 +0900
Message-ID: <cc1d72231c925a632f360937d9eb48ea12bd539c.1789689763.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789689763.git.jeuk20.kim@samsung.com>
References: <cover.1789689763.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stanley Jhu <stanleyjhu@google.com>

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
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c         |  7 ++++
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 96 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |  2 +
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index eeca865eb5..bdb1650851 100644
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
index 0cd3ba9b02..922293355b 100644
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
index 160a4ac4f3..3c4d7424da 100644
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
index aa8361d93d..6f2693b7ca 100644
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
2.43.0


