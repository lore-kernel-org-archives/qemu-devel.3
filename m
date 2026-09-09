Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBB2C79FB5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x48jE-0002Yo-V0; Tue, 08 Sep 2026 23:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3es6gagoKCvUpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com>)
 id 1x48jC-0002Y4-Kc
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:02 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3es6gagoKCvUpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com>)
 id 1x48j8-0004zv-K3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 23:12:00 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so4334245a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788923515; x=1789528315; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QvjQ3EEZOav8WbIfKiSEOaKv4sRoYmiBFLRu7TD6Ts4=;
 b=sMWe6x9ooshcN4PscCTr35tKuhLYAfUdnktit/tGjtpcQVkwzVXCLD2ajEUO3VLARn
 vQ96M7Dgl49tgsy8/FFZ5pFGMbLYj0wS6rDBeTS9URePt2fwPe6O6zpBypbilYVzmWyz
 YkC4ZD0QUps8OLr09lIqMaSjP/CEWv4LnvT4b3TpYwz8Hek/H8O/br8tNY/g7FYkjiAH
 e9FHPkKm5k1KbSjFbFkm3mKwQu6mFnf7SXhVt9vhu7Q3kB9xRUs7196QZVle5mfDBf3w
 eJrHMeTVVQh9b8RKu83PTysJL53/72OIrfBcalj7CwQSRJJYs/kzJy6/SNYJ8NPIXPIJ
 zw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788923515; x=1789528315;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QvjQ3EEZOav8WbIfKiSEOaKv4sRoYmiBFLRu7TD6Ts4=;
 b=YSY6zGnc01Rt/ybcD/4DpLSoxm7Wx4/z90FkFNQCW7LIn6PzJrGu4h+v/TPkuVSwu8
 0q2pxtuqdUGsMuBRxHm+vqvCFAWBDCUxh4nI/kjWcszKV7CBMeB9+q7llV8LxsVmNNFc
 IOgPj1Eim6Qb3pHj2ya6lUeGn7x1/P6tIbb1Gyxx98Wj24TkPksAIO2/TscnYR/HQat1
 3yP1Z4jfHKgKYeK8CC3DD0AezXWxVOFXas/9cmCV+J5n7PAiDTcIzngyfVDP9BSJoyq5
 sYM3rCO1liPWxupsyt7snaDMI+odaGj/udu9eOgjES3HO6ATo5FsO5K+dL6RftnBaOrG
 PAWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgL6vIcuTN+vzcDoRW/LeUhxGGO7iBeMII1SUWIdxxK2z7GvTxIGKtEl9tSuLkcvcQ8YTP/HauiYyQ@nongnu.org
X-Gm-Message-State: AFuF++k9RYwnO0uFl/qTlEsaOr2T7bHxXeSeGBJsSkjq6Wpn4KlQyYZw
 uyPk5TXy1uHG95HJ7b3HoQ5hy5biIV4Foczg2lM7975iHAR5i7UwNV+Xo+qBk4H5sfX8N2SUt7p
 8gSBpYgCUfOnzjlimXbbJAw==
X-Received: from pfrb15.prod.google.com ([2002:aa7:8ecf:0:b0:867:8d4a:901d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:16:b0:3c4:3672:b86 with SMTP id
 adf61e73a8af0-3da9d69b429mr11065162637.3.1788923514779; 
 Tue, 08 Sep 2026 20:11:54 -0700 (PDT)
Date: Wed,  9 Sep 2026 11:11:46 +0800
In-Reply-To: <20260909031146.1646684-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20260909031146.1646684-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260909031146.1646684-4-stanleyjhu@google.com>
Subject: [PATCH v2 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org
Cc: Brian Kao <powenkao@google.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3es6gagoKCvUpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
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

According to JEDEC UFSHCI 5.2.1 (Section 7.3 "UTP Task Management"), the
host controller processes Task Management Requests via the UTP Task
Management Request List (UTMRL). When software triggers UTMRLDBR, the
controller processes descriptors, executes the requested task management
function (such as UFS_ABORT_TASK or UFS_QUERY_TASK), returns the response
UPIU, and signals completion via the UTMRCS interrupt.

Currently, QEMU does not implement the UTMRL doorbell or operational
registers. Consequently, when Linux SCSI error recovery initiates task
aborts via ufshcd_abort() or ufshcd_mcq_abort(), the requests time out and
unnecessarily escalate to full host controller resets.

Implement Task Management Request processing:
- Support UTMRL registers (UTMRLDBR, UTMRLCLR, UTMRLRSR) and latch doorbell
  events per Section 5.3.3.
- Handle UFS_ABORT_TASK and UFS_QUERY_TASK functions across both legacy UTRL
  and MCQ queues, locating outstanding requests by task tag.
- Return compliant response UPIUs with appropriate status codes (setting both
  response header and output parameters for Linux driver compatibility), and
  update descriptor OCS while preserving vendor/reserved fields.
- Reset UTMRL operational registers on HCE reset.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   1 +
 hw/ufs/ufs.c        | 117 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

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
index 4e22c31f89..ca5f6f2e96 100644
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
-- 
2.55.0.1007.g17ff1f9808-goog


