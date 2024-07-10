Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F6C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRa0Q-00071e-OG; Wed, 10 Jul 2024 12:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sRa0N-00070S-HL
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sRa0K-0001C0-Pz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720628235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RN+Cyaod45FRM4pbFQEXu+jCysRMbqUsAMGmsZni5WE=;
 b=TsFUsmmh/PzuoAQzgzEMFu1Ofh7L4890BhQudUSBSM8Jf4cJlIULLyMdY6yJJ7dm6HRYTR
 aZM7azAnqv32qsh4lszLyYcHw6hWu2mjlSaHBU0vkhl8bMu+NMXcufx+Kdy+6vvqLP52Hv
 IsXHPnS1Rls3S1nkY9bqgSSPimma6Xo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-6r70zM12M3iYou9W90RORw-1; Wed, 10 Jul 2024 12:17:12 -0400
X-MC-Unique: 6r70zM12M3iYou9W90RORw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-653306993a8so95614757b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720628232; x=1721233032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RN+Cyaod45FRM4pbFQEXu+jCysRMbqUsAMGmsZni5WE=;
 b=obrCW0SrT70H01UaxmzcrVU0jeWHIh/0b+Ej8pP6H6opw518e1Aa2N+zLwNoFnpVVi
 y67zt/6wQw+4s33Vwztei/EMedERiCMMsbNKD+ZqAvRevhIlZ24whlZBJxzlSUt5z0cc
 UfM0f9+Qxx5zE9hJ3XYG+NrcKEzVCmmQK8MJRyvVeci/8qdim7jsgkudXe6c4+hAcu1g
 lJxF0SBd2jdufG7IRx/WbjbttgLez0lr57PzvTyHMapsInbkYE2v77rjbFcN5M3CE0s9
 RoPuij41FwyWxL45qfqaNK5q8afgZAfVeRPmFux15eJ43Rp1w2PC6/a+ytJnDafxJn4I
 AtMA==
X-Gm-Message-State: AOJu0YwAtn+cb7wcmt+L7ggz+73glCPYHBYxBynDD/lQeiWDvozJT5rx
 PWU1yYvOle9IAN3Rux0WNrwNU0uvnC0mVhMaUJPRgS1LyDRs/h8eArQi6RbDjjt20FKb9jSQRAA
 Ftku2KR0KUyHViBk22SV+/rOlo/Yn93QZkem6tJkOcYBUPu1q8gPRpldDxgrbDHgfkovp4caj5c
 xhm0LkLVJG1LryNB8yrwALxG9o3DA=
X-Received: by 2002:a81:5b42:0:b0:64a:6eda:fc60 with SMTP id
 00721157ae682-658ee69ac4cmr68719307b3.4.1720628232331; 
 Wed, 10 Jul 2024 09:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx96Zdg0x9PwmiJz7fW1Yj/5iewtu0Rawq71SJ5g0w/ZxTyxwG3nC+/ch8ExvdfAmm4qFIsLa85dROMUHl0LI=
X-Received: by 2002:a81:5b42:0:b0:64a:6eda:fc60 with SMTP id
 00721157ae682-658ee69ac4cmr68718837b3.4.1720628231788; Wed, 10 Jul 2024
 09:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240710125522.4168043-1-jonah.palmer@oracle.com>
 <20240710125522.4168043-5-jonah.palmer@oracle.com>
In-Reply-To: <20240710125522.4168043-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 10 Jul 2024 18:16:35 +0200
Message-ID: <CAJaqyWfRCAif9ou9XMCbDaKWPqt9msB7QbdbSGVkqTJv8O_McQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] virtio: virtqueue_ordered_flush -
 VIRTIO_F_IN_ORDER support
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
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Jul 10, 2024 at 2:56=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Add VIRTIO_F_IN_ORDER feature support for the virtqueue_flush operation.
>
> The goal of the virtqueue_ordered_flush operation when the
> VIRTIO_F_IN_ORDER feature has been negotiated is to write elements to
> the used/descriptor ring in-order and then update used_idx.
>
> The function iterates through the VirtQueueElement used_elems array
> in-order starting at vq->used_idx. If the element is valid (filled), the
> element is written to the used/descriptor ring. This process continues
> until we find an invalid (not filled) element.
>
> For packed VQs, the first entry (at vq->used_idx) is written to the
> descriptor ring last so the guest doesn't see any invalid descriptors.
>
> If any elements were written, the used_idx is updated.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
> Several fixes here for the split VQ case:
> - Ensure all previous write operations to buffers are completed before
>   updating the used_idx (via smp_wmb()).
>
> - used_elems index 'i' should be incremented by the number of descriptors
>   in the current element we just processed, not by the running total of
>   descriptors already seen. This would've caused batched operations to
>   miss ordered elements when looping through the used_elems array.
>
> - Do not keep the VQ's used_idx bound between 0 and vring.num-1 when
>   setting it via vring_used_idx_set().
>
>   While the packed VQ case naturally keeps used_idx bound between 0 and
>   vring.num-1, the split VQ case cannot. This is because used_idx is
>   used to compare the current event index with the new and old used
>   indices to decide if a notification is necessary (see
>   virtio_split_should_notify()). This comparison expects used_idx to be
>   between 0 and 65535, not 0 and vring.num-1.
>
>  hw/virtio/virtio.c | 70 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 0000a7b41c..b419d8d6e7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1023,6 +1023,72 @@ static void virtqueue_packed_flush(VirtQueue *vq, =
unsigned int count)
>      }
>  }
>
> +static void virtqueue_ordered_flush(VirtQueue *vq)
> +{
> +    unsigned int i =3D vq->used_idx % vq->vring.num;
> +    unsigned int ndescs =3D 0;
> +    uint16_t old =3D vq->used_idx;
> +    uint16_t new;
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
> +    if (!vq->used_elems[i].in_order_filled) {
> +        return;
> +    }
> +
> +    /* Search for filled elements in-order */
> +    while (vq->used_elems[i].in_order_filled) {
> +        /*
> +         * First entry for packed VQs is written last so the guest
> +         * doesn't see invalid descriptors.
> +         */
> +        if (packed && i !=3D vq->used_idx) {
> +            virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, f=
alse);
> +        } else if (!packed) {
> +            uelem.id =3D vq->used_elems[i].index;
> +            uelem.len =3D vq->used_elems[i].len;
> +            vring_used_write(vq, &uelem, i);
> +        }
> +
> +        vq->used_elems[i].in_order_filled =3D false;
> +        ndescs +=3D vq->used_elems[i].ndescs;
> +        i +=3D vq->used_elems[i].ndescs;
> +        if (i >=3D vq->vring.num) {
> +            i -=3D vq->vring.num;
> +        }
> +    }
> +
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
> +        /* Make sure buffer is written before we update index. */
> +        smp_wmb();
> +        new =3D old + ndescs;
> +        vring_used_idx_set(vq, new);
> +        if (unlikely((int16_t)(new - vq->signalled_used) < (uint16_t)(ne=
w - old))) {
> +            vq->signalled_used_valid =3D false;
> +        }
> +    }
> +    vq->inuse -=3D ndescs;
> +}
> +
>  void virtqueue_flush(VirtQueue *vq, unsigned int count)
>  {
>      if (virtio_device_disabled(vq->vdev)) {
> @@ -1030,7 +1096,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int co=
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
> 2.43.5
>


