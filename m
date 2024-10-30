Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7E7D6B6A0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5L-0003pO-7T; Wed, 30 Oct 2024 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5H-0003o4-V5
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5F-0007q3-5R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4oURxNBXBkPRiq9WGmdIdu1uQxGl0jyPp2LNYV0ZBA=;
 b=MGFpXA/ppNqFK/Ak0BJXOCEB9BdfN7I4UrAkmNV7LpPwjiqgyNLrs0bAHODMpb3SYf/ivq
 Yt7MfQ4dMtj9Al95CFBDlaieVmhFlQ9bS+OdWuzxSrROmtnjs99vOkrm2LXka2AOCywloJ
 pd/SIU2uB9IGNal1mMyzYpFH5apeXNw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-z0MOC_x0PCuQ8WrnbrbbtQ-1; Wed, 30 Oct 2024 11:58:06 -0400
X-MC-Unique: z0MOC_x0PCuQ8WrnbrbbtQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbe4cb4252so63056d6.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303885; x=1730908685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4oURxNBXBkPRiq9WGmdIdu1uQxGl0jyPp2LNYV0ZBA=;
 b=Zpwd2+waQ4k4xwn2SgqC12jcOYrsEyfYgVsHUQkEls8htcJdZm4pLiPMqB4ngzu3NR
 L6VDjO7TWMCytXuzpayj7hJZWfUmZtw1edUh+JcStk1Qpsxr/1iqDvkBWU7EgdzhsBDK
 8J5MXAGHXa+LqG9GcG6T889V8p2KHMxrByw2xw847/HTYoNOFnT5N5oekISQLLZqVHMQ
 5van2Pjymoq9QJ2asIZsMWR13Wo3+Lremrsz+XmiGer2weEM3aM99mTMTuwizdEzP44D
 SPNTwl7m9FpjWt1x1SHKjbyNHtAtjQbu+TGlPGXo7mv5/fYzll729qZCIZeLqduB6r0c
 TSEQ==
X-Gm-Message-State: AOJu0YxVihVX/Bn1qLibe1mekBI2jsdLbGGpLHXgUXMpBraEybmh8rbV
 4GBBVtioXYtcINdH9YoEQ1RpxO3x5S+yg7nl4oMJMopu7ExmLYvKqz2xn0qKkOEjpYopcWTTEtC
 PyUqO3YzKHDESLsYyAg6AH+h6cBivoJlfxLtaqVQyhHFv0+Cc0NhduDhCVNHZjaRTxR2uDsyCk/
 2Bud92F5AyTfePVg1udciRsoL9ku42hnbzSw==
X-Received: by 2002:a05:6214:4305:b0:6cb:ff04:655f with SMTP id
 6a1803df08f44-6d1856eea23mr190399926d6.22.1730303884224; 
 Wed, 30 Oct 2024 08:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGDI1RbKNPifftg1STXFl8wa3OuriAQLyEGLq+Q7HiiTe19QARdxgOPAhrUgbnviWCNKwR2w==
X-Received: by 2002:a05:6214:4305:b0:6cb:ff04:655f with SMTP id
 6a1803df08f44-6d1856eea23mr190399036d6.22.1730303882365; 
 Wed, 30 Oct 2024 08:58:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:58:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/18] migration: Drop migration_is_setup_or_active()
Date: Wed, 30 Oct 2024 11:57:31 -0400
Message-ID: <20241030155734.2141398-16-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241024213056.1395400-5-peterx@redhat.com
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
index de80d64dda..cab65ba8db 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1113,33 +1113,6 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
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
@@ -1155,11 +1128,10 @@ bool migration_is_running(void)
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
 
@@ -1658,8 +1630,7 @@ bool migration_incoming_postcopy_advised(void)
 
 bool migration_in_bg_snapshot(void)
 {
-    return migrate_background_snapshot() &&
-           migration_is_setup_or_active();
+    return migrate_background_snapshot() && migration_is_running();
 }
 
 bool migration_is_idle(void)
@@ -2332,7 +2303,7 @@ static void *source_return_path_thread(void *opaque)
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


