Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBC7C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53bG-0005cd-Lj; Thu, 09 May 2024 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s53b1-0005aD-SH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s53b0-0004E9-2B
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715260439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vo0rdvNCtADGJUOZEToQ/LD1I8me2EZpGdoGQrmHLOg=;
 b=EyPJS/EfVN2p8EGOo2VdDKUS/SZikfMeN7yCPl6B9uKcVI1ortX+ZNcY9tmeHL1YwM3Ssa
 cj6XHr9PvI7pKYY4Z8vphFWm9/M9wPYX1TgCOi3IEkcxWR7Y+ZC99X3A9ID9BYGJ6+PzUm
 immIEncyeKNDJ+Z5LBLbIhS0FEL6M1g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-dAcSTA_HPnuWcUSJeIUlmw-1; Thu, 09 May 2024 09:13:58 -0400
X-MC-Unique: dAcSTA_HPnuWcUSJeIUlmw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de57643041bso1476705276.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715260438; x=1715865238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vo0rdvNCtADGJUOZEToQ/LD1I8me2EZpGdoGQrmHLOg=;
 b=FtF6kHVBHWTvwXw/D/YEPsLe+8pExcP/juHmehWs1oj34I811cRBpSmcU2x7MLbPjt
 Ibyqrw7ohT+4K61dtOEpWRyaH5ps4to8jK1tS2jjkAFP3TwTxSghW/2tkRkLUruzRGtI
 xVuHarxMe7agOgsocYjCpbXB8XndutgyLp1yedUg87wV7xaWCO5LutKBP4sYxu/doPX5
 AaSFxn7gOQ+Q87Pzpug1K0PjWHg2Inefdid/W3AvSmL+vh4cGtjKP4cswcb6mtwBjLBl
 8yAi4TxPZu2/hEWvNvMvvesunCWcGVkMRkLFB8omhh/LrF2V0aXSKfbvaVMClBbwgv7t
 UikA==
X-Gm-Message-State: AOJu0YxPXn0RkoPs2vnSzjh21PhFkbOmMMmn+yHYONBgASSZgDLeSkEf
 fyheqOZSb9RwwMXVZ4muBwDmVNWW8Vw/+qzmpwFXTfwMh89lUy50sZQINDsIH9ErT2DPNixDtpo
 DiqL4tXrByTy8IXcj6X7n9c5pZeRRmGQ6lh+f4uHHCT9zcbirORJ1+BhwgBZ1qQdLN90d7VR/rn
 LZkXsOtUz3rpnwD8nAdAV7cUZcLQs=
X-Received: by 2002:a25:8151:0:b0:deb:c936:abf6 with SMTP id
 3f1490d57ef6-debc936af36mr3725928276.24.1715260437494; 
 Thu, 09 May 2024 06:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGONfrpqmIcMELAUBDnfsvHxU0WLuUoopLIbdS4VMP4j2x+TBBXXj08cQmBmG2QaWU1aSnr9k6nKk09ob4wT48=
X-Received: by 2002:a25:8151:0:b0:deb:c936:abf6 with SMTP id
 3f1490d57ef6-debc936af36mr3725843276.24.1715260435683; Thu, 09 May 2024
 06:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240506150428.1203387-1-jonah.palmer@oracle.com>
 <20240506150428.1203387-3-jonah.palmer@oracle.com>
In-Reply-To: <20240506150428.1203387-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 9 May 2024 15:13:19 +0200
Message-ID: <CAJaqyWeASizkBEmef4Yo7Mv0hF2zKe2p627G4ZEgVG0kMkCCOg@mail.gmail.com>
Subject: Re: [PATCH 2/6] virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
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

On Mon, May 6, 2024 at 5:06=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Add VIRTIO_F_IN_ORDER feature support in virtqueue_split_pop and
> virtqueue_packed_pop.
>
> VirtQueueElements popped from the available/descritpor ring are added to
> the VirtQueue's used_elems array in-order and in the same fashion as
> they would be added the used and descriptor rings, respectively.
>
> This will allow us to keep track of the current order, what elements
> have been written, as well as an element's essential data after being
> processed.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/virtio.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..e6eb1bb453 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1506,7 +1506,7 @@ static void *virtqueue_alloc_element(size_t sz, uns=
igned out_num, unsigned in_nu
>
>  static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>  {
> -    unsigned int i, head, max;
> +    unsigned int i, j, head, max;
>      VRingMemoryRegionCaches *caches;
>      MemoryRegionCache indirect_desc_cache;
>      MemoryRegionCache *desc_cache;
> @@ -1539,6 +1539,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>          goto done;
>      }
>
> +    j =3D vq->last_avail_idx;
> +
>      if (!virtqueue_get_head(vq, vq->last_avail_idx++, &head)) {
>          goto done;
>      }
> @@ -1630,6 +1632,12 @@ static void *virtqueue_split_pop(VirtQueue *vq, si=
ze_t sz)
>          elem->in_sg[i] =3D iov[out_num + i];
>      }
>
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        vq->used_elems[j].index =3D elem->index;
> +        vq->used_elems[j].len =3D elem->len;
> +        vq->used_elems[j].ndescs =3D elem->ndescs;
> +    }
> +
>      vq->inuse++;
>
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> @@ -1758,6 +1766,13 @@ static void *virtqueue_packed_pop(VirtQueue *vq, s=
ize_t sz)
>
>      elem->index =3D id;
>      elem->ndescs =3D (desc_cache =3D=3D &indirect_desc_cache) ? 1 : elem=
_entries;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
> +        vq->used_elems[vq->last_avail_idx].index =3D elem->index;
> +        vq->used_elems[vq->last_avail_idx].len =3D elem->len;
> +        vq->used_elems[vq->last_avail_idx].ndescs =3D elem->ndescs;
> +    }
> +

I suggest using a consistent style between packed and split: Either
always use vq->last_avail_idx or j. If you use j, please rename to
something more related to the usage, as j is usually for iterations.

In my opinion I think vq->last_avail_idx is better.


>      vq->last_avail_idx +=3D elem->ndescs;
>      vq->inuse +=3D elem->ndescs;
>
> --
> 2.39.3
>


