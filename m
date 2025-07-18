Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E243AC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uckpd-0006fT-RG; Fri, 18 Jul 2025 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uckjH-0000LK-K9
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uckjE-0000kY-Dp
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752843737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDaLYbnpfQ3JG+RJIs3oiMgRO10m0C9vhrJxQmt8tw0=;
 b=A3DcTME/aljNGhmEmWlgtsiOxRB8a8z7iYOqorV0P0uKuzpIUGgY6cFf/rpEdX68/OqBS0
 QwSZni3anlrxxlPnl1zg4v+ex344EIX2d4rGo8P3qFNeuqTkSPt10MsMBRkwl3qxpgbLek
 Ls+MwOIoW8KWvNtJBdZ2xuQ/Q+JdLJ8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1yLKR-IqNuW2zYVPnRSZhg-1; Fri, 18 Jul 2025 09:02:09 -0400
X-MC-Unique: 1yLKR-IqNuW2zYVPnRSZhg-1
X-Mimecast-MFC-AGG-ID: 1yLKR-IqNuW2zYVPnRSZhg_1752843729
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-403317cd1ffso835626b6e.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 06:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752843729; x=1753448529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDaLYbnpfQ3JG+RJIs3oiMgRO10m0C9vhrJxQmt8tw0=;
 b=VroKySGaf0jt2373qObJRsNyKaojzdy/Oh2/vYLAekpLAD61wij5sOSskRK6FdwPBj
 hWLTYPTbGcs4YQM9UCkWEEFBnUfFqBoW9gwpMtlO7XSSNtLXVFQJA4W5h55d0CH+vLyg
 rmuDxRVhXB39wGSwdfqs0TE+UU6nMaJJWEM1ZD9LcxexOdfA4xrULilRylT2zxV7sajq
 D2mLFfeKHoTo4d8zXfIso8RLgTehNtNfyPic8CtCN98goTnbEln18t1IZ2UlfbJG5LPH
 jiQcJhkVKOUL0L06iTGXL6mLPpimSqkHHiRo5ySwlZdwIqIunqtwO2wfQbmjajxErAw8
 Pd2w==
X-Gm-Message-State: AOJu0YwSCQjRQb01Fb9xQw6fA1R6JVSs/mnk0FjLKA/vktslJicQ6TFd
 3KS67/mbqwKauPzkKT9JoOAprQG27vxfA+xWPg6y/huKuuMytWi+uhCPrTDt94GOnqwvyuMcHYB
 BWQVvISQomqtdbkEMIofdM7WbTcF4bCbg9keltLan/6m8TWObvckaVCiP
X-Gm-Gg: ASbGnctyJTyjIBB7H8IovJX9eXheunB9JSj/80tQ2PKm5OqVvTiqrncm2K6RGaiYp90
 mjJDyXuMhsckRgKOrd/rl8Pq9zXcuUDYRWAK6RgGW8T/5reVGcvJBs1fuIHEiv7shvA2i3HZQ3g
 +FyAfaTg8Z9iH1M9dNC8C4WRLF/AYtgWRidSnQxhYN8gWfeW5xix1FdH2I7UCOUs57wrif23otj
 0+7mg6sMiZOAsTcmigCepn7s+Sa2AtQQcMA5kCMS0Q2woZOkzmOguNaWtyVMgMVBLlBk/M6HAFQ
 z0MQesu5gg9q+OB2vga9/sqk485zhrlaZNTLZv5ArspPRJfM8FAScL66ICrUvJjmOHbyt4McVNY
 vW+o6OC7QglONZGk=
X-Received: by 2002:a05:6808:1807:b0:40b:9948:f2a9 with SMTP id
 5614622812f47-41cee084e3cmr5748675b6e.11.1752843728338; 
 Fri, 18 Jul 2025 06:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxKOJq2S7I3maLnz67HJ3NnZcutQlRzt/TptFqk7AuF2hJTF2QwZaLYs9Al5JAzmqkSVnyEg==
X-Received: by 2002:a05:6808:1807:b0:40b:9948:f2a9 with SMTP id
 5614622812f47-41cee084e3cmr5748583b6e.11.1752843727488; 
 Fri, 18 Jul 2025 06:02:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b28289sm81691985a.16.2025.07.18.06.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 06:02:06 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:01:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 10/13] vhost-net: implement extended features
 support
Message-ID: <zdfxqwsj7bmx6dfoxticifa2max3rkqhhoor5mjxfy7xcj7tys@6hwveszzsbua>
References: <cover.1752828082.git.pabeni@redhat.com>
 <083cd54b7ee4909fdedbf5c9128e60563469057e.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <083cd54b7ee4909fdedbf5c9128e60563469057e.1752828082.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 18, 2025 at 10:52:36AM +0200, Paolo Abeni wrote:
>Provide extended version of the features manipulation helpers,
>and let the device initialization deal with the full features space,
>adjusting the relevant format strings accordingly.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v2 -> v3:
>  - use virtio_features_andnot return value instead of virtio_features_empty
>  - rebased on top of "net: Consolidate vhost feature bits into vhost_net
>    structure"
>  - _array -> _ex
>
>v1 -> v2:
>  - uint128_t -> uint64_t[]
>  - provide extended variant of the features manipulation helpers
>---
> hw/net/vhost_net-stub.c |  8 +++----
> hw/net/vhost_net.c      | 46 ++++++++++++++++++++++-------------------
> include/net/vhost_net.h | 33 ++++++++++++++++++++++++++---
> 3 files changed, 58 insertions(+), 29 deletions(-)
>
>diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>index 7d49f82906..0740d5a2eb 100644
>--- a/hw/net/vhost_net-stub.c
>+++ b/hw/net/vhost_net-stub.c
>@@ -46,9 +46,8 @@ void vhost_net_cleanup(struct vhost_net *net)
> {
> }
>
>-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
>+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
> {
>-    return features;
> }
>
> int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>@@ -62,13 +61,12 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>     return 0;
> }
>
>-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
>+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
> {
> }
>
>-uint64_t vhost_net_get_acked_features(VHostNetState *net)
>+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
> {
>-    return 0;
> }
>
> bool vhost_net_virtqueue_pending(VHostNetState *net, int idx)
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index 540492b37d..33fc6ba2f9 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -35,10 +35,9 @@
> #include "hw/virtio/virtio-bus.h"
> #include "linux-headers/linux/vhost.h"
>
>-uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
>+void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
> {
>-    return vhost_get_features(&net->dev, net->feature_bits,
>-            features);
>+    vhost_get_features_ex(&net->dev, net->feature_bits, features);
> }
> int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>                          uint32_t config_len)
>@@ -51,10 +50,11 @@ int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>     return vhost_dev_set_config(&net->dev, data, offset, size, flags);
> }
>
>-void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
>+void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
> {
>-    net->dev.acked_features = net->dev.backend_features;
>-    vhost_ack_features(&net->dev, net->feature_bits, features);
>+    virtio_features_copy(net->dev.acked_features_ex,
>+                         net->dev.backend_features_ex);
>+    vhost_ack_features_ex(&net->dev, net->feature_bits, features);
> }
>
> uint64_t vhost_net_get_max_queues(VHostNetState *net)
>@@ -62,9 +62,9 @@ uint64_t vhost_net_get_max_queues(VHostNetState *net)
>     return net->dev.max_queues;
> }
>
>-uint64_t vhost_net_get_acked_features(VHostNetState *net)
>+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features)
> {
>-    return net->dev.acked_features;
>+    virtio_features_copy(features, net->dev.acked_features_ex);
> }
>
> void vhost_net_save_acked_features(NetClientState *nc)
>@@ -234,7 +234,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>     int r;
>     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
>     struct vhost_net *net = g_new0(struct vhost_net, 1);
>-    uint64_t features = 0;
>+    uint64_t missing_features[VIRTIO_FEATURES_DWORDS];
>+    uint64_t features[VIRTIO_FEATURES_DWORDS];

Should we initialize `features` (IIUC calling virtio_features_clear)
since it was set to 0 before this patch?

>     Error *local_err = NULL;
>
>     if (!options->net_backend) {
>@@ -261,7 +262,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>         net->backend = r;
>         net->dev.protocol_features = 0;
>     } else {
>-        net->dev.backend_features = 0;
>+        virtio_features_clear(net->dev.backend_features_ex);
>         net->dev.protocol_features = 0;
>         net->backend = -1;
>
>@@ -279,28 +280,31 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>     if (backend_kernel) {
>         if (!qemu_has_vnet_hdr_len(options->net_backend,
>                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
>-            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
>+            net->dev.features &= ~VIRTIO_BIT(VIRTIO_NET_F_MRG_RXBUF);
>         }
>-        if (~net->dev.features & net->dev.backend_features) {
>-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
>-                   " for backend\n",
>-                   (uint64_t)(~net->dev.features & net->dev.backend_features));
>+
>+        if (virtio_features_andnot(missing_features,
>+                                   net->dev.backend_features_ex,
>+                                   net->dev.features_ex)) {
>+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
>+                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
>             goto fail;
>         }
>     }
>
>     /* Set sane init value. Override when guest acks. */
>     if (options->get_acked_features) {
>-        features = options->get_acked_features(net->nc);
>-        if (~net->dev.features & features) {
>-            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
>-                    " for backend\n",
>-                    (uint64_t)(~net->dev.features & features));
>+        virtio_features_from_u64(features,
>+                                 options->get_acked_features(net->nc));
>+        if (virtio_features_andnot(missing_features, features,
>+                                   net->dev.features_ex)) {
>+            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
>+                    " for backend\n", VIRTIO_FEATURES_PR(missing_features));
>             goto fail;
>         }
>     }
>
>-    vhost_net_ack_features(net, features);
>+    vhost_net_ack_features_ex(net, features);

If `options->get_acked_features` is false, `features` here is not
initialized (it was set to 0 before this patch).

Thanks,
Stefano

>
>     return net;
>
>diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
>index 879781dad7..1d07b437c7 100644
>--- a/include/net/vhost_net.h
>+++ b/include/net/vhost_net.h
>@@ -2,6 +2,7 @@
> #define VHOST_NET_H
>
> #include "net/net.h"
>+#include "hw/virtio/virtio-features.h"
> #include "hw/virtio/vhost-backend.h"
>
> struct vhost_net;
>@@ -33,8 +34,26 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
>
> void vhost_net_cleanup(VHostNetState *net);
>
>-uint64_t vhost_net_get_features(VHostNetState *net, uint64_t features);
>-void vhost_net_ack_features(VHostNetState *net, uint64_t features);
>+void vhost_net_get_features_ex(VHostNetState *net, uint64_t *features);
>+static inline uint64_t vhost_net_get_features(VHostNetState *net,
>+                                              uint64_t features)
>+{
>+    uint64_t features_array[VIRTIO_FEATURES_DWORDS];
>+
>+    virtio_features_from_u64(features_array, features);
>+    vhost_net_get_features_ex(net, features_array);
>+    return features_array[0];
>+}
>+
>+void vhost_net_ack_features_ex(VHostNetState *net, const uint64_t *features);
>+static inline void vhost_net_ack_features(VHostNetState *net,
>+                                          uint64_t features)
>+{
>+    uint64_t features_array[VIRTIO_FEATURES_DWORDS];
>+
>+    virtio_features_from_u64(features_array, features);
>+    vhost_net_ack_features_ex(net, features_array);
>+}
>
> int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>                          uint32_t config_len);
>@@ -51,7 +70,15 @@ VHostNetState *get_vhost_net(NetClientState *nc);
>
> int vhost_net_set_vring_enable(NetClientState *nc, int enable);
>
>-uint64_t vhost_net_get_acked_features(VHostNetState *net);
>+void vhost_net_get_acked_features_ex(VHostNetState *net, uint64_t *features);
>+static inline uint64_t vhost_net_get_acked_features(VHostNetState *net)
>+{
>+    uint64_t features[VIRTIO_FEATURES_DWORDS];
>+
>+    vhost_net_get_acked_features_ex(net, features);
>+    assert(!virtio_features_use_extended(features));
>+    return features[0];
>+}
>
> int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
>
>-- 
>2.50.0
>


