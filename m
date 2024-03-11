Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8700FC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngr-0000qD-49; Mon, 11 Mar 2024 18:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngc-0000YM-EU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnga-00042y-Jn
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNUhmEzp/58FEG6jAG2/JC7N9wqLD5mTyKauBdCXsmU=;
 b=JRi1Rn3/4vSSYTgrKaVhsd574CH2Ef6Dt3dLr+Rm1uBLgZnlvk6XcY2NMKKs17hxzYzI7B
 KHAsgpAYLYjNlKqv2T8vN5KWcP4dOnBcs9qCPXpXygW2s8nwJHU3KV1a4vMB2gmrgSbU7G
 w7g8h8BNeySFjUi85cpmAoIUPUbc8WQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-oKMTK-22NVS68bXqeu5tYw-1; Mon, 11 Mar 2024 17:59:54 -0400
X-MC-Unique: oKMTK-22NVS68bXqeu5tYw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ca03e758so5295856d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194393; x=1710799193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNUhmEzp/58FEG6jAG2/JC7N9wqLD5mTyKauBdCXsmU=;
 b=os5cZ16qt/aVqg+zorN8NLwPQxKXmC0gN1S4yVvx7S7ijNdHxV5Y9lrifZL5jAGIxH
 mJEi7JQqS8ULNWnPz7c9zMorIkTmNMA3BuZiNwdqYuI+BM5illBRpgtVdUXZByL6RSPl
 xKSOHc1HyHI2PT0sGQoHS3sujG+Y6cMGWn6aQtk8ZXgT0m9UXziZ41W/Co33CWJ40ZuR
 E1rssyzYN3OGDJWMUVUihHukPokeUiUQ+rK1GbGibAPw+pnr9yjVZy9G48oEVwWuMPJ6
 Mv6DkUp6mHyZq4Mb6tqBbptY8XPr66eRqXepXt7r/xsr0VfMy2ZPg9zxSWKlPubxgx0z
 WXNg==
X-Gm-Message-State: AOJu0Yy++xPxe/5ynyhvbTbF5Gu2ywStd1duvFjK3gynLE1V/GMgOnQm
 a4UQfFKPbbGIVHQTGVxs/tZqXGRJguAOs0sNkBbas5ju97qYcuqxsJIyLkCKJA8dRv0J4L6wOin
 QeJ03aV64nld3k2WS2/wRzmhQ0gfqFcoTy/dLEp8aWn/uS5Msw6bIAnlF4teS5xdtOm+OsUfEAM
 WYXB1oHcfr6STu2TAy9w45I1AZSssLwB2ecA==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id
 dc3-20020a056214174300b00690027a00e6mr121558qvb.5.1710194393475; 
 Mon, 11 Mar 2024 14:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtGL2Cn4/57l0PYp+7R/5Wfss794xgkYagX6VxOzxB+7gOfsH4BLXmjjWYJLoushhekcEHuw==
X-Received: by 2002:a05:6214:1743:b0:690:27a:e6 with SMTP id
 dc3-20020a056214174300b00690027a00e6mr121523qvb.5.1710194392817; 
 Mon, 11 Mar 2024 14:59:52 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:52 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/34] migration: export migration_is_setup_or_active
Date: Mon, 11 Mar 2024 17:59:09 -0400
Message-ID: <20240311215925.40618-19-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Delete the MigrationState parameter from migration_is_setup_or_active
and move it to the public API in misc.h.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/1710179338-294359-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/migration.h    |  1 -
 hw/vfio/common.c         |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  5 ++---
 net/vhost-vdpa.c         |  3 +--
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4c226a40bb..79cff6224e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -61,6 +61,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+bool migration_is_setup_or_active(void);
 bool migrate_mode_is_cpr(MigrationState *);
 
 typedef enum MigrationEventType {
diff --git a/migration/migration.h b/migration/migration.h
index 65c0b61cbd..736460aa8b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -479,7 +479,6 @@ bool migrate_has_error(MigrationState *s);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
-bool migration_is_setup_or_active(int state);
 bool migration_is_running(int state);
 
 int migrate_init(MigrationState *s, Error **errp);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a..896eab8103 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -152,7 +152,7 @@ static void vfio_set_migration_error(int err)
 {
     MigrationState *ms = migrate_get_current();
 
-    if (migration_is_setup_or_active(ms->state)) {
+    if (migration_is_setup_or_active()) {
         WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
             if (ms->to_dst_file) {
                 qemu_file_set_error(ms->to_dst_file, err);
diff --git a/migration/migration.c b/migration/migration.c
index a49fcd53ee..af21403bad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1081,9 +1081,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
  */
-bool migration_is_setup_or_active(int state)
+bool migration_is_setup_or_active(void)
 {
-    switch (state) {
+    MigrationState *s = current_migration;
+
+    switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
@@ -1601,10 +1603,8 @@ bool migration_incoming_postcopy_advised(void)
 
 bool migration_in_bg_snapshot(void)
 {
-    MigrationState *s = migrate_get_current();
-
     return migrate_background_snapshot() &&
-            migration_is_setup_or_active(s->state);
+           migration_is_setup_or_active();
 }
 
 bool migration_is_idle(void)
@@ -2297,7 +2297,7 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-    while (migration_is_setup_or_active(ms->state)) {
+    while (migration_is_setup_or_active()) {
         trace_source_return_path_thread_loop_top();
 
         header_type = qemu_get_be16(rp);
diff --git a/migration/ram.c b/migration/ram.c
index 2cd936d9ce..3ee8cb47d3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2909,10 +2909,9 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
     RAMBlock *block;
     ram_addr_t offset;
     size_t used_len, start, npages;
-    MigrationState *s = migrate_get_current();
 
     /* This function is currently expected to be used during live migration */
-    if (!migration_is_setup_or_active(s->state)) {
+    if (!migration_is_setup_or_active()) {
         return;
     }
 
@@ -3263,7 +3262,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
 out:
     if (ret >= 0
-        && migration_is_setup_or_active(migrate_get_current()->state)) {
+        && migration_is_setup_or_active()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
             ret = multifd_send_sync_main();
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6bdb4562d..8564817073 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -26,7 +26,6 @@
 #include <err.h>
 #include "standard-headers/linux/virtio_net.h"
 #include "monitor/monitor.h"
-#include "migration/migration.h"
 #include "migration/misc.h"
 #include "hw/virtio/vhost.h"
 
@@ -355,7 +354,7 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->always_svq ||
-        migration_is_setup_or_active(migrate_get_current()->state)) {
+        migration_is_setup_or_active()) {
         v->shadow_vqs_enabled = true;
     } else {
         v->shadow_vqs_enabled = false;
-- 
2.44.0


