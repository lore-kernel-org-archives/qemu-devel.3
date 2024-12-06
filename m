Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB94E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7P-0004Mt-Kp; Fri, 06 Dec 2024 17:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7L-0004LN-JB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7J-0002Py-Ie
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiMz2upzz1D7+xWewetQWKt2ho3rwd/SN8vyiWBwuro=;
 b=QpEy3mco1k06UxeHOV824/l9G8MsrdxCznacWvZ1AgQ9Kshnvse00j1g6R9lpcwHPcKOuB
 w42phwlwaPHMBvPUK4WGlwiKLjHhIcO51yUxvq0+RtPqKg7uXLgW5RcoqRJVx/BTCowjs2
 XWcICj00y+DxtYPwu9drLqvdhk9H6fY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-CY4YyscZOUS2lNNwcuQ38Q-1; Fri, 06 Dec 2024 17:48:05 -0500
X-MC-Unique: CY4YyscZOUS2lNNwcuQ38Q-1
X-Mimecast-MFC-AGG-ID: CY4YyscZOUS2lNNwcuQ38Q
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-841a9ae0f26so439060139f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525282; x=1734130082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiMz2upzz1D7+xWewetQWKt2ho3rwd/SN8vyiWBwuro=;
 b=rrQD/sEMJgq/UnMr/Wwrv26Hi4YeWAU8+Kc1MA2rSpnsu4cBiqrzkP6D/my3O+TBFJ
 NT++0PdPeYacrKWEEU3zyDGR15EQMdZyLvwX8e3+GpLNd0HlZLGHLPJ3V23Y7fbzNoL8
 u4UAGgNO4adNkwG7kQ/hzGdVd7R9ZuATxG0c5EKdB9FlqmV5+PT/UfM2yD1qvDqvaqXE
 fLb3W/eyPm6VQOlKLSDtUhdtRpP9YdRBncooyZWgb/3E7dssE3ZHlY0N0Uo9Y4zQz/BX
 4AriAyOIW6RWKsEQB/Y1bBxHeafGBNp3J5k/A0a17l0liAGVK39a1PfFXIrm+ud8xsLK
 6Mgw==
X-Gm-Message-State: AOJu0Yw2O0EiHZYNZyQ0q9ututoue4XHmrfvZiqG6eWnTiw980TWXH/0
 BI9sXGxguy+90kOTQPAMkiBbaEoxPf7jmxwLjAfjseoqCdU379pKzcQw1T667Xcehl8m/6D/BnT
 +WBFrfiaqXLXRmVJUbUTf3rpBF/X4FFFpgmnq+9WqL4MTDO6xqhaMtC7h5aCzOyX+9UdeS6wgq1
 SzwVm2O0dGPsE9Yjvwxm6fNuDI+D4INO1cyw==
X-Gm-Gg: ASbGncvSWi80ryZOD0ZcgvW5ijHAT3co0+SiGDOQwY0BcR3ISa5F+fpyuGcPIUe3ILe
 fGJ5kynlaD5Y08qD6HnnIzdypuJbNaHpuV29WuT8tNDRMP1OYBZ/3neIND+Mu2YpaDGoQ3QndHU
 LJdV2Irb/WNOzYkkkzggynTU0uzOxpZmCa+HeEZul0goUVI1Ly09n5YFiGXRGZzIlfiha+NBL+p
 /97DhoZCcuafC5KzZfg8C2ifuQE+GfUtiwT+2RzjgDGML4nPOcZypk3Bm8gGV++5vOlhN+2JOcB
 TiOgSUfy/FIcX3ZmWnMdMmktTw==
X-Received: by 2002:a6b:6511:0:b0:842:ff2d:c3de with SMTP id
 ca18e2360f4ac-8447e202021mr474457739f.1.1733525282209; 
 Fri, 06 Dec 2024 14:48:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE04HG0VbEh/zk6xrbNLHLo2XNM2REETbK76tzH4rQJR65Sy+I6zdMe4n4G2sODT8RGh4fzRA==
X-Received: by 2002:a6b:6511:0:b0:842:ff2d:c3de with SMTP id
 ca18e2360f4ac-8447e202021mr474455839f.1.1733525281878; 
 Fri, 06 Dec 2024 14:48:01 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 2/7] migration/multifd: Allow to sync with sender threads
 only
Date: Fri,  6 Dec 2024 17:47:50 -0500
Message-ID: <20241206224755.1108686-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Teach multifd_send_sync_main() to sync with threads only.

We already have such requests, which is when mapped-ram is enabled with
multifd.  In that case, no SYNC messages will be pushed to the stream when
multifd syncs the sender threads because there's no destination threads
waiting for that.  The whole point of the sync is to make sure all threads
finished their jobs.

So fundamentally we have a request to do the sync in different ways:

  - Either to sync the threads only,
  - Or to sync the threads but also with the destination side.

Mapped-ram did it already because of the use_packet check in the sync
handler of the sender thread.  It works.

However it may stop working when e.g. VFIO may start to reuse multifd
channels to push device states.  In that case VFIO has similar request on
"thread-only sync" however we can't check a flag because such sync request
can still come from RAM which needs the on-wire notifications.

Paving way for that by allowing the multifd_send_sync_main() to specify
what kind of sync the caller needs.  We can use it for mapped-ram already.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        | 23 ++++++++++++++++++++---
 migration/multifd-nocomp.c |  7 ++++++-
 migration/multifd.c        | 17 +++++++++++------
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..6493512305 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -19,6 +19,22 @@
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
 
+typedef enum {
+    /* No sync request */
+    MULTIFD_SYNC_NONE = 0,
+    /* Sync locally on the sender threads without pushing messages */
+    MULTIFD_SYNC_LOCAL,
+    /*
+     * Sync not only on the sender threads, but also push MULTIFD_FLAG_SYNC
+     * message to the wire for each iochannel (which is for a remote sync).
+     *
+     * When remote sync is used, need to be paired with a follow up
+     * RAM_SAVE_FLAG_EOS / RAM_SAVE_FLAG_MULTIFD_FLUSH message on the main
+     * channel.
+     */
+    MULTIFD_SYNC_ALL,
+} MultiFDSyncReq;
+
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 void multifd_send_channel_created(void);
@@ -28,7 +44,7 @@ void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(void);
+int multifd_send_sync_main(MultiFDSyncReq req);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
@@ -143,7 +159,7 @@ typedef struct {
     /* multifd flags for each packet */
     uint32_t flags;
     /*
-     * The sender thread has work to do if either of below boolean is set.
+     * The sender thread has work to do if either of below field is set.
      *
      * @pending_job:  a job is pending
      * @pending_sync: a sync request is pending
@@ -152,7 +168,8 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
-    bool pending_sync;
+    MultiFDSyncReq pending_sync;
+
     MultiFDSendData *data;
 
     /* thread local variables. No locking required */
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..219f9e58ef 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -345,6 +345,8 @@ retry:
 
 int multifd_ram_flush_and_sync(void)
 {
+    MultiFDSyncReq req;
+
     if (!migrate_multifd()) {
         return 0;
     }
@@ -356,7 +358,10 @@ int multifd_ram_flush_and_sync(void)
         }
     }
 
-    return multifd_send_sync_main();
+    /* File migrations only need to sync with threads */
+    req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
+
+    return multifd_send_sync_main(req);
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..7ecc3964ee 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -523,11 +523,13 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(void)
+int multifd_send_sync_main(MultiFDSyncReq req)
 {
     int i;
     bool flush_zero_copy;
 
+    assert(req != MULTIFD_SYNC_NONE);
+
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -543,8 +545,8 @@ int multifd_send_sync_main(void)
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
          */
-        assert(qatomic_read(&p->pending_sync) == false);
-        qatomic_set(&p->pending_sync, true);
+        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
+        qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -635,14 +637,17 @@ static void *multifd_send_thread(void *opaque)
              */
             qatomic_store_release(&p->pending_job, false);
         } else {
+            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
+
             /*
              * If not a normal job, must be a sync request.  Note that
              * pending_sync is a standalone flag (unlike pending_job), so
              * it doesn't require explicit memory barriers.
              */
-            assert(qatomic_read(&p->pending_sync));
+            assert(req != MULTIFD_SYNC_NONE);
 
-            if (use_packets) {
+            /* Only push the SYNC message if it involves a remote sync */
+            if (req == MULTIFD_SYNC_ALL) {
                 p->flags = MULTIFD_FLAG_SYNC;
                 multifd_send_fill_packet(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
@@ -654,7 +659,7 @@ static void *multifd_send_thread(void *opaque)
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             }
 
-            qatomic_set(&p->pending_sync, false);
+            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
             qemu_sem_post(&p->sem_sync);
         }
     }
-- 
2.47.0


