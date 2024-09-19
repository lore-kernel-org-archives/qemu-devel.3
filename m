Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F06CDD560
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 00:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4bG-0007rT-MN; Wed, 18 Sep 2024 20:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4bD-0007qJ-PS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 20:00:44 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sr4bB-0004I3-7b
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 20:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=kOKUXySs4KdiNi+Z17+VJGaI7YhOtS5E1WabpUoRFZE=; b=jSFUk5JdfWKJMFgO
 IikdpJ4DTjUYntMlXxuw5+EPGOyimLW9W4C9sy1t6oH7QNSekOHLnkLnpZpT00x4zGhpImvSDDwQZ
 L3KPBUTHu/Q6zj5s3TVgM0d7rrR88sj/JD0ZFRkPiSalVGTfZ2mY3cLHKN5AFgOCRxFl8/kV3Y8nq
 hx2Y5sppCCUgR+8AprFOM3zcwsibqtWPhT/YYuP6p/gjNHdj6QZAspw/txpYyBVmqOD0DDE8zqu31
 j7SA+jnGOBwiPu1uEG5jB0kBeTUKWnlZhxttbpGAsRXpGXBMAmRiDj+EW1+hgo4I+AE2YHrKLi0XY
 r/KApxvDNAIAF/d3zA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sr4b8-006M4N-0q;
 Thu, 19 Sep 2024 00:00:38 +0000
From: dave@treblig.org
To: berrange@redhat.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] io/channel-socket: Remove unused
 qio_channel_socket_dgram_async
Date: Thu, 19 Sep 2024 01:00:34 +0100
Message-ID: <20240919000034.485744-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

qio_channel_socket_dgram_async has been unused since it was originally
added in 2015.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/io/channel-socket.h | 29 --------------------
 io/channel-socket.c         | 54 -------------------------------------
 io/trace-events             |  1 -
 3 files changed, 84 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d38..6c858cc6b5 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -182,35 +182,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
                                   SocketAddress *remoteAddr,
                                   Error **errp);
 
-/**
- * qio_channel_socket_dgram_async:
- * @ioc: the socket channel object
- * @localAddr: the address to local bind address
- * @remoteAddr: the address to remote peer address
- * @callback: the function to invoke on completion
- * @opaque: user data to pass to @callback
- * @destroy: the function to free @opaque
- * @context: the context to run the async task. If %NULL, the default
- *           context will be used.
- *
- * Attempt to initialize a datagram socket bound to
- * @localAddr and communicating with peer @remoteAddr.
- * This method will run in the background so the caller
- * will regain execution control immediately. The function
- * @callback will be invoked on completion or failure.
- * The @localAddr and @remoteAddr parameters will be copied,
- * so may be freed as soon as this function returns without
- * waiting for completion.
- */
-void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddress *localAddr,
-                                    SocketAddress *remoteAddr,
-                                    QIOTaskFunc callback,
-                                    gpointer opaque,
-                                    GDestroyNotify destroy,
-                                    GMainContext *context);
-
-
 /**
  * qio_channel_socket_get_local_address:
  * @ioc: the socket channel object
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..2282e7a549 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -319,60 +319,6 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
 }
 
 
-struct QIOChannelSocketDGramWorkerData {
-    SocketAddress *localAddr;
-    SocketAddress *remoteAddr;
-};
-
-
-static void qio_channel_socket_dgram_worker_free(gpointer opaque)
-{
-    struct QIOChannelSocketDGramWorkerData *data = opaque;
-    qapi_free_SocketAddress(data->localAddr);
-    qapi_free_SocketAddress(data->remoteAddr);
-    g_free(data);
-}
-
-static void qio_channel_socket_dgram_worker(QIOTask *task,
-                                            gpointer opaque)
-{
-    QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    struct QIOChannelSocketDGramWorkerData *data = opaque;
-    Error *err = NULL;
-
-    /* socket_dgram() blocks in DNS lookups, so we must use a thread */
-    qio_channel_socket_dgram_sync(ioc, data->localAddr,
-                                  data->remoteAddr, &err);
-
-    qio_task_set_error(task, err);
-}
-
-
-void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddress *localAddr,
-                                    SocketAddress *remoteAddr,
-                                    QIOTaskFunc callback,
-                                    gpointer opaque,
-                                    GDestroyNotify destroy,
-                                    GMainContext *context)
-{
-    QIOTask *task = qio_task_new(
-        OBJECT(ioc), callback, opaque, destroy);
-    struct QIOChannelSocketDGramWorkerData *data = g_new0(
-        struct QIOChannelSocketDGramWorkerData, 1);
-
-    data->localAddr = QAPI_CLONE(SocketAddress, localAddr);
-    data->remoteAddr = QAPI_CLONE(SocketAddress, remoteAddr);
-
-    trace_qio_channel_socket_dgram_async(ioc, localAddr, remoteAddr);
-    qio_task_run_in_thread(task,
-                           qio_channel_socket_dgram_worker,
-                           data,
-                           qio_channel_socket_dgram_worker_free,
-                           context);
-}
-
-
 QIOChannelSocket *
 qio_channel_socket_accept(QIOChannelSocket *ioc,
                           Error **errp)
diff --git a/io/trace-events b/io/trace-events
index d4c0f84a9a..5d0d4358db 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -25,7 +25,6 @@ qio_channel_socket_listen_async(void *ioc, void *addr, int num) "Socket listen a
 qio_channel_socket_listen_fail(void *ioc) "Socket listen fail ioc=%p"
 qio_channel_socket_listen_complete(void *ioc, int fd) "Socket listen complete ioc=%p fd=%d"
 qio_channel_socket_dgram_sync(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram sync ioc=%p localAddr=%p remoteAddr=%p"
-qio_channel_socket_dgram_async(void *ioc, void *localAddr, void *remoteAddr) "Socket dgram async ioc=%p localAddr=%p remoteAddr=%p"
 qio_channel_socket_dgram_fail(void *ioc) "Socket dgram fail ioc=%p"
 qio_channel_socket_dgram_complete(void *ioc, int fd) "Socket dgram complete ioc=%p fd=%d"
 qio_channel_socket_accept(void *ioc) "Socket accept start ioc=%p"
-- 
2.46.0


