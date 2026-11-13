Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446E606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+BI5oxo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYl-0000gQ-JJ; Fri, 13 Nov 2026 04:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYk-0000g8-Dy
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYi-00061D-DD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:27:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso4084745ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562019; x=1795166819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pxyUXo7Ru3xt0fI3PgpJjhvzJDljlv7M0kkgJXI2bac=;
 b=r+BI5oxoOjSWXzr1nEVDSS8HIk/Pl3YHsZuTd2uJloPMYzI5TAkNgKcn58XImAk0rZ
 UwZ3QN4GFUXwijwIsx2JY/HWFG4agt1CTzEBNvDQU5xOft2FdK1pwZFlw9JwjcPSd+kM
 dzyaT9dMJbtt8qggX+seMhD0g1LU+Y6kdDdWKikoLW/Mp6AimMcKd3P7ao/fo+rZtMXv
 dHK5A140b1Tbe9XKC8b1rjAz9KiyKAd4FyaWjoTjt1FjzRzg3VR2hgg0ncdi1BFVHAGX
 CuJXII/jywerSSbP+SKkKch6Ny7iZM8TN0fswFLv/lN2FigmTAmhd+EBHUrNBp0UGNXU
 u7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562019; x=1795166819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pxyUXo7Ru3xt0fI3PgpJjhvzJDljlv7M0kkgJXI2bac=;
 b=hXwLtuwdQIVbxBxU4TOe4KtA+k/Eb+n1k+s+Wr+7HWR0sFMORuueMQzLUnJYH/nzuz
 6AwPSkie49zeHQmblTJdNg77ti3krPu6rowVlwcOaaaoQq1rTYekBKtBJB5lfAHPg2Na
 lJqKm5DE0KuaT177bc0BdL30e8ipbz+0lFI9Gtf4RYORLG6x+7I2TkGmx5UD3O0/PqHX
 nJtHMmI3uVP8gY05MzhjsQ9CqcOultfffFLxga0J3Lc2R7NuCNQBIGnMERvyid21orbu
 /SrJHmlIeURdwu9vQdNj5uidMDAY9Fmjyb1UdcEzZjrpw5fnW5u+hxXMnaQFCPBLbc2T
 saCQ==
X-Gm-Message-State: APuU4Z94steVuH5dVuEvN0AB4DOTT6nJwzANHgEPIXZxlUAa+b//Mlik
 fjNeHIB3XsnA5FQHEkPrwZ6gBbygniVf7UzqvHdZF0EBPqmVuKmDSts7K4bHpaK5
X-Gm-Gg: AYBFou2oZ8zwSPXI40GNB72tg4RSlcmvRLRmkXz/5igZX9Xqh3puc6fjQg6YUs00yTK
 AnvS8md67czC/IpUD8ZGDRzOWN1up5CFG8kXfVGgNx2jpDHIfAqgiTUeBzy/A5J1pfFze8zgA6/
 O/kifQkVXqqydq7tkxKdiFpTuOdU5JYw2FEmrwrpBJtdk2ItNezoSYYIiLVhzJcCN+16R6sF7cD
 iY5wUR6MBhSrMAzG1YJyP+9DIsR+wy7wZiCl9s0gqRzCWpBXUP202mHZiz+ZeaHaeSiIHKobRkf
 hdHoAeZ6Yz/aRCYffKjCzuZfDHCelWPuleZOqgLAuZrUP374WiUdy/z+vH4+mnqlDBybE9lasFR
 qhCD5dTIIAn0JLGTLvg077Ro59WFH56BGX9Q6bF84cT9aIVfNqEHwKYdKU0wgk/0zyo17q7YeHM
 yFadN3DjsLoKEWL9nwQOcwLiHdPQID6VpTPhV4XciWkD7HNO43AEHBY4Ky6or4OMhFs8T6ncSX8
 aOb38dgmLuU2rtwHYiIXBteTwPFmAFBheYQZ+McADc/DViU3KO+4D7aAhydC5W6YBYrHeQdXwbh
 WKWDgbxYpVW4XrnQ8X7aJwba2SHytyJrBBGUem7hyRw9M/GUEwX/y5wPEEw=
X-Received: by 2002:a17:902:ef0b:b0:2ed:1e82:ab81 with SMTP id
 d9443c01a7336-2ee0dc97d44mr18202275ad.57.1794562018922; 
 Fri, 13 Nov 2026 01:26:58 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:58 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 09/14] vfio-user/proxy: Update tracking iothread users
 with device QOM paths
Date: Fri, 13 Nov 2026 17:26:00 +0800
Message-ID: <20261113092605.942292-10-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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
index c749ff149f..d0760defdd 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -279,7 +279,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     memset(&addr, 0, sizeof(addr));
     addr.type = SOCKET_ADDRESS_TYPE_UNIX;
     addr.u.q_unix.path = (char *)sock_name;
-    proxy = vfio_user_connect_dev(&addr, errp);
+    proxy = vfio_user_connect_dev(&addr, OBJECT(pdev), errp);
     if (!proxy) {
         return;
     }
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index ba29085321..c104a3a6b3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -917,7 +917,8 @@ vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Object *owner,
+                                   Error **errp)
 {
     VFIOUserProxy *proxy;
     QIOChannelSocket *sioc;
@@ -942,6 +943,13 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
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
@@ -961,7 +969,8 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
+                                                &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -993,6 +1002,10 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
     int i;
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = proxy->qom_path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1047,6 +1060,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_unref_and_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
@@ -1057,6 +1072,7 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
         vfio_user_free_fds(proxy->region_fds[i]);
     }
 
+    g_free(proxy->qom_path);
     g_free(proxy->sockname);
     g_free(proxy);
 }
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 4b9834a436..5eade2f7f1 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -70,6 +70,7 @@ typedef struct VFIOUserProxy {
     uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
+    char *qom_path;
     QEMUBH *req_bh;
     bool async_ops;
     VFIOUserFDs *region_fds[VFIO_USER_MAX_REGIONS];
@@ -103,7 +104,8 @@ typedef struct VFIOUserProxy {
 
 typedef struct VFIODevice VFIODevice;
 
-VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Object *owner,
+                                   Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
-- 
2.53.0


