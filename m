Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CAED5A6ED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 07:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFqQA-0003BJ-OD; Tue, 26 Nov 2024 02:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFqQ8-0003B0-0u
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFqQ5-0002P0-GF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 02:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732607734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xFYl1AVQ9Oi+3ypuAnWJbY378JNbRYJgtpbB1QMa34=;
 b=jJlsoXp/qUpQSWc9LaY4mVZDg+FzjGGhlETwkypLavmmcXqtNgwcFZm4B1fJn2LdHDsXI+
 ZPS+hbNZWSg4M0DdGm0p8zbKK4e8YPboHNeXt9BFvJDSKl034AXhtFAdTJYAM63rA8ZckN
 02UYAS4i3sVEPlmAyhIpoB8+oZlWazM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MmQ2xLHZMbaGetdbBOId2g-1; Tue, 26 Nov 2024 02:55:29 -0500
X-MC-Unique: MmQ2xLHZMbaGetdbBOId2g-1
X-Mimecast-MFC-AGG-ID: MmQ2xLHZMbaGetdbBOId2g
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-724f1f38eceso3243623b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 23:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732607728; x=1733212528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xFYl1AVQ9Oi+3ypuAnWJbY378JNbRYJgtpbB1QMa34=;
 b=iGG3Utx0TCb8ePy27mYKJyjM2cD8ZsnqjLFruOpUOIp4pKu+1FAClRpYPvE7XhQkxb
 51xr3bjRp6Y5impW+tCswd6L9Kc1ym+hxKnWelC+0NRFgU9TgQqPXhXYDhDG3b2YEHIO
 nrEXPtvonDwWEjFnj6RJZeyy7h1HWoDn+Pvir1qYPVKbC+0CIvV8WmMZb1m5s3WxxgV9
 KeluVhwZ4/HCVhqe+HXZYR3Dj8KnhiAuy58TuOUnHUk3oE1R73dXJI2vJySlTdV2DiL+
 htta4vZ2XUnzyp66hdP5WNgkMXSe9BwDEVx9WvbcOdWv72KI4GWjGSlAMz4C6pvCQQ3b
 1vEA==
X-Gm-Message-State: AOJu0YxG3n2LGXi4PC84NfrrI6mpwrJOKCiyHgNsnXUuitEtfIcQ2ejv
 9jut91vPpdMM6ys2iZaI5FkzXvwa0UmRzYXaqLx1dhxiRdYrBJTktq4k9Y1rFSpFwhQ//2tUQl+
 fqGtVSKOFE9ux/HPu/JvZpeyUhOZB4qrgpRIukSe18WYayFX1sxvgE3wmT7i3J/8stgZH/wceYF
 ZpFZjNJ3r9L1sZqNM9niwQ7aTjm4U=
X-Gm-Gg: ASbGnctrKoXlJ48taRMbxxwdkrm21TN8oyYcUi4CnnnzybQvQGCGdaktrhcedXAXH0m
 up/ZXAns/2LV7FRoP3Nv5TKGRED9A/jaq
X-Received: by 2002:a05:6a20:a112:b0:1d9:2ba5:912b with SMTP id
 adf61e73a8af0-1e09e5cb06amr21825786637.36.1732607728124; 
 Mon, 25 Nov 2024 23:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1zzRWE+4xb3FltTNiRQiNNIjOlmu7ACh3zWO5hQ6yYW+WjAAYA8Y6/uRASPWHdqsHF/9WcUqV03ngKtUfpDk=
X-Received: by 2002:a05:6a20:a112:b0:1d9:2ba5:912b with SMTP id
 adf61e73a8af0-1e09e5cb06amr21825769637.36.1732607727786; Mon, 25 Nov 2024
 23:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
 <20240917082751.GD575885@fedora.redhat.com>
 <CADSE00JXG7-EswSRUcYwcmKHc2V=gTMB0i5nz5yCq3egmt4=UA@mail.gmail.com>
In-Reply-To: <CADSE00JXG7-EswSRUcYwcmKHc2V=gTMB0i5nz5yCq3egmt4=UA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 26 Nov 2024 08:55:16 +0100
Message-ID: <CADSE00JV8GAc=WAnKiWhObjCPWnO-yPSBqrhdMetCc=Rw8XKiA@mail.gmail.com>
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

On Mon, Nov 25, 2024 at 5:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Tue, Sep 17, 2024 at 10:27=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
> > > Add a cache BAR in the vhost-user-device
> > > into which files can be directly mapped.
> > >
> > > The number, shmid, and size of the VIRTIO Shared
> > > Memory subregions is retrieved through a get_shmem_config
> > > message sent by the vhost-user-base module
> > > on the realize step, after virtio_init().
> > >
> > > By default, if VHOST_USER_PROTOCOL_F_SHMEM
> > > feature is not supported by the backend,
> > > there is no cache.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> >
> > Not all devices derive from vhost-user-base.c so this does not offer
> > full coverage. I think that's okay since few devices currently use
> > VIRTIO Shared Memory Regions. A note about this in the commit
> > description would be useful though. Which vhost-user devices gain VIRTI=
O
> > Shared Memory Region support and what should you do if your device is
> > not included in this list?
> >
> > >  hw/virtio/vhost-user-base.c       | 37 +++++++++++++++++++++++++++--
> > >  hw/virtio/vhost-user-device-pci.c | 39 ++++++++++++++++++++++++++++-=
--
> > >  2 files changed, 71 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.=
c
> > > index 2bc3423326..f2597d021a 100644
> > > --- a/hw/virtio/vhost-user-base.c
> > > +++ b/hw/virtio/vhost-user-base.c
> > > @@ -271,7 +271,9 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> > >  {
> > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > > -    int ret;
> > > +    uint64_t memory_sizes[8];
> > > +    void *cache_ptr;
> > > +    int i, ret, nregions;
> > >
> > >      if (!vub->chardev.chr) {
> > >          error_setg(errp, "vhost-user-base: missing chardev");
> > > @@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> > >
> > >      /* Allocate queues */
> > >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > > +    for (i =3D 0; i < vub->num_vqs; i++) {
> > >          g_ptr_array_add(vub->vqs,
> > >                          virtio_add_queue(vdev, vub->vq_size,
> > >                                           vub_handle_output));
> > > @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev,=
 Error **errp)
> > >          do_vhost_user_cleanup(vdev, vub);
> >
> > Missing return statement.
>
> True, but this is unrelated to this patchset. I will fix it in a
> different patch, so that it can find its way in faster.
>
> >
> > >      }
> > >
> > > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->v=
host_dev,
> > > +                                                           &nregions=
,
> > > +                                                           memory_si=
zes,
> >
> > Buffer overflow. vhost_get_shmem_config() copies out up to 256
> > memory_sizes[] elements. Please introduce a constant in the VIRTIO
> > header and use it instead of hardcoding uint64_t memory_sizes[8] above.
> >
> > > +                                                           errp);
> > > +
> > > +    if (ret < 0) {
> > > +        do_vhost_user_cleanup(vdev, vub);
> >
> > Missing return statement.
>
> Same here.

I'll correct myself here, this one was introduced in this patch, so is
not in mainline. Anyway, I think a goto may be a clearer pattern to
avoid missing the return statement.

> >
> > > +    }
> > > +
> > > +    for (i =3D 0; i < nregions; i++) {
> > > +        if (memory_sizes[i]) {
> > > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0)=
 {
> > > +                error_setg(errp, "Shared memory %d size must be a po=
wer of 2 "
> > > +                                 "no smaller than the page size", i)=
;
> > > +                return;
> >
> > Missing do_vhost_user_cleanup().
>
> Maybe a goto would be preferable here? Just because the same exit
> pattern occurs quite a few times now.
>
> >
> > > +            }
> > > +
> > > +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_NONE,
> > > +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> >
> >
> >
> > > +            if (cache_ptr =3D=3D MAP_FAILED) {
> > > +                error_setg_errno(errp, errno, "Unable to mmap blank =
cache");
> > > +                return;
> >
> > Missing do_vhost_user_cleanup().
> >
> > > +            }
> > > +
> > > +            virtio_new_shmem_region(vdev);
> > > +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
> > > +                                       OBJECT(vdev), "vub-shm-" + i,
> > > +                                       memory_sizes[i], cache_ptr);
> >
> > I think memory_region_init_ram_ptr() is included in live migration, so
> > the contents of VIRTIO Shared Memory Regions will be transferred to the
> > destination QEMU and written to the equivalent memory region there. I'm
> > not sure this works:
> > 1. If there are PROT_NONE memory ranges, then live migration will
> >    probably crash the source QEMU while trying to send this memory to
> >    the destination QEMU.
> > 2. If the destination vhost-user device has not yet loaded its state an=
d
> >    sent MAP messages setting up the VIRTIO Shared Memory Region, then
> >    receiving migrated data and writing it into this memory will fail.
> >
> > QEMU has a migration blocker API so that devices can refuse live
> > migration. For the time being a migration blocker is probably needed
> > here. See migrate_add_blocker()/migrate_del_blocker().
> >
> > > +        }
> > > +    }
> > > +
> > >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, N=
ULL,
> > >                               dev, NULL, true);
> > >  }
> > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user=
-device-pci.c
> > > index efaf55d3dd..abf4e90c21 100644
> > > --- a/hw/virtio/vhost-user-device-pci.c
> > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > @@ -8,14 +8,18 @@
> > >   */
> > >
> > >  #include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > >  #include "hw/qdev-properties.h"
> > >  #include "hw/virtio/vhost-user-base.h"
> > >  #include "hw/virtio/virtio-pci.h"
> > >
> > > +#define VIRTIO_DEVICE_PCI_CACHE_BAR 2
> >
> > "Cache" is ambigous. Call it shmem_bar here and everywhere else?
> >
> > > +
> > >  struct VHostUserDevicePCI {
> > >      VirtIOPCIProxy parent_obj;
> > >
> > >      VHostUserBase vub;
> > > +    MemoryRegion cachebar;
> > >  };
> > >
> > >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > > @@ -25,10 +29,39 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VH=
OST_USER_DEVICE_PCI)
> > >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, =
Error **errp)
> > >  {
> > >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > > -
> > > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > > +    MemoryRegion *mr;
> > > +    uint64_t offset =3D 0, cache_size =3D 0;
> > > +    int i;
> > > +
> > >      vpci_dev->nvectors =3D 1;
> > > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > > +
> > > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > > +        mr =3D vdev->shmem_list[i].mr;
> > > +        if (mr->size > UINT64_MAX - cache_size) {
> > > +            error_setg(errp, "Total shared memory required overflow"=
);
> > > +            return;
> > > +        }
> > > +        cache_size =3D cache_size + mr->size;
> > > +    }
> > > +    if (cache_size) {
> > > +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> > > +                           "vhost-device-pci-cachebar", cache_size);
> > > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > > +            mr =3D vdev->shmem_list[i].mr;
> > > +            memory_region_add_subregion(&dev->cachebar, offset, mr);
> > > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE=
_BAR,
> > > +                                   offset, mr->size, i);
> > > +            offset =3D offset + mr->size;
> > > +        }
> > > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_CACHE=
_BAR,
> > > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > > +                        &dev->cachebar);
> > > +    }
> > >  }
> > >
> > >  static void vhost_user_device_pci_class_init(ObjectClass *klass, voi=
d *data)
> > > --
> > > 2.45.2
> > >


