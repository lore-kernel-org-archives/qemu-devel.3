Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618BDC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NOP-0008IK-H7; Fri, 04 Sep 2026 02:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3v2SaagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOO-0008Hv-ES
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:16 -0400
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3v2SaagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1x2NOM-0005Fv-Gr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:27:16 -0400
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so1240729a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788503232; x=1789108032; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BWI75te92WAOR10DOoSbgBN2CFVLAtdlPgPv1u+hVgo=;
 b=Hv0BrAIhu0n5W1TQRqKFvpb+9HF9crF978y7pv0X+NFADFmnvmy8+l2OkQHjzpL2rP
 k5urwaOzOo2mBoQx37kAExuI9WvkA7mFPNzUp34pnxtdEyOg7uqxaO03WAbcQeoRTQUF
 JCHFMzcUAMQ+vmV162ak5Lw7OBWU0kqgrEkvClAyf5JVbpJJ0LHaHFBYwxrKCIVjj8rq
 uaN+RpQiZwICWdB6MWAjV6vKUP/mulde/a5WOQjMwkhQbXHOuC1DYKfgT5BtYmR61mMp
 zQV0FTwE2EW4EX6QztZcD1fNfFz2YCEH4eTjEdCmYH8qDiDMGR6sARrsDbfALCQuP/Pf
 KZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503232; x=1789108032;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWI75te92WAOR10DOoSbgBN2CFVLAtdlPgPv1u+hVgo=;
 b=NnCkI2mZxxBV2e4iWjo7wwJZCRqee828lJctgrNt4dwo+9ACmdB6vamUq50+IuYykl
 rS9HNN8aBlYoG+yHQCUYegB6GodxLmgh8hVOv2I/LcW4uHLsjz6Kckzn6/xgCvd6Xte7
 tyXv8IIO0w16rTzAu4D2ZernAvOFzdtO/EZDVb1JvBJcfIspxKZpVAF4OEQbOigLCQih
 kwoxRC/j5Bo1leeK1MmjBgYH3ZRiLukwshA0CKteIynsqivN+oFEOS5Ud0BrbF5nWW9I
 MtDJ8oaaSPV5iAydjbLhSXSKP9RTuLgJSlUC+eU9MPEZdyFCpoySWlZ+LmjUv188Tpr0
 rISA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1hTKI90kIHg4XSXxXPi4967WpCRvdi10rRcbXOlviHRV6dwi19H0Tokag6u+rEVHVruSQglgxFetX@nongnu.org
X-Gm-Message-State: AFuF++nJATSMeUz8GA4/jrHrdmyMh1GVwH1YhEoCVNYIqOwkIHMNC8AB
 Kl4Boq/e5tT6a+g0LUsjc39tWTlKoRljKPLkTqwsaL1sVB+H+cxPE3Wf++ldF06j+SXogBa6Wfe
 WtJWJENpY9Ot8uCMt4GrEXg==
X-Received: from pjbbh6.prod.google.com ([2002:a17:90b:486:b0:38e:3cf9:2e8b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39b25ee67f0mr6138957a91.0.1788503231809; 
 Thu, 03 Sep 2026 23:27:11 -0700 (PDT)
Date: Fri,  4 Sep 2026 14:27:05 +0800
In-Reply-To: <20260904062706.2684958-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260904062706.2684958-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904062706.2684958-3-stanleyjhu@google.com>
Subject: [PATCH 2/3] hw/ufs: Implement Task Management Request (TMR) handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@gmail.com>, Jinyoung Choi <j-young.choi@samsung.com>, 
 qemu-block@nongnu.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1048;
 envelope-from=3v2SaagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1048.google.com
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

According to JEDEC UFSHCI 5.2.1 (Section 7.3 "UTP Task Management"), the
host controller processes Task Management Requests via the UTP Task
Management Request List (UTMRL). When software writes to UTMRLDBR, the
controller processes descriptors, dispatches the requested function
(e.g., UFS_ABORT_TASK, UFS_QUERY_TASK), returns the completion code in the
response UPIU, and triggers the UTMRCS interrupt.

Currently, QEMU treats UTMRLDBR, UTMRLCLR, and UTMRLRSR as unsupported.
Consequently, when Linux kernel SCSI error recovery invokes task aborts
via ufshcd_abort() or ufshcd_mcq_abort(), requests time out and escalate
unnecessarily to full device or host resets.

Implement Task Management Request handling:
- Add sreq tracking in UfsRequest and cancel pending SCSIRequests in
  ufs_clear_req() to eliminate Use-After-Free hazards during abort.
- Implement ufs_find_req_by_tag() supporting both legacy UTRL and MCQ
  execution queues.
- Implement ufs_process_tmr() to dispatch UFS_QUERY_TASK and UFS_ABORT_TASK,
  releasing resources and returning completion response UPIU.
- For UFS_QUERY_TASK, return UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED if the
  task is pending in the controller/device, and return
  UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL if the task does not exist.
- Set both rsp_header.response and output_param1 to satisfy both JEDEC
  and Linux kernel driver response validation.
- Mask and preserve descriptor header dword_2 when updating OCS.
- Connect A_UTMRLDBR, A_UTMRLCLR, and A_UTMRLRSR in ufs_write_reg.
- Latch pending doorbell bits in u->reg.utmrldbr upon UTMRLDBR write.
- In ufs_hce_reset(), reset task management operational registers (utmrlrsr,
  utmrlclr, utmrlba/utmrlbau).
- Add trace_ufs_process_tmr trace event.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/lu.c         |   7 +++
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 122 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |   1 +
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index bdb1650851..fb7eaa99fb 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -173,6 +173,12 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
     int16_t status = scsi_req->status;
     uint32_t transfered_len = scsi_req->cmd.xfer - resid;
 
+    if (!req) {
+        return;
+    }
+
+    req->sreq = NULL;
+
     /* WB / HID accounting should only happen for successful commands */
     if (status == GOOD) {
         ufs_wb_process_write_req(req, transfered_len);
@@ -389,6 +395,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     SCSIRequest *scsi_req =
         scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
                      UFS_CDB_SIZE, req);
+    req->sreq = scsi_req;
 
     uint32_t len = scsi_req_enqueue(scsi_req);
     if (len) {
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index d8173b12b6..5e5a54a3fb 100644
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
index 5064878028..c7064f1825 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -771,8 +771,10 @@ static void ufs_hce_reset(UfsHc *u)
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
@@ -782,6 +784,8 @@ static void ufs_hce_reset(UfsHc *u)
     u->reg.is = 0;
     u->reg.utrlba = 0;
     u->reg.utrlbau = 0;
+    u->reg.utmrlba = 0;
+    u->reg.utmrlbau = 0;
 
     /* 4. Free MCQ Queues and reset MCQ dynamic registers */
     if (u->params.mcq) {
@@ -818,6 +822,111 @@ static void ufs_hce_reset(UfsHc *u)
     ufs_irq_check(u);
 }
 
+static UfsRequest *ufs_find_req_by_tag(UfsHc *u, uint32_t task_tag)
+{
+    if (task_tag < u->params.nutrs) {
+        UfsRequest *req = &u->req_list[task_tag];
+        if (req->state == UFS_REQUEST_RUNNING ||
+            req->state == UFS_REQUEST_READY) {
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
+            uint8_t tm_func, tm_resp;
+            uint32_t task_tag;
+
+            if (ufs_addr_read(u, desc_addr, &desc, sizeof(desc))) {
+                continue;
+            }
+
+            tm_func = desc.upiu_req.req_header.query_func;
+            task_tag = be32_to_cpu(desc.upiu_req.input_param2);
+
+            if (tm_func == UFS_QUERY_TASK) {
+                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
+
+                if (req) {
+                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+                } else {
+                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+                }
+            } else if (tm_func == UFS_ABORT_TASK) {
+                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
+
+                if (req) {
+                    ufs_clear_req(req);
+                    req->state = UFS_REQUEST_IDLE;
+                    if (ufs_mcq_req(req)) {
+                        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
+                        qemu_bh_schedule(req->sq->bh);
+                    } else {
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
@@ -880,10 +989,16 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
     case A_MCQCONFIG:
         u->reg.mcqconfig = data;
         break;
-    case A_UTRLCLR:
     case A_UTMRLDBR:
+        ufs_process_tmr(u, data);
+        break;
     case A_UTMRLCLR:
+        u->reg.utmrldbr &= ~data;
+        break;
     case A_UTMRLRSR:
+        u->reg.utmrlrsr = data;
+        break;
+    case A_UTRLCLR:
         trace_ufs_err_unsupport_register_offset(offset);
         break;
     default:
@@ -2286,6 +2401,11 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 
 static void ufs_clear_req(UfsRequest *req)
 {
+    if (req->sreq != NULL) {
+        scsi_req_cancel(req->sreq);
+        req->sreq = NULL;
+    }
+
     if (req->sg != NULL) {
         qemu_sglist_destroy(req->sg);
         g_free(req->sg);
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6f2693b7ca..265a43faaa 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -60,6 +60,7 @@ typedef struct UfsRequest {
     UtpUpiuRsp rsp_upiu;
 
     /* for scsi command */
+    SCSIRequest *sreq;
     QEMUSGList *sg;
     uint32_t data_len;
 
-- 
2.55.0.979.g7e5102b832-goog


