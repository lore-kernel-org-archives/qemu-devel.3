Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A0CC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NOO-0008Hz-KG; Fri, 04 Sep 2026 02:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vWSaagoKCkw67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOM-0008HA-Mv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:14 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vWSaagoKCkw67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOK-0005FV-Kn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:14 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so1024762a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788503230; x=1789108030; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nCtO4gELwPq20yztFyVCinNc8WEEbXyTCynQ9QwGoZc=;
 b=JHx6gVfUVSx9qbNszNuMR26St47l44rxCSorjk9ypjdNdTMflt+JCkZe2EUo4ymLxq
 1Ef77wLhK6SLXmsZbbPZwKCT2RHg6jwkzQT3D43vsF527pCFFclmAJNTPdlppsta/v9U
 pnz/9W49RiWA3et6U0MhgEENOw7YjVE0KL7Ra7lWBhulTul5+2IJaUSBCVJYJuEStaXp
 nc++Pb4ZLmpuh29ZH9CE5NA1b3kvX4/qQ0berQ8xNTK8V7Th7pZJcs+recU0g1futzJM
 8EWNR0P1IYTRqltkeZ0zZ2uU0wNGB7150P+la90z9Ahza/5s1FSVdeIpbZsegcp3ikin
 gxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503230; x=1789108030;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nCtO4gELwPq20yztFyVCinNc8WEEbXyTCynQ9QwGoZc=;
 b=G+9QvOYOJxvlvzD06xKugjBdqTWTpUTj6J9vCTw3EVMYUPuOq3W2dkuHdkt2u8gY0O
 Q/yoFbODggPEZvZHdKYKv2ZEztvY8va5wiGe0azOmLVBaCBY2hWpBoGsqQBHYfrKF/on
 GrQYQOGA2DbUnp2+2+BwN3LsPxmLb+0nQ6/B4kdZ8WYH3OhsS6wpjdLqdqVeZWy5VzCn
 E4jR86l8FOPt7AaqAXgKMwqsX4FkbZ4aRNizSVwVOeOh+rSNL9FC+mse+t0Oo/LZpDcS
 zr0T5ujLMEc55yelvd3ws6dvmvydZnpfmCtp1OU5EXnMz+mRB8gG8cvnVymXS5SBoJt3
 0sag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL6jmggmBRWSuMatW21inILEUqHAeIdeTOGbQR7wGEZiBGZtwB3bVTLsKd5iwspy4/eYsg3UCunHtD@nongnu.org
X-Gm-Message-State: AFuF++lEKrLaGxiTrN6nlvWtceYd7ruAnKWYJHstmhkbldTzbEKQielw
 TEaUlyejvcxRvHNaFI4aeyU5O09rNRrRJT0jfhmQdOnbFhZn7zTwDeawp5VAyF9tusEh2iw4CGS
 E7nBSTaa9bvxfxjDdu8QHTA==
X-Received: from pjzb15.prod.google.com ([2002:a17:90a:e38f:b0:384:aeb6:624c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f46:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39b261e763dmr6705198a91.15.1788503229802; 
 Thu, 03 Sep 2026 23:27:09 -0700 (PDT)
Date: Fri,  4 Sep 2026 14:27:04 +0800
In-Reply-To: <20260904062706.2684958-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260904062706.2684958-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904062706.2684958-2-stanleyjhu@google.com>
Subject: [PATCH 1/3] hw/ufs: Support MCQ runtime interrupt and queue status
 registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@gmail.com>, Jinyoung Choi <j-young.choi@samsung.com>, 
 qemu-block@nongnu.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3vWSaagoKCkw67o1zsCxv8u22uzs.q204s08-rs9sz121u18.25u@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
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

According to JEDEC UFSHCI 5.2.1 and 5.6, Multi-Circular Queue (MCQ)
architecture provides per-queue runtime control and interrupt registers.
When Linux initializes MCQ via ufshcd_mcq_make_queues_operational(),
it accesses SQnRTC, SQnCTI, SQnIS, SQnIE, CQnIS, CQnIE, and CQnIACR.
Currently, QEMU logs "invalid register offset" warnings for these registers.

Implement handling for these operational registers:
- Define REG32 and FIELD macros for SQRTC (STOP, ICU) and SQRTS (STS, CUS, RTC).
- SQnRTC: Handle SQSTART (bit 0=0) and SQSTOP (bit 0=1) commands to update
  SQnRTS (Run-Time Status), scheduling or cancelling the SQ bottom half.
  Enforce SQSTOP in ufs_mcq_process_sq() to halt processing when stopped.
- SQnRTC / SQnRTS: Handle SQ_ICU (bit 1=1) queue cleanup command, reporting
  SQ_CUS (bit 1=1) and RTC completion code 0 in SQnRTS.
- SQnCTI: Store Completion Timeout Interval configuration.
- SQnIS: Handle Write-1-to-Clear interrupt status and invoke ufs_irq_check().
- CQnIS: Handle Write-1-to-Clear interrupt status. Recalculate whether any
  CQ has pending interrupts, and clear the global CQES (CQ Event Status) bit
  in IS before calling ufs_irq_check() to prevent IRQ storms.
- SQnIE / CQnIE: Store Interrupt Enable configuration.
- CQnIACR: Store Interrupt Aggregation Control Register configuration.
- In ufs_hce_reset(), reset operational registers (utriacr, utrlclr, ie,
  utrlba/utrlbau) while preserving the Max Active Channels (MAC) capability
  field in MCQCONFIG according to params.mcq.
- Add trace_ufs_write_mcq_op_reg trace event with explicit offset cast.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 69 +++++++++++++++++++++++++++++++++++++++++++--
 include/block/ufs.h |  9 ++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 922293355b..d8173b12b6 100644
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
index 3c4d7424da..5064878028 100644
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
 
@@ -770,7 +771,17 @@ static void ufs_hce_reset(UfsHc *u)
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
@@ -983,6 +994,9 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
 
     opr = &u->mcq_op_reg[qid];
 
+    trace_ufs_write_mcq_op_reg(qid, (uint32_t)(offset % sizeof(UfsMcqOpReg)),
+                               data);
+
     switch (offset % sizeof(UfsMcqOpReg)) {
     case offsetof(UfsMcqOpReg, sq.tp):
         if (opr->sq.tp != data) {
@@ -990,6 +1004,38 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
+    case offsetof(UfsMcqOpReg, sq.rtc):
+        opr->sq.rtc = data;
+        if (FIELD_EX32(data, SQRTC, ICU)) {
+            /* SQ_ICU: Initiate Cleanup (SQ_CUS = 1, RTC = 0) */
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, CUS, 1);
+            opr->sq.rts = FIELD_DP32(opr->sq.rts, SQRTS, RTC, 0);
+        }
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
 
@@ -1006,8 +1052,27 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
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
index d19b3c65ef..00591aa755 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -224,6 +224,15 @@ typedef struct QEMU_PACKED UfsMcqSqReg {
     uint32_t rts;
 } UfsMcqSqReg;
 
+REG32(SQRTC, offsetof(UfsMcqSqReg, rtc))
+    FIELD(SQRTC, STOP, 0, 1)
+    FIELD(SQRTC, ICU, 1, 1)
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
2.55.0.979.g7e5102b832-goog


