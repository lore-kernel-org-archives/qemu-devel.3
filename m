Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD0C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 10:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLGd-0008O0-FI; Tue, 18 Feb 2025 05:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkLGa-0008Nf-Af
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkLGX-00039G-Kd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 05:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739876147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf09oegmsoo42Zl4PfndDm+++JSLqS6xP8vo0mDG3BI=;
 b=GdB/JsZhmGpHgut9Rz3kxQStw2+/vcIhaTPWjkdm/1/1c14EqeCAt/VqlJxv0qsvytJSRj
 NT9FOE9DzqrWTqQgJRgGOuxugaWSkZefDgnFRytBpooZtctxVlR1PF6xspTGTOeuSYR0RK
 NAmdryZqty9yYZpbQpsxUwqoGY5qio8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-hBnsMVCTM7ik4ACw2g_Bug-1; Tue, 18 Feb 2025 05:55:46 -0500
X-MC-Unique: hBnsMVCTM7ik4ACw2g_Bug-1
X-Mimecast-MFC-AGG-ID: hBnsMVCTM7ik4ACw2g_Bug_1739876145
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f816a85facso10641250a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 02:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739876145; x=1740480945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bf09oegmsoo42Zl4PfndDm+++JSLqS6xP8vo0mDG3BI=;
 b=FCxf2DuXittveDzvlnJ5Tc3R6+jg/OgEf+pCzmTHROvCL3uoGdxvB+AfRE4QDdngql
 twTjvvM8bXqOtPJjx9q8o042fw/Jyf75xDhu0Z718xn9vORdI1xvfsMNEEpfSabbNL6g
 D2eUgRpkJRjHrV9hcBaO/NrZr894xjekVZc7AJRUtnIh6YXVrDxsn0EhErSwBRUwjJJX
 YYQhL7IyftI/EV2JB2q5BgMTZl220twUm96vT+IlGOIYKUVgHhzWpbSCYuL1TcBZ0y6Q
 FiaIPHScqq8hEYD+WvjhhPfRdqF5/y/5JMr55LySFMTHpI3x2vt+FbpObrOVJnqe4/Ot
 k2+Q==
X-Gm-Message-State: AOJu0Yz94kWuiaUq4UKgcDMe1B80iYOUB8KvJgZQo8z2PRRWlnHejF62
 OoWYyikB1N8x41flIaQRYoTfv3NbO/C0NtQMSkl1fO77foc/Gh7tbCjcO0AKg9I6RwFDc4Xz7uf
 8Yrg17sXxL8VAzxgQVuyVo/0RpsHN+1sghIE7MR0yytfAbSN6regodcvVSAuQzvq31AvrkynySW
 /yfyUVYsZZjNBlO+SHyu5T8AkaN+w=
X-Gm-Gg: ASbGncvZFRCvVVFOzaYlKr0McxQ/cK/O2DIag973NUPL1s5H/JPc6qfS4wxZKBBi3zF
 krNd39JBzOSr7pOBccfOeBaTpxMj1S4Z817x1UFtm9h6HmCNwoUAf/8Y4nyzuH8fo
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2fc40f22d67mr24023497a91.18.1739876145404; 
 Tue, 18 Feb 2025 02:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmMkfEH8n5Kdd1iGdvdUtTbWJ6/xjLg/rDtDFx9Tdd0Cgv4RZp+hwB8Zsxwt6V/oxXqEMbVlJvKmbD+PWLPc8=
X-Received: by 2002:a17:90b:3d86:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2fc40f22d67mr24023461a91.18.1739876145025; Tue, 18 Feb 2025
 02:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-8-aesteve@redhat.com>
 <20250218104116.GK10767@fedora>
In-Reply-To: <20250218104116.GK10767@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Feb 2025 11:55:33 +0100
X-Gm-Features: AWEUYZn68J3azwqBdjd_3KqAf8vbCSpsF8g5bLocw2YKKSdB_nwuaUGM88I3FYY
Message-ID: <CADSE00+-uisJfHWCe0sFTy1fXrqB7K_yWnm-xZSxAmf1=fVpAA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] vhost-user-devive: Add shmem BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 18, 2025 at 11:41=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Feb 17, 2025 at 05:40:10PM +0100, Albert Esteve wrote:
> > Add a shmem BAR block in the vhost-user-device,
> > which files can be directly mapped into.
> >
> > The number, shmid, and size of the VIRTIO Shared
> > Memory subregions is retrieved through a
> > get_shmem_config message sent by the
> > vhost-user-base module on the realize step,
> > after virtio_init().
> >
> > By default, if VHOST_USER_PROTOCOL_F_SHMEM
> > feature is not supported by the backend,
> > there is no cache.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 36 +++++++++++++++++++++--
> >  2 files changed, 78 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index 2bc3423326..8d4bca98a8 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -16,6 +16,7 @@
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/vhost-user-base.h"
> >  #include "qemu/error-report.h"
> > +#include "migration/blocker.h"
> >
> >  static void vub_start(VirtIODevice *vdev)
> >  {
> > @@ -271,7 +272,8 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > -    int ret;
> > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > +    int i, ret, nregions;
> >
> >      if (!vub->chardev.chr) {
> >          error_setg(errp, "vhost-user-base: missing chardev");
> > @@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >
> >      /* Allocate queues */
> >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > +    for (i =3D 0; i < vub->num_vqs; i++) {
> >          g_ptr_array_add(vub->vqs,
> >                          virtio_add_queue(vdev, vub->vq_size,
> >                                           vub_handle_output));
> > @@ -328,11 +330,50 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> >                           VHOST_BACKEND_TYPE_USER, 0, errp);
> >
> >      if (ret < 0) {
> > -        do_vhost_user_cleanup(vdev, vub);
> > +        goto err;
> > +    }
> > +
> > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vho=
st_dev,
> > +                                                           &nregions,
> > +                                                           memory_size=
s,
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        goto err;
> > +    }
> > +
> > +    for (i =3D 0; i < nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> > +                error_setg(&vub->vhost_dev.migration_blocker,
> > +                       "Migration disabled: devices with VIRTIO Shared=
 Memory "
> > +                       "Regions do not support migration yet.");
> > +                ret =3D migrate_add_blocker_normal(
> > +                    &vub->vhost_dev.migration_blocker,
> > +                    errp);
> > +
> > +                if (ret < 0) {
> > +                    goto err;
> > +                }
> > +            }
> > +
> > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> > +                error_setg(errp, "Shared memory %d size must be a powe=
r of 2 "
> > +                                 "no smaller than the page size", i);
> > +                goto err;
> > +            }
> > +
> > +            memory_region_init(virtio_new_shmem_region(vdev)->mr,
>
> Does this code support non-contiguous shmids? For example, if a device
> has two Shared Memory Regions defined in its spec but the first one is
> optional, then the device might have memory_sizes[0] =3D=3D 0 and
> memory_sizes[1] > 0. In that case the Shared Memory Region must have
> shmid 1 and not shmid 0.

Yes, it does. That is guarded by ` if (memory_sizes[i]) {`, which only
initializes the region if memory_sizes[i] > 0. The main downsize of
that, is that it requires to send as many `memory_sizes` elements as
the highest shmid for the device. But as it is, it is supported by
this code.

>
> > +                               OBJECT(vdev), "vub-shm-" + i,
> > +                               memory_sizes[i]);
> > +        }
> >      }
> >
> >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NUL=
L,
> >                               dev, NULL, true);
> > +    return;
> > +err:
> > +    do_vhost_user_cleanup(vdev, vub);
> >  }
> >
> >  static void vub_device_unrealize(DeviceState *dev)
> > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-d=
evice-pci.c
> > index efaf55d3dd..f215cae925 100644
> > --- a/hw/virtio/vhost-user-device-pci.c
> > +++ b/hw/virtio/vhost-user-device-pci.c
> > @@ -8,14 +8,18 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qapi/error.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/virtio/vhost-user-base.h"
> >  #include "hw/virtio/virtio-pci.h"
> >
> > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 2
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion shmembar;
> >  };
> >
> >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > @@ -25,10 +29,38 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOS=
T_USER_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Er=
ror **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    MemoryRegion *mr;
> > +    uint64_t offset =3D 0, shmem_size =3D 0;
> > +    int i;
> >
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +        mr =3D vdev->shmem_list[i].mr;
> > +        if (mr->size > UINT64_MAX - shmem_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        shmem_size =3D shmem_size + mr->size;
> > +    }
> > +    if (shmem_size) {
> > +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-shmembar", shmem_size);
> > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +            memory_region_add_subregion(&dev->shmembar, offset, mr);
> > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                                   offset, mr->size, i);
> > +            offset =3D offset + mr->size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->shmembar);
> > +    }
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass, void =
*data)
> > --
> > 2.48.1
> >


