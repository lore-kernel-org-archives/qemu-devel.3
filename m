Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B41C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OHp-0006OA-Dx; Wed, 23 Sep 2026 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37uazagoKCucbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHk-0006MB-QH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:25 -0400
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37uazagoKCucbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com>)
 id 1x9OHi-00015E-Q4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:49:24 -0400
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so1156968a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790174959; x=1790779759; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yjuVbFyCYsWPeaabx9S3N6TVkSzTzpUWVd+Nwc4nDz4=;
 b=pjEpHGU4rNdRtuOKehjM1w4tlx1tPc/g2aRb5FlSVNppZRFVHhzxk2DFiClzxRmEcO
 Asoha1OSqJSGYu/dBUvG+P6gPFzAfbomciF/xZ7KhTB8gge4JNh9yr1PU/UmzmZY1fHB
 pr0H8UVOnMFp4vdIGywFOWdw/mYbGZkzEaX9NtgQnQ5CZ815zpyjmdxM3waejFdzjgtZ
 8iAx5k/ca0QT24CcyM/yCGF4e7nTuysI2jZmaZB7MHmBue4SCy8z4bV828U6J6JF6+/q
 PI/lPbF5/8rjFHN4A4XWtxDADZHl9qhzN+HiQpg7ML9P0FzbMsBcFzLneDrzmaUjESRS
 9ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174959; x=1790779759;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yjuVbFyCYsWPeaabx9S3N6TVkSzTzpUWVd+Nwc4nDz4=;
 b=btdTCwcbpJH8c9kZ3N4ytls13L/jXRgMys3fvpzsQbDclM7KyvIRftSnGcMl4p1cqk
 PF6hIwi+OYrGQCbguu6Mcx/I4jr8OicHgb3ydiYTb0MsJ8nQulAREmQcHnNOtvQwV63h
 RpED2JAm2xQyND5IxN36Xz1gKsnyqetZYVHIRjr7hRHd+EWlI0yPczZJXlHyKVG6hnkk
 TE5Z4JM5ZmStQZPv1OXarP2kWNvqiR3oJxT0zi/yeRdgnqg109U8eP7EV9KSpRodvLUt
 OFCqWQ1S0WJM5rvj2QQwdfhC4aFM9nGTGmc+KOXG5GRBMHkfs+oxAF4sefCGVSaPJ/Vx
 evsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhDu51d3ngolvySnQ8LJwi6mjofHy4QQF8qNArWzaAFBs2uobuJ8VzHD0j+8OPwzPp3CQoTa+2CHO4@nongnu.org
X-Gm-Message-State: AFuF++kx5PjAdSCXOjXHptvISpx7Un7MlkkDgFYtBCitJwHLzlx3/d6s
 YTPG6lAnWHBAnCMi88tPafZzOB0PoyhH/PhZaK3t1hh02nWjSbhFUAYEd9GiLYLZyBLl5hmUryo
 4buFHsm+HK75NA1eztHvUBA==
X-Received: from pjbiw22.prod.google.com ([2002:a17:90b:4216:b0:3a0:a28:fc2e])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e08:b0:3a0:8133:69a0 with SMTP id
 98e67ed59e1d1-3a081336a1cmr1482431a91.14.1790174958639; 
 Wed, 23 Sep 2026 07:49:18 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:48:11 +0800
In-Reply-To: <20260923144911.2877141-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260923144911.2877141-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923144911.2877141-4-stanleyjhu@google.com>
Subject: [PATCH v3 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: Stanley Jhu <stanleyjhu@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1045;
 envelope-from=37uazagoKCucbcJWUNhSQdPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1045.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
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

Implement UTP Task Management Request List (UTMRL) doorbell and TMR
processing per JEDEC UFSHCI:

- Support UTMRLDBR, UTMRLCLR (clear-on-zero), and UTMRLRSR registers.
- Handle UFS_QUERY_TASK and UFS_ABORT_TASK across legacy UTRL and MCQ
  queues. For MCQ, UFS_ABORT_TASK cancels the active SCSIRequest and
  defers CQE posting (OCS = UFS_OCS_ABORTED) and slot recycling to
  subsequent SQRTC.ICU cleanup.
- Reset UTMRL operational registers on HCE reset.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 129 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |   1 +
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index d8173b1..5e5a54a 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -15,6 +15,7 @@ ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
 ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
+ufs_process_tmr(uint8_t func, uint32_t tag, uint8_t resp) "query_func 0x%"PRIx8", task_tag %"PRIu32", tm_resp 0x%"PRIx8""
 ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 4d8c641..336bdb8 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -772,8 +772,10 @@ static void ufs_hce_reset(UfsHc *u)
     u->reg.utmrldbr = 0;
     u->reg.utrlcnr = 0;
     u->reg.utrlrsr = 0;
+    u->reg.utmrlrsr = 0;
     u->reg.utriacr = 0;
     u->reg.utrlclr = 0;
+    u->reg.utmrlclr = 0;
     if (u->params.mcq) {
         u->reg.mcqconfig = FIELD_DP32(0, MCQCONFIG, MAC, 0x1f);
     } else {
@@ -783,6 +785,8 @@ static void ufs_hce_reset(UfsHc *u)
     u->reg.is = 0;
     u->reg.utrlba = 0;
     u->reg.utrlbau = 0;
+    u->reg.utmrlba = 0;
+    u->reg.utmrlbau = 0;
 
     /* 4. Free MCQ Queues and reset MCQ dynamic registers */
     if (u->params.mcq) {
@@ -819,6 +823,119 @@ static void ufs_hce_reset(UfsHc *u)
     ufs_irq_check(u);
 }
 
+static UfsRequest *ufs_find_req_by_tag(UfsHc *u, uint8_t lun, uint32_t task_tag)
+{
+    if (task_tag < u->params.nutrs) {
+        UfsRequest *req = &u->req_list[task_tag];
+        if ((req->state == UFS_REQUEST_RUNNING ||
+             req->state == UFS_REQUEST_READY) &&
+            req->req_upiu.header.lun == lun &&
+            req->req_upiu.header.task_tag == task_tag) {
+            return req;
+        }
+    }
+
+    if (u->params.mcq) {
+        for (int q = 0; q < ARRAY_SIZE(u->sq); q++) {
+            UfsSq *sq = u->sq[q];
+            if (!sq) {
+                continue;
+            }
+            for (int i = 0; i < sq->size; i++) {
+                UfsRequest *req = &sq->req[i];
+                if (req->state == UFS_REQUEST_RUNNING &&
+                    req->req_upiu.header.lun == lun &&
+                    req->req_upiu.header.task_tag == task_tag) {
+                    return req;
+                }
+            }
+        }
+    }
+
+    return NULL;
+}
+
+static void ufs_process_tmr(UfsHc *u, uint32_t val)
+{
+    hwaddr base_addr = (((hwaddr)u->reg.utmrlbau) << 32) + u->reg.utmrlba;
+    uint32_t completed_mask = 0;
+
+    u->reg.utmrldbr |= val;
+
+    for (int i = 0; i < u->params.nutmrs; i++) {
+        if (val & (1 << i)) {
+            uint64_t desc_addr = base_addr + i * sizeof(UtpTaskReqDesc);
+            UtpTaskReqDesc desc;
+            uint8_t tm_func, tm_resp, lun;
+            uint32_t task_tag;
+
+            if (ufs_addr_read(u, desc_addr, &desc, sizeof(desc))) {
+                continue;
+            }
+
+            tm_func = desc.upiu_req.req_header.query_func;
+            lun = desc.upiu_req.req_header.lun;
+            task_tag = be32_to_cpu(desc.upiu_req.input_param2);
+
+            if (tm_func == UFS_QUERY_TASK) {
+                UfsRequest *req = ufs_find_req_by_tag(u, lun, task_tag);
+
+                if (req) {
+                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+                } else {
+                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                }
+            } else if (tm_func == UFS_ABORT_TASK) {
+                UfsRequest *req = ufs_find_req_by_tag(u, lun, task_tag);
+
+                if (req) {
+                    if (ufs_mcq_req(req)) {
+                        if (req->sreq != NULL) {
+                            SCSIRequest *sreq = req->sreq;
+                            req->sreq = NULL;
+                            scsi_req_cancel(sreq);
+                        }
+                        req->state = UFS_REQUEST_ERROR;
+                    } else {
+                        ufs_clear_req(req);
+                        req->state = UFS_REQUEST_IDLE;
+                        u->reg.utrldbr &= ~(1 << req->slot);
+                    }
+                }
+                tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+            } else {
+                tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_NOT_SUPPORTED;
+            }
+
+            memset(&desc.upiu_rsp, 0, sizeof(desc.upiu_rsp));
+            desc.header.dword_2 = cpu_to_le32(
+                (le32_to_cpu(desc.header.dword_2) & ~UFS_MASK_OCS) |
+                UFS_OCS_SUCCESS);
+            desc.upiu_rsp.rsp_header.trans_type =
+                UFS_UPIU_TRANSACTION_TASK_RSP;
+            desc.upiu_rsp.rsp_header.flags = 0;
+            desc.upiu_rsp.rsp_header.lun = desc.upiu_req.req_header.lun;
+            desc.upiu_rsp.rsp_header.task_tag =
+                desc.upiu_req.req_header.task_tag;
+            desc.upiu_rsp.rsp_header.response = tm_resp;
+            desc.upiu_rsp.output_param1 = cpu_to_be32(tm_resp);
+
+            if (ufs_addr_write(u, desc_addr, &desc, sizeof(desc))) {
+                continue;
+            }
+
+            trace_ufs_process_tmr(tm_func, task_tag, tm_resp);
+            u->reg.utmrldbr &= ~(1 << i);
+            completed_mask |= (1 << i);
+        }
+    }
+
+    if (completed_mask) {
+        u->reg.is = FIELD_DP32(u->reg.is, IS, UTMRCS, 1);
+        ufs_irq_check(u);
+    }
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
 {
     switch (offset) {
@@ -881,10 +998,20 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     case A_MCQCONFIG:
         u->reg.mcqconfig = data;
         break;
-    case A_UTRLCLR:
     case A_UTMRLDBR:
+        if (!FIELD_EX32(u->reg.hce, HCE, HCE) ||
+            !FIELD_EX32(u->reg.utmrlrsr, UTMRLRSR, UTMRLRSR)) {
+            break;
+        }
+        ufs_process_tmr(u, data);
+        break;
     case A_UTMRLCLR:
+        u->reg.utmrldbr &= data;
+        break;
     case A_UTMRLRSR:
+        u->reg.utmrlrsr = data;
+        break;
+    case A_UTRLCLR:
         trace_ufs_err_unsupport_register_offset(offset);
         break;
     default:
diff --git a/include/block/ufs.h b/include/block/ufs.h
index b72403c..b051532 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -141,6 +141,7 @@ REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
 REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
 REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
 REG32(UTMRLRSR, offsetof(UfsReg, utmrlrsr))
+    FIELD(UTMRLRSR, UTMRLRSR, 0, 1)
 REG32(UICCMD, offsetof(UfsReg, uiccmd))
 REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
 REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
-- 
2.56.0.rc1.310.g51773c2048-goog


