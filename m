Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10FBC54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaM-0002Fr-RW; Sun, 17 Mar 2024 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaK-0002FL-5P
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaI-0002dq-A5
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jCIs6kDNXpzb96UsCwUy6eatdgo/oXMCneO7owVbBs=;
 b=PcJeXUiFKbC49nFinmG7R0D7vS1y2z5DL0cbGbEhFrt9R7SpNp5UQJ/dzWzgz1BPs6Pk3K
 XdwNu/mIiuSQ+FvDLybOwL5FHDI4pRaoGlkhynSFlfkkKRjQB90+rvEwWVAEKNTqKhFGFo
 f6C1xjRO2vg/eU+UWgPkEip7W+jfSrk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Gjelsqd9MWS6lytSCIANbw-1; Sun, 17 Mar 2024 16:58:19 -0400
X-MC-Unique: Gjelsqd9MWS6lytSCIANbw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42f30752eb4so12381631cf.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709098; x=1711313898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jCIs6kDNXpzb96UsCwUy6eatdgo/oXMCneO7owVbBs=;
 b=bfYocP/UVh7fi1XtB7IYGtqbmnd/0XQHlBnmr8rqzTp0KYSWhWs5o/luOOozCzt6+F
 vY6SsQ8rd27jpfJhiNSQj496Y4acq0oQChvYev5CWHjmMvkdnpDIptbf/INwzI3hWoS6
 r7hM22G3o+LhILv7cpXE4rprXJVkkaQcUXgxM1E1jPFw4mS19kn6BYDywFsa7ojWBbFl
 TGLD0r0YBlPEYpx4ccdwvwlfrCf5R1wkl14D//gjPOcsDQy4TMxs2bc7Ih5l8Q1vq43G
 hyl79b+uZD0EZRDSQpSneZevT8JorqLqTXPJ8g1mRGZuXQNK0UVn5H8O6ohNWcGwV2GC
 2cVw==
X-Gm-Message-State: AOJu0Yw1eC7q2eYpqqUgz03NqwHQVZW8HSkAqc3c94Q1BPLLMINKCk04
 0cZknkXCoi+PQMKShtTYepSvtzljKP8GTTwWGDvY1WCO3Dazi+EH9G+VEGLmifI6WhI/2sSc1c8
 4sLj09S+D49Fk16TA6T2Hqu0QaWo15SX+uIo3dZaSAMDBLP6SZDjrWqERpQw7Ct8x4Xaro8AsYR
 xo3Rqd3vuF2P/MFjIW9lDdXakgsSdF0vph6w==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266759qvb.4.1710709098194; 
 Sun, 17 Mar 2024 13:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGveN+v5Zb66b+uDk4qKwUjcp2MUKH2M4q80bLOvJRperog77Y1+yzEgssHSoGLjB6kd+FdQg==
X-Received: by 2002:a05:6214:3d9a:b0:691:456f:415a with SMTP id
 om26-20020a0562143d9a00b00691456f415amr12266742qvb.4.1710709097729; 
 Sun, 17 Mar 2024 13:58:17 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:17 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/10] migration: Fix iocs leaks during file and fd migration
Date: Sun, 17 Mar 2024 16:58:01 -0400
Message-ID: <20240317205803.361163-9-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The memory for the io channels is being leaked in three different ways
during file migration:

1) if the offset check fails we never drop the ioc reference;

2) we allocate an extra channel for no reason;

3) if multifd is enabled but channel creation fails when calling
   dup(), we leave the previous channels around along with the glib
   polling;

Fix all issues by restructuring the code to first allocate the
channels and only register the watches when all channels have been
created.

For multifd, the file and fd migrations can share code because both
are backed by a QIOChannelFile. For the non-multifd case, the fd needs
to be separate because it is backed by a QIOChannelSocket.

Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240313212824.16974-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.h |  1 +
 migration/fd.c   | 29 +++++++-----------------
 migration/file.c | 58 ++++++++++++++++++++++++++++++------------------
 3 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/migration/file.h b/migration/file.h
index 9f71e87f74..7699c04677 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -20,6 +20,7 @@ void file_start_outgoing_migration(MigrationState *s,
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
+void file_create_incoming_channels(QIOChannel *ioc, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/fd.c b/migration/fd.c
index 4e2a63a73d..39a52e5c90 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
+#include "file.h"
 #include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-file.h"
@@ -80,7 +81,6 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
-    QIOChannelFile *fioc;
     int fd = monitor_fd_param(monitor_cur(), fdname, errp);
     if (fd == -1) {
         return;
@@ -94,26 +94,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    qio_channel_set_name(ioc, "migration-fd-incoming");
-    qio_channel_add_watch_full(ioc, G_IO_IN,
-                               fd_accept_incoming_migration,
-                               NULL, NULL,
-                               g_main_context_get_thread_default());
-
     if (migrate_multifd()) {
-        int channels = migrate_multifd_channels();
-
-        while (channels--) {
-            fioc = qio_channel_file_new_dupfd(fd, errp);
-            if (!fioc) {
-                return;
-            }
-
-            qio_channel_set_name(ioc, "migration-fd-incoming");
-            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
-                                       fd_accept_incoming_migration,
-                                       NULL, NULL,
-                                       g_main_context_get_thread_default());
-        }
+        file_create_incoming_channels(ioc, errp);
+    } else {
+        qio_channel_set_name(ioc, "migration-fd-incoming");
+        qio_channel_add_watch_full(ioc, G_IO_IN,
+                                   fd_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
     }
 }
diff --git a/migration/file.c b/migration/file.c
index e56c5eb0a5..ddde0ca818 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -115,13 +115,46 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
+void file_create_incoming_channels(QIOChannel *ioc, Error **errp)
+{
+    int i, fd, channels = 1;
+    g_autofree QIOChannel **iocs = NULL;
+
+    if (migrate_multifd()) {
+        channels += migrate_multifd_channels();
+    }
+
+    iocs = g_new0(QIOChannel *, channels);
+    fd = QIO_CHANNEL_FILE(ioc)->fd;
+    iocs[0] = ioc;
+
+    for (i = 1; i < channels; i++) {
+        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
+
+        if (!fioc) {
+            while (i) {
+                object_unref(iocs[--i]);
+            }
+            return;
+        }
+
+        iocs[i] = QIO_CHANNEL(fioc);
+    }
+
+    for (i = 0; i < channels; i++) {
+        qio_channel_set_name(iocs[i], "migration-file-incoming");
+        qio_channel_add_watch_full(iocs[i], G_IO_IN,
+                                   file_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
+    }
+}
+
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 {
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
-    int channels = 1;
-    int i = 0;
 
     trace_migration_file_incoming(filename);
 
@@ -132,28 +165,11 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 
     if (offset &&
         qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
+        object_unref(OBJECT(fioc));
         return;
     }
 
-    if (migrate_multifd()) {
-        channels += migrate_multifd_channels();
-    }
-
-    do {
-        QIOChannel *ioc = QIO_CHANNEL(fioc);
-
-        qio_channel_set_name(ioc, "migration-file-incoming");
-        qio_channel_add_watch_full(ioc, G_IO_IN,
-                                   file_accept_incoming_migration,
-                                   NULL, NULL,
-                                   g_main_context_get_thread_default());
-
-        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
-
-        if (!fioc) {
-            break;
-        }
-    } while (++i < channels);
+    file_create_incoming_channels(QIO_CHANNEL(fioc), errp);
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
-- 
2.44.0


