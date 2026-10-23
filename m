Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R8zWdG4V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbh-0006mr-Ks; Fri, 23 Oct 2026 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3PkfbagoKCpcJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbe-0006m1-DN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:43 -0400
Received: from mail-pf1-x446.google.com ([2607:f8b0:4864:20::446])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3PkfbagoKCpcJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbc-00066d-Mu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:42 -0400
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-89f9fdbabe1so1197246b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755519; x=1793360319; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e7kXcOu1rXj3GG76M91zb8CjiWQiYnKx2MHHdTi0fic=;
 b=R8zWdG4VPz29DUxBMxRnAkt9uAsPIMJlDpvOSnQ/AFEp33ml1J12VsjHxys+Vz1uWr
 ZLKxdikAM9o9DXDDKD4hMGDfBr44CCduocCPfJ4H3dgnc+Zw/yR/phPVeDgwsVtmfTqR
 nsRdZ50lFYOfVApENT6xibtTsYE7tkIfcSRU8ev97TQKBMycVzyXECKTH1xW4mhy2cRL
 visTGdy8pkZrp9bICkakOvTSS6mtZpR9p8xOjFO3naCnGdqcJZX68MG2o8jPoo0DkAVt
 aIDUZUxtvF3uOfUz5rHO6D/r9L/TU0J8sCQdYd5yJcMYFmKWRDoJ/xBnFzC5rC8QcEwl
 5xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755519; x=1793360319;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e7kXcOu1rXj3GG76M91zb8CjiWQiYnKx2MHHdTi0fic=;
 b=oITS5bbq7VgDrANRMy6tjGvm0gEUGKlYyRxfWUPGrO/wQ1LcEhYEWK1GnTCxXNU1vV
 nZWxzHGCHO+oU68hFDKu73qCXF2UATUtPqzf1eQeQ2VtQHEhvzlV0V7G0YW51qJ24ra8
 7zWY9wHukw0O84JNN83vlngRMEfFACwdF1cN/00MKdn9GrwbMT51Ci7jwA8BHO+AUvvh
 hdG/7fA4oBtgkbVndg/tWt2df5i/61TOsFIFG4jljS3GH5v9oOyWTsvgKnlIMHK7tyQI
 6QgPmrcuVn3aQnbPjyCISYGavhODsUWeldKX7kJdVEALg/ZOhuCwEexTff5AH1BHL4Wx
 3o7w==
X-Gm-Message-State: AFq9FYLZkgv35bCb7u0IaUL+LCJoHxTLvePLf1+/pknYns14ne725YX4
 J/fhtOFkFxLIY4Qo2IsulRZz2cubHmMZdG2hhffbPmm+zR3u+IWtsV2Hmd5rLfeLdYf3zDbJmv5
 6ezIhxmAzkks2VR1PIHN2Yg==
X-Received: from pfhx27.prod.google.com ([2002:a05:6a00:189b:b0:88e:f55:207e])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:181c:b0:87d:3894:197b with SMTP id
 d2e1a72fcca58-8a2c668b824mr1848042b3a.59.1792755518364; 
 Fri, 23 Oct 2026 04:38:38 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:25 +0800
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023113830.3368902-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-4-stanleyjhu@google.com>
Subject: [PATCH v3 3/8] hw/ufs: Add ssu-timeout mode for power management
 recovery testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::446;
 envelope-from=3PkfbagoKCpcJK1EC5PA8L7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x446.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the experimental fault injection property x-fault-inject-mode
with a new "ssu-timeout" mode to facilitate automated testing of host
driver power management and Start Stop Unit (SSU) recovery handling.

When x-fault-inject-mode="ssu-timeout" is set and x-fault-inject-tag
is armed (e.g., 0xfffffffe for any tag, or a matching tag), the
controller only intercepts SCSI START_STOP (0x1B) commands sent to
the UFS Device Well-Known LUN (WLUN) and holds them without queuing
them to the SCSI layer, while letting non-SSU commands complete
normally. This triggers the host driver's 10-second SSU command
timeout and subsequent power management recovery routines (e.g.,
during suspend-to-idle or freeze transitions), verifying host error
recovery and link restoration paths.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/ufs.c | 19 +++++++++++++++++--
 hw/ufs/ufs.h |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 83d5fc2441..f8da7c9554 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -862,6 +862,7 @@ static void ufs_fault_inject_sq_cleanup(UfsHc *u, UfsRequest *req)
 static bool ufs_fault_inject_exec_req(UfsRequest *req)
 {
     UfsHc *u = req->hc;
+    uint8_t op;
 
     if (likely(u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_NONE) ||
         u->held_req != NULL ||
@@ -869,8 +870,21 @@ static bool ufs_fault_inject_exec_req(UfsRequest *req)
         return false;
     }
 
+    op = req->req_upiu.sc.cdb[0];
+    if (u->params.fault_inject_mode == UFS_FAULT_INJECT_SSU_TIMEOUT) {
+        if (op == START_STOP &&
+            req->req_upiu.header.lun == UFS_UPIU_UFS_DEVICE_WLUN &&
+            (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY ||
+             req->req_upiu.header.task_tag == u->active_fault_inject_tag)) {
+            u->active_fault_inject_tag = req->req_upiu.header.task_tag;
+            u->held_req = req;
+            trace_ufs_fault_inject_hold_req(req->req_upiu.header.task_tag, 0);
+            return true;
+        }
+        return false;
+    }
+
     if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
-        uint8_t op = req->req_upiu.sc.cdb[0];
         uint64_t lba = 0;
         bool is_match = false;
 
@@ -3226,6 +3240,7 @@ const QEnumLookup UfsFaultInjectMode_lookup = {
         [UFS_FAULT_INJECT_ABORT_FAILED] = "abort-failed",
         [UFS_FAULT_INJECT_IN_TRANSITION] = "in-transition",
         [UFS_FAULT_INJECT_TIMEOUT] = "timeout",
+        [UFS_FAULT_INJECT_SSU_TIMEOUT] = "ssu-timeout",
     },
     .size = UFS_FAULT_INJECT_MODE_MAX,
 };
@@ -3295,7 +3310,7 @@ const PropertyInfo ufs_prop_fault_inject_tag = {
 const PropertyInfo ufs_prop_fault_inject_mode = {
     .type = "UfsFaultInjectMode",
     .description = "Fault injection mode: abort-success, abort-failed, "
-                   "in-transition, timeout",
+                   "in-transition, timeout, ssu-timeout",
     .enum_table = &UfsFaultInjectMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 8071574e53..a1e63bd0c8 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -153,12 +153,16 @@ typedef struct UfsLu {
  * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or clear
  *                                 doorbell, triggering hardware-level TMR
  *                                 timeout.
+ * UFS_FAULT_INJECT_SSU_TIMEOUT:   Intercepts SCSI START_STOP (0x1B) commands
+ *                                 targeting the UFS Device WLUN when
+ *                                 x-fault-inject-tag is armed.
  */
 typedef enum UfsFaultInjectMode {
     UFS_FAULT_INJECT_ABORT_SUCCESS = 0,
     UFS_FAULT_INJECT_ABORT_FAILED,
     UFS_FAULT_INJECT_IN_TRANSITION,
     UFS_FAULT_INJECT_TIMEOUT,
+    UFS_FAULT_INJECT_SSU_TIMEOUT,
     UFS_FAULT_INJECT_MODE_MAX,
 } UfsFaultInjectMode;
 
-- 
2.56.0.307.g5fe7bd680c-goog


