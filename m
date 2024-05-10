Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205FAC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 07:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5L0G-0004NY-06; Fri, 10 May 2024 03:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s5L0D-0004ID-Tb
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s5L0A-0002XT-Eo
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715327347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wt0dTIt6d4wjvyBofQFW28KQCSensSnHLBQWx9Uno0Q=;
 b=CMfUug0s0c8SvIg6XUfRxNofouOU8xQpPSuHCdzxr00t1w30fKO+1C7mFI8chdY4xoB67r
 vqk1ctWxF4V1rS0C77eE/QXU8UDIxgUXznOLGdiH8A8vr4M3Ib7lChKO0q9Ty3Y4eaZw+w
 dvMnkj2jkxf/lFr5UF1sHQymSwlq2T0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-l9_3rDeON5WbTMuRor523Q-1; Fri, 10 May 2024 03:49:06 -0400
X-MC-Unique: l9_3rDeON5WbTMuRor523Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de617c7649dso2620760276.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 00:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715327346; x=1715932146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wt0dTIt6d4wjvyBofQFW28KQCSensSnHLBQWx9Uno0Q=;
 b=HM/ySNfrsBqA7CETb1quBaPEgHOr9hHgYyVpNVoODWdbGxOZ45+1OhWTfOhlkfwTJb
 HKMMFG2Dlh2kdf3MBGllQuGz8r7u2Kaqs6nvdTH8wZT3Y5uVYJ8GxMz8Id8OPo0dP0Qn
 /R2EXRv0PRXvJcDVjY9wZBnSlSnEvMcv0lZp4X3h6ozsp9hznBLLW/90/YJ21ke8u78u
 9E2S6KKnJ0h4OI/QTAf5+0n8zYhJu8/us/SN+zYNq2ndYjHebNwk2z8bc7NoMZwHZZD8
 cRCzG5VypR3kL+ZaqvpDsQs1+dkvJBNUcJYNELaedFtextWilFjp6uXICFvpGS2Q0ShS
 PhkA==
X-Gm-Message-State: AOJu0YyJu7IWBnFQD+avtJWXwoPjc1yNA1u2DU9BgeQfh0TP281x0bw9
 CBRg23JtGvhhkxP73r20ha7mas7hwYx8EWG8upFsU02+tHNG8ezHKTeftdE93yBvwOWD5ldEnGm
 grK9s7FK4nBAuZBSsiFS3Vdmvs/6P3YRYxEC6CcZtjfYY8xcsgTdfqa/pR4soSFSZPK/F5i9+l4
 353qT58WQRpq8WXf5Up3Zm/j9VmWA=
X-Received: by 2002:a25:c7d1:0:b0:de5:9d13:48ac with SMTP id
 3f1490d57ef6-dee4f2f6deemr1926648276.5.1715327345871; 
 Fri, 10 May 2024 00:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW6lIvSV6PJRfNnt0MAg8Qx5Eu3tgVC7KaSPbS66wUMfqoTkFK3NWaxowvf0IHZGExOZtYhdIRSzeah6BJyWI=
X-Received: by 2002:a25:c7d1:0:b0:de5:9d13:48ac with SMTP id
 3f1490d57ef6-dee4f2f6deemr1926624276.5.1715327345511; Fri, 10 May 2024
 00:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240506150428.1203387-1-jonah.palmer@oracle.com>
 <20240506150428.1203387-5-jonah.palmer@oracle.com>
In-Reply-To: <20240506150428.1203387-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 May 2024 09:48:29 +0200
Message-ID: <CAJaqyWd8ALnpr5BVOFpWo1ndUu9Y3XHO0UKtHFzEOFW3FsmWpA@mail.gmail.com>
Subject: Re: [PATCH 4/6] virtio: virtqueue_ordered_flush - VIRTIO_F_IN_ORDER
 support
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
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, May 6, 2024 at 5:06=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add VIRTIO_F_IN_ORDER feature support for virtqueue_flush operations.
>
> The goal of the virtqueue_flush operation when the VIRTIO_F_IN_ORDER
> feature has been negotiated is to write elements to the used/descriptor
> ring in-order and then update used_idx.
>
> The function iterates through the VirtQueueElement used_elems array
> in-order starting at vq->used_idx. If the element is valid (filled), the
> element is written to the used/descriptor ring. This process continues
> until we find an invalid (not filled) element.
>
> If any elements were written, the used_idx is updated.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c | 75 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 064046b5e2..0efed2c88e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1006,6 +1006,77 @@ static void virtqueue_packed_flush(VirtQueue *vq, =
unsigned int count)
>      }
>  }
>
> +static void virtqueue_ordered_flush(VirtQueue *vq)
> +{
> +    unsigned int i =3D vq->used_idx;
> +    unsigned int ndescs =3D 0;
> +    uint16_t old =3D vq->used_idx;
> +    bool packed;
> +    VRingUsedElem uelem;
> +
> +    packed =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED);
> +
> +    if (packed) {
> +        if (unlikely(!vq->vring.desc)) {
> +            return;
> +        }
> +    } else if (unlikely(!vq->vring.used)) {
> +        return;
> +    }
> +
> +    /* First expected in-order element isn't ready, nothing to do */
> +    if (!vq->used_elems[i].filled) {
> +        return;
> +    }
> +
> +    /* Write first expected in-order element to used ring (split VQs) */
> +    if (!packed) {
> +        uelem.id =3D vq->used_elems[i].index;
> +        uelem.len =3D vq->used_elems[i].len;
> +        vring_used_write(vq, &uelem, i);
> +    }
> +
> +    ndescs +=3D vq->used_elems[i].ndescs;
> +    i +=3D ndescs;
> +    if (i >=3D vq->vring.num) {
> +        i -=3D vq->vring.num;
> +    }
> +
> +    /* Search for more filled elements in-order */
> +    while (vq->used_elems[i].filled) {
> +        if (packed) {
> +            virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, f=
alse);
> +        } else {
> +            uelem.id =3D vq->used_elems[i].index;
> +            uelem.len =3D vq->used_elems[i].len;
> +            vring_used_write(vq, &uelem, i);
> +        }
> +
> +        vq->used_elems[i].filled =3D false;
> +        ndescs +=3D vq->used_elems[i].ndescs;
> +        i +=3D ndescs;
> +        if (i >=3D vq->vring.num) {
> +            i -=3D vq->vring.num;
> +        }
> +    }
> +

I may be missing something, but you have split out the first case as a
special one, totally out of the while loop. Can't it be contained in
the loop checking !(packed && i =3D=3D vq->used_idx)? That would avoid
code duplication.

A comment can be added in the line of "first entry of packed is
written the last so the guest does not see invalid descriptors".

> +    if (packed) {
> +        virtqueue_packed_fill_desc(vq, &vq->used_elems[vq->used_idx], 0,=
 true);
> +        vq->used_idx +=3D ndescs;
> +        if (vq->used_idx >=3D vq->vring.num) {
> +            vq->used_idx -=3D vq->vring.num;
> +            vq->used_wrap_counter ^=3D 1;
> +            vq->signalled_used_valid =3D false;
> +        }
> +    } else {
> +        vring_used_idx_set(vq, i);
> +        if (unlikely((int16_t)(i - vq->signalled_used) < (uint16_t)(i - =
old))) {
> +            vq->signalled_used_valid =3D false;
> +        }
> +    }
> +    vq->inuse -=3D ndescs;
> +}
> +
>  void virtqueue_flush(VirtQueue *vq, unsigned int count)
>  {
>      if (virtio_device_disabled(vq->vdev)) {
> @@ -1013,7 +1084,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int co=
unt)
>          return;
>      }
>
> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
> +        virtqueue_ordered_flush(vq);
> +    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) =
{
>          virtqueue_packed_flush(vq, count);
>      } else {
>          virtqueue_split_flush(vq, count);
> --
> 2.39.3
>


