Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9FACD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXM-0000bm-8n; Fri, 22 Mar 2024 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXK-0000b3-8J
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXE-0000kx-N1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711124062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptE4Jzsb6riHNpWnGjngqsuwWnV2Uk4JwkkRsTQX1vE=;
 b=arvADdJzHhvo2bKTj9D7k00kU5fNOSbttuW/G3k09gG6NRN8FHcgN5+VwPZolJFXlRtpYM
 IFLkZ/fRdZtlZNGzQM4ByiLOAyKQitrhBSSqHqZV6qPbrG7PTYhPWHqK3+4xqCCasaqsIx
 71eIevGC8RLxHRsX9mTS7SGZJSxT3+4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-30cA5LeINLiqDgpfjfoMQA-1; Fri, 22 Mar 2024 12:14:21 -0400
X-MC-Unique: 30cA5LeINLiqDgpfjfoMQA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69672754479so962466d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124060; x=1711728860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptE4Jzsb6riHNpWnGjngqsuwWnV2Uk4JwkkRsTQX1vE=;
 b=Nr19U65FB3ZTnjVRn3Bukvj7XofTF0moS4Nfp/LNFx9HJj0VuJBkycuWfzqiQxuHMO
 Q9LiZqSkYXK39vhOgFYiq88T9In/+wM/NHj0d1YK/oADmsyljKXjXGg055IU7y3/9iRf
 3sbGg/vV73TzSke1uAkvXLv/ganM0YyRZcR64B5Q5+ejhm7brQFSu3PdUGJiew1rwqIH
 40ZoNQdJEu7HaVLNHVVMnTBSpgG0rEb0fX5u2enfQIogioydaE/dxglo5JedcXyT6VXA
 UbBYAi+258u8bPrH8CC/OeyIRZz2k/8TQ2QIGNAR0YU7wG8GqjA8x3B5wsuU/Q1Ncfqn
 7gPg==
X-Gm-Message-State: AOJu0Yx+7DOhWzlgDFAjg65OLiYPHjHpdXdFPJihqrwULAYIliF4gQrY
 DXSEkm6aBFQGLUd9r/cYJpZeijsoCnMxGRxR5V2mzEBgC7/m+zNRA35CksGHaIyl6fW6iwPlBfH
 7sKRswi1b79IHjolO5LiLDdXBGOBnUPPgA7pHnufVy1c6VkiXjvsrh1xHOJeYIc0fTxO8lms/1b
 t6+KoKw6XsXdN+gsJpZrlSidleuX7s4R84Dg==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id
 kr6-20020a0562142b8600b00696732f41cemr1095441qvb.0.1711124060341; 
 Fri, 22 Mar 2024 09:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWUgrR6fTWAZ0ERhLxo3L5ZTfZB8uXoKbcHzgiAZwvw70ZVw+hJC8YB1KsxVM86UUp0np3HA==
X-Received: by 2002:a05:6214:2b86:b0:696:732f:41ce with SMTP id
 kr6-20020a0562142b8600b00696732f41cemr1095408qvb.0.1711124059681; 
 Fri, 22 Mar 2024 09:14:19 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05621420e600b006904c34d5basm1202708qvk.64.2024.03.22.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 09:14:19 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PULL 1/3] migration: Revert mapped-ram multifd support to fd: URI
Date: Fri, 22 Mar 2024 12:14:15 -0400
Message-ID: <20240322161417.759586-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322161417.759586-1-peterx@redhat.com>
References: <20240322161417.759586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

This reverts commit decdc76772c453ff1444612e910caa0d45cd8eac in full
and also the relevant migration-tests from
7a09f092834641b7a793d50a3a261073bbb404a6.

After the addition of the new QAPI-based migration address API in 8.2
we've been converting an "fd:" URI into a SocketAddress, missing the
fact that the "fd:" syntax could also be used for a plain file instead
of a socket. This is a problem because the SocketAddress is part of
the API, so we're effectively asking users to create a "socket"
channel to pass in a plain file.

The easiest way to fix this situation is to deprecate the usage of
both SocketAddress and "fd:" when used with a plain file for
migration. Since this has been possible since 8.2, we can wait until
9.1 to deprecate it.

For 9.0, however, we should avoid adding further support to migration
to a plain file using the old "fd:" syntax or the new SocketAddress
API, and instead require the usage of either the old-style "file:" URI
or the FileMigrationArgs::filename field of the new API with the
"/dev/fdset/NN" syntax, both of which are already supported.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240319210941.1907-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.h               |  2 --
 migration/fd.c               | 56 ++++--------------------------------
 migration/file.c             | 19 ++----------
 migration/migration.c        | 13 ---------
 migration/multifd.c          |  2 --
 tests/qtest/migration-test.c | 43 ---------------------------
 6 files changed, 8 insertions(+), 127 deletions(-)

diff --git a/migration/fd.h b/migration/fd.h
index 0c0a18d9e7..b901bc014e 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -20,6 +20,4 @@ void fd_start_incoming_migration(const char *fdname, Error **errp);
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
-void fd_cleanup_outgoing_migration(void);
-int fd_args_get_fd(void);
 #endif
diff --git a/migration/fd.c b/migration/fd.c
index fe0d096abd..449adaa2de 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,42 +15,19 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "monitor/monitor.h"
-#include "io/channel-file.h"
-#include "io/channel-socket.h"
 #include "io/channel-util.h"
-#include "options.h"
 #include "trace.h"
 
 
-static struct FdOutgoingArgs {
-    int fd;
-} outgoing_args;
-
-int fd_args_get_fd(void)
-{
-    return outgoing_args.fd;
-}
-
-void fd_cleanup_outgoing_migration(void)
-{
-    if (outgoing_args.fd > 0) {
-        close(outgoing_args.fd);
-        outgoing_args.fd = -1;
-    }
-}
-
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
-    int newfd;
-
     if (fd == -1) {
         return;
     }
@@ -62,18 +39,6 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    /*
-     * This is dup()ed just to avoid referencing an fd that might
-     * be already closed by the iochannel.
-     */
-    newfd = dup(fd);
-    if (newfd == -1) {
-        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
-        object_unref(ioc);
-        return;
-    }
-    outgoing_args.fd = newfd;
-
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
@@ -104,20 +69,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    if (migrate_multifd()) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            object_unref(ioc);
-            return;
-        }
-
-        file_create_incoming_channels(ioc, errp);
-    } else {
-        qio_channel_set_name(ioc, "migration-fd-incoming");
-        qio_channel_add_watch_full(ioc, G_IO_IN,
-                                   fd_accept_incoming_migration,
-                                   NULL, NULL,
-                                   g_main_context_get_thread_default());
-    }
+    qio_channel_set_name(ioc, "migration-fd-incoming");
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               fd_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
 }
diff --git a/migration/file.c b/migration/file.c
index b6e8ba13f2..ab18ba505a 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -11,7 +11,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
-#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
@@ -55,27 +54,15 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
-    bool ret = false;
-    int fd = fd_args_get_fd();
-
-    if (fd && fd != -1) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            goto out;
-        }
-
-        ioc = qio_channel_file_new_dupfd(fd, errp);
-    } else {
-        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-    }
+    bool ret = true;
 
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
     if (!ioc) {
+        ret = false;
         goto out;
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
-    ret = true;
 
 out:
     /*
diff --git a/migration/migration.c b/migration/migration.c
index f60bd371e3..047b6b49cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -140,10 +140,6 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
 
-        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            return migrate_mapped_ram();
-        }
-
         return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
                 saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
                 saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
@@ -165,15 +161,6 @@ static bool transport_supports_seeking(MigrationAddress *addr)
         return true;
     }
 
-    /*
-     * At this point QEMU has not yet fetched the fd passed in by the
-     * user, so we cannot know for sure whether it refers to a plain
-     * file or a socket. Let it through anyway and check at fd.c.
-     */
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
-    }
-
     return false;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0179422f6d..d2f0238f70 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,7 +18,6 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -794,7 +793,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
-    fd_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 71895abb7f..1d2cee87ea 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2536,13 +2536,6 @@ static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *migrate_fd_file_mapped_ram_start(QTestState *from, QTestState *to)
-{
-    migrate_mapped_ram_start(from, to);
-
-    return migrate_precopy_fd_file_start(from, to);
-}
-
 static void test_migrate_precopy_fd_file(void)
 {
     MigrateCommon args = {
@@ -2553,36 +2546,6 @@ static void test_migrate_precopy_fd_file(void)
     };
     test_file_common(&args, true);
 }
-
-static void test_migrate_precopy_fd_file_mapped_ram(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_fd_file_mapped_ram_start,
-        .finish_hook = test_migrate_fd_finish_hook
-    };
-    test_file_common(&args, true);
-}
-
-static void *migrate_multifd_fd_mapped_ram_start(QTestState *from,
-                                                QTestState *to)
-{
-    migrate_multifd_mapped_ram_start(from, to);
-    return migrate_precopy_fd_file_start(from, to);
-}
-
-static void test_multifd_fd_mapped_ram(void)
-{
-    MigrateCommon args = {
-        .connect_uri = "fd:fd-mig",
-        .listen_uri = "defer",
-        .start_hook = migrate_multifd_fd_mapped_ram_start,
-        .finish_hook = test_migrate_fd_finish_hook
-    };
-
-    test_file_common(&args, true);
-}
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
@@ -3687,10 +3650,6 @@ int main(int argc, char **argv)
                        test_multifd_file_mapped_ram);
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
-#ifndef _WIN32
-    migration_test_add("/migration/multifd/fd/mapped-ram",
-                       test_multifd_fd_mapped_ram);
-#endif
 
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
@@ -3753,8 +3712,6 @@ int main(int argc, char **argv)
                        test_migrate_precopy_fd_socket);
     migration_test_add("/migration/precopy/fd/file",
                        test_migrate_precopy_fd_file);
-    migration_test_add("/migration/precopy/fd/file/mapped-ram",
-                       test_migrate_precopy_fd_file_mapped_ram);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
-- 
2.44.0


