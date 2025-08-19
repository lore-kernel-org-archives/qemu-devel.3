Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03658CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKjK-0003sh-8t; Tue, 19 Aug 2025 07:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoKjG-0003sQ-6n
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoKj8-0000z5-OZ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755603722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNXR2flllI9K8mFGVc4nKNBQozBRE4+NBAFdpKCmNPQ=;
 b=jPW1t0fzB7iKkoX6dai9JceOZZEF+XfuU74tSf681cqTCaJhz8ymcQy/14/U+fNov4/JAW
 Ei4SIpKPAk1mfqBji9dpzI/KKDaSw9EPfvZAUluY5jXc51ZlS2lbZwRD1DD/htyh2+wreJ
 bmi/rBn62B4nUUwXLOXs1Ph2uizRaT0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-7kabI-gfMNWbgIJOXPhBoQ-1; Tue, 19 Aug 2025 07:42:01 -0400
X-MC-Unique: 7kabI-gfMNWbgIJOXPhBoQ-1
X-Mimecast-MFC-AGG-ID: 7kabI-gfMNWbgIJOXPhBoQ_1755603720
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-323267bf596so4978574a91.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 04:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755603720; x=1756208520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNXR2flllI9K8mFGVc4nKNBQozBRE4+NBAFdpKCmNPQ=;
 b=oa4oSMJx5jdxFOWujLiiBalZetLH17zqYlXUY1r7N1TeiCZ8xFfurQ/cNcBo8dn9t9
 EMK5hmGfBFinJyd1kjnWvvtrp2NLySG8qcRbAzip5GDigtiBBGmuoFHIRdnBKkIO7I6S
 aUiktYnE0e0FrIl0AJEdPHayFLcB5+crj6BxHnrKGHJYAoDzwnvCMEQvkbd8/Dxo3fIz
 ECJPQRoeVF34djAkiFQZfdTaYeLp9EOjp9uh5qBpUgP/y3wtseVdQjHcviBs8DwTbFw+
 Wz+XR9aj3hqnKnXSNftrFbSvwJwwyBFiDxNLG0SgsxrzrwwgBb0fz+mdpZPG+4vlK441
 DE9Q==
X-Gm-Message-State: AOJu0YxvRCJ/xjdX9HUubHMGg+i5rkXQ0k/tbHO4KQM2dHHFaWPEDujZ
 nVC7YhuSQ+Bj8KFTeVB2jiG1AhrS4MeAGv1mAvfjLsZ46WluxmNYNs9e9yIfNC75CCL/DmonetM
 L5dh/A25bp2W9lEV2lVsC88+hvLXomzMZ5CXFNjbTIwQpglsayyN2lhdNKww+glzKTBj/qjUZmE
 wdp0TkurfoOzI2VkAXYtn4tKDAw8iyzg4=
X-Gm-Gg: ASbGncv1XuBqL2sCTGvsXWid20VHRxltFj2xexCML9EslklUIm8XbTApLsa3fqGucAm
 fwxkxC9vLUXU1e0SArJrxP0B2XUY2hP3gW+zMXfkNGeHUOqXwc61+vNRewMuukTzT3ngfiPY83K
 Fr8JBEoMARUYY3xUfJJ8Nb
X-Received: by 2002:a17:902:d541:b0:240:2145:e51f with SMTP id
 d9443c01a7336-245e02dc59fmr28378525ad.3.1755603720018; 
 Tue, 19 Aug 2025 04:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzpTVDwkWMo+VjM77l5K81F5h2euiQiCMvZkuIYzZOVgMmDRI4gY/dJdLf5qMfQAMhMacQdzS4m5G4G7+8f70=
X-Received: by 2002:a17:902:d541:b0:240:2145:e51f with SMTP id
 d9443c01a7336-245e02dc59fmr28378105ad.3.1755603719543; Tue, 19 Aug 2025
 04:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-9-aesteve@redhat.com>
 <20250819104234.GB30271@fedora>
In-Reply-To: <20250819104234.GB30271@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 Aug 2025 13:41:48 +0200
X-Gm-Features: Ac12FXwEaZJOdP4hlANLq5WfJikWD35ip3zgiDQMHxfsL48JCImQ16GXFIt34qg
Message-ID: <CADSE00JytDdYQrQ-FYQc0oaMQsD1ja-UbBqknqGk-gjkm57Wng@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost-user-device: Add shared memory BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 19, 2025 at 12:42=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Aug 18, 2025 at 12:03:53PM +0200, Albert Esteve wrote:
> > Add shared memory BAR support to vhost-user-device-pci
> > to enable direct file mapping for VIRTIO Shared
> > Memory Regions.
> >
> > The implementation creates a consolidated shared
> > memory BAR that contains all VIRTIO Shared
> > Memory Regions as subregions. Each region is
> > configured with its proper shmid, size, and
> > offset within the BAR. The number and size of
> > regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> > message sent by vhost-user-base during realization
> > after virtio_init().
> >
> > Specifiically, it uses BAR 3 to avoid conflicts, as
> > it is currently unused.
> >
> > The shared memory BAR is only created when the
> > backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> > has configured shared memory regions. This maintains
> > backward compatibility with backends that do not
> > support shared memory functionality.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user-base.c       | 49 +++++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 34 +++++++++++++++++++--
> >  2 files changed, 78 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index ff67a020b4..932f9b5596 100644
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
> > @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > -    int ret;
> > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > +    g_autofree char *name =3D NULL;
> > +    int i, ret, nregions;
> >
> >      if (!vub->chardev.chr) {
> >          error_setg(errp, "vhost-user-base: missing chardev");
> > @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >
> >      /* Allocate queues */
> >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > +    for (i =3D 0; i < vub->num_vqs; i++) {
> >          g_ptr_array_add(vub->vqs,
> >                          virtio_add_queue(vdev, vub->vq_size,
> >                                           vub_handle_output));
> > @@ -333,11 +336,51 @@ static void vub_device_realize(DeviceState *dev, =
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
> > +            name =3D g_strdup_printf("vub-shm-%d", i);
>
> name is leaked because it's scope extends until the end of the function
> (after the loop) but a newly allocated string is assigned each time
> around the loop. This can be fixed by moving the local variable
> declaration inside the if statement body.
>
> > +            memory_region_init(&virtio_new_shmem_region(vdev, i)->mr,
> > +                               OBJECT(vdev), name,
> > +                               memory_sizes[i]);
>
> ->mr is already initialized inside virtio_new_shmem_region(). I suggest
> changing the definition of virtio_new_shmem_region() like this:
>
>   void virtio_add_shmem_region(VirtIODevice *vdev, uint8_t shmid,
>                                uint64_t size)
>
> and then calling it like this:
>
>   virtio_add_shmem_region(vdev, shmid, memory_sizes[i]);
>
> ("new" usually returns a new instance whereas "add" modifies an owner
> object/container. I think "add" is more appropriate here.)

Yes, I was checking your comment in the first patch and came to this.
I was changing it as you suggested. I messed that up with double init
and max size.

>
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
> > index f10bac874e..bac99e7c60 100644
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
> > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 3
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion shmembar;
> >  };
> >
> >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > @@ -25,10 +29,36 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOS=
T_USER_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Er=
ror **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    VirtioSharedMemory *shmem, *next;
> > +    uint64_t offset =3D 0, shmem_size =3D 0;
> >
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
>
> This is not specific to vhost-user-device-pci.c. All VIRTIO devices with
> Shared Memory Regions need PCI BAR setup code. Since vdev->shmem_list is
> part of the core hw/virtio/ code, it would make sense to move this into
> into hw/virtio/virtio-pci.c.
>
> > +        if (shmem->mr.size > UINT64_MAX - shmem_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        shmem_size =3D shmem_size + shmem->mr.size;
> > +    }
> > +    if (shmem_size) {
> > +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-shmembar", shmem_size);
> > +        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > +            memory_region_add_subregion(&dev->shmembar, offset, &shmem=
->mr);
> > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                                   offset, shmem->mr.size, shmem->shmi=
d);
> > +            offset =3D offset + shmem->mr.size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->shmembar);
>
> This does not follow the same approach as virtio-gpu-pci.c and
> virtio-vga.c. They config the VirtIOPCIProxy's BARs
> (->modern_io_bar_idx, ->modern_mem_bar_idx, and ->msix_bar_idx) to
> control the BAR layout first and then call qdev_realize().
>
> Why does this patch do things differently? It looks like it's assuming
> vpci_dev always has a specific BAR layout (it could change).
>
> > +    }
>
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass,
> > --
> > 2.49.0
> >


