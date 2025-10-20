Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE79CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzJN-0002jr-3n; Mon, 20 Oct 2025 19:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzJL-0002j9-4F
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:29:07 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzJI-0008UW-NH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:29:06 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-430b45ba0e4so22101005ab.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002943; x=1761607743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMJLYHmuhI96ADY1eXaq0ihkHnaThjCFBRzNrs2joP4=;
 b=kY47y3lNH5hYAzG3+EOzep4Iff6SOad5H20aFZXwDfPVO/9Mw/yzOkkYIA276MfLXf
 4ExpI+/4FNLAHEte4rABXZVxra8MTfsNQSVEkp1fb9q75GNup9ZbV9vBnmGxM8AWHz/D
 Oqbqpl/wkG334epW6I2yADYZ0Q9JpPzt14pMQv0qE8Oo8GYGFc/YhBv+10iYpQZr1uld
 SOy1JUWtTcZWQ3QRT4leSjBdrUTV/nkvSHsvKKNSm71M5kxkQAbNQxm8tJPnH8ONl3Cj
 r7OT60/020o5lQstqB+vFJY4VZZcvbBwiofN1QeKFKoGd/XYw3TfQuzf+RdXtD/X1eNe
 1Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002943; x=1761607743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMJLYHmuhI96ADY1eXaq0ihkHnaThjCFBRzNrs2joP4=;
 b=mgA+ifqSBJ1l4BzbCjtD6vgamVDNbdQfrSN8zEuJOwtrUDidw3UAbSirAr25otjPD2
 FuBjAgg1V2Qc+SrV/BgQ/e/MjoSNa1SaGq89oUsQ4bE674dOqGanN0zzDJqY9UChlsIg
 jasOEM2tBSIY73m6zLxbi85P24G+USrQgG6PkLn83JtvNKR5NfGYRQBW3wt69cCdvhWf
 bPLEOZCV1saSAK7RlaKjBZehpFKWx0PDIPRUic65iLA+ZC/twvVeo3eOars7hcqCta2h
 DAl2E/HE/nR9sysa5oG8netJIApthVmgM2hu/EbXL7wKYQ/SO6+Foj7jeKGRZEVga820
 E0YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEUJjW5agvAAu0aKbxdFx/F4JsoPSmZBPo5QexN9+cyXvCEKPUGgwE7YZF//EJIvuH0hNOKvKcTClm@nongnu.org
X-Gm-Message-State: AOJu0Yw74qxJQdIkE9NexX0PJ8zuMxESVCs3aDVa9LNJnZ3esVO/8I+X
 y1KlwQvtn+50R8VqT7egUY5JP6B9WhId+a140gx0TwLXY5LJ2/74aCQ0LU7kOlz/qBVt3tZ9/sS
 GmgVIN4ylYYAP6kApa+4aO3BV8gvCsRk=
X-Gm-Gg: ASbGncu7VDeFzia4NVSpOc+Fc75OSDQXiDJ4y5YxKlbMAoapHKwIKofOx15mTHJyyDV
 m+LGBQE+Sc2SvJTK0j0hapb1mqa48ScC4xylVLGoeMrWAP+E4JBXFrI7QbNZ1A6QpN7QcRM1uRd
 isjxfyxa06Gs+oLZ2rvo7w48S/nvclCkYmgD6A2BOOMzKATpbsNBILwH8fkse3elpbn/RqmLaox
 wojaudIcUKIaL06HME0i1LXwwZM9A4TJVqiKJdMp+OXzW0LChAzUgsG+EXn
X-Google-Smtp-Source: AGHT+IFX/jENe+3waGYsg6nVutWEnh7d+kTxo8Zgf8WiHXwWeV5phCmTg5BgCc2H6GFqSS7QgNGujQu0uJBQh2YTjew=
X-Received: by 2002:a05:6e02:b43:b0:42e:72ee:4164 with SMTP id
 e9e14a558f8ab-430c528d9b2mr215081835ab.23.1761002943421; Mon, 20 Oct 2025
 16:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-12-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-12-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:28:52 -0400
X-Gm-Features: AS18NWAsIiBaJlz7aklXXKGOEvoJgQCS5gbgcTMeZcReNtu-gv6tAXvHjjDQX28
Message-ID: <CAFubqFvb0Q-59QPqjoxrL6zm5BEnh1EBwca3sAp8msycjFNJ4g@mail.gmail.com>
Subject: Re: [PATCH v2 11/25] vhost-user-blk: move initial reconnect loop to
 separate function
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 16, 2025 at 7:46=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Simplify _realize function, and prepare to further changes.
>
> While being here, also rename virtio_err: label to more generic
> fail:, virtio_err doesn't improve readability here.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 54 +++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9c727c3977..36e32229ad 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -489,14 +489,40 @@ static int vhost_user_blk_realize_connect(VHostUser=
Blk *s, Error **errp)
>      return 0;
>  }
>
> -static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp=
)
> +static int vhost_user_blk_realize_connect_loop(VHostUserBlk *s, Error **=
errp)
>  {
>      ERRP_GUARD();
> +    DeviceState *dev =3D DEVICE(s);
> +    int ret, retries =3D VU_REALIZE_CONN_RETRIES;
> +
> +    assert(!*errp);
> +    do {
> +        if (*errp) {
> +            error_prepend(errp, "Reconnecting after error: ");
> +            error_report_err(*errp);
> +            *errp =3D NULL;
> +        }
> +        ret =3D vhost_user_blk_realize_connect(s, errp);
> +    } while (ret < 0 && retries--);
> +
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* we're fully initialized, now we can operate, so add the handler *=
/
> +    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
> +                             vhost_user_blk_event, NULL, (void *)dev,
> +                             NULL, true);
> +
> +    return 0;
> +}
> +
> +static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp=
)
> +{
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>      size_t config_size;
> -    int retries;
> -    int i, ret;
> +    int i;
>
>      trace_vhost_user_blk_device_realize_in(vdev);
>
> @@ -540,31 +566,15 @@ static void vhost_user_blk_device_realize(DeviceSta=
te *dev, Error **errp)
>      s->inflight =3D g_new0(struct vhost_inflight, 1);
>      s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
>
> -    retries =3D VU_REALIZE_CONN_RETRIES;
> -    assert(!*errp);
> -    do {
> -        if (*errp) {
> -            error_prepend(errp, "Reconnecting after error: ");
> -            error_report_err(*errp);
> -            *errp =3D NULL;
> -        }
> -        ret =3D vhost_user_blk_realize_connect(s, errp);
> -    } while (ret < 0 && retries--);
> -
> -    if (ret < 0) {
> -        goto virtio_err;
> +    if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
> +        goto fail;
>      }
>
> -    /* we're fully initialized, now we can operate, so add the handler *=
/
> -    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
> -                             vhost_user_blk_event, NULL, (void *)dev,
> -                             NULL, true);
> -
>      trace_vhost_user_blk_device_realize_out(vdev);
>
>      return;
>
> -virtio_err:
> +fail:
>      g_free(s->vhost_vqs);
>      s->vhost_vqs =3D NULL;
>      g_free(s->inflight);
> --
> 2.48.1
>
>

