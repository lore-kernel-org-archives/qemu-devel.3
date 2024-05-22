Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFA1C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9oAP-0004Uf-CR; Wed, 22 May 2024 11:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9oAN-0004Si-AW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s9oAL-00012H-NM
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716392769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dohSD+xMyXX8VQW8PMZIyNH8UCTgtLWA68tTvl5P8RA=;
 b=AIOUvoZv2i9Q473lEBYLFyvXE2NItadXWH3US3NjcxMAVV4EHWdKUNXjASwXuHgcCW4j7U
 7/6ZYT4h1JsKzymUKjNhYlB8FbVH6jSjXtYK/mvdrEfMkmIAvZM8XePzl5n0gMKIzTcmLz
 qHe2awv4oLH5rk5ypBmCm0xO0omNZtU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XiRMpllsONifLt5ESEQBLw-1; Wed, 22 May 2024 11:46:07 -0400
X-MC-Unique: XiRMpllsONifLt5ESEQBLw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de61a10141fso20531613276.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 08:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716392767; x=1716997567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dohSD+xMyXX8VQW8PMZIyNH8UCTgtLWA68tTvl5P8RA=;
 b=nBjPVBVp8v5UEhG5PRfQAlROZWaZA6OzvX/2OnxihBYmX3g5C35RX05nQaenJyH0cq
 gg6LZJA+n8F8TdO/snUVuDLVraXdunK0KbytKtNAiG6f+96vhglQt4E1Oht5N5MJQmiJ
 Kc5ufxYffHQX5O5Oaj4z4NgUpVVengJ5rYFli0m93OZK05ok+tTh3WVoxtSiXXyZjEgc
 uQIDdzZunjAaCIHHtc8zRgJM/F32OpttjRnS61wYiL7iEKKbgFEPKEOmcUmzjk52q/gc
 puZP9+kZm0br4HqBMccMPPBc0U/2m7k3e4NRQlv111wotk+3DJwxhcKsyKxBKWVaLC9Z
 7L3Q==
X-Gm-Message-State: AOJu0YxNKiD8UZZ9tWFzHNQBboQhNUrPmrFLgmmJM0ft1lXeOnZMFr3p
 62RBuWDkKWlOmmekn65GeAifTor209aOVbGSOs+O5iix33+en+uCtuQMLo9K5UyQTk6jW7agGPj
 DDnlEMMzucG2J5BG1xoqvitlWZeneyHPPsodIYgRFDQQ6RCmm0BYUjYwY5Co7vmt7oTAviCnHni
 kZKmjBO8W/Y9GahVM+qMHAb3tFHA4=
X-Received: by 2002:a25:add5:0:b0:de0:de50:d6d4 with SMTP id
 3f1490d57ef6-df4e0a6e798mr2683754276.8.1716392767259; 
 Wed, 22 May 2024 08:46:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjVEJ7I8YyfrTgHsOl3Et6/mGrY9eCItONq3gG92V0rIP1Z6NuZLnO4gcTlmJVyMvFE4mwGYr59PZjgbp9vHo=
X-Received: by 2002:a25:add5:0:b0:de0:de50:d6d4 with SMTP id
 3f1490d57ef6-df4e0a6e798mr2683635276.8.1716392765393; Wed, 22 May 2024
 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240520130048.1483177-1-jonah.palmer@oracle.com>
 <20240520130048.1483177-3-jonah.palmer@oracle.com>
In-Reply-To: <20240520130048.1483177-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 May 2024 17:45:29 +0200
Message-ID: <CAJaqyWePFXKm9qSjczbWyacadd7Cxv2NxEvM1qT=UYNi_VW7qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
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

On Mon, May 20, 2024 at 3:01=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
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
> index 893a072c9d..7456d61bc8 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1506,7 +1506,7 @@ static void *virtqueue_alloc_element(size_t sz, uns=
igned out_num, unsigned in_nu
>
>  static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>  {
> -    unsigned int i, head, max;
> +    unsigned int i, head, max, prev_avail_idx;
>      VRingMemoryRegionCaches *caches;
>      MemoryRegionCache indirect_desc_cache;
>      MemoryRegionCache *desc_cache;
> @@ -1539,6 +1539,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>          goto done;
>      }
>
> +    prev_avail_idx =3D vq->last_avail_idx;
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

I think vq->last_avail_idx - 1 could be more clear here.

Either way,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +        vq->used_elems[prev_avail_idx].index =3D elem->index;
> +        vq->used_elems[prev_avail_idx].len =3D elem->len;
> +        vq->used_elems[prev_avail_idx].ndescs =3D elem->ndescs;
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
>      vq->last_avail_idx +=3D elem->ndescs;
>      vq->inuse +=3D elem->ndescs;
>
> --
> 2.39.3
>


