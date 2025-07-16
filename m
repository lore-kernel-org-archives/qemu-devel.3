Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F5FC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfQ-0002rf-Um; Wed, 16 Jul 2025 06:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeG-0000xG-Lo
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeE-0000mZ-Jy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vH481x7IL588bR5xEyAd6GIH6MgLnEAsXHK0PE6cgeQ=;
 b=VSq2t8fCAA5tUKcBEnafckL2aoBrK4a6nDywyGV4onSc2oSiD0UKq9PPRvLsnH4xITHNWd
 dbiJr7D5BmStMlkVOXz7EJq1cIFsNNsHjPJ+OD1kBjS1aMzkcqC7w7EysNKFfTBKkVScUr
 yTX3SOJTXf7I5wLoEmFVXgEet6vVj2k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-sroCXgGZP6WqBmAINqWN1Q-1; Wed, 16 Jul 2025 06:46:00 -0400
X-MC-Unique: sroCXgGZP6WqBmAINqWN1Q-1
X-Mimecast-MFC-AGG-ID: sroCXgGZP6WqBmAINqWN1Q_1752662760
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235f77f86f6so62325905ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662760; x=1753267560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vH481x7IL588bR5xEyAd6GIH6MgLnEAsXHK0PE6cgeQ=;
 b=t8cFOtPvDc52hynbbXHFzrE1RacGKKi+tjxQtS8CdzYFycQ+Mb0r9kohcnWa9Zy1mV
 LWXLGJ32j3CLmXWfqnqUmNaMzVTYgoJiiZb55LNialdxxyxlJ6CbgqJN8rxoQaSN6qXw
 Wh403aS6918QfPN1BEvQJsXgff9zcbLh1xdCJjrb1hqcoRFpmRGmkIchEj9XfIlkbcqH
 c5/QhyjE5MMXFJWNNfyzQG9ArDe24nf1dt9x54Ivc3dqTbecfRJ/G2KXT8HnV2/7irlH
 5R3lrsEMw07/zH0fIRYN4slfXsq7BEqwizNBb8reJrN0xy+JKimv+vp4/SBqXBiwbkSq
 gE5w==
X-Gm-Message-State: AOJu0Yw9i6A37yTfgUm1mGbmWVncEn02YExYvv7dTpTHVJtPkuHIP0R8
 /xaTosXseg93CM7mM9GXfcm3yakgpkigvrafSdXTS+NJfMDZ45iKhVrH1WjtD4putdNcA30Pj7K
 mk1lq2bev7rlxMb1ELBxDLYwirfQNli40LDcCoTqbqwVffIAuIVuRRcxg
X-Gm-Gg: ASbGncv/oAJqnBah75tzguzc9alTZ8oqdfnvpJK4PzniZ7eQxHO1ZOWTZ98w0kAYSyg
 462LfMN0XuOrg6FVruOB/SRYXvydmxZ/zYThI2G9D7xPSxP17fPkeSdbAQL0f5ZpUi0kkPKL19O
 BUdRYUauiaBGgh21OwobuwEUimqw+wrGBHeAj8gCp/v2kaOH940pG9u0PHnnRwEo2ZdZdNOhE5l
 d5kgKnvzFnYJ3m+lQhI++UQGHrk8NIQzsMIb2adhYikfgW+IpvHDN3jIuR8ijzair97qXR+/Jr6
 mUKDqYCJJrKWEPfGZvNgEI8F52l+xEpXB0K9GaVSaBvnXATn0Q==
X-Received: by 2002:a17:903:32d2:b0:234:909b:3dba with SMTP id
 d9443c01a7336-23e256c99b3mr34112215ad.20.1752662759568; 
 Wed, 16 Jul 2025 03:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6hOGOr7TPe1XP4o3FDl27nnVTjRH1Di9/GCSgYoe2zFQGlsLUTbdUU7UxcZrxCdj9N4p/g==
X-Received: by 2002:a17:903:32d2:b0:234:909b:3dba with SMTP id
 d9443c01a7336-23e256c99b3mr34111925ad.20.1752662759141; 
 Wed, 16 Jul 2025 03:45:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:58 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:09 +0530
Subject: [PATCH v4 19/23] migration: push Error **errp into qemu_loadvm_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-19-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861; i=armenon@redhat.com;
 h=from:subject:message-id; bh=E0hcIDwqDrluQVykoDSAcYJmDhjKVCPSIYDY/GpaxOI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k0Oqh1bKXKNg7ZdCvKXmFfu5J3yOiLmzLUn0o3B7W
 Ka1LFtHKQuDGBeDrJgiS8PXANmmgMKISNuX12HmsDKBDGHg4hSAicjOZfgr4ZktttfpW3lhjtw1
 ZtFcpW51O1mL1X89lsxoOxd+Pa6H4a+U+bXjjPzy8Vuc0+e7np+XEv3lmfs1fsbj8lFl7i+yDjM
 AAA==
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 migration/savevm.c    | 25 +++++++++++++------------
 migration/savevm.h    |  2 +-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 326487882c8d41e2f89f99f69df0d9d4d42705e4..1f0a8bd6ab28ff09bb76919564bdbfbde35c5e42 100644
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
+        error_prepend(&local_err, "load of migration failed: %s ",
+                      strerror(-ret));
         goto fail;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 9752fad6e1aa2d677b68cb6ae9180d1059d54019..7bdcf0f808fb07543fd62a679e359bcb18c4ad35 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3135,27 +3135,24 @@ out:
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
 
@@ -3165,7 +3162,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3183,8 +3180,12 @@ int qemu_loadvm_state(QEMUFile *f)
         if (migrate_has_error(migrate_get_current()) ||
             !qemu_loadvm_thread_pool_wait(s, mis)) {
             ret = -EINVAL;
+            error_setg(errp, "Error while loading vmstate : %d", ret);
         } else {
             ret = qemu_file_get_error(f);
+            if (ret < 0) {
+                error_setg(errp, "Error while loading vmstate : %d", ret);
+            }
         }
     }
     /*
@@ -3470,10 +3471,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+        error_prepend(errp, "loading Xen device state failed ");
     }
     migration_incoming_state_destroy();
 }
@@ -3544,13 +3545,13 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        error_prepend(errp, "Error %d while loading VM state ", ret);
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


