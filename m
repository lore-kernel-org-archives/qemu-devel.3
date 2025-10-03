Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED7DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huH-0004xd-Uk; Fri, 03 Oct 2025 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htW-0004l5-LI
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htD-0007a6-Je
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDQehBFjS9hzbRN2c7a1rsRVsYnUY8qV/XKDyPPXFYY=;
 b=aPtIrMgqHKVnAl2ZxVr9t286ZuPetguRJGzK3ptJUnUTXK5odBENTJLNNBMkB26NlzHwCj
 a+VoLSuv34HL9f0+0lDiXZ7+G2P93YzxsZ3nSREszl+BdlC3HSzf16YNu7gNP6o6YjC97p
 zk7lNPS9kussjt+jq/f0WJqqTAYer1Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-pYiRClfqMy2aspQ5mIC70Q-1; Fri, 03 Oct 2025 11:40:04 -0400
X-MC-Unique: pYiRClfqMy2aspQ5mIC70Q-1
X-Mimecast-MFC-AGG-ID: pYiRClfqMy2aspQ5mIC70Q_1759506003
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79390b83c48so49169326d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506003; x=1760110803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDQehBFjS9hzbRN2c7a1rsRVsYnUY8qV/XKDyPPXFYY=;
 b=nOoUCMPGk6Z6KHklLcZysE8/cM8sXPL0AF5xcpTB42bNcWZvMSFGJzId5a6fxZD4zM
 ng5LjP+4shtanoULpvUEEgUScu1yytV6qZ+MaI/4qLfaQQXj7xx3GQhH338MQGmWRfCi
 6poEFFpVh168O2XGsFqkn0pcCUoflKdzOJBjHlOAGG5eOJ7YcCum4vou5A4OInrQxTvI
 Y1RA0TdtpIuVMD6mCVoWs79N/xjkeOZgeOpMISuvUCKgXcj6YfTX2PDie1wjVPpnemJR
 x6icGy+pB+hpnzHDbprjnRTdmMe5dEx98PRgiy8nCpvNNuZL8+j4g64Ksf8dfDDjKSqa
 Zd4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgq61pnWUdVhMk+oVwQQ9thBMuQ0Hii5pCyF5rHsvX6Bv1Snb+7+Dh8G6IWcXhLUTx45CIDRsKNAc9@nongnu.org
X-Gm-Message-State: AOJu0YyhnoZuWOZA9t4PD4QqzGsQFOyw1Fr+bsKPTsAR0gUEAueFjbU/
 f6ARpnHpx9HnLSqKX4CiErKzucFcri+8i1u3e4F1ZwKNaBB8b07ZSOlAMykhEkojgLaLfSpVzOi
 1g659Ug1mBWeifhnPVP3ltDfgNRaXYuszzYE7/n2o3lxgm7guwyH32z1Vv2kmErsd
X-Gm-Gg: ASbGncvIiKktGJC3FXVM/rjC1JDsWnai1Gej6FCDD3NCBf/z0XdtXz6qWwqX6DlK1Bm
 oZetu47tolZkJF8GDux11B4P4wnKlw0zueZXETy2rX2tdd8dh+/R9te/Q8GUtjlLmBG4jOHH0IY
 nBreS77xdhwRi6U+EWOvCVY0weYyDYZkaccXz7QSvUwVzl7fw5Z9BMHgA9X+Z1Z7OWuMGDZS3b/
 zReQijXZ6BS/T0wngtWqFIj//rjashccfuSXfWq2WSbWE/PJaS2RCQOrieZdQJunfWplOn6tZim
 rPgNNXHaM/uui8+MVwJ8CYOK9Vdpf7wAozz+NA==
X-Received: by 2002:a05:6214:ac2:b0:803:3b8e:e9a6 with SMTP id
 6a1803df08f44-879dc79b830mr47719986d6.16.1759506003042; 
 Fri, 03 Oct 2025 08:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcSs7LG3RBGt7hBuzmht1D8eDTZw48dTLpMOTbT1ROprFvXoRBBtD4c5TaXe9U1Kb2ny2BWQ==
X-Received: by 2002:a05:6214:ac2:b0:803:3b8e:e9a6 with SMTP id
 6a1803df08f44-879dc79b830mr47719396d6.16.1759506002459; 
 Fri, 03 Oct 2025 08:40:02 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/45] migration: push Error **errp into qemu_loadvm_state()
Date: Fri,  3 Oct 2025 11:39:10 -0400
Message-ID: <20251003153948.1304776-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Arun Menon <armenon@redhat.com>

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
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-7-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c | 14 ++++++++++++--
 migration/savevm.c    | 30 ++++++++++++++++++------------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c7166..b80770b746 100644
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
diff --git a/migration/migration.c b/migration/migration.c
index e1ac4d73c2..cba2a39355 100644
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
index 5e54651652..88116ed278 100644
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
 
-- 
2.50.1


