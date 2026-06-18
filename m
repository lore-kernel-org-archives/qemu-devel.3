Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A752CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3Jk-0008B6-2X; Wed, 17 Jun 2026 23:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Ji-0008Aj-FJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:22 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3Jg-0002JN-ON
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:21:22 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c88a4d79ba5so318725a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752879; x=1782357679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HktabLtwsgOICpypiuiSex0ShyKn6VFTpFu0belFXIM=;
 b=VPPbGQtVlksLWH/Q7e/KFuIQkckt7I+Rwfpq3aqFVZ27usOzIuEOLgMD4gpQ6uit7q
 XTTk3TQ22TJJlZnGM/wstXuwDu+Ao0tdw96kIyDXkd1jpF8fubpWjeUefOqocHkMchoX
 PHeU+cQp0iee8hAJ117eMsD8TmvTOfJcBYPkBSkIfjHf6d8/c+ZuA4R+DLz1UFx7OPPN
 lcFPxxqwTggA76SVsj9cGuWiwqe5b1I+it07fKo0UE0hraZ0123tqdDPn6wjVutdg736
 49SMU1GEreVDxiUprRMt3taz19MfohXUGgQDI2qG7Lw1t395wb9fw8zvrZEnxjPYfDL+
 N/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752879; x=1782357679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HktabLtwsgOICpypiuiSex0ShyKn6VFTpFu0belFXIM=;
 b=iLc9OPUxjmbbisRhKuhfe1CiOvsHaYuWxI9NaqDgH3YSV1PPaiXvVcJ/F7AgUqRexK
 the2cadq2O+zrXSWjSqifbxLMYw/hbgMSHVuvCI4+i33/1mAzUsGNqjFHASZepwcormj
 ZrT6gxuYbNY7BQ98SRYMz5mdSIRCJwuWCHXGauoRdo536PBn8iF10rsm8Sk7oOs0rDY4
 LYdJxE2sVQ+6OzezSx9lpRL3pOJ2H7TYY3+PlYAYW9l7NsNv38Ipzc7BJZdoB5meOpLh
 Ug3OOV1bhLBSPeYVlx7tQRBLHCd5/Ql34d7SOc6S1lqwocmJ08EetI2FNGiLO+QUdcQs
 MYAg==
X-Gm-Message-State: AOJu0YyXW4YTJR1fLb1PSrWecqom4p3IhQ8fyeHp7rETcl/nLpixi5zc
 r93X2VBhwZ871XTTHvqlvZe4jMYh2Eb6pRKfv5Ty6v1Pb/ORN9eL63FWFzz2YJfP
X-Gm-Gg: Acq92OFz1LWusCcqR/5QwHOxbuZ66N/1w3fUGnmML1j1JFZHUYRG7G08ErjsdvQSCyf
 huaKY5XKZPr+Km8Hx+b8UyN29mDTsgcIvMpsflf8xK1SBnw+2t8utZfrFp0lsyFyyDBIZvUiXce
 3SR6JzdIC/N5j//Hc9wh0E16rgdGH463mWsBsejgagyF8Cs+QoLkjpQKVL/ent5sr859YQucikC
 kZQWOIghio0KPANPAxCMidVGDTsuvfEsU85V80i4v0qnm3jv8Kh9ZAZ27v+V+K/aswvdPef5qkV
 Bp3cM0P8FQlTjLCR182AQrEhdJ+XtnDoQIoj7vEZ2SvmGGUhN4BTI3xV3czbMPttSsLfaNzfv2x
 VA/9Kg+fRlNJ+9IDxJBu2hvpIb6o8s7GYJDrp93Ti+L+Ooz451rpBmPwvW1p48DRAOLLX7f4fIs
 0uDHsBxhWUIr+Dcqd0OHkoMB9rzcS48dcHtvz3UFZrbfr/MKYf4CeM
X-Received: by 2002:a05:6a20:3d10:b0:39f:a42:9247 with SMTP id
 adf61e73a8af0-3b8bf4e2a25mr7680476637.37.1781752879441; 
 Wed, 17 Jun 2026 20:21:19 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:21:19 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 4/5] migration: write up code to run fast snapshot load in
 qemu_loadvm_state
Date: Thu, 18 Jun 2026 08:50:09 +0530
Message-ID: <20260618032010.88755-5-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618032010.88755-1-aadeshveer07@gmail.com>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When both mapped-ram and postcopy-ram are set, divert from
qemu_loadvm_state to run fast snapshot load

Initialize postcopy RAM state and register RAM Blocks with userfaultfd
via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup().
Launch fault thread before VM to serve faults for some hardwares
emulation that need to read RAM (like vapic devices). Populate bitmaps
and offset tables while reading file in qemu_loadvm_state_main. Call to
qemu_loadvm_state_postcopy() which starts the VM using
loadvm_postcopy_handle_run_bh() and launches eager load thread.

Skip scheduling process_incoming_migration_bh() in
process_incoming_migration_co(), for fast snapshot load as the state
cleanup is managed by eager load thread on completion.

Skip setting migration status to ACTIVE in process_incoming_migration_co
and set set it to POSTCOPY_DEVICE in qemu_loadvm_state() itself.

Remove the capability check that rejected mapped-ram and postcopy-ram
being set simultaneously, as this combination now corresponds to fast
snapshot load. The corresponding test will be updated in following
patch.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c | 10 ++++++---
 migration/options.c   |  6 -----
 migration/savevm.c    | 52 +++++++++++++++++++++++++++++++++++++++++--
 migration/savevm.h    |  2 ++
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..e1ac310e20 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -756,8 +756,10 @@ process_incoming_migration_co(void *opaque)
 
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
-    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_ACTIVE);
+    if (!migrate_fast_snapshot_load()) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_ACTIVE);
+    }
 
     mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file, &local_err);
@@ -786,7 +788,9 @@ process_incoming_migration_co(void *opaque)
         colo_incoming_co();
     }
 
-    migration_bh_schedule(process_incoming_migration_bh, mis);
+    if (!migrate_fast_snapshot_load()) {
+        migration_bh_schedule(process_incoming_migration_bh, mis);
+    }
     goto out;
 
 fail:
diff --git a/migration/options.c b/migration/options.c
index 5f80dd5b42..3f447cf7b2 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -732,12 +732,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                        "Mapped-ram migration is incompatible with xbzrle");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
-            error_setg(errp,
-                       "Mapped-ram migration is incompatible with postcopy");
-            return false;
-        }
     }
 
     /*
diff --git a/migration/savevm.c b/migration/savevm.c
index 23adaf9dd9..f10cc3c2fc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2959,6 +2959,32 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
+/*
+ * Starts the VM and launches the eager thread for fast snapshot load
+ */
+int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
+                               Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+
+    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+
+    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
+    ret = postcopy_ram_eager_load_setup(mis);
+    if (ret) {
+        error_prepend(errp,
+                      "Failed to setup eager load for fast snapshot load: ");
+        return ret;
+    }
+
+    return ret;
+}
+
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp)
 {
@@ -3067,8 +3093,30 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis, errp);
-    qemu_event_set(&mis->main_thread_load_event);
+    if (migrate_fast_snapshot_load()) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_POSTCOPY_DEVICE);
+
+        if (ram_postcopy_incoming_init(mis, errp)) {
+            return -EINVAL;
+        }
+
+        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
+        if (postcopy_ram_incoming_setup(mis)) {
+            return -EINVAL;
+        }
+
+        ret = qemu_loadvm_state_main(f, mis, errp);
+
+        qemu_event_set(&mis->main_thread_load_event);
+
+        if (ret == 0) {
+            ret = qemu_loadvm_state_postcopy(f, mis, errp);
+        }
+    } else {
+        ret = qemu_loadvm_state_main(f, mis, errp);
+        qemu_event_set(&mis->main_thread_load_event);
+    }
 
     trace_qemu_loadvm_state_post_main(ret);
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 96fdf96d4e..9656acd7fe 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
 int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
+int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
+                               Error **errp);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
-- 
2.54.0


