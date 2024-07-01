Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9525EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODjr-00036q-H5; Mon, 01 Jul 2024 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sODjo-00036J-PR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sODjm-00037w-4d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719827655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgXLuTHkoXi8Vklay8hpTBjPI4prwoMUdbPjguNidUI=;
 b=N9qCu4CHlD1UOV3y7vc6DAkmZ6ke6UYqtRR73ec+z1VjLqzx5k+lBzzcMEZ/DRc8D2X3AE
 YcWVURuGl3xd1eEMtzqn0SyWjrUhgW3DVdAITBJzIPdE2P2utFth9dHaqxgmWJPf6476jY
 /U1rKNprTG53ZQRYWfW67dGRoE3SgbU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-dzOwPVVJOyKVaYEwg5-B2w-1; Mon, 01 Jul 2024 05:54:11 -0400
X-MC-Unique: dzOwPVVJOyKVaYEwg5-B2w-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-64b2a73ad0bso43227467b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 02:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719827651; x=1720432451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgXLuTHkoXi8Vklay8hpTBjPI4prwoMUdbPjguNidUI=;
 b=ldcI5dFvpxLNFAoV566sajQ2zON2D5CWj1NWFPhIQz2HQra1jCO/S0Uzh9+3tAxyRa
 T7tpU+Kihf1LPbV9BihJ56hlxPUUU53v4kBYaK8S2R8xy/5t0G8JvdCO6+WP3cB9DUuy
 7CMaYc1wFDDhZx6lKARlZGUvCusuy1K3/XcrYBwKvhTagEGfaxyMa4Fis4O93aLjC/O2
 tIISo9XkngGFa1kx6RTUZ3+PsvgAa7MGj36cNMtF8FcYJK+4wBAKhq8HNegpjXxENmKF
 ASiXf7CFQ2ugjBt+HsMXreTZ/IBflhMl+CNG0yE6oSCv54r3oQKni6LiFmsJrRo8P2vu
 YD1A==
X-Gm-Message-State: AOJu0YyBirFdzC2oT+eA2lQiziSsL8aQ6GMdcs4nPz49iuhczZnF56E2
 h8fLx1vzw5uFDtqA0aTmpLAmQgTsDOsr9YHWbis5KwgqANOTBiNgpfmb1/u4xSxpGvvlwURIEAR
 WYxwiHPZ68zQ1qQfA5K5BcEHKgf3ghmDmM+8c1ppfU2xAV74l3IjMo7EZipSh69NuiyQBia7Ug8
 Q9uX/mmhfxXKC4YtMSbI70gYpFAME=
X-Received: by 2002:a81:431a:0:b0:63c:4140:a0de with SMTP id
 00721157ae682-64c7239dca2mr49199387b3.6.1719827651313; 
 Mon, 01 Jul 2024 02:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXxHw8m18FZLIVo676njEwaZeJuyBqZ4eTXutnZvtR8RSh/QgKoPZR7wDJ3QX5H+C3N/LcSqCfU5vGbRbirKI=
X-Received: by 2002:a81:431a:0:b0:63c:4140:a0de with SMTP id
 00721157ae682-64c7239dca2mr49199307b3.6.1719827650914; Mon, 01 Jul 2024
 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240701075208.19634-1-sgarzare@redhat.com>
In-Reply-To: <20240701075208.19634-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 1 Jul 2024 11:53:34 +0200
Message-ID: <CAJaqyWffdg6jz-+_1_tZApLTWs362KQYAMkPHttP51s7v07tEw@mail.gmail.com>
Subject: Re: [PATCH] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, 
 Xoykie <xoykie@gmail.com>, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 1, 2024 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> switched using of address_space_read_cached() to virito_lduw_phys_cached(=
)
> to access packed descriptor event.
>
> When we used address_space_read_cached(), we needed to call
> virtio_tswap16s() to handle the endianess of the field, but
> virito_lduw_phys_cached() already handles it internally, so we no longer
> need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
> but forgot for `flags`).
>
> Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> Cc: jasowang@redhat.com
> Cc: qemu-stable@nongnu.org
> Reported-by: Xoykie <xoykie@gmail.com>
> Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--=
Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I think it would be great to test the patches using a big endian host
just in case.

Thanks!

> ---
>  hw/virtio/virtio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..2e5e67bdb9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vde=
v,
>      /* Make sure flags is seen before off_wrap */
>      smp_rmb();
>      e->off_wrap =3D virtio_lduw_phys_cached(vdev, cache, off_off);
> -    virtio_tswap16s(vdev, &e->flags);
>  }
>
>  static void vring_packed_off_wrap_write(VirtIODevice *vdev,
> --
> 2.45.2
>


