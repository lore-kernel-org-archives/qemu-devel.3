Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5134AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOeb-0003Ic-AY; Wed, 27 Mar 2024 04:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpOea-0003IL-2n
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpOeY-0006s2-3n
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711528136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKIFQ+GE6xEtvak4VA8DuUj0LwYsIrBhEIpPZLg7bq4=;
 b=govc6CVQzlM9mYefzRYh9M2lxdcl7gxw5XMkyevhaxPEc4jHvYXTPE1Csm7hAgbM4ZEMgo
 unoyEuI6QHvvSdPie43LGBsJaj2BXw9mwUaYFVX/RS9kiwD1fgqJJzjEKItKJwhkVdyUbX
 ZDYzdiV9B+HgNw46RyycZ87Rai5pE9w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-T7rXNAyHNwqlqEVQZdAQnQ-1; Wed, 27 Mar 2024 04:28:55 -0400
X-MC-Unique: T7rXNAyHNwqlqEVQZdAQnQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56be6572ebfso2037211a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711528134; x=1712132934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKIFQ+GE6xEtvak4VA8DuUj0LwYsIrBhEIpPZLg7bq4=;
 b=SMQR5uzv0hVoWli1kXPruVDaHLbpsvAdxKQ0XCFUPnufEz2MdY17LcqG/j+bJinFPF
 AwqPl4lU0l7+K3OkJfgTv0bGPJDeK8wsQnn3l3+Nv2RI8lnqDFd5idOrPwSQpNLEwa2e
 WITlMU11XwotJtNBL751+4FwmYv2rdUQu8Ni+ZfsPkeQYH5r9shFZdbpPeqOXwLojKaG
 JvL78umUxz/fMZPbUJjycmcY6sXcw1+BdXb+vSP3Q1lAku1U7pOCd99mPub2a1Mjw3GV
 z4OdlEXQm07uc+RwwDGvLzwHQRd2MTc+NpKma3FLiav+KIAppj45Z9+StxC/BhDGkW4V
 I6Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVORbPhUU4F1isNAUmWNkyHPaPxg6Z8mhJb/Cp7FaeTunjWZ6rybfRNTg9avbli6H4BUfmp/rVKBYOBWaDJ31P9bbpnr8M=
X-Gm-Message-State: AOJu0YwLUK2r5vfhiZShzDFtauA/MlvJPZX/s6fagNHTRSXNrGHIckBK
 dSow2LRxpNmacKn3XuGIC4d2cz59mVbKzyYOipb8RkMwvRZP2ptx1ue+MH9gAwN35wAbSKb1D1I
 hamCZdlqm86J//VMndVT8gztwXFlkoUl39pNKLoHqh/Jx2BORKcY5q61XH7axT5J5B7ftIC2K2t
 S3iREKZUvSz/zhXBU+Mk9XmxFkxp8=
X-Received: by 2002:a17:906:46d7:b0:a4a:3679:5514 with SMTP id
 k23-20020a17090646d700b00a4a36795514mr470730ejs.48.1711528133796; 
 Wed, 27 Mar 2024 01:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41QpR2NRxkE4YgsGXQmOYigBUVba3PuAFK87Ztth/zrRunoMfkECJk+RSIQEMlBy8WNNtm2JuC+VzseEXW9g=
X-Received: by 2002:a17:906:46d7:b0:a4a:3679:5514 with SMTP id
 k23-20020a17090646d700b00a4a36795514mr470711ejs.48.1711528133429; Wed, 27 Mar
 2024 01:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
In-Reply-To: <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Mar 2024 16:28:16 +0800
Message-ID: <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
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

On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > Hi Cindy:
> > >
> > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > we need a crash in Non-standard image, here is the jira for this ht=
tps://issues.redhat.com/browse/RHEL-28522
> > > > The root cause of the issue is that an IRQFD was used without initi=
alization..
> > > >
> > > > During the booting process of the Vyatta image, the behavior of the=
 called function in qemu is as follows:
> > > >
> > > > 1. vhost_net_stop() was called, this will call the function
> > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for=
 vector 0
> > >
> > > Before vhost_net_stop(), do we know which vector is used by which que=
ue?
> > >
> > before this stop, vdev->config_verctor is get from
> > virtio_pci_common_read/virtio_pci_common_write
> > it was set to vector 0
>
> I basically meant if vector 0 is shared with some virtqueues here.
>
Really sorry for this, vq's vector is 1,2, and will not share with the
configure vector
> > > >
> > > > 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_V=
ECTORt
> > > >
> > > > 3.vhost_net_start() was called (at this time the configure vector i=
s
> > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() w=
ith
> > > > assgin=3D true, so the irqfd for vector 0 was not "init" during thi=
s process
> > >
> > > How does the configure vector differ from the virtqueue vector here?
> > >
> > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > msix_fire_vector_notifier()
> > been called will cause the crash at this time.
>
> Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd when
> the assignment is true?
>
It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)

then it will called kvm_virtio_pci_vector_use_one()

in this function, there is a check for

    if (vector >=3D msix_nr_vectors_allocated(dev))

{         return 0;     }

So it will return.

> > So I think this should
> > be a bug in this guest image
>
> The point is Qemu should not crash even if the guest driver is buggy.
>
> It would be nice if we can have a qtest for this on top.
>
> Thanks
>
sure, got it, I have done the Qtest, and it passed
here is the result

Ok:                 794
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            32
Timeout:            0

> > > >
> > > > 4. The system continues to boot and msix_fire_vector_notifier() was
> > > > called unmask the vector 0 and then met the crash
> > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > >
> > > > The reason for not reproducing in RHEL/fedora guest image is becaus=
e
> > > > REHL/Fedora doesn't have the behavior of calling vhost_net_stop and=
 then virtio_reset, and also won't call msix_fire_vector_notifier for vecto=
r 0 during system boot.
> > > >
> > > > The reason for not reproducing before configure interrupt support i=
s because
> > > > vector 0 is for configure interrupt,  before the support for config=
ure interrupts, the notifier process will not handle vector 0.
> > > >
> > > > For the device Vyatta using, it doesn't support configure interrupt=
s at all, So we plan to disable the configure interrupts in unsupported dev=
ice
> > >
> > > Btw, let's tweak the changelog, it's a little bit hard to understand.
> > >
> > sure will do
> > thanks
> > Cindy
> > > Thanks
> > >
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > >
> > > > Cindy Lu (2):
> > > >   virtio-net: disable the configure interrupt for not support devic=
e
> > > >   virtio-pci: check if the configure interrupt enable
> > > >
> > > >  hw/net/virtio-net.c        |  5 ++++-
> > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-------------=
----
> > > >  hw/virtio/virtio.c         |  1 +
> > > >  include/hw/virtio/virtio.h |  1 +
> > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>


