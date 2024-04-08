Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C3C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rti2g-0001lW-Gi; Mon, 08 Apr 2024 01:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rti2Z-0001lF-Vh
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 01:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rti2Y-0004KB-2Z
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 01:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712555971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvCFpF9Yz6vZrxMeFo8wZ1v9KkIQ0/0fyRaae8/f9VI=;
 b=g9OKgE/B19XYXyHmEsgegGngHwL+W2dbygG7/CijfrKp3zSjuMFOHjEp8Dpe7+vjCY8bAg
 HfJS/YVsM0jMRdsKPrc25NvP8Sb6h4QtPdB3YGDkwCU5CBBs3abEH2ydOkp5WjdEl/y+Yz
 3zOiI+6OXix1GTL3XfXGTeD/uLtPPa4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-M4A2O5emN5WWey4EG5GQ3A-1; Mon, 08 Apr 2024 01:59:29 -0400
X-MC-Unique: M4A2O5emN5WWey4EG5GQ3A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a51c76700adso68091666b.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 22:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712555968; x=1713160768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvCFpF9Yz6vZrxMeFo8wZ1v9KkIQ0/0fyRaae8/f9VI=;
 b=xDjTUwk5Q7/Y1ogGx0Ga6r86kGUBAUJKD74EeeDmZDKex7E4p3CXdMEFZD1iPG52xU
 qTqEZpGawAFPa5EWu4JkUbzAvuQjbR4GduCpA2/wwty/TWrokf0UUrCO7+tfDabbiGQg
 EhlzWdaNQWiCuYMRUctYyfy+5IU0G36eOA13AXjiUODzcmK5U4YwOTgzCsEr7K9ERMcq
 oYsGJDFEnmD29UKZL6i3DDyqAQrOWOKGI+EujiI4cxPdaVi8TrVSWiLCTiXcoua2bS0h
 tkaY5qlOeQnabecyBqbaAokpMDZ88rDZPg0SWnd47WTzdby8ngdVUvcyQQFX7M278szj
 UFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHkdJV5UnM9RX2BjNZe5ugSf4J70NjLQsQiP9JW4CkdVjjE0d7Oq7l6zRIvo6tqP0KL/8Z6TBQxWj0IN4M3ai3sWII28A=
X-Gm-Message-State: AOJu0YzdO5yqFvm1JNNqk1mnepgfJewZ7np3wio523XFr9jUpNLUzmRO
 fhGNZfZAYvUcsplCZUm1S+7XqkMD3yKv6K1F+6GFON6kOh2hShrBpZg4q/KPosjfRNfn39xq/PS
 zxLn7bu83kJoy86jDvkjYy1WMx8IwJY0HzSPnJrbzq2KAJ8EPu2Ed7v8KR+GJK+UPvdlCmFwSRI
 WRoGzLUQbtJEWpr+e7dpCuyYlzI8SDdCZoT64=
X-Received: by 2002:a17:906:240e:b0:a47:3afd:4739 with SMTP id
 z14-20020a170906240e00b00a473afd4739mr7250385eja.6.1712555967827; 
 Sun, 07 Apr 2024 22:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDFpYxz0zjmk7s+OLge7LNWAd+fCeOEVJmx3wmmGozBsTSTsOzw3bJOve0XFQUzLDyeX9GSMXzHfU2TxSYH2Q=
X-Received: by 2002:a17:906:240e:b0:a47:3afd:4739 with SMTP id
 z14-20020a170906240e00b00a473afd4739mr7250375eja.6.1712555967484; Sun, 07 Apr
 2024 22:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
 <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
 <CACLfguVs=sd+2knCn4hhCEa+qsQ84yiE6wxt+kDNz8pU=ceU=Q@mail.gmail.com>
 <CACGkMEu6ijH9uADA-dah9y+cp1yEQuw4WrrZY=T0yNBc4z44eg@mail.gmail.com>
In-Reply-To: <CACGkMEu6ijH9uADA-dah9y+cp1yEQuw4WrrZY=T0yNBc4z44eg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Apr 2024 13:58:48 +0800
Message-ID: <CACLfguWHZaP0mYr7isH7MUaq4kRVxygjk=EwW4nXY5eo+vXa0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 8, 2024 at 12:59=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Apr 7, 2024 at 3:00=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Sun, Apr 7, 2024 at 12:20=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 11:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > When the guest calls virtio_stop and then virtio_reset,
> > >
> > > Guests could not call those functions directly, it is triggered by fo=
r
> > > example writing to some of the registers like reset or others.
> > >
> > sure , Will fix this
> > > > the vector will change
> > > > to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released.=
 After that
> > > > If you want to change the vector back,
> > >
> > > What do you mean by "change the vector back"? Something like
> > >
> > > assign VIRTIO_MSI_NO_VECTOR to vector 0
> > > assign X to vector 0
> > >
> > yes, the process is something  like
> > ....
> > set config_vector =3D VIRTIO_MSI_NO_VECTOR
> > ...
> > set config_vector =3D 0
> > > And I guess what you meant is to configure the vector after DRIVER_OK=
.
> >
> > >
> > >
> > > > it will cause a crash.
> > > >
> > > > To fix this, we need to call the function "kvm_virtio_pci_vector_us=
e_one()"
> > > > when the vector changes back from VIRTIO_NO_VECTOR
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
> > > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > index e433879542..45f3ab38c3 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIP=
roxy *proxy, int queue_no,
> > > >      return 0;
> > > >  }
> > > >
> > > > -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, in=
t queue_no)
> > > > +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, in=
t queue_no,
> > > > +                                         bool recovery)
> > > >  {
> > > >      unsigned int vector;
> > > >      int ret;
> > > >      EventNotifier *n;
> > > >      PCIDevice *dev =3D &proxy->pci_dev;
> > > > +    VirtIOIRQFD *irqfd;
> > > >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > > >      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> > > >
> > > > @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(Virt=
IOPCIProxy *proxy, int queue_no)
> > > >      if (vector >=3D msix_nr_vectors_allocated(dev)) {
> > > >          return 0;
> > > >      }
> > > > +    /*
> > > > +     * if this is recovery and irqfd still in use, means the irqfd=
 was not
> > > > +     * release before and don't need to set up again
> > > > +     */
> > > > +    if (recovery) {
> > > > +        irqfd =3D &proxy->vector_irqfd[vector];
> > > > +        if (irqfd->users !=3D 0) {
> > > > +            return 0;
> > > > +        }
> > > > +    }
> > > >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> > > >      if (ret < 0) {
> > > >          goto undo;
> > > >      }
> > > > +
> > > >      /*
> > > >       * If guest supports masking, set up irqfd now.
> > > >       * Otherwise, delay until unmasked in the frontend.
> > > > @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtI=
OPCIProxy *proxy, int nvqs)
> > > >          if (!virtio_queue_get_num(vdev, queue_no)) {
> > > >              return -1;
> > > >          }
> > > > -        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > > > +        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no, fal=
se);
> > > >      }
> > > >      return ret;
> > > >  }
> > > >
> > > >  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
> > > >  {
> > > > -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_=
IDX);
> > > > +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_=
IDX, false);
> > > >  }
> > > >
> > > >  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *prox=
y,
> > > > @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *op=
aque, hwaddr addr,
> > > >          } else {
> > > >              val =3D VIRTIO_NO_VECTOR;
> > > >          }
> > > > +        vector =3D vdev->config_vector;
> > > >          vdev->config_vector =3D val;
> > > > +        /*check if the vector need to recovery*/
> > > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_N=
O_VECTOR) &&
> > > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ=
_IDX, true);
> > > > +        }
> > >
> > > This looks too tricky.
> > >
> > > Think hard of this. I think it's better to split this into two parts:
> > >
> > > 1) a series that disables config irqfd for vhost-net, this series
> > > needs to be backported to -stable which needs to be conservative. It
> > > looks more like your V1, but let's add a boolean for pci proxy.
> > sure, I wll try this
> >
> > > 2) a series that deal with the msix vector configuration after
> > > driver_ok, we probably need some refactoring to do per vq use instead
> > > of the current loop in DRIVER_OK
> > >
> > Sorry I didn't get what you mean , Do you mean we need to move the chec=
k
> > to inside kvm_virtio_pci_vector_vq_use()=EF=BC=9F
> > Thanks
> > cindy
>
> I meant try to do use/release during mmio write instead of start.
>
> Note that Michael seems to prefer the approach of this patch. Let's
> fix the comment I gave in another thread and see.
>
> Thanks
>
sure, got ot. I will try this
thanks
cindy
> > > Does this make sense?
> > >
> > > Thanks
> > >
> > > >          break;
> > > >      case VIRTIO_PCI_COMMON_STATUS:
> > > >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *op=
aque, hwaddr addr,
> > > >              val =3D VIRTIO_NO_VECTOR;
> > > >          }
> > > >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > > > +
> > > > +        /*check if the vector need to recovery*/
> > > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_N=
O_VECTOR) &&
> > > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, =
true);
> > > > +        }
> > > >          break;
> > > >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > > >          if (val =3D=3D 1) {
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>


