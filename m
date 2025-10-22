Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303ACCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTu-0002vP-Fy; Wed, 22 Oct 2025 15:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTl-0002tY-3o
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTh-0001Yd-Tv
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UsHdXQwCwD7WP5y/WUYROrf5LFRHXxP7WcAGO6x+FI=;
 b=Or/ArdDmavQOj/RYY+sh+rjzoe1N2ljX014EBXXjgBgA9dwsPQEVD7aojLrBSldXm4TFJj
 N5KQa/5N7Nf1scp/UN/Rpmq7b+6QLnO+GYBTETzOpqXdmqmck4OXqyyPRvAguyGdljldvE
 vyDG8K0qyGNon6NKBXwM4FHFMIWqtG0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-amTWN4HsP5WYxQLqE10pOw-1; Wed, 22 Oct 2025 15:26:31 -0400
X-MC-Unique: amTWN4HsP5WYxQLqE10pOw-1
X-Mimecast-MFC-AGG-ID: amTWN4HsP5WYxQLqE10pOw_1761161191
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8b8db4a35so40414081cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161191; x=1761765991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UsHdXQwCwD7WP5y/WUYROrf5LFRHXxP7WcAGO6x+FI=;
 b=NeszA4chKrE+eCuePA+QNu/xGrUYA9gg1dwk6p2x5NH6iLQXbUUz4028B3tcBhx98J
 RO7kOQWe5Wk74YItQMaig40Ln/7wszGIOmTCNQ8CV7ZrKflHYQd59XU5cXeTskax2jR9
 fmlAR1giDrtRrN5QZa6M7mCIsQyF1qAytujBS2U9Ct92FQl8rZdpUXMt25VOCdf+RGpO
 em7HDT6LtQo2R8PkltLOdXelfo/j+aMf4454gJF0bxolhN4jTQCXm53yYT6a8Jpampf6
 LSzcGrORtXULCd8Ma/aNcUFJZbW4G9+dUupkEUkTTJUNCD6lg251mT38YOGmHcA1T2xB
 f2Gg==
X-Gm-Message-State: AOJu0YzZ+yK8HTTaV+4FyLcTFbPFU3VZHg3Impe8lVMZJLmGXYIpBGSW
 uAd+12dEqSPsfa9QNQm4lY7EbEdug1D6uvZYCmNxbABFg9RmyJ+fToGi3+ZFeIuKbPbR6YTtERm
 cNWtO63fYTIfcqmbW+h5RR+S/ASmwqB6DIXJZ9yid3ae/Cz5HDJegP4oNldNazK/F6GY8WlIcwq
 bGRmZ1JM144FSMMT1/I3JK6NuGSGBjsuYxADbVlg==
X-Gm-Gg: ASbGncvEie1enMBI+FVQpieRepWnvd8/7Nxcwd8+NxtsWkDfJtZIwCkhACGvIHIzJe0
 zJF5OsaOeota+HLJW9stYkmc/8t5ZdYpFy787DpaUi3VXmbP0QdPCumQYIntCUEi+MrmrBPvq4P
 oZJ7sO5rcS+pMhRLj3yjlHLIXcYoqEAui7SHC9TZFyX7+ZEgVp3HTJTbohaQpnO6uSi1Mfo0pHk
 2wx81D39uyLcj1iFBaQSFRmTUz46HiM96fOt6m9cv/kRFdl2EW9tEhnbRfVzh1felk/VgZHv4f5
 c7iXlV8Z+3PxxOgORc5x6fzPSQDIRwUuYydyTVLnAknj1ArvEOA/zVUF346ehAoC
X-Received: by 2002:a05:622a:1ccd:b0:4e8:a2aa:77c9 with SMTP id
 d75a77b69052e-4e8a2aa88aamr220367061cf.1.1761161190844; 
 Wed, 22 Oct 2025 12:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOV+yjiKv1OCk6ubza4PxjCziIxPWCkWWJLrLvCUjFUeH/dgGNuskUR34ENQD5xGL1oIlo8A==
X-Received: by 2002:a05:622a:1ccd:b0:4e8:a2aa:77c9 with SMTP id
 d75a77b69052e-4e8a2aa88aamr220366601cf.1.1761161190355; 
 Wed, 22 Oct 2025 12:26:30 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 09/13] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
Date: Wed, 22 Oct 2025 15:26:08 -0400
Message-ID: <20251022192612.2737648-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now after thread-ified dest VM load during precopy, we will always in a
thread context rather than within a coroutine.  We can remove this path
now.

Reviewed-by: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 90 ++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 3389f6448b..67119634d7 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,7 +29,6 @@
 #include "qemu/rcu.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
-#include "qemu/coroutine.h"
 #include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
@@ -1345,61 +1344,54 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
 {
     struct rdma_cm_event *cm_event;
 
-    if (qemu_in_coroutine()) {
-        yield_until_fd_readable(comp_channel->fd);
-    } else {
-        /* This is the source side, we're in a separate thread
-         * or destination prior to migration_fd_process_incoming()
-         * after postcopy, the destination also in a separate thread.
-         * we can't yield; so we have to poll the fd.
-         * But we need to be able to handle 'cancel' or an error
-         * without hanging forever.
-         */
-        while (!rdma->errored && !rdma->received_error) {
-            GPollFD pfds[2];
-            pfds[0].fd = comp_channel->fd;
-            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
-            pfds[0].revents = 0;
-
-            pfds[1].fd = rdma->channel->fd;
-            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
-            pfds[1].revents = 0;
-
-            /* 0.1s timeout, should be fine for a 'cancel' */
-            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
-            case 2:
-            case 1: /* fd active */
-                if (pfds[0].revents) {
-                    return 0;
-                }
+    /*
+     * This is the source or dest side, either during precopy or
+     * postcopy.  We're always in a separate thread when reaching here.
+     * Poll the fd.  We need to be able to handle 'cancel' or an error
+     * without hanging forever.
+     */
+    while (!rdma->errored && !rdma->received_error) {
+        GPollFD pfds[2];
+        pfds[0].fd = comp_channel->fd;
+        pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+        pfds[0].revents = 0;
+
+        pfds[1].fd = rdma->channel->fd;
+        pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+        pfds[1].revents = 0;
+
+        /* 0.1s timeout, should be fine for a 'cancel' */
+        switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
+        case 2:
+        case 1: /* fd active */
+            if (pfds[0].revents) {
+                return 0;
+            }
 
-                if (pfds[1].revents) {
-                    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
-                        return -1;
-                    }
+            if (pfds[1].revents) {
+                if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
+                    return -1;
+                }
 
-                    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
-                        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
-                        rdma_ack_cm_event(cm_event);
-                        return -1;
-                    }
+                if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
+                    cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                     rdma_ack_cm_event(cm_event);
+                    return -1;
                 }
-                break;
+                rdma_ack_cm_event(cm_event);
+            }
+            break;
 
-            case 0: /* Timeout, go around again */
-                break;
+        case 0: /* Timeout, go around again */
+            break;
 
-            default: /* Error of some type -
-                      * I don't trust errno from qemu_poll_ns
-                     */
-                return -1;
-            }
+        default: /* Error of some type - don't trust errno from qemu_poll_ns */
+            return -1;
+        }
 
-            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
-                /* Bail out and let the cancellation happen */
-                return -1;
-            }
+        if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
+            /* Bail out and let the cancellation happen */
+            return -1;
         }
     }
 
-- 
2.50.1


