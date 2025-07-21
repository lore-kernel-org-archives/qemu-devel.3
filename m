Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 02:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udgfo-0000A2-Dd; Sun, 20 Jul 2025 22:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1udgfl-000080-Ue
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 22:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1udgfh-0001Bs-Vj
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 22:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753066471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vypUYKRtFQoZrrWG5dFdQAEmzsxiJomW/9QNU3x0Bw=;
 b=KvQ1mst7d1D0fZdWmvbdfgtnAKm61pZWjd1CH0Dn7PUK95ixegJbFj6xOGmDrjDsSwc9Xp
 DZBmpRhdRjU4hVVzDyRoPqThrKfptfuUIKqgdPDxzpbHOG+HXwG2rqDGgiAHFwwiyP0hzP
 YJFzvUSGnRh+EKpHstvyOh0kUyLfLi4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-f1qdTIUOOWuf8vgp4OoxWA-1; Sun, 20 Jul 2025 22:54:29 -0400
X-MC-Unique: f1qdTIUOOWuf8vgp4OoxWA-1
X-Mimecast-MFC-AGG-ID: f1qdTIUOOWuf8vgp4OoxWA_1753066468
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae6d551ef64so341124666b.2
 for <qemu-devel@nongnu.org>; Sun, 20 Jul 2025 19:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753066468; x=1753671268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vypUYKRtFQoZrrWG5dFdQAEmzsxiJomW/9QNU3x0Bw=;
 b=wYsiAcE8jaJkOsxADqf4dskg13u9YLAQXn006bYu7muhMFPTl0eXE9C2RYuH0ACWoP
 qb/txQiBbECpJYJ2WNIZrcYThuhcrTnn6+YqCYfKC8nNEIjVjEeD2vJYM9jGuW3fMpTC
 MCi48ll+2NlcO6C1sGo5T8wpIAlxmoN2zYM5i7f1xWMp/Ihi2fg21sAp8RKJtTbyPJAX
 gXaA1A1qEBZ0KsL8XVgk3A5oDmw5JbXUHwdWR3A8dteTHaICp+TWjt7dndju6/+CriBZ
 Sqt+QCHDlgT3ce9P8NECHSftfp+ZGfpWCNcuOfTHlVamxWoJ25fHb1CbJ61hJwQFSZ+f
 HbpA==
X-Gm-Message-State: AOJu0Yy1PQCDWPneFMN/OyQRRpUfaTj6k8wiuLgFHTLjA99ifa0qCB0j
 Zg+DOeim8ZsGPBmPsStl4xg7XDuuQP4TUw59Ud5UwSVics3A7zwDNR+2oZnCCak2+KCl8ezwKCc
 A2vRoJ/RZ1uBoWasc2J0tbc0o20WYID6Ea04Bxc9poOWeCEl5dbl0cXbyHhXnJN3aL2usd3sP2H
 rWqS1r1PMiNCtLJwfueNWXDuaJtZXdAsA=
X-Gm-Gg: ASbGncuGszN2EeGZ/VV0Ct/4aeFeJ8rnRJwr9b3epDvcw0cEYy+Xo08bwWWv2zHIajf
 myNYKYJKufCCEHWpfxq2tmxMtaOL81QJtPhQwjPlTJ7ydmJunUEjuqKb3fW8akZkruzPRxaLFi2
 ontpgdlKmwSnB58Q2CzLMw
X-Received: by 2002:a17:906:d553:b0:ae0:d7b3:848a with SMTP id
 a640c23a62f3a-ae9c9983073mr2011674166b.2.1753066468267; 
 Sun, 20 Jul 2025 19:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUOVBdirnedpuMQ0N8TGNejWYQXWojDhtoMtCtjFoW6/+ji120rxt1T+v78tocLNh0opqRv3xblH4nxyqypP0=
X-Received: by 2002:a17:906:d553:b0:ae0:d7b3:848a with SMTP id
 a640c23a62f3a-ae9c9983073mr2011672666b.2.1753066467862; Sun, 20 Jul 2025
 19:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
 <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
In-Reply-To: <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 21 Jul 2025 10:53:49 +0800
X-Gm-Features: Ac12FXy8aAQvcMhldC0OoMThCmqAan3JzItMjKYnO1wQWaSIDZMZr8nzYpUuw-4
Message-ID: <CAPpAL=yQwxOKYCsFSK1p_3R7arT0oDpZmfKsD_bKf0R7tXhCNQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jul 18, 2025 at 10:37=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Fri, Jul 18, 2025 at 10:52:33AM +0200, Paolo Abeni wrote:
> >Similar to virtio infra, vhost core maintains the features status
> >in the full extended format and allows the devices to implement
> >extended version of the getter/setter.
> >
> >Note that 'protocol_features' are not extended: they are only
> >used by vhost-user, and the latter device is not going to implement
> >extended features soon.
> >
> >Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >---
> >v2 -> v3:
> >  - fix compile warning
> >  - _array -> _ex
> >
> >v1 -> v2:
> >  - uint128_t -> uint64_t[]
> >  - add _ex() variant of features manipulation helpers
> >---
> > hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++----
> > include/hw/virtio/vhost-backend.h |  6 +++
> > include/hw/virtio/vhost.h         | 33 ++++++++++++--
> > 3 files changed, 100 insertions(+), 12 deletions(-)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index c30ea1156e..85ae1e4d4c 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_d=
ev *dev,
> > static int vhost_dev_set_features(struct vhost_dev *dev,
> >                                   bool enable_log)
> > {
> >-    uint64_t features =3D dev->acked_features;
> >+    uint64_t features[VIRTIO_FEATURES_DWORDS];
> >     int r;
> >+
> >+    virtio_features_copy(features, dev->acked_features_ex);
> >     if (enable_log) {
> >-        features |=3D 0x1ULL << VHOST_F_LOG_ALL;
> >+        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
> >     }
> >     if (!vhost_dev_has_iommu(dev)) {
> >-        features &=3D ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
> >+        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
> >     }
> >     if (dev->vhost_ops->vhost_force_iommu) {
> >         if (dev->vhost_ops->vhost_force_iommu(dev) =3D=3D true) {
> >-            features |=3D 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
> >+            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
> >        }
> >     }
> >-    r =3D dev->vhost_ops->vhost_set_features(dev, features);
> >+

Hi Paolo

> >+    if (virtio_features_use_extended(features) &&
> >+        !dev->vhost_ops->vhost_set_features_ex) {
> >+        VHOST_OPS_DEBUG(r, "extended features without device support");
> >+        r =3D -EINVAL;
> >+        goto out;
> >+    }

As we discussed in version 2, this code should be changed to: [1],
otherwise the problem mentioned last time will occur when compiling.

[1] if (virtio_features_use_extended(features) &&
         !dev->vhost_ops->vhost_set_features_ex) {
-        VHOST_OPS_DEBUG(r, "extended features without device support");
         r =3D -EINVAL;
+        VHOST_OPS_DEBUG(r, "extended features without device support");
         goto out;
     }

Thanks
Lei
> >+
> >+    if (dev->vhost_ops->vhost_set_features_ex) {
> >+        r =3D dev->vhost_ops->vhost_set_features_ex(dev, features);
> >+    } else {
> >+        r =3D dev->vhost_ops->vhost_set_features(dev, features[0]);
> >+    }
> >     if (r < 0) {
> >         VHOST_OPS_DEBUG(r, "vhost_set_features failed");
> >         goto out;
> >@@ -1506,12 +1520,27 @@ static void vhost_virtqueue_cleanup(struct vhost=
_virtqueue *vq)
> >     }
> > }
> >
> >+static int vhost_dev_get_features(struct vhost_dev *hdev,
> >+                                  uint64_t *features)
> >+{
> >+    uint64_t features64;
> >+    int r;
> >+
> >+    if (hdev->vhost_ops->vhost_get_features_ex) {
> >+        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
> >+    }
> >+
> >+    r =3D hdev->vhost_ops->vhost_get_features(hdev, &features64);
> >+    virtio_features_from_u64(features, features64);
> >+    return r;
> >+}
> >+
> > int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >                    VhostBackendType backend_type, uint32_t busyloop_tim=
eout,
> >                    Error **errp)
> > {
> >+    uint64_t features[VIRTIO_FEATURES_DWORDS];
> >     unsigned int used, reserved, limit;
> >-    uint64_t features;
> >     int i, r, n_initialized_vqs =3D 0;
> >
> >     hdev->vdev =3D NULL;
> >@@ -1531,7 +1560,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
> >         goto fail;
> >     }
> >
> >-    r =3D hdev->vhost_ops->vhost_get_features(hdev, &features);
> >+    r =3D vhost_dev_get_features(hdev, features);
> >     if (r < 0) {
> >         error_setg_errno(errp, -r, "vhost_get_features failed");
> >         goto fail;
> >@@ -1569,7 +1598,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
> >         }
> >     }
> >
> >-    hdev->features =3D features;
> >+    virtio_features_copy(hdev->features_ex, features);
> >
> >     hdev->memory_listener =3D (MemoryListener) {
> >         .name =3D "vhost",
> >@@ -1592,7 +1621,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void
> >*opaque,
> >     };
> >
> >     if (hdev->migration_blocker =3D=3D NULL) {
> >-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
> >+        if (!virtio_has_feature_ex(hdev->features_ex, VHOST_F_LOG_ALL))=
 {
> >             error_setg(&hdev->migration_blocker,
> >                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL=
 feature.");
> >         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_c=
heck()) {
> >@@ -1871,6 +1900,20 @@ uint64_t vhost_get_features(struct vhost_dev *hde=
v, const int *feature_bits,
> >     return features;
> > }
> >
> >+void vhost_get_features_ex(struct vhost_dev *hdev,
> >+                           const int *feature_bits,
> >+                           uint64_t *features)
> >+{
> >+    const int *bit =3D feature_bits;
> >+
> >+    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> >+        if (!virtio_has_feature_ex(hdev->features_ex, *bit)) {
> >+            virtio_clear_feature_ex(features, *bit);
> >+        }
> >+        bit++;
> >+    }
> >+}
> >+
>
> Can we do something similar of what we do in hw/virtio/virtio.c where
> the old virtio_set_features() use the new virtio_set_features_ex()?
>
> > void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits=
,
> >                         uint64_t features)
> > {
> >@@ -1884,6 +1927,18 @@ void vhost_ack_features(struct vhost_dev *hdev, c=
onst int *feature_bits,
> >     }
> > }
> >
> >+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_b=
its,
> >+                           const uint64_t *features)
> >+{
> >+    const int *bit =3D feature_bits;
> >+    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> >+        if (virtio_has_feature_ex(features, *bit)) {
> >+            virtio_add_feature_ex(hdev->acked_features_ex, *bit);
> >+        }
> >+        bit++;
> >+    }
> >+}
> >+
>
> Ditto.
>
> Not a strong opinion, but just to reduce code duplication.
>
> Thanks,
> Stefano
>
> > int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
> >                          uint32_t config_len, Error **errp)
> > {
> >diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost=
-backend.h
> >index d6df209a2f..ff94fa1734 100644
> >--- a/include/hw/virtio/vhost-backend.h
> >+++ b/include/hw/virtio/vhost-backend.h
> >@@ -95,6 +95,10 @@ typedef int (*vhost_new_worker_op)(struct vhost_dev *=
dev,
> >                                    struct vhost_worker_state *worker);
> > typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
> >                                     struct vhost_worker_state *worker);
> >+typedef int (*vhost_set_features_ex_op)(struct vhost_dev *dev,
> >+                                        const uint64_t *features);
> >+typedef int (*vhost_get_features_ex_op)(struct vhost_dev *dev,
> >+                                        uint64_t *features);
> > typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
> >                                      uint64_t features);
> > typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
> >@@ -186,6 +190,8 @@ typedef struct VhostOps {
> >     vhost_free_worker_op vhost_free_worker;
> >     vhost_get_vring_worker_op vhost_get_vring_worker;
> >     vhost_attach_vring_worker_op vhost_attach_vring_worker;
> >+    vhost_set_features_ex_op vhost_set_features_ex;
> >+    vhost_get_features_ex_op vhost_get_features_ex;
> >     vhost_set_features_op vhost_set_features;
> >     vhost_get_features_op vhost_get_features;
> >     vhost_set_backend_cap_op vhost_set_backend_cap;
> >diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >index 66be6afc88..39fbffc6bc 100644
> >--- a/include/hw/virtio/vhost.h
> >+++ b/include/hw/virtio/vhost.h
> >@@ -107,9 +107,9 @@ struct vhost_dev {
> >      * future use should be discouraged and the variable retired as
> >      * its easy to confuse with the VirtIO backend_features.
> >      */
> >-    uint64_t features;
> >-    uint64_t acked_features;
> >-    uint64_t backend_features;
> >+    VIRTIO_DECLARE_FEATURES(features);
> >+    VIRTIO_DECLARE_FEATURES(acked_features);
> >+    VIRTIO_DECLARE_FEATURES(backend_features);
> >
> >     /**
> >      * @protocol_features: is the vhost-user only feature set by
> >@@ -333,6 +333,21 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, V=
irtIODevice *vdev, int n,
> > uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_=
bits,
> >                             uint64_t features);
> >
> >+/**
> >+ * vhost_get_features_ex() - sanitize the extended features set
> >+ * @hdev: common vhost_dev structure
> >+ * @feature_bits: pointer to terminated table of feature bits
> >+ * @features: original features set, filtered out on return
> >+ *
> >+ * This is the extended variant of vhost_get_features(), supporting the
> >+ * the extended features set. Filter it with the intersection of what i=
s
> >+ * supported by the vhost backend (hdev->features) and the supported
> >+ * feature_bits.
> >+ */
> >+void vhost_get_features_ex(struct vhost_dev *hdev,
> >+                           const int *feature_bits,
> >+                           uint64_t *features);
> >+
> > /**
> >  * vhost_ack_features() - set vhost acked_features
> >  * @hdev: common vhost_dev structure
> >@@ -344,6 +359,18 @@ uint64_t vhost_get_features(struct vhost_dev *hdev,=
 const int *feature_bits,
> >  */
> > void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits=
,
> >                         uint64_t features);
> >+
> >+/**
> >+ * vhost_ack_features_ex() - set vhost full set of acked_features
> >+ * @hdev: common vhost_dev structure
> >+ * @feature_bits: pointer to terminated table of feature bits
> >+ * @features: requested feature set
> >+ *
> >+ * This sets the internal hdev->acked_features to the intersection of
> >+ * the backends advertised features and the supported feature_bits.
> >+ */
> >+void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_b=
its,
> >+                           const uint64_t *features);
> > unsigned int vhost_get_max_memslots(void);
> > unsigned int vhost_get_free_memslots(void);
> >
> >--
> >2.50.0
> >
>
>


