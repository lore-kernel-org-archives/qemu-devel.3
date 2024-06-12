Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB12C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBS-00086n-NC; Wed, 12 Jun 2024 10:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBR-00085r-Gf
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBP-0002lq-Sa
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718203359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Y1IDYkI+aUDRc+MKkp3+DSunQulfjkQ0w9dXYr1Xhs=;
 b=OzpYiwvrZzIB4xrzIMYojcl+hP3f8FlqUF8dP16aF+SWWb5Y/RiNwGT7eLmJo9SO4EHWX8
 LMqbfjkNAHSPEx/i1N9kh9gL/tD+BGlhVZTg0vu8UWFp1sKI+boKQ8l/AyNTbn/8X3/DoA
 pQeF+FYQ3Xgf+Bue7c5vRc4iSoVJfeA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-HsOLga9hNCyy0-Hflst8vw-1; Wed, 12 Jun 2024 10:42:37 -0400
X-MC-Unique: HsOLga9hNCyy0-Hflst8vw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dfefde6c84dso8222276.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203356; x=1718808156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y1IDYkI+aUDRc+MKkp3+DSunQulfjkQ0w9dXYr1Xhs=;
 b=QEekkh2/FUtrjs17oSfGKkfL4JJgjoVJCm8x1N7n/l0CO0ii4gNn+t1lnPl+s89DAg
 OqyLhJAgYnwqBsQRnxdcBCtye2Ut0w8gSOPz9Rooe01ZfSA0PEQck9CZZQe64ZsCuM8V
 3JzSEdoosreuA03/HfWP/OhxqZsmEidF31DKEucMk8NtJt8jKUJuCh/PB1o7z/Jqw55k
 te9e0l0w2Ky1YaecT6Ojao93lHPzQ9ToGHp6I2S0OJftQasd7+pN9OmflPzISYWoLem1
 ZamaIsC4x3G+EDPBIVLQ81Igyi0WA6L8wQeN9GBN7oRrO8/l6+zDP6M7M9s4TCJFaV8S
 BRTQ==
X-Gm-Message-State: AOJu0Yx4MWTx5bVst5fnm9dEW1T3eGYcUBC64depX0Sr86+8ygcMTxpU
 xptslyeFRdOqadwxFAxBHafueqC7bKPXb/OrYkMSx49s2lwJYyXDZYLEakIA2aYkSmt/E5WG0vL
 LE5VK8os52ok0uANymhoy4txA9o0ftjPVtZL1c0PGa95yOcPq5B+HPi5aAN+TFRLBYfVLN2YRD+
 QGjJLJV8HOqo31JQNuv4SYaNZ3H/Sv/WY9+w==
X-Received: by 2002:a25:b125:0:b0:dfb:a69:5fdb with SMTP id
 3f1490d57ef6-dfe65e7f385mr1601036276.1.1718203356300; 
 Wed, 12 Jun 2024 07:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbE23xXFoaTC++Qr5ltR678XTsJh4jnpx9rYp7eUsxdlZq2JkL3dtljImwuEB/k8wumKoLXg==
X-Received: by 2002:a25:b125:0:b0:dfb:a69:5fdb with SMTP id
 3f1490d57ef6-dfe65e7f385mr1600992276.1.1718203355525; 
 Wed, 12 Jun 2024 07:42:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405e3ded65sm37581681cf.87.2024.06.12.07.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 3/4] migration: Use MigrationStatus instead of int
Date: Wed, 12 Jun 2024 10:42:27 -0400
Message-ID: <20240612144228.1179240-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240612144228.1179240-1-peterx@redhat.com>
References: <20240612144228.1179240-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
 migration/migration.c | 13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

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
index d41e00ed4c..bfbd657035 100644
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
@@ -1598,7 +1599,7 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_WAIT_UNPLUG:
         return false;
-    case MIGRATION_STATUS__MAX:
+    default:
         g_assert_not_reached();
     }
 
-- 
2.45.0


