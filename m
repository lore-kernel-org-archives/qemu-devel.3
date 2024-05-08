Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55546C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gqy-0000gQ-Vs; Wed, 08 May 2024 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4gqr-0000fs-Hp
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4gqp-0004E0-R8
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715173009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NP7m8jbHeEA6zUp44J64q0lSjcdxEslJQ5pmld6tyCE=;
 b=iYfqmUaExWHD4jYov1SwTt93xb1hmT047jqvjRneo9eseT8phrpjWdijv0NMAi/HfuDvKz
 Yq535Mf15eMB/xUKL94karhA61tbCL8aWXpi+qjiCOxzXQObr/ypY5TnXHesQjGsn4xk/z
 0LSNamHz7ikxLlvOtURA/IhavaNDHZY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-4vN6UKbCNWWeYCEV3slkmA-1; Wed, 08 May 2024 08:56:48 -0400
X-MC-Unique: 4vN6UKbCNWWeYCEV3slkmA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61be5d44307so75018537b3.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 05:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173008; x=1715777808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NP7m8jbHeEA6zUp44J64q0lSjcdxEslJQ5pmld6tyCE=;
 b=ce4n88a3ACs+nzVDhXB/45URb1aSDDOZrc/BxKTQvQC12E5h+YEPRjxqlg6eiM5imQ
 71pw59zlZwgnjzltd6jCqZkPEyFTJIK0IM1nC0a8UzTxI3ExZoJBWuoLQO64+VdqVZa4
 V2Gpw6pVimNkN9F42snL+O1RYxYtKyoeENOY1EY4uYEKFyElcosziTSzjeS3GsW5ENK/
 EznUm1RuKHyXvMEXbWCWCP65EmK4JHFJYjKu+Xf2ZlsD0HXvyD/d7VBxDwSptdNClLWs
 qDAXCpriTqrOPVudgU15lew+T7V/TXhc/8JlBaH7pxdkjhHNVXEiKNZ8DKDpQRdgn50I
 YKIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULo03XebSXVRnzmFxBkbbrqzlxmc2YegrUPyq/GBinSQsXGdTDKdhbbib4HfjyyAvq1RGTlAUvdAMmjIIabQSqrrOvVdc=
X-Gm-Message-State: AOJu0YztdZzcYTFMhqoNxRVbl0SShAL6LR13EciHEzQEQdU3dshMWO1+
 DBLnD3U1JlvXAilRBFiPgWTR/dRYQWiqMnF1v8/nf9Zl2R+4WCdx86b9I/Y54oOhiLGSp7Ls6og
 bNAWWcjz8iwXi+/0l5BBVBy2Rtsn2ByJINqRML3uYewy2pY5TzStX5hnjRz3aP/d4j3y/CHAHXZ
 PmIQlBtNn+Nv6o7epSopSi9uxjJu0=
X-Received: by 2002:a05:6902:24b:b0:de6:d19:837a with SMTP id
 3f1490d57ef6-debb9dbb3d7mr2540996276.34.1715173007923; 
 Wed, 08 May 2024 05:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Xcmts07nbBz43bFf2Uf9kdrfBXX/I3RY+Q8qr6xKSMzfsyrq9znTS4VpUG3T5LjuagXyExOzJdBQ2BkP9WI=
X-Received: by 2002:a05:6902:24b:b0:de6:d19:837a with SMTP id
 3f1490d57ef6-debb9dbb3d7mr2540978276.34.1715173007654; Wed, 08 May 2024
 05:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
In-Reply-To: <20240422014041.5706-2-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 8 May 2024 14:56:11 +0200
Message-ID: <CAJaqyWcgMFJL8y7wXwFZa6dny34WKDRH+tuEaCdP8oFN4Qf5fQ@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
To: Wafer <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

On Mon, Apr 22, 2024 at 3:41=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote=
:
>
> The virtio-1.3 specification
> <https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
> 2.8.6 Next Flag: Descriptor Chaining
>       Buffer ID is included in the last descriptor in the list.
>
> If the feature (_F_INDIRECT_DESC) has been negotiated, install only
> one descriptor in the virtqueue.
> Therefor the buffer id should be obtained from the first descriptor.
>
> In descriptor chaining scenarios, the buffer id should be obtained
> from the last descriptor.
>

This is actually trickier. While it is true the standard mandates it,
both linux virtio_ring driver and QEMU trusts the ID will be the first
descriptor of the chain. Does merging this change in QEMU without
merging the corresponding one in the linux kernel break things? Or am
I missing something?

If it breaks I guess this requires more thinking. I didn't check DPDK,
neither as driver nor as vhost-user device.

Thanks!

> Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
>
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
> ---
>  hw/virtio/virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 871674f9be..f65d4b4161 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, s=
ize_t sz)
>              goto err_undo_map;
>          }
>
> +        if (desc_cache !=3D &indirect_desc_cache) {
> +            /* Buffer ID is included in the last descriptor in the list.=
 */
> +            id =3D desc.id;
> +        }
> +
>          rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cache, ma=
x, &i,
>                                               desc_cache =3D=3D
>                                               &indirect_desc_cache);
> --
> 2.27.0
>


