Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113CBC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngS-0000Mu-J8; Mon, 11 Mar 2024 17:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngP-0000Hd-1z
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngN-0003zJ-7e
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gY4gtbDoA8vveGI24uQ86jfhBn09tzoZ4ceN3ir39E=;
 b=MDFSlCOQF9z60kA+6Sa9vYaS/9H2CJqxxhi6OfrmrVOql4NpwEN8duaW9A7BFYucAY9Iej
 4iTYlS6ydVtwv4XM5OEHY5iW8X6dDXQpYRz7EgBbIVlvKmJLdnEn5xFUEUe3XxRRVvj7/G
 9aCD2II327yeyLQlLaZihXr+UKxQ3no=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-_sh9AwjBODunqizGgXGRgw-1; Mon, 11 Mar 2024 17:59:41 -0400
X-MC-Unique: _sh9AwjBODunqizGgXGRgw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690ca03e758so5295386d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194380; x=1710799180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gY4gtbDoA8vveGI24uQ86jfhBn09tzoZ4ceN3ir39E=;
 b=C8grlHVqWKt9YYmCPzzkG98WipV3389YWRXI6cTAJw5Yub2T9IvMYFzp3gdoUHI7t5
 17IKGrw2YnRN9HS/yaeuh94ta4j0eGXzLmsRk950GCkxq3yAeWoQMP27dCb2awJiVs5x
 0hd0evfyXIT1UTa7rG9UHgwDqz4jG8KbK5Tg7oM+XDb/kraDpSxRxcFjb/k5mkRsAMrS
 mtVkwRp7e5Fr7R35sBfnMDWMdnI3oksBnV9Stx1RTJat2NMZuvdzEepWOpMdVvsxVmEL
 PzmeBQxY8bv8yksT3h6ot6Yzh0FTULM2GbCf6cvJZI7dFZyZXDOsXYf8yTn6NuS7ALSV
 Q+JA==
X-Gm-Message-State: AOJu0Ywl5Tx+R+IdVXnS/UMqtahqfo4a3rAMQeNMnZxZL7+6cdiR1npc
 vTT2ngUPckYGxNG6slsnd3DqT/yr3V0ruWz/oT01609Pzi3DkC3IXE90j9hIGXt59DhdpsH2wcG
 m5HCrV9q+ZEuc5yW/YQ10ECnvIqgJCAb4JGvE8SsiumEc1IWA+MHprZz/yulv+vypzD57BKVAW2
 iMgBt5slZIrt2pX5luUlJ8vnIz++daVkGyjw==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr136163qvo.3.1710194380647; 
 Mon, 11 Mar 2024 14:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEoPP1WYLLpSMeU65gKxwcLLjZB4e+v4jIzD/uZCNUkeigL46BBe4tSeANo//Kh9Dh3b3NyQ==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr136142qvo.3.1710194380149; 
 Mon, 11 Mar 2024 14:59:40 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:39 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/34] migration/multifd: Don't fsync when closing
 QIOChannelFile
Date: Mon, 11 Mar 2024 17:59:00 -0400
Message-ID: <20240311215925.40618-10-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Commit bc38feddeb ("io: fsync before closing a file channel") added a
fsync/fdatasync at the closing point of the QIOChannelFile to ensure
integrity of the migration stream in case of QEMU crash.

The decision to do the sync at qio_channel_close() was not the best
since that function runs in the main thread and the fsync can cause
QEMU to hang for several minutes, depending on the migration size and
disk speed.

To fix the hang, remove the fsync from qio_channel_file_close().

At this moment, the migration code is the only user of the fsync and
we're taking the tradeoff of not having a sync at all, leaving the
responsibility to the upper layers.

Fixes: bc38feddeb ("io: fsync before closing a file channel")
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240305195629.9922-1-farosas@suse.de
Link: https://lore.kernel.org/r/20240305174332.2553-1-farosas@suse.de
[peterx: add more comment to the qio_channel_close()]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst |  3 ++-
 io/channel-file.c             |  5 -----
 migration/multifd.c           | 28 +++++++++++++++++++---------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 8024275d6d..54385a23e5 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -44,7 +44,8 @@ over any transport.
 - file migration: do the migration using a file that is passed to QEMU
   by path. A file offset option is supported to allow a management
   application to add its own metadata to the start of the file without
-  QEMU interference.
+  QEMU interference. Note that QEMU does not flush cached file
+  data/metadata at the end of migration.
 
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
diff --git a/io/channel-file.c b/io/channel-file.c
index d4706fa592..a6ad7770c6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -242,11 +242,6 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (qemu_fdatasync(fioc->fd) < 0) {
-        error_setg_errno(errp, errno,
-                         "Unable to synchronize file data with storage device");
-        return -1;
-    }
     if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
diff --git a/migration/multifd.c b/migration/multifd.c
index d4a44da559..bf9d483f7a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -710,16 +710,26 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
         /*
-         * An explicit close() on the channel here is normally not
-         * required, but can be helpful for "file:" iochannels, where it
-         * will include fdatasync() to make sure the data is flushed to the
-         * disk backend.
+         * The object_unref() cannot guarantee the fd will always be
+         * released because finalize() of the iochannel is only
+         * triggered on the last reference and it's not guaranteed
+         * that we always hold the last refcount when reaching here.
          *
-         * The object_unref() cannot guarantee that because: (1) finalize()
-         * of the iochannel is only triggered on the last reference, and
-         * it's not guaranteed that we always hold the last refcount when
-         * reaching here, and, (2) even if finalize() is invoked, it only
-         * does a close(fd) without data flush.
+         * Closing the fd explicitly has the benefit that if there is any
+         * registered I/O handler callbacks on such fd, that will get a
+         * POLLNVAL event and will further trigger the cleanup to finally
+         * release the IOC.
+         *
+         * FIXME: It should logically be guaranteed that all multifd
+         * channels have no I/O handler callback registered when reaching
+         * here, because migration thread will wait for all multifd channel
+         * establishments to complete during setup.  Since
+         * migrate_fd_cleanup() will be scheduled in main thread too, all
+         * previous callbacks should guarantee to be completed when
+         * reaching here.  See multifd_send_state.channels_created and its
+         * usage.  In the future, we could replace this with an assert
+         * making sure we're the last reference, or simply drop it if above
+         * is more clear to be justified.
          */
         qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));
-- 
2.44.0


