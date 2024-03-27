Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1525C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPKr-00079G-2M; Wed, 27 Mar 2024 05:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpPKo-00078u-QL
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpPKm-0001dv-TM
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711530755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erYWHg58vF/++WSSFdKIZ/B+ohyqP952lhdQB1U4VrM=;
 b=TQDtQTVZXXGbiFuMeqvAKYfQeUfDbNOj34t7xWwcTIuVS+Dzq6nZr9JFr36dO5Qmyvfvm6
 dz1X/Y9VFDepHxqp6wWqVr96oERse340TuXmKwEAXWzgA3dSyq0pxZ3Qv1FgOSmrsGER8y
 4jE2Iwk2hIcCaSX1o5t5TGJqBmZXCyU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-UpUR9OdnNWSOY-oBOHuIwA-1; Wed, 27 Mar 2024 05:12:33 -0400
X-MC-Unique: UpUR9OdnNWSOY-oBOHuIwA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29de3646c56so4865458a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711530753; x=1712135553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erYWHg58vF/++WSSFdKIZ/B+ohyqP952lhdQB1U4VrM=;
 b=PJB/IlpgcU0yG/Cm274IkSZbBjZ+XDaj7ASyGii9PZlKiQ79XNjKqc3EdiVczd9UnQ
 PhoRVHOKCDogDfhCZ3E3BBLGTlHX1ulOFqJIEYWY8kyX2XWRUPESuoMNqxWFn2O4VU8M
 ayfJCrojraftFhSB2LztSQz70iMUKOT7OYunnFz5xMDDZCf7MeqlNz6K6RbCKb/ZknEQ
 dOTJacqeGeNkpAhrL8y2Qg+1V/GzVChELSpdquAavBi3M7pwqpN/c/5GIZ2eVi+/2lpm
 /j9QHtxfNRo3L7mD6MvW5x4I4ug8pcqEE9l11jO6arhIRzv/Umejb4LRZIrvfwQYjkQ/
 M8Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmjMIXg/P2rfudyj2ePXUmrC/jy3z+Cv6g2f6d2nosflk28/r5vT7ZitRWY7pauIhLzoiBUoj+ghQJGntW0w44WV5MtEA=
X-Gm-Message-State: AOJu0YynJxg709svK81VAYKZwEpS8LLmRwSmxCru1QraInj23BVYWedA
 FO1OVodGGmJxXSYVSVJ/fqh6W5nusoP2TBW806T07xkKgK68UADX0JYgILo3I0nO7YqgLI7h70N
 q3oQVaQ1sbWpHDcmiVpNjIAJSlBcISmv/FoH/b7BHczAO4HNTQl80mjcSY6MY6pwa49XODEyOq1
 EplGhxAB/JYp+TXiFQyBSPpC/duJQ=
X-Received: by 2002:a17:90a:634a:b0:29f:cbd8:ea11 with SMTP id
 v10-20020a17090a634a00b0029fcbd8ea11mr610413pjs.15.1711530752834; 
 Wed, 27 Mar 2024 02:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnWVp+UOtWbvZs9CE0bpIRxKf7U8arMl//UpJdoChxbNZs0j/W6tqTnRaan6BHWpV7afV1elEJ+Z8aryhSEPk=
X-Received: by 2002:a17:90a:634a:b0:29f:cbd8:ea11 with SMTP id
 v10-20020a17090a634a00b0029fcbd8ea11mr610398pjs.15.1711530752450; Wed, 27 Mar
 2024 02:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
In-Reply-To: <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 17:12:21 +0800
Message-ID: <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > Hi Cindy:
> > > >
> > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > we need a crash in Non-standard image, here is the jira for this =
https://issues.redhat.com/browse/RHEL-28522
> > > > > The root cause of the issue is that an IRQFD was used without ini=
tialization..
> > > > >
> > > > > During the booting process of the Vyatta image, the behavior of t=
he called function in qemu is as follows:
> > > > >
> > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd f=
or vector 0
> > > >
> > > > Before vhost_net_stop(), do we know which vector is used by which q=
ueue?
> > > >
> > > before this stop, vdev->config_verctor is get from
> > > virtio_pci_common_read/virtio_pci_common_write
> > > it was set to vector 0
> >
> > I basically meant if vector 0 is shared with some virtqueues here.
> >
> Really sorry for this, vq's vector is 1,2, and will not share with the
> configure vector
> > > > >
> > > > > 2. virtio_reset() was called -->set configure vector to VIRTIO_NO=
_VECTORt
> > > > >
> > > > > 3.vhost_net_start() was called (at this time the configure vector=
 is
> > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers()=
 with
> > > > > assgin=3D true, so the irqfd for vector 0 was not "init" during t=
his process
> > > >
> > > > How does the configure vector differ from the virtqueue vector here=
?
> > > >
> > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > msix_fire_vector_notifier()
> > > been called will cause the crash at this time.
> >
> > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd when
> > the assignment is true?
> >
> It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
>
> then it will called kvm_virtio_pci_vector_use_one()
>
> in this function, there is a check for
>
>     if (vector >=3D msix_nr_vectors_allocated(dev))
>
> {         return 0;     }
>
> So it will return.

How about let's just fix this?

Btw, it's better to explain in detail like the above in the next version.

Thanks

>
> > > So I think this should
> > > be a bug in this guest image
> >
> > The point is Qemu should not crash even if the guest driver is buggy.
> >
> > It would be nice if we can have a qtest for this on top.
> >
> > Thanks
> >
> sure, got it, I have done the Qtest, and it passed
> here is the result
>
> Ok:                 794
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            32
> Timeout:            0
>
> > > > >
> > > > > 4. The system continues to boot and msix_fire_vector_notifier() w=
as
> > > > > called unmask the vector 0 and then met the crash
> > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > >
> > > > > The reason for not reproducing in RHEL/fedora guest image is beca=
use
> > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_stop a=
nd then virtio_reset, and also won't call msix_fire_vector_notifier for vec=
tor 0 during system boot.
> > > > >
> > > > > The reason for not reproducing before configure interrupt support=
 is because
> > > > > vector 0 is for configure interrupt,  before the support for conf=
igure interrupts, the notifier process will not handle vector 0.
> > > > >
> > > > > For the device Vyatta using, it doesn't support configure interru=
pts at all, So we plan to disable the configure interrupts in unsupported d=
evice
> > > >
> > > > Btw, let's tweak the changelog, it's a little bit hard to understan=
d.
> > > >
> > > sure will do
> > > thanks
> > > Cindy
> > > > Thanks
> > > >
> > > > >
> > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > >
> > > > > Cindy Lu (2):
> > > > >   virtio-net: disable the configure interrupt for not support dev=
ice
> > > > >   virtio-pci: check if the configure interrupt enable
> > > > >
> > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----------=
------
> > > > >  hw/virtio/virtio.c         |  1 +
> > > > >  include/hw/virtio/virtio.h |  1 +
> > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > >
> >
>


