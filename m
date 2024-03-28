Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E3C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpjrs-0004qv-Et; Thu, 28 Mar 2024 03:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpjrq-0004qW-Lo
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpjrm-0004dp-1D
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711609680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnqrvEIozezjHPNJzKHpuicodoyO2tN7o2xjiP2w/Mg=;
 b=SIGrqNxUGJR6RMeqebBr3IVbA7OcMkK0l3yKc7AK3kSp1fYsXSLZXIgI281PAz2nFpNkLi
 ky7OJldQO489jv28gu7ez23OF/kiARWB4J46Ac+mN3o6ZSMKiUmn2n5RGhqp81WRAVFKUW
 dbx7gker6KnGexd35Yn797bny+dUH2w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-A3uUnXqiMrGhhWn2yJNNDw-1; Thu, 28 Mar 2024 03:07:58 -0400
X-MC-Unique: A3uUnXqiMrGhhWn2yJNNDw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-568b1075d18so361881a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 00:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711609677; x=1712214477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnqrvEIozezjHPNJzKHpuicodoyO2tN7o2xjiP2w/Mg=;
 b=Y0mQMxoKupnMUD+uxXELFE6UW0TRroDj300XBgKAdFsaV3Gw9PRCwSlE1qXmCCHXSy
 DWpkojiSnO4zgiUKDp7wVpJY4b20od9Y2xdtjC0JDCqJRCJUdwinyqxbhhi3FioOcdny
 p1oEr2V+FXbUce9hb/nSKlpk2Kx/o5Smd8qiiNlw4gzpUOWqrNoCGkwPdoW6+ip9B282
 vTCVT4K1k3BWFa9tcF+BTuT1F29NZJvBqwZmtXOk4lQEKkkuK3Kl+XROJdZQ/KB+dql7
 Qjk5/2laF5tcgG3X3/4xp69ZUzm4o/BkiOU6+zb5WquCGgU/W/UDipEf6L1Kh1r77gnX
 AYOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPFx400JmBAXm+V+HATljOlJPFfgjWhskbVKaCZApEKt0RpZ6j4kfNI89VgauH8AIi1P8Mw4om/8rZs1/+wlzbz6SU48=
X-Gm-Message-State: AOJu0YxpD4uiu5pm79PrpM2QxQWU2oELHoo1KditLNoxK1ActQLPuyNQ
 rd7fmTjSn9ljZGMtcaQSM4p1uR2/5V+GCDJ2KyzrnLkTGhellwK7MMlKAFLXUcmuqLBu6A+twYw
 cXQWFQ7ScmPiXdQVBW2c4pPGbvCrHlrjJQ3RkrDNNmSUhSEkzpSB4L3Bv5MdjNjQclzLcRO2+BD
 RGSmjkmBEpkD5dY65SNdNfjleLQil0nhQc0VJhzQ==
X-Received: by 2002:a17:906:c00a:b0:a45:c931:5703 with SMTP id
 e10-20020a170906c00a00b00a45c9315703mr925211ejz.70.1711609677047; 
 Thu, 28 Mar 2024 00:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+77+OQrNdDb08QtoIr3iqJhpw+e5C2I+n8+LUPOAoC6KhB05cV8lC5m+hOFdh5UkS7Tg1JwNjUXbjfGDWdmE=
X-Received: by 2002:a17:906:c00a:b0:a45:c931:5703 with SMTP id
 e10-20020a170906c00a00b00a45c9315703mr925197ejz.70.1711609676604; Thu, 28 Mar
 2024 00:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
 <CACGkMEvRo4Q2Of7cwTNmR6mgapMWYQ79D4fErJ8AoqPrsc+ncA@mail.gmail.com>
 <CACLfguWfOpwGktTaDOQ=fFMjvFJ4L9i42kJiPess85OJSw0QFA@mail.gmail.com>
 <CACGkMEuX37wzRiO4T-7d1yE76_YxdFK9eh0cChRdAhVJ4iY5Vw@mail.gmail.com>
In-Reply-To: <CACGkMEuX37wzRiO4T-7d1yE76_YxdFK9eh0cChRdAhVJ4iY5Vw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 28 Mar 2024 15:07:13 +0800
Message-ID: <CACLfguWGXRGLF1WVFCX9tUk6nXGYNUi5NVFuy=sGzdQnr7+EpQ@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
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

On Thu, Mar 28, 2024 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Mar 27, 2024 at 5:44=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 5:13=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.c=
om> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Hi Cindy:
> > > > > > > >
> > > > > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redh=
at.com> wrote:
> > > > > > > > >
> > > > > > > > > we need a crash in Non-standard image, here is the jira f=
or this https://issues.redhat.com/browse/RHEL-28522
> > > > > > > > > The root cause of the issue is that an IRQFD was used wit=
hout initialization..
> > > > > > > > >
> > > > > > > > > During the booting process of the Vyatta image, the behav=
ior of the called function in qemu is as follows:
> > > > > > > > >
> > > > > > > > > 1. vhost_net_stop() was called, this will call the functi=
on
> > > > > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, an=
d
> > > > > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the=
 irqfd for vector 0
> > > > > > > >
> > > > > > > > Before vhost_net_stop(), do we know which vector is used by=
 which queue?
> > > > > > > >
> > > > > > > before this stop, vdev->config_verctor is get from
> > > > > > > virtio_pci_common_read/virtio_pci_common_write
> > > > > > > it was set to vector 0
> > > > > >
> > > > > > I basically meant if vector 0 is shared with some virtqueues he=
re.
> > > > > >
> > > > > Really sorry for this, vq's vector is 1,2, and will not share wit=
h the
> > > > > configure vector
> > > > > > > > >
> > > > > > > > > 2. virtio_reset() was called -->set configure vector to V=
IRTIO_NO_VECTORt
> > > > > > > > >
> > > > > > > > > 3.vhost_net_start() was called (at this time the configur=
e vector is
> > > > > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_not=
ifiers() with
> > > > > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" =
during this process
> > > > > > > >
> > > > > > > > How does the configure vector differ from the virtqueue vec=
tor here?
> > > > > > > >
> > > > > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > > > > msix_fire_vector_notifier()
> > > > > > > been called will cause the crash at this time.
> > > > > >
> > > > > > Won't virtio_pci_set_guest_notifiers() will try to allocate irq=
fd when
> > > > > > the assignment is true?
> > > > > >
> > > > > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> > > > >
> > > > > then it will called kvm_virtio_pci_vector_use_one()
> > > > >
> > > > > in this function, there is a check for
> > > > >
> > > > >     if (vector >=3D msix_nr_vectors_allocated(dev))
> > > > >
> > > > > {         return 0;     }
> > > > >
> > > > > So it will return.
> > > >
> > > > How about let's just fix this?
> > >
> > > Btw, another question, how does vDPA work here?
> > >
> > > Thanks
> > >
> > the rhel/fedroa guest image will not call  vrtio_stop and virtio_reset
> > during the boot
> > So vector will not change to  VIRTIO_NO_VECTOR. So the vdpa's
> > configure interrupt
> > Should work ok and there is no crash
>
> I mean:
>
> 1) if vDPA can work with the image you used to reproduce the issue
> 2) if current Qemu can work on old kernel without configure interrupt
> support for vDPA
>
Really Sorry for ,  I tried to answer this
1. the vDPA device also can not working in this image,
 Because the irqfd for vector 0 is released. and then guest image
called unmask this vector. These code are all not dependent on vdpa
related processes

2, the current qemu can work with old kernel
because as I debug the old kernel  won't call
msix_fire_vector_notifier for vector 0=EF=BC=8C and it will not unmask vect=
or
0
Thansk
cindy

> Thanks
>
> > Thanks
> > cindy
> >
> > > >
> > > > Btw, it's better to explain in detail like the above in the next ve=
rsion.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > So I think this should
> > > > > > > be a bug in this guest image
> > > > > >
> > > > > > The point is Qemu should not crash even if the guest driver is =
buggy.
> > > > > >
> > > > > > It would be nice if we can have a qtest for this on top.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > sure, got it, I have done the Qtest, and it passed
> > > > > here is the result
> > > > >
> > > > > Ok:                 794
> > > > > Expected Fail:      0
> > > > > Fail:               0
> > > > > Unexpected Pass:    0
> > > > > Skipped:            32
> > > > > Timeout:            0
> > > > >
> > > > > > > > >
> > > > > > > > > 4. The system continues to boot and msix_fire_vector_noti=
fier() was
> > > > > > > > > called unmask the vector 0 and then met the crash
> > > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked=
 1
> > > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked=
 0
> > > > > > > > >
> > > > > > > > > The reason for not reproducing in RHEL/fedora guest image=
 is because
> > > > > > > > > REHL/Fedora doesn't have the behavior of calling vhost_ne=
t_stop and then virtio_reset, and also won't call msix_fire_vector_notifier=
 for vector 0 during system boot.
> > > > > > > > >
> > > > > > > > > The reason for not reproducing before configure interrupt=
 support is because
> > > > > > > > > vector 0 is for configure interrupt,  before the support =
for configure interrupts, the notifier process will not handle vector 0.
> > > > > > > > >
> > > > > > > > > For the device Vyatta using, it doesn't support configure=
 interrupts at all, So we plan to disable the configure interrupts in unsup=
ported device
> > > > > > > >
> > > > > > > > Btw, let's tweak the changelog, it's a little bit hard to u=
nderstand.
> > > > > > > >
> > > > > > > sure will do
> > > > > > > thanks
> > > > > > > Cindy
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > >
> > > > > > > > > Cindy Lu (2):
> > > > > > > > >   virtio-net: disable the configure interrupt for not sup=
port device
> > > > > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > > > > >
> > > > > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++---=
--------------
> > > > > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
> >
>


