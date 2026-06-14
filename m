Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F255CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAj-0000Ws-OQ; Sun, 14 Jun 2026 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAh-0000GD-Jl
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAf-0001rQ-Dg
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oN7X2D8NM/XDxALEaF70VOsTMgEaeaWJ0gRnytmbEO4=;
 b=aIJeXdY2N0PzxEpudnCA5k2Abfu2lf+CAIDgLZqbzory3GHBGkcJ9S1iKwv3HDxG1PmFnn
 QkrXt+TPNXQ702GuZbyolTm1MsbUzws3ghVcDDytQcm7X6pLmf2oc4lIb4lbtwugxGaOJU
 1Y7rL+QpbRHyt9NXPTfDkzkZUuiJbiw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-tdFi0nIVPGailSct3_ttzg-1; Sun, 14 Jun 2026 15:06:59 -0400
X-MC-Unique: tdFi0nIVPGailSct3_ttzg-1
X-Mimecast-MFC-AGG-ID: tdFi0nIVPGailSct3_ttzg_1781464018
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so25298815e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464018; x=1782068818; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oN7X2D8NM/XDxALEaF70VOsTMgEaeaWJ0gRnytmbEO4=;
 b=Ae9z2dwi3LLxIdXla8UVGvOtTgX0AfiK7PaQXld4Vo/CfCQxvuqZEgOJQ580yBy7lU
 7ip/Db73FPCJiTCq/PtF+rOizWS5qHdDR/SNyBUKOlv7fzXbwm6tHSZRAy+eXYTGqK91
 MfkDQrkIH1HKl4L8Li9ctlKPqPrG7vQNbSL9xaV54A/b5CpRBFkLv9Iqxp4JTWQ4ewnI
 OpJJLQdrT4oBuvECjO43zbbpKBUloXHv6Ybu2lXDYcS0s22HdxpKAJV/K+vjAqxxmGci
 /DX3iNJ5uiRp5rslNGyfA0TJsz3J8QpfIb8JJU5D5J53kjGyf75I/MC/EoOx4XisYA1C
 1KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464018; x=1782068818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oN7X2D8NM/XDxALEaF70VOsTMgEaeaWJ0gRnytmbEO4=;
 b=VF4VPGNh8FllKg/U7c2yHEM2ekKrHtLVSMzXZo5805DO/lZimgWKxkfeUQ2zOETc0m
 ZGUgQCG7ZVEqZxldMIDnSssepQKpAYqLk+flEjwu/o9btVz+z9YbDNWrTJWDR0Z3wLSO
 WG4jHe6s0MWNBSUbkZ5XH6QHm3SRbRmy3/xOQo4kXwgIc093gWpQFx/q3yloIdxV7w0U
 4+DHK8r0JwB3lTvKm7OHX0TMXu8x1V0LDNwg+4F3Q5TGFD4gaJpScWBrMf2PC0cNBwF9
 gCbvyz/1I4y2kr1oxKEMhYCSPZz361o7gUIuSpX+hwgPxA3ygg0yMFFInclMcA+EzF/V
 WFfw==
X-Gm-Message-State: AOJu0YzpTTrxylGExmg+xIe1rJ9PNG3dVJHXkTFebU+XQYgA4f6A2jtu
 g0kzB2MPcNQk2MRkYSqBeijt/x5XsWQAeH0XL83G0n55zKy3YuHeSZLGkHeES5gJI41A/EaKEEM
 20e/YcMpBkHCWu45MwO0DPaw5UIcZp6eAA357u1sMEYchCDyLyKpVTZUG5hE8q4mzV5IQTvmqD7
 Rmp/tnfWzJIeo2XHumhTkQirdcJFC8c+txDw==
X-Gm-Gg: Acq92OFYC81WN4tRdYDrLb/U8F/4VPJ0FzjOK4X4N9ALNEtrsJiNiOheJ7xo8emkTGE
 ie4yvuoKKZLR0j8dE4RdBAh7jsrCj85YGYGdXCnYPJ//oXInhGLRBNycg9IHBbT1hXnaABrdaKh
 0MiU54sWafkjM8cDquQJ5qC/tg88vQiO3K5XunWR2LlP9kGufhV+5+IkY+PsLYluuDC7YYg0ESE
 UeRwjtdku+YrPE5/dYe0GJ7fMDJDtGHHIymyjEuxcPywJUQaPQjkt3SmJoV//grA0DD63n1QNmu
 eLD3sVJLNgFUBQGIgvroxD9RDN1KkGCVNx2p/D4w1SbpnQVIcQVPRMnECmXRg5ZB2yd+SNfOLSt
 MTK2lCPH/9R76ZZAeRkYX0//us446ggXRgyzvZ6MyYjg=
X-Received: by 2002:a05:600c:2d47:b0:490:c2a2:b1d4 with SMTP id
 5b1f17b1804b1-4922011d635mr57204205e9.35.1781464017768; 
 Sun, 14 Jun 2026 12:06:57 -0700 (PDT)
X-Received: by 2002:a05:600c:2d47:b0:490:c2a2:b1d4 with SMTP id
 5b1f17b1804b1-4922011d635mr57203885e9.35.1781464017213; 
 Sun, 14 Jun 2026 12:06:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203dd0b9sm181808925e9.15.2026.06.14.12.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:56 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Lei Yang <leiyang@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 028/106] vhost: drop backend_features field
Message-ID: <1ee0bc0c9bf006a1ea9afeae67b6b7a0b57a4783.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This field is mostly unused and sometimes confusing. We even have
a TODO-like comment to drop it, the comment is removed in this commit.

The field is used to held VHOST_USER_F_PROTOCOL_FEATURES for vhost-user
and/or VHOST_NET_F_VIRTIO_NET_HDR for vhost-net (which may be
vhost-user-net). But we can simply recalculate these two flags in place
from hdev->features, and from net-client for VHOST_NET_F_VIRTIO_NET_HDR.

Note: removing field from x-query-virtio-status result is incompatible
change. We can do it because the command is unstable.

Cc: devel@lists.libvirt.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-3-vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c   |  1 -
 hw/net/vhost_net.c          | 26 ++++++++++++++------------
 hw/scsi/vhost-scsi.c        |  1 -
 hw/scsi/vhost-user-scsi.c   |  1 -
 hw/virtio/vdpa-dev.c        |  1 -
 hw/virtio/vhost-user.c      | 17 ++++++++---------
 hw/virtio/virtio-hmp-cmds.c |  2 --
 hw/virtio/virtio-qmp.c      |  4 ----
 include/hw/virtio/vhost.h   |  7 -------
 qapi/virtio.json            |  3 ---
 10 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e83677..dc99de0263 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -348,7 +348,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
 
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 25e9f1fd24..fda90e231e 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -52,8 +52,14 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
 
 void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
 {
-    virtio_features_copy(net->dev.acked_features_ex,
-                         net->dev.backend_features_ex);
+    virtio_features_clear(net->dev.acked_features_ex);
+    if (net->backend == -1) {
+        net->dev.acked_features =
+           net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES);
+    } else if (!qemu_has_vnet_hdr(net->nc)) {
+        net->dev.acked_features = 1ULL << VHOST_NET_F_VIRTIO_NET_HDR;
+    }
+
     vhost_ack_features_ex(&net->dev, net->feature_bits, features);
 }
 
@@ -258,12 +264,9 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
         if (r < 0) {
             goto fail;
         }
-        net->dev.backend_features = qemu_has_vnet_hdr(options->net_backend)
-            ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
         net->backend = r;
         net->dev.protocol_features = 0;
     } else {
-        virtio_features_clear(net->dev.backend_features_ex);
         net->dev.protocol_features = 0;
         net->backend = -1;
 
@@ -284,13 +287,12 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
             net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
 
-        if (virtio_features_andnot(missing_features,
-                                   net->dev.backend_features_ex,
-                                   net->dev.features_ex)) {
-            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
-                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
-            goto fail;
-        }
+        if (!qemu_has_vnet_hdr(options->net_backend) &&
+            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR))) {
+            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend\n",
+                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR));
+             goto fail;
+         }
     }
 
     /* Set sane init value. Override when guest acks. */
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 699863cc10..859888fdba 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -275,7 +275,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vqs = vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
                          VHOST_BACKEND_TYPE_KERNEL, 0, errp);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 3612897d4b..5070178dc2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -159,7 +159,6 @@ static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
     vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
     vsc->dev.vqs = s->vhost_vqs;
     vsc->dev.vq_index = 0;
-    vsc->dev.backend_features = 0;
 
     ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 4532d63653..06179e402e 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -104,7 +104,6 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
     v->dev.vqs = vqs;
     v->dev.vq_index = 0;
     v->dev.vq_index_end = v->dev.nvqs;
-    v->dev.backend_features = 0;
     v->started = false;
 
     ret = vhost_vdpa_get_iova_range(v->vhostfd, &iova_range);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 13c73e7b17..7ce17c5b2d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1465,14 +1465,15 @@ static int vhost_user_set_features(struct vhost_dev *dev,
     int ret;
 
     /*
-     * We need to include any extra backend only feature bits that
-     * might be needed by our device. Currently this includes the
-     * VHOST_USER_F_PROTOCOL_FEATURES bit for enabling protocol
-     * features.
+     * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
+     * specific.
      */
-    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES,
-                              features | dev->backend_features,
-                              log_enabled);
+    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+        features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+    }
+
+    ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
+                             log_enabled);
 
     if (virtio_has_feature(dev->protocol_features,
                            VHOST_USER_PROTOCOL_F_STATUS)) {
@@ -2192,8 +2193,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
         uint64_t protocol_features;
 
-        dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
-
         err = vhost_user_get_u64(dev, VHOST_USER_GET_PROTOCOL_FEATURES,
                                  &protocol_features);
         if (err < 0) {
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 1daae482d3..4bf9a3109d 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -176,8 +176,6 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
         hmp_virtio_dump_features(mon, s->vhost_dev->features);
         monitor_printf(mon, "    Acked features:\n");
         hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
-        monitor_printf(mon, "    Backend features:\n");
-        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
         monitor_printf(mon, "    Protocol features:\n");
         hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
     }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index f9cdca50d9..71717c56a4 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -710,8 +710,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
                                                  vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
                                                 vdev->host_features_ex);
-    status->backend_features = qmp_decode_features(vdev->device_id,
-                                                 vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
@@ -752,8 +750,6 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
             qmp_decode_features(vdev->device_id, hdev->features_ex);
         status->vhost_dev->acked_features =
             qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
-        status->vhost_dev->backend_features =
-            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
 
         status->vhost_dev->protocol_features =
             qmp_decode_protocols(hdev->protocol_features);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 3dfec5e15c..e139e05985 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -100,16 +100,9 @@ struct vhost_dev {
      *
      * @features: available features provided by the backend
      * @acked_features: final negotiated features with front-end driver
-     *
-     * @backend_features: this is used in a couple of places to either
-     * store VHOST_USER_F_PROTOCOL_FEATURES to apply to
-     * VHOST_USER_SET_FEATURES or VHOST_NET_F_VIRTIO_NET_HDR. Its
-     * future use should be discouraged and the variable retired as
-     * its easy to confuse with the VirtIO backend_features.
      */
     VIRTIO_DECLARE_FEATURES(features);
     VIRTIO_DECLARE_FEATURES(acked_features);
-    VIRTIO_DECLARE_FEATURES(backend_features);
 
     /**
      * @protocol_features: is the vhost-user only feature set by
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 09dd0e6d05..671f1ad793 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -85,8 +85,6 @@
 #
 # @acked-features: vhost_dev acked_features
 #
-# @backend-features: vhost_dev backend_features
-#
 # @protocol-features: vhost_dev protocol_features
 #
 # @max-queues: vhost_dev max_queues
@@ -106,7 +104,6 @@
             'vq-index': 'int',
             'features': 'VirtioDeviceFeatures',
             'acked-features': 'VirtioDeviceFeatures',
-            'backend-features': 'VirtioDeviceFeatures',
             'protocol-features': 'VhostDeviceProtocols',
             'max-queues': 'uint64',
             'backend-cap': 'uint64',
-- 
MST


