Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A33CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsPb-0003nE-2B; Wed, 03 Jun 2026 16:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUsPZ-0003mf-4f
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUsPX-0001HK-GO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780519317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fMojmsEs3FWvBuI5y49zumJBFe5MQLFHwXU0olbsL3Q=;
 b=Wz22OUl8pl7yAVtXfGbdav1W4sTqmrJ570PBgn84AmV5eDLvbG5RlKfsea2e+IICLNHv55
 ga3jLuNegFN5MCCvwL0aw/ePHYT8iNaORzq/uQQ9LmWM260rbqs0CrguP100tjDXpo1cuR
 eD4iF6FV1YrdUry+kAgj0t/TUQZNQDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-i8CgcpNzNIGsaHqoedUIsw-1; Wed,
 03 Jun 2026 16:41:54 -0400
X-MC-Unique: i8CgcpNzNIGsaHqoedUIsw-1
X-Mimecast-MFC-AGG-ID: i8CgcpNzNIGsaHqoedUIsw_1780519312
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72E991800365; Wed,  3 Jun 2026 20:41:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65E2C30001A1; Wed,  3 Jun 2026 20:41:51 +0000 (UTC)
Date: Wed, 3 Jun 2026 16:41:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v11 3/5] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <20260603204150.GD78072@fedora>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BU0uSookOQjYFqvt"
Content-Disposition: inline
In-Reply-To: <20260601214405.252818-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--BU0uSookOQjYFqvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 11:44:03PM +0200, Sam Li wrote:
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9cb9f1fb2b..285db19ac7 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -288,6 +288,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s=
, MultiReqBuffer *mrb)
>      int i =3D 0, start =3D 0, num_reqs =3D 0, niov =3D 0, nb_sectors =3D=
 0;
>      uint32_t max_transfer;
>      int64_t sector_num =3D 0;
> +    BlockDriverState *bs =3D blk_bs(s->blk);

Please add a blk_get_zone_size() API in block-backend.c along the lines
of the other accessor APIs (blk_get_request_alignment(), etc) instead of
using bs directly.

> +    bool zone_cross;
> +    int64_t zone_sector, end_sector;
> =20
>      if (mrb->num_reqs =3D=3D 1) {
>          submit_requests(s, mrb, 0, 1, -1);
> @@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock =
*s, MultiReqBuffer *mrb)
>      for (i =3D 0; i < mrb->num_reqs; i++) {
>          VirtIOBlockReq *req =3D mrb->reqs[i];
>          if (num_reqs > 0) {
> +            zone_cross =3D false;
> +
> +            /*
> +             * On zoned backends, a single backend write must not span a=
 zone

This code handles both reads and writes but the comment only mentions
writes. I think reads are allowed to span zones, so should there be a
check that mrb->is_write?

--BU0uSookOQjYFqvt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmogkY4ACgkQnKSrs4Gr
c8iV8Qf/Yp6Nxf8oMamuTKuBIZQx6Zl9rWSVGp9U3DoyCaPW+P1yZPLXSaVSPPao
JxwOfWUVtq4TGXtyFWolXzxz1N67dWv/2qmXgTKr9Wv3m5IJ9EDE2qlB7pr9O/n9
Ys3VSvipNNRCK3EY8aOonIGG4uFdQzC1riACg8TVs+AHWRMBG/v8T5cfXYw8hEoa
aJVH6TkHafogGhD3BFTZW6mQQ+V46XeNXTbfgd9vd/4eIyvBdlcfiyIhyIDSs3BC
UsUNgiuvaHAEEiQqJQYwTTC4/ok4ylWOoQwsxEXTT7anTezDbJMRPcseEzYtN/i5
S1jd98RWn8c79ufAL8nIGhxoubaLlg==
=fmSb
-----END PGP SIGNATURE-----

--BU0uSookOQjYFqvt--


