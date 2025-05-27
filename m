Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E8C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2KL-0004ks-Df; Tue, 27 May 2025 17:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KH-0004kB-JZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2KF-000883-8k
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rjaoMtmxWqZHgcZh3j5/e8hA4MGM0+maUVVcU22C5c=;
 b=J3lEv090EyQ59BixTBinxHdTZ+HpUiB1bz1xwAVyWtYASvCibC+ZZo6tt77gygvDZBkgL2
 XUoPr/BOYeMGhYGMmKNdd6zTLNVrs73jzn3JPCh2pnS2TujlSpDaq2fUfWh/JMgLrJOkhw
 SqPqoKahB35XHStSyZqndY/HVRwhZYA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-JMWAE2HrOwGaZ7EHSY1MRA-1; Tue, 27 May 2025 17:59:09 -0400
X-MC-Unique: JMWAE2HrOwGaZ7EHSY1MRA-1
X-Mimecast-MFC-AGG-ID: JMWAE2HrOwGaZ7EHSY1MRA_1748383149
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faa9ffe50fso40638956d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383148; x=1748987948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rjaoMtmxWqZHgcZh3j5/e8hA4MGM0+maUVVcU22C5c=;
 b=DMgI/MEBzsEqJLKHOrFmOBP6a45BEA42nvp65ntMyb+JYIBCk9IWVEt3Nnbh0ZN/FN
 J2mi91ItTQMerTnaVQPFrKDDNdYsJl6fBH5lz9l3z4BsbaeeN2WaiDXIRg6XqoJGW/gn
 g7Bomvg3uiZhXWHpMaogc93NgBi2ZAOXkLd7mAUWpyHnydHRMRLllA5J+8mqn6HpfcVZ
 2ib0O+GWGSrtXAiOleiSdZa8VV3XdgAnyXyyqmodURtrraJz1Rx9igWcLtYWRaCw4p4d
 N4AEJL4ELqQjgphqe2BdPi2MjcL0emP828ep9zDWP/z5R16vHYhgV0ytODJ88+Gsh6yU
 ANyw==
X-Gm-Message-State: AOJu0YyHFd/N7L+2tjiv95tx/eyUr82AKQbQkQTUVFOBJc9ZSo9XuajI
 3S+7MsiCJzHKoIv6HOhOkQqFQoT67ZG52AdG638jQ7+qEviym/zLp7zbi+TbhaIme+a1E1ANzUO
 AXGvdtbG9aMiM58ilruCfAqsFK0Mj6V4PfWN+rJxwQZgGZc+bXN8rvPJBat6XejRzAksaItP0HM
 FJZBD+NfSBZwrElEU7tBUXcHGdkKbmhW6fSDLlog==
X-Gm-Gg: ASbGncuoI60fWOSq0T3WfU6GXeupfjVsNZ1ltWK1QRALwAwVQfjIur3EUGgBfZBEjd5
 EFsy3xkzR7vkh9i29p3Fz1qH31gK2/UJhQfTi2Sb8OjFE0UH6g4H8kZvz++G1gOLsCABaptaURE
 DiomsAgXaelV0uvBtKDVcFG0u3JaUFZS5K0aSQA6M4iZltsnBagMN0rF4bfME8F6bTGtkaKQNnD
 3DzcCdJbpAzyMuAOg6taqiWmOQY5U9/jvqU1+ucXCwlGN8iTZVeAsszrtoT7QrDuzIcXdASLKHj
X-Received: by 2002:a05:6214:3013:b0:6f8:f21a:233c with SMTP id
 6a1803df08f44-6fa9d2de23emr254270376d6.42.1748383148250; 
 Tue, 27 May 2025 14:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/q7bRHYU/X0tpI+yPhbBZ/yMv3mKAs+U9IPe1zUljY5U9Lu2zVvyNAIjtaDi5ABoHYPS3qQ==
X-Received: by 2002:a05:6214:3013:b0:6f8:f21a:233c with SMTP id
 6a1803df08f44-6fa9d2de23emr254270076d6.42.1748383147863; 
 Tue, 27 May 2025 14:59:07 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:59:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 10/11] migration: Rewrite the migration complete detect logic
Date: Tue, 27 May 2025 17:58:49 -0400
Message-ID: <20250527215850.1271072-11-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 56 +++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7bd78dd524..e542c09755 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3439,33 +3439,59 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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


