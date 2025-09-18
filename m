Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F45CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGVE-00042G-9t; Thu, 18 Sep 2025 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVA-0003vK-9G
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGV8-0002jr-3I
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nZZiGu+K47IEF65X0NaWF9ITwNWS/RFb4YkerOV6gk=;
 b=NEZAgHugmZOitleeg/V+Bvgn5Yw9T0hMtFGxYJYUgkdxD/M1bXy38F6/Ha/kJ4wLLIWtzt
 vb1uLM144B1zMgxBTq0PmTPeSW7Z+43rjMi6R2aKgWRNGS8VCyhFDBrQ5HGwIKQ2G3qcUh
 lE2xN2GcfZPTGh6p2nbHzXegQ5ixP8U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-gh1yR-QyO0GDVfRkCwHQcw-1; Thu, 18 Sep 2025 11:24:48 -0400
X-MC-Unique: gh1yR-QyO0GDVfRkCwHQcw-1
X-Mimecast-MFC-AGG-ID: gh1yR-QyO0GDVfRkCwHQcw_1758209087
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-77241858ec1so1164403b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209087; x=1758813887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nZZiGu+K47IEF65X0NaWF9ITwNWS/RFb4YkerOV6gk=;
 b=S+ibYidOHoZ75DRUBGL9Jd2ue2yQKy8DIPjTk+f6wG9Y6OjVkX3zhz27ZUy8+vVnJM
 ZUU3PsWMq1WpOM1afqyAadtk26wtoiwD2Wfc1SPtsUzJLCpu5Aos8+oYyIX1IlkTova3
 gu2Ec/xe3R56y1J7ItVWLSHkHvIjLFZLkowq4wPjbMYgowpChlJUZU9n7vrwGwN1IR3/
 gektArZZ+bISlTf9xPvvI49zlSZwo15/8ikH7l5FZdXlLmjnCl9mNmbqHVQ9HERCh5bv
 NQzyQhfb9fWAfCM6pFNAH6sg2+ntSTdN7InkvO6IFieANirXCXlEuXQWA4fTwXmin4Uh
 PGpA==
X-Gm-Message-State: AOJu0YztqomnE8avya4bvsSK0hyCXMPcYzoqPIHZ4MmLY0yGCvJY7luk
 +jjfn5zuOXQa1U8b9vu1eD3TO08itiByoZL5TqBS84D0W6SxrCeDXcXSj8dhSwgBnQHL6yqTF8x
 RKevDyvvWglNsqpiruz90LepefluzXMUNDF+QYTgOGZmhFdmyUjAZqeWl
X-Gm-Gg: ASbGncuhwtvsU/DoFOxkY0CR6LOxzSU8/Hbw2Ye54Jht/XlQ+IhR6ikEsJcMp+nhtch
 V7reHOGBYVd4cH1VrUUwRgmoxmEZUp768iITtrS8Bs7I99Hn/2g6qH60T/JBDBrheW6SP2KmIVp
 ZQ6Pt4TGfjac06NeSLnhdToo6JcqgT+UdebrlcWYhBU513B4jffeS7cT/C0H8Vm1HZHCZnqZ+7x
 LI6fuWrbG+g2W1MkIXbCW/ZZLsJidVb9VxYCBbMtrKJXTF4xoZdzneneHBpYHKDosAKwRZ5Uu66
 UKmJta7Vvo1qX/nxhkYZX7jC7tkSTsb5UGOe5XW7pBWZUS9HEgsfNg==
X-Received: by 2002:a05:6a00:1992:b0:77d:13e3:ccfa with SMTP id
 d2e1a72fcca58-77d13e3ecdcmr4288499b3a.4.1758209086913; 
 Thu, 18 Sep 2025 08:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDEtBDV5GWMugTnv1URRn1BiyYUovAg3YH4X1KUhW5RH8Tqoso5H7nEGfbh/kQsHMtMUgpOA==
X-Received: by 2002:a05:6a00:1992:b0:77d:13e3:ccfa with SMTP id
 d2e1a72fcca58-77d13e3ecdcmr4288448b3a.4.1758209086417; 
 Thu, 18 Sep 2025 08:24:46 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:45 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:24 +0530
Subject: [PATCH v14 07/27] migration: push Error **errp into
 qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-7-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6219; i=armenon@redhat.com;
 h=from:subject:message-id; bh=IIT+8nokWMp/vohnpdDSOWEYBogGfJ2e1LS670VvRDE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e8rH4j+3TtdeO4GHa/m5alnPk6oOjLD3u9Q3ly1G
 3M8dUzzO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAEwkYwvDP827duf2i9pN5F5l
 Gsgqu6Xtl/bC2NKlHb9PlKb1TdO/Hsnwv0gu40X7oco3CyansIbnpq8t2PdW3/HiTlMDrm9ZEc6
 LmQE=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_state() must report an error
in errp, in case of failure.

When postcopy live migration runs, the device states are loaded by
both the qemu coroutine process_incoming_migration_co() and the
postcopy_ram_listen_thread(). Therefore, it is important that the
coroutine also reports the error in case of failure, with
error_report_err(). Otherwise, the source qemu will not display
any errors before going into the postcopy pause state.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c | 14 ++++++++++++--
 migration/savevm.c    | 30 ++++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..fcf76cf73595c93e7616ee7341f2e02a598e4e3b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-    ret = qemu_loadvm_state(mis->from_src_file);
+    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
@@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
+        error_prepend(&local_err, "load of migration failed: %s: ",
+                      strerror(-ret));
         goto fail;
     }
 
@@ -935,6 +936,15 @@ fail:
         }
 
         exit(EXIT_FAILURE);
+    } else {
+        /*
+         * Report the error here in case that QEMU abruptly exits
+         * when postcopy is enabled.
+         */
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
     }
 out:
     /* Pairs with the refcount taken in qmp_migrate_incoming() */
diff --git a/migration/savevm.c b/migration/savevm.c
index de5671ffd1cd06e728227a3056c3f895d3a6e6f3..0087fca15ce108685667d3808350d80d37b807b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3159,28 +3159,24 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f)
+int qemu_loadvm_state(QEMUFile *f, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
     int ret;
 
-    if (qemu_savevm_state_blocked(&local_err)) {
-        error_report_err(local_err);
+    if (qemu_savevm_state_blocked(errp)) {
         return -EINVAL;
     }
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f, &local_err);
+    ret = qemu_loadvm_state_header(f, errp);
     if (ret) {
-        error_report_err(local_err);
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
-        error_report_err(local_err);
+    if (qemu_loadvm_state_setup(f, errp) != 0) {
         return -EINVAL;
     }
 
@@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
+    if (ret < 0) {
+        error_setg(errp, "Load VM state failed: %d", ret);
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3208,8 +3207,15 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp,
+                       "Error while loading vmstate");
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Error while loading vmstate: stream error: %d",
+                           ret);
+            }
         }
     }
     /*
@@ -3474,6 +3480,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3495,10 +3502,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+        error_prepend(errp, "loading Xen device state failed: ");
     }
     migration_incoming_state_destroy();
 }
@@ -3569,13 +3576,12 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
         return false;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);

-- 
2.51.0


