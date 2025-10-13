Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737F8CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 15:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Kcu-0004OQ-MC; Mon, 13 Oct 2025 11:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8Kcr-0004OI-RI
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8Kck-0006XL-Kg
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760369887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z52uK1wKDJDjT0Gs0o7Bf5J8AkNtaDau/9werj/gv4I=;
 b=FZzyVifk1zKr8gpLfzulVqZKcLfwIy4Q1Ky+u8P/KE1KtBHTbSChb4QQrYofzX15da0jka
 BTfEuCGYJHwAe3uD4SS2et0KIlmaw6sVf86ziRFke+6X/tUcCcfBDmEsoco1Snmw6fanI4
 mGRv6l/k5XCI174R/zfmw8XoGbG3LAs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-M6cI6TzzPMaE2pqo5SHXkw-1; Mon, 13 Oct 2025 11:38:05 -0400
X-MC-Unique: M6cI6TzzPMaE2pqo5SHXkw-1
X-Mimecast-MFC-AGG-ID: M6cI6TzzPMaE2pqo5SHXkw_1760369885
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-28e538b5f23so86017955ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 08:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760369885; x=1760974685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z52uK1wKDJDjT0Gs0o7Bf5J8AkNtaDau/9werj/gv4I=;
 b=PEH4oOVg+N2cFWumqXBmUPP/642YrSFsEWlWML6Cp+/8dJhk0qUXgHHJXaMnXoIEnh
 RixtYn+8p6jMW+oMPKQhjIrSERlDuq9e6Gnp1inKhYOM6Lvi7MftFwob/PJeVFdJjfZa
 lJbbI9yk2SF80khGynttIr1AVGBVtGmVj+aKk12W01fLk5S3r61Gc7j/paiInw5vC7fo
 LZ6NkFYIrVOAs7yZ1WpUiCj7/btg91hkWPeA5V2z6xm8YhO4kiXqCzUf/ibkKh8ITQR8
 uUvL5ub+JnoyCx95iuKNjiAurxg9KDQXagxyqfOA93dyknGXIOVTUWCICuNsvPsYL+n6
 0mpQ==
X-Gm-Message-State: AOJu0YxT3imIpbwCDxqdxy8cReNEIla1+S/DMCmi5/ceKH9c773ImUM5
 mHpLkedh3uuR1pWKkuwfU8ejqk/h781n9eMC0BUlBHUcudJj0K/mr0RX/T0C5USLvbyby5Rwpzd
 rbT5ArveSWs4ptrGSPHnQGWe/gYhEtViahfY57G2h7o0V/yb0yTz97IXdI069u4dQPxA1MgezeQ
 g8CbXPh9EvcxaH7hGaRCr9lbJkgOtODKo=
X-Gm-Gg: ASbGncsjdYMyTKSosEijV/zPp24lANWalY5Swr0WzfOq87q/cc+DLFIAUnuuVaOqA9L
 okafU1yMTN626jQo7ukbRD62o8/2Ue4ce0cLlSIsZ/I+kcOL0QClqLwuy9nYFRMZVjncuKshdTx
 Yi5bFECOiFh6oQCFuc
X-Received: by 2002:a17:903:3847:b0:24a:fab6:d15a with SMTP id
 d9443c01a7336-29027240d1bmr293455325ad.20.1760369884607; 
 Mon, 13 Oct 2025 08:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhytu1Dlu8K4T6RziXPjZkd8F7Zn+bYfbYIyLOgiaDjFqj2iCEumzT3wdyyIaTK2gcz/IvxzVojjk4+guFvF0=
X-Received: by 2002:a17:903:3847:b0:24a:fab6:d15a with SMTP id
 d9443c01a7336-29027240d1bmr293454835ad.20.1760369884032; Mon, 13 Oct 2025
 08:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <20250910115420.1012191-8-aesteve@redhat.com>
 <20250929190031.GG81824@fedora>
In-Reply-To: <20250929190031.GG81824@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 13 Oct 2025 17:37:52 +0200
X-Gm-Features: AS18NWB7BHtKi5qZBFyqVwItNJmDffDwKzlZ0-CyrHrATxXIKw92h2JyiuXJ8f8
Message-ID: <CADSE00KBfyW=bTaNjvr8xgTevzndsk=Rps6gvfE8yH4sYqHqgA@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] vhost-user-device: Add shared memory BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, 
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com, 
 david@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 29, 2025 at 9:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Sep 10, 2025 at 01:54:20PM +0200, Albert Esteve wrote:
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
> >  hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 34 ++++++++++++++++++++--
> >  2 files changed, 76 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index ff67a020b4..82f49500e4 100644
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
> > +    int i, ret, nregions, regions_processed =3D 0;
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
> > @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev, =
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
> > +    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < =
nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            regions_processed++;
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
> > +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
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
>
> 64-bit PCI memory BARs require two contiguous 32-bit BARs. Choosing BAR
> 3 won't work because modern_mem_bar_idx =3D 4 (and 5) and there is a
> collision.
>
> virtio-gpu-hostmem uses BAR 2 and 3 for VIRTIO Shared Memory Regions. In
> order to do this, it rearranges the other VIRTIO PCI BARs in
> virtio_vga_base_realize(). Following that approach should be safe.

I see. But doing the same strategy would collide with
virtio-gpu-hostmem if both devices are used simultaneously? Would that
be ok?

The only other option (I think?) is to just use
`VIRTIO_DEVICE_PCI_SHMEM_BAR 2` as there is a comment in virtio-pci
that suggests that virtio modern io bar is off by default. But that
would also collide when used with virtio-gpu-hostmem :/


