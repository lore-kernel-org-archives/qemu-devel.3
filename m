Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ADAC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqR5-0007Wc-PU; Thu, 14 Mar 2024 15:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkqR3-0007W9-OO
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkqR0-0002Qf-Qw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710443290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEsFE57FIIQ5/jpmZ387bmDLy+ZyAANQezz0Kgbj8uo=;
 b=QRH7dj7jsw+VfZsh/IDMI5TUV2PAnPgnxhWQTj7BQ6YgbCaw6YYGuWCJVh1598+qfZ76Fh
 uHZsGOTmwCWJfxGVkyYy4a4Ld2keX1wp9Wzq+kPGRO9f7ZnrilndLqaE7sqx6DeWVctej2
 vvPER6gmiVnXK0qqllq1RuOSnKshtM4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-tVT2a9oUPDejG_zV7OpxiQ-1; Thu, 14 Mar 2024 15:08:08 -0400
X-MC-Unique: tVT2a9oUPDejG_zV7OpxiQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcdc3db67f0so2747640276.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710443288; x=1711048088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEsFE57FIIQ5/jpmZ387bmDLy+ZyAANQezz0Kgbj8uo=;
 b=OGyR3CCuXSLtGa24KgLgaj4VBFoARoH2iszo4HTlAvkS1/fKksazxTD45JTZf/riaP
 qHEuQxvyxOAYvq1q68uA27c5mDYzrf8X9dPQ8drfh2rsY8VYcPM4A1pjhZlUIVYBt8he
 SCfrzA2nVq7t/AvhgQulCRSHTqblouCg/qoSPsehTmg3Ou4oMA5waxUkYbiLRAMuxWO+
 /N/B3fxMIl6KhKzp+05HixtO3NkiexaSn3CCTe3IdPzYW6xz76/S2rha4r8kFIKwG+5H
 Up3F6dmN+27fF61Rj0z77ab7aLHQInsrYkidf9maWXqAYvdAF82QYT0NqFz7HooU0D4V
 lmjw==
X-Gm-Message-State: AOJu0YwEPAO5dJd+gE9Dtv2MYTQrAd/f885CrC0Y1BGc2RE6C2cNazAi
 CsB1OFAkHclG5hT2CyHyw3y+e5cE1OkvJ+WN5UZ8x4zGG3GmIJVTsjrzh35t6QnuAvePT8IyF/W
 WJ87r1VDo7e0ybYF7AoOcUtffRCJ778yPmzi4Svb3jAknc1hOlMqmuCc4VjyABbkzPXGH0YmVNk
 Flyz/66vtRfM5kVcpV/BUDUFhCtAQ=
X-Received: by 2002:a25:2688:0:b0:dcb:df38:1c20 with SMTP id
 m130-20020a252688000000b00dcbdf381c20mr2109840ybm.24.1710443288166; 
 Thu, 14 Mar 2024 12:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExDw4/rBfjY8VXqVa/8RcVqzi034ODAZMCxPGdAh8+q8T/HW1yr3SeWDJm9lf3sgD/jJKNU94AFfXSSIf0tH4=
X-Received: by 2002:a25:2688:0:b0:dcb:df38:1c20 with SMTP id
 m130-20020a252688000000b00dcbdf381c20mr2109822ybm.24.1710443287820; Thu, 14
 Mar 2024 12:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <1710401215-25490-1-git-send-email-si-wei.liu@oracle.com>
 <1710401215-25490-2-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWfpMpQBTcDGaf+btUWXpZPveXaY4YC9eN1ajz60VihbHw@mail.gmail.com>
 <4eab5964-9627-4021-9e8f-c105e24d7254@oracle.com>
In-Reply-To: <4eab5964-9627-4021-9e8f-c105e24d7254@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 20:07:32 +0100
Message-ID: <CAJaqyWcmQnaVVZAKVxkOiVy7m=nccGs+iqkwwPh61y45JONVJw@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 7:35=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/14/2024 8:34 AM, Eugenio Perez Martin wrote:
> > On Thu, Mar 14, 2024 at 9:38=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> On setups with one or more virtio-net devices with vhost on,
> >> dirty tracking iteration increases cost the bigger the number
> >> amount of queues are set up e.g. on idle guests migration the
> >> following is observed with virtio-net with vhost=3Don:
> >>
> >> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> >> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> >> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> >> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> >>
> >> With high memory rates the symptom is lack of convergence as soon
> >> as it has a vhost device with a sufficiently high number of queues,
> >> the sufficient number of vhost devices.
> >>
> >> On every migration iteration (every 100msecs) it will redundantly
> >> query the *shared log* the number of queues configured with vhost
> >> that exist in the guest. For the virtqueue data, this is necessary,
> >> but not for the memory sections which are the same. So essentially
> >> we end up scanning the dirty log too often.
> >>
> >> To fix that, select a vhost device responsible for scanning the
> >> log with regards to memory sections dirty tracking. It is selected
> >> when we enable the logger (during migration) and cleared when we
> >> disable the logger. If the vhost logger device goes away for some
> >> reason, the logger will be re-selected from the rest of vhost
> >> devices.
> >>
> >> After making mem-section logger a singleton instance, constant cost
> >> of 7%-9% (like the 1 queue report) will be seen, no matter how many
> >> queues or how many vhost devices are configured:
> >>
> >> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
> >> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
> >>
> >> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >> v2 -> v3:
> >>    - add after-fix benchmark to commit log
> >>    - rename vhost_log_dev_enabled to vhost_dev_should_log
> >>    - remove unneeded comparisons for backend_type
> >>    - use QLIST array instead of single flat list to store vhost
> >>      logger devices
> >>    - simplify logger election logic
> >>
> >> ---
> >>   hw/virtio/vhost.c         | 63 +++++++++++++++++++++++++++++++++++++=
+++++-----
> >>   include/hw/virtio/vhost.h |  1 +
> >>   2 files changed, 58 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index efe2f74..d91858b 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -45,6 +45,7 @@
> >>
> >>   static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >>   static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> >> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX]=
;
> >>
> >>   /* Memslots used by backends that support private memslots (without =
an fd). */
> >>   static unsigned int used_memslots;
> >> @@ -149,6 +150,43 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
> >>       }
> >>   }
> >>
> >> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
> >> +{
> >> +    assert(dev->vhost_ops);
> >> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> >> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> >> +
> >> +    return dev =3D=3D QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->bac=
kend_type]);
> >> +}
> >> +
> >> +static inline void vhost_dev_elect_mem_logger(struct vhost_dev *hdev,=
 bool add)
> >> +{
> >> +    VhostBackendType backend_type;
> >> +
> >> +    assert(hdev->vhost_ops);
> >> +
> >> +    backend_type =3D hdev->vhost_ops->backend_type;
> >> +    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
> >> +    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
> >> +
> >> +    if (add && !QLIST_IS_INSERTED(hdev, logdev_entry)) {
> >> +        if (QLIST_EMPTY(&vhost_log_devs[backend_type])) {
> >> +            QLIST_INSERT_HEAD(&vhost_log_devs[backend_type],
> >> +                              hdev, logdev_entry);
> >> +        } else {
> >> +            /*
> >> +             * The first vhost_device in the list is selected as the =
shared
> >> +             * logger to scan memory sections. Put new entry next to =
the head
> >> +             * to avoid inadvertent change to the underlying logger d=
evice.
> >> +             */
> > Why is changing the logger device a problem? All the code paths are
> > either changing the QLIST or logging, isn't it?
> Changing logger device doesn't affect functionality for sure, but may
> have inadvertent effect on cache locality, particularly it's relevant to
> the log scanning process in the hot path. The code makes sure there's no
> churn on the leading logger selection as a result of adding new vhost
> device, unless the selected logger device will be gone and a re-election
> of another logger is needed.
>

Understood, thanks for the explanation! If you're going to send a new
version I suggest adding that to the comment.

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> -Siwei
>
> >
> >> +            QLIST_INSERT_AFTER(QLIST_FIRST(&vhost_log_devs[backend_ty=
pe]),
> >> +                               hdev, logdev_entry);
> >> +        }
> >> +    } else if (!add && QLIST_IS_INSERTED(hdev, logdev_entry)) {
> >> +        QLIST_REMOVE(hdev, logdev_entry);
> >> +    }
> >> +}
> >> +
> >>   static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
> >>                                      MemoryRegionSection *section,
> >>                                      hwaddr first,
> >> @@ -166,12 +204,14 @@ static int vhost_sync_dirty_bitmap(struct vhost_=
dev *dev,
> >>       start_addr =3D MAX(first, start_addr);
> >>       end_addr =3D MIN(last, end_addr);
> >>
> >> -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> >> -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> >> -        vhost_dev_sync_region(dev, section, start_addr, end_addr,
> >> -                              reg->guest_phys_addr,
> >> -                              range_get_last(reg->guest_phys_addr,
> >> -                                             reg->memory_size));
> >> +    if (vhost_dev_should_log(dev)) {
> >> +        for (i =3D 0; i < dev->mem->nregions; ++i) {
> >> +            struct vhost_memory_region *reg =3D dev->mem->regions + i=
;
> >> +            vhost_dev_sync_region(dev, section, start_addr, end_addr,
> >> +                                  reg->guest_phys_addr,
> >> +                                  range_get_last(reg->guest_phys_addr=
,
> >> +                                                 reg->memory_size));
> >> +        }
> >>       }
> >>       for (i =3D 0; i < dev->nvqs; ++i) {
> >>           struct vhost_virtqueue *vq =3D dev->vqs + i;
> >> @@ -383,6 +423,7 @@ static void vhost_log_put(struct vhost_dev *dev, b=
ool sync)
> >>           g_free(log);
> >>       }
> >>
> >> +    vhost_dev_elect_mem_logger(dev, false);
> >>       dev->log =3D NULL;
> >>       dev->log_size =3D 0;
> >>   }
> >> @@ -998,6 +1039,15 @@ static int vhost_dev_set_log(struct vhost_dev *d=
ev, bool enable_log)
> >>               goto err_vq;
> >>           }
> >>       }
> >> +
> >> +    /*
> >> +     * At log start we select our vhost_device logger that will scan =
the
> >> +     * memory sections and skip for the others. This is possible beca=
use
> >> +     * the log is shared amongst all vhost devices for a given type o=
f
> >> +     * backend.
> >> +     */
> >> +    vhost_dev_elect_mem_logger(dev, enable_log);
> >> +
> >>       return 0;
> >>   err_vq:
> >>       for (; i >=3D 0; --i) {
> >> @@ -2073,6 +2123,7 @@ int vhost_dev_start(struct vhost_dev *hdev, Virt=
IODevice *vdev, bool vrings)
> >>               VHOST_OPS_DEBUG(r, "vhost_set_log_base failed");
> >>               goto fail_log;
> >>           }
> >> +        vhost_dev_elect_mem_logger(hdev, true);
> >>       }
> >>       if (vrings) {
> >>           r =3D vhost_dev_set_vring_enable(hdev, true);
> >> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >> index 0247778..d75faf4 100644
> >> --- a/include/hw/virtio/vhost.h
> >> +++ b/include/hw/virtio/vhost.h
> >> @@ -129,6 +129,7 @@ struct vhost_dev {
> >>       void *opaque;
> >>       struct vhost_log *log;
> >>       QLIST_ENTRY(vhost_dev) entry;
> >> +    QLIST_ENTRY(vhost_dev) logdev_entry;
> >>       QLIST_HEAD(, vhost_iommu) iommu_list;
> >>       IOMMUNotifier n;
> >>       const VhostDevConfigOps *config_ops;
> >> --
> >> 1.8.3.1
> >>
>


