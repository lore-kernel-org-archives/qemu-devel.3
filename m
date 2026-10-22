Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D571606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RjoVLwej
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUL-0007Fn-HY; Thu, 22 Oct 2026 03:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3D7_ZagoKClICDu75yI31E08805y.w86Ay6E-xyFy578707E.8B0@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUJ-0007FG-Vn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:24 -0400
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3D7_ZagoKClICDu75yI31E08805y.w86Ay6E-xyFy578707E.8B0@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUI-0002Ga-7U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:23 -0400
Received: by mail-pl1-x647.google.com with SMTP id
 d9443c01a7336-2e93f266d20so22825585ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655120; x=1793259920; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zrtx18tA7GBAcf7rkDCL5qWhALr2rFi5M+XElgsHVS0=;
 b=RjoVLwej0fJWvPO6vWD531FLz9RKDJFvcZbxLeqAKDg+PwO88DMZ/oT0XoosfFwjpy
 vCzi+BNvvKB4wVzaLBupj8POomMZE3E+azZCNC0/wkDzUNSJNeGhH+bFDZ5B0WvlDRqC
 HsZk5DDLBqACBFbvuiqqE1KyNZvqaQowUpBILj1kbghxXU3v2kyV98uflpycMXeoJt1z
 ewBWd6/g4IvvQzq98EhynyG9jwvhZBgxnzkywB2nz6mGvJlATANR6WdW9fvxjj6x7Cvo
 5NngTQ9pWnU6yDDPpYBNE2qNvBvwL01LEFU3LpXNEzT6eKiT9Z+jds9hdusAc+Bw6aRs
 RMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655120; x=1793259920;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zrtx18tA7GBAcf7rkDCL5qWhALr2rFi5M+XElgsHVS0=;
 b=ObVxnzjI2bQ+uWQr3hPUsGozPI5ykcQOYmZ4n/4CoNCS77x6kd+SdmFLByqk2j2a+y
 J8xrG0FxySIizGIYLTpwrQzGThmmLFIbWyG5OztiIXDd2sZWkyaYMygVLJdpCa+mOZSo
 bKL3X68wuNuEocu//qRqhFICXEXrDvVWFPF4XQF2MUl6UWN68Uz63VmXXRqF0Cik0RLD
 PoGEPU2+GNZiYi2rRxNBq/K3hHWX+My1K3iGmUyUf3s1cUTj8b1T/aVXGNcCXFKFfUrl
 27KrsMKWL36GbXGaQaqiRX8GizOAo5SPyP4Dn1Zga0QMPTIPWs+LecWbxNTfNJ4SU+fn
 Gmbw==
X-Gm-Message-State: AFq9FYIgaLdBx7YsJ+iJJlMXmpUktu5cETeXY+qpnCVwQE/AULdOY5Y7
 cm6/469KAc4OLRJNNqpW3xMDNh1SxP9bSoPZHUNzl5MiVETiJ9Ou+m8vmc4NqsfnPhzkM2ZVT7p
 x0238LtD8u/TU6TqimBrkSw==
X-Received: from plsb13.prod.google.com ([2002:a17:902:b60d:b0:2e9:569d:e0fc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f645:b0:2e9:5c29:995e with SMTP id
 d9443c01a7336-2ea43f622fdmr37967875ad.41.1792655119529; 
 Thu, 22 Oct 2026 00:45:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:07 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::647;
 envelope-from=3D7_ZagoKClICDu75yI31E08805y.w86Ay6E-xyFy578707E.8B0@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x647.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
  transfer request with success without executing the SCSI command or
  transferring data, and return UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL.
- "timeout": UFS_ABORT_TASK skips completion so the host driver hits
  its TMR timeout path.

Also clear u->held_req and disarm active_fault_inject_tag when an MCQ
submission queue containing the held request is cleaned up via
ufs_mcq_sq_cleanup().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/ufs.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index f356818375..6d7bd16953 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -796,6 +796,91 @@ static void ufs_fault_inject_hce_reset(UfsHc *u)
     }
 }
 
+/*
+ * In-transition mode simulates a held request completing during TMR
+ * execution without executing the SCSI command or transferring data.
+ */
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
@@ -968,6 +1053,7 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
             UtpTaskReqDesc desc;
             uint8_t tm_func, tm_resp, lun;
             uint32_t task_tag;
+            bool skip_completion = false;
 
             if (ufs_addr_read(u, desc_addr, &desc, sizeof(desc))) {
                 continue;
@@ -977,7 +1063,12 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
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
@@ -1245,6 +1336,7 @@ static void ufs_mcq_sq_cleanup(UfsHc *u, uint8_t qid)
         }
 
         if (req) {
+            ufs_fault_inject_sq_cleanup(u, req);
             if (req->sreq != NULL) {
                 SCSIRequest *sreq = req->sreq;
                 req->sreq = NULL;
-- 
2.56.0.218.g1ec904b173-goog


