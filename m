Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66313C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwgd8-0004cq-Ih; Tue, 16 Apr 2024 07:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwgd5-0004cS-46
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwgd1-0002br-1y
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 07:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713265529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecN54dKkqsw7AnQsLPMI4Iso2OaDkBffOwSVm/BLkCE=;
 b=ecuYmkOAbLXeAQQIpOlqIVyoA+cjKyjsPx2VN2mkIHOval78/xxkF5iYa9pXRGkMkS0e2H
 7qyDoSOMTJvK6YSKYW5BnDdiYhmFtFaw9K94+HuwtG3lAniCHmJ250n8cw/pz5KNLRScZZ
 iTduQKjKugJhg21eZiuO1oKQcH/yMGw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-APkvr9dPPneUOyai_iNvmQ-1; Tue, 16 Apr 2024 07:05:27 -0400
X-MC-Unique: APkvr9dPPneUOyai_iNvmQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a53ed147aa3so99626366b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 04:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713265526; x=1713870326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecN54dKkqsw7AnQsLPMI4Iso2OaDkBffOwSVm/BLkCE=;
 b=Kf9ebCGr/7OH6yDzCHOwqD0ZaJ0s6ADlEX9ao50WwCUYtJHMq42bv+G4ofkfVUGad3
 zW1fi96BylZVVC70LGX4+OTK69XNkCwR9/LoMVlebaknXRwCJRwV6hJBpzKoo6DYmfoz
 jZvV1LR25Ffu09mznRscV+25H6XsF1/2Q/1/VYeicbPan6ELmztVTEJmuKu52UnB2x6w
 oYkcA4zBuVjKB+aLipocsMt+Y4JKSPeduQhrjX/EzOwinQKVLyrsS2RgPrw300u+kgRm
 vvXjdASsjt12N/ul40PYQZDfCsf7X5aLQMOkOfdld6JJaj3TNkZjNmQ742ZzY8yRAXun
 zeKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzv/4GIVXDzyrpX2YzBTOtpp/Fb8cKlGkeskEszPYPhB1Aszani9pGzsDtQnChaKCs2cAMm9zK/+zmT2OHpbvgEwxnbw=
X-Gm-Message-State: AOJu0YyZJcqfYQhG1pgR5uxzUm/oVKlDLtU0sOAsbgnVsNyi28KZOO7d
 U4PlYWC/h+IcTdiJ4FN1YCK8YJrQoPL5oWc4FTG8OLNc1dIIhKg1G3vPiHBWv11u8kzePYNdhnw
 Myl2dDw8YhZum9m/L6P7SZBJ6CXlFvs8Ryb9ifWsha7y14Ia603ocmufmulX6zFemMBbWNXq94t
 CboZSoZBGNQGgTZwvIXpmVaoXtrc0=
X-Received: by 2002:a17:906:2a85:b0:a52:6e3b:fcf1 with SMTP id
 l5-20020a1709062a8500b00a526e3bfcf1mr3521587eje.17.1713265526594; 
 Tue, 16 Apr 2024 04:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsYvz2Xy8GSGcofH7v0sNbTuok2OQ/pVymmptj87Ospb8aVr4sJw2fpe7k7JZQB+in+Tqk+KdJ092oRV/Xp10=
X-Received: by 2002:a17:906:2a85:b0:a52:6e3b:fcf1 with SMTP id
 l5-20020a1709062a8500b00a526e3bfcf1mr3521571eje.17.1713265526258; Tue, 16 Apr
 2024 04:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Apr 2024 19:04:48 +0800
Message-ID: <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Tue, Apr 16, 2024 at 6:01=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 15 Apr 2024 at 11:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
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
> >
>
> Hi; Coverity points out what it thinks is a problem in this commit
> (CID 1543938):
>
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index cb6940fc0e..cb159fd078 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy=
 *proxy,
> >      return offset;
> >  }
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
>
> Here queue_no can be VIRTIO_CONFIG_IRQ_IDX, which is -1.
>
> > +    /* If the new vector changed need to set it up. */
> > +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
>
> Here we pass that through to kvm_virtio_pci_vector_use_one().
> In kvm_virtio_pci_vector_use_one()'s error-exit path ("undo")
> it does
>     vector =3D virtio_queue_vector(vdev, queue_no);
> and in virtio_queue_vector() it does:
>
>     return n < VIRTIO_QUEUE_MAX ? vdev->vq[n].vector :
>         VIRTIO_NO_VECTOR;
>
> where 'n' is an int, so if we can get here with queue_no being
> VIRTIO_CONFIG_IRQ_IDX then we'll index off the front of the
> vdev->vq[] array.
>
> Maybe this is a "can't happen" case, but it does seem odd that
> virtio_queue_vector() only bounds-checks the "too big" case
> for its argument and not the "too small" case and/or it
> doesn't have a special case for VIRTIO_CONFIG_IRQ_IDX.
>
> > +    }
> > +}
> > +
>
hi peter
I think we can simply remove the part
    vector =3D virtio_queue_vector(vdev, queue_no);
the vector is get from virtio_pci_get_notifier() and don't need to get it a=
gain
I will send the fix soon
thanks
cindy
> thanks
> -- PMM
>


