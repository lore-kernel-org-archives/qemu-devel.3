Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F0DC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ55C-0004BL-Ma; Fri, 13 Jun 2025 10:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54z-0004A7-55
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54w-0001WM-HV
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkSoF5C170XPQpMmHRJlTyOwKvMj5P74B1dZkPVw5Dg=;
 b=Z4nK8QUJsp6bwB/kzZmoMgs5VGjuiwel26hQZ3854UD5W9msPT567nFitu0sxQXWaRKNhh
 1Kyc6T/7MpheXB4DukkjOXxuo0xdOgxp4EuzVQ81ooDK05lLdcvIzT/lJfJzymWdxyafkd
 Auyjz2A3bB0UK6lRxCjsDA8h7kMuDSY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-p0qelc32OMO9gQWEd26xmQ-1; Fri, 13 Jun 2025 10:08:20 -0400
X-MC-Unique: p0qelc32OMO9gQWEd26xmQ-1
X-Mimecast-MFC-AGG-ID: p0qelc32OMO9gQWEd26xmQ_1749823700
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a42d650185so28999441cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823699; x=1750428499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkSoF5C170XPQpMmHRJlTyOwKvMj5P74B1dZkPVw5Dg=;
 b=XVXOi1nn6WLgNOX9Q3BN+qtyBi+63E6ZzyogHKx7lMuT+WTYQQ/tDJcfl8UFWiiEXe
 N/pOxV0Ri3Y4yg+C1D3/BzyhWz2ZIA3Cncy91rd3q4Ouva9DUuDVhBJnzSEb8ku8lePm
 RgpokAsrSqaw4Ny42ORQMldNEp/YgG0f7bHY6xCqn64UAL1o6/X+juT6qLwFv+fRZhB5
 QNQx+3r6HOh1V9EEKPpThe7Vl6SxQHPGQLXnwi8Eof8k8R6knYOBBraSBvBT77gQ+RCS
 rXZdp34BIYIKtY1iPXzbkunBZ50eNZZim8zgbMzYHXrveh/w/s5R+Z6aXePAL+pPlfbx
 h2wQ==
X-Gm-Message-State: AOJu0YwgJLFkuDHnHacVlXneTlcN1MeXm1QtBaXiwEoPRb/u7oqYG8tc
 oJx27VRVReYIuKzXPKLaf1skxpTrUnXX+u7KgBN7ZxSgLuUyHR7WduzPmwxLXlmGOkWyX4rvJ3i
 gbRGvRitMJ9S6coLTyfUtaeS+7aj85j3abt5lyV6nnvSyOZFAmGh1UubU35Vo+eg//zuvXLK7zx
 HibZBd77IL2VrK/Dw88F5sDHgQK5iVDU8O2lBajg==
X-Gm-Gg: ASbGncs1LZHKKm9EN/hugLrjgbvwTfeZVHSGDp0MHZIXIDUbQ5NXdbCkKR/N+i5d9qT
 t/eY30V+gWYjBEznT3ATYfThBav9U0RT11Yo0KJT1BbuO44YpQobsyI351R7KB/sJ3k0zK8nxkt
 Mwv4fiCIwwzIg/yHQxF5cmStmDIrNeFmuoXal6yvlSAgorEk2XZ6ybgXUpbIZAmH0lz8PCx2myg
 XD0qg2ue1qY3R4pth2BBKG//IMaZSNuXIjB/fv3OAHmKfg4fnFFdRLuy5Y0u5jy9/SbPqX5fZoe
 qmFA38HXESY=
X-Received: by 2002:a05:622a:4d09:b0:4a6:f878:346a with SMTP id
 d75a77b69052e-4a72fe63272mr57516471cf.11.1749823699241; 
 Fri, 13 Jun 2025 07:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLDbW8JkrD8JwXPtBwnfp1jMLy/QEUEXPXfG9mSacrRephz6JoPL7cxmOR0AAQxMUQMt0rWQ==
X-Received: by 2002:a05:622a:4d09:b0:4a6:f878:346a with SMTP id
 d75a77b69052e-4a72fe63272mr57515791cf.11.1749823698620; 
 Fri, 13 Jun 2025 07:08:18 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 10/11] migration: Rewrite the migration complete detect
 logic
Date: Fri, 13 Jun 2025 10:08:00 -0400
Message-ID: <20250613140801.474264-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There're a few things off here in that logic, rewrite it.  When at it, add
rich comment to explain each of the decisions.

Since this is very sensitive path for migration, below are the list of
things changed with their reasonings.

  (1) Exact pending size is only needed for precopy not postcopy

      Fundamentally it's because "exact" version only does one more deep
      sync to fetch the pending results, while in postcopy's case it's
      never going to sync anything more than estimate as the VM on source
      is stopped.

  (2) Do _not_ rely on threshold_size anymore to decide whether postcopy
      should complete

      threshold_size was calculated from the expected downtime and
      bandwidth only during precopy as an efficient way to decide when to
      switchover.  It's not sensible to rely on threshold_size in postcopy.

      For precopy, if switchover is decided, the migration will complete
      soon.  It's not true for postcopy.  Logically speaking, postcopy
      should only complete the migration if all pending data is flushed.

      Here it used to work because save_complete() used to implicitly
      contain save_live_iterate() when there's pending size.

      Even if that looks benign, having RAMs to be migrated in postcopy's
      save_complete() has other bad side effects:

      (a) Since save_complete() needs to be run once at a time, it means
      when moving RAM there's no way moving other things (rather than
      round-robin iterating the vmstate handlers like what we do with
      ITERABLE phase).  Not an immediate concern, but it may stop working
      in the future when there're more than one iterables (e.g. vfio
      postcopy).

      (b) postcopy recovery, unfortunately, only works during ITERABLE
      phase. IOW, if src QEMU moves RAM during postcopy's save_complete()
      and network failed, then it'll crash both QEMUs... OTOH if it failed
      during iteration it'll still be recoverable.  IOW, this change should
      further reduce the window QEMU split brain and crash in extreme cases.

      If we enable the ram_save_complete() tracepoints, we'll see this
      before this patch:

      1267959@1748381938.294066:ram_save_complete dirty=9627, done=0
      1267959@1748381938.308884:ram_save_complete dirty=0, done=1

      It means in this migration there're 9627 pages migrated at complete()
      of postcopy phase.

      After this change, all the postcopy RAM should be migrated in iterable
      phase, rather than save_complete():

      1267959@1748381938.294066:ram_save_complete dirty=0, done=0
      1267959@1748381938.308884:ram_save_complete dirty=0, done=1

  (3) Adjust when to decide to switch to postcopy

      This shouldn't be super important, the movement makes sure there's
      only one in_postcopy check, then we are clear on what we do with the
      two completely differnt use cases (precopy v.s. postcopy).

  (4) Trivial touch up on threshold_size comparision

      Which changes:

      "(!pending_size || pending_size < s->threshold_size)"

      into:

      "(pending_size <= s->threshold_size)"

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 57 +++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e33e39ac74..923400f801 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3436,33 +3436,60 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
     bool can_switchover = migration_can_switchover(s);
+    bool complete_ready;
 
+    /* Fast path - get the estimated amount of pending data */
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     pending_size = must_precopy + can_postcopy;
     trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
 
-    if (pending_size < s->threshold_size) {
-        qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
-        pending_size = must_precopy + can_postcopy;
-        trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
+    if (in_postcopy) {
+        /*
+         * Iterate in postcopy until all pending data flushed.  Note that
+         * postcopy completion doesn't rely on can_switchover, because when
+         * POSTCOPY_ACTIVE it means switchover already happened.
+         */
+        complete_ready = !pending_size;
+    } else {
+        /*
+         * Exact pending reporting is only needed for precopy.  Taking RAM
+         * as example, there'll be no extra dirty information after
+         * postcopy started, so ESTIMATE should always match with EXACT
+         * during postcopy phase.
+         */
+        if (pending_size < s->threshold_size) {
+            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
+            pending_size = must_precopy + can_postcopy;
+            trace_migrate_pending_exact(pending_size, must_precopy,
+                                        can_postcopy);
+        }
+
+        /* Should we switch to postcopy now? */
+        if (must_precopy <= s->threshold_size &&
+            can_switchover && qatomic_read(&s->start_postcopy)) {
+            if (postcopy_start(s, &local_err)) {
+                migrate_set_error(s, local_err);
+                error_report_err(local_err);
+            }
+            return MIG_ITERATE_SKIP;
+        }
+
+        /*
+         * For precopy, migration can complete only if:
+         *
+         * (1) Switchover is acknowledged by destination
+         * (2) Pending size is no more than the threshold specified
+         *     (which was calculated from expected downtime)
+         */
+        complete_ready = can_switchover && (pending_size <= s->threshold_size);
     }
 
-    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
+    if (complete_ready) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
-    /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
-        qatomic_read(&s->start_postcopy)) {
-        if (postcopy_start(s, &local_err)) {
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
-        }
-        return MIG_ITERATE_SKIP;
-    }
-
     /* Just another iteration step */
     qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
     return MIG_ITERATE_RESUME;
-- 
2.49.0


