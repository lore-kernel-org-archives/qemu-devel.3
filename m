Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB14DC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rph82-00055W-Ia; Thu, 28 Mar 2024 00:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rph7z-00055B-Ns
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rph7x-0002eM-PL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711599151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qBWhmExpygb9Ocow6EKZEs3Fzw4GxejvTmxKGnYvQ8=;
 b=G+fxySh7fs1WYE1ZCJqfHpddEhpHyWXcj30jQQoSfZi49BjTK31b0eNDshKIusruWhmp0A
 IeBpgOTN5Hq7RSZXCB8nO9EIW1ggMliVN/E5KroJcsHOJNg/Oh593VMTa4R43vxFosBicZ
 PnzywrOPBnX8phPNmJTeK6g2e53Nhsg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ZUZUFIDTPu6gGTR0cIhdyA-1; Thu, 28 Mar 2024 00:12:28 -0400
X-MC-Unique: ZUZUFIDTPu6gGTR0cIhdyA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29c7744a891so444649a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 21:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599147; x=1712203947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qBWhmExpygb9Ocow6EKZEs3Fzw4GxejvTmxKGnYvQ8=;
 b=exD7nDDwop+LTjbzZvvxyrkY5lkXvaJJFUUKQ0tmC9jeH87EGINjsWkr06z/K6+Ahp
 GN3/yrD4VKNwSBkAQJ9WFI64m5MNlNUEE3rXbaYndWVdQwpMscZekJ4Owxudk5VSoStb
 o4dZ8Ud1julQwFup1wINb35wLOrHZd/w2mq60sK6ddwUb8TOdzYPXEK+YvizO0XPO/1F
 Uo49EH7TFgd+ixwo+S9ZgdK72mhPMNgL7Lr9TSN3jiX1FnAfFOuqHceQGefGgQ+5T0Q9
 /81jaLqX9G0qA3EviEzpwaZbjFcPHanNBtVqWd0wlq+0R1g0J+YAlNtPr1OBGx+D6LDj
 3o/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZc8OJox/QykLPhgLj7e8h/CkeLZUzXKD7Caosz5exXSqDH2ChU2BAcr42reVDLNQ0MDKWBoYMEQIbTdcXGV41vtLnIpI=
X-Gm-Message-State: AOJu0YzYYoU8cat9ualeqgGebuZrvkBJ9gPqd38NrsHys6os6A3g7d6Y
 w1MGRhv4s6M38jSSNguPi+AAB+b+JU61aruCa9dP51wyMDI8eRR2ZmMOkEDqoEpRWtHH/RD1SJj
 m5Rwi77MyIfV/MJThiQkWarTrtCWxNRFLBLCGaLN3VXKvErdg2N33sbgpOyKX9vk5w7z0gKzZcp
 JSHgUB/ovOI26LXRXdeL+h18CpdmA=
X-Received: by 2002:a17:90a:4609:b0:29b:9c90:46ec with SMTP id
 w9-20020a17090a460900b0029b9c9046ecmr1721505pjg.9.1711599147341; 
 Wed, 27 Mar 2024 21:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQTFQSnBeBrAwixK+AxRYrARmtSjcILw34tlp9XRCN/5sV+gaxiONnApvimEq/jPFmwZelorQVALdyRzHW+OA=
X-Received: by 2002:a17:90a:4609:b0:29b:9c90:46ec with SMTP id
 w9-20020a17090a460900b0029b9c9046ecmr1721495pjg.9.1711599147005; Wed, 27 Mar
 2024 21:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
 <CACLfguU8tTagz=gtYkY5B01-TSMBjb0R=z-hhaP9LoOSx1GVUw@mail.gmail.com>
In-Reply-To: <CACLfguU8tTagz=gtYkY5B01-TSMBjb0R=z-hhaP9LoOSx1GVUw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:12:15 +0800
Message-ID: <CACGkMEs5bJgp-tsn3hg6ECnOfm0UghPmbnZLv=vaGPJ2oaQuQg@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, Mar 27, 2024 at 5:33=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > Hi Cindy:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.c=
om> wrote:
> > > > > > >
> > > > > > > we need a crash in Non-standard image, here is the jira for t=
his https://issues.redhat.com/browse/RHEL-28522
> > > > > > > The root cause of the issue is that an IRQFD was used without=
 initialization..
> > > > > > >
> > > > > > > During the booting process of the Vyatta image, the behavior =
of the called function in qemu is as follows:
> > > > > > >
> > > > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irq=
fd for vector 0
> > > > > >
> > > > > > Before vhost_net_stop(), do we know which vector is used by whi=
ch queue?
> > > > > >
> > > > > before this stop, vdev->config_verctor is get from
> > > > > virtio_pci_common_read/virtio_pci_common_write
> > > > > it was set to vector 0
> > > >
> > > > I basically meant if vector 0 is shared with some virtqueues here.
> > > >
> > > Really sorry for this, vq's vector is 1,2, and will not share with th=
e
> > > configure vector
> > > > > > >
> > > > > > > 2. virtio_reset() was called -->set configure vector to VIRTI=
O_NO_VECTORt
> > > > > > >
> > > > > > > 3.vhost_net_start() was called (at this time the configure ve=
ctor is
> > > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifie=
rs() with
> > > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" duri=
ng this process
> > > > > >
> > > > > > How does the configure vector differ from the virtqueue vector =
here?
> > > > > >
> > > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > > msix_fire_vector_notifier()
> > > > > been called will cause the crash at this time.
> > > >
> > > > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd w=
hen
> > > > the assignment is true?
> > > >
> > > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> > >
> > > then it will called kvm_virtio_pci_vector_use_one()
> > >
> > > in this function, there is a check for
> > >
> > >     if (vector >=3D msix_nr_vectors_allocated(dev))
> > >
> > > {         return 0;     }
> > >
> > > So it will return.
> >
> > How about let's just fix this?
> >
> > Btw, it's better to explain in detail like the above in the next versio=
n.
> >
> > Thanks
> >
> The problem is I think the behavior here is correct, The vector here is
>  VIRTIO_NO_VECTOR and we should return,

So if I understand correctly, the configure vector is configured after
DRIVER_OK?

Spec doesn't forbid this, this is something we need to support.

It looks to me the correct fix is to kvm_virtio_pci_vector_use_one()
when guest is writing to msix_vector after DRIVER_OK?

Thanks

> the fix could work maybe is we try get to know if this was changed
> from another value
> and use that one? this seems strange.
> Thanks
> cindy
> > >
> > > > > So I think this should
> > > > > be a bug in this guest image
> > > >
> > > > The point is Qemu should not crash even if the guest driver is bugg=
y.
> > > >
> > > > It would be nice if we can have a qtest for this on top.
> > > >
> > > > Thanks
> > > >
> > > sure, got it, I have done the Qtest, and it passed
> > > here is the result
> > >
> > > Ok:                 794
> > > Expected Fail:      0
> > > Fail:               0
> > > Unexpected Pass:    0
> > > Skipped:            32
> > > Timeout:            0
> > >
> > > > > > >
> > > > > > > 4. The system continues to boot and msix_fire_vector_notifier=
() was
> > > > > > > called unmask the vector 0 and then met the crash
> > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > > > >
> > > > > > > The reason for not reproducing in RHEL/fedora guest image is =
because
> > > > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_st=
op and then virtio_reset, and also won't call msix_fire_vector_notifier for=
 vector 0 during system boot.
> > > > > > >
> > > > > > > The reason for not reproducing before configure interrupt sup=
port is because
> > > > > > > vector 0 is for configure interrupt,  before the support for =
configure interrupts, the notifier process will not handle vector 0.
> > > > > > >
> > > > > > > For the device Vyatta using, it doesn't support configure int=
errupts at all, So we plan to disable the configure interrupts in unsupport=
ed device
> > > > > >
> > > > > > Btw, let's tweak the changelog, it's a little bit hard to under=
stand.
> > > > > >
> > > > > sure will do
> > > > > thanks
> > > > > Cindy
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > >
> > > > > > > Cindy Lu (2):
> > > > > > >   virtio-net: disable the configure interrupt for not support=
 device
> > > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > > >
> > > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-------=
----------
> > > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


