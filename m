Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AF6C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpO7L-0005YU-LA; Wed, 27 Mar 2024 03:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpO7K-0005Y6-Aa
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpO7I-00087b-K4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711526075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpjdPdhysfqULOJleUGIiiS7Z0dHYgSe4GsND9iEshU=;
 b=PjDK1Uu5KF/poPvUFYbPkK7VPpS6CEmNRFCWsA31jbazkLLM7eusgGgVehNHMPMQNlyw2X
 uUeIIfo71MuocXSfcoRSh+M2mZ6JJeIyfGy5K691c5DLz5ZIlutE3gg+gqvlxuMjb9QqWj
 wmywnEC2sWUXpJTw7/YSi+kSJPPl80U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-y9s1kaF3MmmDkc4crQIP4g-1; Wed, 27 Mar 2024 03:54:32 -0400
X-MC-Unique: y9s1kaF3MmmDkc4crQIP4g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29feefd1a95so5162417a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 00:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711526071; x=1712130871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpjdPdhysfqULOJleUGIiiS7Z0dHYgSe4GsND9iEshU=;
 b=KvXKnZYSf9oAGyaEbbnY0B6m7NebWEWwtDAY9i+dmtqPHLfIFSTjDdzMiiSjBwRQg8
 NLJ0/ajJ1AGLWxShYM0EHVX8uqql4yJoQaoEtOC9I9C2UEHTqJV1nhvVU2oN/I73sA6p
 V9QAvLram92dtb2vdHhNLA4tfS7V+juSq+ZLlfBcm8duOLwNpu3vBp/cKWs9ipZ2Sq+l
 uQnJpqSQmmIKgGE+z/uTPW04vuUzcyrB5wJJPLNSzwHS0ss/x5340o6NKf1MEHdyHZTm
 wOh9tdbVtqsXQx+vNvBshpJornxUoH8NZpYZuCm3yz3ciPK2SLH6SWHxJQ+6NMDgRFyL
 DJKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxnTB1t4akY7OUPFs9fW5rL0r0jpVDrSQAzWrhPIEfYhY62NjyigQjUDzVRFAmlZImp1z59KmGIeUXFlnk2Ki484VKICg=
X-Gm-Message-State: AOJu0YxlagO7uJ/iZ0QfaD8HlVtOXqlmo1SSMdFPK8uYNZ6ofR04vcn7
 uV5sh1dCmbOsJVT1gSOc4ieFnYAOGOxn5kJGJytn4sqm6k8lOgP1NIBsAfvURUN0sIZilKnvuoB
 5ktytDzF44+MfFMUgsxNV/Pwkq5787+RX3jCp2hxXNZ7fswoQx9HQ8oepMP/0ocx3jP0M8b9cbC
 mo2qafg9VbrQiaTo5nBQBd97Lvgfmia9Y9RauZXw==
X-Received: by 2002:a17:90a:6c96:b0:2a0:95e2:1f8c with SMTP id
 y22-20020a17090a6c9600b002a095e21f8cmr1856598pjj.17.1711526071335; 
 Wed, 27 Mar 2024 00:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6E0D1xOYGFsxwbLWDqXmwFiRAVyvoRMrYmk4rFUHVzQdfQD6sbyRfXgeq1ze0lmGfq8k+8vg4x6afBuRxl3Q=
X-Received: by 2002:a17:90a:6c96:b0:2a0:95e2:1f8c with SMTP id
 y22-20020a17090a6c9600b002a095e21f8cmr1856591pjj.17.1711526070957; Wed, 27
 Mar 2024 00:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
In-Reply-To: <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 15:54:20 +0800
Message-ID: <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > Hi Cindy:
> >
> > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > we need a crash in Non-standard image, here is the jira for this http=
s://issues.redhat.com/browse/RHEL-28522
> > > The root cause of the issue is that an IRQFD was used without initial=
ization..
> > >
> > > During the booting process of the Vyatta image, the behavior of the c=
alled function in qemu is as follows:
> > >
> > > 1. vhost_net_stop() was called, this will call the function
> > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for v=
ector 0
> >
> > Before vhost_net_stop(), do we know which vector is used by which queue=
?
> >
> before this stop, vdev->config_verctor is get from
> virtio_pci_common_read/virtio_pci_common_write
> it was set to vector 0

I basically meant if vector 0 is shared with some virtqueues here.

> > >
> > > 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VEC=
TORt
> > >
> > > 3.vhost_net_start() was called (at this time the configure vector is
> > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() wit=
h
> > > assgin=3D true, so the irqfd for vector 0 was not "init" during this =
process
> >
> > How does the configure vector differ from the virtqueue vector here?
> >
> All the vectors are VIRTIO_NO_VECTOR (including vq). any
> msix_fire_vector_notifier()
> been called will cause the crash at this time.

Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd when
the assignment is true?

> So I think this should
> be a bug in this guest image

The point is Qemu should not crash even if the guest driver is buggy.

It would be nice if we can have a qtest for this on top.

Thanks

> > >
> > > 4. The system continues to boot and msix_fire_vector_notifier() was
> > > called unmask the vector 0 and then met the crash
> > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > >
> > > The reason for not reproducing in RHEL/fedora guest image is because
> > > REHL/Fedora doesn't have the behavior of calling vhost_net_stop and t=
hen virtio_reset, and also won't call msix_fire_vector_notifier for vector =
0 during system boot.
> > >
> > > The reason for not reproducing before configure interrupt support is =
because
> > > vector 0 is for configure interrupt,  before the support for configur=
e interrupts, the notifier process will not handle vector 0.
> > >
> > > For the device Vyatta using, it doesn't support configure interrupts =
at all, So we plan to disable the configure interrupts in unsupported devic=
e
> >
> > Btw, let's tweak the changelog, it's a little bit hard to understand.
> >
> sure will do
> thanks
> Cindy
> > Thanks
> >
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > Cindy Lu (2):
> > >   virtio-net: disable the configure interrupt for not support device
> > >   virtio-pci: check if the configure interrupt enable
> > >
> > >  hw/net/virtio-net.c        |  5 ++++-
> > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++---------------=
--
> > >  hw/virtio/virtio.c         |  1 +
> > >  include/hw/virtio/virtio.h |  1 +
> > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
>


