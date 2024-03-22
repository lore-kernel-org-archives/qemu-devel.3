Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE1DC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 11:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncvm-000053-EB; Fri, 22 Mar 2024 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncvk-0008WO-Ep
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rncvh-0001mF-VB
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711106360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NPRkQs9P20xfCEmvDDjRK8efgav0YfluddXA9YKjd0=;
 b=Ry7O1CZDy7rjIslmW2yhEzdJxBD7sykLwI72H9glAy8gUyvpIYVBUdfes969l0zE2r8/T7
 e9U3vgdra3AKmdOm/1cz4aoaCemGt1jQBuSBC6kcK5kBBiWWEvR+rWQ0EjFmtrWD/AnsDx
 2vRzi5BNr8H0VkzzAgL53pLSRTNHKfc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-j6YotHzlMjqrPbzweKa0pg-1; Fri, 22 Mar 2024 07:19:18 -0400
X-MC-Unique: j6YotHzlMjqrPbzweKa0pg-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc6b26ce0bbso3879291276.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 04:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711106358; x=1711711158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NPRkQs9P20xfCEmvDDjRK8efgav0YfluddXA9YKjd0=;
 b=g03I8E6wX6a0mR+gzDn2Fda5gitUQt1cZvo7MloAOQBCoEeJkvHx/QxLYz980E+ZAT
 kyBb5++b+vpOeHyMPue16+m0CLXsfntOzi3rWgC1BwR8Kc14i/Ksiqjt0smnhLjG3sex
 4FdZPBvDqPae7td/rC5GqGLZ15kDmDy+grMdw7WtTm2CIrIz10FyEQCNCVKRLHNvPWY0
 bbfA2Wlp80GJlORQJNPwLsEmlRMvfH3ag3gZ96lZNp6iySbXwcpw3c8/YveSxTLpu/79
 4MBhR80RnDYPmwRbtA6vSNfwiTQxELb0VzwokjR/z99LUUXCZ4mPDvYIYyqVPqMtfcpO
 9YcQ==
X-Gm-Message-State: AOJu0Yx1jXamMyPLEQBt1AaXOWMHq0nfMyF/KuWjFuTUHzlURTKB816k
 1u65xOVZ9iXlwCdFiIFlDN6i4HWvX45pp5umkTQw9DmbIeNr3ktswMh+gExRsZI4VXSInOWmHm+
 YoQzpX14sbieu6T63NO8LEv8yuyqQOJC3+vxXOaWDsTofIX4ZQEwJmtFDdVOpT72eLByJdQaqE7
 gxstfWL4og64IyOyA2SjTWT1HMeTY=
X-Received: by 2002:a25:ef12:0:b0:dc7:5018:4022 with SMTP id
 g18-20020a25ef12000000b00dc750184022mr1865841ybd.44.1711106358102; 
 Fri, 22 Mar 2024 04:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRzZ+/ts7hQaW+mk7dMf4N/NkJb62jnsp8qLzYXE3arEAofDVT4M+SEDYtvfXn3kMKEcG6A0HSNN9iRHqQPGw=
X-Received: by 2002:a25:ef12:0:b0:dc7:5018:4022 with SMTP id
 g18-20020a25ef12000000b00dc750184022mr1865814ybd.44.1711106357812; Fri, 22
 Mar 2024 04:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
In-Reply-To: <20240321155717.1392787-1-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Mar 2024 12:18:41 +0100
Message-ID: <CAJaqyWf-oS_Y7EgO7DrVxMj5Roe=yjbbU3tka=Yj3St1ALCvnw@mail.gmail.com>
Subject: Re: [RFC 0/8] virtio,vhost: Add VIRTIO_F_IN_ORDER support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Thu, Mar 21, 2024 at 4:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
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
> of GLib's GHashTable. The decision behind using a hash table was to
> leverage their ability for quick lookup, insertion, and removal
> operations. Given that our keys are simply numbers of an ordered
> sequence, a hash table seemed like the best choice for a buffer
> mechanism.
>
> ---------------------
>
> The strategy behind this implementation is as follows:
>
> We know that buffers that are popped from the available ring and enqueued
> for further processing will always done in the same order in which they
> were made available by the driver. Given this, we can note their order
> by assigning the resulting VirtQueueElement a key. This key is a number
> in a sequence that represents the order in which they were popped from
> the available ring, relative to the other VirtQueueElements.
>
> For example, given 3 "elements" that were popped from the available
> ring, we assign a key value to them which represents their order (elem0
> is popped first, then elem1, then lastly elem2):
>
>      elem2   --  elem1   --  elem0   ---> Enqueue for processing
>     (key: 2)    (key: 1)    (key: 0)
>
> Then these elements are enqueued for further processing by the host.
>
> While most devices will return these completed elements in the same
> order in which they were enqueued, some devices may not (e.g.
> virtio-blk). To guarantee that these elements are put on the used ring
> in the same order in which they were enqueued, we can use a buffering
> mechanism that keeps track of the next expected sequence number of an
> element.
>
> In other words, if the completed element does not have a key value that
> matches the next expected sequence number, then we know this element is
> not in-order and we must stash it away in a hash table until an order
> can be made. The element's key value is used as the key for placing it
> in the hash table.
>
> If the completed element has a key value that matches the next expected
> sequence number, then we know this element is in-order and we can push
> it on the used ring. Then we increment the next expected sequence number
> and check if the hash table contains an element at this key location.
>
> If so, we retrieve this element, push it to the used ring, delete the
> key-value pair from the hash table, increment the next expected sequence
> number, and check the hash table again for an element at this new key
> location. This process is repeated until we're unable to find an element
> in the hash table to continue the order.
>
> So, for example, say the 3 elements we enqueued were completed in the
> following order: elem1, elem2, elem0. The next expected sequence number
> is 0:
>
>     exp-seq-num =3D 0:
>
>      elem1   --> elem1.key =3D=3D exp-seq-num ? --> No, stash it
>     (key: 1)                                         |
>                                                      |
>                                                      v
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>                                                |key: 1 - elem1|
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>     ---------------------
>     exp-seq-num =3D 0:
>
>      elem2   --> elem2.key =3D=3D exp-seq-num ? --> No, stash it
>     (key: 2)                                         |
>                                                      |
>                                                      v
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>                                                |key: 1 - elem1|
>                                                |--------------|
>                                                |key: 2 - elem2|
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>     ---------------------
>     exp-seq-num =3D 0:
>
>      elem0   --> elem0.key =3D=3D exp-seq-num ? --> Yes, push to used rin=
g
>     (key: 0)
>
>     exp-seq-num =3D 1:
>
>     lookup(table, exp-seq-num) !=3D NULL ? --> Yes, push to used ring,
>                                              remove elem from table
>                                                      |
>                                                      v
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>                                                |key: 2 - elem2|
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>     exp-seq-num =3D 2:
>
>     lookup(table, exp-seq-num) !=3D NULL ? --> Yes, push to used ring,
>                                              remove elem from table
>                                                      |
>                                                      v
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>                                                |   *empty*    |
>                                                =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>     exp-seq-num =3D 3:
>
>     lookup(table, exp-seq-num) !=3D NULL ? --> No, done
>     ---------------------
>

I think to use a hashtable to handle this has an important drawback:
it hurts performance on the devices that are using right in-order
because of hash calculus, to benefit devices that are using it badly
by using descriptors out of order. We should use data structs that are
as free as possible for the first, and we don't care to worse the
experience of the devices that enable in_order and they shouldn't.

So I suggest reusing vq->used_elems array vq. At each used descriptor
written in the used ring, you know the next head is elem->index +
elem->ndescs, so you can check if that element has been filled or not.
If used, it needs to be flushed too. If not used, just return.

Of course virtqueue_flush also needs to take this into account.

What do you think, does it make sense to you?

Thanks!


> Jonah Palmer (8):
>   virtio: Define InOrderVQElement
>   virtio: Create/destroy/reset VirtQueue In-Order hash table
>   virtio: Define order variables
>   virtio: Implement in-order handling for virtio devices
>   virtio-net: in-order handling
>   vhost-svq: in-order handling
>   vhost/vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits
>   virtio: Add VIRTIO_F_IN_ORDER property definition
>
>  hw/block/vhost-user-blk.c          |   1 +
>  hw/net/vhost_net.c                 |   2 +
>  hw/net/virtio-net.c                |   6 +-
>  hw/scsi/vhost-scsi.c               |   1 +
>  hw/scsi/vhost-user-scsi.c          |   1 +
>  hw/virtio/vhost-shadow-virtqueue.c |  15 ++++-
>  hw/virtio/vhost-user-fs.c          |   1 +
>  hw/virtio/vhost-user-vsock.c       |   1 +
>  hw/virtio/virtio.c                 | 103 ++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio.h         |  20 +++++-
>  net/vhost-vdpa.c                   |   1 +
>  11 files changed, 145 insertions(+), 7 deletions(-)
>
> --
> 2.39.3
>


