Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2ECA6001
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTj-0002bR-B9; Mon, 05 Oct 2026 07:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-IPDagoKCmsbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTd-0002Zb-G3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:25 -0400
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-IPDagoKCmsbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTb-0005Qe-G4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:25 -0400
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cc72777faa2so1186365a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198201; x=1791803001; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DquBNqapPFvSrSvuzaqbhHyPBctiNwwc9aHt5UXK6eA=;
 b=kHJy4rZy4bb34wuwjjJSikJtQbKd5uSwcPTgKrNUW2AcEM4V460NulgSbjCDgO5mXN
 0oDiKWUZWNIET0Xa0z2Q+1NuZcXrPWEv/7FbJmPNZRHFq4Nq+ytzwUGIm3nJhtf94MZV
 lvK8uVUVK0nxEOszIumJDPBAgFHktOUlUPD7vuzT59FSU9FGQlZYEf32Z9aj8UvZg4qz
 cTwpBTtDrwY1Uy7SlMHEYH0jqDsG0ETyV0DTtysyaTdfsQx5p+1dgTmhzTMxCN/QFjBE
 QpMIqKwl1JmZ00bvrHAkJ9C2221Wg+uoaOmD4Knewkzbyj1E/m0W7rWbqSUWtAPgJaSi
 wtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198201; x=1791803001;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DquBNqapPFvSrSvuzaqbhHyPBctiNwwc9aHt5UXK6eA=;
 b=RAfFUo4CXLoB/ywgJwdn8AqMztppy0uRKqrkZXr1uAEl7enGyk+HcqdCoqXF91h6wx
 1K3VIPDWGqMz8OQBQvXQsBrxfYxCd6GG9u2EPH5X9QN/YLfKMrt2yDdamzSmKbVnwUU5
 QALSH6l31JNfN8kRIlnT+Hlo3qFadPIvw9anI+5NPcog4dF4T7TrijF4U95iQlJNMIHW
 +4AjXILoGQOxlnVMpBaEwpTACe997ZlA9c4D/g6A6Wbt0R42sz8JG+Np2TQmfeOOaKFM
 kXnVKXTx7ClhzeV84aHPO9fOHUyA2bG2fl0H/s7HdqR+WYfeq9cR5c7EXTAwmBOIGbTU
 mhAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByaXr4+OHPRwAV8EzF5dfYQS6VJfbA+YfzP4DcWqmbruz/s6fKb65Bk7k3Awb3lGOd1MSpzrhMhPOrk@nongnu.org
X-Gm-Message-State: AFuF++nbXBBJ/JVneRKkF2sTj9Uwl+3oAaS/QyMOzNHShGBfsX1YWGXZ
 k/p8VYGiYtetdwPjSayzmWf9O3s1SkRxQ2d0fk13ESzTiAeS4UhXVyZMPgYvXX5BDfWHWSHUR6A
 VCRfAH6QPzRpZard87pJz+Q==
X-Received: from pgba18-n1.prod.google.com
 ([2002:a05:6a02:6452:10b0:cc1:bda2:d0a3])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3944:b0:3de:188c:27b7 with SMTP id
 adf61e73a8af0-3e0d6ba9712mr6282429637.38.1791198200883; 
 Mon, 05 Oct 2026 04:03:20 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:13 +0800
In-Reply-To: <20261005110315.3327418-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261005110315.3327418-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110315.3327418-3-stanleyjhu@google.com>
Subject: [PATCH v4 2/4] hw/ufs: Support MCQ runtime interrupt and queue status
 registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::547;
 envelope-from=3-IPDagoKCmsbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x547.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
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

- Handle SQRTC.STOP transitions (0 -> 1 stop and 1 -> 0 resume) and
  SQRTC.ICU cleanup using Submission Queue Cleanup Task Information
  (SQCTI). Immediately clear SQRTS.CUS and SQRTS.RTC on ICU = 1, post
  a CQE with OCS = UFS_OCS_ABORTED on an active matching task, and set
  SQRTS.CUS = 1 with SQRTS.RTC = 0 (success), 1 (task not found),
  2 (SQ not stopped), or 3 (SQ disabled).
- Implement write-1-to-clear per-queue interrupt status (SQnIS, CQnIS)
  and synchronize the global IS.CQES bit.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 112 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |  15 ++++++
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 922293355..d8173b12b 100644
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
index adae6639e..956ef9c87 100644
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
 
@@ -970,6 +972,56 @@ static void ufs_mcq_process_db(UfsHc *u, uint8_t qid, uint32_t db)
     qemu_bh_schedule(sq->bh);
 }
 
+static void ufs_mcq_sq_cleanup(UfsHc *u, uint8_t qid)
+{
+    UfsMcqOpReg *opr = &u->mcq_op_reg[qid];
+    UfsSq *sq = u->sq[qid];
+    uint8_t task_tag = FIELD_EX32(opr->sq.cti, SQCTI, TASK_TAG);
+    uint8_t lun = FIELD_EX32(opr->sq.cti, SQCTI, LUN);
+    UfsRequest *req = NULL;
+    uint8_t rtc;
+
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 0);
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, 0);
+
+    if (!sq) {
+        rtc = 3;
+    } else if (!FIELD_EX32(opr->sq.rts, SQRTS, STS)) {
+        rtc = 2;
+    } else {
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
+
+        if (req) {
+            if (req->sreq != NULL) {
+                SCSIRequest *sreq = req->sreq;
+                req->sreq = NULL;
+                scsi_req_cancel(sreq);
+            }
+            req->utrd.header.dword_2 = cpu_to_le32(
+                (le32_to_cpu(req->utrd.header.dword_2) & ~UFS_MASK_OCS) |
+                UFS_OCS_ABORTED);
+            req->state = UFS_REQUEST_COMPLETE;
+            QTAILQ_INSERT_TAIL(&sq->cq->req_list, req, entry);
+            ufs_mcq_process_cq(sq->cq);
+            rtc = 0;
+        } else {
+            rtc = 1;
+        }
+    }
+
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 1);
+    opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, rtc);
+}
+
 static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
                                  unsigned size)
 {
@@ -983,6 +1035,9 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
 
     opr = &u->mcq_op_reg[qid];
 
+    trace_ufs_write_mcq_op_reg(qid, (uint32_t)(offset % sizeof(UfsMcqOpReg)),
+                               data);
+
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
         if (opr->sq.tp != data) {
@@ -990,6 +1045,40 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
+    case offsetof(UfsMcqOpReg, sq.rtc): {
+        bool prev_stop = FIELD_EX32(opr->sq.rtc, SQRTC, STOP);
+        bool new_stop = FIELD_EX32(data, SQRTC, STOP);
+
+        if (!prev_stop && new_stop) {
+            /* SQ_STOP (0 -> 1): Stop queue */
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, STS, 1);
+            if (u->sq[qid] && u->sq[qid]->bh) {
+                qemu_bh_cancel(u->sq[qid]->bh);
+            }
+        } else if (prev_stop && !new_stop) {
+            /* SQ_START (1 -> 0): Resume queue */
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, STS, 0);
+            if (u->sq[qid] && u->sq[qid]->bh) {
+                qemu_bh_schedule(u->sq[qid]->bh);
+            }
+        }
+        if (FIELD_EX32(data, SQRTC, ICU)) {
+            ufs_mcq_sq_cleanup(u, qid);
+            data = FIELD_DP32(data, SQRTC, ICU, 0);
+        }
+        opr->sq.rtc = data;
+        break;
+    }
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
 
@@ -1006,8 +1095,27 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
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
index d19b3c65e..b72403c47 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog


