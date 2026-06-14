Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8517CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAr-000138-6X; Sun, 14 Jun 2026 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAn-0000tr-M8
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAl-0001uW-KD
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTRrNFoGzxxR5M/VZ/bnXQ71PiEMWMbPEG5ObNe6UPQ=;
 b=RLo9eZaLkYGXQyTSZuxu0yehOJOWfDDg0QKUCwPvYyCOWuapGGbWntPo7ieetXj/MWgptO
 VuXbzsZf0wvkg/QZOkKxuE/vw+ZUDCCCV3vyj+43Wgq9q1Eu79fSWKipfHN60vdxivKM1R
 3PW6jDb91tASQOJSH9ik0Dojrz010wk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-s2DhADtEPhaXDMF9whCzhQ-1; Sun, 14 Jun 2026 15:07:05 -0400
X-MC-Unique: s2DhADtEPhaXDMF9whCzhQ-1
X-Mimecast-MFC-AGG-ID: s2DhADtEPhaXDMF9whCzhQ_1781464025
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so7703165e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464024; x=1782068824; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OTRrNFoGzxxR5M/VZ/bnXQ71PiEMWMbPEG5ObNe6UPQ=;
 b=abUxcSKpdV/RriXm++fAK/IiwkYfVDw1p5tSqrW8tCR2FW3B7/TnDieJNOA8jHcVU3
 dwSHK4JZ22O9/ZD/2tlbUmr+mY/y/i4sqzWVrfBCaL3dkpSMraCDoa8ApLz1bLXwJE7n
 qtcF10xtFHhhHiw/8l27SZzzOvGQMuMsftWftXP5DQQdqpSHUfnxbbN6wBtd+TwHCEy8
 uO8GCOqw5A+7at06SJ9b8z+3rFn8QuA/d4d/mmTUxi5Pq5ha/++mXJ2yeu2CvDeTu1ri
 1dXbyjP/XFqbTOQBjgBCRjPZ0YhyTO0fINu3FlRMsyBVXz0qQJYVhoR4Jx6Ii6CK5KVz
 EaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464024; x=1782068824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTRrNFoGzxxR5M/VZ/bnXQ71PiEMWMbPEG5ObNe6UPQ=;
 b=dG5pzwiQOINEIbd+C9axHk6/qLo2Yad6O5v/clgCVmSjg1nBvX1bVIan0EY3UyFLof
 r07Ju9VPUgjov5q5b6ht7wJWWh7vxCG/FqMNmkVj0VXUlS5EGw1vab6g8D7Eo4lNqL5/
 Tyq6B7lUIdBtC3A8TGEGEkcPcVANCNBITsrh/8v69Oo9zz8pTwfksM0CaK47br/CQEdw
 kfpFIXnaOlwydxfLdOsP7MDvYva5MtWFNjFjchQJNfeaAIlofDLtee9Kw14n5oewoS1E
 eMzUp0iMelHBc+QMXQ66VGKJ4EOQDL5frqrEeTOOfAwQ6VyD/Ee17/LrJvQsBKKyRkxT
 Bh3g==
X-Gm-Message-State: AOJu0YzqdlLlSLc0i/REydqbkKq1nGvTFrkeVyBNB/PmHw0quNSH2vTQ
 eDYKU7+YBCm1tY7iMw3H0tBlDlHzf2PUUbnSkIK6kuB6Wgt1cZsohvSUS1uEaFlwJeLZIlFiqFa
 4vn9yC3pmtXhxkWQ/sqTwys10YHsHLZT/Bk+gWqoDF/oWDblafi9znBZKoK7EB51wzEoWuCMi4f
 ilEIGfBpif9xEFTukaj6i2oDkSxBajX/Gj3g==
X-Gm-Gg: Acq92OE+3iuf1EabKwAqO3zeh3ESmXUq4DmPYFwQVktd4F9OHBuwWq116FgzdI4BmWk
 Or9hj5gkCJ7Z+XiYfygMITyT96buV/sQDHTEyWBgxuMQiEjpfwf1VWFoqSMKggcBdY6XaLFnxu5
 +TsDQAOp5skfzILQQR6YnweMDeAuz3tZsn990UfhmkturmYYzggyJEtLRsPNVuFT9IixCJ25WSE
 o4fsJjHQ2Eh6aHOT2Rjf4WIIiyoJTC43Es+3tPke50K96XSsLjBKbwz/Y6oZi0gzOePjIkUnEX8
 7bQ5In2xbcP7LhLQa6gYV+bRPiU9Tf3fbDLfSJnP/uwb97WwQVAQZZ4Br5B/touh7XYgLhSLrKu
 bexYU4Feri/BiS1hlBHsmDE5OJBzAyp/XjExjG0RTRkw=
X-Received: by 2002:a05:600c:4595:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490ec4fb683mr146217615e9.20.1781464024415; 
 Sun, 14 Jun 2026 12:07:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4595:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490ec4fb683mr146217125e9.20.1781464023783; 
 Sun, 14 Jun 2026 12:07:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea94f5b0sm187757855e9.1.2026.06.14.12.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:02 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 030/106] vhost: move protocol_features to vhost_user
Message-ID: <f9a8f5812607b6076c0412439f1d569391131e33.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

As comment says: it's only for vhost-user. So, let's move it
to corresponding vhost backend realization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-5-vsementsov@yandex-team.ru>
---
 backends/cryptodev-vhost.c     |  1 -
 hw/block/vhost-user-blk.c      |  6 ++----
 hw/net/vhost_net.c             |  2 --
 hw/virtio/meson.build          |  1 +
 hw/virtio/vhost-user-stub.c    |  6 ++++++
 hw/virtio/vhost-user.c         | 36 +++++++++++++++++++++++++++-------
 hw/virtio/virtio-qmp.c         |  6 ++++--
 include/hw/virtio/vhost-user.h |  4 ++++
 include/hw/virtio/vhost.h      |  8 --------
 9 files changed, 46 insertions(+), 24 deletions(-)
 create mode 100644 hw/virtio/vhost-user-stub.c

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index abdfce33af..c6069f4e5b 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -60,7 +60,6 @@ cryptodev_vhost_init(
 
     crypto->cc = options->cc;
 
-    crypto->dev.protocol_features = 0;
     crypto->backend = -1;
 
     /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index dc99de0263..2831f3c053 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -572,10 +572,8 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
 {
     struct VHostUserBlk *s = opaque;
 
-    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
-                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-
-    return inflight_migration;
+    return vhost_user_has_protocol_feature(
+        &s->dev, VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
 }
 
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fda90e231e..ca19983126 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -265,9 +265,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             goto fail;
         }
         net->backend = r;
-        net->dev.protocol_features = 0;
     } else {
-        net->dev.protocol_features = 0;
         net->backend = -1;
 
         /* vhost-user needs vq_index to initiate a specific queue pair */
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index e0566a60de..0ea89d8af4 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -94,6 +94,7 @@ system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 stub_ss.add(files('vhost-stub.c'))
+stub_ss.add(files('vhost-user-stub.c'))
 stub_ss.add(files('virtio-stub.c'))
 stub_ss.add(files('virtio-md-stubs.c'))
 
diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
new file mode 100644
index 0000000000..45559788dd
--- /dev/null
+++ b/hw/virtio/vhost-user-stub.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user.h"
+
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+}
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 72aeed26ca..fc2ed1f17e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-dmabuf.h"
+#include "hw/virtio/virtio-qmp.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
@@ -259,6 +260,14 @@ struct vhost_user {
     /* Our current regions */
     int num_shadow_regions;
     struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
+
+    /**
+     * @protocol_features: the vhost-user protocol feature set by
+     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
+     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
+     * by the backend (see @features).
+     */
+    uint64_t protocol_features;
 };
 
 struct scrub_regions {
@@ -267,10 +276,13 @@ struct scrub_regions {
     int fd_idx;
 };
 
-static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
-                                            uint64_t feature)
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
 {
-    return virtio_has_feature(dev->protocol_features, feature);
+    struct vhost_user *u = dev->opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    return virtio_has_feature(u->protocol_features, feature);
 }
 
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
@@ -1338,8 +1350,8 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
     int ret;
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     VhostUserMsg msg = {
         .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2239,8 +2251,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* final set of protocol features */
-        dev->protocol_features = protocol_features;
-        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
+        u->protocol_features = protocol_features;
+        err = vhost_user_set_protocol_features(dev, u->protocol_features);
         if (err < 0) {
             error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
             return -EPROTO;
@@ -3033,6 +3045,16 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+    struct vhost_user *u = dev->opaque;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    status->vhost_dev->protocol_features =
+        qmp_decode_protocols(u->protocol_features);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 71717c56a4..c8bf702d38 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -751,12 +751,14 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
 
-        status->vhost_dev->protocol_features =
-            qmp_decode_protocols(hdev->protocol_features);
         status->vhost_dev->max_queues = hdev->max_queues;
         status->vhost_dev->backend_cap = hdev->backend_cap;
         status->vhost_dev->log_enabled = hdev->log_enabled;
         status->vhost_dev->log_size = hdev->log_size;
+
+        if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER) {
+            vhost_user_qmp_status(hdev, status);
+        }
     }
 
     return status;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 53fe996686..0e576fc538 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -10,6 +10,7 @@
 
 #include "chardev/char-fe.h"
 #include "hw/virtio/virtio.h"
+#include "qapi/qapi-types-virtio.h"
 
 enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
@@ -113,4 +114,7 @@ void vhost_user_async_close(DeviceState *d,
                             CharFrontend *chardev, struct vhost_dev *vhost,
                             vu_async_close_fn cb);
 
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature);
+
 #endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index e139e05985..4a9bd3effe 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -104,14 +104,6 @@ struct vhost_dev {
     VIRTIO_DECLARE_FEATURES(features);
     VIRTIO_DECLARE_FEATURES(acked_features);
 
-    /**
-     * @protocol_features: is the vhost-user only feature set by
-     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
-     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
-     * by the backend (see @features).
-     */
-    uint64_t protocol_features;
-
     uint64_t max_queues;
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
-- 
MST


