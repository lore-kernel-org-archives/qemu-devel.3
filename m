Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A31CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTm-0002db-6M; Mon, 05 Oct 2026 07:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-4PDagoKCm4efMZXQkVTgSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTh-0002ak-Fn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:30 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-4PDagoKCm4efMZXQkVTgSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTd-0005RA-Lb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:27 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cc44d708055so2386039a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198203; x=1791803003; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K5eUzRQW+5Aqjf4eZC1yePv4IOuOBDABX0sGLyhsqfU=;
 b=p2bloZz8YhCDUbkjBlaJ7B/+TwfXoqeNYrZewzXY7PZLK5LtU8/sp03K4L7c0EastA
 E685fQfplxeAIdaksSqasluXhl76tU9o7SFTeERIGeHPZNK/AdpP8E9k1/mxmUcTXQ0z
 HOQcrjtayXpx9qh9+WplHrdj9hVvooMb8fpDE9Au2jBsmUOocaAT227qwweyGnH5CxO+
 +ATwXplyoh+xAtidwWliO97WRpOy3jCmFI+G+A73rJf0kT8Xzl1o9gssg1RwPNeousz3
 /Zvr7IzMHrphpnCwgdGyi0doXRAqFPg1Eprbx+Zih/sWBWbMu5JX3W8d32ub4CAlR2My
 +pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198203; x=1791803003;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5eUzRQW+5Aqjf4eZC1yePv4IOuOBDABX0sGLyhsqfU=;
 b=JMoNhD1Zmh7bGYSAWsYW/huwFr7EskHNsUjDPH6Mxfmu3vvukbTx78ZGFZnNdKnes4
 GD7YJh8/uyyURUgQsDq3MpmngKfG91R1Kk7iUlz+4zsBNDnbIw7WaiA4jOx5Tg6b55fR
 pZl8YQR99UarvA5iu1wrG3HgaP8ruj7EZWx/azo7zezwsRoFDu1J0eOVddQPbzhPxBec
 sFw8YKVVxebkSPh/9Ov3oW3kpCkWAsoNFHYfuviFyomeITYGOk05329D6hfT6ROHzymN
 om+K5zsXskpAkYxzGFtJG2CAaTOgorrprHivo9VkQkE3wrozTtgq95ryjES17sAgBATa
 bezg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ3csUjSAmjBDbM/s513gZBckvlQCEY15Go4FwxI1A1D1xAeoWh/cqhjCL+aaXvZ6Fb3T+ZASF49R0@nongnu.org
X-Gm-Message-State: AFuF++lBb09LA/UOMhmriPG9ZpRuT0FNqwV5726flrSRald0BH3Q9IFu
 7qa7dg12OXFh+apzMHds5Hfq3v8c0Sy0fIXK650TY8keeXMqXmtncCpNXrEIwOLEn48ZDP2ddUx
 dNE59NqZqUHM9vT6WBEsBCA==
X-Received: from pfcy26.prod.google.com ([2002:a05:6a00:93da:b0:88e:cc4a:845])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1392:b0:3e0:c258:2f15 with SMTP id
 adf61e73a8af0-3e0d6b70267mr5927881637.57.1791198203004; 
 Mon, 05 Oct 2026 04:03:23 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:14 +0800
In-Reply-To: <20261005110315.3327418-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261005110315.3327418-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110315.3327418-4-stanleyjhu@google.com>
Subject: [PATCH v4 3/4] hw/ufs: Implement Task Management Request (TMR)
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3-4PDagoKCm4efMZXQkVTgSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
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
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 133 +++++++++++++++++++++++++++++++++++++++++++-
 include/block/ufs.h |   1 +
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index d8173b12b..5e5a54a3f 100644
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
index 956ef9c87..4c505e0bf 100644
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
index b72403c47..b0515325f 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog


