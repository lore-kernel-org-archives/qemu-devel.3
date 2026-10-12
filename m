Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E1CCA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDjo-0005dz-6H; Mon, 12 Oct 2026 06:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDji-0005dG-1l
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjg-0000w0-4v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso4463055ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802706; x=1792407506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7V3jOPRB/kiA2idBqkKjY+LkhnYmwzQx/7a+A3ZswXA=;
 b=jwFa06YvZYBUvQChF6jYTdkgj7i7RFh7W53AR3PrlxYmOl2pv7othBoPHiKja/0Xjo
 kU5u/P/gJSsqzzm0WMAQ13t6eLWqN8UZN2Hj4MOBge2jU0PE1wPS/CamGRChqTVDF15V
 7sjUvKWpxYzxTqyBg98HAleHipf9V08V4tmImlJK4f2eXMK2JjVR7pWae9h3/DFDV/zX
 sbMJ/Wuz+8CGvriSuNSnoLtbTj62NUDZGSs3t3v9gAr0hLvgsuMnF9L5xGfYSoztes4z
 G0aEsehX+rq9QySQrcdCEQDGxrzqo3P1fT8YUbSz2SbEEeVvzyunrDT+swyjiJwU6arH
 fO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802706; x=1792407506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7V3jOPRB/kiA2idBqkKjY+LkhnYmwzQx/7a+A3ZswXA=;
 b=dOmiTxXbWOcOYXIJ3f+qN4AcGaoPa3aHj1H22PjkoC6QLfq0cmA2MH/T8Fo3vXlKbQ
 tyt9m+zHcf08XHMvVpLswR/Fv3Fi2lDqthHFRf2ZpGzpeeYGh6jKQuKRi0cj/Wn1Jac9
 AgaR1du/zP3JWopQEXx33tGfJh/Mlwui6NRq850OLRnNgUoJYxOw+k65t2QQUbxh34Of
 QYPEDpYzhYe1tKK5bpix3Rq2DNW9pS7JByWHAh57MooupS5a2H0V0/l4sSayGndBrfgQ
 r2vCROh/gjYmbM0kdWzwLzIzoqi4MilymNH0BLDTBb1bR3MKagUNkCAZ5PwGwN7QFu+4
 Bx3g==
X-Gm-Message-State: AFq9FYKzPGdUIxUgkt+zRdcMD8k83qnUcITc6Yiw67Bnv47JDaI+SRfM
 JFg2EBB9arjjTtPW5MEPOwR85HKa5R6Rqi4wIH697vx7NXRCcpQdDChy1WLpvQ==
X-Gm-Gg: AYBFou3VLLHh7XxjIvccG8TWCsKTf7Xc2sV9FPChXP2h5qHtBhOrmZR26/jmqdkFJux
 4RNA3wYeZ+VVwg/mtUX/nHBLA/4dbP1PU20YR0sL6D0t7pQQ29g9TS3qxxCN9ipkMgY8dqdV9oP
 3vgZLnqPSbx62TXQ4b+5oZhRSeBR38ZDKD+b3ZdzEPEt5/WlXviPpxKSnbN5HLPNsG0+IKyuV0r
 +VYQThKnvayAALNTZ8FdiEKztFkrwNJQJgr+PeUfzBzNWNk3SRb/Fav1PLHJmNLQ+vrE5CEq/GF
 psoW0qaUQhyxLelD9XEqO3SKYByXhkBub7rkQq7RN8hZdo/h9yWQH223JdDWwQYJuKno4o620zx
 hUa4K0L0hy4watcbrPbR8iZ9jXnK8rTkPEx2tv2SIFCnTcpXLcTLf6oxE1zOhbgrIY7YGQBKYnb
 KImMFeJPL00hnN656OoMezBwW/ZTZTS1NaqjLvW+C8Ae0N/E89oReYTOJri1GW523DDfk/5FRGk
 78=
X-Received: by 2002:a17:903:41cf:b0:2dd:ad74:6d16 with SMTP id
 d9443c01a7336-2e842ab68efmr86529855ad.28.1791802706189; 
 Mon, 12 Oct 2026 03:58:26 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:25 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 2/5] hw/ufs: Support MCQ runtime interrupt and queue status
 registers
Date: Mon, 12 Oct 2026 19:58:04 +0900
Message-ID: <cfd3210497f95347c2262cf5b5bcf476a832a4b6.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 112 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |  15 ++++++
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 922293355b2..d8173b12b6c 100644
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
index adae6639e16..956ef9c878e 100644
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
index d19b3c65ef4..b72403c478e 100644
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
2.43.0


