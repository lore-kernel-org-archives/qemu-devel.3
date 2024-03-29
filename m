Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F5CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq2WD-0000oc-D8; Thu, 28 Mar 2024 23:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rq2WB-0000o8-My
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rq2W9-0007ik-Cg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711681375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVWfaSawxoK1/O518ytKhBcgaLocJNaTw+uNsyjdRck=;
 b=NM+nnFRRpUxEdvtBsE59S75/2Urt9WkqO804zBS02kG6DHCZRlinKQlymhZy5eAW6x+nsx
 1jM+xrxKaLeBSdmS3g6NIuFibrsq+R12is/ImlMUp+c/PvBfutXHm4EF3CRMdv56EsuyCf
 GBrwh9DvqJILbkr5VuczTjTwXgb7G6g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-jKJonhIPN32Csidnr94gnQ-1; Thu, 28 Mar 2024 23:02:48 -0400
X-MC-Unique: jKJonhIPN32Csidnr94gnQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-515ab42c302so1255009e87.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 20:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711681367; x=1712286167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVWfaSawxoK1/O518ytKhBcgaLocJNaTw+uNsyjdRck=;
 b=ZnnLzHDnrzo6SAvvKCvPv9Rl/2OKIO+o0vbyPhD80WcL1vuEySeKsg58FcKDqOc7wv
 2sOd4jgYXfthVAi6s0axOaY3RsDQbVW1HzCyRW0cy6oDFxTdusfIHVjyjU7+SApbHeM1
 JRokUGQ8xa3lcZYCeio/ky88KZ7qAVAtIPTXHICm5nc3fV53GgbsuTjoB4Hv3VCV5uAe
 cy3T/5VEGXUaVh/TZo9VMIf8oe/94ZrvCI941Ht7WfOqMHBW06nzmCRMMVyjv+CirY9H
 pN5ctBmfHXN3UJruUwdmUtD0zYSfXthtqMk0x+PCxezK2X8p7zoc4M4RXt3D8eM7V0t9
 Sd+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO16SQg4O8l6I1PWO69HfPRbv2BmKhpWBwlD/W9VNEVPQqDsVmXL8N0edVenTB3FN4s45zhqS5vBRkuO0frg9z7HyHEJg=
X-Gm-Message-State: AOJu0YwzmJDF1QMCQ7VgkkXDMdg/zPna1Z0rzW9M69Yp3GMKtZxvXSU2
 Rw4pR7HJKk4xJ6WvaLjlUAe+BBEMD0LmOrB2S2bWVXnwrqiliknIpGv2xUrz9lEcdk6jRjv/2TQ
 jjIKgRyBrQK2pZObUxENHbA7h8z48GUaF80TwsHMXxIElYWDejP6GzCfcXRLaweYbcBA3SK6H6X
 nxNEnf74kj5kBLLgW1NVEHaI5j0Nc=
X-Received: by 2002:ac2:483c:0:b0:513:c757:33d9 with SMTP id
 28-20020ac2483c000000b00513c75733d9mr721047lft.53.1711681367372; 
 Thu, 28 Mar 2024 20:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9sciOl1xTCuv15zLCGM2uVbZVibg5Pr1a45ENqIKQZ0c/8WZGtV/t6mkWeMmHU73EGZWqD2fjyFqTTFRa6M=
X-Received: by 2002:ac2:483c:0:b0:513:c757:33d9 with SMTP id
 28-20020ac2483c000000b00513c75733d9mr721036lft.53.1711681366908; Thu, 28 Mar
 2024 20:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
 <CACLfguU8tTagz=gtYkY5B01-TSMBjb0R=z-hhaP9LoOSx1GVUw@mail.gmail.com>
 <CACGkMEs5bJgp-tsn3hg6ECnOfm0UghPmbnZLv=vaGPJ2oaQuQg@mail.gmail.com>
In-Reply-To: <CACGkMEs5bJgp-tsn3hg6ECnOfm0UghPmbnZLv=vaGPJ2oaQuQg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 29 Mar 2024 11:02:09 +0800
Message-ID: <CACLfguUjXOQaGw-PNHvYO0s3MftPrJuO7zLA9WBzjo+gpXKDFQ@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 12:12=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Mar 27, 2024 at 5:33=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com=
> wrote:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > Hi Cindy:
> > > > > > >
> > > > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat=
.com> wrote:
> > > > > > > >
> > > > > > > > we need a crash in Non-standard image, here is the jira for=
 this https://issues.redhat.com/browse/RHEL-28522
> > > > > > > > The root cause of the issue is that an IRQFD was used witho=
ut initialization..
> > > > > > > >
> > > > > > > > During the booting process of the Vyatta image, the behavio=
r of the called function in qemu is as follows:
> > > > > > > >
> > > > > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the i=
rqfd for vector 0
> > > > > > >
> > > > > > > Before vhost_net_stop(), do we know which vector is used by w=
hich queue?
> > > > > > >
> > > > > > before this stop, vdev->config_verctor is get from
> > > > > > virtio_pci_common_read/virtio_pci_common_write
> > > > > > it was set to vector 0
> > > > >
> > > > > I basically meant if vector 0 is shared with some virtqueues here=
.
> > > > >
> > > > Really sorry for this, vq's vector is 1,2, and will not share with =
the
> > > > configure vector
> > > > > > > >
> > > > > > > > 2. virtio_reset() was called -->set configure vector to VIR=
TIO_NO_VECTORt
> > > > > > > >
> > > > > > > > 3.vhost_net_start() was called (at this time the configure =
vector is
> > > > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notif=
iers() with
> > > > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" du=
ring this process
> > > > > > >
> > > > > > > How does the configure vector differ from the virtqueue vecto=
r here?
> > > > > > >
> > > > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > > > msix_fire_vector_notifier()
> > > > > > been called will cause the crash at this time.
> > > > >
> > > > > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd=
 when
> > > > > the assignment is true?
> > > > >
> > > > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> > > >
> > > > then it will called kvm_virtio_pci_vector_use_one()
> > > >
> > > > in this function, there is a check for
> > > >
> > > >     if (vector >=3D msix_nr_vectors_allocated(dev))
> > > >
> > > > {         return 0;     }
> > > >
> > > > So it will return.
> > >
> > > How about let's just fix this?
> > >
> > > Btw, it's better to explain in detail like the above in the next vers=
ion.
> > >
> > > Thanks
> > >
> > The problem is I think the behavior here is correct, The vector here is
> >  VIRTIO_NO_VECTOR and we should return,
>
> So if I understand correctly, the configure vector is configured after
> DRIVER_OK?
>
sorry I didn't get your point, Do you mean set_guest_notifiers()?,
this was called during the system boot
 but for the value of vdev->config_vector/vq vector, this is changed
by virtio_pci_common_read/virtio_pci_common_write
and these function will not check the process  DRIVER_OK.
> Spec doesn't forbid this, this is something we need to support.
>
> It looks to me the correct fix is to kvm_virtio_pci_vector_use_one()
> when guest is writing to msix_vector after DRIVER_OK?
>
if I understand correctly. do you mean
when  function   virtio_pci_common_read/virtio_pci_common_write was called
we need to check the number of  vdev->config_vector/vq vector, if this
was changed and also DRIVER_OK was set
then we need to call virtio_pci_set_guest_notifiers() to re-init the irqfd?
Thanks
cindy
> Thanks
>
> > the fix could work maybe is we try get to know if this was changed
> > from another value
> > and use that one? this seems strange.
> > Thanks
> > cindy
> > > >
> > > > > > So I think this should
> > > > > > be a bug in this guest image
> > > > >
> > > > > The point is Qemu should not crash even if the guest driver is bu=
ggy.
> > > > >
> > > > > It would be nice if we can have a qtest for this on top.
> > > > >
> > > > > Thanks
> > > > >
> > > > sure, got it, I have done the Qtest, and it passed
> > > > here is the result
> > > >
> > > > Ok:                 794
> > > > Expected Fail:      0
> > > > Fail:               0
> > > > Unexpected Pass:    0
> > > > Skipped:            32
> > > > Timeout:            0
> > > >
> > > > > > > >
> > > > > > > > 4. The system continues to boot and msix_fire_vector_notifi=
er() was
> > > > > > > > called unmask the vector 0 and then met the crash
> > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > > > > >
> > > > > > > > The reason for not reproducing in RHEL/fedora guest image i=
s because
> > > > > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_=
stop and then virtio_reset, and also won't call msix_fire_vector_notifier f=
or vector 0 during system boot.
> > > > > > > >
> > > > > > > > The reason for not reproducing before configure interrupt s=
upport is because
> > > > > > > > vector 0 is for configure interrupt,  before the support fo=
r configure interrupts, the notifier process will not handle vector 0.
> > > > > > > >
> > > > > > > > For the device Vyatta using, it doesn't support configure i=
nterrupts at all, So we plan to disable the configure interrupts in unsuppo=
rted device
> > > > > > >
> > > > > > > Btw, let's tweak the changelog, it's a little bit hard to und=
erstand.
> > > > > > >
> > > > > > sure will do
> > > > > > thanks
> > > > > > Cindy
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > >
> > > > > > > > Cindy Lu (2):
> > > > > > > >   virtio-net: disable the configure interrupt for not suppo=
rt device
> > > > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > > > >
> > > > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----=
------------
> > > > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


