Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024EECCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vqn-000896-6x; Thu, 09 Oct 2025 14:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vql-00081m-FY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:51 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vqi-0006CO-Fm
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:58:51 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-42f9353c810so4058555ab.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036325; x=1760641125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6xGVDe7uVy4lIHX0yY/ZG/TO5rSZ9MOFLK0ktZq6WY=;
 b=B0l57ZTIUYlhJUeoxqBfpP5yv+OYDJj+cfsugY7r9TOetUVwAoU6zWXNcr5uU7ANIv
 TdjJCDMin1LWlllVQks4yAIzznDTOKsxGF7xnFLgTRTXVm+FrMZoPCpiQTOasB2oCe4J
 ebySOAfB/vxrdXipC0MsA5AgUC2QFdwKcFysUF0SnU9Rp+PK3jBeD1qgMMsm3qL1+cWl
 Ur96tK8+1kgGUyYfPlKiDBrqynpbuQbLCy9qtCKudk5mL59Gs+ZPdt9gn7ui/Q1S96Xz
 YRxUod2Ou5P+CXsZT+D6QXGx46AIqqOfAH127qBUl23aXv3oL4QG33gatoqFmmqmIWF5
 XmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036325; x=1760641125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6xGVDe7uVy4lIHX0yY/ZG/TO5rSZ9MOFLK0ktZq6WY=;
 b=tRvVme5hKDH3Emsm19RtnDNtphRAbu20dxggbSabXLEJHYtMpP943UljKnlXCL6lvQ
 CCkM+4hrIXoncyLMtkuRb4DDEM84EdcMbukfmsQOllFlxJ6PhaJ2Am8OF0QFxh7TkwM3
 i6kqPiMFS0QW5KyotkVXs6Y6C8vADHjLIWdI+Ge6PNtnkCqPaW0QbMSvvfwV5fiEE+2v
 BQVwrUA3A53BSryui/VP4Pua2ajUGekKtWZl0IcsHh7CWUN0EGCLkUr4kwDoNU/9obTc
 azdpeLDqSB4KgRfdRsur7v0zZombl2xwL1Sz396SONgzItgYqA0erFCRT+4WrZNG4zAd
 sOgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKpBtInU9a5Gv5mErx/OgR7pkrZ1Q8kdPmvmwndILtvflu5zZ6gudrdfZ9IZJa2cgs3CB632FuN4eo@nongnu.org
X-Gm-Message-State: AOJu0Yz+aMqW9f4+WLFXyLTlVAvoO26S0356PrdDme8wBMti6ICbQ1I2
 p2skJ5YZyWzHCMs/ZtBjF8hytSHUhRWXDLezRGhlqfWkgBpYeYMnPUbbGpU4SlEtq5Nzh3v2+jb
 mBffelojeMWFSGi7wW0AyrKYHNG/2F08=
X-Gm-Gg: ASbGncug0WPcAKNULvdIUnT0YYNDSG5N9FHXjuRP4wqGS2a0wgoySBiji7TL4OFL+Tn
 b1hBfzyKDsA4uvKE/UAubgCvixo3NmR0SERKQz4euoZgyRz0BFX2ZmzwePqweJOJnLWWLvk5uqj
 4Z8S4P+wxhb6h293HWhEte8eqfo+rLM3XxlmUof0Ibz40eLCuu5/i93vf3gGLBwlGk9u9Fzd0dO
 ChKULhoxalazzU+nX7z+H8zswwNvfLBDUwQ8z+xTg==
X-Google-Smtp-Source: AGHT+IHLD+dNho87OMRMNsv6iJ+qqY4dU2LLUwofv1nRME2A1VgkYWaEMHNHtRkym6Ixn5G+gepAcV3yMROO4QFIoFg=
X-Received: by 2002:a05:6e02:218f:b0:429:6c5a:61e4 with SMTP id
 e9e14a558f8ab-42f87362431mr69166495ab.7.1760036324940; Thu, 09 Oct 2025
 11:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-7-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-7-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:58:34 -0400
X-Gm-Features: AS18NWAfcdEub2u8MN_7JR5WeffBUndjqg-YvyQ407-8rjYQIssIP5DIKNarE04
Message-ID: <CAFubqFtQNGxbiuC+r8g=28tvC=qz5c+1HfqT-jAG6T8xM_Wv9A@mail.gmail.com>
Subject: Re: [PATCH 06/33] vhost: make vhost_dev.features private
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x136.google.com
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

On Wed, Aug 13, 2025 at 12:58=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> It's hard to control where and how do we use this field. Let's
> cover all usages by getters/setters, and keep direct access to the
> field only in vhost.c. It will help to control migration of this
> field in further commits.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/display/vhost-user-gpu.c |  7 +++----
>  hw/net/vhost_net.c          | 17 +++++++++--------
>  hw/virtio/vdpa-dev.c        |  2 +-
>  hw/virtio/vhost-user-base.c |  8 ++++++--
>  hw/virtio/vhost-user.c      |  7 +++----
>  hw/virtio/vhost.c           | 21 ++++++++++++++++++---
>  hw/virtio/virtio-qmp.c      |  2 +-
>  include/hw/virtio/vhost.h   | 21 +++++++++++++++++++--
>  net/vhost-vdpa.c            |  7 +++----
>  9 files changed, 63 insertions(+), 29 deletions(-)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 79ea64b12c..146620e0a3 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -631,17 +631,16 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Er=
ror **errp)
>
>      /* existing backend may send DMABUF, so let's add that requirement *=
/
>      g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED;
> -    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_VIRGL)) =
{
> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_VIRGL)) {
>          g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED=
;
>      }
> -    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_EDID)) {
> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_EDID)) {
>          g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_EDID_ENABLED;
>      } else {
>          error_report("EDID requested but the backend doesn't support it.=
");
>          g->parent_obj.conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_EDID_ENABLE=
D);
>      }
> -    if (virtio_has_feature(g->vhost->dev.features,
> -        VIRTIO_GPU_F_RESOURCE_UUID)) {
> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID=
)) {
>          g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID=
_ENABLED;
>      }
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index ce30b6e197..5269533864 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -55,7 +55,8 @@ void vhost_net_ack_features(struct vhost_net *net, uint=
64_t features)
>  {
>      net->dev.acked_features =3D
>          (qemu_has_vnet_hdr(net->nc) ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NE=
T_HDR))
> -         | (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES)=
);
> +         | (vhost_dev_features(&net->dev) &
> +            (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
>
>      vhost_ack_features(&net->dev, net->feature_bits, features);
>  }
> @@ -277,23 +278,23 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>      if (backend_kernel) {
>          if (!qemu_has_vnet_hdr_len(options->net_backend,
>                                 sizeof(struct virtio_net_hdr_mrg_rxbuf)))=
 {
> -            net->dev.features &=3D ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
> +            vhost_dev_clear_feature(&net->dev, VIRTIO_NET_F_MRG_RXBUF);
>          }
>          if (!qemu_has_vnet_hdr(options->net_backend) &&
> -            (~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET_HDR)))=
 {
> -            fprintf(stderr, "vhost lacks feature mask 0x%llx for backend=
\n",
> -                    ~net->dev.features & (1ULL << VHOST_NET_F_VIRTIO_NET=
_HDR));
> +            !vhost_dev_has_feature(&net->dev, VHOST_NET_F_VIRTIO_NET_HDR=
)) {
> +            fprintf(stderr, "vhost lacks VHOST_NET_F_VIRTIO_NET_HDR "
> +                    "feature for backend\n");
>              goto fail;
>          }
>      }
>
>      /* Set sane init value. Override when guest acks. */
>      if (options->get_acked_features) {
> +        uint64_t backend_features =3D vhost_dev_features(&net->dev);
>          features =3D options->get_acked_features(net->nc);
> -        if (~net->dev.features & features) {
> +        if (~backend_features & features) {
>              fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
> -                    " for backend\n",
> -                    (uint64_t)(~net->dev.features & features));
> +                    " for backend\n", ~backend_features & features);
>              goto fail;
>          }
>      }
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 3c0eed3e8e..4dfb03aaa7 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -224,7 +224,7 @@ static uint64_t vhost_vdpa_device_get_features(VirtIO=
Device *vdev,
>                                                 Error **errp)
>  {
>      VhostVdpaDevice *s =3D VHOST_VDPA_DEVICE(vdev);
> -    uint64_t backend_features =3D s->dev.features;
> +    uint64_t backend_features =3D vhost_dev_features(&s->dev);
>
>      if (!virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM)) {
>          virtio_clear_feature(&backend_features, VIRTIO_F_IOMMU_PLATFORM)=
;
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index ff67a020b4..cf311c3bfc 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -118,9 +118,13 @@ static uint64_t vub_get_features(VirtIODevice *vdev,
>                                   uint64_t requested_features, Error **er=
rp)
>  {
>      VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
> +    uint64_t backend_features =3D vhost_dev_features(&vub->vhost_dev);
> +
>      /* This should be set when the vhost connection initialises */
> -    g_assert(vub->vhost_dev.features);
> -    return vub->vhost_dev.features & ~(1ULL << VHOST_USER_F_PROTOCOL_FEA=
TURES);
> +    g_assert(backend_features);
> +    virtio_clear_feature(&backend_features, VHOST_USER_F_PROTOCOL_FEATUR=
ES);
> +
> +    return backend_features;
>  }
>
>  /*
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index abdf47ee7b..46f09f5988 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1245,15 +1245,14 @@ static int vhost_user_set_vring_base(struct vhost=
_dev *dev,
>
>  static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
>  {
> -    return virtio_has_feature(dev->features,
> -                              VHOST_USER_F_PROTOCOL_FEATURES);
> +    return vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES);
>  }
>
>  static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable=
)
>  {
>      int i;
>
> -    if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURE=
S)) {
> +    if (!vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
>          return -EINVAL;
>      }
>
> @@ -1465,7 +1464,7 @@ static int vhost_user_set_features(struct vhost_dev=
 *dev,
>       * Don't lose VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user
>       * specific.
>       */
> -    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES=
)) {
> +    if (vhost_dev_has_feature(dev, VHOST_USER_F_PROTOCOL_FEATURES)) {
>          features |=3D 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>      }
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c33dad4acd..2631bbabcf 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -50,6 +50,21 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BA=
CKEND_TYPE_MAX];
>  static QLIST_HEAD(, vhost_dev) vhost_devices =3D
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>
> +bool vhost_dev_has_feature(struct vhost_dev *dev, uint64_t feature)
> +{
> +    return virtio_has_feature(dev->_features, feature);
> +}
> +
> +uint64_t vhost_dev_features(struct vhost_dev *dev)
> +{
> +    return dev->_features;
> +}
> +
> +void vhost_dev_clear_feature(struct vhost_dev *dev, uint64_t feature)
> +{
> +    virtio_clear_feature(&dev->_features, feature);
> +}
> +
>  unsigned int vhost_get_max_memslots(void)
>  {
>      unsigned int max =3D UINT_MAX;
> @@ -1571,7 +1586,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          }
>      }
>
> -    hdev->features =3D features;
> +    hdev->_features =3D features;
>
>      hdev->memory_listener =3D (MemoryListener) {
>          .name =3D "vhost",
> @@ -1594,7 +1609,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      };
>
>      if (hdev->migration_blocker =3D=3D NULL) {
> -        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
> +        if (!vhost_dev_has_feature(hdev, VHOST_F_LOG_ALL)) {
>              error_setg(&hdev->migration_blocker,
>                         "Migration disabled: vhost lacks VHOST_F_LOG_ALL =
feature.");
>          } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_ch=
eck()) {
> @@ -1865,7 +1880,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev,=
 const int *feature_bits,
>      const int *bit =3D feature_bits;
>      while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
>          uint64_t bit_mask =3D (1ULL << *bit);
> -        if (!(hdev->features & bit_mask)) {
> +        if (!vhost_dev_has_feature(hdev, *bit)) {
>              features &=3D ~bit_mask;
>          }
>          bit++;
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index d55b12f9f3..4bd23c015e 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -785,7 +785,7 @@ VirtioStatus *qmp_x_query_virtio_status(const char *p=
ath, Error **errp)
>          status->vhost_dev->nvqs =3D hdev->nvqs;
>          status->vhost_dev->vq_index =3D hdev->vq_index;
>          status->vhost_dev->features =3D
> -            qmp_decode_features(vdev->device_id, hdev->features);
> +            qmp_decode_features(vdev->device_id, vhost_dev_features(hdev=
));
>          status->vhost_dev->acked_features =3D
>              qmp_decode_features(vdev->device_id, hdev->acked_features);
>          status->vhost_dev->max_queues =3D hdev->max_queues;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 15bc287a9d..8a4c8c3502 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -98,10 +98,11 @@ struct vhost_dev {
>       * offered by a backend which may be a subset of the total
>       * features eventually offered to the guest.
>       *
> -     * @features: available features provided by the backend
> +     * @_features: available features provided by the backend, private,
> +     *             direct access only in vhost.c
>       * @acked_features: final negotiated features with front-end driver
>       */
> -    uint64_t features;
> +    uint64_t _features;
>      uint64_t acked_features;
>
>      uint64_t max_queues;
> @@ -352,6 +353,22 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, ui=
nt16_t queue_size,
>                             struct vhost_inflight *inflight);
>  bool vhost_dev_has_iommu(struct vhost_dev *dev);
>
> +/**
> + * vhost_dev_has_feature() - check if vhost device has a specific featur=
e
> + * @dev: common vhost_dev structure
> + * @feature: feature bit to check
> + *
> + * Return: true if the feature is supported, false otherwise
> + */
> +bool vhost_dev_has_feature(struct vhost_dev *dev, uint64_t feature);
> +
> +/**
> + * vhost_dev_features() - simple getter for dev->features
> + */
> +uint64_t vhost_dev_features(struct vhost_dev *dev);
> +
> +void vhost_dev_clear_feature(struct vhost_dev *dev, uint64_t feature);

Why not define these as static inline helpers in the header file?


> +
>  #ifdef CONFIG_VHOST
>  int vhost_reset_device(struct vhost_dev *hdev);
>  #else
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 74d26a9497..0af0d3bdd3 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -256,15 +256,14 @@ static bool vhost_vdpa_get_vnet_hash_supported_type=
s(NetClientState *nc,
>  {
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> -    uint64_t features =3D s->vhost_vdpa.dev->features;
>      int fd =3D s->vhost_vdpa.shared->device_fd;
>      struct {
>          struct vhost_vdpa_config hdr;
>          uint32_t supported_hash_types;
>      } config;
>
> -    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
> -        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
> +    if (!vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_HASH_REPO=
RT) &&
> +        !vhost_dev_has_feature(s->vhost_vdpa.dev, VIRTIO_NET_F_RSS)) {
>          return false;
>      }
>
> @@ -585,7 +584,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *n=
c)
>       * If we early return in these cases SVQ will not be enabled. The mi=
gration
>       * will be blocked as long as vhost-vdpa backends will not offer _F_=
LOG.
>       */
> -    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> +    if (!vhost_vdpa_net_valid_svq_features(vhost_dev_features(v->dev), N=
ULL)) {
>          return 0;
>      }
>
> --
> 2.48.1
>
>

