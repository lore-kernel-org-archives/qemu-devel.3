Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA1EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUD8-0001QL-Vm; Thu, 31 Jul 2025 10:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHY-0008H4-06
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHT-0000KA-RF
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bS2TkfZk1qCRGz158i4XqD81xtrwOnWsQ7YYFT4INRg=;
 b=THD1RgNAeXWkidzT+YxPCEQHKKWIYw25lv5ZuDGgxbpiwUF/kzzXDF9c6riduSOtsnhDZA
 qiwWs2qQly0eRGNuTGcOu0PJ6GnNFISoOT+r0NmdQaO7Cm8R4pieoo/21z1N3EzCr0BpqZ
 9+grmTXIglLhWAJjLMdf2swrM/hMYYs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-TzvrQtNHPB2UFJJrxK0UTg-1; Thu, 31 Jul 2025 09:25:06 -0400
X-MC-Unique: TzvrQtNHPB2UFJJrxK0UTg-1
X-Mimecast-MFC-AGG-ID: TzvrQtNHPB2UFJJrxK0UTg_1753968306
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4226c60a38so1366014a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968305; x=1754573105;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bS2TkfZk1qCRGz158i4XqD81xtrwOnWsQ7YYFT4INRg=;
 b=FqZXquEHiW2vVKUFNbxef24WdCCD0dJMzcGUqJBANb2BIXt2jgMQwpB0fB48FFJZA7
 xHfdRdXtHirjuVazBFDQfiUXUJvqzHdZYQ4nqdScDp9KlQCWEYsTvcd8B6+tll0Wl1kW
 frU4b5V1V3Yo9Nr+HjlKhnDrPK49PRd54mdFb288a+uE2vZt/S31J+AsdWkw2OakvJmi
 rlmaa62cORsSWapq5p0xUiOJzjkKPv8nV2bo67ytVi0/sEpMqGw59TAq66Bsacb1AE70
 omuK8/A7Q85TntvsN0QoaEXeZHpW2YAfwP5zDJbbsLphYs5c9916BJ4U/RjyRH05Nzzw
 vRPg==
X-Gm-Message-State: AOJu0YyKIL8Cg7tVHUZw5psGODkLgvlimmmOSSmX/BnLz5H9rF+jpxfT
 mNnLrZOnatDDta83N8nLhQOhDJLiy0RQz61zS7p8ezTxTkjnQeyLXfzFmUv9qsulGCRb2HTS2vN
 6874BaISgKuBBwPWlv5k8hnWQJd0mlFvV+7mFufP0RnABcGoiDwi+dwF0ADlHkMJPezym+Fblzz
 6yIdIde36lnOYeYcyNCS8IJYcQj0tTqA+eRhMLBe8rFQ==
X-Gm-Gg: ASbGncvBq78pJupLkTyOC4srE3UAVpfy5WTfl/DLAZK4nNjwzH/tl96kGoiL1CsCAv/
 xWUnM5JIxo/3jjpumuenSuUhr6YKw8bSqueCW0uIihMjdFxuhUewHBE4poY/Z/0BsMPsa5MfMpQ
 xu3qkCYm4dzY3xDS6Z62vi1hWqW+7dQTeMp/UJHUS5NQwLZR2dw7RGXHsr/W19uPZVOGkLof2uq
 wl6BCLyikZ8PWzsGl4Lw1zsadyyqda2DLSji9t8mhoNSaPvqNZjZq6h+Noh49JLK7np4REt6v4D
 riILKK6cVSs3zQYIqrN9h7OIVKA1r5zPASZca1Aw2DUumAQffyFQ
X-Received: by 2002:a17:90b:4b82:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31f5de1f5bemr10164487a91.3.1753968305172; 
 Thu, 31 Jul 2025 06:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gyei7Qr9iwcdAgdmQAf6gSGZqSIC2/EzUVuLZ/nchblNQTdBjr4pItq4yl6IGaFo/aG4iA==
X-Received: by 2002:a17:90b:4b82:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31f5de1f5bemr10164406a91.3.1753968304618; 
 Thu, 31 Jul 2025 06:25:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:25:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:00 +0530
Subject: [PATCH v8 20/27] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-20-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5530; i=armenon@redhat.com;
 h=from:subject:message-id; bh=mH0njnF++VC8MNV1Xg4/TUb4R27KWMg3THHAAoR4I/w=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rPjpfZbFp/RNdt39FlAxbnFqYYsLVv3n7uW3e1mv
 kLadYVzRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIksnsLw30G8ea62pM9Ss7j0
 W4LJN2dONvjjsnuq2dkjWXNXFYruD2JkeP/nwsOH7zM1GIskGn9anAxk3sb0O3ath7bOnvM+7gZ
 LOAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  5 +++--
 migration/savevm.c    | 29 +++++++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d748a02712dc4ebc2de6b0488fb199c92c4d4079..0a5a8d5948b2b0a3f85163795e84f71903870d25 100644
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
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f5903995edd2b4c4f6c1a214c7126d831f10c9f1..2ac341ed627c4a8db7ba7676363d305c82ee3437 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3146,27 +3146,24 @@ out:
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
 
-    ret = qemu_loadvm_state_header(f, NULL);
+    ret = qemu_loadvm_state_header(f, errp);
     if (ret) {
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
-        error_report_err(local_err);
+    if (qemu_loadvm_state_setup(f, errp) != 0) {
         return -EINVAL;
     }
 
@@ -3176,7 +3173,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3194,8 +3191,14 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp,
+                       "Error while loading VM state: "
+                       "Migration stream has error");
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp, "Error while loading vmstate : %d", ret);
+            }
         }
     }
     /*
@@ -3460,6 +3463,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3481,10 +3485,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
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
@@ -3492,6 +3496,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
 bool load_snapshot(const char *name, const char *vmstate,
                    bool has_devices, strList *devices, Error **errp)
 {
+    ERRP_GUARD();
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
     QEMUFile *f;
@@ -3555,13 +3560,13 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        error_prepend(errp, "Error %d while loading VM state: ", ret);
         return false;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index fd7419e6ff90062970ed246b3ea71e6d49a6e372..a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);

-- 
2.50.0


