Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F266C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jC-0002Xz-Qu; Tue, 08 Sep 2026 23:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eM6gagoKCvMnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com>)
 id 1x48j7-0002X7-6i
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:58 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eM6gagoKCvMnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com>)
 id 1x48j5-0004zV-8Q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:11:56 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso5400413a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923513; x=1789528313; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uvk5Eyi7WBTx5w4jU3FUojn97We0KNofjEPwHLpdBsg=;
 b=cN95mySY8QRo4xfCU3vnXjnuJh6wS7N4dduzHqc+JSn897NBdkwLNmt74o9lK/3Z0c
 rehdeRh36nLiIDZ+DmHcLO0xvETXaDGyR/5DbOigu0557QDI9HeZiAqH2idxDKg0aQKF
 Nh6B68GWEakTzHw2SDMxqOuMlxPwbCoxonj7Xd4AqRv16Hsdb0fUFQsCkUwuppzyBu/j
 G/lTf1+Gq0wLU6gpEY5UossY2jNVrN3Yl6ed/bXpvRsM7z1o3Fz/kT1V3v84h+J1rcr9
 E8w/JxEz/0Sx+LydYSwnYVQKkbjbmheqa1Wnz6ZIPCU0/zeS686BWW/A08BNAmta1Rng
 xYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923513; x=1789528313;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uvk5Eyi7WBTx5w4jU3FUojn97We0KNofjEPwHLpdBsg=;
 b=Q0y/DR3h4YIHchhE6FLeFeyalrgUHVs76d2CcoQP0u+eVbtf4YeckR+p4aGknQOoPs
 T0Uo/ytIM1Xag/MSEgGJ7OngyafTrVuWpx+O744R1kkq6mMFcLriKwvsBt7tFVwwneZO
 X8FoOD58a0Md99tlAMOlsqADmZ2Ygpi+Dv1F5FSfv6kymp4xd4anwDQdGhFA/WV/aZuC
 t4lO21tbpGK5AQ69lDu9L//pU4+j8HO+ZOWoWCNEktJG37ni5/5pnYR5GeMo550rvrJ7
 LDo+a7BIGqZzMZa9TWAn/e2nOvwelJ649HsD5hLOkWd5inl82C3odIKjIgKpTkEZZru2
 Yk1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxb0E5gkAJvxkvZUFOy2RYI2JFTFB4a/T6zuiyEMB6XhgoeAmV359YHqM4x6ifsrIyI3IX/oWGlLRm3@nongnu.org
X-Gm-Message-State: AFuF++lsAtSfvaPGKPv7FVx4WDRpUaE2vt29k1UvMCNK63QwP41bZjQA
 kySnIgLozU647lq1L7ZFAau7HCbcexTQTXDNgbrnFDnBvEdJZzngAx7t9g1EzPOTWtZ1O+HewQO
 ggCUrSwSl/v5cFcqoqxcAkA==
X-Received: from pjye9.prod.google.com ([2002:a17:90a:ee09:b0:380:60d8:dafc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:164f:b0:39b:3510:49e7 with SMTP id
 98e67ed59e1d1-39b35105b52mr27154735a91.0.1788923512887; 
 Tue, 08 Sep 2026 20:11:52 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:11:45 +0800
In-Reply-To: <20260909031146.1646684-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260909031146.1646684-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031146.1646684-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/3] hw/ufs: Support MCQ runtime interrupt and queue status
 registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3eM6gagoKCvMnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1047.google.com
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

According to JEDEC UFSHCI 5.2.1 and 5.6, Multi-Circular Queue (MCQ)
architecture provides per-queue runtime control and interrupt registers.
When Linux initializes MCQ via ufshcd_mcq_make_queues_operational(),
it configures operational registers (SQnRTC, SQnCTI, SQnIS/IE, CQnIS/IE,
CQnIACR). Currently, QEMU treats these offsets as unhandled, generating
"invalid register offset" warnings and failing queue lifecycle transitions.

Implement MCQ runtime operational register handling:
- Support SQ run-time control (SQnRTC) to start, stop, and clean up submission
  queues, updating run-time status (SQnRTS) and synchronizing with the SQ
  processing bottom half.
- Support per-queue interrupt status and enable registers (SQnIS/IE, CQnIS/IE).
  Implement write-1-to-clear semantics and dynamically synchronize the global
  CQES (CQ Event Status) bit in IS to prevent interrupt storms.
- Store queue configuration for interrupt aggregation (CQnIACR) and completion
  timeout intervals (SQnCTI).
- Enforce controller reset state machine rules: guard MMIO reads when HCE=0,
  and reinitialize operational registers across HCE resets while preserving
  MCQ capability configurations.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 73 +++++++++++++++++++++++++++++++++++++++++++--
 include/block/ufs.h |  9 ++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

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
index adae6639e1..4e22c31f89 100644
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
@@ -1029,6 +1094,10 @@ static uint64_t ufs_mmio_read(void *opaque, hwaddr addr, unsigned size)
         offset = addr - ufs_mcq_reg_addr(u, 0);
         ptr = (uint32_t *)&u->mcq_reg;
     } else if (ufs_is_mcq_op_reg(u, addr, size)) {
+        if (!FIELD_EX32(u->reg.hce, HCE, HCE)) {
+            trace_ufs_err_invalid_register_offset(addr);
+            return 0xffffffff;
+        }
         offset = addr - ufs_mcq_op_reg_addr(u, 0);
         ptr = (uint32_t *)&u->mcq_op_reg;
     } else {
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
2.55.0.1007.g17ff1f9808-goog


