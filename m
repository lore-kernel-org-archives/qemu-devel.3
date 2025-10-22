Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC04CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTv-0002vT-3K; Wed, 22 Oct 2025 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTj-0002tV-EP
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTg-0001YG-Cm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LeWIh/aS3jgszbhRw8H9hH7gHBVXRI8hO1i9Z5a4Upo=;
 b=iBk4wRc+ONOAQmbPICVaRxVW+DhlE5UHL79HXdZbQJ2Gw3mNpAUKlqXbSHPpCaZGa+Svez
 edbNIdP2eyAX/L4jEfQ2CWaz/3obHpJR3GHibHVtifxU7doeY10K03dsEtMIp37/B/dTfH
 fNNeaqCY+b1WoMziuc+S7UkAZ9pNoDk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-6Md2XWVLPbuqse2QXdCmpw-1; Wed, 22 Oct 2025 15:26:28 -0400
X-MC-Unique: 6Md2XWVLPbuqse2QXdCmpw-1
X-Mimecast-MFC-AGG-ID: 6Md2XWVLPbuqse2QXdCmpw_1761161188
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e894937010so46490211cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161187; x=1761765987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeWIh/aS3jgszbhRw8H9hH7gHBVXRI8hO1i9Z5a4Upo=;
 b=o83AOsy/FVpU8746awozVf/J2D8YNiodufLSdmecYRhAd4T4gNIh9byI6kbctmcSLQ
 fxAH6CE/22IVQ4QZn5ExAtKmlnHKeAq/nmmJO3VhE/uYK9Tk0UMfGgVOmmnsnbjHNp7R
 1xpxOVL1UDGHaVCSTiAzVa+j9Xs8mdgYwsZ+PBaaIpuViHNJMTK3hyG/2uvt21cFUBGG
 NMKGwNBOpaMU0JD+RM6XtDJUq67Wl+ALY37D/8s4nbgfSYgNV5a6dIV4UIqh+hyIX5wA
 BErSuzf4jTkuMHzKFGQfCaBMEgclvE9EElR65gbJsggd0QnXOhGGMwIR4Nh64MouG36u
 0rZQ==
X-Gm-Message-State: AOJu0YwaqtrVcxIQLY0SdWLTnYFjXF+Zh8SynjAYlKiu3opIo5jiYqD0
 R8urhd6f7fWF5Kjp+F0xhRpxBQNXBxjGV7EAc6T5SWyYq1DE6exsJfIky3FI8CxSkglgG33x2GG
 OyZnfSRFXc3+y3/HJtG7+6jmC9qFjT3UrAXASE6B0W7t0WQns9KlN5ZA4u40vlbte8DGWR7XYH8
 Oi6wdG0bNt1XENeGAnR8ZxmmAb/tgdEXE1MlJt5g==
X-Gm-Gg: ASbGnctFlzqVVVuS6F+UkTb185j4lly91qnLrLGoyQIyrtNWhDtrcvR73j0AHQv0bO6
 4Hk1DVeElov67Olhv3uCuwynUVtoN0qByiQJ1M3msnuCumEwqb/SDySGzH4312fGEKD/hZ6eCVv
 FUHU8v0LFHLTcr4bbo+OIZMKzC8sgV0pUnpePRvnOlIjeMbqAlkvy4yRWPTDwbub4vIrIdH74MU
 lFxG646wrQqhB9aeFwOLJzfyBGbKliWjaoKoFiNK0C+stQFt9Dop9p1pt3qXcy7VIZizRqZj6Na
 cSgKvTP2222Sya7eMFKMRKzdZsfXbxDTuC8oEtcgma/7c7WW8veMU1wq2jDDopLm
X-Received: by 2002:ac8:5993:0:b0:4e8:a6ca:8cc4 with SMTP id
 d75a77b69052e-4e8a6ca8ea4mr227194081cf.36.1761161187474; 
 Wed, 22 Oct 2025 12:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwTDHEAZMLO1MTiXCwf6Xt4CUbqzsrdFcrClDRzBgnR4sZ1//qgW9IpLzR+9Mk37q6lAIs1Q==
X-Received: by 2002:ac8:5993:0:b0:4e8:a6ca:8cc4 with SMTP id
 d75a77b69052e-4e8a6ca8ea4mr227193571cf.36.1761161186896; 
 Wed, 22 Oct 2025 12:26:26 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 07/13] migration: Pass in bql_held information from
 qemu_loadvm_state()
Date: Wed, 22 Oct 2025 15:26:06 -0400
Message-ID: <20251022192612.2737648-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Teach qemu_loadvm_state() and some of the internal functions to know
whether we're holding BQL or not.

So far, all the callers still always pass in TRUE, hence no functional
change expected.  But it may change in the near future.

To reviewers: even if this is not functional change yet, it'll be the major
core functional change after we switch to threadified loadvm soon.  Please
Treat it as one to add explicit code to mark out which part of incoming
live migration would need to be executed always with the BQL, or would need
to be run always without BQL.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  4 +--
 migration/colo.c      |  2 +-
 migration/migration.c |  2 +-
 migration/savevm.c    | 72 ++++++++++++++++++++++++++++++-------------
 4 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index c337e3e3d1..a04dee4166 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,10 +64,10 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f, Error **errp);
+int qemu_loadvm_state(QEMUFile *f, bool bql_held, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
-                           Error **errp);
+                           bool bql_held, Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa7..4fd586951a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,7 +686,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, true, errp);
     bql_unlock();
 
     if (ret < 0) {
diff --git a/migration/migration.c b/migration/migration.c
index 4ed2a2e881..38a584afae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -878,7 +878,7 @@ process_incoming_migration_co(void *opaque)
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
+    ret = qemu_loadvm_state(mis->from_src_file, true, &local_err);
     mis->loadvm_co = NULL;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
diff --git a/migration/savevm.c b/migration/savevm.c
index 232cae090b..44aadc2f51 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -154,11 +154,12 @@ static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
 }
 
 static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
-                                         MigrationIncomingState *mis)
+                                         MigrationIncomingState *mis,
+                                         bool bql_held)
 {
-    bql_unlock(); /* Let load threads do work requiring BQL */
-    thread_pool_wait(mis->load_threads);
-    bql_lock();
+    WITH_BQL_RELEASED(bql_held) {
+        thread_pool_wait(mis->load_threads);
+    }
 
     return !migrate_has_error(s);
 }
@@ -2117,7 +2118,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &local_err);
+    load_res = qemu_loadvm_state_main(f, mis, true, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2420,7 +2421,8 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
+                                      bool bql_held, Error **errp)
 {
     int ret;
     size_t length;
@@ -2471,7 +2473,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis, errp);
+    ret = qemu_loadvm_state_main(packf, mis, bql_held, errp);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2571,7 +2573,7 @@ static int loadvm_postcopy_handle_switchover_start(Error **errp)
  * LOADVM_QUIT All good, but exit the loop
  * <0          Error
  */
-static int loadvm_process_command(QEMUFile *f, Error **errp)
+static int loadvm_process_command(QEMUFile *f, bool bql_held, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     uint16_t cmd;
@@ -2641,7 +2643,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        return loadvm_handle_cmd_packaged(mis, errp);
+        /* PACKAGED may have bql dependency internally */
+        return loadvm_handle_cmd_packaged(mis, bql_held, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         return loadvm_postcopy_handle_advise(mis, len, errp);
@@ -2666,7 +2669,11 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        return loadvm_postcopy_handle_switchover_start(errp);
+        WITH_BQL_HELD(bql_held) {
+            /* TODO: drop the BQL dependency */
+            ret = loadvm_postcopy_handle_switchover_start(errp);
+        }
+        return ret;
     }
 
     return 0;
@@ -2882,6 +2889,10 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
             return -EINVAL;
         }
 
+        /*
+         * NOTE: this can be invoked with/without BQL.  It's safe because
+         * vmstate_configuration (and its hooks) doesn't rely on BQL status.
+         */
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
                                  errp);
         if (ret) {
@@ -3072,7 +3083,7 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 }
 
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
-                           Error **errp)
+                           bool bql_held, Error **errp)
 {
     ERRP_GUARD();
     uint8_t section_type;
@@ -3094,20 +3105,33 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type, errp);
+            /*
+             * FULL should normally require BQL, e.g. during post_load()
+             * there can be memory region updates.  START may or may not
+             * require it, but just to keep it simple to always hold BQL
+             * for now.
+             */
+            WITH_BQL_HELD(bql_held) {
+                ret = qemu_loadvm_section_start_full(f, section_type, errp);
+            }
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
+            /* PART / END may be loaded without BQL */
             ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, errp);
+            /*
+             * Be careful; QEMU_VM_COMMAND can embed FULL sections, so it
+             * may internally need BQL.
+             */
+            ret = loadvm_process_command(f, bql_held, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3152,7 +3176,7 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f, Error **errp)
+int qemu_loadvm_state(QEMUFile *f, bool bql_held, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -3177,9 +3201,12 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
         qemu_loadvm_state_switchover_ack_needed(mis);
     }
 
-    cpu_synchronize_all_pre_loadvm();
+    /* run_on_cpu() requires BQL */
+    WITH_BQL_HELD(bql_held) {
+        cpu_synchronize_all_pre_loadvm();
+    }
 
-    ret = qemu_loadvm_state_main(f, mis, errp);
+    ret = qemu_loadvm_state_main(f, mis, bql_held, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3195,7 +3222,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     /* When reaching here, it must be precopy */
     if (ret == 0) {
         if (migrate_has_error(migrate_get_current()) ||
-            !qemu_loadvm_thread_pool_wait(s, mis)) {
+            !qemu_loadvm_thread_pool_wait(s, mis, bql_held)) {
             ret = -EINVAL;
             error_setg(errp,
                        "Error while loading vmstate");
@@ -3249,7 +3276,10 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
         }
     }
 
-    cpu_synchronize_all_post_init();
+    /* run_on_cpu() requires BQL */
+    WITH_BQL_HELD(bql_held) {
+        cpu_synchronize_all_post_init();
+    }
 
     return ret;
 }
@@ -3260,7 +3290,7 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis, errp);
+    ret = qemu_loadvm_state_main(f, mis, true, errp);
     if (ret < 0) {
         return ret;
     }
@@ -3495,7 +3525,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f, errp);
+    ret = qemu_loadvm_state(f, true, errp);
     qemu_fclose(f);
     if (ret < 0) {
         error_prepend(errp, "loading Xen device state failed: ");
@@ -3573,7 +3603,7 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f, errp);
+    ret = qemu_loadvm_state(f, true, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
-- 
2.50.1


