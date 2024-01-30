Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D0C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1b-0002Td-Ce; Tue, 30 Jan 2024 16:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1a-0002TV-41
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1Y-0005ql-Iy
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqrIqLpfE6KTa8DGyo/qgveT/iUUoDKWiwmlBpLSM/c=;
 b=Z8ndWoJCj+Dr3px0Ifpi0+UNWqnE6c5dOXkJmJarU4Si0KWrzb/v5vs5HGgQVJBd+87mRE
 nmMrrkyUQy0s3SiXx/q309t8zy0icegTQu0hKrQkLG36iQBxu9vWsLHX3QdpKSUs0eHQqk
 COjSK8feR5pgVFN+cRYPEPCdVUj/dBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-RUmVC8oUNXWLmnJ2Rm7dlA-1; Tue, 30 Jan 2024 16:52:03 -0500
X-MC-Unique: RUmVC8oUNXWLmnJ2Rm7dlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62A888CDCF;
 Tue, 30 Jan 2024 21:52:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 044E610EA6;
 Tue, 30 Jan 2024 21:52:01 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:52:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/2] hw/block/block.c: improve confusing error
Message-ID: <20240130215200.GE320474@fedora>
References: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vG41yJS4+rkH0rdZ"
Content-Disposition: inline
In-Reply-To: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--vG41yJS4+rkH0rdZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 09:30:30AM +0200, Manos Pitsidianakis wrote:
> In cases where a device tries to read more bytes than the block device
> contains with the blk_check_size_and_read_all() function, the error is
> vague: "device requires X bytes, block backend provides Y bytes".
>=20
> This patch changes the errors of this function to include the block
> backend name, the device id and device type name where appropriate.
>=20
> Version 3:
> - Changed phrasing "%s device with id=3D'%s'" to "%s device '%s'" since
>   second parameter might be either device id or device path.
>     (thanks Stefan Hajnoczi <stefanha@redhat.com>)
>=20
> Version 2:
> - Assert dev is not NULL on qdev_get_human_name
>     (thanks Phil Mathieu-Daud=C3=A9 <philmd@linaro.org>)
>=20
> Manos Pitsidianakis (2):
>   hw/core/qdev.c: add qdev_get_human_name()
>   hw/block/block.c: improve confusing blk_check_size_and_read_all()
>     error
>=20
>  include/hw/block/block.h |  4 ++--
>  include/hw/qdev-core.h   | 14 ++++++++++++++
>  hw/block/block.c         | 25 +++++++++++++++----------
>  hw/block/m25p80.c        |  3 ++-
>  hw/block/pflash_cfi01.c  |  4 ++--
>  hw/block/pflash_cfi02.c  |  2 +-
>  hw/core/qdev.c           |  8 ++++++++
>  7 files changed, 44 insertions(+), 16 deletions(-)
>=20
> Range-diff against v2:
> 1:  5fb5879708 ! 1:  8b566bfced hw/core/qdev.c: add qdev_get_human_name()
>     @@ Commit message
>          Add a simple method to return some kind of human readable identi=
fier for
>          use in error messages.
>     =20
>     +    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>          Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.o=
rg>
>     =20
>       ## include/hw/qdev-core.h ##
> 2:  8e7eb17fbd ! 2:  7260eadff2 hw/block/block.c: improve confusing blk_c=
heck_size_and_read_all() error
>     @@ hw/block/block.c: static int blk_pread_nonzeroes(BlockBackend *blk=
, hwaddr size,
>      -                   "block backend provides %" PRIu64 " bytes",
>      -                   size, blk_len);
>      +        dev_id =3D qdev_get_human_name(dev);
>     -+        error_setg(errp, "%s device with id=3D'%s' requires %" HWAD=
DR_PRIu
>     ++        error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
>      +                   " bytes, %s block backend provides %" PRIu64 " b=
ytes",
>      +                   object_get_typename(OBJECT(dev)), dev_id, size,
>      +                   blk_name(blk), blk_len);
>     @@ hw/block/block.c: bool blk_check_size_and_read_all(BlockBackend *b=
lk, void *buf,
>      -        error_setg_errno(errp, -ret, "can't read block backend");
>      +        dev_id =3D qdev_get_human_name(dev);
>      +        error_setg_errno(errp, -ret, "can't read %s block backend"
>     -+                         "for %s device with id=3D'%s'",
>     ++                         " for %s device '%s'",
>      +                         blk_name(blk), object_get_typename(OBJECT(=
dev)),
>      +                         dev_id);
>               return false;
>=20
> base-commit: 11be70677c70fdccd452a3233653949b79e97908
> --=20
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--vG41yJS4+rkH0rdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW5b4AACgkQnKSrs4Gr
c8iIEAf/YCIf8PLAEbXcYk+Jlmt1nsA3Iq9Q6hcW0dtnHRekZ8CUV9yjSA1JvWQO
TZsYtntEM46MI+H77X57HpKFvxm9+qVgkz1AO+yoiou19UQvwQE6oE+kgmAdXu8X
X404o28r6jzH8GfNHrIvSYw4u6xGc/+alaG20Fyurxn2QtnJN17aiQO73YV2zKN3
FekZZ4JqrStYv5ZQZv3mSFtsUpgI7TYNMis98kjvUaHFoxFCMEp5PseFE0fny+VN
K3ys46s1pqYVIRRn90FMxmcwnhYMz0oOx64YiqHt/PvJ3sBQWDucGVstOHt0H1dF
5q+Y5FAxEOujRgan9kIItxh23F74Eg==
=JsjN
-----END PGP SIGNATURE-----

--vG41yJS4+rkH0rdZ--


