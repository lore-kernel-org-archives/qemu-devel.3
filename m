Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558A9C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OHm-0006MH-BU; Wed, 23 Sep 2026 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37OazagoKCuUZaHUSLfQObNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHj-0006LA-3Z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:23 -0400
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37OazagoKCuUZaHUSLfQObNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHf-000152-Hz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:21 -0400
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so8957875ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174957; x=1790779757; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8eXb32QEzF+kzaTsAe5WTIW2k9xxlgn60VfDpElTFHU=;
 b=Qbv/Ru5LibT2rG5b8oK6gN0BaEZXFbT+aPbQM3v5ngFqc0lBgs9fee4cMzhjVe8HYg
 p6ZvxLTHDH1mqUBt/4+mXth3mALR+dvaRPDr3z1A4A6c7FEHqUPgA7VeblsIJE34G9LZ
 tC18F2IC/O1DS6HJO+18BsxE1U4az6TyjHXIAkYfp0CXTYD7xb4y/SB8WRI+uH/BeTil
 iBFTciBaQKHG2yPJHVPSfzMyScXa+GosMpqZTnPKHRg3ZFz6FFptcHpBzFzfcMTTxYz2
 jV3ark0Su+2uRKFulpbfRXsKhrdzeoTIpmBg6dIZ8MzGMz0bz6ULWIYk8OYQoIA1Xy85
 pqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174957; x=1790779757;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8eXb32QEzF+kzaTsAe5WTIW2k9xxlgn60VfDpElTFHU=;
 b=shx/NMn/KVcLu4BHgHyIH0/WT26nXYlR9uS4SX61c8EqRvHlJPnyY2g814Yq0esHKT
 jAy7F3jAAzJYIN1nQQYq1BWJb0BLC9KOBsktbwEAaoEVjgkGbK/HfQizuHlVAKjhGzwW
 xBmynKQ7Ncqi/yDEdAz+hCnhyq9mZrbMfwfjNE0+8IW6OENefdXcuRfzs8d++5ClFUDJ
 Wf6YWXBuZ74XDKLL1fKXrNtvQ1N1MSazJ4vGPfegCBhRgFw3uMA1FuNB9UtLuOcI/pHh
 q/m95y2XVRrAjnVqC5Y7ob4aQuU5jTCi+b07zvm4vvA9BHNgAg/pbgZQOr+0TwZWSq9c
 rIzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsUUWhq/lCBNf5qJDelL0JhgDjGKyEFI2EqIZHQL7jhVATDQhpXYobOQyeMyuq2t9OFoLKQH+POGWN@nongnu.org
X-Gm-Message-State: AFuF++kb7FHc87V5coxmpVYO/PiffnWY3dN7vFW737GbTVQrZfpohAD0
 aF43HosLSiLduhPmno77x+INhRgVIplG0MLVJAc3rRt+q4Nu5a5ItphjlEmcxZZuoyjKUj3VCD3
 VoW1fR4YVAqg3PmSiZI3UBA==
X-Received: from pjbmv23.prod.google.com ([2002:a17:90b:1997:b0:3a0:8da2:2dbd])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e82:b0:3a0:42a9:9c78 with SMTP id
 98e67ed59e1d1-3a07e6144c4mr2570968a91.41.1790174956746; 
 Wed, 23 Sep 2026 07:49:16 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:48:10 +0800
In-Reply-To: <20260923144911.2877141-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260923144911.2877141-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923144911.2877141-3-stanleyjhu@google.com>
Subject: [PATCH v3 2/3] hw/ufs: Support MCQ runtime interrupt and queue status
 registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: Stanley Jhu <stanleyjhu@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::648;
 envelope-from=37OazagoKCuUZaHUSLfQObNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x648.google.com
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

Implement Multi-Circular Queue (MCQ) runtime operational registers
(SQnRTC, SQnRTS, SQnCTI, SQnIS/IE, CQnIS/IE, CQnIACR) per JEDEC UFSHCI:

- Support SQ start, stop, and cleanup (SQnRTC.ICU) using Submission
  Queue Cleanup Task Information (SQnCTI) to abort the target request
  and post a CQE with OCS = UFS_OCS_ABORTED.
- Implement write-1-to-clear per-queue interrupt status (SQnIS, CQnIS)
  and synchronize the global IS.CQES bit.
- Reset MCQ runtime operational registers across HCE resets.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 111 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |  15 ++++++
 3 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 9222933..d8173b1 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -14,6 +14,7 @@ ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32
 ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
 ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
+ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
 ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index adae663..4d8c641 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -446,13 +446,14 @@ static void ufs_mcq_process_sq(void *opaque)
 {
     UfsSq *sq = opaque;
     UfsHc *u = sq->u;
+    UfsMcqOpReg *opr = &u->mcq_op_reg[sq->sqid];
     UfsSqEntry sqe;
     UfsRequest *req;
     hwaddr addr;
     uint16_t head = ufs_mcq_sq_head(u, sq->sqid);
     int err;
 
-    if (u->resetting) {
+    if (u->resetting || FIELD_EX32(opr->sq.rts, SQRTS, STS)) {
         return;
     }
 
@@ -536,6 +537,7 @@ static void ufs_mcq_process_cq(void *opaque)
         }
 
         ufs_clear_req(req);
+        req->state = UFS_REQUEST_IDLE;
         QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
     }
 
@@ -770,7 +772,17 @@ static void ufs_hce_reset(UfsHc *u)
     u->reg.utmrldbr = 0;
     u->reg.utrlcnr = 0;
     u->reg.utrlrsr = 0;
+    u->reg.utriacr = 0;
+    u->reg.utrlclr = 0;
+    if (u->params.mcq) {
+        u->reg.mcqconfig = FIELD_DP32(0, MCQCONFIG, MAC, 0x1f);
+    } else {
+        u->reg.mcqconfig = 0;
+    }
+    u->reg.ie = 0;
     u->reg.is = 0;
+    u->reg.utrlba = 0;
+    u->reg.utrlbau = 0;
 
     /* 4. Free MCQ Queues and reset MCQ dynamic registers */
     if (u->params.mcq) {
@@ -970,6 +982,45 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
     qemu_bh_schedule(sq->bh);
 }
 
+static void ufs_mcq_sq_cleanup(UfsHc *u, uint8_t qid)
+{
+    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+    UfsSq *sq = u->sq[qid];
+    uint8_t task_tag = FIELD_EX32(opr->sq.cti, SQCTI, TASK_TAG);
+    uint8_t lun = FIELD_EX32(opr->sq.cti, SQCTI, LUN);
+    UfsRequest *req = NULL;
+
+    if (sq) {
+        for (int i = 0; i < sq->size; i++) {
+            UfsRequest *candidate = &sq->req[i];
+            if ((candidate->state == UFS_REQUEST_RUNNING ||
+                 candidate->state == UFS_REQUEST_ERROR) &&
+                candidate->req_upiu.header.task_tag == task_tag &&
+                candidate->req_upiu.header.lun == lun) {
+                req = candidate;
+                break;
+            }
+        }
+    }
+
+    if (req) {
+        if (req->sreq != NULL) {
+            SCSIRequest *sreq = req->sreq;
+            req->sreq = NULL;
+            scsi_req_cancel(sreq);
+        }
+        req->utrd.header.dword_2 = cpu_to_le32(
+            (le32_to_cpu(req->utrd.header.dword_2) & ~UFS_MASK_OCS) |
+            UFS_OCS_ABORTED);
+        req->state = UFS_REQUEST_COMPLETE;
+        QTAILQ_INSERT_TAIL(&sq->cq->req_list, req, entry);
+        ufs_mcq_process_cq(sq->cq);
+    }
+
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 1);
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, 0);
+}
+
 static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
                                  unsigned size)
 {
@@ -983,6 +1034,9 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
 
     opr = &u->mcq_op_reg[qid];
 
+    trace_ufs_write_mcq_op_reg(qid, (uint32_t)(offset % sizeof(UfsMcqOpReg)),
+                               data);
+
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
         if (opr->sq.tp != data) {
@@ -990,6 +1044,40 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
+    case offsetof(UfsMcqOpReg, sq.rtc):
+        if (FIELD_EX32(data, SQRTC, STOP)) {
+            /* SQ_STOP: Stop queue */
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, STS, 1);
+            if (u->sq[qid] && u->sq[qid]->bh) {
+                qemu_bh_cancel(u->sq[qid]->bh);
+            }
+        } else {
+            /* SQ_START: Start queue */
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, STS, 0);
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 0);
+            if (u->sq[qid] && u->sq[qid]->bh) {
+                qemu_bh_schedule(u->sq[qid]->bh);
+            }
+        }
+        if (FIELD_EX32(data, SQRTC, ICU)) {
+            if (FIELD_EX32(opr->sq.rts, SQRTS, STS)) {
+                /* SQ_ICU: Initiate Cleanup while queue is stopped */
+                ufs_mcq_sq_cleanup(u, qid);
+            }
+            data = FIELD_DP32(data, SQRTC, ICU, 0);
+        }
+        opr->sq.rtc = data;
+        break;
+    case offsetof(UfsMcqOpReg, sq.cti):
+        opr->sq.cti = data;
+        break;
+    case offsetof(UfsMcqOpReg, sq_int.is):
+        opr->sq_int.is &= ~data;
+        ufs_irq_check(u);
+        break;
+    case offsetof(UfsMcqOpReg, sq_int.ie):
+        opr->sq_int.ie = data;
+        break;
     case offsetof(UfsMcqOpReg, cq.hp): {
         UfsCq *cq = u->cq[qid];
 
@@ -1006,8 +1094,27 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         ufs_mcq_update_cq_head(u, qid, data);
         break;
     }
-    case offsetof(UfsMcqOpReg, cq_int.is):
+    case offsetof(UfsMcqOpReg, cq_int.is): {
+        bool pending = false;
+
         opr->cq_int.is &= ~data;
+        for (int i = 0; i < ARRAY_SIZE(u->mcq_op_reg); i++) {
+            if (u->mcq_op_reg[i].cq_int.is) {
+                pending = true;
+                break;
+            }
+        }
+        if (!pending) {
+            u->reg.is = FIELD_DP32(u->reg.is, IS, CQES, 0);
+        }
+        ufs_irq_check(u);
+        break;
+    }
+    case offsetof(UfsMcqOpReg, cq_int.ie):
+        opr->cq_int.ie = data;
+        break;
+    case offsetof(UfsMcqOpReg, cq_int.iacr):
+        opr->cq_int.iacr = data;
         break;
     default:
         trace_ufs_err_invalid_register_offset(offset);
diff --git a/include/block/ufs.h b/include/block/ufs.h
index d19b3c6..b72403c 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -224,6 +224,21 @@ typedef struct QEMU_PACKED UfsMcqSqReg {
     uint32_t rts;
 } UfsMcqSqReg;
 
+REG32(SQRTC, offsetof(UfsMcqSqReg, rtc))
+    FIELD(SQRTC, STOP, 0, 1)
+    FIELD(SQRTC, ICU, 1, 1)
+
+REG32(SQCTI, offsetof(UfsMcqSqReg, cti))
+    FIELD(SQCTI, TASK_TAG, 0, 8)
+    FIELD(SQCTI, LUN, 8, 8)
+    FIELD(SQCTI, IID, 16, 4)
+    FIELD(SQCTI, EXT_IID, 20, 4)
+
+REG32(SQRTS, offsetof(UfsMcqSqReg, rts))
+    FIELD(SQRTS, STS, 0, 1)
+    FIELD(SQRTS, CUS, 1, 1)
+    FIELD(SQRTS, RTC, 4, 4)
+
 typedef struct QEMU_PACKED UfsMcqCqReg {
     uint32_t hp;
     uint32_t tp;
-- 
2.56.0.rc1.310.g51773c2048-goog


