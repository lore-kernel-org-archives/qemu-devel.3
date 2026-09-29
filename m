Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E215CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSV-0005rS-Hv; Tue, 29 Sep 2026 04:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSM-0005pU-EO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:45:00 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTSK-0003oy-RF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:58 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso3167812a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671495; x=1791276295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LaoH3WqcUPD5qd54Je+ZT9uQvS4DmV/3LHGVO+3n+k8=;
 b=Qf9CLcV0Eg8AetHImnv6sSJtOmbXtHG4oz5AF/Wp11Lx0LwYIvQ+FkdqCKPnm5PT1M
 vpqs9RXKBohkGtrwicbWBbFhFwRDOfXZ4Vr9yJQGtLMA46QKwLQ9jbK5QoYq2EobEFTz
 TvqwSM+A99kxCZxPNVlb9YNAcR6xyi3om/a5eRf2S6JAPCLqUFLdv5uxQFAmoeoZcQzt
 ybS9hLQ5ozesOOzq+0DEFhCoYDvKEs6a1NSjLgrkjDBOGKhI/h8LqtMblQom7EQKPgBQ
 ceTJ3RfcOBOSMHIFsjHWqY7SkopIE4JLbM+ZHjdyqA8uUAbg2RZ3QHh4EDY5rb+OjZPZ
 ghtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671495; x=1791276295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LaoH3WqcUPD5qd54Je+ZT9uQvS4DmV/3LHGVO+3n+k8=;
 b=lR6b0Hh9MPUArkxtxLXpdrGJnw0XWEGlWtJgfSU+pxK+ruVgs8cuTa0P629AxOcsou
 G1wT4mADO505EADZUcwcgbiFx3xZC15e6v4tjCW1PCW9GpwYsVgN1Et+qR5Na7hp9hc1
 s6kMOtJ53f6udcln44b2BQgkiUYAQ6fxgUdZHXOEHTypaerBV2ifbYH5dZN7HES6sKbu
 HOfqj+bHJCIV/8afbzYA5MTxmgGp1vz2TjLi/s3BOnDeZPrf8zRXFVpJX1rYjuIeTe88
 tQcgs0e8iJ9fpvzzUv/pCa/LSFtb/A7nJnYYCZHYDA+JQ3EornwIG7LpKNlCgsSuxxqf
 j6eA==
X-Gm-Message-State: AFq9FYKMm9IU3QEr9o3BU9Atsh4m+dARW8hoDlz1TwRk91nlV2rVTL8w
 SNrX0bNpUN6UwVPFIk152t+5XerkkwAsBAR9HpV9m26mGELe8MJ30e/+WNaaXuVz
X-Gm-Gg: AYBFou09F/jx2IEgECpQ3QAyGAcqGmmU39JO/bfkB7XpPp7yPzM0BKf0GD4jPLgROhp
 UAu4Uage8UMQCh0bQz7TNg3mK4HLFbxfmRiwGooQ6dOqoK+FFifb7bJgqNgmhR0SiZP/K+/wG0H
 Sef5TMs1cxGj8BAxdd0L6g1amXgY/vZHv7SCDTzmyco2zFmWr+1W7alxAjH81yrmDVPIqZMV0L7
 AWPQ2R/qbCCMHhiJTpkSGLbVGiJwtMvsRFob6sBT2W3eLqyHgfkxFiAwPQCxOQBVYmwWtVHTEzK
 1ISaYze2FbdfUycbV3kKEAk0v5skTENB2iyQ0ztShseyK9TdKLhGRY/TthQZEsMULk+ourRJ+Yz
 OiSA2uMzgNT5ns3BLS3B1egXO1wVVWhqaxUznXkVTXtJKsv76xV/XgLlfuSlh/hI8Vr2wZ0uTAn
 3Cud65i+Y/l9TqSrdJz/NQXW2CsRPU5ndsomzUf26nRWxVGar3G1ZXnRI11Rj/HB37zYJYObd9i
 W8vV1/UGMFLGe33Xhxp87gQbNCzOZluWAKEXg==
X-Received: by 2002:a17:90b:1f8a:b0:39e:6a82:afda with SMTP id
 98e67ed59e1d1-3a098fe651cmr11916434a91.44.1790671495499; 
 Tue, 29 Sep 2026 01:44:55 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:54 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 09/13] vfio-user/proxy: Update tracking iothread users
 with device QOM paths
Date: Tue, 29 Sep 2026 16:44:12 +0800
Message-ID: <20260929084416.1600199-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the holder-aware AioContext APIs to track each proxy's reference
to the shared IOThread, using the owning PCI device's canonical QOM
path as the holder identity. Because the IOChannel has no QOM parent
and therefore cannot provide a canonical path.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/pci.c   |  2 +-
 hw/vfio-user/proxy.c | 20 ++++++++++++++++++--
 hw/vfio-user/proxy.h |  4 +++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e7573d4a9f..126dfdc897 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -273,7 +273,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
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
2.43.0


