Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F6CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8P7n-0000Pt-G2; Mon, 13 Oct 2025 16:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8P7l-0000Pl-TQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:26:29 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8P7k-0001mS-Cn
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:26:29 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so454279439f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760387187; x=1760991987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFqLIIaGv1zmrg2aFa0EnZFt8X6OLTaKCJe++aPiClQ=;
 b=kNhtQ7dU7BbIOHv6+qgezm/tCUjyxTcE/S3j8wXMqG5UyacY055O+KzBVLrQj5k24s
 ZOPzHGUnseiReTV/vH/e1N1SlcFUD9A6IKlC7A7kcsoZ0gLglm9TGWcXIWD3MaNzs0cZ
 YzG2UMD3YU19YoQ2O9F2sxswYDCEVqDTF6GgOL/JwjfrpFyQMuR1s5pV7R/55FxtvyOD
 4EigTINGgohj7iBpL4KfNglyf/MxfE/zV3r7kgTXkEtpCpYBhx64ZJVcG0Aj4BiLnJ8P
 OF8++GoOe5P4MwKS8QChlDOHqhMqGQ9oWOCR0b5HqHDKFokcZGiAI33Z6EWoyE19x9LK
 koHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760387187; x=1760991987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFqLIIaGv1zmrg2aFa0EnZFt8X6OLTaKCJe++aPiClQ=;
 b=qNrVji1aiLhItbCQnR0pieLy7BhXbw2LWDc1r+uRD8pDQrqIrjRPqJ0zeUwwDK2Hc/
 2WlF+p1HXZ/wnKGezuWn9dPqhPzJpkX7m2611id0gkukeLGwRzCGNmFrSp5SYb0hN+/g
 fxyxJ9z135hT9vtuhGDL6YgtVR+xBiLXZOZac6TSSlKe6c9PGODnJuzN9uZ0nDedtKFj
 vtQruZ8QJDr/8F412rXT4It3AFheAm4SkYXY5CiIiPgm1ayNe4wgLvGfojDMlfQOv6NR
 yRmaD74M6Pj/hpQtnHlTkfD7RdNHGZNJwF54Tpq2MyML+MX40k3w6fFdpYQxnAp/nkEH
 H2dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9WTlTG79iUS0VGDqfzJi65IcmVMfT8TnKK03eLloNUX/o6iQ+akBDXm8tG2nwQsSt4apO0U3N4QI@nongnu.org
X-Gm-Message-State: AOJu0YzcyT43CU3jyg6A3VymQaBbX2E/AQnVjrWz3NM5unliqzG0o6nb
 at26QgVHg/2u1/Xa+H62wwQlbGUqkq+efJB3o3ZI++Djsu2dKwF2psNnewf/PI9RqM3SVuMpwHq
 pD/7U7V8xYmp5SGbLEPwadSANqCpx/vXd8SfBHyc=
X-Gm-Gg: ASbGncvRTqJP3pTR1E++RjsWiGvrmr5dD1/Bx1SVK44HFeh+gHiLrSlRoOYCjXMaUE0
 pWK8kEwq76qTFX/CkS+SjDEycDwg6g7dO4gMrDFgd+QWAHBxjFWQUCmJournfhsHv0DlH5Qejpn
 xMqn+VEv2T7TpiiJ+YTcBAUfKKB+X5oKiKSW7JEObEnZD0smVfvTtMIfgxbt/CP6gq3LGnolO8e
 sb012paG0AezU2w57obU3fQ+0J4fxQhlc0U/z0NUbZUo2M=
X-Google-Smtp-Source: AGHT+IHQq+wMpQ6n6eOlq31UBuEmqkMrsQy5AE6P2y/RLXAyxlbVOfqNnfMmvb6ULjQov4GK4IR7Is3OVEvQhFfT/z4=
X-Received: by 2002:a05:6e02:248f:b0:42f:8ae3:20c with SMTP id
 e9e14a558f8ab-42f8ae30b89mr240565295ab.19.1760387187181; Mon, 13 Oct 2025
 13:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-13-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-13-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:26:16 -0400
X-Gm-Features: AS18NWAEZgTKn-25JxAkXCnKpUG78rVqCwISGFMk9ySWUNCe0yAkpeNZ_Ojrs_g
Message-ID: <CAFubqFv-u9S5hKhO2HixQPWJE8dQ5Z2jxyrxiMjLuamUygxR_A@mail.gmail.com>
Subject: Re: [PATCH v2 12/23] vhost: simplify calls to vhost_memory_unmap()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> No reason to calculate memory size again, as we have corresponding
> variable for each vring.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6fec193d5f..e00ba9ecc8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1374,12 +1374,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      return 0;
>
>  fail:
> -    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, =
idx),
> -                       0, 0);
> -    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev=
, idx),
> -                       0, 0);
> -    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, =
idx),
> -                       0, 0);
> +    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
> +    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
> +    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
>      return r;
>  }
>
> @@ -1426,12 +1423,9 @@ static int do_vhost_virtqueue_stop(struct vhost_de=
v *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, =
idx),
> -                       1, virtio_queue_get_used_size(vdev, idx));
> -    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev=
, idx),
> -                       0, virtio_queue_get_avail_size(vdev, idx));
> -    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, =
idx),
> -                       0, virtio_queue_get_desc_size(vdev, idx));
> +    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
> +    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_siz=
e);
> +    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
>      return r;
>  }
>
> --
> 2.48.1
>

