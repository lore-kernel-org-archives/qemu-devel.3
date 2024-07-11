Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CDC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRppz-0004wP-Dn; Thu, 11 Jul 2024 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRppx-0004uh-Em
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRppv-0004fw-I5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720689092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aW5WU2OTO6MsiA3/JlMuWju9ToR5h5PaTwBb0qufWtI=;
 b=H571/d/GKeW/SzTauI4uORI6u6Wrf1vC5cbAMX2UCrrtN4i4AtairrguQLeocBU7JpOPy6
 /kUsJHKzhB9TTa7izlXbMO2jdQbzurVA9jYoRA5+w9V0q6UmH7snXI6G9QWCxM8wt042hU
 S9ziReVVnkoUGSdLoogac06lJqnVx6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-kNDFFuG6OWWL1qF7ZRWxww-1; Thu,
 11 Jul 2024 05:11:23 -0400
X-MC-Unique: kNDFFuG6OWWL1qF7ZRWxww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7B6419560AE; Thu, 11 Jul 2024 09:11:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EED4E19560AA; Thu, 11 Jul 2024 09:11:21 +0000 (UTC)
Date: Thu, 11 Jul 2024 11:11:20 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] Consider discard option when writing zeros
Message-ID: <20240711091120.GK563880@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628202058.1964986-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y87Rr8AT5zw0BtTx"
Content-Disposition: inline
In-Reply-To: <20240628202058.1964986-1-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--y87Rr8AT5zw0BtTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:20:56PM +0300, Nir Soffer wrote:
> Punch holes only when the image is opened with discard=3Don or discard=3D=
unmap.
>=20
> Tested by:
> - new write-zeroes-unmap iotest on xfs, ext4, and tmpfs
> - tests/qemu-iotests/check -raw
> - tests/qemu-iotests/check -qcow2
>=20
> Changes since v2
> - Add write-zeroes-unmap iotest
> - Fix iotest missing discard=3Dunmap
>=20
> v2 was here:
> https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00231.html
>=20
> Nir Soffer (2):
>   qemu-iotest/245: Add missing discard=3Dunmap
>   Consider discard option when writing zeros
>=20
>  block/io.c                                    |   9 +-
>  tests/qemu-iotests/245                        |   2 +-
>  tests/qemu-iotests/tests/write-zeroes-unmap   | 127 ++++++++++++++++++
>  .../qemu-iotests/tests/write-zeroes-unmap.out |  81 +++++++++++
>  4 files changed, 214 insertions(+), 5 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/write-zeroes-unmap
>  create mode 100644 tests/qemu-iotests/tests/write-zeroes-unmap.out
>=20
> --=20
> 2.45.2
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--y87Rr8AT5zw0BtTx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPobgACgkQnKSrs4Gr
c8itGAgAk9I2niWLFme8XRWG6zHvlekvRBPX8GcoIP5zolAOT91pY/eXkmzkaL2K
zTO0eH8zuJDd9ZEJeEj99/cFGJJ1czT18ayB1YbIPEBhghYGrr84oUuMiyrNHmCZ
eD9j1jqo/SpH3P4A46hjwnmggCp/YJ+BUVyvrKfGKmeRwb5C8smup4l6hrx2bUf0
ah9iQrNGOcvBbFLl14kuRGfr32XpjOslY+/zJUWKpIjBVXKHreuPbAE+MckNUYal
4hJ0BNKqd6uqb9FjhRjuPCvMtoMR9ptP7SUBFwRY0v3Vdm1rbQAbaP8tV/M4Q7Jl
+m18yV+3ckk00j7joazMMeWe4dSlkg==
=RBA4
-----END PGP SIGNATURE-----

--y87Rr8AT5zw0BtTx--


