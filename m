Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B078D58D65
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFblj-0005ve-Mb; Mon, 25 Nov 2024 11:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFblU-0005uq-GS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFblS-0001PH-Fr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732551398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbYfC+LamzSHTf3w/DlFzqng6fcdLeWy/BouBZYn1X8=;
 b=cfLs1+6m/5ORW/F/GVzfjsyq9eS7hsRBk+z6AqAXA8BGMYbtpDs+izwB5xD/sYUPxE5+6K
 K5XKJ1vOfrCVDCVXTqs97l5vijt+feA6dL/4+D03dPbXgRTjc58MS2a02cS3QSQUeke2k8
 0WBA7IkUOfXvzKirj4EieN5tOJCEIM0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-RkPsXJYWPPWfbZocFuIsIA-1; Mon, 25 Nov 2024 11:16:36 -0500
X-MC-Unique: RkPsXJYWPPWfbZocFuIsIA-1
X-Mimecast-MFC-AGG-ID: RkPsXJYWPPWfbZocFuIsIA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ea42039766so4426570a91.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732551395; x=1733156195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbYfC+LamzSHTf3w/DlFzqng6fcdLeWy/BouBZYn1X8=;
 b=fv4VQ5FozqGwPhVUYYSnGBN5RSsSltcQ2ocO0X4SqbIg5XD6LNSg84mT8CKTuUYutk
 RksSG1RVDRj207BowD5CZYBD/0qnslfCO+gCQiOd8eIPfkxHcNeboRZKYuxfHzTTigLF
 a7poNsGK92gXKXCD6RV7bgxlzoMyYgYrkpPYhTZi8I+TlMnixUyzeBw/k2XbBzhrOTot
 RlHoEVzr5IOFLjTErBqXI+O5zA7hicuZ2MMUfMcLxAWucpm2yQXH27PnVNamTmENFM2c
 lzYAiptzmjUkf2FpOXnPVjtZipZa7rSJmgu43H3q27L/awUoiW8thU+WomZhKLUxMinB
 f01Q==
X-Gm-Message-State: AOJu0YxSPxFpGRElbmv55WZs+T3NwAUeHXBYnPWZmwyHLDgLbVAmSoHG
 dHsGYOZ7rtlVS0OO+x1HKjA/ys3iwnb8Utl++Po5lHrmEAvig00j+t2vQud38SV8Cqw2nlIoeuY
 D1PdwU+pYGHNk5pFCUjHIOQTtBAjiKsZMnNrc4zLz3RGKrTYTHT6fsmPm7NLKvyK4gaVGOSoieJ
 Bzi6mSEeU1YsptQTLr4W6grkNp2CU=
X-Gm-Gg: ASbGncum1st98X3Yaw/JJSeYdF0RYxQVyseulPyFVfikx1fnD7eHDeF5vpfVI7qBzOi
 1si/S4uFlqZuIEOKexsHc7KU53U65QoZi
X-Received: by 2002:a17:90b:3946:b0:2ea:83a0:47a6 with SMTP id
 98e67ed59e1d1-2eb0e888000mr18918353a91.33.1732551394182; 
 Mon, 25 Nov 2024 08:16:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRvBC3kflTL74BFzJ9KHawLkzjPfcbrqGI5pwHT2/4awG304a00hfn9hinjMfiNY4/Ww0VG2c7S3SDTWIc1fs=
X-Received: by 2002:a17:90b:3946:b0:2ea:83a0:47a6 with SMTP id
 98e67ed59e1d1-2eb0e888000mr18918295a91.33.1732551393682; Mon, 25 Nov 2024
 08:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
 <20240917082751.GD575885@fedora.redhat.com>
In-Reply-To: <20240917082751.GD575885@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 25 Nov 2024 17:16:22 +0100
Message-ID: <CADSE00JXG7-EswSRUcYwcmKHc2V=gTMB0i5nz5yCq3egmt4=UA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com, 
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 17, 2024 at 10:27=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
> > Add a cache BAR in the vhost-user-device
> > into which files can be directly mapped.
> >
> > The number, shmid, and size of the VIRTIO Shared
> > Memory subregions is retrieved through a get_shmem_config
> > message sent by the vhost-user-base module
> > on the realize step, after virtio_init().
> >
> > By default, if VHOST_USER_PROTOCOL_F_SHMEM
> > feature is not supported by the backend,
> > there is no cache.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> Not all devices derive from vhost-user-base.c so this does not offer
> full coverage. I think that's okay since few devices currently use
> VIRTIO Shared Memory Regions. A note about this in the commit
> description would be useful though. Which vhost-user devices gain VIRTIO
> Shared Memory Region support and what should you do if your device is
> not included in this list?
>
> >  hw/virtio/vhost-user-base.c       | 37 +++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 39 ++++++++++++++++++++++++++++---
> >  2 files changed, 71 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index 2bc3423326..f2597d021a 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -271,7 +271,9 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > -    int ret;
> > +    uint64_t memory_sizes[8];
> > +    void *cache_ptr;
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
> > @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, E=
rror **errp)
> >          do_vhost_user_cleanup(vdev, vub);
>
> Missing return statement.

True, but this is unrelated to this patchset. I will fix it in a
different patch, so that it can find its way in faster.

>
> >      }
> >
> > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vho=
st_dev,
> > +                                                           &nregions,
> > +                                                           memory_size=
s,
>
> Buffer overflow. vhost_get_shmem_config() copies out up to 256
> memory_sizes[] elements. Please introduce a constant in the VIRTIO
> header and use it instead of hardcoding uint64_t memory_sizes[8] above.
>
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        do_vhost_user_cleanup(vdev, vub);
>
> Missing return statement.

Same here.
>
> > +    }
> > +
> > +    for (i =3D 0; i < nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> > +                error_setg(errp, "Shared memory %d size must be a powe=
r of 2 "
> > +                                 "no smaller than the page size", i);
> > +                return;
>
> Missing do_vhost_user_cleanup().

Maybe a goto would be preferable here? Just because the same exit
pattern occurs quite a few times now.

>
> > +            }
> > +
> > +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_NONE,
> > +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>
>
>
> > +            if (cache_ptr =3D=3D MAP_FAILED) {
> > +                error_setg_errno(errp, errno, "Unable to mmap blank ca=
che");
> > +                return;
>
> Missing do_vhost_user_cleanup().
>
> > +            }
> > +
> > +            virtio_new_shmem_region(vdev);
> > +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
> > +                                       OBJECT(vdev), "vub-shm-" + i,
> > +                                       memory_sizes[i], cache_ptr);
>
> I think memory_region_init_ram_ptr() is included in live migration, so
> the contents of VIRTIO Shared Memory Regions will be transferred to the
> destination QEMU and written to the equivalent memory region there. I'm
> not sure this works:
> 1. If there are PROT_NONE memory ranges, then live migration will
>    probably crash the source QEMU while trying to send this memory to
>    the destination QEMU.
> 2. If the destination vhost-user device has not yet loaded its state and
>    sent MAP messages setting up the VIRTIO Shared Memory Region, then
>    receiving migrated data and writing it into this memory will fail.
>
> QEMU has a migration blocker API so that devices can refuse live
> migration. For the time being a migration blocker is probably needed
> here. See migrate_add_blocker()/migrate_del_blocker().
>
> > +        }
> > +    }
> > +
> >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NUL=
L,
> >                               dev, NULL, true);
> >  }
> > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-d=
evice-pci.c
> > index efaf55d3dd..abf4e90c21 100644
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
> > +#define VIRTIO_DEVICE_PCI_CACHE_BAR 2
>
> "Cache" is ambigous. Call it shmem_bar here and everywhere else?
>
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion cachebar;
> >  };
> >
> >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > @@ -25,10 +29,39 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOS=
T_USER_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Er=
ror **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > -
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    MemoryRegion *mr;
> > +    uint64_t offset =3D 0, cache_size =3D 0;
> > +    int i;
> > +
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +        mr =3D vdev->shmem_list[i].mr;
> > +        if (mr->size > UINT64_MAX - cache_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        cache_size =3D cache_size + mr->size;
> > +    }
> > +    if (cache_size) {
> > +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-cachebar", cache_size);
> > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +            mr =3D vdev->shmem_list[i].mr;
> > +            memory_region_add_subregion(&dev->cachebar, offset, mr);
> > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_B=
AR,
> > +                                   offset, mr->size, i);
> > +            offset =3D offset + mr->size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_CACHE_B=
AR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->cachebar);
> > +    }
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass, void =
*data)
> > --
> > 2.45.2
> >


