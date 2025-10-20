Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22200CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAz7l-0003Lk-Lo; Mon, 20 Oct 2025 19:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz7k-0003LL-En
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:17:08 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAz7i-00079v-Cq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:17:08 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-42e2c336adcso21857665ab.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002225; x=1761607025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIZ7+dar2IMzE/9lzWBMeeov1+9KMuszhnka4CDxnG8=;
 b=g/dBUV+CDNeoTyR1t3w4DeT9+HC8R3IpWeLmpzsPfHwYAzzaZAa5lxvAXMvwH9SahP
 uB1Ixp7YTNscN8Rj8DJo2M+Cy8ysQUx1AlMd1nhQubCgMak1dnFAPWLz3MABy7P2BiMn
 RSIJtGt5wteN8X6epJUu8At+Wo2vIPyebh4fZD55FFrg9El6StFpl514LS7gVylqSJjf
 eihJ65mwHHKJuM3taNQZ6hvXnTLBStbZJgfKO1YI3SR9WYsD9qyzfUTqlnbwfilPOb79
 HGtFNg3+LSqWP8oPctLqPyQ0momxzSLj49D9ja7xvEjhjkZjzL3PBT4+6LVyM2qgjEuq
 hyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002225; x=1761607025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIZ7+dar2IMzE/9lzWBMeeov1+9KMuszhnka4CDxnG8=;
 b=UwOlx5fEHuVU352TwIJxdt3vMYpf25pQCA4+pjGj8sXN4RuBb1KQzlJ5GJAgc/+YI3
 aJDOGx9O09dqvwLX3z48fToaqq/TbkavtLNWWGMq9iVku62KvOlf/955r0/dL9Ce34f7
 9jySpbJ5Flm5IyUvsrhaYYG3iMQwuy82mu8jPfmSU77FpAmxUqfLroU9YTdwNMSdFt21
 omwLHN920h/CUnmaOFE8oWXNqAftbxV21d8uRehBc4I3t+5iQjmhSZnCMKyLxzb7XTP1
 HBspj4XqheHGC67uXUCy9tqi6JSl/9rywLs6TrgFZkCMgFOBrZlCzawma+t0kPMOVGJR
 taiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHKICZf9+YUxuKJ50mQMOcN2/EApSYBL/4hfr9FbMpdozfGOCkn699dyGCBTdDTj6yjQOmOxTtw9KD@nongnu.org
X-Gm-Message-State: AOJu0Yyav/Iu+RATgj//O5uRGSyM0gi8Ck88sItydcpnbyerBMobYzse
 at1fLuGKZo8IdhQ5u1cWootMQOsavZK3V+81j/i1VtBhkdfcE73EHA12NAWuO42D7mgli8GfjOO
 ESVXEkWLMd3ap7Zq4mEjwkymI+ktVcTVEOPhuT6M=
X-Gm-Gg: ASbGnctNsbEcoVjWyW0LAhPfAZoV1R8OefMqVEyc2FT3uA8AzizD8C1/VlBhjlkOH+s
 F3q0at69y5JZHuD/jP+WYctIRBy5/v8S8nbozCLcrC81IF3RK9+t4t/zwA93GWWfXloDqyGcq/k
 DHZydZc0hTbyDmFYTh3tswynW+QEkseEekFyS7PpXhXNaJHMzjqbhBy3hVZsCdJFk/wHXLH1IL8
 PjIpn63XQQAznIyBn8etz1Nbxy26RTalhnzTmdZ7OQ7sLthrfyxXZsvgx93k9K012o1Arw=
X-Google-Smtp-Source: AGHT+IGq2TtR7T4m46A3PHF8MXLk42MJOYD1l1vjKxRfNuMyZePo6zytbtYtTcEe68uMb53gI5I0wKw0pr/vniXYeoQ=
X-Received: by 2002:a05:6e02:154a:b0:426:e20b:f5d4 with SMTP id
 e9e14a558f8ab-430c52200admr237343575ab.10.1761002224931; Mon, 20 Oct 2025
 16:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-3-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-3-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:16:53 -0400
X-Gm-Features: AS18NWDxgcIlx5AAUQQXaHSooOM2VgYoTdwNFxWnMLelunubapV651-G_jOep14
Message-ID: <CAFubqFuFYvEjm=SatMXH0Z69Z-kDQGiCuUDQ5wTsA6BVKLcbBA@mail.gmail.com>
Subject: Re: [PATCH v2 02/25] vhost: reorder logic in vhost_dev_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
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


On Thu, Oct 16, 2025 at 7:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We are going to split vhost_dev_init() so that the first part will do
> early initialization of QEMU structures, but don't communicate with
> backend, and the second part will do backend communication. We need
> this for future support for backend-transfer migration support for
> vhost-user-blk (backend will not be available in the early
> initialization point).
>
> With this commit, we simply reorder the logic in vhost_dev_init()
> in accordance with idea of further split.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 60 +++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9fc6e7ba65..551d1687fc 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1637,26 +1637,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          goto fail;
>      }
>
> -    r =3D hdev->vhost_ops->vhost_set_owner(hdev);
> -    if (r < 0) {
> -        error_setg_errno(errp, -r, "vhost_set_owner failed");
> -        goto fail;
> -    }
> -
> -    r =3D vhost_dev_init_features(hdev);
> -    if (r < 0) {
> -        error_setg_errno(errp, -r, "vhost_init_features failed");
> -        goto fail;
> -    }
> -
> -    for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> -        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i);
> -        if (r < 0) {
> -            error_setg_errno(errp, -r, "Failed to initialize virtqueue %=
d", i);
> -            goto fail;
> -        }
> -    }
> -
>      hdev->memory_listener =3D (MemoryListener) {
>          .name =3D "vhost",
>          .begin =3D vhost_begin,
> @@ -1677,6 +1657,36 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          .region_del =3D vhost_iommu_region_del,
>      };
>
> +    hdev->mem =3D g_malloc0(offsetof(struct vhost_memory, regions));
> +    hdev->n_mem_sections =3D 0;
> +    hdev->mem_sections =3D NULL;
> +    hdev->log =3D NULL;
> +    hdev->log_size =3D 0;
> +    hdev->log_enabled =3D false;
> +    hdev->started =3D false;
> +    memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
> +    QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> +
> +    r =3D hdev->vhost_ops->vhost_set_owner(hdev);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "vhost_set_owner failed");
> +        goto fail;
> +    }
> +
> +    r =3D vhost_dev_init_features(hdev);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "vhost_init_features failed");
> +        goto fail;
> +    }
> +
> +    for (i =3D 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
> +        r =3D vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index +=
 i);
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "Failed to initialize virtqueue %=
d", i);
> +            goto fail;
> +        }
> +    }
> +
>      if (hdev->migration_blocker =3D=3D NULL) {
>          if (!vhost_dev_has_feature_ex(hdev, VHOST_F_LOG_ALL)) {
>              error_setg(&hdev->migration_blocker,
> @@ -1694,16 +1704,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          }
>      }
>
> -    hdev->mem =3D g_malloc0(offsetof(struct vhost_memory, regions));
> -    hdev->n_mem_sections =3D 0;
> -    hdev->mem_sections =3D NULL;
> -    hdev->log =3D NULL;
> -    hdev->log_size =3D 0;
> -    hdev->log_enabled =3D false;
> -    hdev->started =3D false;
> -    memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
> -    QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> -
>      if (!check_memslots(hdev, errp)) {
>          r =3D -EINVAL;
>          goto fail;
> --
> 2.48.1
>
>

