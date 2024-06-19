Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B6DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pe-0001rO-5f; Wed, 19 Jun 2024 18:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pc-0001qn-Mj
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pa-0008Pz-Lp
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9clR7IoupnKkwSljXq0px/U1vTlfLmSISM5L429P7S0=;
 b=QXa/JBemIz0Sn452030VUTJ3zKfnGNevosYvz9pkmR5h9hy6VqiNkIf8Kq1So1YcCtmuwG
 5o5+Kf0cGRZkbFOGSyU5UaFbaQaQLzK43GtKFNZ7XWAJpLSpDHv0PkKCZ9/RbHg6nZ7fLL
 rqGgCWaxt25jZeFxqdt4iNUbPoNE7Eo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-CcxlBoe5MaGJLiIO3tLziA-1; Wed, 19 Jun 2024 18:31:03 -0400
X-MC-Unique: CcxlBoe5MaGJLiIO3tLziA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b50790e82bso853646d6.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836262; x=1719441062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9clR7IoupnKkwSljXq0px/U1vTlfLmSISM5L429P7S0=;
 b=Ca0uxxe9ymySTDKzqLu6mPo8Z1HK9OSyJ7gaLzjFxD/ooAOhuwcOJfkWGcQSQPjpi1
 FF43Ims9Y1RTO/hDXljcGmFO8LPW+WVRAzCdP6dshmSrEIdI5N1uH82X4nmFm0OgRziW
 5/lKqPgvQIIgFacEQHgFcRbW1oN66vCLjrlNqn1A3x/bDR2oYcP3wUv03YD1Qr6eSMDh
 1CB1LvDdd+7xLAYaHPJm+LRpKO4+Izm86RULYtcsFRaZy+y8aDtAQoz553aPGebmEi95
 TVPsWqeNKd2SyMhod3k8cjZZ0Oc9udqLbqrMBi3x6AVxEQWyrPo+VnFbj7jnq9hGiWih
 voSw==
X-Gm-Message-State: AOJu0YwkXCcMgE4rlprOEX33jdawxVvb68lFXiko41fm+zCNcEaB61Ml
 9RKB4cUI7nZ4x1PGHbcy25Im1OjbhyYik9OU6GR22ARDeesnLsaJUyowuxEj9SQoplskUo+goJf
 PVdECOo7LyBo4UUY76L10j2aj+iIWb00E3SVf7manlLbxYI0FMnUa+olQGkC6npaIohQuZG3nvB
 tKJChApdj7vAwY6FlHJtLo5x5TMcZqBNKUWg==
X-Received: by 2002:ad4:4b24:0:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b506a30a0dmr27874986d6.5.1718836261869; 
 Wed, 19 Jun 2024 15:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvsYjSgjhmTkHOYinwG2e+pfTgpX3KgajRY7ZH8igBWF/DbNBVGr6jrKUsXLCoJCk+bDTPKQ==
X-Received: by 2002:ad4:4b24:0:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b506a30a0dmr27874676d6.5.1718836261085; 
 Wed, 19 Jun 2024 15:31:01 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 05/11] migration/postcopy: Add postcopy-recover-setup phase
Date: Wed, 19 Jun 2024 18:30:40 -0400
Message-ID: <20240619223046.1798968-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Cc: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index de6c8b0444..0f24206bce 100644
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
index 41a88fc50a..3dea06d577 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1117,6 +1117,7 @@ bool migration_is_setup_or_active(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1139,6 +1140,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1276,6 +1278,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
@@ -1482,9 +1485,30 @@ static void migrate_error_free(MigrationState *s)
 
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
 
@@ -1585,6 +1609,7 @@ bool migration_in_postcopy(void)
     switch (s->state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         return true;
     default:
@@ -1972,6 +1997,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             return false;
         }
 
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -3004,9 +3032,9 @@ static MigThrError postcopy_pause(MigrationState *s)
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
@@ -3702,7 +3730,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
-    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
     /*
@@ -3769,7 +3797,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
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


