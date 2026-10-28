Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E062606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZ4jjTLO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzw3-0007G4-IT; Wed, 28 Oct 2026 05:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzw1-00079v-J1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvz-0006iG-R7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:27:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2eac4877accso2443345ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179622; x=1793784422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDLbm7e0Y1nuSgmu6jeUNW1v4Qmthty4+pDhPxrnq+c=;
 b=cZ4jjTLOmxnsS9W/AC5FyMo0kVxwR5LZvjlgysjZM7r5pPJBr1lht/v/dDZxFKCBJe
 5U1Dv7RPJUfuZ+Kl5kwhfmh5TQSeSemagZ9/3RDNtSsZS+rao6g0kW4NHQtrnzja6vVN
 tQYyoviGFLLhaDO7iUDCQPu9X9rFJoMFAMmVVT6uDyb8pzwoCz2JvgG+1wIgJZsvkxMD
 FsmQazuEnu2bAPwopHnfvA9UnezYp8JqtEMNoxtwcoVmS1t8CHa6rnUXsrhUBYzeYcYl
 Fb8yYqoTkFRcdbpnbjWiNxunYuD3Hq0ekOA4TTO9J1RIAawMkrOc6jF0ru9ttBbttp8R
 d3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179622; x=1793784422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LDLbm7e0Y1nuSgmu6jeUNW1v4Qmthty4+pDhPxrnq+c=;
 b=gPi+H6wkT4iADs4lHmsS4P9FqzNkWznRA8CUFnhbTi9waIfUvfHaOJJh9PvsAerjFs
 Swrv/fqbzZB2Wdlqocp5L7mMzRMWkRg2TT5xI1itxDYeLqbVo11LePLlnP02fZNbWyM0
 iVVUDwjVL6AxmHq2+ltBkVXejg+DsWmcOXtITsNWNYeNls9px3mHUkdPai6+ue+hkJ2v
 B0uZaP9vaEq8CT8lhIU5SIscGcIB60LEv7KNZSECoUk9jIk5RKg/Jl5qfddSIPGHSWsb
 V3aNMPXxfysxhePWkiw7LyLIiNNrROq+cM210cyqh1S1nSnqLaZJlINpDdsbrndVRZNj
 Q4NA==
X-Gm-Message-State: AFq9FYI93JIoSH207Qyf6SOCEs4oYKr7gSQpJTPKPOlBDidGAT+/vCcp
 6uoulcykZqgLK0lJlufEU284WuwsnUnOaygQu5Ou/TKgmXRP+4NyUHkSYX75Apn1
X-Gm-Gg: AYBFou3LDUBsuT21xFCuuyOqNbyNStKiiyPNCMNclj08BfKg43CJ9B0CMAeIYIh2RoE
 IpGhlERELevQ0UEoSmLx7UOLTK9JX4bd5AeADYAMKspwYa+TJR1C++pqPc6NZkOuUnUdXIzylIU
 sEolbvxmUg4FLA2PKf5CxrOn5LW0V8V5SowqCHVAvMFXQCyZXlUYtPzAPOLxV9zF5NRztP5lD/t
 OXDeR53YPeR6Lh3ZCs6pYHKYPZ6tCQLQiM8YraosiLpjMJlNSW1u/CXIDgVWFt5TMfUNB7XDk9W
 AEml5O5Tbj9TyTfiUry4b3S7yDgcVhAuP3Feq+Nyf3DISoEMnKBExiWIktR+g3RkJqtD776d49m
 vsvG2gd8Kxu6bewDEiicwj7p6t67CbVsMkpYnhwAlIlExJpYK1VQMoVk3RbBOyKq5PGrTWkEzrU
 DfQz3gWIyHvtTNZQVIxgmWDdkFwmLa8Kov7k3j3Va4YzaFFN60mXdJjloLNsTyzJ9cCWUN4GipD
 1m3ZiFKNqw4BRlWYcJ4qxOqHXwsoOhKfLXtZfNf7Y6DFge/j+whiiBy/cY01iA4HDbmHYXZSehU
 HMz+6CINtuCvLAwUpZ2/ufxf/Ibz8KKbNyM4Ng8vqGpCKuoPbgDjfqK9Fic=
X-Received: by 2002:a17:902:ecc1:b0:2e6:13b1:e196 with SMTP id
 d9443c01a7336-2eb00577e95mr14035555ad.74.1793179622296; 
 Wed, 28 Oct 2026 02:27:02 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:27:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 09/14] vfio-user/proxy: Update tracking iothread users
 with device QOM paths
Date: Wed, 28 Oct 2026 17:26:14 +0800
Message-ID: <20261028092619.1654474-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the holder-aware AioContext APIs to track each proxy's reference
to the shared IOThread, using the owning PCI device's canonical QOM
path as the holder identity. Because the IOChannel has no QOM parent
and therefore cannot provide a canonical path.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/vfio-user/pci.c   |  2 +-
 hw/vfio-user/proxy.c | 20 ++++++++++++++++++--
 hw/vfio-user/proxy.h |  4 +++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 983e1d4ad4..59b18f4d11 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -278,7 +278,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     memset(&addr, 0, sizeof(addr));
     addr.type = SOCKET_ADDRESS_TYPE_UNIX;
     addr.u.q_unix.path = (char *)sock_name;
-    proxy = vfio_user_connect_dev(&addr, errp);
+    proxy = vfio_user_connect_dev(&addr, OBJECT(pdev), errp);
     if (!proxy) {
         return;
     }
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 197aee07bf..e48873c0fb 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -892,7 +892,8 @@ vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Object *owner,
+                                   Error **errp)
 {
     VFIOUserProxy *proxy;
     QIOChannelSocket *sioc;
@@ -917,6 +918,13 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    /* The device may be unparented before disconnect releases the holder. */
+    proxy->qom_path = object_get_canonical_path(owner);
+    assert(proxy->qom_path);
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = proxy->qom_path,
+    };
 
     /* init defaults */
     proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
@@ -936,7 +944,8 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
+                                                &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -967,6 +976,10 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = proxy->qom_path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,12 +1034,15 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_unref_and_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
         vfio_user_iothread = NULL;
     }
 
+    g_free(proxy->qom_path);
     g_free(proxy->sockname);
     g_free(proxy);
 }
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 7b97460cc5..dbdbcfabcb 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
+    char *qom_path;
     QEMUBH *req_bh;
     bool async_ops;
 
@@ -102,7 +103,8 @@ typedef struct VFIOUserProxy {
 
 typedef struct VFIODevice VFIODevice;
 
-VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Object *owner,
+                                   Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
-- 
2.53.0


