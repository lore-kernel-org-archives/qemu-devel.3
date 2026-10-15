Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468ACC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEdu-0003nt-4D; Thu, 15 Oct 2026 02:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34G3QagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdo-0003mW-TH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:37 -0400
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34G3QagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdm-0004I8-P6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:36 -0400
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso5823481a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044513; x=1792649313; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4koF1NCcGU1IeQ9XoEMTKv9s5NkzbRBf/2bjdYh5TyU=;
 b=nZk+fY+1yidLnPgAPvPluE84PSsTRmvGNshvv6kHVEjUi2rxCoo2wPyBqSESvPjeJI
 n1ovQ0itXMNwtbSWlJp9XooldSLipHx20QJtuhDVyZ/yQG59U1SlxeSReuwVVqhtdduZ
 /CDGlu2MWtG0l4AkYFaie3F7ZBD0t8RXXr4IxVMG13WUE5mDmwKt2j1+U+AJliSk5Fbf
 nnDHSNE3ghcQEHOF+0PuUfI74iaB/nzywYSYLvIXJtYLg1TzmBTjejKJaBdIouSQMoSr
 Z4L/eIQbtt+owJJJw2xASKEPM4qMYban82T1In/0U/Vyg2rjW1rvVd84iGJ8Hi8+Ltup
 bX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044513; x=1792649313;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4koF1NCcGU1IeQ9XoEMTKv9s5NkzbRBf/2bjdYh5TyU=;
 b=UIHmkDD8FYLnIo90L5/pqJDxB7iYtNkczUTYZNny717CCQFSiDT2V+JpvMa8Z4K3rF
 WtBEm8suQ/e8pDRljKj8nZSu+Yp6II90/xkmSZ9RVJJVVxA0ik98e7zDInpbC6RLFfCC
 KU04Kp/70ROCIkFBerL0s9x4cH+bLwMJVqR2qjUJPDBW49i5KM5eVTgb+uf8N2mTjq5p
 KxGqV8/IMdqwBW90iPtgZxOJzOEp5TXq682PJaJkcVmc7DLlyQbSwpxUXjupAtS57521
 INx6TKYmhf829u19JSGekn7cZb888reXyeroAPZbu6ERmkbXa5XWUJyUfozh41sgcb5h
 ZwGg==
X-Gm-Message-State: AFq9FYIPVHSW6M20BTm8rvFEbp3IXYiJkJcVCYNvrl8d3ICtBzY7Szg2
 JdnEGYxfmOovZP/DJ73ITh8LKy1rD/G6Tja1N/UfY1nl04NCOAqaQNU5gGCiwWrdzUfom0JnkS3
 tO1Vh/lW2ROiHYY0YNG49bQ==
X-Received: from pgzz16.prod.google.com ([2002:a05:6a02:6830:b0:cc7:c1d2:623b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:83:b0:3de:80a3:cc30 with SMTP id
 adf61e73a8af0-3e16bd7e8f6mr15636695637.19.1792044512966; 
 Wed, 14 Oct 2026 23:08:32 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:21 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-3-stanleyjhu@google.com>
Subject: [PATCH 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::547;
 envelope-from=34G3QagoKClsLM3GE7RCAN9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--stanleyjhu.bounces.google.com;
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

Wire up Task Management Request (TMR) and MCQ submission queue cleanup
handling for transfer requests held by x-fault-inject-tag according to
x-fault-inject-mode:

- "abort-success": UFS_QUERY_TASK returns
  UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED. UFS_ABORT_TASK cancels the
  underlying SCSI request and marks the MCQ request in error state for
  SQRTC.ICU cleanup (or clears the legacy UTRL slot), then returns
  UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL.
- "abort-failed": UFS_ABORT_TASK returns
  UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED while keeping the request held.
- "in-transition": UFS_QUERY_TASK and UFS_ABORT_TASK complete the held
  transfer request with success and return
  UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL.
- "timeout": UFS_ABORT_TASK skips completion so the host driver hits
  its TMR timeout path.

Also clear u->held_req and disarm active_fault_inject_tag when an MCQ
submission queue containing the held request is cleaned up via
ufs_mcq_sq_cleanup().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/ufs.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index e715182b6f..33940e39a8 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -761,6 +761,87 @@ static void ufs_fault_inject_hce_reset(UfsHc *u)
     }
 }
 
+static void ufs_fault_inject_complete_held_req(UfsRequest *hreq)
+{
+    uint16_t data_seg_len = sizeof(hreq->rsp_upiu.sr.sense_data_len);
+
+    hreq->rsp_upiu.sr.sense_data_len = 0;
+    hreq->rsp_upiu.sr.residual_transfer_count = 0;
+    ufs_build_upiu_header(hreq, UFS_UPIU_TRANSACTION_RESPONSE, 0,
+                          UFS_COMMAND_RESULT_SUCCESS, 0, data_seg_len);
+    ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
+}
+
+static bool ufs_fault_inject_tmr(UfsHc *u, uint8_t tm_func, uint8_t lun,
+                                 uint32_t task_tag, uint8_t *tm_resp,
+                                 bool *skip_completion)
+{
+    UfsRequest *hreq = u->held_req;
+
+    *skip_completion = false;
+    if (!hreq || task_tag != u->active_fault_inject_tag ||
+        hreq->req_upiu.header.lun != lun) {
+        return false;
+    }
+
+    if (tm_func == UFS_QUERY_TASK) {
+        if (u->fault_inject_mode == UFS_FAULT_INJECT_IN_TRANSITION) {
+            u->held_req = NULL;
+            u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+            ufs_fault_inject_complete_held_req(hreq);
+        } else {
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
+        }
+        return true;
+    }
+
+    if (tm_func == UFS_ABORT_TASK) {
+        if (u->fault_inject_mode == UFS_FAULT_INJECT_ABORT_FAILED) {
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED;
+        } else if (u->fault_inject_mode == UFS_FAULT_INJECT_TIMEOUT) {
+            *skip_completion = true;
+        } else if (u->fault_inject_mode == UFS_FAULT_INJECT_IN_TRANSITION) {
+            u->held_req = NULL;
+            u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+            ufs_fault_inject_complete_held_req(hreq);
+        } else {
+            /* UFS_FAULT_INJECT_ABORT_SUCCESS or default */
+            u->held_req = NULL;
+            if (ufs_mcq_req(hreq)) {
+                if (hreq->sreq != NULL) {
+                    SCSIRequest *sreq = hreq->sreq;
+                    hreq->sreq = NULL;
+                    scsi_req_cancel(sreq);
+                }
+                hreq->state = UFS_REQUEST_ERROR;
+            } else {
+                ufs_clear_req(hreq);
+                hreq->state = UFS_REQUEST_IDLE;
+                u->reg.utrldbr &= ~(1 << hreq->slot);
+            }
+            u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
+        }
+        return true;
+    }
+
+    return false;
+}
+
+static void ufs_fault_inject_sq_cleanup(UfsHc *u, UfsRequest *req)
+{
+    if (u->held_req == req) {
+        u->held_req = NULL;
+        u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+        u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+    }
+}
+
 static bool ufs_fault_inject_exec_req(UfsRequest *req)
 {
     UfsHc *u = req->hc;
@@ -933,6 +1014,7 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
             UtpTaskReqDesc desc;
             uint8_t tm_func, tm_resp, lun;
             uint32_t task_tag;
+            bool skip_completion = false;
 
             if (ufs_addr_read(u, desc_addr, &desc, sizeof(desc))) {
                 continue;
@@ -942,7 +1024,12 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
             lun = desc.upiu_req.req_header.lun;
             task_tag = be32_to_cpu(desc.upiu_req.input_param2);
 
-            if (tm_func == UFS_QUERY_TASK) {
+            if (ufs_fault_inject_tmr(u, tm_func, lun, task_tag, &tm_resp,
+                                     &skip_completion)) {
+                if (skip_completion) {
+                    continue;
+                }
+            } else if (tm_func == UFS_QUERY_TASK) {
                 UfsRequest *req = ufs_find_req_by_tag(u, lun, task_tag);
 
                 if (req) {
@@ -1210,6 +1297,7 @@ static void ufs_mcq_sq_cleanup(UfsHc *u, uint8_t qid)
         }
 
         if (req) {
+            ufs_fault_inject_sq_cleanup(u, req);
             if (req->sreq != NULL) {
                 SCSIRequest *sreq = req->sreq;
                 req->sreq = NULL;
-- 
2.56.0.385.gd3acb90ef8-goog


