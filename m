Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C941C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnL-0002XV-RP; Tue, 23 Apr 2024 18:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0001UB-4s
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmc-00067d-Rb
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtJb1R51U7wzh9qg7ObGdI3dq4TwH6CZw7wGlzBzynE=;
 b=Sarb9Hy06hoL6u+eZQorHHVcqpb9ahqjXsU2/PPpbT1262zl5UHR7Dgzrzz6++ZiLVUtdI
 XDmOL75Xaffej5pXyyCClQmOgue/Es7UaY2Wqncp+ijbFNUcY1KunsXxnEK7ZsYq5D7RtN
 2A4eS7mhhktrqw8I4R6hK8crdkzbiCs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-xdEk5zVdNOuDC0rqcY_CWg-1; Tue, 23 Apr 2024 18:38:35 -0400
X-MC-Unique: xdEk5zVdNOuDC0rqcY_CWg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c7128fc6c7so1198523b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911915; x=1714516715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtJb1R51U7wzh9qg7ObGdI3dq4TwH6CZw7wGlzBzynE=;
 b=hvfQMb8UC9WoOkxJfLtZOiH/7t2Dly6eHfj52BHqMXEQsnRidxsY8FL8aU2npRZnU8
 aRzB9wBD2L1r1N3jiWA8OHjFEcV78wFBEdejH8vHYPxq9UOHCZPq8yAzUy9sD2BnlJ5U
 HYr38M2G8eabLkSqDPaNCSzXhT6COpldh9aNq0qvj4vla3F5Du2nW8x1frXIwvlE8uv/
 UURiQF/lA5raR46uMlwsB+mFZGL0OO0MhEXkEBuo8DYZyEVNBQO4r0U4m8oH0vLav7pf
 GH+8htK1ijdTriTmeiyHCQi+DJegMZZbcTxDOuwP+NoVhWq3AgIP5j0fmmrBsi/x4R39
 AU5w==
X-Gm-Message-State: AOJu0YwsA8VsRrvKYGVcYQZ6YlYOrRBnd+9bZvBgHjYruESn4eiXnB0d
 AhMCp0SitL7veBxjpC4FWdJi92h8SRWQsxEy+ptFniJDKeVwCM2n/+Ll6o8kcjaSwEXmBionHDy
 IeaRQPtjjrqt6sJYF5Ao+FcY1YwJx5LEi9UkZTuUxJgQfd8rRyxYZYw6oPLtEDInkEwn1KMGOtM
 ULDlW09L1LUGRUGQPfoh3pNC4k/v1ld21rfw==
X-Received: by 2002:a05:6808:19a5:b0:3c7:1773:ddb with SMTP id
 bj37-20020a05680819a500b003c717730ddbmr901624oib.5.1713911914808; 
 Tue, 23 Apr 2024 15:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjTvIu21901u5/xahy5fZzBdqx+Dw0D1EwfvQHE4VvFnlRGivZP91r1pBjBnYcUWfLpYQtOQ==
X-Received: by 2002:a05:6808:19a5:b0:3c7:1773:ddb with SMTP id
 bj37-20020a05680819a500b003c717730ddbmr901602oib.5.1713911914224; 
 Tue, 23 Apr 2024 15:38:34 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/26] migration: Add Error** argument to
 qemu_savevm_state_setup()
Date: Tue, 23 Apr 2024 18:38:02 -0400
Message-ID: <20240423223813.3237060-16-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

This prepares ground for the changes coming next which add an Error**
argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
now handle the error and fail earlier setting the migration state from
MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.

In qemu_savevm_state(), move the cleanup to preserve the error
reported by .save_setup() handlers.

Since the previous behavior was to ignore errors at this step of
migration, this change should be examined closely to check that
cleanups are still correctly done.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-7-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c | 33 +++++++++++++++++++++++++++++++--
 migration/savevm.c    | 26 +++++++++++++++-----------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 74669733dd..9ec96a995c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -32,7 +32,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
-void qemu_savevm_state_setup(QEMUFile *f);
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index 86bf76e925..696762bc64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3431,6 +3431,8 @@ static void *migration_thread(void *opaque)
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
+    Error *local_err = NULL;
+    int ret;
 
     thread = migration_threads_add("live_migration", qemu_get_thread_id());
 
@@ -3474,12 +3476,24 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * Handle SETUP failures after waiting for virtio-net-failover
+     * devices to unplug. This to preserve migration state transitions.
+     */
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto out;
+    }
+
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
@@ -3553,6 +3567,8 @@ static void *bg_migration_thread(void *opaque)
     MigThrError thr_error;
     QEMUFile *fb;
     bool early_fail = true;
+    Error *local_err = NULL;
+    int ret;
 
     rcu_register_thread();
     object_ref(OBJECT(s));
@@ -3586,12 +3602,24 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    qemu_savevm_state_setup(s->to_dst_file);
+    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * Handle SETUP failures after waiting for virtio-net-failover
+     * devices to unplug. This to preserve migration state transitions.
+     */
+    if (ret) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto fail_setup;
+    }
+
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
@@ -3660,6 +3688,7 @@ fail:
         bql_unlock();
     }
 
+fail_setup:
     bg_migration_iteration_finish(s);
 
     qemu_fclose(fb);
diff --git a/migration/savevm.c b/migration/savevm.c
index 6252fc37b7..327e9b346e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
-void qemu_savevm_state_setup(QEMUFile *f)
+int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     MigrationState *ms = migrate_get_current();
     SaveStateEntry *se;
-    Error *local_err = NULL;
     int ret = 0;
 
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
@@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
+            ret = vmstate_save(f, se, ms->vmdesc, errp);
             if (ret) {
-                migrate_set_error(ms, local_err);
-                error_report_err(local_err);
+                migrate_set_error(ms, *errp);
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
         ret = se->ops->save_setup(f, se->opaque);
         save_section_footer(f, se);
         if (ret < 0) {
+            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
+                       "%d(%s): %d", se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
             break;
         }
     }
 
     if (ret) {
-        return;
+        return ret;
     }
 
-    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
-        error_report_err(local_err);
-    }
+    /* TODO: Should we check that errp is set in case of failure ? */
+    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
 }
 
 int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1725,7 +1725,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    qemu_savevm_state_setup(f);
+    ret = qemu_savevm_state_setup(f, errp);
+    if (ret) {
+        goto cleanup;
+    }
 
     while (qemu_file_get_error(f) == 0) {
         if (qemu_savevm_state_iterate(f, false) > 0) {
@@ -1738,10 +1741,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         qemu_savevm_state_complete_precopy(f, false, false);
         ret = qemu_file_get_error(f);
     }
-    qemu_savevm_state_cleanup();
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
+cleanup:
+    qemu_savevm_state_cleanup();
 
     if (ret != 0) {
         status = MIGRATION_STATUS_FAILED;
-- 
2.44.0


