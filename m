Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94336EE49B8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOKF-0000p7-OY; Wed, 11 Sep 2024 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJR-00079d-Tr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJN-0003NJ-A1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5ePHMPfQwBzPpsGte/yR9q9ulk7hoKYYN7lCYMftAw=;
 b=hact8nxCQRbz/LW1pUfuNLnCNHF9q7LiOsihXR0nvrzY/Z408PCtPu0CQybB9TE45hxKaJ
 NUoTx6i+7SmLmSO8dR/0qV8g+edDBmK1krMe9bMcxEmZD/x+P1HpRAqDTKFa/QHMJaS5lg
 STXLN0UPv5sqhKECkCh1FMMsj8VfoOM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-BiHTkPcBPKySs71RUCzzFQ-1; Wed, 11 Sep 2024 09:51:32 -0400
X-MC-Unique: BiHTkPcBPKySs71RUCzzFQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a870f3a65a0so490938166b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062689; x=1726667489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5ePHMPfQwBzPpsGte/yR9q9ulk7hoKYYN7lCYMftAw=;
 b=sZOcBhElDOcYQociXdLEyLkJq8si2HMPuZf+B6Bsag9wFrMGYhJDKqDpvUe7INTi3Y
 O8dLBZtCLiDQl+ai/gGzmorI3j7QCasFWCb3I1a1kjdxg7eQ/N25mDQi6u2E48Y8wK/D
 +yGFbcc06wn7TorBCE+MRMLWN7f1AhgeDgwrhneO0QnVDrnuo9Rvgq5hzIaGmf3DMlvv
 r3TnZ9trUZ/aDJ/pxJRhBXimmdK1KDu7waMMrcOfXUcRbfKMofgcg+iLUjWeuSCXQfw9
 mqBaEKE4NkTcZSaG7I4Hi+ZEmsEbX/J1/8Sb5nXPvlilFt9k6YMoJb+J7ZVqs+pSq7X2
 NGQw==
X-Gm-Message-State: AOJu0YzVjuha4S+PI/Ygj+4qAz46ho8NxdThQYQSAy54hyKKpbdT3kr3
 uC7W9gCjA8nmr8l/ZD3soRiWDD//xZ3lsMGEiYSM1jv2Nn/ikUjw2GiNII+K+D7yI+mwwTT5vRA
 x6JIIjSVFzuCNJppKZ2pE4voeW3CJ1tfes+rtDxjjcqEy25cQI7MRNPULpCyUDstKigBKrPiFPn
 uZDmyVOvqG0kxSFEjNK+tc+dNZR25KnA==
X-Received: by 2002:a17:907:9487:b0:a86:7924:11bd with SMTP id
 a640c23a62f3a-a8ffad9d1a8mr452160566b.41.1726062689271; 
 Wed, 11 Sep 2024 06:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY+bWB+IztdPuwAyYLrFzsLbCvl61KtjpyJeZQfkrPuLoif8uHr5PqRAsy2azdqO7WXIAXmA==
X-Received: by 2002:a17:907:9487:b0:a86:7924:11bd with SMTP id
 a640c23a62f3a-a8ffad9d1a8mr452156966b.41.1726062688686; 
 Wed, 11 Sep 2024 06:51:28 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cec10asm613690266b.160.2024.09.11.06.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 01/18] virtio: Allow .get_vhost() without vhost_started
Message-ID: <00adced5c3166ee65b6880b48c1e0826b7304f76.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

Historically, .get_vhost() was probably only called when
vdev->vhost_started is true.  However, we now decidedly want to call it
also when vhost_started is false, specifically so we can issue a reset
to the vhost back-end while device operation is stopped.

Some .get_vhost() implementations dereference some pointers (or return
offsets from them) that are probably guaranteed to be non-NULL when
vhost_started is true, but not necessarily otherwise.  This patch makes
all such implementations check all such pointers, returning NULL if any
is NULL.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20240723163941.48775-2-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h  |  1 +
 hw/display/vhost-user-gpu.c |  2 +-
 hw/net/virtio-net.c         | 19 +++++++++++++++++--
 hw/virtio/virtio-crypto.c   | 18 +++++++++++++++---
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0fcbc5c0c6..f526ecc8fc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -223,6 +223,7 @@ struct VirtioDeviceClass {
     int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
     bool (*primary_unplug_pending)(void *opaque);
+    /* May be called even when vdev->vhost_started is false */
     struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
     void (*toggle_device_iotlb)(VirtIODevice *vdev);
 };
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index c0c66910f1..14548f1a57 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -642,7 +642,7 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
 static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 {
     VhostUserGPU *g = VHOST_USER_GPU(vdev);
-    return &g->vhost->dev;
+    return g->vhost ? &g->vhost->dev : NULL;
 }
 
 static Property vhost_user_gpu_properties[] = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ed33a32877..fb84d142ee 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3896,8 +3896,23 @@ static bool dev_unplug_pending(void *opaque)
 static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc = qemu_get_queue(n->nic);
-    struct vhost_net *net = get_vhost_net(nc->peer);
+    NetClientState *nc;
+    struct vhost_net *net;
+
+    if (!n->nic) {
+        return NULL;
+    }
+
+    nc = qemu_get_queue(n->nic);
+    if (!nc) {
+        return NULL;
+    }
+
+    net = get_vhost_net(nc->peer);
+    if (!net) {
+        return NULL;
+    }
+
     return &net->dev;
 }
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 5034768bff..0793f56965 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1247,9 +1247,21 @@ static bool virtio_crypto_guest_notifier_pending(VirtIODevice *vdev, int idx)
 static struct vhost_dev *virtio_crypto_get_vhost(VirtIODevice *vdev)
 {
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
-    CryptoDevBackend *b = vcrypto->cryptodev;
-    CryptoDevBackendClient *cc = b->conf.peers.ccs[0];
-    CryptoDevBackendVhost *vhost_crypto = cryptodev_get_vhost(cc, b, 0);
+    CryptoDevBackend *b;
+    CryptoDevBackendClient *cc;
+    CryptoDevBackendVhost *vhost_crypto;
+
+    b = vcrypto->cryptodev;
+    if (!b) {
+        return NULL;
+    }
+
+    cc = b->conf.peers.ccs[0];
+    vhost_crypto = cryptodev_get_vhost(cc, b, 0);
+    if (!vhost_crypto) {
+        return NULL;
+    }
+
     return &vhost_crypto->dev;
 }
 
-- 
MST


