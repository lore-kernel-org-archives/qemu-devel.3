Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13869C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUbW3-0001Cw-OW; Mon, 29 Jan 2024 18:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUbW1-0001An-3T
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUbVz-0000Ce-F5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706572689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/mvyvKDB6afge3QFzNGCXFOp4FTqUCnMIq6BYdpyog=;
 b=P7kLvipQikNK2+VzH0Smf29w+WMcBtBD+xD7tiLfYA22D3FvMUXdlfznXNyNVE3RLFpMrM
 oR1A5LZvWw0vXrc5twexvhpLSrZ/6rMVRvM24yCtA2VjPqRDt9Q+Kyzn2fkdjdug6Gozhw
 KEYLvUcOLSyl9dYpdIZe/gvbrGinbkM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-p2vuAvDmNb2wKc9WGzhmfQ-1; Mon,
 29 Jan 2024 18:58:04 -0500
X-MC-Unique: p2vuAvDmNb2wKc9WGzhmfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5301A3806622;
 Mon, 29 Jan 2024 23:58:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA0CC112131D;
 Mon, 29 Jan 2024 23:58:03 +0000 (UTC)
Date: Mon, 29 Jan 2024 18:58:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 2/2] hw/block/block.c: improve confusing
 blk_check_size_and_read_all() error
Message-ID: <20240129235802.GA217529@fedora>
References: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
 <8e7eb17fbd39d746079e2bb2525b0ed8c97cca33.1706023972.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PXs5zswtbPef7q8+"
Content-Disposition: inline
In-Reply-To: <8e7eb17fbd39d746079e2bb2525b0ed8c97cca33.1706023972.git.manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--PXs5zswtbPef7q8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:35:31PM +0200, Manos Pitsidianakis wrote:
>      if (blk_len !=3D size) {
> -        error_setg(errp, "device requires %" HWADDR_PRIu " bytes, "
> -                   "block backend provides %" PRIu64 " bytes",
> -                   size, blk_len);
> +        dev_id =3D qdev_get_human_name(dev);
> +        error_setg(errp, "%s device with id=3D'%s' requires %" HWADDR_PR=
Iu

Since qdev_get_human_name() falls back to returning the path instead of
the id, this error message could be confusing. Perhaps avoid saying what
dev_id is and let the user interpret it:

  %s device '%s'

> +                   " bytes, %s block backend provides %" PRIu64 " bytes",
> +                   object_get_typename(OBJECT(dev)), dev_id, size,
> +                   blk_name(blk), blk_len);
>          return false;
>      }
> =20
> @@ -89,7 +90,11 @@ bool blk_check_size_and_read_all(BlockBackend *blk, vo=
id *buf, hwaddr size,
>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>      ret =3D blk_pread_nonzeroes(blk, size, buf);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "can't read block backend");
> +        dev_id =3D qdev_get_human_name(dev);
> +        error_setg_errno(errp, -ret, "can't read %s block backend"
> +                         "for %s device with id=3D'%s'",

Same here.

--PXs5zswtbPef7q8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW4O4kACgkQnKSrs4Gr
c8iA6wf6AxK7S3Y6xnfoKWPLFMI1qoWHePKPddKs7ucublWu0hQr2gnkQwWwLxc0
esZlgUIA5KLBdrNoqkO5lljM4cGFHXhc4bBslarwhork5U7W3GuvLAPNDqMquVwX
jI1B3jXA55pVDFx/K+1LL69J7NzPqpBLDBNRMJfTWBM4vu0S1uSdqYYJ0hMtXw3p
f5ufI40IEPs9RLKkzWFcaXQognDU5KsqSGoVTOkeAhmoCa5v7+RPaE3987G2S7rW
mmyUtXLCB58sXmM29VzFnIpOmN1mxvWv/1NuB3nKxbAfd0EH0h66IHt5zdg1/SBZ
CtRdI0OGFhS7VkUgX8aZ9bJXnEqcAw==
=1uKy
-----END PGP SIGNATURE-----

--PXs5zswtbPef7q8+--


