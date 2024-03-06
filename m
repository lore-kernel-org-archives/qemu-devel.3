Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0714BC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 07:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhlnA-00008f-6f; Wed, 06 Mar 2024 02:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhln3-000086-CS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rhlmz-0008Qh-Jh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709710448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yy49i5Xj3EUwTsmXyabM8hcAjOz2YG0lxCiaC6/VxsY=;
 b=fLP44gTfavbhy/+/RTBLEOXNOSS2zMfbT4hicklLu4pj5Qb4yD2R8x0Rov+o1CLHPirTRH
 y1cAXkuAPQrLNdxmDLr4OvXRBRBqe1yrRKltDHRRwmuFY1frtY+09ov/a6VB2A3rNTjPaj
 SL+ymIOFp6JQEkq8iFSZOaBjgExgC6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-yGvynyq_PYyUppUFopBgFA-1; Wed, 06 Mar 2024 02:34:06 -0500
X-MC-Unique: yGvynyq_PYyUppUFopBgFA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412e51c20fdso17197875e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 23:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709710446; x=1710315246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yy49i5Xj3EUwTsmXyabM8hcAjOz2YG0lxCiaC6/VxsY=;
 b=egnytZFtQ6tWLdP1j+apANFz2osYETKwIcFC4sOOHiYIF1YjPpvoM6HMQoFUO42l3z
 R1xSCllNwhd+bMT7HF50CHnNG8t/HcEfqB6EhnlyC0T6UmAlCEYeiEKHR+U16mScmOv3
 GGSrMWCp5YkEW+6ie07TeRpotNdrGad70hKD42kxIxf835T5UHRDGcZVLreiOJBShbNB
 ruhlHuKuUI99NDsZ5grAw6t3mAYmsWNt2ldN4UUrpEZiz3StrdaDGpM0RmD+2mqP5Rm6
 U4HKpYANtTMGcTK1Boto91AOzs3C5q2uNnNsljWwngNUxNg3CHDFG3Ia9Y9/liw4PKfz
 78ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa2u98O6MVCIwWYszZ0Ow+Ua2W/n66MUiPDEvt3hauwoTP1xZQ/mwhggVIEguHwEGDHXd2EGM2rucarzyLeG5Mwquvju0=
X-Gm-Message-State: AOJu0Yx4a2kVZ4HOYmi4gzGJ4crRXvnni5+R6aMA5m51TKNJaPR/Y9wn
 HMZLGA3dKLVPNwt5Z+RUP2vigPTNdmhfpETDTvstc0MA6CD+MhRhL2tp4Gyf284IpxXdRMi34aY
 tdiq2N4h8RYY4mBrwYedJujizxfoTViay4ZF7teLMbvVkiJYgQX+n
X-Received: by 2002:a05:600c:1d16:b0:412:b2fe:6e46 with SMTP id
 l22-20020a05600c1d1600b00412b2fe6e46mr9383987wms.27.1709710445667; 
 Tue, 05 Mar 2024 23:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjX6LQmRlN+VclGnIdPOs3sbAWM4s1HefaMvv67PxSRsmMdUm5tVwl+gXGE85WA2+gNv9o5g==
X-Received: by 2002:a05:600c:1d16:b0:412:b2fe:6e46 with SMTP id
 l22-20020a05600c1d1600b00412b2fe6e46mr9383960wms.27.1709710444979; 
 Tue, 05 Mar 2024 23:34:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ef:f330:b8:b56b:3f3d:2015])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c4ecb00b00412e293bee9sm9274933wmq.38.2024.03.05.23.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 23:34:04 -0800 (PST)
Date: Wed, 6 Mar 2024 02:33:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: Re: [PATCH v1 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA
 support
Message-ID: <20240306023143-mutt-send-email-mst@kernel.org>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
 <CAJaqyWdAFTkjGBJBmxvmTZT8UUiH86UGgE74X_bcq22nd-WwHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdAFTkjGBJBmxvmTZT8UUiH86UGgE74X_bcq22nd-WwHA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 06, 2024 at 08:07:31AM +0100, Eugenio Perez Martin wrote:
> On Wed, Mar 6, 2024 at 6:34 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Mar 5, 2024 at 3:46 AM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > >
> > > The goal of these patches are to add support to a variety of virtio and
> > > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
> > > feature indicates that a driver will pass extra data (instead of just a
> > > virtqueue's index) when notifying the corresponding device.
> > >
> > > The data passed in by the driver when this feature is enabled varies in
> > > format depending on if the device is using a split or packed virtqueue
> > > layout:
> > >
> > >  Split VQ
> > >   - Upper 16 bits: shadow_avail_idx
> > >   - Lower 16 bits: virtqueue index
> > >
> > >  Packed VQ
> > >   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> > >   - Lower 16 bits: virtqueue index
> > >
> > > Also, due to the limitations of ioeventfd not being able to carry the
> > > extra provided by the driver, ioeventfd is left disabled for any devices
> > > using this feature.
> >
> > Is there any method to overcome this? This might help for vhost.
> >
> 
> As a half-baked idea, read(2)ing an eventfd descriptor returns an
> 8-byte integer already. The returned value of read depends on eventfd
> flags, but both have to do with the number of writes of the other end.
> 
> My proposal is to replace this value with the last value written by
> the guest, so we can extract the virtio notification data from there.
> The behavior of read is similar to not-EFD_SEMAPHORE, reading a value
> and then blocking if read again without writes. The behavior of KVM
> writes is different, as it is not a counter anymore.
> 
> Thanks!


I doubt you will be able to support this in ioeventfd...
But vhost does not really need the value at all.
So why mask out ioeventfd with vhost?
vhost-vdpa is probably the only one that might need it...



> > Thanks
> >
> > >
> > > A significant aspect of this effort has been to maintain compatibility
> > > across different backends. As such, the feature is offered by backend
> > > devices only when supported, with fallback mechanisms where backend
> > > support is absent.
> > >
> > > Jonah Palmer (8):
> > >   virtio/virtio-pci: Handle extra notification data
> > >   virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > >   virtio-mmio: Handle extra notification data
> > >   virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > >   virtio-ccw: Handle extra notification data
> > >   virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > >   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
> > >   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
> > >
> > >  hw/block/vhost-user-blk.c    |  1 +
> > >  hw/net/vhost_net.c           |  2 ++
> > >  hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
> > >  hw/s390x/virtio-ccw.c        |  6 ++++--
> > >  hw/scsi/vhost-scsi.c         |  1 +
> > >  hw/scsi/vhost-user-scsi.c    |  1 +
> > >  hw/virtio/vhost-user-fs.c    |  2 +-
> > >  hw/virtio/vhost-user-vsock.c |  1 +
> > >  hw/virtio/virtio-mmio.c      | 15 +++++++++++----
> > >  hw/virtio/virtio-pci.c       | 16 +++++++++++-----
> > >  hw/virtio/virtio.c           | 18 ++++++++++++++++++
> > >  include/hw/virtio/virtio.h   |  5 ++++-
> > >  net/vhost-vdpa.c             |  1 +
> > >  13 files changed, 68 insertions(+), 17 deletions(-)
> > >
> > > --
> > > 2.39.3
> > >
> >


