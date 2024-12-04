Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C5E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdca-0003EN-9A; Tue, 03 Dec 2024 19:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcU-0003Cc-Jy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcQ-0005YR-Ne
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsL66nlHuV4JdK6/kM+Un3Nz5nHzQSMy63MxFVqZCT8=;
 b=d7VQLfTsVeUw4vY8GnDRRCi5xqKjv74biPh20hNcrBtWGnOoJD7j/+KY6rCS++cw312++r
 LzsQR87yeHX9McE+GyPa4rKI3oa7yTGkrwS5Cw2W9aCh49AWvyb9Z6JVEe8sXNxYNkSR8Z
 cESHKe1daTsl6HIac5I48w767IbkrX4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-lEzTh7FRPZCCmJq1n0UVWg-1; Tue, 03 Dec 2024 19:51:51 -0500
X-MC-Unique: lEzTh7FRPZCCmJq1n0UVWg-1
X-Mimecast-MFC-AGG-ID: lEzTh7FRPZCCmJq1n0UVWg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b69c165661so346450485a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273510; x=1733878310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsL66nlHuV4JdK6/kM+Un3Nz5nHzQSMy63MxFVqZCT8=;
 b=V+FhkvUQnHANptF5NpzJdKCMZC3kxQXclwghqXa277qRJAjdDx8rSq3074fpkT9iy1
 05xsh7aarQpMv+qcMcevojSXa05lkuPK1DzJuMTlnMjGnn/6Wj8A2fdLQOMz+jzVa3El
 fQDdsYTWavul48RL5tUVdqSNNglL8gH0f/8kyDitNuq/eCYsiyN5JEODseebbNn7oF0B
 plPWdoTvmbGoXHzflV0iViyktHy1F+vdkh1okfRCexS83rlDu9vKGCbNDo1Y6PO2qws6
 /xc/oYGT6cnvdCgpqndSwPjnLEivz/77a5j//YEJrGQn898nSKFHZvPbLWNfzanuckxF
 Exlw==
X-Gm-Message-State: AOJu0Ywne04BEBfWYZXJDcR1/z02MRxuMZhXC3rg8K3SAqL6J62MduHW
 Qts4a7kMkMNQIlsxA2sz98TEEJR9mhW++2NAWTg6Q6lcZzy6+8R69RCkOUGITiNEbHHPK0MeCwo
 zMItQJ3aD0QYPezD5/xcjlIvcu7ybGeyPRJRe7/ccTy5bHbh89/mXo8s5phbfk4Cfd+3Tav8nMh
 0BzE3GiifKtMMOPGxQXvrfrTfFR2sXyasp/A==
X-Gm-Gg: ASbGncsKP7cvSAjXl9xFlM2aW98Xg056q2NO2eacNUH3ogvJnOKBWNkcORE4SIi97Tz
 dO+hJcP/dG43hDfLiyivAKFP2INbNQKiNuWXXxXjxD755+7yKRw04AmkORSwNQGcxXK2a0lNWxx
 srbOECqtm56PsIVBHEHftclwce1JjIyLAgRQlJn5EW23OrT5SA5DKu5KlB7NF7NhKqyl/yVt0Vl
 UCNwYXODb0T8i+jiZR7kS1igLx3Ya3QZwGYTAPU9uFzxX1OJ6Sxvqmt/iOJ1CPxInql284m6q8I
 G06gnlZMi4K8OyPcwLLRfENVEg==
X-Received: by 2002:a05:620a:1a26:b0:7b1:3ada:dc58 with SMTP id
 af79cd13be357-7b6a617eb13mr315585585a.34.1733273510585; 
 Tue, 03 Dec 2024 16:51:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETa/ngM/QBjIo9R9p1IezBqU7QRnSiGjlvAPsNLl/yP1dNntAjKwWUJq5x9BSoMB7RedN3oQ==
X-Received: by 2002:a05:620a:1a26:b0:7b1:3ada:dc58 with SMTP id
 af79cd13be357-7b6a617eb13mr315583285a.34.1733273510157; 
 Tue, 03 Dec 2024 16:51:50 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:49 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 05/11] migration/block: Merge block reactivations for
 fail/cancel
Date: Tue,  3 Dec 2024 19:51:32 -0500
Message-ID: <20241204005138.702289-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When migration is either cancelled or failed during switchover, especially
when after the disks are inactivated, QEMU needs to remember re-activate
the disks again before vm starts.

It used to be done separately in two paths: one in qmp_migrate_cancel(),
the other one in the failure path of migration_completion().

It used to be fixed in different commits, all over the places in QEMU.  So
these are the ones I see at least:

 - In 2016, commit fe904ea824 ("migration: regain control of images when
   migration fails to complete")

 - In 2017, commit 1d2acc3162 ("migration: re-active images while migration
   been canceled after inactive them")

 - In 2023, commit 6dab4c93ec ("migration: Attempt disk reactivation in
   more failure scenarios")

We could have done better on trying to solve this once and for all.  Now it
might be a good chance because we have a better whole picture now.

Put both of the error cases together now into migration_iteration_finish(),
which will be invoked for either of the scenario.

At the meantime, cleanup block_inactive in a few ways:

  - Rename it to block_active, which is easier to follow..

  - Maintain the flag for the whole lifecycle of QEMU.  Otherwise it's not
    clear on when the flag is valid or not.

  - Put it together with the operations, rather than updating the flag
    separately.

Now we set the flag to TRUE from the start, showing block ownership of a
fresh started QEMU (but so far only used in migration module).  Then it can
be modified by migration switchover code if invalidation happened.  With
that, the flag always reflects the correct block ownership.

NOTE: it can always be racy if there's concurrent operation to change the
block activation status (e.g., qmp_cont() right after migration failure but
right before block re-activate happens), but that's not avoidable even
before this patch, so it's not part of the goal that this patch would like
to achieve, so put aside as of now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 20 +++++++++-
 migration/migration.c | 86 +++++++++++++++++++++++++------------------
 migration/savevm.c    | 11 ++----
 3 files changed, 72 insertions(+), 45 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 3857905c0e..b71c062ad2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -370,8 +370,20 @@ struct MigrationState {
     /* Flag set once the migration thread is running (and needs joining) */
     bool migration_thread_running;
 
-    /* Flag set once the migration thread called bdrv_inactivate_all */
-    bool block_inactive;
+    /*
+     * Migration-only cache to remember the block layer activation status.
+     * Protected by BQL.
+     *
+     * We need this because..
+     *
+     * - Migration can fail after block devices are invalidated (during
+     *   switchover phase).  When that happens, we need to be able to
+     *   recover the block drive status by re-activating them.
+     *
+     * For freshly started QEMU, block_active is initialized to TRUE
+     * reflecting the scenario where QEMU owns block device ownerships.
+     */
+    bool block_active;
 
     /* Migration is waiting for guest to unplug device */
     QemuSemaphore wait_unplug_sem;
@@ -556,4 +568,8 @@ void migration_bitmap_sync_precopy(bool last_stage);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* Wrapper for block active/inactive operations */
+bool migration_block_activate(MigrationState *s);
+bool migration_block_inactivate(MigrationState *s);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index ba5deec5bc..8f7d09ca84 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -130,6 +130,47 @@ static void migration_downtime_end(MigrationState *s)
     trace_vmstate_downtime_checkpoint("src-downtime-end");
 }
 
+bool migration_block_activate(MigrationState *s)
+{
+    Error *local_err = NULL;
+
+    assert(bql_locked());
+
+    if (s->block_active) {
+        return true;
+    }
+
+    bdrv_activate_all(&local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return false;
+    }
+
+    s->block_active = true;
+    return true;
+}
+
+bool migration_block_inactivate(MigrationState *s)
+{
+    int ret;
+
+    assert(bql_locked());
+
+    if (!s->block_active) {
+        return true;
+    }
+
+    ret = bdrv_inactivate_all();
+    if (ret) {
+        error_report("%s: bdrv_inactivate_all() failed: %d\n",
+                     __func__, ret);
+        return false;
+    }
+
+    s->block_active = false;
+    return true;
+}
+
 static bool migration_needs_multiple_sockets(void)
 {
     return migrate_multifd() || migrate_postcopy_preempt();
@@ -1552,16 +1593,6 @@ static void migrate_fd_cancel(MigrationState *s)
             }
         }
     }
-    if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
-        Error *local_err = NULL;
-
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-    }
 }
 
 void migration_add_notifier_mode(NotifierWithReturn *notify,
@@ -2778,31 +2809,6 @@ static void migration_completion_postcopy(MigrationState *s)
     trace_migration_completion_postcopy_end_after_complete();
 }
 
-static void migration_completion_failed(MigrationState *s,
-                                        int current_active_state)
-{
-    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
-                              s->state == MIGRATION_STATUS_DEVICE)) {
-        /*
-         * If not doing postcopy, vm_start() will be called: let's
-         * regain control on images.
-         */
-        Error *local_err = NULL;
-
-        bql_lock();
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-        bql_unlock();
-    }
-
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
-}
-
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
@@ -2856,7 +2862,8 @@ fail:
         error_free(local_err);
     }
 
-    migration_completion_failed(s, current_active_state);
+    migrate_set_state(&s->state, current_active_state,
+                      MIGRATION_STATUS_FAILED);
 }
 
 /**
@@ -3286,6 +3293,11 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
+        /*
+         * Re-activate the block drives if they're inactivated.  Note, COLO
+         * shouldn't use block_active at all, so it should be no-op there.
+         */
+        migration_block_activate(s);
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
@@ -3858,6 +3870,8 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
+    /* Freshly started QEMU owns all the block devices */
+    ms->block_active = true;
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 3c75257318..a335344c75 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1549,17 +1549,14 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     if (inactivate_disks) {
         /* Inactivate before sending QEMU_VM_EOF so that the
          * bdrv_activate_all() on the other end won't fail. */
-        ret = bdrv_inactivate_all();
-        if (ret) {
-            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
-                       __func__, ret);
+        if (!migration_block_inactivate(ms)) {
+            error_setg(&local_err, "%s: bdrv_inactivate_all() failed",
+                       __func__);
             migrate_set_error(ms, local_err);
             error_report_err(local_err);
-            qemu_file_set_error(f, ret);
+            qemu_file_set_error(f, -EFAULT);
             return ret;
         }
-        /* Remember that we did this */
-        s->block_inactive = true;
     }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-- 
2.47.0


