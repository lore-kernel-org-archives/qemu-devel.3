Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E796606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B6LnUqAF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbf-0006mB-C5; Fri, 23 Oct 2026 07:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PEfbagoKCpUHIzCA3N86J5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbc-0006lp-UA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:41 -0400
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PEfbagoKCpUHIzCA3N86J5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--stanleyjhu.bounces.google.com>)
 id 1xKDba-00066T-UC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:40 -0400
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2ea71803effso8075815ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755517; x=1793360317; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z+ZmSWkXkIwVbevimuDwXErSSjUcEchoiee/7PLiCRM=;
 b=B6LnUqAFNFYPKodKRP8560d3PvimkcqaOK5qu5v23JRCH5qx9aMJLQGMGaS4nhNx6O
 MEegzVbkx9a6sfPOj/DzpTBIFzKdd7cW/HUUkZWZAsk07jNQ0RL7vX8Snf1mL+ZIZc1Q
 vj4+r3f27/foBC/DAFNtvEoZeMRxoRahBOi3rhhG/RjOzCymWzlZC9CnprrHvGa/q9sp
 FdxQ5y6R1BTVkj4PwOcII4BAW8VMBat6lFU9/56Bohe9/+htqnSgrS58waIEidqHSeOK
 lNUo0RFJwJDNw5cgTmLGOdvIo9jjM8UAJkJ4NR0WJDArd60D0M4v7GB2Pfg+e6J2hpLb
 SYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755517; x=1793360317;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+ZmSWkXkIwVbevimuDwXErSSjUcEchoiee/7PLiCRM=;
 b=RCsqjLgrN03tRJ+15DuJTEAPbJHJRcZGT2xOG5jJdFeLtFyLcT8S28va0jR/uQNJH5
 kfpnbDsIARYy5uCIzGTKod/KwtBgueKNu57tlmKe+kywagHrm8/nIF+I9ELTFnkCjhPT
 Qq1ysDkHxNc6kSUI++UCwHhDvPnVCB76AwAuWk7k04nNo5VF8SVaRR7+cNWljS4nUdWI
 /wmpgWG7OSe57GViWrO4BIHepMj27WakwHpGSxDSfGY/1jvtw27vYlltGF1OiREzQeYz
 Ccg07zlUWrhW9IcKrgJTa55lJ/edIVL58UoU+Bl+JPkxy2DgygiK1bFjhtIL3VtPegSx
 oRkg==
X-Gm-Message-State: AFq9FYJR8RENKxfXksLX0VuESll6WEB2DwrJpHwBagyhIYRuGSE+bGXY
 MoD5+BHGQD4meyjT0UPmEtGHcWFbjq78QHUpHRsixpT/6OMlrTL/IpBdHowiSqsOOO2BLenrTav
 iy2fvQfHUA6pp446clOM1GA==
X-Received: from pggu22.prod.google.com ([2002:a63:df16:0:b0:ccb:62e:3f01])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d89:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3adce5e61camr1527026a91.16.1792755516334; 
 Fri, 23 Oct 2026 04:38:36 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:24 +0800
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-3-stanleyjhu@google.com>
Subject: [PATCH v3 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::648;
 envelope-from=3PEfbagoKCpUHIzCA3N86J5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x648.google.com
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
- "in-transition": UFS_QUERY_TASK releases the held transfer request
  and executes it through the normal SCSI command path, completing
  with genuine device I/O and CQE generation, while returning
  UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED per SAM-5 task set rules.
  UFS_ABORT_TASK releases the held request to generic abort processing.
- "timeout": UFS_ABORT_TASK skips completion so the host driver hits
  its TMR timeout path.

Also clear u->held_req and disarm active_fault_inject_tag when an MCQ
submission queue containing the held request is cleaned up via
ufs_mcq_sq_cleanup().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/ufs.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1a5bc54eac..83d5fc2441 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -37,6 +37,7 @@
 #define UFS_HID_PROGRESS_COMPLETE 100
 
 static void ufs_exec_req(UfsRequest *req);
+static void ufs_fault_inject_execute_held_req(UfsRequest *hreq);
 static void ufs_clear_req(UfsRequest *req);
 static void ufs_mcq_process_cq(void *opaque);
 
@@ -797,6 +798,67 @@ static void ufs_fault_inject_hce_reset(UfsHc *u)
     }
 }
 
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
+        if (u->params.fault_inject_mode == UFS_FAULT_INJECT_IN_TRANSITION) {
+            u->held_req = NULL;
+            u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+            ufs_fault_inject_execute_held_req(hreq);
+            return false;
+        }
+        /*
+         * Generic QUERY TASK in ufs_process_tmr() will check
+         * ufs_find_req_by_tag() and return SUCCEEDED for the held request.
+         */
+        return false;
+    }
+
+    if (tm_func == UFS_ABORT_TASK) {
+        if (u->params.fault_inject_mode == UFS_FAULT_INJECT_ABORT_FAILED) {
+            *tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED;
+            return true;
+        }
+        if (u->params.fault_inject_mode == UFS_FAULT_INJECT_TIMEOUT) {
+            *skip_completion = true;
+            return true;
+        }
+
+        /*
+         * UFS_FAULT_INJECT_ABORT_SUCCESS, UFS_FAULT_INJECT_IN_TRANSITION,
+         * or default:
+         * Release the fault-injection hold, then let generic ABORT TASK
+         * in ufs_process_tmr() handle cancellation.
+         */
+        u->held_req = NULL;
+        u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+        u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+        return false;
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
@@ -980,6 +1042,7 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
             UtpTaskReqDesc desc;
             uint8_t tm_func, tm_resp, lun;
             uint32_t task_tag;
+            bool skip_completion = false;
 
             if (ufs_addr_read(u, desc_addr, &desc, sizeof(desc))) {
                 continue;
@@ -989,7 +1052,12 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
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
@@ -1257,6 +1325,7 @@ static void ufs_mcq_sq_cleanup(UfsHc *u, uint8_t qid)
         }
 
         if (req) {
+            ufs_fault_inject_sq_cleanup(u, req);
             if (req->sreq != NULL) {
                 SCSIRequest *sreq = req->sreq;
                 req->sreq = NULL;
@@ -2537,6 +2606,16 @@ static void ufs_exec_req(UfsRequest *req)
     }
 }
 
+static void ufs_fault_inject_execute_held_req(UfsRequest *hreq)
+{
+    UfsReqResult req_result;
+
+    req_result = ufs_exec_scsi_cmd(hreq);
+    if (req_result != UFS_REQUEST_NO_COMPLETE) {
+        ufs_complete_req(hreq, req_result);
+    }
+}
+
 static void ufs_process_req(void *opaque)
 {
     UfsHc *u = opaque;
-- 
2.56.0.307.g5fe7bd680c-goog


