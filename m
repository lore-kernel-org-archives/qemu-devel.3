Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FC3C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFm-0001Pp-6S; Mon, 14 Jul 2025 19:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFj-0001Mo-GZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFh-0005LL-PR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJ3YEt/YPhvWK0BFPc8fFh+v9Ob5aI1Wiz/1EwMXPf0=;
 b=RIu6+2tmQg9ursQCt+jWT8UvqS2IdrmW/Efi+jRp8kfIltUhWaNQ7NEDgkJBqGz2LCOQXe
 ssezA96NFrqoBYmpPJPUXu3rI8gdj/9ML9L/STjP/2RFcAX8f28mtgUFyL8YDiVYjZW0IG
 7lxC4cOJh0475n8oBLKSlAKExyflnDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-U46maDlYPwS59Q5Oqj_A0A-1; Mon, 14 Jul 2025 19:06:26 -0400
X-MC-Unique: U46maDlYPwS59Q5Oqj_A0A-1
X-Mimecast-MFC-AGG-ID: U46maDlYPwS59Q5Oqj_A0A_1752534386
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1746163f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534385; x=1753139185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ3YEt/YPhvWK0BFPc8fFh+v9Ob5aI1Wiz/1EwMXPf0=;
 b=Y+dNs2D7Z4gYC3rwurfW79h3a4GbOszWDKGvRo8j5jBegcnxDuVh9wxnxwXj/VEQM7
 kinzdXT2lDPdF/MoR6HJ51I0u32haKsFNd2eOIxTqO9MGUX2Pi0nBMBVLgaPdVa62Jft
 AymJShBdp1tIhQ6fIc5fxSt7ZPqgOdLZ99yvwF7+EEuTl9SnsW+hMzkuvKSqREw+Aon1
 LGAbntjP6O3333y/1xxbuKHMbuTePjExeHrDgEmsp14jnlcdZMytFtxiF51DtR7WYhXC
 lmajvwUSP7EVWTbE0Iy3y5tswcIZNT75l2m4iGIlc15Z/o1vJOToUyEG257noDJDtwad
 W5Vg==
X-Gm-Message-State: AOJu0Yyg6++URXZGh+eVIvO7OvuC1XEAwErbFb5p6wc/D2VQ5fUj6L+S
 pWoGYW1vWzmNX6/oBO2mN+RI8m4shgtT7prLtrS9YHpZkoxo2G5Zr9t6g0IRfIcLNt4ZQjEkn2d
 6WveLx2iWufCVZlCYNaOX7HuCO6iUyt9lK0Zokm7qF1GHhZkJk8g1nrBXXJfs0xBzFb7hK6R/un
 X9O+htLw1H4XGJ9lSTvGwpdOScBKBPrFKjgg==
X-Gm-Gg: ASbGncsI9bYVmV61Ufvj3VKZJ1mkvHGay9kgMsi5Gi24hyUbfby3SHCn5j8tIs6iXKL
 5BbRgHQ37vQtCRMD2twkW2enSdkBZF3CHYsUgqnlKTojMUVDJjkDHAE6wAHVmHggXNe039eMOE1
 /ZseiXbCY3MX7OeaxIKiKIYIJjbJAzS38MNOqSA0TGeJcbgcLD92+RaIGQ8zQunG5snXg+DY3Cs
 /eGvDfpWSF1JBOYMmtdlwgm6Yf0lNxa6sdwpQtbgDYVISWO3lEM3y76jVAReSiMESq+lO4sfB4c
 V/+Mpgmx34BUWxki9K0aXxU1Vds2qgaL
X-Received: by 2002:a05:6000:5c2:b0:3a5:2b1d:7889 with SMTP id
 ffacd0b85a97d-3b5f2e26c9cmr10875892f8f.43.1752534385338; 
 Mon, 14 Jul 2025 16:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA+GJVX8NusqS7Z1fMd0srIeUPa2NuzT2baoV/1+lSaGfUOYqf7RAEclbBkc+XuIyahppaJw==
X-Received: by 2002:a05:6000:5c2:b0:3a5:2b1d:7889 with SMTP id
 ffacd0b85a97d-3b5f2e26c9cmr10875876f8f.43.1752534384916; 
 Mon, 14 Jul 2025 16:06:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1792sm13796067f8f.13.2025.07.14.16.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:24 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/97] virtio-net: Move virtio_net_get_features() down
Message-ID: <2deec9ab7d25d7cd8f57033bd0421c1f9f28d905.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Move virtio_net_get_features() to the later part of the file so that
it can call other functions.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-3-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 146 ++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eb93607b8c..34fe5909c5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -752,79 +752,6 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
-static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
-                                        Error **errp)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc = qemu_get_queue(n->nic);
-
-    /* Firstly sync all virtio-net possible supported features */
-    features |= n->host_features;
-
-    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
-
-    if (!peer_has_vnet_hdr(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-    }
-
-    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
-    }
-
-    if (!peer_has_uso(n)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-    }
-
-    if (!get_vhost_net(nc->peer)) {
-        return features;
-    }
-
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
-    vdev->backend_features = features;
-
-    if (n->mtu_bypass_backend &&
-            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
-        features |= (1ULL << VIRTIO_NET_F_MTU);
-    }
-
-    /*
-     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
-     * enabled. This happens in the vDPA case.
-     *
-     * Make sure the feature set is not incoherent, as the driver could refuse
-     * to start.
-     *
-     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
-     * helping guest to notify the new location with vDPA devices that does not
-     * support it.
-     */
-    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
-    }
-
-    return features;
-}
-
 static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
 {
     uint64_t features = 0;
@@ -3076,6 +3003,79 @@ static int virtio_net_pre_load_queues(VirtIODevice *vdev)
     return 0;
 }
 
+static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
+                                        Error **errp)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    /* Firstly sync all virtio-net possible supported features */
+    features |= n->host_features;
+
+    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+
+    if (!peer_has_vnet_hdr(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+    }
+
+    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
+    }
+
+    if (!peer_has_uso(n)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
+    }
+
+    if (!get_vhost_net(nc->peer)) {
+        return features;
+    }
+
+    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    }
+    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    vdev->backend_features = features;
+
+    if (n->mtu_bypass_backend &&
+            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+        features |= (1ULL << VIRTIO_NET_F_MTU);
+    }
+
+    /*
+     * Since GUEST_ANNOUNCE is emulated the feature bit could be set without
+     * enabled. This happens in the vDPA case.
+     *
+     * Make sure the feature set is not incoherent, as the driver could refuse
+     * to start.
+     *
+     * TODO: QEMU is able to emulate a CVQ just for guest_announce purposes,
+     * helping guest to notify the new location with vDPA devices that does not
+     * support it.
+     */
+    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_CTRL_VQ)) {
+        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
+    }
+
+    return features;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
-- 
MST


