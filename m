Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A027606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpDNoB24
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlx-0006Tj-9L; Fri, 30 Oct 2026 04:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlf-0006MU-3Z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:20 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlc-0001aR-U8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:18 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-36a17a332ecso835248eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348115; x=1793952915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ayIuClwUin4beqwJzWu7BwW7Km9Z24gdUDZznk+CoGU=;
 b=vpDNoB24j9PlktZ2KIS809gFfx7WZS+nx4iAyqbR6m2G8y4qA8E9OqLrkLZFya9Vey
 63wCE6Gk4+WFxx94AUsNr+CuyPRXZuoIuHejTJ6ACUYeP6XXJgwlgr480+rz5wko7zj+
 gKpl0UsNPAIXHUdosOZ3dNzdoMknSlIsuWNc6zcI7QmcBSgGhFEW8mGUHptZrXfGL+z3
 B+w7VmfHMjAgFgrANY1ALCmlNspmAZKtLROncriZ3I3ggKSTsPccoDThjKNDkY+YRN9x
 K51xzuxTCMURrbrzBvQ/7U7t46JTsV/7s84Ajta015I4TGtsALxpbX3kM6tkMv2Awqkg
 w3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348115; x=1793952915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ayIuClwUin4beqwJzWu7BwW7Km9Z24gdUDZznk+CoGU=;
 b=GbxvlSKxGGmQchIEdgT2vTm8Nj58U89YLbsBMXaAjMf1jI6fuu3bsWR/UIDb7yqjZj
 GSuA+2uIrdMN757GoierVFCKp+r/l+3xCZZYWrZQF6I6Ehp1AxoyUWLmM/101TyOW8vt
 2coO3SSp2mUIZljzvutwDnEwgyNy4jGWf7ce2qu8WrnAXYaJxdHSQ9dLl9pCeWFVZBcW
 srG9rPbrJo79cC2/haogkElYAA1BOcixY8yP45lyR+QxbytqFEVKSyFE9VFh/9lgLUq+
 esylnMbs2mZXxBerTh7bcsOutj9aFIrZM7cCEZCJ6M8RlssBP4o0DsbfNJq6BCNmWdf3
 Yr5A==
X-Gm-Message-State: AFq9FYJ8Fu6ETNhd4B2Qd5lFpleMZwakmNMv+Jo1JVN+zLasgquhvXHA
 8RBUHAg6ZWmEXuGuxa3d3TohGTk8BbxgvuurCd9FzCoysqcaJOPgQyOHED0B5g==
X-Gm-Gg: AYBFou0GNIr+OBooeb17/9RHSPx1nmRGbz9F1nOwqstG7gkOBb7QJsfY7Z3PNmBcscw
 Tpmmy3h5ef9m1dG4GZIg39cR/RZ1xdiMeNSkDGIgdCtS5sZDloqOG9Wj/lrLoHBZeiFkLQAbCxm
 /lu1J6NwTrwwErVQQEinvxw6a7rm9iuQ0dBYsQVDuHa78NLaVMJAqVFn/Fv6cS/ivEjJhzQ94ie
 3S1Hsp/74LO7cTGOoMaKV2F17ojveB2jzvYaLefJ+QtB1mucJ5xobbanP7ewBSIhw/Npwn0wNqS
 DrsIdjf2h4wu0H/F6kfcgO/f+5SHAQOjlUGNjnQ7slncHnJ2N1Oq0BCe6HyiQo6uW7d/lLlgo2R
 g5IOKAQTELjXClcKGmX+TNkjdjkyXEatGrEJxaIkSKBH4cCKhZc639tT3oU5X9LmFfYGiycMpON
 i1NbqWNK5oTGq4eTmr49CecE/IK4OT9Y8IhAXt7V1N2z8KtF8CVeOqmFeJH5BqyQS5DrUMoHU0N
 yqRc71MV2mQvM/52AK/BWS/IJkZeoCQ/OUxvEwsUCLkfkLQLn2hkVPPiCpUmL55mAlJXikvmPtS
 p+nlnQRKjHuZHdZCBYPX3CVxlrpyEPWSg6kHXeZaaSKNViiWOK55t4goUqokHEvLtaM1hzeOf54
 TZ0dl+hb9I/U=
X-Received: by 2002:a05:701b:42c5:10b0:193:3274:aac with SMTP id
 a92af1059eb24-1ac5fd05d6bmr2160351c88.37.1793348115081; 
 Fri, 30 Oct 2026 01:15:15 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:14 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 06/12] hw/ufs: Handle task management requests for
 fault-injected held requests
Date: Fri, 30 Oct 2026 17:14:32 +0900
Message-ID: <bbd90ad70cec41436f2a4d6da5a069519e7618ab.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

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
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1a5bc54eac4..83d5fc24414 100644
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
2.43.0


