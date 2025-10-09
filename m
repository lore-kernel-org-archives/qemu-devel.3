Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B166CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vsz-00039L-1L; Thu, 09 Oct 2025 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vsq-00033B-Nk
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:01:01 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vso-0006fa-M6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:01:00 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-42d857dcf92so5108575ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036457; x=1760641257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1J0aTemP4mbLOs9UQusEjIqmVRqzBoElXKvoRf3q6CI=;
 b=lZTmnrDrDnm1ZrdksxAvZUjCwne0hMzSRRHrb1M1OyIwCZ3IYlweu972U29W3wF1Vp
 qT6+Mukb2zUa93tDgd60cvIfbaagv+nqcUTLots9cWmxM+GhSic1xf6Q9YjGMqeTyhWu
 gG6XXp6RFFSTxkPJuliZcBSTbbDir0IsTdUXIh27PolKFXQEI1sBod7RI0XsswqyR/Vl
 N3vkWivM2oXb5Ow337lhVFCFiraMNPLcpHThwvnbNc26b/KJuKNC/XhZjXMizgodTMdy
 IlN2u2UxElggfLCF65WE3mp0c3lMZzE/WWi5yCNMFFPG1hFGdeMym0QDHfS+U/8TIajF
 A7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036457; x=1760641257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1J0aTemP4mbLOs9UQusEjIqmVRqzBoElXKvoRf3q6CI=;
 b=AICCNzNpyFvdOUaXxzPpgjsBguAm5z/XaWc0CtLK3YNdnRhkyjqN4kns1vloVr6KeI
 4KFEGkxPDOULaXhDKHyQphQJ5R+aK0olfbPpNpvk/FmooGV3o5ijKEd5cReSHEeCwy0w
 aBSB6e4iLDdGXBnjdod20EBcbbqIRla974ascTccHJflQ3elCw1pbydU6bDzyhRBxdpm
 GfLro+jDxNVeFkqG/FHJOvxV6FnsM7DViitUq+xtDqt6bzTKyZlzOxc20TMTjLdrtjqV
 39BLGbUU+TGwB/YwzAu3E8xcQ8AVXXBNG+usS6zSyz91iOzqkgTL2wDOw24If7w/2Jmi
 v5FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUalv84pHrQm/ntHROpvKx6eLROPjJ+Uvmt8FHpM+80r61+bOLIYO+enPxACLC4AifvLAVytxLJAR+H@nongnu.org
X-Gm-Message-State: AOJu0YzbB02g5mlVMqB4ZO2pp/ofYNrRU1/vtaCFqMmEEqPFYP3B1cgs
 f2N1BRubP1WquQz+PdOdBJVWSEV6uoBqvnjlff8LytpcXV+y+ZhwZP/ZK8DQNk8aB0PBn1A+gCP
 NoH2pTuGMDmMai7Bo5aWVmSK39nGgvN0=
X-Gm-Gg: ASbGnct8B9Cy55ZPi5Vs6jwh0QqUvU/KRlSlzwh4zgd0f5SKxVrY99ASUNtmO4CgZzj
 tNJdHUjaCJjd1ptOEkmdrpCsKOtVLGH8tVfdLXsAho9Dm2EKRtqmPvwmYgjpq7snBZDWZWUONYz
 e421LtHY0e/9dblUWnS11N9d4vuSZJCfhnI7YwodcIC149uoHDDKrCxlueuFeNy1wj+d1f7tASl
 fYtPwfWV7x/kPOCDK+U7c6DZ7kiUnykWR//xhqzGg==
X-Google-Smtp-Source: AGHT+IF8n5OWsK7vEKHG31IGyA/BvjkCJWjAw9g//D20cc6ti157Ku/h8dB99Ebnmy1WxwPQqWW+wMvuFMQC9KdDwLU=
X-Received: by 2002:a05:6e02:2144:b0:42f:6790:476c with SMTP id
 e9e14a558f8ab-42f8740712dmr76380325ab.23.1760036456716; Thu, 09 Oct 2025
 12:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-12-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-12-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:00:45 -0400
X-Gm-Features: AS18NWDrIbcA381yGsis3H7xqQj-A45cZk3TMjtUeY3hLhgd1vJRmGtfkZqjbXw
Message-ID: <CAFubqFudmBtoPSGptvZiSuzabV4SrRaL45BYCDtpiU9i6wNzeA@mail.gmail.com>
Subject: Re: [PATCH 11/33] vhost: make vhost_memory_unmap() null-safe
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This helps to simplify failure paths of vhost_virtqueue_start()
> a lot.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1e14987cd5..1fdc1937b6 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -489,6 +489,10 @@ static void vhost_memory_unmap(struct vhost_dev *dev=
, void *buffer,
>                                 hwaddr len, int is_write,
>                                 hwaddr access_len)
>  {
> +    if (!buffer) {
> +        return;
> +    }
> +
>      if (!vhost_dev_has_iommu(dev)) {
>          cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>      }
> @@ -1313,33 +1317,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      vq->desc =3D vhost_memory_map(dev, a, l, false);
>      if (!vq->desc) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_desc;
> +        goto fail;
>      }
>      vq->avail_size =3D l =3D virtio_queue_get_avail_size(vdev, idx);
>      vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
>      vq->avail =3D vhost_memory_map(dev, a, l, false);
>      if (!vq->avail) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_avail;
> +        goto fail;
>      }
>      vq->used_size =3D l =3D virtio_queue_get_used_size(vdev, idx);
>      vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
>      vq->used =3D vhost_memory_map(dev, a, l, true);
>      if (!vq->used) {
>          r =3D -ENOMEM;
> -        goto fail_alloc_used;
> +        goto fail;
>      }
>
>      r =3D vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_ena=
bled);
>      if (r < 0) {
> -        goto fail_alloc;
> +        goto fail;
>      }
>
>      file.fd =3D event_notifier_get_fd(virtio_queue_get_host_notifier(vvq=
));
>      r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
>      if (r) {
>          VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
> -        goto fail_kick;
> +        goto fail;
>      }
>
>      /* Clear and discard previous events if any. */
> @@ -1359,24 +1363,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          file.fd =3D -1;
>          r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
>          if (r) {
> -            goto fail_vector;
> +            goto fail;
>          }
>      }
>
>      return 0;
>
> -fail_vector:
> -fail_kick:
> -fail_alloc:
> +fail:
>      vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
>                         0, 0);
> -fail_alloc_used:
>      vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
>                         0, 0);
> -fail_alloc_avail:
>      vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
>                         0, 0);
> -fail_alloc_desc:
>      return r;

This assumes that vq->{used, avail, desc} will be nulled out. I=E2=80=99m n=
ot
totally convinced that will be the case when a device is started and
stopped, or at least I don=E2=80=99t see the unmap path doing it.

>  }

>
> --
> 2.48.1
>
>

