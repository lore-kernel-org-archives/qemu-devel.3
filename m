Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F10D10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QL-0005fM-Cp; Thu, 24 Oct 2024 17:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QJ-0005ev-OS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QH-0005Z8-7O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6k9K1F4sWItx0KAORYMPzbNGOJ+dvY3NLwf36xd2l4=;
 b=YykItHm2JTlA62fZcwT4rSeS20FbAnVkwhA1vOxUAzu5s0ssM6SV9SNuTgZBKiL5t0d9TM
 Ca0fbJIhZFr48jOmCJS6H9gZx1W8bys32A/0JuI/JwYSPmPtrsXyrSys2dWCvf7VBEL5ou
 QZNdYW1tPhIPfP+0rtK7ASEYfIJKlTI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-lCTRQEExPbCnVSwUuNEi6w-1; Thu, 24 Oct 2024 17:31:10 -0400
X-MC-Unique: lCTRQEExPbCnVSwUuNEi6w-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7181ca4eca5so1553388a34.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805469; x=1730410269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6k9K1F4sWItx0KAORYMPzbNGOJ+dvY3NLwf36xd2l4=;
 b=p5pG+18ShGulXr5pWdxFwLdIF3cJX502hA/aYMMHq0PbFTOMozcUtwD9fgeVX+Y8Oc
 EdsGnkk9cNYkl32DeGc4R32NGYN65zRJTAnwF/0CvYDTESN++EvdeLlUVeT35X7jKuje
 LuElrANuIYyGQuFOdy6AUHFGrUy3cXBM55xM4QO3tuAUU1K/fcv/8wRERSzqf307GI+F
 yOFoYdjZVEwynLsTBheyhM1JQcczteZmIhmN2+DqmuU9ArRBTe8MpogiYicKROSR2pae
 yQR8vOI+wsNE2ryAU8gKGzUw2XBXQDnN/POoj1TSi7yNombmpDFiCM0hWeyNv6MGFxE5
 Djxw==
X-Gm-Message-State: AOJu0Yzv0s6N7NGei40HRQIjWXjxJnHTABdZc0OA0sAiJWydEL53Rwyg
 QGt7mRAIUEs1Oe4s9lD61svKpsUr9AWC/MphiEcnYEnHm02Rqt+L6CK75Sz1YNbVdMDgawXn2El
 U9OqDHHQcithz0MgWNrkERVoXarKhtwvKWmh+ks1UG+A35J+VghEwdmPrBCr2EzcWZLZW+B0EhT
 JVJlPZIfqTm1hpXLjzJ6VE40nyzpfMfCNe2A==
X-Received: by 2002:a05:6358:7211:b0:197:df0e:f23c with SMTP id
 e5c5f4694b2df-1c3e4d1fd0emr265778355d.11.1729805468913; 
 Thu, 24 Oct 2024 14:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNXyX+9BUC5E8HTotTZ7ubI6ph201MDCgEpTCL2YHdpRoHyl6p9kTRr3NCUYtR5o+uY242w==
X-Received: by 2002:a05:6358:7211:b0:197:df0e:f23c with SMTP id
 e5c5f4694b2df-1c3e4d1fd0emr265776055d.11.1729805468481; 
 Thu, 24 Oct 2024 14:31:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 5/8] migration: Drop migration_is_idle()
Date: Thu, 24 Oct 2024 17:30:53 -0400
Message-ID: <20241024213056.1395400-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

Now with the current migration_is_running(), it will report exactly the
opposite of what will be reported by migration_is_idle().

Drop migration_is_idle(), instead use "!migration_is_running()" which
should be identical on functionality.

In reality, most of the idle check is inverted, so it's even easier to
write with "migrate_is_running()" check.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 -
 hw/virtio/virtio-mem.c   |  2 +-
 migration/migration.c    | 21 +--------------------
 migration/ram.c          |  2 +-
 system/qdev-monitor.c    |  4 ++--
 5 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 86ef160f19..804eb23c06 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,7 +53,6 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);
 
-bool migration_is_idle(void);
 bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_is_running(void);
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ae1e81d7ba..80ada89551 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -188,7 +188,7 @@ static bool virtio_mem_is_busy(void)
      * after plugging them) until we're running on the destination (as we didn't
      * migrate these blocks when they were unplugged).
      */
-    return migration_in_incoming_postcopy() || !migration_is_idle();
+    return migration_in_incoming_postcopy() || migration_is_running();
 }
 
 typedef int (*virtio_mem_range_cb)(VirtIOMEM *vmem, void *arg,
diff --git a/migration/migration.c b/migration/migration.c
index 3365195def..f86c709699 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1636,25 +1636,6 @@ bool migration_in_bg_snapshot(void)
     return migrate_background_snapshot() && migration_is_running();
 }
 
-bool migration_is_idle(void)
-{
-    MigrationState *s = current_migration;
-
-    if (!s) {
-        return true;
-    }
-
-    switch (s->state) {
-    case MIGRATION_STATUS_NONE:
-    case MIGRATION_STATUS_CANCELLED:
-    case MIGRATION_STATUS_COMPLETED:
-    case MIGRATION_STATUS_FAILED:
-        return true;
-    default:
-        return false;
-    }
-}
-
 bool migration_is_active(void)
 {
     MigrationState *s = current_migration;
@@ -1733,7 +1714,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     ERRP_GUARD();
 
     /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
-    if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
+    if (runstate_check(RUN_STATE_SAVE_VM) || migration_is_running()) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(migration/snapshot in progress) for: ");
diff --git a/migration/ram.c b/migration/ram.c
index 5646a0b882..504b48d584 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4498,7 +4498,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
         return;
     }
 
-    if (!migration_is_idle()) {
+    if (migration_is_running()) {
         /*
          * Precopy code on the source cannot deal with the size of RAM blocks
          * changing at random points in time - especially after sending the
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1310f35c9f..83fa684475 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -686,7 +686,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (!migration_is_idle()) {
+    if (migration_is_running()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
     }
@@ -935,7 +935,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
+    if (migration_is_running() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
     }
-- 
2.45.0


