Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076A3C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 08:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYh0l-0008Ut-S9; Mon, 07 Jul 2025 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0f-0008Rp-To
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uYh0e-0007Np-AB
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751876131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I76yZiKaUMu4077l3joOwVu/AGYxDmVkJAii/GtwsNA=;
 b=MnXz91esoT/gOMDw8+zC4tJCEp4sbkI3jP4KzaNRhYRkdS46HwGsHXcI9+i1WtjIu2njt0
 tpvcNNtIeK6+OoxCSsKr9i/MH6ATI0K1bgk5pk5o+P9gFBSc3hJFq103z0WY6kg+C8RJr+
 8TQoOgNLQExjqmABLKfkAxrfgsw9GZg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-DUKsWn1UOm2S8Wh-TmNE-g-1; Mon,
 07 Jul 2025 04:15:29 -0400
X-MC-Unique: DUKsWn1UOm2S8Wh-TmNE-g-1
X-Mimecast-MFC-AGG-ID: DUKsWn1UOm2S8Wh-TmNE-g_1751876128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D2F0190FBC4; Mon,  7 Jul 2025 08:15:28 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A37F518046C3; Mon,  7 Jul 2025 08:15:23 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Weil <sw@weilnetz.de>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 03/11] vhost_net: Rename vhost_set_vring_enable() for
 clarity
Date: Mon,  7 Jul 2025 10:14:57 +0200
Message-ID: <20250707081505.127519-4-lvivier@redhat.com>
In-Reply-To: <20250707081505.127519-1-lvivier@redhat.com>
References: <20250707081505.127519-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This is a cosmetic change with no functional impact.

The function vhost_set_vring_enable() is specific to vhost_net and
is used outside of vhost_net.c (specifically, in
hw/net/virtio-net.c). To prevent confusion with other similarly named
vhost functions, such as the one found in cryptodev-vhost.c, it has
been renamed to vhost_net_set_vring_enable(). This clarifies that the
function belongs to the vhost_net module.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c | 2 +-
 hw/net/vhost_net.c      | 4 ++--
 hw/net/virtio-net.c     | 4 ++--
 include/net/vhost_net.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e4d..7bed0bf92b8e 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -101,7 +101,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     return 0;
 }
 
-int vhost_set_vring_enable(NetClientState *nc, int enable)
+int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 {
     return 0;
 }
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 891f235a0a6e..cb8705639787 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -551,7 +551,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 
         if (peer->vring_enable) {
             /* restore vring enable state */
-            r = vhost_set_vring_enable(peer, peer->vring_enable);
+            r = vhost_net_set_vring_enable(peer, peer->vring_enable);
 
             if (r < 0) {
                 goto err_guest_notifiers;
@@ -686,7 +686,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     return vhost_net;
 }
 
-int vhost_set_vring_enable(NetClientState *nc, int enable)
+int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 {
     VHostNetState *net = get_vhost_net(nc);
     const VhostOps *vhost_ops = net->dev.vhost_ops;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eb93607b8c76..b52660436273 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -697,7 +697,7 @@ static int peer_attach(VirtIONet *n, int index)
     }
 
     if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_set_vring_enable(nc->peer, 1);
+        vhost_net_set_vring_enable(nc->peer, 1);
     }
 
     if (nc->peer->info->type != NET_CLIENT_DRIVER_TAP) {
@@ -720,7 +720,7 @@ static int peer_detach(VirtIONet *n, int index)
     }
 
     if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_set_vring_enable(nc->peer, 0);
+        vhost_net_set_vring_enable(nc->peer, 0);
     }
 
     if (nc->peer->info->type !=  NET_CLIENT_DRIVER_TAP) {
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index c6a5361a2ae4..0f40049f3419 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -41,7 +41,7 @@ void vhost_net_config_mask(VHostNetState *net, VirtIODevice *dev, bool mask);
 int vhost_net_notify_migration_done(VHostNetState *net, char* mac_addr);
 VHostNetState *get_vhost_net(NetClientState *nc);
 
-int vhost_set_vring_enable(NetClientState * nc, int enable);
+int vhost_net_set_vring_enable(NetClientState *nc, int enable);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
-- 
2.49.0


