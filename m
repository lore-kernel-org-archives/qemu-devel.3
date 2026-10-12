Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD993CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDju-0005gh-JS; Mon, 12 Oct 2026 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjm-0005e6-Lw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDji-0000wc-Ri
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2dd9ec41bc4so9196595ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802709; x=1792407509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fwi0iXujdLHTAusPZjEirlwrKNPsdESWzCH86y8wZho=;
 b=m9KffEpt1K9G4XpNUlz9RkKCUcDlyerNBKtPptW9BfYcs9/s1rm6GSVh4lahwMiejp
 MVlWdc3w5iaEj4qfQuwVAfzVUHyjSibzX127HN0LocAqQfu+Io4HB4NdWTHpld6ncHpR
 5G0AUN02S/Hkj45fUqsRYiLVgMSMDUotnYmFjudQxJzqjKbRyYerrjWfAyHf4oKPmu5L
 qeCh0lj/0aYx/mBUkHizSzySupxlyv3cNPZkf2kwgF6eyqjNuU/0qX5H7xp9vcOJCXew
 8Shmet3WmDOD9SPJgo942zmYMt+UyaDYYwXvCkRIavSWEJ3VDS9n3B1Gk9Fx8BowkqMZ
 u1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802709; x=1792407509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fwi0iXujdLHTAusPZjEirlwrKNPsdESWzCH86y8wZho=;
 b=wI+/bx5dpkwDkdDVTG8O8B6hHOOVnQtYw5s0rTIPlLa+K3O+UNEtOIxBocNKEj2zIf
 Ji+XXiHZKOaChA2UWLaxyCw2F9Ywd+UL30vMTz/eqDXppwEn4BsPrafK/QwiM2XKoiqt
 yPZP0sm9fgMkk1ydJSmDBiBND6SYt3dUHsGvTMYgnEOrgf66a/DyZfWHWywibTiPT2Nb
 FPNVD8wU6PZUxc9fIqJ2h3qalFiQQ1RWTyAwpEP0lbdPDpZMtCE9R848z79ez120xB3d
 5iNBxT3ka1JZCuQh/MkwShmMVMLwSYKNcZsBjxE+X12Svm/849xkI6s44iESSD7loO8q
 kHcA==
X-Gm-Message-State: AFq9FYKTRzm3NqTNqwVi0zaM+ib19dTaburON45nbRdCSY14Mq5BAkyg
 Up0TRylZ+c7f0BggSYk/+TyUKNSAVkUwNIaBUI4oVISGec+yqZyHzptvg474tA==
X-Gm-Gg: AYBFou03zvp/p1hjQ9JVskUenvAxG0nI+p4T5VfxZmWigR0qO9M84ZRKU1og0QqGt03
 UcD5EOtJXxLJObwK8NJ9GWEUmTe0AryxXxuRx2FcyHOyUSaH5bJY/qoqj2uVACUonpoBlXKlHW1
 nKaAPt7O6CMRVVAnMNAXEXSb1iDeBbeipmB4uKe0CemJgJnkckq9SGLaNwtfMRB/tYdoRDF/CQK
 gJcXlHxdVyVcZ3fly19LMRrcHvVVYRPFcVnbl8sivKNCUZeV6HCIOBCjsbV7cINGvM+Wcr4/fDW
 49l6XKX9jMbBJ1r598eOAEJpAFhfxkTjNruZfbj4Jbp8JKcVKyRmLGEGVzAY7h3S1XkNwlsiUjZ
 RskgZRUmSSRVtCLARNTXQKfoIbrrHzfWkkxRf79tvFKiOYDBbuFv5UvRwSeF1BBBxUyce/Gb7C6
 BWunpDXKHt7LK2+PicDQooy6Je2YOMgKxvCkhrWkuJ+bcg/cg4t7RLHH28nZhBKFfNJx/2WE8Uc
 BYzXHJzTZoxKys=
X-Received: by 2002:a17:903:19ef:b0:2e8:b20a:88cb with SMTP id
 d9443c01a7336-2e8b20a89e2mr29204275ad.13.1791802709424; 
 Mon, 12 Oct 2026 03:58:29 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:29 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 3/5] hw/ufs: Implement Task Management Request (TMR) handling
Date: Mon, 12 Oct 2026 19:58:05 +0900
Message-ID: <5791c5832fead3fcbcd09592f93262477fc9fb2c.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

Implement UTP Task Management Request List (UTMRL) doorbell and TMR
processing per JEDEC UFSHCI:

- Support UTMRLDBR, UTMRLCLR (clear-on-zero), and UTMRLRSR registers,
  and gate IS.UTMRCS interrupt assertion on the UTMRD Interrupt (I)
  bit.
- Handle UFS_QUERY_TASK and UFS_ABORT_TASK across legacy UTRL and MCQ
  queues, reporting overall Target Success/Failure in
  rsp_header.response and the TM Service Response in output_param1.
  For MCQ, UFS_ABORT_TASK cancels the active SCSIRequest and defers
  CQE posting (OCS = UFS_OCS_ABORTED) and slot recycling to subsequent
  SQRTC.ICU cleanup.
- Reset UTMRLRSR on HCE reset.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 133 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |   1 +
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index d8173b12b6c..5e5a54a3fb3 100644
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
index 956ef9c878e..4c505e0bffe 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -772,6 +772,7 @@ static void ufs_hce_reset(UfsHc *u)
     u->reg.utmrldbr = 0;
     u->reg.utrlcnr = 0;
     u->reg.utrlrsr = 0;
+    u->reg.utmrlrsr = 0;
     u->reg.is = 0;
 
     /* 4. Free MCQ Queues and reset MCQ dynamic registers */
@@ -809,6 +810,126 @@ static void ufs_hce_reset(UfsHc *u)
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
+    uint32_t completed_int_mask = 0;
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
+            if (tm_resp == UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL ||
+                tm_resp == UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED) {
+                desc.upiu_rsp.rsp_header.response = UFS_COMMAND_RESULT_SUCCESS;
+            } else {
+                desc.upiu_rsp.rsp_header.response = UFS_COMMAND_RESULT_FAIL;
+            }
+            desc.upiu_rsp.output_param1 = cpu_to_be32(tm_resp);
+
+            if (ufs_addr_write(u, desc_addr, &desc, sizeof(desc))) {
+                continue;
+            }
+
+            trace_ufs_process_tmr(tm_func, task_tag, tm_resp);
+            u->reg.utmrldbr &= ~(1 << i);
+            if (le32_to_cpu(desc.header.dword_0) & UFS_UTP_REQ_DESC_INT_CMD) {
+                completed_int_mask |= (1 << i);
+            }
+        }
+    }
+
+    if (completed_int_mask) {
+        u->reg.is = FIELD_DP32(u->reg.is, IS, UTMRCS, 1);
+        ufs_irq_check(u);
+    }
+}
+
 static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
 {
     switch (offset) {
@@ -871,10 +992,20 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
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
index b72403c478e..b0515325f92 100644
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
2.43.0


