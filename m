Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E89FC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7t-0005Cl-PS; Tue, 18 Aug 2026 01:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7s-0005BK-2l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7p-0003lp-Au
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so3667107b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029955; x=1787634755; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uI/bGUOPiZtgA7sRPmLikAJa60Bs+xkxXw4S9cHkhMQ=;
 b=CzDQY8sx/55smXoq5bI43yoaVEq+z+nfTZPvrNVdnbRDgL0KX8lVaeHQE49vUvl0h+
 SsnIFE8a14VW8PZLBLWtbxnT1z3m5RXEead2j/HsWCu2kU7awFclqyvoT5teJjoi+yDe
 wbUIsxnhTprqjycwQiMJMadvynHfCfxemJ51etBnEGMBZUK3dMa9LaS7hQHV9Woeij0N
 O2VsXQibzp5qqlzjR/cZMJjVGYke8PhsMq5T3NixZfUDaJzksLRwzm2MjbMkd4BodnWL
 ZqJK0g6cHK2/ewZlX03d2vVZR6frOPu3mYUg92mRibzEP2SdWgPDi2uH6hYBeJcWmnQU
 pQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029955; x=1787634755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uI/bGUOPiZtgA7sRPmLikAJa60Bs+xkxXw4S9cHkhMQ=;
 b=jGT5HsK1GmLrr4pMSR/FPQQBgP0ZXKYItYBkNGv+aUG3kZkAQagJh250F5CN7py9En
 QkwYqrXm1IghfoVXbhIANSLlU3/GWyqEIaMNnleEgCL8KshFCxwbeWF7AQLwRggo5BlH
 i+asbsuAtBTLzBycmKYwR4hawHsOFKkwuGXnSpsOjJj6NpDNFkDQnovy4p1eP4sYdmI0
 wh8Qg0T2dl7G+ZSEHXBNYLLQZ76dcT7fLyiCoHHEmI1PJL6flOoZN2FLZqU+1AeD6cze
 cL38Ldc/2zyNfbJs+HcC/KTATD9HU89aVSS3PThdqhp9E/OvaduAgu1JZOuUoccc1TiQ
 CvxQ==
X-Gm-Message-State: AOJu0YxYhWFSmIhMwhLn0Ll9FC7D70lX90HCkBHMkexxaLU1cQYtHJQE
 NqLTfuEXqfWj0NnB1RegTC2PGHMl9RIPJ+TefvmmVQZPUgMBb4RhjPKE
X-Gm-Gg: AR+sD100+QKVccP4h6FWPqnLx3B8boMzL0RnePsuAg0JAPmXodsfOFsHDtrze0uAcmt
 vwQlZLNJ50QD5yNccExo48vuGizxq++Za/NVJ2LSYQyvjQPdfZV7r/7Oz28qeM2chlq+hm2t9VD
 pe3O8Yvzwg2hjbn8L9K5N9v6swxCfDF9oQw2SptiJgkDtu0272sUDitkTGXWqwdTspYOgrV/s5o
 emuO8OgI7alfISKLtZ9JonULgannRaLOc9vV3XclyGaH/lhbS16+OHjwvtRi4Bu1ux8bvzwmZAG
 E1H0JHKT2SsbXRrFZiAHdVMygffVIO2SO2yrlNfGti7vHM2pI50M/c+L8PCx6BeKSvugMrF3lHe
 HtqyU7A0/fvL1qGBjUfFsP0RRmAe6yOmeb9bXKTwtdo1EgOi6o9Cxue+uKZ/Oy5NBYhMzQKpkVs
 atpJ/XKhUsDkQ/IyWh6Mpnm/EwpMqo3WHzcJcq4x1hV7Nm2rGLwmXxIqjLHLuq5kbiMFIAIpWn4
 +bM
X-Received: by 2002:a05:6a00:4193:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84fde1500e7mr32736377b3a.6.1787029955327; 
 Mon, 17 Aug 2026 22:12:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:34 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:21 -0700
Subject: [PATCH RFC v2 06/13] vhost-user: add memory_isolation to
 VhostUserState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-6-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=12563;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=CgCmodYY3hh2gpX/jaQuylcKS6MagmlBraNfgqmJ4X0=;
 b=wHHi3W9jMtEUW9xqnPHbGay0kwhnFDuOGxjd8uOeLr1jwuCApSV29JYjB+ly1riYUfkFEpDoC
 yXUW9FgBtIPAqjZ8C1cqJ7+5I4PQlz2AFXV6vjYBMLvMxGgYbRmx1ss
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42a.google.com
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

Add a memory_isolation bool to the VhostUserState struct. This
bool is set within vhost_user_init(), which takes a
memory_isolation bool as an argument.

Refactor all call locations of vhost_user_init to include the new
argument.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 backends/cryptodev-vhost-user.c     |  2 +-
 backends/vhost-user.c               |  4 ++--
 hw/block/vhost-user-blk.c           |  3 ++-
 hw/display/vhost-user-gpu.c         |  3 ++-
 hw/scsi/vhost-user-scsi.c           |  3 ++-
 hw/virtio/vhost-stub.c              |  3 ++-
 hw/virtio/vhost-user-base.c         |  3 ++-
 hw/virtio/vhost-user-fs.c           |  3 ++-
 hw/virtio/vhost-user-scmi.c         |  3 ++-
 hw/virtio/vhost-user-vsock.c        |  3 ++-
 hw/virtio/vhost-user.c              |  5 ++++-
 include/hw/virtio/vhost-user.h      |  6 +++++-
 include/system/vhost-user-backend.h |  3 ++-
 net/passt.c                         | 14 ++++++++++----
 net/vhost-user.c                    |  8 +++++---
 15 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cc478d9902..fa1f9b76d3 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -213,7 +213,7 @@ static void cryptodev_vhost_user_init(
         }
     }
 
-    if (!vhost_user_init(&s->vhost_user, &s->chr, errp)) {
+    if (!vhost_user_init(&s->vhost_user, &s->chr, false, errp)) {
         return;
     }
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 380d825023..470eba1775 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -22,13 +22,13 @@
 
 int
 vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
-                            unsigned nvqs, Error **errp)
+                            unsigned nvqs, bool memory_isolation, Error **errp)
 {
     int ret;
 
     assert(!b->vdev && vdev);
 
-    if (!vhost_user_init(&b->vhost_user, &b->chr, errp)) {
+    if (!vhost_user_init(&b->vhost_user, &b->chr, memory_isolation, errp)) {
         return -1;
     }
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2e5b3ae1b1..4640d7da04 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -505,7 +505,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!vhost_user_init(&s->vhost_user, &s->chardev, errp)) {
+    if (!vhost_user_init(&s->vhost_user, &s->chardev,
+                         false, errp)) {
         return;
     }
 
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index cd684d6363..6655585b43 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -663,7 +663,8 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(g);
 
     vhost_dev_set_config_notifier(&g->vhost->dev, &config_ops);
-    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, errp) < 0) {
+    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, false,
+                                    errp) < 0) {
         return;
     }
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc2..05bc788304 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -276,7 +276,8 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
+    if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev,
+                         false, errp)) {
         goto free_virtio;
     }
 
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 7321dc9210..d1e1075a31 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -12,7 +12,8 @@ unsigned int vhost_get_free_memslots(void)
     return UINT_MAX;
 }
 
-bool vhost_user_init(VhostUserState *user, CharFrontend *chr, Error **errp)
+bool vhost_user_init(VhostUserState *user, CharFrontend *chr,
+                     bool memory_isolation, Error **errp)
 {
     return false;
 }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 90bd2903db..c10851492a 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -317,7 +317,8 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         vub->vhost_user.supports_config = true;
     }
 
-    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
+    if (!vhost_user_init(&vub->vhost_user, &vub->chardev,
+                         false, errp)) {
         return;
     }
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 209993918a..34ccbdec10 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -238,7 +238,8 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) {
+    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev,
+                         false, errp)) {
         return;
     }
 
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 02dc088ea9..bd0ec64daf 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -244,7 +244,8 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
 
     vdev->host_features |= (1ULL << VIRTIO_SCMI_F_P2A_CHANNELS);
 
-    if (!vhost_user_init(&scmi->vhost_user, &scmi->chardev, errp)) {
+    if (!vhost_user_init(&scmi->vhost_user, &scmi->chardev,
+                         false, errp)) {
         return;
     }
 
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index c2cd376e73..44a90c76ad 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -106,7 +106,8 @@ static void vuv_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!vhost_user_init(&vsock->vhost_user, &vsock->conf.chardev, errp)) {
+    if (!vhost_user_init(&vsock->vhost_user, &vsock->conf.chardev,
+                         false, errp)) {
         return;
     }
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2881cec72d..1c003e4d9d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -3121,13 +3121,16 @@ static void vhost_user_state_destroy(gpointer data)
     vhost_user_host_notifier_remove(n, NULL, true);
 }
 
-bool vhost_user_init(VhostUserState *user, CharFrontend *chr, Error **errp)
+bool vhost_user_init(VhostUserState *user, CharFrontend *chr,
+                     bool memory_isolation,
+                     Error **errp)
 {
     if (user->chr) {
         error_setg(errp, "Cannot initialize vhost-user state");
         return false;
     }
     user->chr = chr;
+    user->memory_isolation = memory_isolation;
     user->memory_slots = 0;
     user->notifiers = g_ptr_array_new_full(VIRTIO_QUEUE_MAX / 4,
                                            &vhost_user_state_destroy);
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 06c360af18..0eca9b1668 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -66,6 +66,7 @@ typedef struct VhostUserHostNotifier {
  * @chr: the character backend for the socket
  * @notifiers: GPtrArray of @VhostUserHostnotifier
  * @memory_slots:
+ * @memory_isolation: determines whether data is shared or copied
  */
 typedef struct VhostUserState {
     CharFrontend *chr;
@@ -73,12 +74,14 @@ typedef struct VhostUserState {
     int memory_slots;
     bool supports_config;
     bool supports_inflight_migration;
+    bool memory_isolation;
 } VhostUserState;
 
 /**
  * vhost_user_init() - initialise shared vhost_user state
  * @user: allocated area for storing shared state
  * @chr: the chardev for the vhost socket
+ * @memory_isolation: restrict direct access to guest memory from back-end
  * @errp: error handle
  *
  * User can either directly g_new() space for the state or embed
@@ -87,7 +90,8 @@ typedef struct VhostUserState {
  *
  * Return: true on success, false on error while setting errp.
  */
-bool vhost_user_init(VhostUserState *user, CharFrontend *chr, Error **errp);
+bool vhost_user_init(VhostUserState *user, CharFrontend *chr,
+                     bool memory_isolation, Error **errp);
 
 /**
  * vhost_user_cleanup() - cleanup state
diff --git a/include/system/vhost-user-backend.h b/include/system/vhost-user-backend.h
index 3184c8e799..c23f689182 100644
--- a/include/system/vhost-user-backend.h
+++ b/include/system/vhost-user-backend.h
@@ -41,7 +41,8 @@ struct VhostUserBackend {
 };
 
 int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
-                                unsigned nvqs, Error **errp);
+                                unsigned nvqs, bool memory_isolation,
+                                Error **errp);
 void vhost_user_backend_start(VhostUserBackend *b);
 int vhost_user_backend_stop(VhostUserBackend *b);
 
diff --git a/net/passt.c b/net/passt.c
index 45440c399b..35ec6ad6de 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -433,7 +433,9 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
+static int net_passt_vhost_user_init(NetPasstState *s,
+                                     bool memory_isolation,
+                                     Error **errp)
 {
     Chardev *chr;
     int sv[2];
@@ -457,7 +459,8 @@ static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
 
     s->vhost_user = g_new0(struct VhostUserState, 1);
     if (!qemu_chr_fe_init(&s->vhost_chr, chr, errp) ||
-        !vhost_user_init(s->vhost_user, &s->vhost_chr, errp)) {
+        !vhost_user_init(s->vhost_user, &s->vhost_chr, memory_isolation,
+                         errp)) {
         goto err;
     }
 
@@ -487,7 +490,8 @@ err:
     return -1;
 }
 #else
-static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
+static int net_passt_vhost_user_init(NetPasstState *s, bool memory_isolation,
+                                     Error **errp)
 {
     error_setg(errp, "vhost-user support has not been built");
 
@@ -735,7 +739,9 @@ int net_init_passt(const Netdev *netdev, const char *name,
     s->pidfile = pidfile;
 
     if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
-        if (net_passt_vhost_user_init(s, errp) == -1) {
+        bool memory_isolation = false;
+
+        if (net_passt_vhost_user_init(s, memory_isolation, errp) == -1) {
             qemu_del_net_client(nc);
             return -1;
         }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2d0fc49b4d..b6ee9ed297 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -370,7 +370,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
 
 static int net_vhost_user_init(NetClientState *peer, const char *device,
                                const char *name, Chardev *chr,
-                               int queues)
+                               int queues, bool memory_isolation)
 {
     Error *err = NULL;
     NetClientState *nc, *nc0 = NULL;
@@ -390,7 +390,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
             nc0 = nc;
             s = DO_UPCAST(NetVhostUserState, nc, nc);
             if (!qemu_chr_fe_init(&s->chr, chr, &err) ||
-                !vhost_user_init(user, &s->chr, &err)) {
+                !vhost_user_init(user, &s->chr, memory_isolation, &err)) {
                 error_report_err(err);
                 goto err;
             }
@@ -459,6 +459,7 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
     int queues;
     const NetdevVhostUserOptions *vhost_user_opts;
     Chardev *chr;
+    bool memory_isolation = false;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VHOST_USER);
     vhost_user_opts = &netdev->u.vhost_user;
@@ -476,5 +477,6 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    return net_vhost_user_init(peer, "vhost_user", name, chr, queues);
+    return net_vhost_user_init(peer, "vhost_user", name, chr, queues,
+                               memory_isolation);
 }

-- 
2.43.0


