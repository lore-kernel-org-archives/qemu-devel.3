Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C343C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBk8-0001Xq-2x; Thu, 07 Mar 2024 06:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1riBk6-0001Wy-24
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:16:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1riBk3-0005hz-Cs
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709810210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrM9V3Les7c2pOgU8QkEtywlg42IO/HWCy3/3IGeckM=;
 b=hqsAgbj+hQjubgQtgL378A7qL8MkvF2WVEKEcjcH6LwFZtOLW0o0WMvy1pJnoxpueLM8vr
 lYwssqi6F8oOjA1BY0i6heW2kgDZRsxtGDQIUR3drNTCvFT3ARR7iTYv2Mo1FUZQESjAU/
 4XlN85TkCa7Wf7jxBMqeYvGRbuDay9k=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-v-2WeOSvN5OuEHJKFr2c_w-1; Thu, 07 Mar 2024 06:16:48 -0500
X-MC-Unique: v-2WeOSvN5OuEHJKFr2c_w-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcbee93a3e1so1161513276.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709810208; x=1710415008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrM9V3Les7c2pOgU8QkEtywlg42IO/HWCy3/3IGeckM=;
 b=vvMziDPIwSl6qAT82tSq0n9MDLxXQS9cdhblqPH6b4Gd02gmSApH6oNCXHdjMNrf2q
 gFAWo3OHT5jGiDVYKgWZ4WvAhyI10Zats19a18RpMYRZRLroRvdnJoK+W3m2OMg4P1cm
 uQe+xZROJFXjpe2YtSxyqMIow6oeOs028+yqIeaFwlAJo4DlW6AWQ7y9fkOgiH4tLNr2
 VtGmu4GJbb5d13fKLc1Ni3T3jE3C++gtYRbG59MsQYZFeW36TLLnbgUkHwuUmr16CXtz
 xqYBPc08LINbPiGrDLHlK87t6HGFzfgvxY+Tzazl+Q/r+QFKmV3FwjrxG409DXDbIv2l
 1DxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIevpH94vQNgw4hqW8LYEaCKzRcy799gaBfMPo3LqaNrbtwKDvbD+bjyiI5TDN0cI++CkkNTpMlwFgMnwvXkDirzIvmA0=
X-Gm-Message-State: AOJu0YyQWfKWgtIzZp7I7jexdPp7wBK9F5vmJkG9aW+oa+I1K3qxgHIt
 ITauNxBZBUd+/cz0F0Gr9VVdkjt/a1QHqRpcEzO1TnZ1xlq2J+CNta0DqFzH0kkHVOlw99Sk8AR
 tab95ApP46Igxhu8OLPFILqlF/Ct0ISKOcwo5KnNIFnhsS9AQPyZdYqAcinlEtnl9GoLy/AIdB7
 M3eb64uwzAr2B1H3laW1EKNK9C1DY=
X-Received: by 2002:a25:9192:0:b0:dc6:49d3:dd52 with SMTP id
 w18-20020a259192000000b00dc649d3dd52mr15022147ybl.34.1709810208241; 
 Thu, 07 Mar 2024 03:16:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjDRsVuX4Q24gAs5STcWHZQncfKJPCgrPy5VzGN1y5ajUzJz6F+YJ+ckolBSjNGMovf1oSe0dqMWXTww0VTBQ=
X-Received: by 2002:a25:9192:0:b0:dc6:49d3:dd52 with SMTP id
 w18-20020a259192000000b00dc649d3dd52mr15022120ybl.34.1709810207948; Thu, 07
 Mar 2024 03:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
 <CAJaqyWdAFTkjGBJBmxvmTZT8UUiH86UGgE74X_bcq22nd-WwHA@mail.gmail.com>
 <20240306023143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240306023143-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Mar 2024 12:16:11 +0100
Message-ID: <CAJaqyWcDMu58H6P3FvyTM7L-GphLB1kj7fcOTBw6FC-O2DcpZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] virtio,
 vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 qemu-devel@nongnu.org, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 6, 2024 at 8:34=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Mar 06, 2024 at 08:07:31AM +0100, Eugenio Perez Martin wrote:
> > On Wed, Mar 6, 2024 at 6:34=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Tue, Mar 5, 2024 at 3:46=E2=80=AFAM Jonah Palmer <jonah.palmer@ora=
cle.com> wrote:
> > > >
> > > > The goal of these patches are to add support to a variety of virtio=
 and
> > > > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature.=
 This
> > > > feature indicates that a driver will pass extra data (instead of ju=
st a
> > > > virtqueue's index) when notifying the corresponding device.
> > > >
> > > > The data passed in by the driver when this feature is enabled varie=
s in
> > > > format depending on if the device is using a split or packed virtqu=
eue
> > > > layout:
> > > >
> > > >  Split VQ
> > > >   - Upper 16 bits: shadow_avail_idx
> > > >   - Lower 16 bits: virtqueue index
> > > >
> > > >  Packed VQ
> > > >   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> > > >   - Lower 16 bits: virtqueue index
> > > >
> > > > Also, due to the limitations of ioeventfd not being able to carry t=
he
> > > > extra provided by the driver, ioeventfd is left disabled for any de=
vices
> > > > using this feature.
> > >
> > > Is there any method to overcome this? This might help for vhost.
> > >
> >
> > As a half-baked idea, read(2)ing an eventfd descriptor returns an
> > 8-byte integer already. The returned value of read depends on eventfd
> > flags, but both have to do with the number of writes of the other end.
> >
> > My proposal is to replace this value with the last value written by
> > the guest, so we can extract the virtio notification data from there.
> > The behavior of read is similar to not-EFD_SEMAPHORE, reading a value
> > and then blocking if read again without writes. The behavior of KVM
> > writes is different, as it is not a counter anymore.
> >
> > Thanks!
>
>
> I doubt you will be able to support this in ioeventfd...

I agree.

> But vhost does not really need the value at all.
> So why mask out ioeventfd with vhost?

The interface should not be able to start with vhost-kernel because
the feature is not offered by the vhost-kernel device. So ioeventfd is
always enabled with vhost-kernel.

Or do you mean we should allow it and let vhost-kernel fetch data from
the avail ring as usual? I'm ok with that but then the guest can place
any value to it, so the driver cannot be properly "validated by
software" that way.

> vhost-vdpa is probably the only one that might need it...

Right, but vhost-vdpa already supports doorbell memory regions so I
guess it has little use, isn't it?

Thanks!

>
>
>
> > > Thanks
> > >
> > > >
> > > > A significant aspect of this effort has been to maintain compatibil=
ity
> > > > across different backends. As such, the feature is offered by backe=
nd
> > > > devices only when supported, with fallback mechanisms where backend
> > > > support is absent.
> > > >
> > > > Jonah Palmer (8):
> > > >   virtio/virtio-pci: Handle extra notification data
> > > >   virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > > >   virtio-mmio: Handle extra notification data
> > > >   virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > > >   virtio-ccw: Handle extra notification data
> > > >   virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> > > >   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature=
 bits
> > > >   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
> > > >
> > > >  hw/block/vhost-user-blk.c    |  1 +
> > > >  hw/net/vhost_net.c           |  2 ++
> > > >  hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
> > > >  hw/s390x/virtio-ccw.c        |  6 ++++--
> > > >  hw/scsi/vhost-scsi.c         |  1 +
> > > >  hw/scsi/vhost-user-scsi.c    |  1 +
> > > >  hw/virtio/vhost-user-fs.c    |  2 +-
> > > >  hw/virtio/vhost-user-vsock.c |  1 +
> > > >  hw/virtio/virtio-mmio.c      | 15 +++++++++++----
> > > >  hw/virtio/virtio-pci.c       | 16 +++++++++++-----
> > > >  hw/virtio/virtio.c           | 18 ++++++++++++++++++
> > > >  include/hw/virtio/virtio.h   |  5 ++++-
> > > >  net/vhost-vdpa.c             |  1 +
> > > >  13 files changed, 68 insertions(+), 17 deletions(-)
> > > >
> > > > --
> > > > 2.39.3
> > > >
> > >
>


