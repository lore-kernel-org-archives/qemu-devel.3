Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2979AC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEL8-0002Oq-1N; Mon, 01 Jul 2024 06:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOEL6-0002OJ-86
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOEL3-0004VD-I3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719829967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4BqsedlPzbO6bxocv2wV9TtkbK+PMbaG7L4xZpMHBk=;
 b=OKy9C6ijMJ8eyjmnUNKm6ws1xckYC+gAhn9ZT27b5Tt6PYej0QaiBizqVjIk34gsuQJQPA
 7mk3TE1tMXzf/DNnytGEXs0tDlT1fF/fTTlkxEJFURHzibfOvvsX8rsNiuMPnlKcn63qrK
 38qgCEveFD3RDB1rQYs8qAOr9L4wZj0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-xSqFsi6gNLSXTRF5_-lWxg-1; Mon, 01 Jul 2024 06:32:45 -0400
X-MC-Unique: xSqFsi6gNLSXTRF5_-lWxg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee5a98e5fdso23703031fa.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 03:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719829963; x=1720434763;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4BqsedlPzbO6bxocv2wV9TtkbK+PMbaG7L4xZpMHBk=;
 b=eFvLA+XVYu2PWxqJsYeghvoY/J6VEV5VFa+p5FV3OGh8O0DbTuvbkL2MDoDe48dMTQ
 UJeZ6Yz8K0QeONrNIeXxThCcJmnlRipytb4I2adVPHTAiQbV+DiKhma0+aBAbZTini5C
 RdgQJjZ4kRwiwrEoB0SXJcxe3J8OgwfRz/Gdq7kIwIViBXNME0AvJ7oG+/ISqmjXcsR4
 XY5oQfhcWzFW+XnQQl6cm1v0zuyQZB0j2nTXPekraeJPFrnb5AuhfAGOOJLZRjNt3lHR
 Kf/gfdF1NdTn2BsJ+vFEEgxD+wf0x7OdZwlhmFY5hZhSen5Onlb+PtdL3xxGtI5sB7GZ
 Geyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwA9ppRNEJjFnHMjd1eNJTiWddVCBiFqNBP+yO76qVHzu7IfQz802IHZtb8gIz1AL4NAmEFzxiurUnXC4xdGfHPvxVhco=
X-Gm-Message-State: AOJu0YxbkQqVnp5w8HJZ9GHvOp6nXAPCirLupz5oRL+PpnaDJtxV1AcF
 6dWuFHQBORl0ELowxxrRQiUhEleG5VjrZH2qhASogYq/Ez854qEW5bfb4xe0VH9/eAErbeJIYbs
 +hMZxtgp2RHM9FJjWB0dyXDXPZ/m1VVjEEYCBqjqkzt5exo9Cp5fSLjZTOien
X-Received: by 2002:a2e:8684:0:b0:2ec:522f:6443 with SMTP id
 38308e7fff4ca-2ee5e6ba578mr29788261fa.33.1719829963668; 
 Mon, 01 Jul 2024 03:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrAs0j/XF0GfSBRu28VMGm3p8/McIQc61OSL1xcFXMiWRtJQNex0sDJgYClDsxL9gReUYKZw==
X-Received: by 2002:a2e:8684:0:b0:2ec:522f:6443 with SMTP id
 38308e7fff4ca-2ee5e6ba578mr29788061fa.33.1719829962761; 
 Mon, 01 Jul 2024 03:32:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1777:cc97:5c98:fa23:6d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e0b7csm9623615f8f.49.2024.07.01.03.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 03:32:42 -0700 (PDT)
Date: Mon, 1 Jul 2024 06:32:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Xoykie <xoykie@gmail.com>,
 Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Message-ID: <20240701063129-mutt-send-email-mst@kernel.org>
References: <20240701075208.19634-1-sgarzare@redhat.com>
 <CAJaqyWffdg6jz-+_1_tZApLTWs362KQYAMkPHttP51s7v07tEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWffdg6jz-+_1_tZApLTWs362KQYAMkPHttP51s7v07tEw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:53:34AM +0200, Eugenio Perez Martin wrote:
> On Mon, Jul 1, 2024 at 9:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> > switched using of address_space_read_cached() to virito_lduw_phys_cached()
> > to access packed descriptor event.
> >
> > When we used address_space_read_cached(), we needed to call
> > virtio_tswap16s() to handle the endianess of the field, but
> > virito_lduw_phys_cached() already handles it internally, so we no longer
> > need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
> > but forgot for `flags`).
> >
> > Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> > Cc: jasowang@redhat.com
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Xoykie <xoykie@gmail.com>
> > Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> 
> I think it would be great to test the patches using a big endian host
> just in case.
> 
> Thanks!

I think we really should move to using sparse tags for endian-ness,
like Linux does, and away from swap calls.


> > ---
> >  hw/virtio/virtio.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 893a072c9d..2e5e67bdb9 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
> >      /* Make sure flags is seen before off_wrap */
> >      smp_rmb();
> >      e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
> > -    virtio_tswap16s(vdev, &e->flags);
> >  }
> >
> >  static void vring_packed_off_wrap_write(VirtIODevice *vdev,
> > --
> > 2.45.2
> >


