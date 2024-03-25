Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD45CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropl1-0002ng-VX; Mon, 25 Mar 2024 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ropl0-0002mk-69
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ropky-0006Bj-GT
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711393995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0oaGtLwvaJUP5Gd1Zr0Uu7Z4hDcKfa0UJ+Nmhxot/I=;
 b=CdMb13dKPjADMAq/0J7NA4fog5Wnw1moOroOWMoVX0FBCP+KXBQ1sXLCacF7Ds3+59J8XD
 b6n/+Mm2cmegRLJcIwB58CAINytVVt1uxFd/lKidR1QHWzBscNgS2GeVzN7HiI2AHDQVZx
 /gj3S5z1vbkD7PNpPH6VgrW4hi0NYs8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-X0IVyPz1OYShPWGnCmNLYg-1; Mon, 25 Mar 2024 15:13:13 -0400
X-MC-Unique: X0IVyPz1OYShPWGnCmNLYg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6b26845cdso6875436276.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393993; x=1711998793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0oaGtLwvaJUP5Gd1Zr0Uu7Z4hDcKfa0UJ+Nmhxot/I=;
 b=rcRy8pGSkHrfAq9gF9RrKpVW69mX7qFS9g24btriD4pSMvtdSXN4rQesiDJwAfMu12
 mHHPwCIrBsa/z03bHyjW7I8+EmPr8V3js/yVdrDD1GQ0O34UjzRJXCGpQD/fMQ/JQbMv
 2hX2WkvxrLdrPO78M7qYcMyq+meVeabnTXHtt8uEgV3R/Frho3Hc7OoS7PTmc/BYMMMt
 QrKrMfsKqqqU/mgQJGWSvQQ15yswsnElxUcjPA/WYouLORzPvj22IJFMLRE5o0eCPl+H
 w/P0tkYDwt4WW3rAr3X/bWBaOjU9OF0N/GFZkutnXdp8Z1dT9Q/orZj1tVoX3vE6axhu
 jzug==
X-Gm-Message-State: AOJu0Yy17KzeuCNRcHf+ozxmARs1l7yp7CILP9ctEXnRqo0RtOWfK/82
 VX9UUFw3k7LJNwUdHz/cZ0SyAtkTW8NNSj8pzk66J9ZktxgaF12ZEVV8EA8sJ5P2KETiuulNdVQ
 Fl4N15AMmI/5egc7119cN8zF0USB07Af0ZsO2XQf1sm4FKhuZgkuJCQ3Xym9PdxYhqLm6uGtZvz
 thflbds9CT4muw9ux8iJodcW31gik=
X-Received: by 2002:a25:6ad6:0:b0:dcf:47b6:9155 with SMTP id
 f205-20020a256ad6000000b00dcf47b69155mr6008318ybc.54.1711393993111; 
 Mon, 25 Mar 2024 12:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETgZqBtBhy4Cd6CP83C5BPHY+YtY9JiKvjBUSGVHCeY1ElaYJ436hT2pe8t461kBaFxUkuZruaWRfd30yCNw0=
X-Received: by 2002:a25:6ad6:0:b0:dcf:47b6:9155 with SMTP id
 f205-20020a256ad6000000b00dcf47b69155mr6008302ybc.54.1711393992762; Mon, 25
 Mar 2024 12:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240321155717.1392787-1-jonah.palmer@oracle.com>
 <20240321155717.1392787-2-jonah.palmer@oracle.com>
 <CAJaqyWdg5tg1XR43bHkMRnqvkTZVvrqXMKM__YD6t-xGBOXdYg@mail.gmail.com>
 <205047df-d581-4eb3-9a63-73b7f1754d01@oracle.com>
In-Reply-To: <205047df-d581-4eb3-9a63-73b7f1754d01@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 25 Mar 2024 20:12:36 +0100
Message-ID: <CAJaqyWcWQ6ZK7g8OT9uFXCYNuByw6hY7utUX_fPx=2dL+G7FNQ@mail.gmail.com>
Subject: Re: [RFC 1/8] virtio: Define InOrderVQElement
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
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

On Mon, Mar 25, 2024 at 6:08=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/22/24 5:45 AM, Eugenio Perez Martin wrote:
> > On Thu, Mar 21, 2024 at 4:57=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Define the InOrderVQElement structure for the VIRTIO_F_IN_ORDER
> >> transport feature implementation.
> >>
> >> The InOrderVQElement structure is used to encapsulate out-of-order
> >> VirtQueueElement data that was processed by the host. This data
> >> includes:
> >>   - The processed VirtQueueElement (elem)
> >>   - Length of data (len)
> >>   - VirtQueueElement array index (idx)
> >>   - Number of processed VirtQueueElements (count)
> >>
> >> InOrderVQElements will be stored in a buffering mechanism until an
> >> order can be achieved.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   include/hw/virtio/virtio.h | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index b3c74a1bca..c8aa435a5e 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -77,6 +77,13 @@ typedef struct VirtQueueElement
> >>       struct iovec *out_sg;
> >>   } VirtQueueElement;
> >>
> >> +typedef struct InOrderVQElement {
> >> +    const VirtQueueElement *elem;
> >
> > Some subsystems allocate space for extra elements after
> > VirtQueueElement, like VirtIOBlockReq. You can request virtqueue_pop
> > to allocate this extra space by its second argument. Would it work for
> > this?
> >
>
> I don't see why not. Although this may not be necessary due to me
> missing a key aspect mentioned in your comment below.
>
> >> +    unsigned int len;
> >> +    unsigned int idx;
> >> +    unsigned int count;
> >
> > Now I don't get why these fields cannot be obtained from elem->(len,
> > index, ndescs) ?
> >
>
> Interesting. I didn't realize that these values are equivalent to a
> VirtQueueElement's len, index, and ndescs fields.
>
> Is this always true? Else I would've expected, for example,
> virtqueue_push to not need the 'unsigned int len' parameter if this
> information is already included via. the VirtQueueElement being passed in=
.
>

The code uses "len" to store the written length values of each used
descriptor between virtqueue_fill and virtqueue_flush. But not all
devices use these separately, only the ones that batches: virtio-net
and SVQ.

A smarter / less simpler implementation of virtqueue_push could
certainly avoid storing elem->len. But the performance gain is
probably tiny, and the code complexity grows.

> >> +} InOrderVQElement;
> >> +
> >>   #define VIRTIO_QUEUE_MAX 1024
> >>
> >>   #define VIRTIO_NO_VECTOR 0xffff
> >> --
> >> 2.39.3
> >>
> >
>


