Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C329C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhwET-0006uH-EH; Wed, 06 Mar 2024 13:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhwER-0006u6-Lg
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhwEP-0000MR-TR
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709750588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+AohXnWAf5Oho4bFtMGTQVd+BThZYiG7mAT29CRKSg=;
 b=N6iIv/mCOM5zADfKNVAM9DiCK8bDHJ2VTMdpMShOLPXxYcFZ3PdjUP385egRk4wEDOINMR
 /PVEMD3hvXqFTezmFyQ9hh9I1FEl/ZQo7u3Vkro4q2tDpNjGS8WDtACz0tplfVy7z6rqUZ
 1j1kWjZO6XM9vlJjpTOOLKpDY4+iVHw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-QnqpamjNNCmXRdAC1bHztA-1; Wed, 06 Mar 2024 13:43:07 -0500
X-MC-Unique: QnqpamjNNCmXRdAC1bHztA-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc693399655so13336342276.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 10:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709750567; x=1710355367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+AohXnWAf5Oho4bFtMGTQVd+BThZYiG7mAT29CRKSg=;
 b=krD+7e6qbBElYaHuyrTXVWZFAqZP1QsSb7Pu6zxHc7cTr2CfIr9NdoWQZeks0eWpp9
 ssLN8fVnG6mdt93at4Vg0aFfdZSBmwVNB+DLiJVueZzLyp/MO/qVMDAyzSDxrVZDsEDg
 ev9aZOaZ70LwLf+JW7Ec23vspS+finKQAvCmujS5bJpLOwmrAdC+x9W1uLmTX0HPL/YU
 sAOKO7i1QyDEdcgT/t2k1k+qHBFOJZ0ZHkDBoPBWNWaGPF7XfzuOFKO7qFNfIPgoWvbX
 32G2LfEQtSyhp7+lbgn8c/GfpYInzoU3D7WnM9VxjZ6tsysEQEUChrLCvkL8MXCl2u21
 hjtw==
X-Gm-Message-State: AOJu0Ywv8XiVv+FFIHh6NaQWg8L4yqXo6Xfkozngk64I9GT09Bg5KjrN
 8vmGUn/EDDxBPFuV/bIU3vWUO655N/xRg8mU3+Y5YpDvnFTOCciyf79dRemKVErim/kTw2b1u9B
 4J4jaV94rLRUdEhb8k7qm5GJTzgkruMACJoydYhv3RNYM5KKgq5pnryc5c7EPy3Bm5xG3Q9EhEa
 z0JsiM7gL+EsqbvFstXbo3AgxfgH4=
X-Received: by 2002:a25:bf89:0:b0:dcc:d5aa:af36 with SMTP id
 l9-20020a25bf89000000b00dccd5aaaf36mr14480054ybk.44.1709750567086; 
 Wed, 06 Mar 2024 10:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEETdJdjHGkwXlPR9njcAoKx9LQzOCugjqxHfCoJQYjkuKVMc6p/cnM1+X/8dNpB55LsnbDn5g7T+NFmOxJ+Qk=
X-Received: by 2002:a25:bf89:0:b0:dcc:d5aa:af36 with SMTP id
 l9-20020a25bf89000000b00dccd5aaaf36mr14480035ybk.44.1709750566726; Wed, 06
 Mar 2024 10:42:46 -0800 (PST)
MIME-Version: 1.0
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
 <1707911419-11758-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1707911419-11758-2-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 6 Mar 2024 19:42:10 +0100
Message-ID: <CAJaqyWdAD=YGQ=_nZAdTFa5Bpx4Luou3b+gZO5C3nYqy+wjQOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: Perform memory section dirty scans once per
 iteration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 2:02=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> On setups with one or more virtio-net devices with vhost on,
> dirty tracking iteration increases cost the bigger the number
> amount of queues are set up e.g. on idle guests migration the
> following is observed with virtio-net with vhost=3Don:
>
> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>

I think the after benchmark should also be included.

> With high memory rates the symptom is lack of convergence as soon
> as it has a vhost device with a sufficiently high number of queues,
> the sufficient number of vhost devices.
>
> On every migration iteration (every 100msecs) it will redundantly
> query the *shared log* the number of queues configured with vhost
> that exist in the guest. For the virtqueue data, this is necessary,
> but not for the memory sections which are the same. So
> essentially we end up scanning the dirty log too often.
>
> To fix that, select a vhost device responsible for scanning the
> log with regards to memory sections dirty tracking. It is selected
> when we enable the logger (during migration) and cleared when we
> disable the logger. If the vhost logger device goes away for some
> reason, the logger will be re-selected from the rest of vhost
> devices.
>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost.c         | 75 +++++++++++++++++++++++++++++++++++++++++=
++----
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 70 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ef6d9b5..997d560 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,6 +45,9 @@
>
>  static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>  static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> +static struct vhost_dev *vhost_mem_logger[VHOST_BACKEND_TYPE_MAX];
> +static QLIST_HEAD(, vhost_dev) vhost_mlog_devices =3D
> +    QLIST_HEAD_INITIALIZER(vhost_mlog_devices);
>
>  /* Memslots used by backends that support private memslots (without an f=
d). */
>  static unsigned int used_memslots;
> @@ -149,6 +152,53 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>      }
>  }
>
> +static bool vhost_log_dev_enabled(struct vhost_dev *dev)

"Enabled" sounds misleading to me. Maybe vhost_dev_should_log? More
suggestions below.

> +{
> +    assert(dev->vhost_ops);
> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    return dev =3D=3D vhost_mem_logger[dev->vhost_ops->backend_type];
> +}
> +
> +static void vhost_mlog_set_dev(struct vhost_dev *hdev, bool enable)
> +{
> +    struct vhost_dev *logdev =3D NULL;
> +    VhostBackendType backend_type;
> +    bool reelect =3D false;
> +
> +    assert(hdev->vhost_ops);
> +    assert(hdev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(hdev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    backend_type =3D hdev->vhost_ops->backend_type;
> +
> +    if (enable && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        reelect =3D !vhost_mem_logger[backend_type];
> +        QLIST_INSERT_HEAD(&vhost_mlog_devices, hdev, logdev_entry);
> +    } else if (!enable && QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        reelect =3D vhost_mem_logger[backend_type] =3D=3D hdev;
> +        QLIST_REMOVE(hdev, logdev_entry);
> +    }
> +
> +    if (!reelect)
> +        return;
> +
> +    QLIST_FOREACH(hdev, &vhost_mlog_devices, logdev_entry) {
> +        if (!hdev->vhost_ops ||
> +            hdev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_NONE=
 ||
> +            hdev->vhost_ops->backend_type >=3D VHOST_BACKEND_TYPE_MAX)

Aren't comparisons with ops->backend_type already contained in the
following "hdev->vhost_ops->backend_type =3D=3D backend_type" ?

> +            continue;
> +
> +        if (hdev->vhost_ops->backend_type =3D=3D backend_type) {
> +            logdev =3D hdev;
> +            break;
> +        }

Why not use VHOST_BACKEND_TYPE_MAX QLISTs, and then simply check if
*dev is the head at vhost_log_dev_enabled?

That way we can remove this foreach and vhost_log_dev_enabled
entirely, as the check is simpler. I think it could even remove this
function entirely and inline QLIST_INSERT / QLIST_REMOVE at callers.
What do you think?

Thanks!

> +    }
> +
> +    vhost_mem_logger[backend_type] =3D logdev;
> +}
> +
>  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                     MemoryRegionSection *section,
>                                     hwaddr first,
> @@ -166,12 +216,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev=
 *dev,
>      start_addr =3D MAX(first, start_addr);
>      end_addr =3D MIN(last, end_addr);
>
> -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> -        vhost_dev_sync_region(dev, section, start_addr, end_addr,
> -                              reg->guest_phys_addr,
> -                              range_get_last(reg->guest_phys_addr,
> -                                             reg->memory_size));
> +    if (vhost_log_dev_enabled(dev)) {
> +        for (i =3D 0; i < dev->mem->nregions; ++i) {
> +            struct vhost_memory_region *reg =3D dev->mem->regions + i;
> +            vhost_dev_sync_region(dev, section, start_addr, end_addr,
> +                                  reg->guest_phys_addr,
> +                                  range_get_last(reg->guest_phys_addr,
> +                                                 reg->memory_size));
> +        }
>      }
>      for (i =3D 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq =3D dev->vqs + i;
> @@ -382,6 +434,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
>          g_free(log);
>      }
>
> +    vhost_mlog_set_dev(dev, false);
>      dev->log =3D NULL;
>      dev->log_size =3D 0;
>  }
> @@ -997,6 +1050,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev,=
 bool enable_log)
>              goto err_vq;
>          }
>      }
> +
> +    /*
> +     * At log start we select our vhost_device logger that will scan the
> +     * memory sections and skip for the others. This is possible because
> +     * the log is shared amongst all vhost devices for a given type of
> +     * backend.
> +     */
> +    vhost_mlog_set_dev(dev, enable_log);
> +
>      return 0;
>  err_vq:
>      for (; i >=3D 0; --i) {
> @@ -2072,6 +2134,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>              VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
>              goto fail_log;
>          }
> +        vhost_mlog_set_dev(hdev, true);
>      }
>      if (vrings) {
>          r =3D vhost_dev_set_vring_enable(hdev, true);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 0247778..d75faf4 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -129,6 +129,7 @@ struct vhost_dev {
>      void *opaque;
>      struct vhost_log *log;
>      QLIST_ENTRY(vhost_dev) entry;
> +    QLIST_ENTRY(vhost_dev) logdev_entry;
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
>      const VhostDevConfigOps *config_ops;
> --
> 1.8.3.1
>
>


