Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6D2C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtm-0000QN-9l; Mon, 17 Jun 2024 14:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtZ-0000Dj-Mi
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtU-0006IV-VQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkUOOpD2kGnivnbVwfazf6T09Z5OI7fBuuuqqPaD6cU=;
 b=MtmMX2JWubsULut9Jih+8Yi//10XtUNiHT4EGIfZanKpJqZrM1Ymp8nRpIcIVYJZgX+E9q
 JhPeJ4tQSPAsgZO5AvVxg5Sclzj7juBq2hbEgD9GKJNvbX4xRe7GL8oLOWEQYOXkpyD23M
 KrbWSVLfaPYhI+vuNVwRPci6ySmKo8I=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-W0B2RQT4MymRBcArLkk1wA-1; Mon, 17 Jun 2024 14:15:48 -0400
X-MC-Unique: W0B2RQT4MymRBcArLkk1wA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-254bf518d59so735098fac.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648147; x=1719252947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkUOOpD2kGnivnbVwfazf6T09Z5OI7fBuuuqqPaD6cU=;
 b=B7/Ob0afew+mCS5MAWu52dIoFtR0FQdzlP4rEeZ0jwRwv4xvd2FfEOiI14UF+oQGLy
 IP2vC5NZuUkiEZVA5A4PA5NEJUGNtB7zGQIAq2k1jskBj7PEfCUkN5f3RcTVtPiv2cxD
 /IUCk9pEuXCnX6m86XgZPzBguJZDQH/9sQH3jEzh8KeTDLBCX4fYt9SGqRPmhz56JjK0
 oAOZ6GWmI9vCUfiajJfi+5ASXiEKMLtbiRvtPttMSCcCBl1ZSSOv41hHJRcms0Y93ijO
 805woqlZ54BEH2pW1H7CFKQlP4AyOofUPJbSBHn6Jw/o5RnlfAPQBrGfqq0Mif6mlA3L
 mvEw==
X-Gm-Message-State: AOJu0YwQbJudU1pcZe7FIYEWVsgx50nOdrPJyWA6yN0PB6BkdJr+aLNT
 DW+tyb5c81Yx2j/yxLAnJmf6RP3PZbbBWK/zy+AdetAeCS66fcpSEm4Cr0AJqfJJgqLVWkzLR90
 /xsLc1UfaS808whKF2Sg5kmoewoJ4xStS2L6wBRhLg6dN0OlBOPtTIk5kLFBB5lgq6AjS022WCG
 v6joxIGCYbSzFPwP4tYg4wmpnvc5B8LqXnvA==
X-Received: by 2002:a05:6808:3090:b0:3d2:2293:996e with SMTP id
 5614622812f47-3d24e6e93fdmr11294379b6e.0.1718648146943; 
 Mon, 17 Jun 2024 11:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/pcqVavCnrpB7VjFLnfXGN8oMw9LqOFWdTI2LV4Cw7AEYnKV9Zi/SMUTT1M0pHr+bv9JlZw==
X-Received: by 2002:a05:6808:3090:b0:3d2:2293:996e with SMTP id
 5614622812f47-3d24e6e93fdmr11294336b6e.0.1718648146200; 
 Mon, 17 Jun 2024 11:15:46 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 05/10] migration/postcopy: Add postcopy-recover-setup phase
Date: Mon, 17 Jun 2024 14:15:29 -0400
Message-ID: <20240617181534.1425179-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds a migration state on src called "postcopy-recover-setup".
The new state will describe the intermediate step starting from when the
src QEMU received a postcopy recovery request, until the migration channels
are properly established, but before the recovery process take place.

The request came from Libvirt where Libvirt currently rely on the migration
state events to detect migration state changes.  That works for most of the
migration process but except postcopy recovery failures at the beginning.

Currently postcopy recovery only has two major states:

  - postcopy-paused: this is the state that both sides of QEMU will be in
    for a long time as long as the migration channel was interrupted.

  - postcopy-recover: this is the state where both sides of QEMU handshake
    with each other, preparing for a continuation of postcopy which used to
    be interrupted.

The issue here is when the recovery port is invalid, the src QEMU will take
the URI/channels, noticing the ports are not valid, and it'll silently keep
in the postcopy-paused state, with no event sent to Libvirt.  In this case,
the only thing Libvirt can do is to poll the migration status with a proper
interval, however that's less optimal.

Considering that this is the only case where Libvirt won't get a
notification from QEMU on such events, let's add postcopy-recover-setup
state to mimic what we have with the "setup" state of a newly initialized
migration, describing the phase of connection establishment.

With that, postcopy recovery will have two paths to go now, and either path
will guarantee an event generated.  Now the events will look like this
during a recovery process on src QEMU:

  - Initially when the recovery is initiated on src, QEMU will go from
    "postcopy-paused" -> "postcopy-recover-setup".  Old QEMUs don't have
    this event.

  - Depending on whether the channel re-establishment is succeeded:

    - In succeeded case, src QEMU will move from "postcopy-recover-setup"
      to "postcopy-recover".  Old QEMUs also have this event.

    - In failure case, src QEMU will move from "postcopy-recover-setup" to
      "postcopy-paused" again.  Old QEMUs don't have this event.

This guarantees that Libvirt will always receive a notification for
recovery process properly.

One thing to mention is, such new status is only needed on src QEMU not
both.  On dest QEMU, the state machine doesn't change.  Hence the events
don't change either.  It's done like so because dest QEMU may not have an
explicit point of setup start.  E.g., it can happen that when dest QEMUs
doesn't use migrate-recover command to use a new URI/channel, but the old
URI/channels can be reused in recovery, in which case the old ports simply
can work again after the network routes are fixed up.

Add a new helper postcopy_is_paused() detecting whether postcopy is still
paused, taking RECOVER_SETUP into account too.  When using it on both
src/dst, a slight change is done altogether to always wait for the
semaphore before checking the status, because for both sides a sem_post()
will be required for a recovery.

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-38485
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json      |  4 ++++
 migration/postcopy-ram.h |  3 +++
 migration/migration.c    | 40 ++++++++++++++++++++++++++++++++++------
 migration/postcopy-ram.c |  6 ++++++
 migration/savevm.c       |  4 ++--
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a351fd3714..565c40b637 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,6 +142,9 @@
 #
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
+# @postcopy-recover-setup: setup phase for a postcopy recovery process,
+#     preparing for a recovery phase to start.  (since 9.1)
+#
 # @postcopy-recover: trying to recover from a paused postcopy.  (since
 #     3.0)
 #
@@ -166,6 +169,7 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
+            'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
 ##
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ecae941211..a6df1b2811 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_POSTCOPY_RAM_H
 #define QEMU_POSTCOPY_RAM_H
 
+#include "qapi/qapi-types-migration.h"
+
 /* Return true if the host supports everything we need to do postcopy-ram */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
                                     Error **errp);
@@ -193,5 +195,6 @@ enum PostcopyChannels {
 void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
+bool postcopy_is_paused(MigrationStatus status);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 59442181a1..fc390115bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1094,6 +1094,7 @@ bool migration_is_setup_or_active(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1116,6 +1117,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1253,6 +1255,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
@@ -1459,9 +1462,30 @@ static void migrate_error_free(MigrationState *s)
 
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
+    MigrationStatus current = s->state;
+    MigrationStatus next;
+
     assert(s->to_dst_file == NULL);
-    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+
+    switch (current) {
+    case MIGRATION_STATUS_SETUP:
+        next = MIGRATION_STATUS_FAILED;
+        break;
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
+        /* Never fail a postcopy migration; switch back to PAUSED instead */
+        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        break;
+    default:
+        /*
+         * This really shouldn't happen. Just be careful to not crash a VM
+         * just for this.  Instead, dump something.
+         */
+        error_report("%s: Illegal migration status (%s) detected",
+                     __func__, MigrationStatus_str(current));
+        return;
+    }
+
+    migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
 }
 
@@ -1562,6 +1586,7 @@ bool migration_in_postcopy(void)
     switch (s->state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         return true;
     default:
@@ -1949,6 +1974,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             return false;
         }
 
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -2981,9 +3009,9 @@ static MigThrError postcopy_pause(MigrationState *s)
          * We wait until things fixed up. Then someone will setup the
          * status back for us.
          */
-        while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        do {
             qemu_sem_wait(&s->postcopy_pause_sem);
-        }
+        } while (postcopy_is_paused(s->state));
 
         if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
             /* Woken up by a recover procedure. Give it a shot */
@@ -3679,7 +3707,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
-    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
     /*
@@ -3746,7 +3774,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
     if (resume) {
         /* Wakeup the main migration thread to do the recovery */
-        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
         qemu_sem_post(&s->postcopy_pause_sem);
         return;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 97701e6bb2..1c374b7ea1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1770,3 +1770,9 @@ void *postcopy_preempt_thread(void *opaque)
 
     return NULL;
 }
+
+bool postcopy_is_paused(MigrationStatus status)
+{
+    return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
+        status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index e71410d8c1..deb57833f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2864,9 +2864,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     error_report("Detected IO failure for postcopy. "
                  "Migration paused.");
 
-    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+    do {
         qemu_sem_wait(&mis->postcopy_pause_sem_dst);
-    }
+    } while (postcopy_is_paused(mis->state));
 
     trace_postcopy_pause_incoming_continued();
 
-- 
2.45.0


