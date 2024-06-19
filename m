Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B514C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pc-0001qj-4D; Wed, 19 Jun 2024 18:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pZ-0001pr-Q9
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pY-0008Pg-5z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OLzgDhdQQ/rnqys7jTEDSrmmLFb9m3Dvl5rC/DAIz0=;
 b=hsWl/3pKx7jxlQgYSNXoOGUG4/pP4MU3VaZ4w90rzmFVjoZBOWIcFNsrd19oeD7ijNcPtd
 EzIYTiRvwMpQknOap+sca2B1rflgmD4QBYpu9g1ge7fWUZx3brVyz3rDUCLETHPDKT/VFW
 M9irchDz7pREgEND5ObRsEbCok8cFhM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-nFyUcqlEN4CmA14RcwRXxA-1; Wed, 19 Jun 2024 18:30:58 -0400
X-MC-Unique: nFyUcqlEN4CmA14RcwRXxA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b50a68ff6cso780626d6.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836258; x=1719441058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OLzgDhdQQ/rnqys7jTEDSrmmLFb9m3Dvl5rC/DAIz0=;
 b=J0+pCqlQDfiHYL8SfuSxtnTbbrJiRF8BPnV31lxq4V/fssmHM68akL9LcAGX/Z+rZE
 6xQPRtEYN2mfQVZqZ7kYS50bX+Bmfaa4pR97g7AGhjvx9R9AvHBx9KclVF1xarmAc+4w
 HW7Tn3Gv59QHxSdwlhaSSRCME0RWJBwe4k5oCu4K+3nssFwXX+hwQQz0SWzCsSeHbOIJ
 HFfijN9Hvr3yhA6e5sIZUUXYLRMYEYTelSShEY1WgW+6VbRk9O/oU5T/20g1J3GW23r8
 dttCqT5mIbwq8ZWoQPY7+8q+3lXB0fs2hvFUFPDVz3GUSGxrX0WLFVxcvaNe1lpICjog
 CDvg==
X-Gm-Message-State: AOJu0YwkiLgCMSq+lzvHysVleK0t6bHlDhZAl4Ej57q6G5Bxrkr784Z3
 JTxnyXew1sJxweBJlypL2FE59LmObC5doWVDjfwxHm5KgJgc+yPwTuq5Z4GPJwx4PoFIf1z0SIv
 vgLT7A5S83N7hgjtT9cJX+oBOcZFtaXWDDI5+6P98Fnnj5kskG3tBW/P8B39XLOFEdq+pB2WnBL
 W0+Of3Yj8vKs9B2+L6M7mBbGpLs6RXn8zMpg==
X-Received: by 2002:ad4:5044:0:b0:6b5:6a3:7e4 with SMTP id
 6a1803df08f44-6b506a30a02mr28531956d6.6.1718836257501; 
 Wed, 19 Jun 2024 15:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaYkYjM4e/RU/DbYTtF3oodGj7vgsAuNjsu5XOBMS/yXhpm8EbwJhliZzxSzA/QvJugo3Bmw==
X-Received: by 2002:ad4:5044:0:b0:6b5:6a3:7e4 with SMTP id
 6a1803df08f44-6b506a30a02mr28531666d6.6.1718836256796; 
 Wed, 19 Jun 2024 15:30:56 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 03/11] migration: Use MigrationStatus instead of int
Date: Wed, 19 Jun 2024 18:30:38 -0400
Message-ID: <20240619223046.1798968-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

QEMU uses "int" in most cases even if it stores MigrationStatus.  I don't
know why, so let's try to do that right and see what blows up..

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index f9b69af62f..795b30f0d0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -413,7 +413,7 @@ void migration_incoming_state_destroy(void)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_generate_event(int new_state)
+static void migrate_generate_event(MigrationStatus new_state)
 {
     if (migrate_events()) {
         qapi_event_send_migration(new_state);
@@ -1296,8 +1296,6 @@ static void fill_destination_migration_info(MigrationInfo *info)
     }
 
     switch (mis->state) {
-    case MIGRATION_STATUS_NONE:
-        return;
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
@@ -1313,6 +1311,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
         info->has_status = true;
         fill_destination_postcopy_migration_info(info);
         break;
+    default:
+        return;
     }
     info->status = mis->state;
 
@@ -1360,7 +1360,8 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 /* shared migration helpers */
 
-void migrate_set_state(int *state, int old_state, int new_state)
+void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
+                       MigrationStatus new_state)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
@@ -1567,7 +1568,7 @@ bool migration_in_postcopy(void)
     }
 }
 
-bool migration_postcopy_is_alive(int state)
+bool migration_postcopy_is_alive(MigrationStatus state)
 {
     switch (state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
@@ -1612,20 +1613,9 @@ bool migration_is_idle(void)
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


