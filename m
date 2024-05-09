Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA49C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 01:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4spf-0002JB-Kg; Wed, 08 May 2024 21:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1s4spe-0002IV-2K
 for qemu-devel@nongnu.org; Wed, 08 May 2024 21:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1s4spY-00075p-Lw
 for qemu-devel@nongnu.org; Wed, 08 May 2024 21:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715219058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0ch3dnprGpG9REkrjtdgTKwOBcY49IcOqMEAXZVZgo=;
 b=HDjVymM94muThEJyPGmMusJt9hkuMn2bG0h/B5o4REfNisLYGZ+mhUGDbnrODJlLGlJ8CG
 +9vxqOJbvMsiiJV72Ck5sb7XVa2w706nu88u/NiZAm4zSGHE4r4Kl7nHCtKjoKEMHbchIY
 jJS6MVVyAF18SaZUEYT4AyGfZtyC/7k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wfCDajwhPd2E7AIQeqDDlA-1; Wed, 08 May 2024 21:44:15 -0400
X-MC-Unique: wfCDajwhPd2E7AIQeqDDlA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34eb54c888cso243662f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 18:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715219054; x=1715823854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0ch3dnprGpG9REkrjtdgTKwOBcY49IcOqMEAXZVZgo=;
 b=f0CmI4aDNUqqSOohYsFO96OEgzAQXgyhoawWEXFu9TZTLPYMB+y3UIeXt1zSjcb77L
 hgaVVE94IbK8157van/xqQmYB+sBpeuV9omwfcQ9DvDIk3fXWb0AHeFAYF+UkGmPiYsW
 7vIMLBER9WrUmMm37r1Sj6ifRboNMeTcM2T6VmzaUr93G4xfHpn7aVndXZrvlETQXua6
 q8hyEzc05ocMggoSJ8IFDRV5U1737fuSozV29kBo2yniR5OQcAWuHIqid+pGBhwiB7/x
 gGn4XzAEELa2XJ3BaWC0Q2GfUEuI8Fzz2F1+BCttciJumOutZnVmClcTMA4dwbijRLsM
 kEYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU+onBptSMthpCctXPSvuq/TGGGT0m7uZJoEN5lPy3CrCjASGW/7LQu17FHnd+inktdy3z8+xcsPiJofRMFaIfHTm4KoE=
X-Gm-Message-State: AOJu0YwYx7/dG9PuiCaTZIRJm8ii2bnV2vY2iTtBf63XcTc4VGm1rwXR
 C5E5nDAMWt5HdcJLRPIEa5D9FyqxBG77rsZbO7scGQdqrfKO3tf1dUdt55QriU/fiBCHIs8cflB
 kyVnmzvykvT84VJEgcQWY85cQH70AwUmUkNV4qnQWYvEAZjvzRuQoE62co7+h4L3xWQ2s4cKGpc
 fK9GGXGzO3mLLJO7AJWXYSdsb7r2Y=
X-Received: by 2002:adf:e84e:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-34fca24486fmr3842122f8f.35.1715219054148; 
 Wed, 08 May 2024 18:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/sxY1lv4huJU8CvRNafeMhszS2BQm3ZqIwhkzMhaVrhMM9JcXJQA4vB06lBpycV56CUfj5H739WUBK1xD6uw=
X-Received: by 2002:adf:e84e:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-34fca24486fmr3842111f8f.35.1715219053819; Wed, 08 May 2024
 18:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
 <f1d4bddc-f2e9-4cb7-8866-5f010b21b756@tls.msk.ru>
In-Reply-To: <f1d4bddc-f2e9-4cb7-8866-5f010b21b756@tls.msk.ru>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 9 May 2024 09:43:35 +0800
Message-ID: <CACLfguUF7+Kyafo-pkRpM94m-r7UPqet6xNuP6NDVXxAAD3ccQ@mail.gmail.com>
Subject: Re: [PATCH v8] virtio-pci: fix use of a released vector
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, May 9, 2024 at 4:18=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 15.04.2024 12:34, Michael S. Tsirkin wrote:
> > From: Cindy Lu <lulu@redhat.com>
> >
> > During the booting process of the non-standard image, the behavior of t=
he
> > called function in qemu is as follows:
> >
> > 1. vhost_net_stop() was triggered by guest image. This will call the fu=
nction
> > virtio_pci_set_guest_notifiers() with assgin=3D false,
> > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vec=
tor 0
> >
> > 2. virtio_reset() was triggered, this will set configure vector to VIRT=
IO_NO_VECTOR
> >
> > 3.vhost_net_start() was called (at this time, the configure vector is
> > still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() =
with
> > assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during thi=
s process
> >
> > 4. The system continues to boot and sets the vector back to 0. After th=
at
> > msix_fire_vector_notifier() was triggered to unmask the vector 0 and  m=
eet the crash
> >
> > To fix the issue, we need to support changing the vector after VIRTIO_C=
ONFIG_S_DRIVER_OK is set.
>
> This change breaks both 9.0 and stable-8.2.3:
>
> https://gitlab.com/qemu-project/qemu/-/issues/2321
> https://gitlab.com/qemu-project/qemu/-/issues/2334
>
> So something's not right here.
>
> Thanks,
>
I have checked the stack, seems there is a  crash while set the vector
to NO_VECTOER?

#0  kvm_virtio_pci_vq_vector_release (proxy=3D0x55bd979fd130,
vector=3D<optimized out>) at ../hw/virtio/virtio-pci.c:834
#1  kvm_virtio_pci_vector_release_one
(proxy=3Dproxy@entry=3D0x55bd979fd130, queue_no=3Dqueue_no@entry=3D0) at
../hw/virtio/virtio-pci.c:965
#2  0x000055bd9380c430 in virtio_pci_set_vector (vdev=3D0x55bd97a05500,
proxy=3D0x55bd979fd130, queue_no=3D0, old_vector=3D1, new_vector=3D65535)
    at ../hw/virtio/virtio-pci.c:1445
#3  0x000055bd939c5490 in memory_region_write_accessor
(mr=3D0x55bd979fdc70, addr=3D26, value=3D<optimized out>, size=3D2,
shift=3D<optimized out>,
    mask=3D<optimized out>, attrs=3D...) at ../system/memory.c:497

I will try to reproduce and work in it

thanks
Cindy


> /mjt
>
> ...
> > MST: coding style and typo fixups
> >
> > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
> >   1 file changed, 35 insertions(+), 2 deletions(-)
> >
> > v7->v8:
> > more cleanups, suggested by Philip
> >
> > still untested, i just got involved to help address coding style
> > issues
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index cb6940fc0e..cb159fd078 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy=
 *proxy,
> >       return offset;
> >   }
> >
> > +static void virtio_pci_set_vector(VirtIODevice *vdev,
> > +                                  VirtIOPCIProxy *proxy,
> > +                                  int queue_no, uint16_t old_vector,
> > +                                  uint16_t new_vector)
> > +{
> > +    bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> > +
> > +    if (new_vector =3D=3D old_vector) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * If the device uses irqfd and the vector changes after DRIVER_OK=
 is
> > +     * set, we need to release the old vector and set up the new one.
> > +     * Otherwise just need to set the new vector on the device.
> > +     */
> > +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> > +    }
> > +    /* Set the new vector on the device. */
> > +    if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> > +        vdev->config_vector =3D new_vector;
> > +    } else {
> > +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> > +    }
> > +    /* If the new vector changed need to set it up. */
> > +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > +    }
> > +}
> > +
> >   int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
> >                              uint8_t bar, uint64_t offset, uint64_t len=
gth,
> >                              uint8_t id)
> > @@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaque,=
 hwaddr addr,
> >           } else {
> >               val =3D VIRTIO_NO_VECTOR;
> >           }
> > -        vdev->config_vector =3D val;
> > +        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> > +                              vdev->config_vector, val);
> >           break;
> >       case VIRTIO_PCI_COMMON_STATUS:
> >           if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaque,=
 hwaddr addr,
> >           } else {
> >               val =3D VIRTIO_NO_VECTOR;
> >           }
> > -        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, va=
l);
> >           break;
> >       case VIRTIO_PCI_COMMON_Q_ENABLE:
> >           if (val =3D=3D 1) {
>
> --
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D=
98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0=
A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
>


