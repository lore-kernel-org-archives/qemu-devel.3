Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8467AC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCLd-00054N-5Q; Mon, 01 Jul 2024 04:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOCIw-0004jO-Tf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sOCIv-0000za-88
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719822148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/JSP8j/zvkme/NWxYyLbMp1RYWPCaM/K8E7GZhHnwo=;
 b=HVG18PG2jaAneV+Z/HhLti51CPzucirhlYm82OXBAOD4dcY8h9gNJHVO01KKOZc5o7ucNa
 C06bJ457W6gyh9ECCDfSSqwYzXiFafoYdt/2Iu0VuXAs6uGQw2x1TMKZ+CXlM49QPmgB3E
 h/m78dxEd20waSLsnyL2q/hHRPTWvBM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-pPFMrYvDOZqV9GLBmVZ9qQ-1; Mon, 01 Jul 2024 04:22:26 -0400
X-MC-Unique: pPFMrYvDOZqV9GLBmVZ9qQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7065ba27265so2700949b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719822145; x=1720426945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/JSP8j/zvkme/NWxYyLbMp1RYWPCaM/K8E7GZhHnwo=;
 b=xA503803pFvlYzTiGmdywy6tsuaTbUH2ivHFGyk6w+vNfKuPnbMWgAk+t/z/gGcY32
 dtFtC3TtR3zhdeGS+OSQafzbZKL53aKSMG2ML2Pa3uCzjeHpqabm5e+x1rj+tcpKCu82
 KyyHuJO2s9sbIY+FjP0sepZNmFUFs0FmgHhuLyuqIbEHqaS8ZSgWm8tDjtebqxGyYR3y
 1owoblaCfRBolNAt77+6n89LvS2aeeAEhChVUVR8M0jr+v9W8FNlJcO9qW6F/GHSOWwF
 bZm2LYbezH3MO6C12UYfWZZVHgX0Fzy/DUkZshgyeY4XMEWGlbT9gQDer18gBhzG6dUO
 bcRw==
X-Gm-Message-State: AOJu0YyWiBZR7pCSPprw1FCGkSBtYDlt113dtjhMB3mYb0N3W+shKr+b
 F3ughMxMWe6CDnvV5bXuFTAwk9HAMWbAbHgnOCw+1uCZAcMGxSeswfpFL5jb0HosdR+8AsNa8He
 ajkjXsnGXSA8f9j8v2wg5/6tro/er+nX/83O/UWfpaPu3qLDfwYxmxR88oUaPSpDmNred5Aru6s
 MSHvXfR/MVlOPjM0ATujrjd3BIE4o=
X-Received: by 2002:a05:6a00:1812:b0:706:9030:8960 with SMTP id
 d2e1a72fcca58-70aaad2a08cmr7874869b3a.4.1719822144985; 
 Mon, 01 Jul 2024 01:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq06POL0waE0r/n8hsCoLLoMn+31A0A+3PhYKspw9SQAkd/5d7rr0uYiwnh5QqO3iQOY0Yq5uPq1uKb6jlgLc=
X-Received: by 2002:a05:6a00:1812:b0:706:9030:8960 with SMTP id
 d2e1a72fcca58-70aaad2a08cmr7874850b3a.4.1719822144656; Mon, 01 Jul 2024
 01:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240701075208.19634-1-sgarzare@redhat.com>
In-Reply-To: <20240701075208.19634-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Jul 2024 16:22:13 +0800
Message-ID: <CACGkMEu4u5js7L5Yp+-6o8D6hv=JDP4wFyn+t2WPPZSQVhH4EQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, Xoykie <xoykie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 1, 2024 at 3:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

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


