Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0BD10388
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QK-0005fC-UT; Thu, 24 Oct 2024 17:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QH-0005eC-F7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QE-0005Yn-2w
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3olLJmt75jk+FJwxKOAC+XSuUICRdqFmF+p2v48vhJw=;
 b=SCpGLYdXndl5HlztTUyUbQy1cdcSz7SS1N+15C6o/UOTw/GnamUCoAsV+RLQHBuE7YynrI
 epmMmym9OBDNfdykG3lwxrsFT29gQJpCpg1fRXJirK8SvpfnAENUwSs2AF/K1pyVOmj9iy
 cL6EK3w+OwNh8pbSfymbms22t2C3aZo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-DohlQ0LmOmKiiaBxkhuYYw-1; Thu, 24 Oct 2024 17:31:08 -0400
X-MC-Unique: DohlQ0LmOmKiiaBxkhuYYw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-460b638b668so20330341cf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805467; x=1730410267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3olLJmt75jk+FJwxKOAC+XSuUICRdqFmF+p2v48vhJw=;
 b=Bup7Rtu7fkFzWaHUHJ9PyA2aFX1H3oAWDh5wkX5evOI1sPz5+Bi/sQceGYTQgGCR5U
 y6JmHWfPThS/y3pM9luwBB9pny4lxSYCL5Rora3LkGCr6BW2ILAAKAps2OxgX9L/TU+4
 FLhp4nMV1gqf0y5ycCf0LCY+VCIEJJ1RYcDo+l2F47yjuNrgieNPfNLSJ1lr0xQXLutn
 ptUcQP81BYlkHImMOVVvmqHW8kkggnaFONZV8JTJOEO15rQCdpgbWIU8FT6ou7sanSJz
 4TrhP8P2PI02sOFcBJuN7G1EX57xyacos/mft4PfCbC1S3BXm0cbgqG87El9j0gNS8yS
 qEIA==
X-Gm-Message-State: AOJu0YyJacr1vMhd7r0+e8UpPj+adF2dCTVr6pyDdZ9i/sjN19wkrvJ/
 kuefvTnLKJOguuUaNEZ0d01rstraGepTAfJDW5T0vbXq+pgni+9WDMSEbeAUEsXoKGwRenmtIPt
 5+g9KbvOGvcdbzHfxw7fZNohxb+lbjvZI3RapTzgTIYhPazbtZuMYlJ2G+CZYVO3l7DOROtXCO7
 sTAVplX/THRymhXJH6aSfC6Rm2I0RuPnBzQw==
X-Received: by 2002:a05:622a:1109:b0:461:1474:2059 with SMTP id
 d75a77b69052e-461258e3428mr42551471cf.13.1729805466804; 
 Thu, 24 Oct 2024 14:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4IdpNMXK7juRo68WjGvXa/gEzd365qeeAJM4Omi4FyNvz10hSvFKOb2LsgeFi0qVUeGcmQ==
X-Received: by 2002:a05:622a:1109:b0:461:1474:2059 with SMTP id
 d75a77b69052e-461258e3428mr42551191cf.13.1729805466487; 
 Thu, 24 Oct 2024 14:31:06 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 4/8] migration: Drop migration_is_setup_or_active()
Date: Thu, 24 Oct 2024 17:30:52 -0400
Message-ID: <20241024213056.1395400-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This helper is mostly the same as migration_is_running(), except that one
has COLO reported as true, the other has CANCELLING reported as true.

Per my past years experience on the state changes, none of them should
matter.

To make it slightly safer, report both COLO || CANCELLING to be true in
migration_is_running(), then drop the other one.  We kept the 1st only
because the name is simpler, and clear enough.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  4 ++--
 hw/vfio/common.c         |  2 +-
 migration/migration.c    | 35 +++--------------------------------
 migration/ram.c          |  5 ++---
 net/vhost-vdpa.c         |  3 +--
 5 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e8490e3af5..86ef160f19 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -52,11 +52,12 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 /* migration/migration.c */
 void migration_object_init(void);
 void migration_shutdown(void);
+
 bool migration_is_idle(void);
 bool migration_is_active(void);
 bool migration_is_device(void);
+bool migration_is_running(void);
 bool migration_thread_is_self(void);
-bool migration_is_setup_or_active(void);
 
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
@@ -95,7 +96,6 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
-bool migration_is_running(void);
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 36d0cf6585..dcef44fe55 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -149,7 +149,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
 
 static void vfio_set_migration_error(int ret)
 {
-    if (migration_is_setup_or_active()) {
+    if (migration_is_running()) {
         migration_file_set_error(ret, NULL);
     }
 }
diff --git a/migration/migration.c b/migration/migration.c
index e82ffa8cf3..3365195def 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1116,33 +1116,6 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
     migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
 }
 
-/*
- * Return true if we're already in the middle of a migration
- * (i.e. any of the active or setup states)
- */
-bool migration_is_setup_or_active(void)
-{
-    MigrationState *s = current_migration;
-
-    switch (s->state) {
-    case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_PAUSED:
-    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
-    case MIGRATION_STATUS_POSTCOPY_RECOVER:
-    case MIGRATION_STATUS_SETUP:
-    case MIGRATION_STATUS_PRE_SWITCHOVER:
-    case MIGRATION_STATUS_DEVICE:
-    case MIGRATION_STATUS_WAIT_UNPLUG:
-    case MIGRATION_STATUS_COLO:
-        return true;
-
-    default:
-        return false;
-
-    }
-}
-
 bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
@@ -1158,11 +1131,10 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_WAIT_UNPLUG:
     case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_COLO:
         return true;
-
     default:
         return false;
-
     }
 }
 
@@ -1661,8 +1633,7 @@ bool migration_incoming_postcopy_advised(void)
 
 bool migration_in_bg_snapshot(void)
 {
-    return migrate_background_snapshot() &&
-           migration_is_setup_or_active();
+    return migrate_background_snapshot() && migration_is_running();
 }
 
 bool migration_is_idle(void)
@@ -2335,7 +2306,7 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-    while (migration_is_setup_or_active()) {
+    while (migration_is_running()) {
         trace_source_return_path_thread_loop_top();
 
         header_type = qemu_get_be16(rp);
diff --git a/migration/ram.c b/migration/ram.c
index d284f63854..5646a0b882 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2860,7 +2860,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
     size_t used_len, start, npages;
 
     /* This function is currently expected to be used during live migration */
-    if (!migration_is_setup_or_active()) {
+    if (!migration_is_running()) {
         return;
     }
 
@@ -3208,8 +3208,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     }
 
 out:
-    if (ret >= 0
-        && migration_is_setup_or_active()) {
+    if (ret >= 0 && migration_is_running()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
             ret = multifd_ram_flush_and_sync();
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 46b02c50be..231b45246c 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -375,8 +375,7 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    if (s->always_svq ||
-        migration_is_setup_or_active()) {
+    if (s->always_svq || migration_is_running()) {
         v->shadow_vqs_enabled = true;
     } else {
         v->shadow_vqs_enabled = false;
-- 
2.45.0


