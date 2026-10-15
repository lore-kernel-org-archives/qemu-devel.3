Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3849ACC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEe1-0003p5-8B; Thu, 15 Oct 2026 02:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34m3QagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com>)
 id 1xHEds-0003ns-9L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:40 -0400
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34m3QagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdp-0004IN-Oo
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:39 -0400
Received: by mail-pl1-x648.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso46642715ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044515; x=1792649315; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rv7fv8Mq5HfQJ+NDwI7zpkuvScKfGwdgRtcmXo2PjEk=;
 b=gqLMmbndEIWXaS+UWKhReQULuooNIXQso82NDp0d1VXeqrWaBv+Efrm6xgTstd6S4/
 ScOov/30MAyaSzEeVwnNkmIeX27JbiiLus4q4XLxDB3wEkKxkxSZud66NUSA5d66EZ8d
 TUMEQm76tZA7FjRmh1bU/GB+YqMJ4XA/Fpk0cfkOxY9dWG5t+FwLG3mD6NTB+TSB4bhR
 OzatlXO5Jc5EHLJHQPLkvENekHfpvrBwWGJWk5+Etfm2dZiOWqA2uJxbz5cAGyX9aCJG
 d6U0iz9j2P+V991xSEvn3cCIujVYA0ewWnoVesYLcZOdrb4ExCm9uYM/4dS41NFmxGRC
 VW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044515; x=1792649315;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rv7fv8Mq5HfQJ+NDwI7zpkuvScKfGwdgRtcmXo2PjEk=;
 b=tPAz5YWbAv3EeghnMyhHKB1pQUdc033iv+ox13IcRO0UOa1kRVu90VvPu++/wpDKAW
 s83/sfbhNoxdjpq0TVXLyi4LpjZQGn8NOIIrGHTOO6S4+IqLn5THUY9gWzjCMX3+8P+L
 E8nOZTbVv/DPgYZ6fdoYiF6BMD8lyhzeCCNBmddt9KR411K5dG6ilx4AiG+9nvBCKnpP
 dVmmfXdDJG586J6VBYwT+D+BnEwH9J7Q8Qnpe39GM5pX5aaHLHjL6y5NIoGexcIsi+kL
 2QlcczcWU4hcHehgNbphH6fhnRTBWCRRdZozJNMX0vW531Lwx1/8IowYX46dPtNghLZm
 ozUA==
X-Gm-Message-State: AFq9FYJ6FDl5jE4PAtmKKS2r2eqKFsYSUIxGaS/mX1B7MSoAcRLGwygl
 HEioUfHY2HXj1GB9zgLFGqtwo1pY3dGjC5Lo9KcvGTjOZggfhp1oOEdBk8ZvVPz0YJ9h35aNXfO
 s3Vk2d6n7eWZsXbjZXJXPKA==
X-Received: from plnm7.prod.google.com ([2002:a17:902:fda7:b0:2e9:3ced:bb90])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f706:b0:2df:4dc5:e12e with SMTP id
 d9443c01a7336-2e842ab68afmr161915825ad.27.1792044514972; 
 Wed, 14 Oct 2026 23:08:34 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:22 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-4-stanleyjhu@google.com>
Subject: [PATCH 3/8] hw/ufs: Add ssu-timeout mode for power management
 recovery testing
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::648;
 envelope-from=34m3QagoKCl0NO5IG9TECPBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x648.google.com
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
index 33940e39a8..da8d512283 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -845,6 +845,7 @@ static void ufs_fault_inject_sq_cleanup(UfsHc *u, UfsRequest *req)
 static bool ufs_fault_inject_exec_req(UfsRequest *req)
 {
     UfsHc *u = req->hc;
+    uint8_t op;
 
     if (likely(u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_NONE) ||
         u->held_req != NULL ||
@@ -852,9 +853,21 @@ static bool ufs_fault_inject_exec_req(UfsRequest *req)
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
@@ -3188,6 +3201,8 @@ static bool ufs_fault_inject_parse_mode(const char *str,
         *mode = UFS_FAULT_INJECT_IN_TRANSITION;
     } else if (g_strcmp0(str, "timeout") == 0) {
         *mode = UFS_FAULT_INJECT_TIMEOUT;
+    } else if (g_strcmp0(str, "ssu-timeout") == 0) {
+        *mode = UFS_FAULT_INJECT_SSU_TIMEOUT;
     } else {
         error_setg(errp, "invalid x-fault-inject-mode: %s", str);
         return false;
@@ -3275,6 +3290,9 @@ static void ufs_prop_get_fault_inject_mode(Object *obj, Visitor *v,
     case UFS_FAULT_INJECT_TIMEOUT:
         str = "timeout";
         break;
+    case UFS_FAULT_INJECT_SSU_TIMEOUT:
+        str = "ssu-timeout";
+        break;
     case UFS_FAULT_INJECT_ABORT_SUCCESS:
     default:
         str = "abort-success";
@@ -3325,7 +3343,7 @@ static void ufs_prop_release_fault_inject_mode(Object *obj, const char *name,
 const PropertyInfo ufs_prop_fault_inject_mode = {
     .type = "str",
     .description = "Fault injection mode: abort-success, abort-failed, "
-                   "in-transition, timeout",
+                   "in-transition, timeout, ssu-timeout",
     .get = ufs_prop_get_fault_inject_mode,
     .set = ufs_prop_set_fault_inject_mode,
     .release = ufs_prop_release_fault_inject_mode,
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 6004268ba2..2016f72ffe 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -106,12 +106,16 @@ typedef struct UfsLu {
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
2.56.0.385.gd3acb90ef8-goog


