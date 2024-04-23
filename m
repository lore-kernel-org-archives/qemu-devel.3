Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AC4C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnI-0002JF-31; Tue, 23 Apr 2024 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0001UC-TP
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmd-00068d-Ha
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgdtuHf4Rc/P9PvYya3rWC+4QxG4xDu0pc9j8q4eNhE=;
 b=F5dotFs38hpPajutH5XdrNR8fjzbBBRng+H6wbFhdlSuT39KV7AGH6ArPdfSgCWvTYKStY
 j6IuvCBZQ7QzyHRkGgIAj1luibcs9hfP+ssv+XcaSO0LkKy2K6sDO8htpuPKbAx8FIxHzL
 lBLG3RFLPCQSt4jY99qMLyVP5LjLioE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nLXaB_zbOQOeVIRguSm8Iw-1; Tue, 23 Apr 2024 18:38:37 -0400
X-MC-Unique: nLXaB_zbOQOeVIRguSm8Iw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a07f0d60edso9948626d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911916; x=1714516716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgdtuHf4Rc/P9PvYya3rWC+4QxG4xDu0pc9j8q4eNhE=;
 b=ODpjpaN+ATk1MBYGVVF/eSaeWnIr1LaVNBuePUMnxo1Qd/DmYIuhJn8sVqip+/WaLd
 7zv0YyjB7wiDFNEBothzSMF/mSQ9LSQOUyPraMm/ilLjiPs07T11xb4pxluR7CL+HgFf
 pn2py/wRxLQXfwfTUq5iO0uDYFS3VkjCArXReVJ8A9fBm8ylCZed897ZS5bNzXFTO7sJ
 E7KdISStj2oMhdrCbNKndB/hrGHxKqwluLKCGsVuVe4dIa+SEA4syjXMgy+vggljS25u
 WjyG6Nb50r5cZ+QTWr4DFaC3gqQG8b1bjgDwmAPoPKHV326+7jPmu4GcgCtIZoF+E7gR
 LPVQ==
X-Gm-Message-State: AOJu0YwSZ6ddLd71RTh9QpOTD3AgPQxQIsVfMF5AgucDCDIq9EQU6ShP
 NccWxG+poXuJ4VjR7hwInJMSjH1MpUl1OOOUobZc5HjnEOn6rcA5RBZmVlqRfaEqGdVus6srUmJ
 o6cwZsXWKlaXMJupiL2tCjc9M1t1Gj4zAKX5tOq/hxD+Eaoxnwx0PxkBPt2L3OYJEOs7PBpbLeL
 04LJFXT89aUvpts9xH9puWhltxAlXFqdaz5w==
X-Received: by 2002:a05:620a:170b:b0:790:8672:9f33 with SMTP id
 az11-20020a05620a170b00b0079086729f33mr946258qkb.1.1713911916439; 
 Tue, 23 Apr 2024 15:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQp31++nKsr3Kx1BDn6Sai3Dxv9mOeZdLbqeN69uj7eruePHO4A7C5jUxuAbVlYN7rIlEuNQ==
X-Received: by 2002:a05:620a:170b:b0:790:8672:9f33 with SMTP id
 az11-20020a05620a170b00b0079086729f33mr946220qkb.1.1713911915782; 
 Tue, 23 Apr 2024 15:38:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/26] migration: Add Error** argument to .save_setup() handler
Date: Tue, 23 Apr 2024 18:38:03 -0400
Message-ID: <20240423223813.3237060-17-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

The purpose is to record a potential error in the migration stream if
qemu_savevm_state_setup() fails. Most of the current .save_setup()
handlers can be modified to use the Error argument instead of managing
their own and calling locally error_report().

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-8-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h   |  3 ++-
 hw/ppc/spapr.c                 |  2 +-
 hw/s390x/s390-stattrib.c       |  6 ++----
 hw/vfio/migration.c            | 17 ++++++++---------
 migration/block-dirty-bitmap.c |  4 +++-
 migration/block.c              | 13 ++++---------
 migration/ram.c                | 15 ++++++++-------
 migration/savevm.c             |  4 +---
 8 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index d7b70a8be6..64fc7c1103 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -60,10 +60,11 @@ typedef struct SaveVMHandlers {
      *
      * @f: QEMUFile where to send the data
      * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*save_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
      * @save_cleanup
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9bc97fee0..823164e81c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2172,7 +2172,7 @@ static const VMStateDescription vmstate_spapr = {
     }
 };
 
-static int htab_save_setup(QEMUFile *f, void *opaque)
+static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     SpaprMachineState *spapr = opaque;
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index b743e8a2fe..bc04187b2b 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -168,19 +168,17 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static int cmma_save_setup(QEMUFile *f, void *opaque)
+static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
-    Error *local_err = NULL;
     int res;
     /*
      * Signal that we want to start a migration, thus needing PGSTE dirty
      * tracking.
      */
-    res = sac->set_migrationmode(sas, true, &local_err);
+    res = sac->set_migrationmode(sas, true, errp);
     if (res) {
-        error_report_err(local_err);
         return res;
     }
     qemu_put_be64(f, STATTR_FLAG_EOS);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index bf5a29ddc1..5763c0b683 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -376,7 +376,7 @@ static int vfio_save_prepare(void *opaque, Error **errp)
     return 0;
 }
 
-static int vfio_save_setup(QEMUFile *f, void *opaque)
+static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
@@ -390,8 +390,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
                                       stop_copy_size);
     migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
     if (!migration->data_buffer) {
-        error_report("%s: Failed to allocate migration data buffer",
-                     vbasedev->name);
+        error_setg(errp, "%s: Failed to allocate migration data buffer",
+                   vbasedev->name);
         return -ENOMEM;
     }
 
@@ -401,8 +401,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
                                            VFIO_DEVICE_STATE_RUNNING);
             if (ret) {
-                error_report("%s: Failed to set new PRE_COPY state",
-                             vbasedev->name);
+                error_setg(errp, "%s: Failed to set new PRE_COPY state",
+                           vbasedev->name);
                 return ret;
             }
 
@@ -413,8 +413,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             /* vfio_save_complete_precopy() will go to STOP_COPY */
             break;
         default:
-            error_report("%s: Invalid device state %d", vbasedev->name,
-                         migration->device_state);
+            error_setg(errp, "%s: Invalid device state %d", vbasedev->name,
+                       migration->device_state);
             return -EINVAL;
         }
     }
@@ -425,8 +425,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
-        error_report("%s: save setup failed : %s", vbasedev->name,
-                     strerror(-ret));
+        error_setg_errno(errp, -ret, "%s: save setup failed", vbasedev->name);
     }
 
     return ret;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 2708abf3d7..542a8c297b 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1213,12 +1213,14 @@ fail:
     return ret;
 }
 
-static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
+static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
 
     if (init_dirty_bitmap_migration(s) < 0) {
+        error_setg(errp,
+                   "Failed to initialize dirty tracking bitmap for blocks");
         return -1;
     }
 
diff --git a/migration/block.c b/migration/block.c
index f8a11beb37..bae6e94891 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -711,10 +711,9 @@ static void block_migration_cleanup(void *opaque)
     blk_mig_unlock();
 }
 
-static int block_save_setup(QEMUFile *f, void *opaque)
+static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     int ret;
-    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -722,25 +721,21 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     warn_report("block migration is deprecated;"
                 " use blockdev-mirror with NBD instead");
 
-    ret = init_blk_migration(f, &local_err);
+    ret = init_blk_migration(f, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
     if (ret) {
-        error_setg_errno(&local_err, -ret,
-                         "Failed to start block dirty tracking");
-        error_report_err(local_err);
+        error_setg_errno(errp, -ret, "Failed to start block dirty tracking");
         return ret;
     }
 
     ret = flush_blks(f);
     if (ret) {
-        error_setg_errno(&local_err, -ret, "Flushing block failed");
-        error_report_err(local_err);
+        error_setg_errno(errp, -ret, "Flushing block failed");
         return ret;
     }
     blk_mig_reset_dirty_cursor();
diff --git a/migration/ram.c b/migration/ram.c
index 44d7073730..6ea5a06e00 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3066,22 +3066,23 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
  *
  * @f: QEMUFile where to send the data
  * @opaque: RAMState pointer
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-static int ram_save_setup(QEMUFile *f, void *opaque)
+static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
     int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
-        error_report("%s: failed to start compress threads", __func__);
+        error_setg(errp, "%s: failed to start compress threads", __func__);
         return -1;
     }
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
-            error_report("%s: failed to setup RAM for migration", __func__);
+            error_setg(errp, "%s: failed to setup RAM for migration", __func__);
             compress_threads_save_cleanup();
             return -1;
         }
@@ -3118,14 +3119,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
-        error_report("%s: failed to start RDMA registration", __func__);
+        error_setg(errp, "%s: failed to start RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
-        error_report("%s: failed to stop RDMA registration", __func__);
+        error_setg(errp, "%s: failed to stop RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
@@ -3142,7 +3143,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
-        error_report("%s: multifd synchronization failed", __func__);
+        error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
@@ -3154,7 +3155,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret < 0) {
-        error_report("%s failed : %s", __func__, strerror(-ret));
+        error_setg_errno(errp, -ret, "%s failed", __func__);
     }
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 327e9b346e..a2679ba0b8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1342,11 +1342,9 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
-            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
-                       "%d(%s): %d", se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
             break;
         }
-- 
2.44.0


