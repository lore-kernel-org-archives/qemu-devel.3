Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0974CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMYK-0004Qw-Gj; Mon, 30 Sep 2024 15:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMY2-00049Q-MG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMY0-00047c-Tj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727726347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDBWKslzG5nwdIt7YxzIRAMdilvoFhU+JDma5UP115Q=;
 b=cl+EtGGnys4iz0IciZh2L47g0TxlojJlbYWnzpqOGP0YYf2nuBSsZU07E9hgykTUx69Liz
 KVTr7X/gigJIeyWliLeFqeEk/t0iA0F8InOAn6ycIASWkCNGlq4U/L+7w+ofIB36AVIcTj
 VyawdcAz1NdnXArPWKdtkMy+Aa8XptQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-NstkanWxMuSETVVL5Fm1sw-1; Mon, 30 Sep 2024 15:59:06 -0400
X-MC-Unique: NstkanWxMuSETVVL5Fm1sw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-45856a29545so99100651cf.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727726345; x=1728331145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDBWKslzG5nwdIt7YxzIRAMdilvoFhU+JDma5UP115Q=;
 b=VOfuzNAqvQpLJP3ppZ4feFchwm4XcETngCcCZdQTkz1lgda7G1Q1d9WsShvij6/OSN
 oUkjYd26uYR6EtjzYOzVLTTK+NphMR2rSioH+59ymkm5UOYEtN0XKQ2BH1ctRc+TOtAk
 9X2Wfa8G4NlJR8mgMD4GwKaGgyCjDreC0xrgq+o8sJYbpqmCa4xqZr/B9J/oMHadbLnE
 iNpZF1Fiy+k2o9AGvvKanPrmxZCdgDv3RaNjp7aLeeHwnMshwVDxH9PgLkWRXF0MXnTE
 NUSR4LdYudOyyaPzgjs+UmJnrljhr9irCAtPx++DaJubIRhhExoC68187fW4BdGvfKvK
 c+QQ==
X-Gm-Message-State: AOJu0Yz21JXGVP6AMRu4pzy8YwlO+bt6ImM6dJFZqS3ciaTGmykabR3p
 tQa5JGH2PIoVotJIKEw14wFHCag5LcLdQ6JTz2vV5E3sLTQjj2l7++CpQnDRe1wJALg1fiFe6xo
 eNpO6ktfe6OefQgD/gUUPO7tU7TGyzQkpvV398ANETtzLy7vN70Bs8KSgl5wTKpLrXhb2AzAJKB
 D72sjF8PFUe5KUPUC8M1q17EPsrsmpTqwEJw==
X-Received: by 2002:ac8:7f09:0:b0:45b:5596:f785 with SMTP id
 d75a77b69052e-45c9f2a3ccamr217341481cf.44.1727726344594; 
 Mon, 30 Sep 2024 12:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF00fm5R2Yl9uT792JudZsOBV9gQxJc9d2Ztjd5aqJ+8ReyVARVuAaZm4316X4jDrwIXTThdA==
X-Received: by 2002:ac8:7f09:0:b0:45b:5596:f785 with SMTP id
 d75a77b69052e-45c9f2a3ccamr217341161cf.44.1727726344203; 
 Mon, 30 Sep 2024 12:59:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f28e481sm38879371cf.16.2024.09.30.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:59:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 6/7] migration: Remove MigrationThread and threadinfo.h
Date: Mon, 30 Sep 2024 15:58:36 -0400
Message-ID: <20240930195837.825728-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240930195837.825728-1-peterx@redhat.com>
References: <20240930195837.825728-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The MigrationThread struct is mostly the same as MigrationThreadInfoList,
except that it's a double-linked list so removal doesn't need to remember
prev pointer.

That might not be necessary, especially considering that the defintion of
that struct is the only thing in threadinfo.h now.

Reuse MigrationThreadInfoList, then let's drop the header.  Need to manage
a single list entry removal, but after I saw the diff, it's not so bad.

With that, query-migrationthreads is much easier, as we can simply do
QAPI_CLONE() now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/threadinfo.h | 22 -------------------
 migration/migration.c  |  1 -
 migration/multifd.c    |  1 -
 migration/threadinfo.c | 50 +++++++++++++++++++++---------------------
 4 files changed, 25 insertions(+), 49 deletions(-)
 delete mode 100644 migration/threadinfo.h

diff --git a/migration/threadinfo.h b/migration/threadinfo.h
deleted file mode 100644
index 59f334af21..0000000000
--- a/migration/threadinfo.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Migration Threads info
- *
- *  Copyright (c) 2022 HUAWEI TECHNOLOGIES CO., LTD.
- *
- *  Authors:
- *  Jiang Jiacheng <jiangjiacheng@huawei.com>
- *
- *  This work is licensed under the terms of the GNU GPL, version 2 or later.
- *  See the COPYING file in the top-level directory.
- */
-
-#include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-
-typedef struct MigrationThread MigrationThread;
-
-struct MigrationThread {
-    const char *name; /* the name of migration thread */
-    int thread_id; /* ID of the underlying host thread */
-    QLIST_ENTRY(MigrationThread) node;
-};
diff --git a/migration/migration.c b/migration/migration.c
index 04c4272e46..1034668a90 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -57,7 +57,6 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "qemu/yank.h"
 #include "sysemu/cpus.h"
 #include "yank_functions.h"
diff --git a/migration/multifd.c b/migration/multifd.c
index b96aaffebb..0baa760ccf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -26,7 +26,6 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 73db26dc82..6c1278b4ea 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -13,11 +13,13 @@
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
 #include "qemu/lockable.h"
-#include "threadinfo.h"
 #include "migration.h"
+#include "qapi/qapi-commands-migration.h"
+#include "qapi/qapi-visit-migration.h"
+#include "qapi/clone-visitor.h"
 
 QemuMutex migration_threads_lock;
-static QLIST_HEAD(, MigrationThread) migration_threads;
+static MigrationThreadInfoList *migration_threads;
 
 static void __attribute__((constructor)) migration_threads_init(void)
 {
@@ -26,31 +28,40 @@ static void __attribute__((constructor)) migration_threads_init(void)
 
 void migration_threads_add(const char *name)
 {
-    MigrationThread *thread =  g_new0(MigrationThread, 1);
+    MigrationThreadInfo *thread = g_new0(MigrationThreadInfo, 1);
 
-    thread->name = name;
+    thread->name = g_strdup(name);
     thread->thread_id = qemu_get_thread_id();
 
     WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
-        QLIST_INSERT_HEAD(&migration_threads, thread, node);
+        QAPI_LIST_PREPEND(migration_threads, thread);
     }
 }
 
 void migration_threads_remove(void)
 {
     int tid = qemu_get_thread_id();
-    MigrationThread *thread;
+    MigrationThreadInfoList *thread, *prev;
 
     QEMU_LOCK_GUARD(&migration_threads_lock);
 
-    QLIST_FOREACH(thread, &migration_threads, node) {
-        if (tid != thread->thread_id) {
-            continue;
-        }
+    prev = NULL;
+    thread = migration_threads;
 
-        QLIST_REMOVE(thread, node);
-        g_free(thread);
-        return;
+    while (thread) {
+        if (tid == thread->value->thread_id) {
+            if (!prev) {
+                migration_threads = thread->next;
+            } else {
+                prev->next = thread->next;
+            }
+            /* Terminate this single object to not free the rest */
+            thread->next = NULL;
+            qapi_free_MigrationThreadInfoList(thread);
+            return;
+        }
+        prev = thread;
+        thread = thread->next;
     }
 
     g_assert_not_reached();
@@ -58,18 +69,7 @@ void migration_threads_remove(void)
 
 MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
 {
-    MigrationThreadInfoList *head = NULL;
-    MigrationThreadInfoList **tail = &head;
-    MigrationThread *thread = NULL;
-
     QEMU_LOCK_GUARD(&migration_threads_lock);
-    QLIST_FOREACH(thread, &migration_threads, node) {
-        MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
-        info->name = g_strdup(thread->name);
-        info->thread_id = thread->thread_id;
-
-        QAPI_LIST_APPEND(tail, info);
-    }
 
-    return head;
+    return QAPI_CLONE(MigrationThreadInfoList, migration_threads);
 }
-- 
2.45.0


