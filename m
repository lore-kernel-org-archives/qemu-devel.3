Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916F2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq0v-0001qL-E1; Tue, 14 Jan 2025 18:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0t-0001q2-J5
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0r-00042y-NI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJR38tp/bNFIvxL2s+ykIG6k6iWIvuZ+RXhgC0s5ndE=;
 b=ZgJXQ5mLapWMe4ZmL7yltSBeZJoY7SUPTbfZm1+0FhTsWp8ymU+KIBKYjawrEujkQHropL
 259Cl51QY6HkpZhv0D0uRdeXw6UKqSGDloc5+1V4P4hJhKd9bKu39A+OtgYOpd7DiQoCpp
 n9OZ6fEDIB1RBYTz/bN+91r23GMiPkw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-G8Nm5LH-Nw22VLT2Wa6EPA-1; Tue, 14 Jan 2025 18:07:54 -0500
X-MC-Unique: G8Nm5LH-Nw22VLT2Wa6EPA-1
X-Mimecast-MFC-AGG-ID: G8Nm5LH-Nw22VLT2Wa6EPA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8844560e9so127907766d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896074; x=1737500874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJR38tp/bNFIvxL2s+ykIG6k6iWIvuZ+RXhgC0s5ndE=;
 b=sS9gQ357FjsAGxlB34T1D/tzMsXp2llXxiT+EnHHfEoTlPVg4FSxm8KYbiuWjVAiNc
 xh5oKaGOXLm/R3A/rTk3CvFp//5C3pvFNua7QEdAV9c4C/Q1bFPkgoCDGhIf3QRlHluB
 CUUQjLR789khEedmInInesyUQp1utArzJpGT08YnhtFF/Ei2xQ380hyG4FLO2iGMOS4j
 lpZv8lbM0Erj1xp5h+H8X0e0Ou24ep8g+ji4vSyvXGFxDoR/AztgudPUVhTWB0M1mHU+
 Q7JtlJ6X1VMvdqK2DK1L8k7mlVTq8ZAIGO5jbvQcp4Y+lhd0vxCDiI0XLm5KhFO214m1
 2wsg==
X-Gm-Message-State: AOJu0Yx3aPKvWAqq8dlmHSPvBvGHoOc7tJIkUsYM22UxOYTRLpFBQY2d
 qclDXUZWg2KjMC+0HKnua4SNesE/rcuzVT9igKd8PDkZFvm0ZdC0onn+ssO0Nqih0t8jRmmXUuA
 8ueGle/yprxPYzQa3t4Rg369Qf/WjfePBNmdPUNxrXG19DbGxfNJlQzlMWl2G+GP6B/T4r0UqUS
 rlscz30AlX0vaRs0/GAX4/87Sv+jXe3ray9Q==
X-Gm-Gg: ASbGncufJJCPetlEKj5vqDePLYgV+dhyH1gFORKTrUVO7P/0hK6y6dqaRuS16g1RV7L
 1gWNpUxt+kLUBGhS7eL7Q1HSwfcySfm74utKMemJPCAif7tjpvjk1WZ9TtF1etj8dDVXq5zx71U
 W808FcIJMV89N+4YRgCTz6GOoqdTbQIDHfiVWYar39ag/pmj8dkCtlPYc0EZIdH/np9lJD7wL57
 RYEbXEQt1QPk9SBTqD6Awb7fljrOODybM+nORg+Kc9b51TrU6NG2b1Anz3YGOHEQd0HGVYQqc1L
 xdcDMHfHtb7I60ILlvY+gn12H0bAF3q6
X-Received: by 2002:a05:6214:2428:b0:6d8:960e:5785 with SMTP id
 6a1803df08f44-6df9b234c28mr397065786d6.13.1736896073687; 
 Tue, 14 Jan 2025 15:07:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaVQ7cUOeZkDKamGe9n5EjP7CAWu9sKmnkY9zIoiZHSSm+3xLHZ2dJ0n69d4q+NC6zSyOAtg==
X-Received: by 2002:a05:6214:2428:b0:6d8:960e:5785 with SMTP id
 6a1803df08f44-6df9b234c28mr397065356d6.13.1736896073195; 
 Tue, 14 Jan 2025 15:07:53 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:52 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 02/16] migration: Do not construct JSON description if
 suppressed
Date: Tue, 14 Jan 2025 18:07:32 -0500
Message-ID: <20250114230746.3268797-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU machine has a property "suppress-vmdesc". When it is enabled, QEMU
will stop attaching JSON VM description at the end of the precopy migration
stream (postcopy is never affected because postcopy never attach that).

However even if it's suppressed by the user, the source QEMU will still
construct the JSON descriptions, which is a complete waste of CPU and
memory resources.

To avoid it, only create the JSON writer object if suppress-vmdesc is not
specified.

Luckily, vmstate_save() already supports vmdesc==NULL, so only a few spots
that are left to be prepared that vmdesc can be NULL now.

When at it, move the init / destroy of the JSON writer object to start /
end of the migration - the JSON writer object is a sub-struct of migration
state, and that looks like the only object that was dynamically allocated /
destroyed within migration process.  Make it the same as the rest objects
that migration uses.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  1 +
 migration/migration.c |  9 +++++---
 migration/savevm.c    | 49 +++++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 0df2a187af..3f1927f79c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -552,6 +552,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
+bool should_send_vmdesc(void);
 
 /* migration/block-active.c */
 void migration_block_active_setup(bool active);
diff --git a/migration/migration.c b/migration/migration.c
index 2d1da917c7..bad7b39293 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1406,8 +1406,8 @@ static void migrate_fd_cleanup(MigrationState *s)
 
     g_free(s->hostname);
     s->hostname = NULL;
-    json_writer_free(s->vmdesc);
-    s->vmdesc = NULL;
+
+    g_clear_pointer(&s->vmdesc, json_writer_free);
 
     qemu_savevm_state_cleanup();
 
@@ -1681,7 +1681,10 @@ int migrate_init(MigrationState *s, Error **errp)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
-    s->vmdesc = NULL;
+
+    if (should_send_vmdesc()) {
+        s->vmdesc = json_writer_new(false);
+    }
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 0c4df27177..fa03a0a264 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1231,8 +1231,7 @@ void qemu_savevm_non_migratable_list(strList **reasons)
 void qemu_savevm_state_header(QEMUFile *f)
 {
     MigrationState *s = migrate_get_current();
-
-    s->vmdesc = json_writer_new(false);
+    JSONWriter *vmdesc = s->vmdesc;
 
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
@@ -1241,16 +1240,21 @@ void qemu_savevm_state_header(QEMUFile *f)
     if (s->send_configuration) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
 
-        /*
-         * This starts the main json object and is paired with the
-         * json_writer_end_object in
-         * qemu_savevm_state_complete_precopy_non_iterable
-         */
-        json_writer_start_object(s->vmdesc, NULL);
+        if (vmdesc) {
+            /*
+             * This starts the main json object and is paired with the
+             * json_writer_end_object in
+             * qemu_savevm_state_complete_precopy_non_iterable
+             */
+            json_writer_start_object(vmdesc, NULL);
+            json_writer_start_object(vmdesc, "configuration");
+        }
+
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc);
 
-        json_writer_start_object(s->vmdesc, "configuration");
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, s->vmdesc);
-        json_writer_end_object(s->vmdesc);
+        if (vmdesc) {
+            json_writer_end_object(vmdesc);
+        }
     }
 }
 
@@ -1296,16 +1300,19 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 {
     ERRP_GUARD();
     MigrationState *ms = migrate_get_current();
+    JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
     int ret = 0;
 
-    json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
-    json_writer_start_array(ms->vmdesc, "devices");
+    if (vmdesc) {
+        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
+        json_writer_start_array(vmdesc, "devices");
+    }
 
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc, errp);
+            ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
                 migrate_set_error(ms, *errp);
                 qemu_file_set_error(f, ret);
@@ -1424,7 +1431,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
     return all_finished;
 }
 
-static bool should_send_vmdesc(void)
+bool should_send_vmdesc(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -1564,21 +1571,17 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
 
-        json_writer_end_array(vmdesc);
-        json_writer_end_object(vmdesc);
-        vmdesc_len = strlen(json_writer_get(vmdesc));
+        if (vmdesc) {
+            json_writer_end_array(vmdesc);
+            json_writer_end_object(vmdesc);
+            vmdesc_len = strlen(json_writer_get(vmdesc));
 
-        if (should_send_vmdesc()) {
             qemu_put_byte(f, QEMU_VM_VMDESCRIPTION);
             qemu_put_be32(f, vmdesc_len);
             qemu_put_buffer(f, (uint8_t *)json_writer_get(vmdesc), vmdesc_len);
         }
     }
 
-    /* Free it now to detect any inconsistencies. */
-    json_writer_free(vmdesc);
-    ms->vmdesc = NULL;
-
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
 
     return 0;
-- 
2.47.0


