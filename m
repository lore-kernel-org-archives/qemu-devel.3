Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C5CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 07:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtMVr-0000LY-1i; Sun, 07 Apr 2024 03:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rtMVm-0000LG-Pg
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 03:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rtMVj-0006xZ-9s
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 03:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712473213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/1y5tYWQ8AxUAeRWwutEnE3dvk2d2vvXNDg62Giz1I=;
 b=BBwxicbo2TSQbhREfZ+8xUSxXy8h3JYh8J0pEej9aiw9yaZ2sHDbbPPjIV/AbgmuqL2wKk
 uFvf7Jwieo8HPkfLyCCeYJ39qSlmresZt0LczEHORW0cvqZEYwucBXDxf7EwV+aFPcr50V
 meijqNlZWaMUFZcC6hLBGvLVcYKaf00=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-CUj6JemXM2STqNdXc1Mvtg-1; Sun, 07 Apr 2024 03:00:11 -0400
X-MC-Unique: CUj6JemXM2STqNdXc1Mvtg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d871310b3aso13413601fa.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 00:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712473209; x=1713078009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/1y5tYWQ8AxUAeRWwutEnE3dvk2d2vvXNDg62Giz1I=;
 b=KNWT0f+19DVDKXPzSgSIfZ7Kemk8XqBB9bUfzSkmXSqrN5JK7uTOTeXhsiRNUaDN6a
 Rt131RPHE3P77YVgnuiRzYnXJ3mo95FW4u92aXwDTlbetgNzItuekSSnEKUtf4kSR9CA
 yvyahRaofJ4nELqVChTAuK4O7sKphR0X9LexxIompyPa8BJuzERU6VZjaiyeQ1cAz0Q4
 uYKSPs96zUGnXKXIMiylsJS9R/VBfzUvTGHbrpNMToTkkvpd44q8QwT3CfNmruobPSfE
 N7jtCGCgCytf1OSYRD2CpPOQNN8xJ7z+NUEfGtFzgmFQiDkeGfzukNi9yxh1lPq6Cb7x
 uIXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPawaNJBDK6ntIPeD6ksLviZTEsw/5Ac9Ahxo+us/nnG5HHR9C5YPQdnSNjsZ9X7Gj9yRreokq6Dl39x0tegrJEsvhp6E=
X-Gm-Message-State: AOJu0YyeiRc3V1VehIUjvIYXc2r7hQQbbFg/bZglNSTYfKe3yV3ev9ut
 0bRXGQlQNFy3fR+buVnVD8tDUrag7qfHZ626uC277XT8dFen2cAmaijKk+NB725f2Pza6ArtMPg
 ZABGrZAdjhVjSJA1irxjWCNdrJ614pIM7+dD+Uhe/ijkAWNBetgEyRQt8CmvIWp4OWhS340u8Au
 4WLDvSbnu+GpztPGVjsZakEkt+p8s=
X-Received: by 2002:a2e:9c05:0:b0:2d7:11bf:1fc4 with SMTP id
 s5-20020a2e9c05000000b002d711bf1fc4mr3721627lji.42.1712473209648; 
 Sun, 07 Apr 2024 00:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQlPLMlUSgMr7dCd/x68deJzF4Rfr297Dzzo9mCiLeD3k3LOJJx8WpRbUsRQg5LiBIKlbI3DbEmgLLsx1rkug=
X-Received: by 2002:a2e:9c05:0:b0:2d7:11bf:1fc4 with SMTP id
 s5-20020a2e9c05000000b002d711bf1fc4mr3721621lji.42.1712473209288; Sun, 07 Apr
 2024 00:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
 <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
In-Reply-To: <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 7 Apr 2024 14:59:26 +0800
Message-ID: <CACLfguVs=sd+2knCn4hhCEa+qsQ84yiE6wxt+kDNz8pU=ceU=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Apr 7, 2024 at 12:20=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 2, 2024 at 11:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When the guest calls virtio_stop and then virtio_reset,
>
> Guests could not call those functions directly, it is triggered by for
> example writing to some of the registers like reset or others.
>
sure , Will fix this
> > the vector will change
> > to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. Aft=
er that
> > If you want to change the vector back,
>
> What do you mean by "change the vector back"? Something like
>
> assign VIRTIO_MSI_NO_VECTOR to vector 0
> assign X to vector 0
>
yes, the process is something  like
....
set config_vector =3D VIRTIO_MSI_NO_VECTOR
...
set config_vector =3D 0
> And I guess what you meant is to configure the vector after DRIVER_OK.

>
>
> > it will cause a crash.
> >
> > To fix this, we need to call the function "kvm_virtio_pci_vector_use_on=
e()"
> > when the vector changes back from VIRTIO_NO_VECTOR
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index e433879542..45f3ab38c3 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy=
 *proxy, int queue_no,
> >      return 0;
> >  }
> >
> > -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int qu=
eue_no)
> > +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int qu=
eue_no,
> > +                                         bool recovery)
> >  {
> >      unsigned int vector;
> >      int ret;
> >      EventNotifier *n;
> >      PCIDevice *dev =3D &proxy->pci_dev;
> > +    VirtIOIRQFD *irqfd;
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >
> > @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPC=
IProxy *proxy, int queue_no)
> >      if (vector >=3D msix_nr_vectors_allocated(dev)) {
> >          return 0;
> >      }
> > +    /*
> > +     * if this is recovery and irqfd still in use, means the irqfd was=
 not
> > +     * release before and don't need to set up again
> > +     */
> > +    if (recovery) {
> > +        irqfd =3D &proxy->vector_irqfd[vector];
> > +        if (irqfd->users !=3D 0) {
> > +            return 0;
> > +        }
> > +    }
> >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> >      if (ret < 0) {
> >          goto undo;
> >      }
> > +
> >      /*
> >       * If guest supports masking, set up irqfd now.
> >       * Otherwise, delay until unmasked in the frontend.
> > @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOPCI=
Proxy *proxy, int nvqs)
> >          if (!virtio_queue_get_num(vdev, queue_no)) {
> >              return -1;
> >          }
> > -        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > +        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no, false);
> >      }
> >      return ret;
> >  }
> >
> >  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
> >  {
> > -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX)=
;
> > +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX,=
 false);
> >  }
> >
> >  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
> > @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >          } else {
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> > +        vector =3D vdev->config_vector;
> >          vdev->config_vector =3D val;
> > +        /*check if the vector need to recovery*/
> > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VE=
CTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX=
, true);
> > +        }
>
> This looks too tricky.
>
> Think hard of this. I think it's better to split this into two parts:
>
> 1) a series that disables config irqfd for vhost-net, this series
> needs to be backported to -stable which needs to be conservative. It
> looks more like your V1, but let's add a boolean for pci proxy.
sure, I wll try this

> 2) a series that deal with the msix vector configuration after
> driver_ok, we probably need some refactoring to do per vq use instead
> of the current loop in DRIVER_OK
>
Sorry I didn't get what you mean , Do you mean we need to move the check
to inside kvm_virtio_pci_vector_vq_use()=EF=BC=9F
Thanks
cindy
> Does this make sense?
>
> Thanks
>
> >          break;
> >      case VIRTIO_PCI_COMMON_STATUS:
> >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +
> > +        /*check if the vector need to recovery*/
> > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VE=
CTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, true=
);
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> >          if (val =3D=3D 1) {
> > --
> > 2.43.0
> >
>


