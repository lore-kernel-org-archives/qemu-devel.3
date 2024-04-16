Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E13CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 00:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwWzX-0002pG-W8; Mon, 15 Apr 2024 20:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rwWzS-0002nB-RW
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 20:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rwWzR-0001SH-A0
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 20:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713228479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=997gQ0EC64A1IFQr7b9ClHckWVuOZOzu8dRw7fYVG2c=;
 b=e8Qt8Q4lB6XZIfEUktEK3riJBJvPosJOZ/h6b94i6w8+Q9WKcVu4Nf4US1HQ3bRfa7mGk9
 ngd3Eo3WJB0R6g03ySp9LkWl0IIXavkhLbqP9KS08ARDiOx7c4em4te14zZz+yGVrHcc5y
 xumdwczVqlXPUZ2Q2j6pCQO6tRN4i/8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-VQtrshzHMJ-UkQRBAdDYeQ-1; Mon, 15 Apr 2024 20:47:56 -0400
X-MC-Unique: VQtrshzHMJ-UkQRBAdDYeQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4455ae71fcso287476566b.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 17:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713228475; x=1713833275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=997gQ0EC64A1IFQr7b9ClHckWVuOZOzu8dRw7fYVG2c=;
 b=st96PCB5S6OpjAQYZGqsiVoLJlmXcxBm1r21AJAQ8BphpVQe7N9zFp1Bny9awm4jzm
 YbEWC1i3I94Z7vn90+iY1vfudgflIMy7kl+kPEiTZDIqt6Qqaz4RYoJAKaX2FMAlVR9u
 P1Z/HrjJa8C8QuBeBTdfMwgzge39x5V984s1KWmp3kDw7Z4fawmrYN0jqra+7teYR734
 ulUOkx+cZKZmt9yyNhKyE5sueVTRFEQ55kC47SJEOAhUY9VGU1FprujuOPbC18XF4Vsa
 el+bIR9S19K2zNas9UammlbDm4sGMygXtaDJltvYU3mgACweNVAymOefXMjdlYIDvp4R
 0a/w==
X-Gm-Message-State: AOJu0Yye5ttN77YrDI0OoAJSXnqr1ntwX0wbzs/TYggn51duNd8iHNjk
 Uo3+pyxvfXM3Gt1tWfztYEL/L08df7pVilDtE/0QRiapw0F7u3nRU+wrCB+BQlwDV5k2EFifeRW
 p6uGYlvHpAx6IOXqVuNq7ea4RpWH4b6+MybVH6+Z4Hyk2HxtBLTy1zefWjtHbFIvfuvGikRRVrc
 X+65wWsv8bcMw0a7KH5CpiK6OSiJs=
X-Received: by 2002:a17:907:972a:b0:a51:827d:c99b with SMTP id
 jg42-20020a170907972a00b00a51827dc99bmr9051231ejc.14.1713228475032; 
 Mon, 15 Apr 2024 17:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpeVQr9oYRUmNPe4+JyA6CSwp2Lae4DDkx8dqE5KYybKeOsdpAWhFNCR2NnUP093EGYCi3/FSTR5igpSY95Bk=
X-Received: by 2002:a17:907:972a:b0:a51:827d:c99b with SMTP id
 jg42-20020a170907972a00b00a51827dc99bmr9051211ejc.14.1713228474641; Mon, 15
 Apr 2024 17:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240408153408.3527586-1-jonah.palmer@oracle.com>
In-Reply-To: <20240408153408.3527586-1-jonah.palmer@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 16 Apr 2024 08:47:17 +0800
Message-ID: <CAPpAL=yBZqQuRbv6W_7o11+KgMyLHfqix2AyA8By7f7oZvgB4Q@mail.gmail.com>
Subject: Re: [RFC v3 0/6] virtio,vhost: Add VIRTIO_F_IN_ORDER support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, eperezma@redhat.com, stefanha@redhat.com, 
 qemu-block@nongnu.org, schalla@marvell.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

QE tested this series with packed=3Don/off, in_order=3Dtrue and vhost=3Doff
under regression tests, everything are works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Apr 8, 2024 at 11:34=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> The goal of these patches is to add support to a variety of virtio and
> vhost devices for the VIRTIO_F_IN_ORDER transport feature. This feature
> indicates that all buffers are used by the device in the same order in
> which they were made available by the driver.
>
> These patches attempt to implement a generalized, non-device-specific
> solution to support this feature.
>
> The core feature behind this solution is a buffer mechanism in the form
> of a VirtQueue's used_elems VirtQueueElement array. This allows devices
> who always use buffers in-order by default to have a minimal overhead
> impact. Devices that may not always use buffers in-order likely will
> experience a performance hit. How large that performance hit is will
> depend on how frequent elements are completed out-of-order.
>
> A VirtQueue whose device who uses this feature will use its used_elems
> VirtQueueElement array to hold used VirtQueueElements. The index that
> used elements are placed in used_elems is the same index on the
> used/descriptor ring that would satisfy the in-order requirement. In
> other words, used elements are placed in their in-order locations on
> used_elems and are only written to the used/descriptor ring once the
> elements on used_elems are able to continue their expected order.
>
> To differentiate between a "used" and "unused" element on the used_elems
> array (a "used" element being an element that has returned from
> processing and an "unused" element being an element that has not yet
> been processed), we added a boolean 'filled' member to the
> VirtQueueElement struct. This flag is set to true when the element comes
> back from processing (virtqueue_ordered_fill) and then set back to false
> once it's been written to the used/descriptor ring
> (virtqueue_ordered_flush).
>
> ---
> v3: Add elements to used_elems during virtqueue_split/packed_pop
>     Replace current_seq_idx usage with vq->last_avail_idx
>     Remove used_seq_idx, leverage used_idx and last_avail_idx for
>     searching used_elems
>     Remove seq_idx in VirtQueueElement
>     Add boolean to VirtQueueElement to signal element status
>     Add virtqueue_ordered_fill/flush functions for ordering
>
> v2: Use a VirtQueue's used_elems array as a buffer mechanism
>
> v1: Implement custom GLib GHashTable as a buffer mechanism
>
> Jonah Palmer (6):
>   virtio: Add bool to VirtQueueElement
>   virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
>   virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support
>   virtio: virtqueue_ordered_flush - VIRTIO_F_IN_ORDER support
>   vhost,vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits
>   virtio: Add VIRTIO_F_IN_ORDER property definition
>
>  hw/block/vhost-user-blk.c    |   1 +
>  hw/net/vhost_net.c           |   2 +
>  hw/scsi/vhost-scsi.c         |   1 +
>  hw/scsi/vhost-user-scsi.c    |   1 +
>  hw/virtio/vhost-user-fs.c    |   1 +
>  hw/virtio/vhost-user-vsock.c |   1 +
>  hw/virtio/virtio.c           | 118 ++++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio.h   |   5 +-
>  net/vhost-vdpa.c             |   1 +
>  9 files changed, 127 insertions(+), 4 deletions(-)
>
> --
> 2.39.3
>


