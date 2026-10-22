Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED1606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i+m4/7XX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnVw-0000G3-JW; Thu, 22 Oct 2026 03:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Eb_ZagoKClQEFw970K53G2AA270.yA8C08G-z0H079A929G.AD2@flex--stanleyjhu.bounces.google.com>)
 id 1xJnV6-0007bm-Rp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:46:32 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Eb_ZagoKClQEFw970K53G2AA270.yA8C08G-z0H079A929G.AD2@flex--stanleyjhu.bounces.google.com>)
 id 1xJnV4-0002WA-Qr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:46:12 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-3ad53f538d2so1640749a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655165; x=1793259965; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SihwI6II02J0wSv5mm6TKsCxV9e6o3CfwSzvMI5XV88=;
 b=i+m4/7XXzTNDHETjEfm5wwwAiPElfbW5u/fkpEihsuBICRz2dwNQKuYQN78xu2u2ll
 TiZoP70oUa+SujY9vf9UvfeduDL7G9Mjo5BfEI1319kv5AsTcAkPsFDQyu6YcZP079DC
 22Bp765Z+L2qky+ow1MoOfSxKVfNkRleK7p14lHqbJg1k0jogr0u1O77dxBLvee4nVVM
 QmDhHfcJt73EHmS6lzmVzDrHypbr1ZdsvUuCJ1UqiagCjxQ+46fJwihDmOWCqRMMswUK
 1TL9E6iDjES9DYq1OH7GQISYX6t79YT5geMWfHdBXTaE9AsBETOr/Xz7lfkIBkKrvse4
 3rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655165; x=1793259965;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SihwI6II02J0wSv5mm6TKsCxV9e6o3CfwSzvMI5XV88=;
 b=aC61Ef3EgmB0DXNr65DLYG5+Ettrp2bDyEDukihoAn1Z4hNPR0Z+4fny685t5fhe2B
 e5FMOFrtqYncmTFpq7SdcjRdHe7Xu6IcK/N31dcbJ7uJJTTZvGlziWB0aFrvUF9LEsVy
 vAL4IOLN9sF0xbBczSrmh6q/sj3ZVcFGqycbX0uTLDtBPf+xmHpNBPO1L4mrw+WQ4atF
 OmsC8Aieiz10HFQyrPLnCvikM6vuE+B8p7sv4d/tH1OH2WWLpfaa0ZOzNwwbwGJjmq3/
 zIBL4vNDkBuMUS6apidxu5n2wPyGjfjfxkasht00/yyIMaHxbPgIuWQnFWBqM7dXPYQy
 7tag==
X-Gm-Message-State: AFq9FYL12TU29x47v1cdkepDtJrp6K6RcpomW6zMX+KIZlIySZfJqgc3
 Hv72BchjI2mpYjDrGQwCJPo3v4yUg8Q1fIyCQ0rzSY17WXFRAiSbRV8yOz+y8nouWp8682+pano
 OH+10+Ehdj+5a/XTcNSYjYQ==
X-Received: from pjhr3.prod.google.com ([2002:a17:90a:5003:b0:3a9:ccc3:cbae])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b0a:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3ad86caa7cdmr3724017a91.46.1792655121455; 
 Thu, 22 Oct 2026 00:45:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:08 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-4-stanleyjhu@google.com>
Subject: [PATCH v2 3/8] hw/ufs: Add ssu-timeout mode for power management
 recovery testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3Eb_ZagoKClQEFw970K53G2AA270.yA8C08G-z0H079A929G.AD2@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1047.google.com
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
 hw/ufs/ufs.c | 24 +++++++++++++++++++++---
 hw/ufs/ufs.h |  4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 6d7bd16953..c54b31716e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -884,6 +884,7 @@ static void ufs_fault_inject_sq_cleanup(UfsHc *u, UfsRequest *req)
 static bool ufs_fault_inject_exec_req(UfsRequest *req)
 {
     UfsHc *u = req->hc;
+    uint8_t op;
 
     if (likely(u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_NONE) ||
         u->held_req != NULL ||
@@ -891,9 +892,21 @@ static bool ufs_fault_inject_exec_req(UfsRequest *req)
         return false;
     }
 
-    if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
-        uint8_t op = req->req_upiu.sc.cdb[0];
+    op = req->req_upiu.sc.cdb[0];
+    if (u->fault_inject_mode == UFS_FAULT_INJECT_SSU_TIMEOUT) {
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
 
+    if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
         if (op == READ_10 || op == WRITE_10) {
             /*
              * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
@@ -3233,6 +3246,8 @@ static bool ufs_fault_inject_parse_mode(const char *str,
         *mode = UFS_FAULT_INJECT_IN_TRANSITION;
     } else if (g_strcmp0(str, "timeout") == 0) {
         *mode = UFS_FAULT_INJECT_TIMEOUT;
+    } else if (g_strcmp0(str, "ssu-timeout") == 0) {
+        *mode = UFS_FAULT_INJECT_SSU_TIMEOUT;
     } else {
         error_setg(errp, "invalid x-fault-inject-mode: %s", str);
         return false;
@@ -3320,6 +3335,9 @@ static void ufs_prop_get_fault_inject_mode(Object *obj, Visitor *v,
     case UFS_FAULT_INJECT_TIMEOUT:
         str = "timeout";
         break;
+    case UFS_FAULT_INJECT_SSU_TIMEOUT:
+        str = "ssu-timeout";
+        break;
     case UFS_FAULT_INJECT_ABORT_SUCCESS:
     default:
         str = "abort-success";
@@ -3370,7 +3388,7 @@ static void ufs_prop_release_fault_inject_mode(Object *obj, const char *name,
 const PropertyInfo ufs_prop_fault_inject_mode = {
     .type = "str",
     .description = "Fault injection mode: abort-success, abort-failed, "
-                   "in-transition, timeout",
+                   "in-transition, timeout, ssu-timeout",
     .get = ufs_prop_get_fault_inject_mode,
     .set = ufs_prop_set_fault_inject_mode,
     .release = ufs_prop_release_fault_inject_mode,
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 39213650bb..29332e6b1d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -151,12 +151,16 @@ typedef struct UfsLu {
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
 } UfsFaultInjectMode;
 
 /*
-- 
2.56.0.218.g1ec904b173-goog


