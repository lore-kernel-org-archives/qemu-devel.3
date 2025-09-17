Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D5ECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrEm-0004Ut-6E; Wed, 17 Sep 2025 08:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrEb-0004QI-6s
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrEY-00019O-LV
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VnVXQSRE3XnlbwBZhW8DnCp4bP9gVf0+88xqUVmtMuY=;
 b=TdZB+5VCM0A4iGRul0tx5/T0fCbE4dmbgV7ogbwnLu0p0nx7YgHJevt8lyg3UCeCg26mpZ
 LMZapNeZpx/lTEzFcGaZzV4pgpzjcrXXb+GywtXgXc2JalqCUwY/3qsRonJ//YE3e3OqSW
 JcfWNQLtmdMWOMA8k/gdMnVShrfsS60=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-nxij16wsN2CotcJZ07VUrQ-1; Wed, 17 Sep 2025 08:25:56 -0400
X-MC-Unique: nxij16wsN2CotcJZ07VUrQ-1
X-Mimecast-MFC-AGG-ID: nxij16wsN2CotcJZ07VUrQ_1758111955
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so1223335f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111955; x=1758716755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnVXQSRE3XnlbwBZhW8DnCp4bP9gVf0+88xqUVmtMuY=;
 b=Qn3Mt5pCK34LGOhw84ew7xVRnvSpvAS6BNJUkV0tPyFisnJACQTkk2xoQOJnVgHbIj
 HwwtTuJui/tQwsHj20yqXqJ/8c4HmcrgITHaWCfE/KHLwCkRghhNB6I2ZM5wYJnWKyfV
 VOdj+948yAXOUrheBvkuSgn6bDTvc9gc1VoPwi9d7gIJn9MqQUJKZgBU3Oi4zI4dswfu
 4olyx/K4ffUNq5DvTfdmnWoQdWkQ5YxkYCVjQ4TCmln7qhDS7jHH1AaK0IKyQfldg9Uw
 HggGe+fC+OOnoUMXkcHTsiL8EYHy48maMijyUBS4WZm/nsgugzC/nwl7RdgFJh5rZwlX
 EFmQ==
X-Gm-Message-State: AOJu0YwLi8ORB742UVVkXi7GO82rTTK9mvTv2pEMxAH8ub+mBVZ5mUis
 1JulrkjEPgPE3Hdq+WZQ7scvKKa+AGBRhT7hf//39zW3M57bJ0SMvJE7M7IHwpICinS0ZKDXsRo
 wXlvvtBL0JvPtSMuySBgg4I8JVaz60zsJgMhNeQkn/m2E5IWa+P1o9rQc
X-Gm-Gg: ASbGnctKHow3e95DAeuvMv3P4A1Uqw8Ttr+dbjjhw46VtgDbceAawMdF+rvLNF3CYYX
 +r40qXn4Q0a8nARLmZQKFcqiF+/dYpyTezwA98LDMB9O9vel1EZcq4C01mU48aJac0xcPATPJnl
 qEFaZeFSV19QKPtdnhTPZIG3PFj91RoUBW1+qMaenvCbWiwv/4qDmI1yT5WXqVkp3LIfxattEnR
 2mbxeyiqFgQHVHqkn7AfWh2n6gGFYDb3OkmzF1UJIsxMfMroSNI5YLpldvWqoWlykhrH/uAx63m
 9nYZAaSQw7MP6zlIVxvfnntTwC6fe6f3usMjUzZA/pM9
X-Received: by 2002:a05:6000:2881:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-3ecdfa0d552mr1903253f8f.38.1758111955426; 
 Wed, 17 Sep 2025 05:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcMvD01Gs3ifBkoBFodoxF1xqThz/2gk6MrQ6vCEzQkICanKHUNyP2WphZQRGNxoLYGKjmKQ==
X-Received: by 2002:a05:6000:2881:b0:3ec:2529:b4e5 with SMTP id
 ffacd0b85a97d-3ecdfa0d552mr1903220f8f.38.1758111954920; 
 Wed, 17 Sep 2025 05:25:54 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607870cfsm26752810f8f.19.2025.09.17.05.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:25:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:25:48 +0200
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
Subject: Re: [PATCH v6 07/14] virtio-pci: implement support for extended
 features
Message-ID: <noxeu2gkgenvy744hopuwlvkanauo3vlga4jgc6whl4tygorcz@afwpr5z26pfu>
References: <cover.1757676218.git.pabeni@redhat.com>
 <921883b5ff7bc8b99e35a36381658685c12ba49d.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <921883b5ff7bc8b99e35a36381658685c12ba49d.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Sep 12, 2025 at 03:06:58PM +0200, Paolo Abeni wrote:
>Extend the features configuration space to 128 bits. If the virtio
>device supports any extended features, allow the common read/write
>operation to access all of it, otherwise keep exposing only the
>lower 64 bits.
>
>On migration, save the 128 bit version of the features only if the
>upper bits are non zero. Relay on reset to clear all the feature
>space before load.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v5 -> v6:
>  - fixed checkpatch error (missing brackets on a single line statement)
>
>v4 -> v5:
>  - add blank line after QEMU_BUILD_BUG_ON()
>  - make virtio_pci_select_max() robust vs future feature space increase
>
>v3 -> v4:
>  - use new virtio_features macro names
>  - move the build bug before vmstate_virtio_pci_modern_state_sub
>
>v2 -> v3:
>  - drop the pre_load/post_load trickery and relay on reset zeroing
>    the features instead.
>  - avoid union usage, just increase guest_features size and use
>    SUB_ARRAY.
>  - drop unneeded '!!'
>  - _array -> _ex
>
>v1 -> v2:
>  - use separate VMStateDescription and pre/post load to avoid breaking
>    migration
>  - clear proxy features on device reset
>---
> hw/virtio/virtio-pci.c         | 76 ++++++++++++++++++++++++++++++----
> include/hw/virtio/virtio-pci.h |  2 +-
> 2 files changed, 68 insertions(+), 10 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index 767216d795..01e4fecaf4 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -109,6 +109,29 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
>     }
> };
>
>+static bool virtio_pci_modern_state_features128_needed(void *opaque)
>+{
>+    VirtIOPCIProxy *proxy = opaque;
>+    uint32_t features = 0;
>+    int i;
>+
>+    for (i = 2; i < ARRAY_SIZE(proxy->guest_features); ++i) {
>+        features |= proxy->guest_features[i];
>+    }
>+    return features;
>+}
>+
>+static const VMStateDescription vmstate_virtio_pci_modern_state_features128 = {
>+    .name = "virtio_pci/modern_state/features128",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .needed = &virtio_pci_modern_state_features128_needed,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 2, 2),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
> static bool virtio_pci_modern_state_needed(void *opaque)
> {
>     VirtIOPCIProxy *proxy = opaque;
>@@ -116,6 +139,12 @@ static bool virtio_pci_modern_state_needed(void *opaque)
>     return virtio_pci_modern(proxy);
> }
>
>+/*
>+ * Avoid silently breaking migration should the feature space increase
>+ * even more in the (far away) future
>+ */
>+QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU32S != 4);
>+
> static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>     .name = "virtio_pci/modern_state",
>     .version_id = 1,
>@@ -124,11 +153,15 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>     .fields = (const VMStateField[]) {
>         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
>         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
>-        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
>+        VMSTATE_UINT32_SUB_ARRAY(guest_features, VirtIOPCIProxy, 0, 2),
>         VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
>                              vmstate_virtio_pci_modern_queue_state,
>                              VirtIOPCIQueue),
>         VMSTATE_END_OF_LIST()
>+    },
>+    .subsections = (const VMStateDescription * const []) {
>+        &vmstate_virtio_pci_modern_state_features128,
>+        NULL
>     }
> };
>
>@@ -1477,6 +1510,19 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>     return virtio_pci_add_mem_cap(proxy, &cap.cap);
> }
>
>+static int virtio_pci_select_max(const VirtIODevice *vdev)
>+{
>+    int i;
>+
>+    for (i = VIRTIO_FEATURES_NU64S - 1; i > 0; i--) {
>+        if (vdev->host_features_ex[i]) {
>+            return (i + 1) * 2;
>+        }
>+    }
>+
>+    return 2;
>+}
>+
> static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>                                        unsigned size)
> {
>@@ -1494,18 +1540,21 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
>         val = proxy->dfselect;
>         break;
>     case VIRTIO_PCI_COMMON_DF:
>-        if (proxy->dfselect <= 1) {
>+        if (proxy->dfselect < virtio_pci_select_max(vdev)) {
>             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>
>-            val = (vdev->host_features & ~vdc->legacy_features) >>
>-                (32 * proxy->dfselect);
>+            val = vdev->host_features_ex[proxy->dfselect >> 1] >>
>+                  (32 * (proxy->dfselect & 1));
>+            if (proxy->dfselect <= 1) {
>+                val &= (~vdc->legacy_features) >> (32 * proxy->dfselect);
>+            }
>         }
>         break;
>     case VIRTIO_PCI_COMMON_GFSELECT:
>         val = proxy->gfselect;
>         break;
>     case VIRTIO_PCI_COMMON_GF:
>-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
>+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
>             val = proxy->guest_features[proxy->gfselect];
>         }
>         break;
>@@ -1588,11 +1637,18 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>         proxy->gfselect = val;
>         break;
>     case VIRTIO_PCI_COMMON_GF:
>-        if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
>+        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
>+            uint64_t features[VIRTIO_FEATURES_NU64S];
>+            int i;
>+
>             proxy->guest_features[proxy->gfselect] = val;
>-            virtio_set_features(vdev,
>-                                (((uint64_t)proxy->guest_features[1]) << 32) |
>-                                proxy->guest_features[0]);
>+            virtio_features_clear(features);
>+            for (i = 0; i < ARRAY_SIZE(proxy->guest_features); ++i) {
>+                uint64_t cur = proxy->guest_features[i];
>+
>+                features[i >> 1] |= cur << ((i & 1) * 32);
>+            }
>+            virtio_set_features_ex(vdev, features);
>         }
>         break;
>     case VIRTIO_PCI_COMMON_MSIX:
>@@ -2311,6 +2367,8 @@ static void virtio_pci_reset(DeviceState *qdev)
>     virtio_bus_reset(bus);
>     msix_unuse_all_vectors(&proxy->pci_dev);
>
>+    memset(proxy->guest_features, 0, sizeof(proxy->guest_features));
>+
>     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>         proxy->vqs[i].enabled = 0;
>         proxy->vqs[i].reset = 0;
>diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
>index eab5394898..639752977e 100644
>--- a/include/hw/virtio/virtio-pci.h
>+++ b/include/hw/virtio/virtio-pci.h
>@@ -158,7 +158,7 @@ struct VirtIOPCIProxy {
>     uint32_t nvectors;
>     uint32_t dfselect;
>     uint32_t gfselect;
>-    uint32_t guest_features[2];
>+    uint32_t guest_features[VIRTIO_FEATURES_NU32S];
>     VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
>
>     VirtIOIRQFD *vector_irqfd;
>-- 
>2.51.0
>


