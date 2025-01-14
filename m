Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36902E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1V-00023a-C3; Tue, 14 Jan 2025 18:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1K-00021k-VN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1G-0004DC-RJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uw97LMM4hh1MOntWweq85MDlCjOv/z8693OvKaqOQvo=;
 b=ZWUEKz+FsbA8xTPBFmAP0MTUHWPNdPFIc1VXE73AJ0FJlH7FaCoWJdOVEKWFhfbIQ2IpS8
 JZjy5VRs4qhSIhmrLpha2wkmmL/NVb3Ys/XdykKJa7d8VOaD+aQHXTzl+AKuotjfF+hy69
 jJRSSVxaNV6d2X89Rn3WZwlncZ+eFwo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-TZdi32LlNHK4YGZICVlYVQ-1; Tue, 14 Jan 2025 18:08:18 -0500
X-MC-Unique: TZdi32LlNHK4YGZICVlYVQ-1
X-Mimecast-MFC-AGG-ID: TZdi32LlNHK4YGZICVlYVQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4678b42cbfeso122244701cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896096; x=1737500896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uw97LMM4hh1MOntWweq85MDlCjOv/z8693OvKaqOQvo=;
 b=Gv8ws/KRZEKpSTKkEbfCJYn9cTNUbUrraOqUmqCO0Rug5ooVX5GAcWJTstU8CB7ovn
 NUiOJzdfjq1bDSEKfcb4Tjy6O4AgO7L12tLBjiFLjbfljcunWa0Vbi9ORXPb0avGIM4Z
 Le/FX5kQAhXYEin6zjSve32vXu814UMUZdZJ66m9HbZxbMKYHI/T3o5zqpvgHM7hliA8
 aUdw2IWlNmEbtBoHFmX18Thb33K6n7yjmQ08eWoLv6L7pDtGzSMEJ+RC8+edobL/dyI3
 M9qnJF7oJZD5gSvjCcuTQA8sF5kMuQoc18fibYhqj7cJBdwKNguhk25ANSrYnuhjCjo7
 WwBA==
X-Gm-Message-State: AOJu0Yxxl9/JwvTQNOc0lu/LyeGQV+O7UKBgAFfS94AY+6H25gYK8EUO
 iNsOOtGPk7nZFsG6w//t+q6/Rfrs9+j3zIh6lDedIyozKOf9fhJDIs3tC8qpeVFGsKj567uGvSU
 7JML/TZ/FH73N9AUNOCYFVnzFkKqZBzhA3GSm3cAMVrE5zNsY3NrFe84O+NBdcnHOhkFt9Pjs87
 5bt8Ml0vImRdWK1ngSzUyh7WpiNSk6WHswug==
X-Gm-Gg: ASbGncs3YuDH+wztNiEQa4L841RIeiBAP/TSQ3ZGeyLSJ4SRno0PYTTPA7Kw9AQImam
 HfJBU51GjNZzR8rTFexUIL3ug3OPhXaZZV5M5w5mVsC/VNKGGxdfpc9b7sP1wzCXnIwNNJsBlM5
 DvGlEEmKM9ucutm86n87RZdKjuXtOGLcjiqJ4ufGCoSoesAaWePzpPNQxlZPMtI08akkAei0XJ/
 IjoKId92FEryn4PJtmbeZjpUZPoRTICyGJF/yTEjF+ygxoM4ZYqzOZI8nlGH+BoxDt4DOwfuM++
 N1iA8MhnHCWE/jnUZW8cWFJzzYM+hws4
X-Received: by 2002:ac8:5852:0:b0:467:5eaf:7d1f with SMTP id
 d75a77b69052e-46c710a63ebmr451181351cf.50.1736896096257; 
 Tue, 14 Jan 2025 15:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTUAFzoNp7Mz4AuWe94I+cTCZXdUgKKsBUdzu3bpygRta5pCXnW5eMIugh16bHEis9jBvH4A==
X-Received: by 2002:ac8:5852:0:b0:467:5eaf:7d1f with SMTP id
 d75a77b69052e-46c710a63ebmr451180961cf.50.1736896095882; 
 Tue, 14 Jan 2025 15:08:15 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 15/16] migration: Merge precopy/postcopy on switchover start
Date: Tue, 14 Jan 2025 18:07:45 -0500
Message-ID: <20250114230746.3268797-16-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now after all the cleanups, finally we can merge the switchover startup
phase into one single function for precopy/postcopy.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2a95081b6c..f6694e7e94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,7 +102,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static bool migration_switchover_start(MigrationState *s);
+static bool migration_switchover_start(MigrationState *s, Error **errp);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2540,21 +2540,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    if (!migration_switchover_start(ms)) {
-        error_setg(errp, "migration_switchover_start() failed");
+    if (!migration_switchover_start(ms, errp)) {
         goto fail;
     }
 
-    if (!migration_block_inactivate()) {
-        error_setg(errp, "%s: Failed in bdrv_inactivate_all()", __func__);
-        goto fail;
-    }
-
-    /* Switchover phase, switch to unlimited */
-    migration_rate_set(RATE_LIMIT_DISABLED);
-
-    precopy_notify_complete();
-
     /*
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
@@ -2686,7 +2675,7 @@ fail:
 }
 
 /**
- * @migration_switchover_start: Start VM switchover procedure
+ * @migration_switchover_prepare: Start VM switchover procedure
  *
  * @s: The migration state object pointer
  *
@@ -2701,7 +2690,7 @@ fail:
  *
  * Returns: true on success, false on interruptions.
  */
-static bool migration_switchover_start(MigrationState *s)
+static bool migration_switchover_prepare(MigrationState *s)
 {
     /* Concurrent cancellation?  Quit */
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -2749,21 +2738,13 @@ static bool migration_switchover_start(MigrationState *s)
     return s->state == MIGRATION_STATUS_DEVICE;
 }
 
-static int migration_completion_precopy(MigrationState *s)
+static bool migration_switchover_start(MigrationState *s, Error **errp)
 {
-    int ret;
-
-    bql_lock();
-
-    if (!migrate_mode_is_cpr(s)) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            goto out_unlock;
-        }
-    }
+    ERRP_GUARD();
 
-    if (!migration_switchover_start(s)) {
-        goto out_unlock;
+    if (!migration_switchover_prepare(s)) {
+        error_setg(errp, "Switchover is interrupted");
+        return false;
     }
 
     /* Inactivate disks except in COLO */
@@ -2773,8 +2754,8 @@ static int migration_completion_precopy(MigrationState *s)
          * bdrv_activate_all() on the other end won't fail.
          */
         if (!migration_block_inactivate()) {
-            ret = -EFAULT;
-            goto out_unlock;
+            error_setg(errp, "Block inactivate failed during switchover");
+            return false;
         }
     }
 
@@ -2782,6 +2763,27 @@ static int migration_completion_precopy(MigrationState *s)
 
     precopy_notify_complete();
 
+    return true;
+}
+
+static int migration_completion_precopy(MigrationState *s)
+{
+    int ret;
+
+    bql_lock();
+
+    if (!migrate_mode_is_cpr(s)) {
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            goto out_unlock;
+        }
+    }
+
+    if (!migration_switchover_start(s, NULL)) {
+        ret = -EFAULT;
+        goto out_unlock;
+    }
+
     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
-- 
2.47.0


