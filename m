Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1894C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1d-00025W-8n; Tue, 14 Jan 2025 18:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1H-00021L-3h
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1E-0004CV-6v
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmFaOzluSBJlmHuYFILUjrWqsbv31ND4/DIPaTdh/4M=;
 b=fhvUjuXysOqT/PmJMXZt9vCzzRQdUl2BCvRnq1gl37HgXOaki6s0yC93ld8sxk3/ax7BZl
 q7Vshbta4Wgaxee37DPGA6KAwTkVVtrz9LjI0ZQyodbgtlnM2/vuPv87LLUpLAgxpYafxQ
 HnNpt3rijZyMxKpxxnA3+WtuQ+xKlqE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-f-ZSmMGgPFCpt4W8JCPcIw-1; Tue, 14 Jan 2025 18:08:16 -0500
X-MC-Unique: f-ZSmMGgPFCpt4W8JCPcIw-1
X-Mimecast-MFC-AGG-ID: f-ZSmMGgPFCpt4W8JCPcIw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4678b42cbfeso122244421cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896094; x=1737500894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmFaOzluSBJlmHuYFILUjrWqsbv31ND4/DIPaTdh/4M=;
 b=jO7lh63sBDgooOD5LA4E5xLuwqX4erzuOk40FkvGH+iJ32HbpuA2q311OMAWoRLGes
 jHHzyjmzZ0hwWgSkrcVxQOiK3iaEGId9zvZUwHvLzse7MM+oOyFdHZ8hI/ePionQjZli
 o4jHwCRDlv0mfEs845qFnlfnmAAeVIZwNN5tfUIuh1/SybO+zNbe2iZ1mjeZoO5LCayp
 IovmA6Khlf3bIDMQE7VycXRQPEOfEWPzXfpFxF21k33D2WMIRAj0+ulo8Jm66hjVNeDh
 IVxcs4/XK30mvmJ6xVwd560wwulPhkwnh9Y4rJxdmKX8As9QwehIKChHakKsSre4t48k
 tD7A==
X-Gm-Message-State: AOJu0YytRIWvVRamWGWskucwbzSFXAOY8CSJDUFijczxv6U+A/sMYaRD
 sor0JLyT4TElYbd1+BuUzgfLJDBgeVxxxnRMhn7QLWyLaAcfQBG8EMbhl0DTJQ2/1Gb3+rJvowD
 u6KDCJorRLWVBWrsJZA5A2ssiYjb6sdLkxf8N11fFyEEpxdDGnFnXy6jdxYQ/8wokogNDF5upIh
 +3dY84VjhdRYOQiC5CK9pWjCxMnbj99a4t7g==
X-Gm-Gg: ASbGncu7i3Wai5bIBaoWaXafg8+6Iooc//30ikI0oSIBupakPJAAHxYG/rp/XqILJvv
 S2HItw5D5dt+XuzzAOOU06GgmF6KT9g+r6pV3cE1RF+AQNIdYmOXLEjBIr4zlaRWCVobq1gqDSD
 Ues630AD4XFahWeaczdvu+jocnTTv8J0O0A+TkUktimzC2OvtxNIWWZeSf9mrmMc1GTWAMKBfU0
 Wwb7vzg1tiRJHJKjcFkX+hXAsQf95a2zwCl3nGC6Q5E4aWVyGw4VPkk7h5IsFu3jV6S1WSYzJ2m
 ZuWIrDhrhXlukqmkbOI3+Kvxj0hWiv5t
X-Received: by 2002:ac8:5746:0:b0:467:50d0:8869 with SMTP id
 d75a77b69052e-46c71004b3amr464993461cf.18.1736896094006; 
 Tue, 14 Jan 2025 15:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5Lsm5vDavLlde2FVr8DkN0Iyih2gUZK4xiZZtJVOmCJwrrBV6VsmSTUE/8fcyqaR4rYTDMg==
X-Received: by 2002:ac8:5746:0:b0:467:50d0:8869 with SMTP id
 d75a77b69052e-46c71004b3amr464993021cf.18.1736896093549; 
 Tue, 14 Jan 2025 15:08:13 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 14/16] migration: Always set DEVICE state
Date: Tue, 14 Jan 2025 18:07:44 -0500
Message-ID: <20250114230746.3268797-15-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

DEVICE state was introduced back in 2017:

https://lore.kernel.org/qemu-devel/20171020090556.18631-1-dgilbert@redhat.com/

Quote from Dave's cover letter, when the pre-switchover phase was enabled,
the state transition looks like this:

  The precopy flow is:
  active->pre-switchover->device->completed

  The postcopy flow is:
  active->pre-switchover->postcopy-active->completed

To supplement above, when the cap is not enabled:

  The precopy flow is:
  active->completed

  The postcopy flow is:
  active->postcopy-active->completed

It works for us, though we have some code just to special case these state
transitions, so the DEVICE state currently is special only to precopy, and
only conditionally.

I had a quick discussion with Libvirt developers, it turns out that this
may not be necessary. IOW, it seems okay we can have DEVICE state to be
generic, so that we don't have over-complicated state machines.  It not
only helps align all the migration state machine, help cleanup the code
path especially on pre-switchover handling (see the patch itself), another
side benefit is we can unconditionally have a specific state to mark the
switchover phase, which might be helpful for debugging too.

This patch makes the DEVICE state to be present always, marking that source
QEMU is switching over.  Then the state machine will be always as simple
as:

  active-> [pre-switchover->] -> device -> [postcopy-active->] -> complete

After the change, no matter whether pre-switchover or postcopy is enabled
or not, we always have DEVICE state showing the switchover phase.  When
pre-switchover enabled, we'll have an extra stage before that.  When
postcopy is enabled, we'll have an extra stage after that.

A few qtests need touch up in QEMU tree for this change:

  - A few iotest outputs (194, 203, 234, 262, 280)
  - Teach libqos's migrate() on "device" state

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json         |  7 +++-
 migration/migration.c       | 82 +++++++++++++++++++++++--------------
 tests/qtest/libqos/libqos.c |  3 +-
 tests/qemu-iotests/194.out  |  1 +
 tests/qemu-iotests/203.out  |  1 +
 tests/qemu-iotests/234.out  |  2 +
 tests/qemu-iotests/262.out  |  1 +
 tests/qemu-iotests/280.out  |  1 +
 8 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a605dc26db..86d2342e1f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -158,8 +158,11 @@
 #
 # @pre-switchover: Paused before device serialisation.  (since 2.11)
 #
-# @device: During device serialisation when pause-before-switchover is
-#     enabled (since 2.11)
+# @device: During device serialisation (also known as switchover phase).
+#     Before 9.2, this is only used when (1) in precopy, and (2) when
+#     pre-switchover capability is enabled.  After 10.0, this state will
+#     always be present for every migration procedure as the switchover
+#     phase.  (since 2.11)
 #
 # @wait-unplug: wait for device unplug request by guest OS to be
 #     completed.  (since 4.2)
diff --git a/migration/migration.c b/migration/migration.c
index a8fe423a2b..2a95081b6c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,7 +102,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static int migration_maybe_pause(MigrationState *s, int new_state);
+static bool migration_switchover_start(MigrationState *s);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2530,11 +2530,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
-    if (!migrate_pause_before_switchover()) {
-        migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    }
-
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
@@ -2545,10 +2540,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = migration_maybe_pause(ms, MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
-                         __func__);
+    if (!migration_switchover_start(ms)) {
+        error_setg(errp, "migration_switchover_start() failed");
         goto fail;
     }
 
@@ -2673,6 +2666,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
+    /* Now, switchover looks all fine, switching to postcopy-active */
+    migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
     bql_unlock();
 
     return ret;
@@ -2689,14 +2686,39 @@ fail:
 }
 
 /**
- * migration_maybe_pause: Pause if required to by
- * migrate_pause_before_switchover called with the BQL locked
- * Returns: 0 on success
+ * @migration_switchover_start: Start VM switchover procedure
+ *
+ * @s: The migration state object pointer
+ *
+ * Prepares for the switchover, depending on "pause-before-switchover"
+ * capability.
+ *
+ * If cap set, state machine goes like:
+ *   [postcopy-]active -> pre-switchover -> device
+ *
+ * If cap not set:
+ *   [postcopy-]active -> device
+ *
+ * Returns: true on success, false on interruptions.
  */
-static int migration_maybe_pause(MigrationState *s, int new_state)
+static bool migration_switchover_start(MigrationState *s)
 {
+    /* Concurrent cancellation?  Quit */
+    if (s->state == MIGRATION_STATUS_CANCELLING) {
+        return false;
+    }
+
+    /*
+     * No matter precopy or postcopy, since we still hold BQL it must not
+     * change concurrently to CANCELLING, so it must be either ACTIVE or
+     * POSTCOPY_ACTIVE.
+     */
+    assert(migration_is_active());
+
+    /* If the pre stage not requested, directly switch to DEVICE */
     if (!migrate_pause_before_switchover()) {
-        return 0;
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_DEVICE);
+        return true;
     }
 
     /* Since leaving this state is not atomic with posting the semaphore
@@ -2709,23 +2731,22 @@ static int migration_maybe_pause(MigrationState *s, int new_state)
         /* This block intentionally left blank */
     }
 
+    /* Update [POSTCOPY_]ACTIVE to PRE_SWITCHOVER */
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_PRE_SWITCHOVER);
+    bql_unlock();
+
+    qemu_sem_wait(&s->pause_sem);
+
+    bql_lock();
     /*
-     * If the migration is cancelled when it is in the completion phase,
-     * the migration state is set to MIGRATION_STATUS_CANCELLING.
-     * So we don't need to wait a semaphore, otherwise we would always
-     * wait for the 'pause_sem' semaphore.
+     * After BQL released and retaken, the state can be CANCELLING if it
+     * happend during sem_wait().. Only change the state if it's still
+     * pre-switchover.
      */
-    if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_PRE_SWITCHOVER);
-        bql_unlock();
-        qemu_sem_wait(&s->pause_sem);
-        bql_lock();
-        migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
-                          new_state);
-    }
+    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
+                      MIGRATION_STATUS_DEVICE);
 
-    return s->state == new_state ? 0 : -EINVAL;
+    return s->state == MIGRATION_STATUS_DEVICE;
 }
 
 static int migration_completion_precopy(MigrationState *s)
@@ -2741,8 +2762,7 @@ static int migration_completion_precopy(MigrationState *s)
         }
     }
 
-    ret = migration_maybe_pause(s, MIGRATION_STATUS_DEVICE);
-    if (ret < 0) {
+    if (!migration_switchover_start(s)) {
         goto out_unlock;
     }
 
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 5c0fa1f7c5..28a0901a0a 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -117,13 +117,14 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
         g_assert(qdict_haskey(sub, "status"));
         st = qdict_get_str(sub, "status");
 
-        /* "setup", "active", "completed", "failed", "cancelled" */
+        /* "setup", "active", "device", "completed", "failed", "cancelled" */
         if (strcmp(st, "completed") == 0) {
             qobject_unref(rsp);
             break;
         }
 
         if ((strcmp(st, "setup") == 0) || (strcmp(st, "active") == 0)
+            || (strcmp(st, "device") == 0)
             || (strcmp(st, "wait-unplug") == 0)) {
             qobject_unref(rsp);
             g_usleep(5000);
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 376ed1d2e6..6940e809cd 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -14,6 +14,7 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
diff --git a/tests/qemu-iotests/203.out b/tests/qemu-iotests/203.out
index 9d4abba8c5..8e58705e51 100644
--- a/tests/qemu-iotests/203.out
+++ b/tests/qemu-iotests/203.out
@@ -8,4 +8,5 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
index ac8b64350c..be3e138b58 100644
--- a/tests/qemu-iotests/234.out
+++ b/tests/qemu-iotests/234.out
@@ -10,6 +10,7 @@ Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -27,6 +28,7 @@ Starting migration back to A...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
index b8a2d3598d..bd7706b84b 100644
--- a/tests/qemu-iotests/262.out
+++ b/tests/qemu-iotests/262.out
@@ -8,6 +8,7 @@ Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 546dbb4a68..37411144ca 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -7,6 +7,7 @@ Enabling migration QMP events on VM...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 VM is now stopped:
-- 
2.47.0


