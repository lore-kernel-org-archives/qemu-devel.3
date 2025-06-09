Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1018EC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfEC-00014p-S8; Mon, 09 Jun 2025 12:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDo-0000me-R3
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDm-0004Xd-GB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tgiVBDvopoht8yBW2Hx5L1ZBKRLyR84q/WVPp5DRwQ=;
 b=A0BZjc3TINdzSsARY2J9/1Xdg3+t4sR6AFOGD/zsD1HtaOux58VUzWkZBUwZQsBj2/5Upf
 OFLjaAgBtceltpRwzgPfwlgCua3/XUu4VzYT82LUiLfVRiCNR/b8Fr6dWTOf2iJv5mAxEz
 ql8tCnQXIViZMgH834f/px0hUPJQCkg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-4GLsOqpJPVqAviSdVGbEnA-1; Mon, 09 Jun 2025 12:19:36 -0400
X-MC-Unique: 4GLsOqpJPVqAviSdVGbEnA-1
X-Mimecast-MFC-AGG-ID: 4GLsOqpJPVqAviSdVGbEnA_1749485976
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so6612744a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485975; x=1750090775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tgiVBDvopoht8yBW2Hx5L1ZBKRLyR84q/WVPp5DRwQ=;
 b=wKPW4DQxovZihtGwo6TlKXj5Kj8pizLncMTN5JIDSvytezGg0SxfxtBxEW2jWD6NOs
 Jzh7SxD4zUw4XRR4rHb4d0RQR8iX2PzwaoR0qw8p5psWVrHvOfwEuZlT5XroqobQMfpW
 jeyQDEGxzGghDuAMhYYsmDYkVHUbABKobcEzjxMJXHo+gtdA3AjKlnIcXmsL8F6K78fm
 VMrm1d1CejSwTRf51LZuYoJBOyo48gNra5djQRW9vcfBd2NYSxWWuWpJgKalkZXWm6Jz
 l7FEsqLZ8FJDoU/mG/slaDuZLkU3OHy1vEkpdBJOhz7nYLK5b9lmzXe3/2o/Sv71Yz9t
 +OIw==
X-Gm-Message-State: AOJu0Yz9HS0uyoq7scxXlgNBWDRkPCLcCQwWNg3qLQpAPpM2IR/M2mqv
 I5ZSGdOQhPFyml6XXpM/Z+tFlDEVhztDoPR1srkWaQc7PVQSTtEeDmDyYq+jKAe3YWnuY2e/n5x
 0BWaqXnzUJGk9QnTqToA5dMWALdZWBMOc8YkzvHF6wY5enHCFO6O4+Fmk6lf+dVj+lehFa84/SF
 oONFgrHuJbZrYDuUwo65bsP9Gq/NiCiWtB9wkfvg==
X-Gm-Gg: ASbGncsMct1jD5bwQ5St/+am5AmPekGZrl8p01pMNoy/qmk+neZQ5JGHR9EmBLsbpfx
 7vdoH+sEioRtGg3UtRF9wh/wiW7S5gFiaaGncqU7iw6esJfKhr5xba66uCHMeZPAMzo5/USpMA5
 BMvM5iskb/cb2PFnZnb8CuvWiIp4XP+5yMYMoTtCUra7bUlDkeuBM/j+Gpd0LZosKh/fl3utkAx
 z6m/RfEImRancF7G78TEZ2fJtqBkHlSA62XbX1MGx7A5oBxI+WKpXpZdWlh2Tu4K/Ln01xCfLNA
 VbY=
X-Received: by 2002:ad4:5b8f:0:b0:6fa:c634:dc01 with SMTP id
 6a1803df08f44-6fb08f78beamr245544716d6.16.1749485964558; 
 Mon, 09 Jun 2025 09:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH84b24kYpwH0Sm4PXEe56IVnjhbSnvBe1JkUQyzp59RNmkh6ntSVVw70R0QzitjXRZmR49+w==
X-Received: by 2002:a05:6214:b6b:b0:6fa:b42b:2bd9 with SMTP id
 6a1803df08f44-6fb08fe37eamr253861546d6.37.1749485952825; 
 Mon, 09 Jun 2025 09:19:12 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 10/11] migration: Rewrite the migration complete detect
 logic
Date: Mon,  9 Jun 2025 12:18:54 -0400
Message-ID: <20250609161855.6603-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
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
 migration/migration.c | 56 +++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e33e39ac74..1a26a4bfef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3436,33 +3436,59 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
+            trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
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


