Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311EFCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNFo-0003ps-MR; Thu, 04 Apr 2024 09:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNFm-0003oo-MP
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNFQ-0003nZ-Fw
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712237717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPwGQpO3CGWRuqj8ZK+pAJ0GpLa7bQLuOOgf5vUw+9E=;
 b=ePHIBpFBTeKxuBblyjN/+f3ROP0c99Lb1JEWNW3j2yPmeD4VYW2S/SnIMMZwyYhotdwlvP
 GJcVvNRJfeHysVHfYCtjFrbRdbl6jGsFtU2JEg4U5Ewag7FDKutkN79agla9FcsjYVvwCX
 mMAH9ks4AschzwVprKifPAqa0E5qQro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-jzpw2lAoNqejXGdMDiSPSw-1; Thu,
 04 Apr 2024 09:35:13 -0400
X-MC-Unique: jzpw2lAoNqejXGdMDiSPSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F6C238143B4;
 Thu,  4 Apr 2024 13:35:13 +0000 (UTC)
Received: from localhost (unknown [10.39.195.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 510C02024517;
 Thu,  4 Apr 2024 13:35:12 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:35:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: Re: [PATCH] block/virtio-blk: Fix memory leak from
 virtio_blk_zone_report
Message-ID: <20240404133506.GB2555172@fedora>
References: <20240404120040.1951466-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LHI7FLq0z6sfUBpE"
Content-Disposition: inline
In-Reply-To: <20240404120040.1951466-1-zheyuma97@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--LHI7FLq0z6sfUBpE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 02:00:40PM +0200, Zheyu Ma wrote:
> This modification ensures that in scenarios where the buffer size is
> insufficient for a zone report, the function will now properly set an
> error status and proceed to a cleanup label, instead of merely
> returning.
>=20
> The following ASAN log reveals it:
>=20
> =3D=3D1767400=3D=3DERROR: LeakSanitizer: detected memory leaks
> Direct leak of 312 byte(s) in 1 object(s) allocated from:
>     #0 0x64ac7b3280cd in malloc llvm/compiler-rt/lib/asan/asan_malloc_lin=
ux.cpp:129:3
>     #1 0x735b02fb9738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x5e738)
>     #2 0x64ac7d23be96 in virtqueue_split_pop hw/virtio/virtio.c:1612:12
>     #3 0x64ac7d23728a in virtqueue_pop hw/virtio/virtio.c:1783:16
>     #4 0x64ac7cfcaacd in virtio_blk_get_request hw/block/virtio-blk.c:228=
:27
>     #5 0x64ac7cfca7c7 in virtio_blk_handle_vq hw/block/virtio-blk.c:1123:=
23
>     #6 0x64ac7cfecb95 in virtio_blk_handle_output hw/block/virtio-blk.c:1=
157:5
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/block/virtio-blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 92de315f17..bb86e65f65 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -768,7 +768,8 @@ static void virtio_blk_handle_zone_report(VirtIOBlock=
Req *req,
>              sizeof(struct virtio_blk_zone_report) +
>              sizeof(struct virtio_blk_zone_descriptor)) {
>          virtio_error(vdev, "in buffer too small for zone report");
> -        return;
> +        err_status =3D VIRTIO_BLK_S_ZONE_INVALID_CMD;
> +        goto out;
>      }
> =20
>      /* start byte offset of the zone report */
> --=20
> 2.34.1
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--LHI7FLq0z6sfUBpE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYOrIoACgkQnKSrs4Gr
c8iacwf/dkK6mDTHCpRy4PWByjds0DS20/ku2c/vk09pCMMHS4VIMYDpxB4tYuuz
R+IAFvRyfY7vd0bQ6PHTRGQJ/+vPR8Ylt7D+pcjZTB1l2Ik+j2xRM3hTJ6ysDWI8
vA9WctMCyAWaLOL/hqTqukhWvJwQK8wMmwEhgEb9ftiR7AGb1S/UrzhponwLcJs0
xkRN/MZjtVSwqUZtrykU6NVyWGd0Cn2CkpgWNVZ6FFlIBfoK4p6zWW4JmEt4gWwd
84Z0DT2BJqa0c/PyAmqOBTQJSys3vIBU9SCJrbdcJJahFy7CUm703hbhJljsvK0M
2DiGKBe1RyIjUmPPGDv4TN2UV06BtQ==
=5BvL
-----END PGP SIGNATURE-----

--LHI7FLq0z6sfUBpE--


