Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B6BC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGti-0000Lf-Mn; Mon, 17 Jun 2024 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtZ-0000Dh-Nz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtU-0006IL-8B
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eSeZdzvmXBPLNKlFcOUj7uncDEIhp9AnL4Vfx5wSsI=;
 b=Zc9o2eXnjNIg1mE1X/waTQwGh/e1LC+rKyuXPRH2V3v+WjlNjdVdSL/lzQiDqdWoNz9Ljb
 UG7U6ZBAo8tQQp4iUpDbobzkyXe3sehKthzfval3huZZm9gdin6SCD8vf3sKGE/a0bcDFY
 AF1tuQ+nA/pEfBReqsHIrzWMVk4ylko=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-3mhaTe4HORWp5ZwymuSo3Q-1; Mon, 17 Jun 2024 14:15:43 -0400
X-MC-Unique: 3mhaTe4HORWp5ZwymuSo3Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad803bc570so9577866d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648142; x=1719252942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0eSeZdzvmXBPLNKlFcOUj7uncDEIhp9AnL4Vfx5wSsI=;
 b=OXFFhyBB63N12hR9VTxwAbqp0Oqn0dw87RFNtAMQlkGdhea3s8UASTF3mbJJTyG9pp
 NwT1GovUn+mVKWmdTAnyLgSyyJYRJKsTZcCrYXVQhZ7zllMyq6cjIGV7ZYyWaw71nbmN
 rKWdRKM1KcB74o4yaOfVio1yal9qo4+3e/t8fPkiCio3N+gLBkvFWka2A+xg/6j2cUPK
 ksBCjBQMPsCVJGJD/LZX6RikfYOTO8M2BMrG03qNG5YL7I30vcTfV4JotIeZDtRv7ONZ
 tNr1htTj0niFNvFlgaEddT8F8IhUevEpbsMSFWITStdPBYGpkSXT4QOa+shgCM+/ObJZ
 vd8A==
X-Gm-Message-State: AOJu0YxygzSAKvpYgeVXap54DEbEp0l7ur140jXTkfutS9JXEvPxpjHJ
 YF+6s/HxwlVV3qOtdrBG3qLZOPfDSFCTGn27zJr4mzJxOPzoTgWOBEVpxO6OPVn6DR/iCgxGS+D
 mMRCODvfwuEC5XDUWr6zbLS//TD/lGQPvBGRDRn8qS1pZhdxshcWwR8gvIa//Yt9YVM3WPybjeL
 /9rxMVoYB+Xgqbs2U4k7ZaZKQ0TycQKFnWCA==
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr1142477085a.4.1718648141653; 
 Mon, 17 Jun 2024 11:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmeSvVhxVlCoYoaL+At8yVRF9RRUHweNYGruOY/1Ah8LXb/0UzMzB4ZhJg/nYD6fz8JpD5AA==
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr1142472885a.4.1718648140994; 
 Mon, 17 Jun 2024 11:15:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 03/10] migration: Use MigrationStatus instead of int
Date: Mon, 17 Jun 2024 14:15:27 -0400
Message-ID: <20240617181534.1425179-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

QEMU uses "int" in most cases even if it stores MigrationStatus.  I don't
know why, so let's try to do that right and see what blows up..

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  9 +++++----
 migration/migration.c | 24 +++++++-----------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 6af01362d4..38aa1402d5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -160,7 +160,7 @@ struct MigrationIncomingState {
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
     GArray   *postcopy_remote_fds;
 
-    int state;
+    MigrationStatus state;
 
     /*
      * The incoming migration coroutine, non-NULL during qemu_loadvm_state().
@@ -301,7 +301,7 @@ struct MigrationState {
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
 
-    int state;
+    MigrationStatus state;
 
     /* State related to return path */
     struct {
@@ -459,7 +459,8 @@ struct MigrationState {
     bool rdma_migration;
 };
 
-void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
+                       MigrationStatus new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
@@ -479,7 +480,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
-bool migration_postcopy_is_alive(int state);
+bool migration_postcopy_is_alive(MigrationStatus state);
 MigrationState *migrate_get_current(void);
 bool migration_has_failed(MigrationState *);
 bool migrate_mode_is_cpr(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index d41e00ed4c..75c9d80e8e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -390,7 +390,7 @@ void migration_incoming_state_destroy(void)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_generate_event(int new_state)
+static void migrate_generate_event(MigrationStatus new_state)
 {
     if (migrate_events()) {
         qapi_event_send_migration(new_state);
@@ -1273,8 +1273,6 @@ static void fill_destination_migration_info(MigrationInfo *info)
     }
 
     switch (mis->state) {
-    case MIGRATION_STATUS_NONE:
-        return;
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
@@ -1290,6 +1288,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
         info->has_status = true;
         fill_destination_postcopy_migration_info(info);
         break;
+    default:
+        return;
     }
     info->status = mis->state;
 
@@ -1337,7 +1337,8 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 /* shared migration helpers */
 
-void migrate_set_state(int *state, int old_state, int new_state)
+void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
+                       MigrationStatus new_state)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
@@ -1544,7 +1545,7 @@ bool migration_in_postcopy(void)
     }
 }
 
-bool migration_postcopy_is_alive(int state)
+bool migration_postcopy_is_alive(MigrationStatus state)
 {
     switch (state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
@@ -1589,20 +1590,9 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COMPLETED:
     case MIGRATION_STATUS_FAILED:
         return true;
-    case MIGRATION_STATUS_SETUP:
-    case MIGRATION_STATUS_CANCELLING:
-    case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-    case MIGRATION_STATUS_COLO:
-    case MIGRATION_STATUS_PRE_SWITCHOVER:
-    case MIGRATION_STATUS_DEVICE:
-    case MIGRATION_STATUS_WAIT_UNPLUG:
+    default:
         return false;
-    case MIGRATION_STATUS__MAX:
-        g_assert_not_reached();
     }
-
-    return false;
 }
 
 bool migration_is_active(void)
-- 
2.45.0


