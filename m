Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C9CFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fgv-0002Mq-OG; Wed, 23 Oct 2024 14:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgk-0002Lc-BR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgh-00040S-S5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729706546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8pWkArmtfUuABCkN8q7bum98R07KaedLND3Mn0kzzA=;
 b=dHxaYP6pHo4KuOTZcdgsS9dG/3l0wJrxhi85lJcwpTojUQUqFN4+QKmkR/LGs1uvRc4zAC
 1ufHXOT4qKUeiyiSzdKvkwX5gHMd1THeefu+OBEvg1UlQn10W+sRrAq3nOyffPjzRjd98u
 zjcyAQMPkC1C0qpuEYJ8TnoTUrV1MXs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-OGKjWmoOPciWSFCvRgbLyA-1; Wed, 23 Oct 2024 14:02:25 -0400
X-MC-Unique: OGKjWmoOPciWSFCvRgbLyA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-461011bd338so836681cf.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706543; x=1730311343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8pWkArmtfUuABCkN8q7bum98R07KaedLND3Mn0kzzA=;
 b=ohYyZfZKjaBuDsPiNPdsMRas4w9vVCI+GYugBXBxdOxnQGhRv7L3j61vqKrjtZ2ZAc
 Nb29nXG7htGt2tjbQysQKc3XXs+keabQKcAbeBr+TW+2/PN6Ha0YoLHfEMWozxLVy/xs
 wmIDPNj4JdMv6/UCJk0dRopO47uuHzDukXsqK27ZEBG+JeotH17EkHh1mZnSKfF65Beu
 jqVMaBRmOjA5sSV7LBzvuv2pdgMzlSGYwBG48anlGGuvucIyabVjE2OQ2VX8w8Ko0RcX
 oe1QVTsMXDtGDkdKRXYBKfw8G6Tczx1vdY6rBgbVUXj6Qg/kDBLmj7W+CsWjFUkRFLCx
 Qf3A==
X-Gm-Message-State: AOJu0Yy298UwRly6+L45SMP1t200F2/d10UUog3w7YyXImTfPslghnSs
 MIbmLO86AdxJufoaaG4VErdipVrnI56+5V1Zc0e/ad2paI7UQlQ4CIPShmDHYSm6tJNnbPqaDUP
 zqn4FMrrNGQ9MKBkIn/IucSCu8T6V8WKJVLnV7grAJu3cyPPrvZLH5Rf7+fpt3oXhXtTfwZJHgW
 SLp0HEt3gIrCLEFbAFKkd3LMjjVt+KD540sA==
X-Received: by 2002:a05:622a:d0:b0:460:a9da:42b8 with SMTP id
 d75a77b69052e-461146bff6amr40873061cf.22.1729706543728; 
 Wed, 23 Oct 2024 11:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkiPd6HQAIvBizypMj9qmSkBmmIcMzdl6KqwcYi5PN1NYJrvegvqT2vnBNF/gQoUza1sJq7Q==
X-Received: by 2002:a05:622a:d0:b0:460:a9da:42b8 with SMTP id
 d75a77b69052e-461146bff6amr40872541cf.22.1729706543176; 
 Wed, 23 Oct 2024 11:02:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fcd0esm41746716d6.132.2024.10.23.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:02:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/4] migration: Add global_migration
Date: Wed, 23 Oct 2024 14:02:15 -0400
Message-ID: <20241023180216.1072575-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
References: <20241023180216.1072575-1-peterx@redhat.com>
MIME-Version: 1.0
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

Add a variable that is only used in exported / global migration helpers,
reflecting whether migration is available to the outside world.

Note that we haven't yet started using this variable, but hopefully that is
still better already because now we have an explicit place to say who owns
the initial migration refcount.  In this case, it's the global_migration
pointer (rather than current_migration) that owns it.  Then in shutdown()
we clear that pointer right after the unref() would make sense.

We'll start to use the variable in the next patch to provide thread safety
to all migration exported helpers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 44 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a82297db0f..c4adad7972 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -96,7 +96,36 @@ enum mig_rp_message_type {
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
 
-static MigrationState *current_migration;
+/*
+ * We have two pointers for the global migration objects.  Both of them are
+ * initialized early during QEMU starts, but they have different lifecycles.
+ *
+ * - current_migration
+ *
+ *   This variable reflects the whole lifecycle of the migration object
+ *   (which each QEMU can only have one).  It is valid until the migration
+ *   object is destroyed.
+ *
+ *   This is the object that internal migration so far use.  For example,
+ *   internal helper migrate_get_current() references it.
+ *
+ *   When all migration code can always pass over a MigrationState* around,
+ *   this variable can logically be dropped.  But we're not yet there.
+ *
+ * - global_migration
+ *
+ *   This is valid only until the migration object is still valid to the
+ *   outside-migration world (until migration_shutdown()).
+ *
+ *   This should normally be always set, cleared or accessed by the main
+ *   thread only, rather than the migration thread.
+ *
+ *   All the exported functions (in include/migration) should reference the
+ *   exported migration object only to avoid race conditions, as
+ *   current_migration can be freed concurrently by migration thread when
+ *   the migration thread holds the last refcount.
+ */
+static MigrationState *current_migration, *global_migration;
 static MigrationIncomingState *current_incoming;
 
 static GSList *migration_blockers[MIG_MODE__MAX];
@@ -232,7 +261,9 @@ static int migration_stop_vm(MigrationState *s, RunState state)
 
 void migration_object_init(void)
 {
-    MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+    /* The global variable holds the refcount */
+    global_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
+
     /* This should be set when initialize the object */
     assert(current_migration);
 
@@ -333,7 +364,14 @@ void migration_shutdown(void)
      * stop the migration using this structure
      */
     migration_cancel(NULL);
-    object_unref(OBJECT(current_migration));
+
+    /*
+     * This marks that migration object is not visible anymore to
+     * outside-migration world.  Migration might still hold a refcount if
+     * it's still in progress.
+     */
+    object_unref(OBJECT(global_migration));
+    global_migration = NULL;
 
     /*
      * Cancel outgoing migration of dirty bitmaps. It should
-- 
2.45.0


