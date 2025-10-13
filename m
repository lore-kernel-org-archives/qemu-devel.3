Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC2CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 20:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8PVz-0004wH-P3; Mon, 13 Oct 2025 16:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PVy-0004vs-0R
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:51:30 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8PVw-0004fw-CC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 16:51:29 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42f9353c810so18509305ab.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760388687; x=1760993487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxxpIRKgzKowTWFr2jZavYTnQfMz3IP1ipbZzb8+tSg=;
 b=fTCqyA4985BNuDgaUjYfiSRwAXvgSLMYI+srSOxRGJ4Yeeuxbkh52Fw1AAradu5IUY
 1Tc/j+0KrxWzO6kWm7pRDv+Z09Ne8rPMJD+OVV4ss1a3CiAL/BmyvbY1wYKOemc/PWcr
 X5nKYEaz5678LRMOCwsQ530iINxXOs52Y+ppHXpkrqOQa13OZ34OQBFpYt+Kq3HcOXv8
 oI5m4eMKiIlMkBeoS0ypWMZnFky84xGXYzQWwlnjh5U+BgoJMbpinMNfvxqLn4e5QZ4M
 M7RIAyVzXU4pfirtL8rqkLEXjJSLW/wIUzJJlvhUc+9JTVR3AMCT3IC6O8NlCS6Y9/jb
 Ikyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760388687; x=1760993487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxxpIRKgzKowTWFr2jZavYTnQfMz3IP1ipbZzb8+tSg=;
 b=oHn4BuKdLj/IP9hGFE6E/elldPCH3pi3XaHZbLtQ1EEpKkBUTIl6ZUGvtVHObkZAjW
 2xMTCqtKTrKpDfUTMQd2yYcpJtUxt+Zm5vWYLBuIcg5/NTry9X08SJORnLKgapiX4wfq
 oB8Ia2mCgM2rOEx8B8jCUCVqu7Grsp+ydcrIKZYQ4Pyp3Xt4CR2wQ1rqGNCFMGJbTCEy
 CsdjtiaeHljV1my67RkY9WriAg9q9NKucPg16L9sIL/Kksf8Fv0igGLvDD1v2uZm1fdr
 nJId8BAk6muVNuBaOh18wjJRguGW6aYCJAElL5Alxc4T/sdW7G2x0x4O4xbV71yB77s6
 vJig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6IuZN84bCv6DP2D7zKAvtiMUXaevg64LSIo0dzBwqbmyjUP5Bfr4zrIDmrVsm9+6el6wA6HaPnYES@nongnu.org
X-Gm-Message-State: AOJu0YwaMHALfzQV7f86A3kmQTk7M8NAb82QJktUhzYvqHyWVfZpjC1Y
 MH2/PjNRIvJaYMfzoo4YHZqW3uZ8HPF0frI3WzZOo4aJo9/Qr3lleaAG8cBV2a2DLbnyAxfJ+bU
 EMt6DZq8VEFiM6R3JYwhRMhL1xaylwFE=
X-Gm-Gg: ASbGncvXXPjgZVQbv4glV0G7YiPRnaVzH9LD8F2yRtqjZ0i7VEXNLD9rBgUSnY4ljHT
 ceY+BYnPFIeNb85wPC3D8+owIp1ZT+owOdxKw5pPxq6wWqU04g4Gtg5NqQvQqsh7ar2yhCeFsHB
 L4CrL8m78ovXH1a9LeHomFjhRyTnzRuzgpEmertZ0GMX+BBSJplMQe8cBLwnkC0+TZ08eVaxlac
 okQTNwyPWxtfT/PRWlfQTGrTCmxjkrhJoAZ
X-Google-Smtp-Source: AGHT+IE2lXxxigmhsWYNnsrZWTyGtKHBl+r1iR6HEJFjHn5XR9ie6dDACRiNJjhSLOXuZZYnN/vtlz5ce5R75pjfQ90=
X-Received: by 2002:a05:6e02:2308:b0:42d:89e7:7f94 with SMTP id
 e9e14a558f8ab-42f8740a177mr205992575ab.28.1760388686786; Mon, 13 Oct 2025
 13:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-20-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-20-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 16:51:15 -0400
X-Gm-Features: AS18NWD53lCVFgCzNo8X5G2akbPehheooo4LZPA0wnGwX8X0eA5RnBVKkd-uFbk
Message-ID: <CAFubqFuC1xdfpJprp3Tno_TLet-aMRyN1arMtDDze6FrfLNKZQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/23] vhost: vhost_dev_init(): simplify features
 initialization
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12f.google.com
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
> Drop extra variable and extra function parameter passing, initialize
> dev._features directly.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c990029756..d02d1d4c34 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1557,18 +1557,17 @@ static void vhost_virtqueue_cleanup(struct vhost_=
virtqueue *vq)
>      }
>  }
>
> -static int vhost_dev_get_features(struct vhost_dev *hdev,
> -                                  uint64_t *features)
> +static int vhost_dev_init_features(struct vhost_dev *hdev)
>  {
>      uint64_t features64;
>      int r;
>
>      if (hdev->vhost_ops->vhost_get_features_ex) {
> -        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
> +        return hdev->vhost_ops->vhost_get_features_ex(hdev, hdev->_featu=
res_ex);
>      }
>
>      r =3D hdev->vhost_ops->vhost_get_features(hdev, &features64);
> -    virtio_features_from_u64(features, features64);
> +    virtio_features_from_u64(hdev->_features_ex, features64);
>      return r;
>  }
>
> @@ -1615,7 +1614,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>                     VhostBackendType backend_type, uint32_t busyloop_time=
out,
>                     Error **errp)
>  {
> -    uint64_t features[VIRTIO_FEATURES_NU64S];
>      int i, r, n_initialized_vqs =3D 0;
>
>      hdev->vdev =3D NULL;
> @@ -1635,9 +1633,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          goto fail;
>      }
>
> -    r =3D vhost_dev_get_features(hdev, features);
> +    r =3D vhost_dev_init_features(hdev);
>      if (r < 0) {
> -        error_setg_errno(errp, -r, "vhost_get_features failed");
> +        error_setg_errno(errp, -r, "vhost_init_features failed");
>          goto fail;
>      }
>
> @@ -1650,8 +1648,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          }
>      }
>
> -    virtio_features_copy(hdev->_features_ex, features);
> -
>      hdev->memory_listener =3D (MemoryListener) {
>          .name =3D "vhost",
>          .begin =3D vhost_begin,
> --
> 2.48.1
>

