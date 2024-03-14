Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AC0C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkn6b-00074x-BO; Thu, 14 Mar 2024 11:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkn6Z-00074b-I9
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkn6X-0005L7-S7
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710430489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEEVtknUnrLhxYeaPOof3LmohS9luSd5fVUZqHwhoWA=;
 b=b0LFrqyYiZQTRazP7ffH6y/+lvSdZnDjO8/6f94/0EePIwHy3Rizw7OfG/8z9CfDmJYtxp
 TsvlAQnjaQNiNOBK90SCUDOfoO+d2ANlkoBoiMfVZHHpRYzyzzbbwtuNpukTwfgHGttv9v
 syRFdaRt+yLUeVPZTOxV5lZEwY//0t8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-qyW1jYV4PoWPue8WPJkedw-1; Thu, 14 Mar 2024 11:34:47 -0400
X-MC-Unique: qyW1jYV4PoWPue8WPJkedw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-60a54004e9fso21421287b3.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710430486; x=1711035286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEEVtknUnrLhxYeaPOof3LmohS9luSd5fVUZqHwhoWA=;
 b=fZVFf5tWguxlAkFobpbeudeiiyhxGRwgQC6zP+B3LKRsI0lXSXb2korM6pBE2PLUnF
 tg28U8DXyJRaPhTSgTM6BIHx/JlprWh9cIoE5ePg941yocqoSCZ96vUy7G3YTZMQUFcF
 nSIp0ef83K4BdyAwlbaG/rAFN6ik3TvaawledSpNOLIYP1T4OXT8bL/CIvg5o/OuQF7m
 Mdrtdfbmo842TiubODsVJFmrrJS0VxyhtjlcOgiOuwCAJpt7exMeu9F/KZ16F6VJqHPg
 qI26AL8Nknx8eMZ1IRLo4R5rFoUal4zzF9kAePT0LDs+6jXJCh+lTmghbiiutGA+JAGJ
 ZrMQ==
X-Gm-Message-State: AOJu0YypYfNGKwG0KjB9PSfsF3ZmMdUJrdSDeTpmhbH/pzXwZXjFnd9y
 r0joFI0IZ5gwazZbK0yxc6rluahMeuUCGHdy/W1c9SkwI4iJk08T2FhEqpfZPcVFZyG9lIlU3dY
 zdrOoxI7JQ5y3SCnT08j/vusHoi3NpBMv5ajxBXz0J0bc9JIH1V4TEiV8uD102UZnN2q0jeQZq6
 JBX/pQVMcnIfjcXT8uxXfcLHIE1AA=
X-Received: by 2002:a0d:ca8e:0:b0:609:8262:9846 with SMTP id
 m136-20020a0dca8e000000b0060982629846mr2445812ywd.7.1710430486413; 
 Thu, 14 Mar 2024 08:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkTZkxmqwpc5GA+2FiteaY6QfreNoPa1wkaclfUlqinRVczuru73KHxTX/flBTM9K0dHeXxPQedKbThrWYJfQ=
X-Received: by 2002:a0d:ca8e:0:b0:609:8262:9846 with SMTP id
 m136-20020a0dca8e000000b0060982629846mr2445780ywd.7.1710430486070; Thu, 14
 Mar 2024 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
 <1710401215-25490-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1710401215-25490-2-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 16:34:10 +0100
Message-ID: <CAJaqyWfpMpQBTcDGaf+btUWXpZPveXaY4YC9eN1ajz60VihbHw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vhost: Perform memory section dirty scans once per
 iteration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 14, 2024 at 9:38=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
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
> With high memory rates the symptom is lack of convergence as soon
> as it has a vhost device with a sufficiently high number of queues,
> the sufficient number of vhost devices.
>
> On every migration iteration (every 100msecs) it will redundantly
> query the *shared log* the number of queues configured with vhost
> that exist in the guest. For the virtqueue data, this is necessary,
> but not for the memory sections which are the same. So essentially
> we end up scanning the dirty log too often.
>
> To fix that, select a vhost device responsible for scanning the
> log with regards to memory sections dirty tracking. It is selected
> when we enable the logger (during migration) and cleared when we
> disable the logger. If the vhost logger device goes away for some
> reason, the logger will be re-selected from the rest of vhost
> devices.
>
> After making mem-section logger a singleton instance, constant cost
> of 7%-9% (like the 1 queue report) will be seen, no matter how many
> queues or how many vhost devices are configured:
>
> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
> v2 -> v3:
>   - add after-fix benchmark to commit log
>   - rename vhost_log_dev_enabled to vhost_dev_should_log
>   - remove unneeded comparisons for backend_type
>   - use QLIST array instead of single flat list to store vhost
>     logger devices
>   - simplify logger election logic
>
> ---
>  hw/virtio/vhost.c         | 63 +++++++++++++++++++++++++++++++++++++++++=
+-----
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index efe2f74..d91858b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,6 +45,7 @@
>
>  static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>  static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>
>  /* Memslots used by backends that support private memslots (without an f=
d). */
>  static unsigned int used_memslots;
> @@ -149,6 +150,43 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>      }
>  }
>
> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
> +{
> +    assert(dev->vhost_ops);
> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    return dev =3D=3D QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backen=
d_type]);
> +}
> +
> +static inline void vhost_dev_elect_mem_logger(struct vhost_dev *hdev, bo=
ol add)
> +{
> +    VhostBackendType backend_type;
> +
> +    assert(hdev->vhost_ops);
> +
> +    backend_type =3D hdev->vhost_ops->backend_type;
> +    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    if (add && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        if (QLIST_EMPTY(&vhost_log_devs[backend_type])) {
> +            QLIST_INSERT_HEAD(&vhost_log_devs[backend_type],
> +                              hdev, logdev_entry);
> +        } else {
> +            /*
> +             * The first vhost_device in the list is selected as the sha=
red
> +             * logger to scan memory sections. Put new entry next to the=
 head
> +             * to avoid inadvertent change to the underlying logger devi=
ce.
> +             */

Why is changing the logger device a problem? All the code paths are
either changing the QLIST or logging, isn't it?

> +            QLIST_INSERT_AFTER(QLIST_FIRST(&vhost_log_devs[backend_type]=
),
> +                               hdev, logdev_entry);
> +        }
> +    } else if (!add && QLIST_IS_INSERTED(hdev, logdev_entry)) {
> +        QLIST_REMOVE(hdev, logdev_entry);
> +    }
> +}
> +
>  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                     MemoryRegionSection *section,
>                                     hwaddr first,
> @@ -166,12 +204,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev=
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
> +    if (vhost_dev_should_log(dev)) {
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
> @@ -383,6 +423,7 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
>          g_free(log);
>      }
>
> +    vhost_dev_elect_mem_logger(dev, false);
>      dev->log =3D NULL;
>      dev->log_size =3D 0;
>  }
> @@ -998,6 +1039,15 @@ static int vhost_dev_set_log(struct vhost_dev *dev,=
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
> +    vhost_dev_elect_mem_logger(dev, enable_log);
> +
>      return 0;
>  err_vq:
>      for (; i >=3D 0; --i) {
> @@ -2073,6 +2123,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>              VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
>              goto fail_log;
>          }
> +        vhost_dev_elect_mem_logger(hdev, true);
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


