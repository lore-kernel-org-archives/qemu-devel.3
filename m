Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F1DC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIYe-0006nu-Ql; Tue, 23 Jul 2024 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYa-0006mr-Sm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYX-0001YK-2m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721752800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFVhOh7SmpXOJwo7bOzKTSdDE/PawzWv7qmTvXMjT7Y=;
 b=NYHd9rhX6ZqjlGL0UqR2LKRkEJZsh7lsfuZYfaz2u8euZP2XiLdJgv6cozJxA1D5FbAs1S
 EHOm951tLeqtXzmhNlpvhE4kl7pJyMlE7AHNj/phzTqqOBVZ88VKN6rQZdOE2VpCGwchUW
 7MNd9pDw995gkmCdZ+7joC3gNZMd0lc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-N2oKFPUoMJuIq-i84U-H_g-1; Tue, 23 Jul 2024 12:39:58 -0400
X-MC-Unique: N2oKFPUoMJuIq-i84U-H_g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so45690555e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721752795; x=1722357595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFVhOh7SmpXOJwo7bOzKTSdDE/PawzWv7qmTvXMjT7Y=;
 b=Ur5DxaUWRby3wRNXP/N3siZG665MVcuXTkdDpWRir1iTyQJOMypx3x8/MfijakMeaG
 ko8g4rlTMrZB3XFCdwRAkYab8T3JewB4uVXzNk6scw0aw+KprvsJg8408qbis6oHGiOt
 eJsMfFx+ggRlgm7++W155gDpbSpOl9W0sCC9cvqU/slkEIodPc/v+N6oQVNNzGMpaeus
 3rdsk8ZL4CPrwp0ldedUNeGN9q6mBnc9qc8TrWJjbGJtk+IL57NWmnPutiSZxjW7lrXK
 A8EYm//jlmGR033yG5Veacr67WioX93KQX3ZVDbS+fwYx5iGdcN3FzfyqkkFeF2vmnj3
 mP2Q==
X-Gm-Message-State: AOJu0YyJDI2PgU1D/aWQbs4X/vlVt+3N4ju/DqA6trCA19YES/6ZFrcn
 lDbp898og7RxEKoMWepQuaDPFFDT+003SF3MdlW22/b8PJaqY1i9Vb9lhslNQDlYeON56+Ukw1L
 yDFoUZiLSDm9HozHrf2gagnzV2Zr7ZM+w18lDHTqx8dq5en4aau0dKQKzQgkm8cCPycLVbRIz7b
 alnBS9nQ8pYceNg5L3qNMBChg1jG/iDPpR+w==
X-Received: by 2002:a05:600c:699b:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-427daa67f25mr63873865e9.36.1721752795430; 
 Tue, 23 Jul 2024 09:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJGMdeh6v3/qV/USaEeLJGGeIGF48IjFCcSgX5h8oN9unFj7+vqB7W4nGQQiKbe106MZ606A==
X-Received: by 2002:a05:600c:699b:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-427daa67f25mr63873675e9.36.1721752794857; 
 Tue, 23 Jul 2024 09:39:54 -0700 (PDT)
Received: from localhost
 (p200300cfd74b1cd04af1f18b763c5dac.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd0:4af1:f18b:763c:5dac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b24csm11973636f8f.25.2024.07.23.09.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 09:39:51 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 1/2] virtio: Allow .get_vhost() without vhost_started
Date: Tue, 23 Jul 2024 18:39:39 +0200
Message-ID: <20240723163941.48775-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723163941.48775-1-hreitz@redhat.com>
References: <20240723163941.48775-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/hw/virtio/virtio.h  |  1 +
 hw/display/vhost-user-gpu.c |  2 +-
 hw/net/virtio-net.c         | 19 +++++++++++++++++--
 hw/virtio/virtio-crypto.c   | 18 +++++++++++++++---
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7512afbc84..ff29088232 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -221,6 +221,7 @@ struct VirtioDeviceClass {
     int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
     bool (*primary_unplug_pending)(void *opaque);
+    /* May be called even when vdev->vhost_started is false */
     struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
     void (*toggle_device_iotlb)(VirtIODevice *vdev);
 };
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 63c64ddde6..5056ffd618 100644
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
index 8f30972708..874ed9c032 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3890,8 +3890,23 @@ static bool dev_unplug_pending(void *opaque)
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
index bbe8aa4b99..3296b7f219 100644
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
2.45.2


