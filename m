Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95720C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq11-0001t4-O0; Tue, 14 Jan 2025 18:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0z-0001rd-G7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0x-00043a-Gh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puz3fqWAe4p+E3jR68kieXjasW6yV218uFcwIMo6OkE=;
 b=eQ2wJ/9MrQddeV6gxPr+Atlj8ykMEtrawifWrUZE2kwseTh5j1S8Fw99Yo4cSgQ26aMSwa
 s6vPdhHF4JtyANubS3plmM6AHOX3mh6jSaz5LPd6rE6b/SFQwNDLGQ7zAfSArhzf6wTPW1
 ERofEiQa/G3Tj2TsFj2Ve1Oxim39rEw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-J2m4sK_mM0eqk_Vsx_8sWw-1; Tue, 14 Jan 2025 18:07:59 -0500
X-MC-Unique: J2m4sK_mM0eqk_Vsx_8sWw-1
X-Mimecast-MFC-AGG-ID: J2m4sK_mM0eqk_Vsx_8sWw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-467944446a0so92870271cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896078; x=1737500878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puz3fqWAe4p+E3jR68kieXjasW6yV218uFcwIMo6OkE=;
 b=pLQzxHDmEVGaF6SZVwe4jsnJVmaMZOlE7kUHBQv7uSx76SCwOp85Jl7nqNiafIaTpo
 haUVOMMXAfU1Kn2urwHwqfk40hnWImpYcA7nji1m+9YT2a+SNzip8maWAzexJPaQaq+t
 MiS/dFmgcPJtLxSSQMxHZIfsqniK8bPbnmOGDX46JlrHcXJbLOE/LfOexUE+Muo3UK/c
 uzpkRu3ZVjNiByTgsY/0NcGbOVu/DvP2HwZ/gDhuli67qiKLtT73KgBjpz0zQlMbICFR
 PPea5uObeWDEA1fZKoveuPg2qJl4HuHjs/UchOuvxVoPoEior/xiQSpMCv9HC5sv88df
 U4kQ==
X-Gm-Message-State: AOJu0YzbFJnYIQelGVHcNcp/ga/nRhCBlZSBxNGl+5wqoS6WJDY2k5cW
 FljsDN/1unMnwjTeB/MvwXx/kceVXpjBiyIeNeUYe6OjoCMyswjhEJCp+F610p5Qebrd3di/Z0O
 qouoYmnZxPm0TEDuBJDiqiVt5y9mazF1wpPEorEiTLsP73iZcsuFd11uKidh+7rL5yEk+IautjD
 HTeFFodzEwnukscGrxUO7ISRz5lPHmAlcOww==
X-Gm-Gg: ASbGncu8SnEPh2aNgocInFShhSy9RLjGcDKouiDMcTggFu778weqH2J9FEOLfWnMsYn
 yn/VRs8336z6ZAomrK2jKOgTm0IwvRDkqoTYWarWliHM8Xl3I4yaIvGz8of8lxLsrpNxAPgiFT3
 Fcj3T8+4Kz630WF8J3EA/5jfT9p1mIzU3QqWBm2CBTqeg0BB/VoEGhnYPwDJR+GZhFBnJe9HRFN
 itD/IiS0LhQj4v87qWR3xfLwBEizWmpHJTGYEL6V+f7/v/zMwMu2QYUmWl2fS86CXzx68kuEB5N
 Y6+VJSRoQdTnTBOsOxIyJ9Fn/NRcakRp
X-Received: by 2002:a05:622a:1996:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-46c7107a481mr493237521cf.43.1736896078530; 
 Tue, 14 Jan 2025 15:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOwXKNfSOlRCWj63VkMLObuQvi3Q1tq3vDHbie9CN+gMnTFWWVeEm4PpO6yurFvUKHIX4VKA==
X-Received: by 2002:a05:622a:1996:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-46c7107a481mr493237081cf.43.1736896078088; 
 Tue, 14 Jan 2025 15:07:58 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 05/16] migration: Drop inactivate_disk param in
 qemu_savevm_state_complete*
Date: Tue, 14 Jan 2025 18:07:35 -0500
Message-ID: <20250114230746.3268797-6-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This parameter is only used by one caller, which is the genuine precopy
complete path (migration_completion_precopy).

The parameter was introduced in a1fbe750fd ("migration: Fix race of image
locking between src and dst") to make sure the inactivate will happen
before EOF to make sure dest will always be able to activate the disk
properly.  However there's no limitation on how early we inactivate the
disk.  For precopy completion path, we can always do that as long as VM is
stopped.

Move the disk inactivate there, then we can remove this inactivate_disk
parameter in the whole call stack, because all the rest users pass in false
always.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  5 ++---
 migration/migration.c | 22 ++++++++++++++++------
 migration/savevm.c    | 27 +++++----------------------
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a995c..c48a53e95e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -39,8 +39,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks);
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
@@ -68,6 +67,6 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-        bool in_postcopy, bool inactivate_disks);
+        bool in_postcopy);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index e1fc1a7fdc..b33baab950 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2555,7 +2555,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
      */
-    qemu_savevm_state_complete_precopy(ms->to_dst_file, true, false);
+    qemu_savevm_state_complete_precopy(ms->to_dst_file, true);
 
     /*
      * in Finish migrate and with the io-lock held everything should
@@ -2600,7 +2600,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    qemu_savevm_state_complete_precopy(fb, false, false);
+    qemu_savevm_state_complete_precopy(fb, false);
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
@@ -2732,11 +2732,21 @@ static int migration_completion_precopy(MigrationState *s,
         goto out_unlock;
     }
 
+    /* Inactivate disks except in COLO */
+    if (!migrate_colo()) {
+        /*
+         * Inactivate before sending QEMU_VM_EOF so that the
+         * bdrv_activate_all() on the other end won't fail.
+         */
+        if (!migration_block_inactivate()) {
+            ret = -EFAULT;
+            goto out_unlock;
+        }
+    }
+
     migration_rate_set(RATE_LIMIT_DISABLED);
 
-    /* Inactivate disks except in COLO */
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                             !migrate_colo());
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
     return ret;
@@ -3617,7 +3627,7 @@ static void *bg_migration_thread(void *opaque)
      * save their state to channel-buffer along with devices.
      */
     cpu_synchronize_all_states();
-    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
+    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
         goto fail;
     }
     /*
diff --git a/migration/savevm.c b/migration/savevm.c
index fa03a0a264..5e56a5d9fc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1521,8 +1521,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 }
 
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-                                                    bool in_postcopy,
-                                                    bool inactivate_disks)
+                                                    bool in_postcopy)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
@@ -1553,20 +1552,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                     end_ts_each - start_ts_each);
     }
 
-    if (inactivate_disks) {
-        /*
-         * Inactivate before sending QEMU_VM_EOF so that the
-         * bdrv_activate_all() on the other end won't fail.
-         */
-        if (!migration_block_inactivate()) {
-            error_setg(&local_err, "%s: bdrv_inactivate_all() failed",
-                       __func__);
-            migrate_set_error(ms, local_err);
-            error_report_err(local_err);
-            qemu_file_set_error(f, -EFAULT);
-            return ret;
-        }
-    }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
@@ -1587,8 +1572,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
     Error *local_err = NULL;
@@ -1613,8 +1597,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
         goto flush;
     }
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy,
-                                                          inactivate_disks);
+    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy);
     if (ret) {
         return ret;
     }
@@ -1717,7 +1700,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f, false, false);
+        qemu_savevm_state_complete_precopy(f, false);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
@@ -1743,7 +1726,7 @@ cleanup:
 void qemu_savevm_live_state(QEMUFile *f)
 {
     /* save QEMU_VM_SECTION_END section */
-    qemu_savevm_state_complete_precopy(f, true, false);
+    qemu_savevm_state_complete_precopy(f, true);
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
-- 
2.47.0


