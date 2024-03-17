Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDBFC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaE-0002CX-9I; Sun, 17 Mar 2024 16:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaC-0002Bc-L1
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaA-0002ZJ-Ld
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMe8E26pD9FoMazJMsajFgDf38rg/H2KYQdjS+f1E6g=;
 b=BO59lIBzuqrttBXCPSTLliu6jIT50/L0tvTrjYqwHXNYi2R9Y9EDiuMXwX+m2GcJfnhjf2
 PI2iJNmkdG++LgjS6AgwYtSLi/ujScy9X8wZffJ6bPzBG43LZ37yvBszS7MMTe5/Ax/k4H
 plrVYLOQsCXNGlEZWc4M00AuvX7ch8g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-tPndS4gYMs6I4ry2Y1hqtA-1; Sun, 17 Mar 2024 16:58:11 -0400
X-MC-Unique: tPndS4gYMs6I4ry2Y1hqtA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78315f4f5c2so120640185a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709090; x=1711313890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMe8E26pD9FoMazJMsajFgDf38rg/H2KYQdjS+f1E6g=;
 b=soJpHYNzKy7skwi31ajMjwpBmHYyOHHRSSg1LtD7X/IGN6HCH0L3mJHwHOAmwAm+7f
 xh21ii5afYJmvByRbogrx5VsQi8Dso9gASIIytW4py+A7nh3/hxY+sJGE3ktsm1N7w6O
 5/mgcd0ornBPioh+/XglnRSfd+O99/bopafnWE837Rgea2Fh3cXmdZrLsQihxcTWn3TR
 A5LjMLySWcRLWwjkgD3G5Offrr+q+LXbORyrtRf9gC5KRVM0+CizEFpgDpc2WNKLHonm
 Fge2xttY2BowvicinAADIQFmnopQdWJjM0zRumgj6Aefzv3FjpjvMgruJKOZ0uatF4Ms
 V/9g==
X-Gm-Message-State: AOJu0YwmIpmLB7crE6oRh6Xs6Ok/UtpVEDBCymtkMPZQ8YsUwnMlLJh/
 DCsqwqtVnNfvaL5FeuWAx0oia4JSU7ARFjDKPSpPiLIIlKrGoUnkTsLooj6OH5v3us8Wn30NJuh
 vf0edkVb8lPkmBakjWis4crJ9/Easos36OrZvR03YriH94tD9GRYh+9U+5OA8b1UgxCLjvzy913
 YVFi8ACmchesmQDPuPbGWgh9gHwfubaLs9vg==
X-Received: by 2002:a05:6214:2b9d:b0:690:cdd5:ea47 with SMTP id
 kr29-20020a0562142b9d00b00690cdd5ea47mr12279967qvb.4.1710709090195; 
 Sun, 17 Mar 2024 13:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQZiv5gWBvvpDvr6dXloatQiTjUR7sercRv8Pl0iHMx9zO5+GpczT/N1BacS2YqQo79Iy5VQ==
X-Received: by 2002:a05:6214:2b9d:b0:690:cdd5:ea47 with SMTP id
 kr29-20020a0562142b9d00b00690cdd5ea47mr12279945qvb.4.1710709089781; 
 Sun, 17 Mar 2024 13:58:09 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:09 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/10] migration: Fix error handling after dup in file migration
Date: Sun, 17 Mar 2024 16:57:55 -0400
Message-ID: <20240317205803.361163-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The file migration code was allowing a possible -1 from a failed call
to dup() to propagate into the new QIOFileChannel::fd before checking
for validity. Coverity doesn't like that, possibly due to the the
lseek(-1, ...) call that would ensue before returning from the channel
creation routine.

Use the newly introduced qio_channel_file_dupfd() to properly check
the return of dup() before proceeding.

Fixes: CID 1539961
Fixes: CID 1539965
Fixes: CID 1539960
Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240311233335.17299-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c   |  9 ++++-----
 migration/file.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index d4ae72d132..4e2a63a73d 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -80,6 +80,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
+    QIOChannelFile *fioc;
     int fd = monitor_fd_param(monitor_cur(), fdname, errp);
     if (fd == -1) {
         return;
@@ -103,15 +104,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         int channels = migrate_multifd_channels();
 
         while (channels--) {
-            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
-
-            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
-                error_setg(errp, "Failed to duplicate fd %d", fd);
+            fioc = qio_channel_file_new_dupfd(fd, errp);
+            if (!fioc) {
                 return;
             }
 
             qio_channel_set_name(ioc, "migration-fd-incoming");
-            qio_channel_add_watch_full(ioc, G_IO_IN,
+            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
                                        fd_accept_incoming_migration,
                                        NULL, NULL,
                                        g_main_context_get_thread_default());
diff --git a/migration/file.c b/migration/file.c
index b0b963e0ce..e56c5eb0a5 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -58,12 +58,13 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     int fd = fd_args_get_fd();
 
     if (fd && fd != -1) {
-        ioc = qio_channel_file_new_fd(dup(fd));
+        ioc = qio_channel_file_new_dupfd(fd, errp);
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-        if (!ioc) {
-            goto out;
-        }
+    }
+
+    if (!ioc) {
+        goto out;
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
@@ -147,10 +148,9 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
                                    NULL, NULL,
                                    g_main_context_get_thread_default());
 
-        fioc = qio_channel_file_new_fd(dup(fioc->fd));
+        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
 
-        if (!fioc || fioc->fd == -1) {
-            error_setg(errp, "Error creating migration incoming channel");
+        if (!fioc) {
             break;
         }
     } while (++i < channels);
-- 
2.44.0


