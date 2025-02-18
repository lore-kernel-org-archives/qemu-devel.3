Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0742EC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkP99-0000sZ-7o; Tue, 18 Feb 2025 10:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkP97-0000rw-Iq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tkP95-00048e-5E
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739891061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+QUCUKOG/ZLCL2Bj+1396e6XOhmqUB0EHip1Xhcq20=;
 b=GGQkwHvXpjOUTk8XLfkRlLVk9d+iexDwI4B7W+H33AMa2u4mQcNzC8K6XkxWAEez6Q6xGD
 SwiwC7MLPz22Zpjo1zwn5MOJkv1ccSnJZp34b1Ic1XXfNRfNOrFTjqDxL5Lw3dN3Xq7cCx
 vdgxuKGhLwE/6bTosYG/Kqd1ot18Co0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-eXNccJHZO1eWTn2WX4PDEA-1; Tue, 18 Feb 2025 10:04:15 -0500
X-MC-Unique: eXNccJHZO1eWTn2WX4PDEA-1
X-Mimecast-MFC-AGG-ID: eXNccJHZO1eWTn2WX4PDEA_1739891055
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fc57652924so5594241a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739891055; x=1740495855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+QUCUKOG/ZLCL2Bj+1396e6XOhmqUB0EHip1Xhcq20=;
 b=lN3y8HVnKHd55VuPyMcnjefl6LT+5Ue+iCJw+/fQDVBY4Peqh7gCsHaopPsrHwgd6L
 W7JMgrCCyfoC4ThDJasU5pCjZztrbYzVckMwqM6nTcQUSWowiqPVzL5aFKLaZkRhMvzA
 kZJk1lQRzkMJYJMiyXlYzlq/pb2wpRUBbtc/6yBMamZVndTxrRrnkwTxuMcc6HrCEfQX
 Ve2R2XOHTSQAKsvnYMceQU+4ry5wZ1LtONyI9zBNwrzCI4BRddbQiQBjTDOCOuhq/IJq
 sDooeOapU5FO0Hq9xcJyZa7QSvWloKsYECVdx5ENrX8qVqGDj0MOu/T8zmqCjKUscFtC
 c+3w==
X-Gm-Message-State: AOJu0YwAY5wVJhH2I/MAJidJNLJ5dL/5jJhNASxUQv7dxp/qeJBCfFrH
 YaF8wK0deJa3uqv8ZCtcvE05em9ljuyJg3ZmAT1VgwPth7DCzZ21Q06fI0dCiSSJ0blMlOrNvSI
 LlLX4xYFEcmF8/If6lp/K0+zoXgGAecJ/jRAJvO3VLP0gsU/UvE4UGRui71rNUbsdRoLmiFTiA1
 czwvYkKN5zQV+3vtmD+1z0R7/pM+E=
X-Gm-Gg: ASbGncvFjy4EKFQMiHEcHqP+WXRVL54grGDfNyLkC0wYbnAnyDWlwz2Eo2ThhgGnC3w
 jbikEuWWIANEUZ29x0bW8Q00ASmAiBYl+3fVkw1DCAW5BmkgDyuGsnNRmTsjXHo+i
X-Received: by 2002:a17:90b:4cd2:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-2fcb4d80a53mr39774a91.17.1739891054727; 
 Tue, 18 Feb 2025 07:04:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSDFKdEgOrrUWDx/RKupBpHSOj2F0DfGN3rARyr7xLHEQ1W+euZdeqq5PSTdSTy5oRY5K2aUdDSnu/g6il/Fo=
X-Received: by 2002:a17:90b:4cd2:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-2fcb4d80a53mr39723a91.17.1739891054296; Tue, 18 Feb 2025
 07:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <20250217164012.246727-8-aesteve@redhat.com>
 <20250218104116.GK10767@fedora>
 <CADSE00+-uisJfHWCe0sFTy1fXrqB7K_yWnm-xZSxAmf1=fVpAA@mail.gmail.com>
 <20250218132516.GA28047@fedora>
In-Reply-To: <20250218132516.GA28047@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Feb 2025 16:04:02 +0100
X-Gm-Features: AWEUYZkc2A6xX80q7i7kmznBjcGYzYnq7DcvAe--sDh-nYdmg-BPBQ-Ua2MgzHA
Message-ID: <CADSE00JX4g+j6ic+ATQ1r7FXogZRZsRwqJiyTLJ=wWaPi2Mgww@mail.gmail.com>
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

On Tue, Feb 18, 2025 at 2:29=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Feb 18, 2025 at 11:55:33AM +0100, Albert Esteve wrote:
> > On Tue, Feb 18, 2025 at 11:41=E2=80=AFAM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > On Mon, Feb 17, 2025 at 05:40:10PM +0100, Albert Esteve wrote:
> > > > Add a shmem BAR block in the vhost-user-device,
> > > > which files can be directly mapped into.
> > > >
> > > > The number, shmid, and size of the VIRTIO Shared
> > > > Memory subregions is retrieved through a
> > > > get_shmem_config message sent by the
> > > > vhost-user-base module on the realize step,
> > > > after virtio_init().
> > > >
> > > > By default, if VHOST_USER_PROTOCOL_F_SHMEM
> > > > feature is not supported by the backend,
> > > > there is no cache.
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++=
++--
> > > >  hw/virtio/vhost-user-device-pci.c | 36 +++++++++++++++++++++--
> > > >  2 files changed, 78 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-bas=
e.c
> > > > index 2bc3423326..8d4bca98a8 100644
> > > > --- a/hw/virtio/vhost-user-base.c
> > > > +++ b/hw/virtio/vhost-user-base.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include "hw/virtio/virtio-bus.h"
> > > >  #include "hw/virtio/vhost-user-base.h"
> > > >  #include "qemu/error-report.h"
> > > > +#include "migration/blocker.h"
> > > >
> > > >  static void vub_start(VirtIODevice *vdev)
> > > >  {
> > > > @@ -271,7 +272,8 @@ static void vub_device_realize(DeviceState *dev=
, Error **errp)
> > > >  {
> > > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > > > -    int ret;
> > > > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > > > +    int i, ret, nregions;
> > > >
> > > >      if (!vub->chardev.chr) {
> > > >          error_setg(errp, "vhost-user-base: missing chardev");
> > > > @@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev=
, Error **errp)
> > > >
> > > >      /* Allocate queues */
> > > >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > > > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > > > +    for (i =3D 0; i < vub->num_vqs; i++) {
> > > >          g_ptr_array_add(vub->vqs,
> > > >                          virtio_add_queue(vdev, vub->vq_size,
> > > >                                           vub_handle_output));
> > > > @@ -328,11 +330,50 @@ static void vub_device_realize(DeviceState *d=
ev, Error **errp)
> > > >                           VHOST_BACKEND_TYPE_USER, 0, errp);
> > > >
> > > >      if (ret < 0) {
> > > > -        do_vhost_user_cleanup(vdev, vub);
> > > > +        goto err;
> > > > +    }
> > > > +
> > > > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub-=
>vhost_dev,
> > > > +                                                           &nregio=
ns,
> > > > +                                                           memory_=
sizes,
> > > > +                                                           errp);
> > > > +
> > > > +    if (ret < 0) {
> > > > +        goto err;
> > > > +    }
> > > > +
> > > > +    for (i =3D 0; i < nregions; i++) {
> > > > +        if (memory_sizes[i]) {
> > > > +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> > > > +                error_setg(&vub->vhost_dev.migration_blocker,
> > > > +                       "Migration disabled: devices with VIRTIO Sh=
ared Memory "
> > > > +                       "Regions do not support migration yet.");
> > > > +                ret =3D migrate_add_blocker_normal(
> > > > +                    &vub->vhost_dev.migration_blocker,
> > > > +                    errp);
> > > > +
> > > > +                if (ret < 0) {
> > > > +                    goto err;
> > > > +                }
> > > > +            }
> > > > +
> > > > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D =
0) {
> > > > +                error_setg(errp, "Shared memory %d size must be a =
power of 2 "
> > > > +                                 "no smaller than the page size", =
i);
> > > > +                goto err;
> > > > +            }
> > > > +
> > > > +            memory_region_init(virtio_new_shmem_region(vdev)->mr,
> > >
> > > Does this code support non-contiguous shmids? For example, if a devic=
e
> > > has two Shared Memory Regions defined in its spec but the first one i=
s
> > > optional, then the device might have memory_sizes[0] =3D=3D 0 and
> > > memory_sizes[1] > 0. In that case the Shared Memory Region must have
> > > shmid 1 and not shmid 0.
> >
> > Yes, it does. That is guarded by ` if (memory_sizes[i]) {`, which only
> > initializes the region if memory_sizes[i] > 0. The main downsize of
> > that, is that it requires to send as many `memory_sizes` elements as
> > the highest shmid for the device. But as it is, it is supported by
> > this code.
>
> shmids are not preserved when there are gaps:
>
>   for (i =3D 0; i < vdev->n_shmem_regions; i++) {
>       memory_region_add_subregion(&dev->shmembar, offset, mr);
>       virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
>                              offset, mr->size, i);
>                                                ^
>
> vdev->n_shmem_regions is incremented by virtio_new_shmem_region().
> virtio_new_shmem_region() is only called on non-empty Shared Memory
> Regions.
>
> In the example I gave with empty shmid 0 and non-empty shmid 1 I think
> we end up with vdev->n_shmem_regions =3D=3D 1. shmdid 1 is exposed to the
> guest with shmid 0.

Ah, right. I considered your example when I was doing it, but the code
is buggy indeed. The code that I tested is mostly on the shm map API
part, with a custom pci device.

As mentioned in the initial message, I will add tests for the next
iteration. Thanks for finding this one!

>
> Have I missed something?
>
> > >
> > > > +                               OBJECT(vdev), "vub-shm-" + i,
> > > > +                               memory_sizes[i]);
> > > > +        }
> > > >      }
> > > >
> > > >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event,=
 NULL,
> > > >                               dev, NULL, true);
> > > > +    return;
> > > > +err:
> > > > +    do_vhost_user_cleanup(vdev, vub);
> > > >  }
> > > >
> > > >  static void vub_device_unrealize(DeviceState *dev)
> > > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-us=
er-device-pci.c
> > > > index efaf55d3dd..f215cae925 100644
> > > > --- a/hw/virtio/vhost-user-device-pci.c
> > > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > > @@ -8,14 +8,18 @@
> > > >   */
> > > >
> > > >  #include "qemu/osdep.h"
> > > > +#include "qapi/error.h"
> > > >  #include "hw/qdev-properties.h"
> > > >  #include "hw/virtio/vhost-user-base.h"
> > > >  #include "hw/virtio/virtio-pci.h"
> > > >
> > > > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 2
> > > > +
> > > >  struct VHostUserDevicePCI {
> > > >      VirtIOPCIProxy parent_obj;
> > > >
> > > >      VHostUserBase vub;
> > > > +    MemoryRegion shmembar;
> > > >  };
> > > >
> > > >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > > > @@ -25,10 +29,38 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, =
VHOST_USER_DEVICE_PCI)
> > > >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev=
, Error **errp)
> > > >  {
> > > >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > > > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > > > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > > > +    MemoryRegion *mr;
> > > > +    uint64_t offset =3D 0, shmem_size =3D 0;
> > > > +    int i;
> > > >
> > > >      vpci_dev->nvectors =3D 1;
> > > > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > > > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > > > +
> > > > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > > > +        mr =3D vdev->shmem_list[i].mr;
> > > > +        if (mr->size > UINT64_MAX - shmem_size) {
> > > > +            error_setg(errp, "Total shared memory required overflo=
w");
> > > > +            return;
> > > > +        }
> > > > +        shmem_size =3D shmem_size + mr->size;
> > > > +    }
> > > > +    if (shmem_size) {
> > > > +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> > > > +                           "vhost-device-pci-shmembar", shmem_size=
);
> > > > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > > > +            memory_region_add_subregion(&dev->shmembar, offset, mr=
);
> > > > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHM=
EM_BAR,
> > > > +                                   offset, mr->size, i);
> > > > +            offset =3D offset + mr->size;
> > > > +        }
> > > > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHM=
EM_BAR,
> > > > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > > > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > > +                        &dev->shmembar);
> > > > +    }
> > > >  }
> > > >
> > > >  static void vhost_user_device_pci_class_init(ObjectClass *klass, v=
oid *data)
> > > > --
> > > > 2.48.1
> > > >
> >


