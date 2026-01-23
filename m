Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E76D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEN-0001vB-JJ; Fri, 23 Jan 2026 14:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEL-0001uS-Sy
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:05 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEJ-0003SG-RG
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:05 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC40733863;
 Fri, 23 Jan 2026 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=743Ck5PACkasCTR4nYgvx9N+Sar7G8Zr/XdruLrTb7E=;
 b=XvpMOmdBVxJS34yWMIQ78XUbsTr8qmwGokzSNO1pnoDIbeAx7DxQJNzOtGNWNC+11Iav/a
 Vvuyr2iBhxweNows1mBzYQ4ihM8DL0WJrFZ//3fbRsY3UhHMMn8GRGA258NhQpF+wL9YjS
 nR9YPMbuqcg1bwKLPZu9uFUViHnOYIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=743Ck5PACkasCTR4nYgvx9N+Sar7G8Zr/XdruLrTb7E=;
 b=yPzoRP/2Nx722fdFYO+PsRZwVyNSzLuTN4/HNa88SVVQttTTZq/MZhWqd0pofsIlhaZY8T
 UM+2xblA+LIMvXDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CM29LtSr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yB5p83Yf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=743Ck5PACkasCTR4nYgvx9N+Sar7G8Zr/XdruLrTb7E=;
 b=CM29LtSr3EdblwEuHJzapZ8GHFK5La22zR58NmQ/LKeJAkacDxKaLj+Pvndfog7cIVDTtr
 lwXqlW/KSPyxd+MEZ5+4VbZdHH7RdatT4LDnKp3erd9Z005Tw68IH9esSYFycYF+O0qU6l
 1ISycdaK+RwndTN2ywZT6Q3l7+4j1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=743Ck5PACkasCTR4nYgvx9N+Sar7G8Zr/XdruLrTb7E=;
 b=yB5p83Yf0rpusMsCNyTOHMfWhT39J4Luzs2ejBL6M4i3agVwRxbeIBInxCTNdZYzCvlJjV
 nmHK3+NhwRR9EeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92EBD1395E;
 Fri, 23 Jan 2026 19:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NydFNTRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:53:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/36] migration: Drop deprecated QMP command
 query-migrationthreads
Date: Fri, 23 Jan 2026 16:53:16 -0300
Message-ID: <20260123195352.12850-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EC40733863
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

Deprecated in commit 228529d1fec3 (migration: Deprecate
query-migrationthreads command), v9.2.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260108125512.2234147-2-armbru@redhat.com
[fixed title underline length]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst       |  8 -----
 docs/about/removed-features.rst |  9 +++++
 migration/meson.build           |  1 -
 migration/migration.c           |  6 ----
 migration/multifd.c             |  5 ---
 migration/threadinfo.c          | 64 ---------------------------------
 migration/threadinfo.h          | 25 -------------
 qapi/migration.json             | 30 ----------------
 8 files changed, 9 insertions(+), 139 deletions(-)
 delete mode 100644 migration/threadinfo.c
 delete mode 100644 migration/threadinfo.h

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88efa3aa80..f57422d378 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -111,14 +111,6 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
-``query-migrationthreads`` (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-To be removed with no replacement, as it reports only a limited set of
-threads (for example, it only reports source side of multifd threads,
-without reporting any destination threads, or non-multifd source threads).
-For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
-
 ``block-job-pause`` (since 10.1)
 ''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index b0d7fa8813..4e0775dbc0 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -757,6 +757,15 @@ or list arguments were silently ignored. Other argument types were not
 checked, but an implicit conversion happened, so that e.g. string
 values could be assigned to integer device properties or vice versa.
 
+``query-migrationthreads`` (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''
+
+Removed with no replacement, as it reported only a limited set of
+threads (for example, it only reported source side of multifd threads,
+without reporting any destination threads, or non-multifd source
+threads).  For debugging purpose, please use ``-name
+$VM,debug-threads=on`` instead.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/migration/meson.build b/migration/meson.build
index 16909d54c5..c7f39bdb55 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -36,7 +36,6 @@ system_ss.add(files(
   'savevm.c',
   'socket.c',
   'tls.c',
-  'threadinfo.c',
 ), gnutls, zlib)
 
 if get_option('replication').allowed()
diff --git a/migration/migration.c b/migration/migration.c
index 1bcde301f7..9c6aa6f98a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -59,7 +59,6 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "qemu/yank.h"
 #include "system/cpus.h"
 #include "yank_functions.h"
@@ -3744,16 +3743,12 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
 static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
-    MigrationThread *thread = NULL;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
-                                   qemu_get_thread_id());
-
     rcu_register_thread();
 
     update_iteration_initial_status(s);
@@ -3854,7 +3849,6 @@ out:
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index c9d4a67a46..24785db93b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -29,7 +29,6 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
@@ -658,13 +657,10 @@ int multifd_send_sync_main(MultiFDSyncReq req)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
-    MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
     bool use_packets = multifd_use_packets();
 
-    thread = migration_threads_add(p->name, qemu_get_thread_id());
-
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
 
@@ -779,7 +775,6 @@ out:
     }
 
     rcu_unregister_thread();
-    migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
deleted file mode 100644
index 262990dd75..0000000000
--- a/migration/threadinfo.c
+++ /dev/null
@@ -1,64 +0,0 @@
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
-#include "qemu/osdep.h"
-#include "qemu/queue.h"
-#include "qemu/lockable.h"
-#include "threadinfo.h"
-
-QemuMutex migration_threads_lock;
-static QLIST_HEAD(, MigrationThread) migration_threads;
-
-static void __attribute__((constructor)) migration_threads_init(void)
-{
-    qemu_mutex_init(&migration_threads_lock);
-}
-
-MigrationThread *migration_threads_add(const char *name, int thread_id)
-{
-    MigrationThread *thread =  g_new0(MigrationThread, 1);
-    thread->name = name;
-    thread->thread_id = thread_id;
-
-    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
-        QLIST_INSERT_HEAD(&migration_threads, thread, node);
-    }
-
-    return thread;
-}
-
-void migration_threads_remove(MigrationThread *thread)
-{
-    QEMU_LOCK_GUARD(&migration_threads_lock);
-    if (thread) {
-        QLIST_REMOVE(thread, node);
-        g_free(thread);
-    }
-}
-
-MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
-{
-    MigrationThreadInfoList *head = NULL;
-    MigrationThreadInfoList **tail = &head;
-    MigrationThread *thread = NULL;
-
-    QEMU_LOCK_GUARD(&migration_threads_lock);
-    QLIST_FOREACH(thread, &migration_threads, node) {
-        MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
-        info->name = g_strdup(thread->name);
-        info->thread_id = thread->thread_id;
-
-        QAPI_LIST_APPEND(tail, info);
-    }
-
-    return head;
-}
diff --git a/migration/threadinfo.h b/migration/threadinfo.h
deleted file mode 100644
index 2f356ff312..0000000000
--- a/migration/threadinfo.h
+++ /dev/null
@@ -1,25 +0,0 @@
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
-
-MigrationThread *migration_threads_add(const char *name, int thread_id);
-void migration_threads_remove(MigrationThread *info);
diff --git a/qapi/migration.json b/qapi/migration.json
index 201dedd982..7bd24e66e9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2054,36 +2054,6 @@
 { 'command': 'query-vcpu-dirty-limit',
   'returns': [ 'DirtyLimitInfo' ] }
 
-##
-# @MigrationThreadInfo:
-#
-# Information about migrationthreads
-#
-# @name: the name of migration thread
-#
-# @thread-id: ID of the underlying host thread
-#
-# Since: 7.2
-##
-{ 'struct': 'MigrationThreadInfo',
-  'data': {'name': 'str',
-           'thread-id': 'int'} }
-
-##
-# @query-migrationthreads:
-#
-# Return information of migration threads
-#
-# Features:
-#
-# @deprecated: This command is deprecated with no replacement yet.
-#
-# Since: 7.2
-##
-{ 'command': 'query-migrationthreads',
-  'returns': ['MigrationThreadInfo'],
-  'features': ['deprecated'] }
-
 ##
 # @snapshot-save:
 #
-- 
2.51.0


