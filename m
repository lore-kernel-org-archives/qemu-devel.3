Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA939C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 16:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9oVR-0007h9-DM; Wed, 22 May 2024 12:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9oVK-0007eI-Ar
 for qemu-devel@nongnu.org; Wed, 22 May 2024 12:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9oVF-0004mB-2w
 for qemu-devel@nongnu.org; Wed, 22 May 2024 12:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716394063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFilv3pbs+35EgsHoQGw65hmxQaAATuFuNpim+MUR0g=;
 b=bRBz+Bal9nmqv+vPRtFOH/bOx3c4WGrrTfx+7Rp2GYbFFdC0PzHIcRpE6eVxxSt3CUw2eH
 tZufzIqoH+tgCLG+tzNK0ajN20OvOrgSt+3PCGDcWiyracTflnRKJ5l99NgZOt25uRunX7
 DcgP8kx2Lm4/t95wDn3SqnbIHKhFeLU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-3V-X2T7bMBGuE3xZO0jqUg-1; Wed, 22 May 2024 12:07:41 -0400
X-MC-Unique: 3V-X2T7bMBGuE3xZO0jqUg-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc6dbdcfd39so26611227276.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 09:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716394061; x=1716998861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFilv3pbs+35EgsHoQGw65hmxQaAATuFuNpim+MUR0g=;
 b=LYQhrap1AexwgJ1zhwfNX08SuJeWqXfeUhcf/Cj8RNwFEEyDfyJMdZbtUYkkMSXUws
 fQAGUFzkOVIXfU8oh2pT0RCiV8DgX2MIcZTzM8HelixnYcIajtJIzWY1BmtkJbw37Ru0
 Pv9Wtvj+lBTwv4rrcbaZvAO99RDruZMH/qeVhf9I+TFG/r2qCNe6cd7fkWwn53y28gLK
 rk0D0a70b3xOzI8rqLbKJYvWZqTeL4rx4YcUmfThT0jtTDN7krHo2w7m9XH7q+bEzpgk
 I6dF2mxm3kEZ+kAow0EqB8nl01jMxw+z7+BQoQ57owGzPAfSiiQYSg5Q6byaR1hOunW9
 DdRQ==
X-Gm-Message-State: AOJu0YzU3ymAfA7jH24r5uULC6FHUI32n5ihUMlJBSYRrZEZNqx2+cGh
 x5Ri+FnUJ4CCBAyKUDEdThNyyCsxMhleFnsz/bZ3CYxu8EH9MHUK1/zRDVx7tBSzRl1xY3EyRKz
 C0M8u+RqEzgchJi820gLDZtHkLEMTbV4TukrzU+2SG1VdaYN22sw4EyjQ3yzxO0K3bnZMGWA1Lm
 +XP72pICxPSn5dniIRfpufy9XeA6M=
X-Received: by 2002:a5b:b49:0:b0:de4:634c:b2fb with SMTP id
 3f1490d57ef6-df4e0bcafd3mr2574619276.35.1716394060667; 
 Wed, 22 May 2024 09:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZPsKGZkaK960aVcenANeqiEnBLvDfmpByfzVmheFQ1GplmSFQisKMFeZnFzQL6u/071hTioI1SkQfCR3LqGk=
X-Received: by 2002:a5b:b49:0:b0:de4:634c:b2fb with SMTP id
 3f1490d57ef6-df4e0bcafd3mr2574581276.35.1716394060278; Wed, 22 May 2024
 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240520130048.1483177-1-jonah.palmer@oracle.com>
 <20240520130048.1483177-4-jonah.palmer@oracle.com>
In-Reply-To: <20240520130048.1483177-4-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 May 2024 18:07:04 +0200
Message-ID: <CAJaqyWdxt+cPNR=unm6P1cGCKV=LwhuMYdVeQLbWF6wYLBLWKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER
 support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Mon, May 20, 2024 at 3:01=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Add VIRTIO_F_IN_ORDER feature support for the virtqueue_fill operation.
>
> The goal of the virtqueue_ordered_fill operation when the
> VIRTIO_F_IN_ORDER feature has been negotiated is to search for this
> now-used element, set its length, and mark the element as filled in
> the VirtQueue's used_elems array.
>
> By marking the element as filled, it will indicate that this element has
> been processed and is ready to be flushed, so long as the element is
> in-order.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7456d61bc8..01b6b32460 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -873,6 +873,38 @@ static void virtqueue_packed_fill(VirtQueue *vq, con=
st VirtQueueElement *elem,
>      vq->used_elems[idx].ndescs =3D elem->ndescs;
>  }
>
> +static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement=
 *elem,
> +                                   unsigned int len)
> +{
> +    unsigned int i, steps, max_steps;
> +
> +    i =3D vq->used_idx;
> +    steps =3D 0;
> +    /*
> +     * We shouldn't need to increase 'i' by more than the distance
> +     * between used_idx and last_avail_idx.
> +     */
> +    max_steps =3D (vq->last_avail_idx + vq->vring.num - vq->used_idx)
> +                % vq->vring.num;

I may be missing something, but (+vq->vring.num) is redundant if we (%
vq->vring.num), isn't it?

> +
> +    /* Search for element in vq->used_elems */
> +    while (steps <=3D max_steps) {
> +        /* Found element, set length and mark as filled */
> +        if (vq->used_elems[i].index =3D=3D elem->index) {
> +            vq->used_elems[i].len =3D len;
> +            vq->used_elems[i].in_order_filled =3D true;
> +            break;
> +        }
> +
> +        i +=3D vq->used_elems[i].ndescs;
> +        steps +=3D vq->used_elems[i].ndescs;
> +
> +        if (i >=3D vq->vring.num) {
> +            i -=3D vq->vring.num;
> +        }
> +    }
> +}
> +

Let's report an error if we finish the loop. I think:
qemu_log_mask(LOG_GUEST_ERROR,
              "%s: %s cannot fill buffer id %u\n",
              __func__, vdev->name, elem->index);

(or similar) should do.

apart form that,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  static void virtqueue_packed_fill_desc(VirtQueue *vq,
>                                         const VirtQueueElement *elem,
>                                         unsigned int idx,
> @@ -923,7 +955,9 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueEle=
ment *elem,
>          return;
>      }
>
> -    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_IN_ORDER)) {
> +        virtqueue_ordered_fill(vq, elem, len);
> +    } else if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) =
{
>          virtqueue_packed_fill(vq, elem, len, idx);
>      } else {
>          virtqueue_split_fill(vq, elem, len, idx);
> --
> 2.39.3
>


