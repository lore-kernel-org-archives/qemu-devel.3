Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6109BCFA45D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fgv-0002Mo-Dy; Wed, 23 Oct 2024 14:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgl-0002Lj-SE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgk-00040z-4S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729706548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irG+E1FaN1Hl9lD+YLjc9uevqLdXpkeOECPEiSEa5DE=;
 b=Y77Bxw+My+iJfdU/Toocd8r8rV9uStnwCnv/P/r30jhnT7w++6rBZd2hy0ywZKhFQOQ13j
 UUAT1cp+IKUR3sHXa4vKp+LhNXW2fPfVCpcAauaeRu2nfpHZ0ltltTddtzx5/vBq4bUa9O
 VPI4KPS0HgbY8i4FXeO+JVrF/yVoVug=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Qzd1uc7YNTGE9Kp-eyZ6gA-1; Wed, 23 Oct 2024 14:02:27 -0400
X-MC-Unique: Qzd1uc7YNTGE9Kp-eyZ6gA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbe4a123fdso1363446d6.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706546; x=1730311346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irG+E1FaN1Hl9lD+YLjc9uevqLdXpkeOECPEiSEa5DE=;
 b=ZLu3iEGR53H3VWfhNgq1PHcN3/3h8A3sAgOQyJP3lVn+zGW5MCZTMicKTR5ZVXJdZO
 /vAx1N7VXoR/wEditkHA1oT0NN+M9cqizQ7uYTtbifPF2JgICBlwuUpeqWsjo1uHS5nY
 Hs6J4rlCcnEZzt3filkNdr1Wfb9ji9LPhfiYG9cKbFjW30wk2iO4x3eqrt/k3Z47z0BY
 cGdb3LHK3TPmEc154H4w75SVSqap+iw2CEWjMfT4ylX2g5hdmzW+yl880cCs07CrqVpB
 FL+qfhHQ26P2F1osQbel5jeBd2cH9yHXQWFQRqsLkMtPH2Nz1MvCeoDz/tXsmOmqrMts
 D5xA==
X-Gm-Message-State: AOJu0Ywomf5efLrnRG+Vko0TIZcVB1jiMeDKOrP4XlC7lfeNwZ2upnE3
 GJJ3qua2aza+6hSgVORbhhxuKU1cyYblzkiepZVH4ZJIdyPDKh3OroEiUId2eL038qCFyaZXC5i
 4FX4cb0V0dzBnUKMUeJmOveeNq3otRdLPQZIsQiV/hoMcLGnuqKggZWxPmccIVC0/Pwoy2h6PDS
 nTWpA16WGTDDrMzc/4fiuC1R1oV0MITwRR7A==
X-Received: by 2002:a05:6214:4186:b0:6cb:5273:7265 with SMTP id
 6a1803df08f44-6ce341a2c77mr31532296d6.20.1729706545638; 
 Wed, 23 Oct 2024 11:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV5voK3721NW9DdugT/oFGZywAfbgQ148v30ZBAPoF84sUiNspXlqcr/U0XlDQ4ELS03MBfA==
X-Received: by 2002:a05:6214:4186:b0:6cb:5273:7265 with SMTP id
 6a1803df08f44-6ce341a2c77mr31531916d6.20.1729706545234; 
 Wed, 23 Oct 2024 11:02:25 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fcd0esm41746716d6.132.2024.10.23.11.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:02:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 4/4] migration: Make all helpers in misc.h safe to use
 without migration
Date: Wed, 23 Oct 2024 14:02:16 -0400
Message-ID: <20241023180216.1072575-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
References: <20241023180216.1072575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Migration object can be freed (e.g. after migration_shutdown()) before some
other device codes can still run, while we do have a bunch of migration
helpers exported in migration/misc.h that logically can be invoked at any
time of QEMU, even during destruction of a VM.

Make all these functions safe to be called, especially, not crashing after
the migration object is unreferenced from the main context.

To achieve it, only reference global_migration variable in the exported
functions.  The variable is only reset with BQL, so it's safe to access.

Add a comment in the header explaining how to guarantee thread safe on
using these functions, and we choose BQL because fundamentally that's how
it's working now.  We can move to other things (e.g. RCU) whenever
necessary in the future but it's an overkill if we have BQL anyway in
most/all existing callers.

When at it, update some comments, e.g. migrate_announce_params() is
exported from options.c now.

Cc: Cédric Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 26 +++++++++++++++++++++-----
 migration/migration.c    | 32 ++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index df57be6b5e..48892f9672 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -19,8 +19,19 @@
 #include "qapi/qapi-types-net.h"
 #include "migration/client-options.h"
 
-/* migration/ram.c */
+/*
+ * Misc migration functions exported to be used in QEMU generic system
+ * code outside migration/.
+ *
+ * By default, BQL is recommended before using below functions to avoid
+ * race conditions (concurrent updates to global_migration variable).  It's
+ * caller's responsibility to make sure it's thread safe otherwise when
+ * below helpers are used without BQL held.  When unsure, take BQL always.
+ */
 
+/*
+ * migration/ram.c
+ */
 typedef enum PrecopyNotifyReason {
     PRECOPY_NOTIFY_SETUP = 0,
     PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
@@ -43,14 +54,19 @@ void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 bool migrate_ram_is_ignored(RAMBlock *block);
 
-/* migration/block.c */
-
+/*
+ * migration/options.c
+ */
 AnnounceParameters *migrate_announce_params(void);
-/* migration/savevm.c */
 
+/*
+ * migration/savevm.c
+ */
 void dump_vmstate_json_to_file(FILE *out_fp);
 
-/* migration/migration.c */
+/*
+ * migration/migration.c
+ */
 void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
diff --git a/migration/migration.c b/migration/migration.c
index c4adad7972..667816cc65 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1157,7 +1157,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
  */
 bool migration_is_setup_or_active(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = global_migration;
+
+    if (!s) {
+        return false;
+    }
 
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
@@ -1174,7 +1178,6 @@ bool migration_is_setup_or_active(void)
 
     default:
         return false;
-
     }
 }
 
@@ -1721,7 +1724,11 @@ bool migration_is_idle(void)
 
 bool migration_is_active(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = global_migration;
+
+    if (!s) {
+        return false;
+    }
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
@@ -1729,14 +1736,23 @@ bool migration_is_active(void)
 
 bool migration_is_device(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = global_migration;
+
+    if (!s) {
+        return false;
+    }
 
     return s->state == MIGRATION_STATUS_DEVICE;
 }
 
 bool migration_thread_is_self(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = global_migration;
+
+    /* If no migration object, must not be the migration thread */
+    if (!s) {
+        return false;
+    }
 
     return qemu_thread_is_self(&s->thread);
 }
@@ -3113,7 +3129,11 @@ static MigThrError postcopy_pause(MigrationState *s)
 
 void migration_file_set_error(int ret, Error *err)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = global_migration;
+
+    if (!s) {
+        return;
+    }
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-- 
2.45.0


