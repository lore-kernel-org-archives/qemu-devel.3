Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E67C47BF5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 14:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd7yO-0004nn-VM; Tue, 06 Jan 2026 09:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vd7yM-0004kj-PV
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 09:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vd7yK-0004JH-Px
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 09:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767709422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYlJkxfAc09UUpqDMPAMZ7fix4+l7WgAuO6Z503Ze/0=;
 b=FR/kIPiUoQaCOcqLE+SajdSFo9oQQjIEOh+O4/5HS/diOjxcuyzdVfO4jU+Ns4WVm08IgW
 yZ2+Y9kw5DkDx2znCbpAuSnqphENCQTh4htpolMnun4BuoOq0/mJx763K2rEgeIg23hlDl
 jHcWZLB8nqcgyLm0Pz/5iW1LwwN1NCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-_0y6dZS5PBqu-cLXYBT_sg-1; Tue,
 06 Jan 2026 09:23:39 -0500
X-MC-Unique: _0y6dZS5PBqu-cLXYBT_sg-1
X-Mimecast-MFC-AGG-ID: _0y6dZS5PBqu-cLXYBT_sg_1767709418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D53191809A06; Tue,  6 Jan 2026 14:23:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 962FA18004D8; Tue,  6 Jan 2026 14:23:33 +0000 (UTC)
Date: Mon, 5 Jan 2026 14:10:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net
Subject: Re: [PATCH] block/io: fallback to bounce buffer if BLKZEROOUT is not
 supported because of alignment
Message-ID: <20260105191049.GB59391@fedora>
References: <20260105143416.737482-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="slfdR39JgnnaEYiw"
Content-Disposition: inline
In-Reply-To: <20260105143416.737482-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--slfdR39JgnnaEYiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 03:29:55PM +0100, Fiona Ebner wrote:
> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
> certain 'qemu-img convert' invocations, because of a pre-existing
> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
> the request is shorter than the block size of the block device.
> Fallback to the bounce buffer, similar to when the ioctl is not
> supported at all, rather than treating such an error as fatal.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
> Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7197
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index cace297f22..e37d9d2417 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1917,7 +1917,8 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int6=
4_t offset, int64_t bytes,
>              assert(!bs->supported_zero_flags);
>          }
> =20
> -        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
> +        if ((ret =3D=3D -ENOTSUP || (ret =3D=3D -EINVAL && num < alignme=
nt)) &&
> +            !(flags & BDRV_REQ_NO_FALLBACK)) {
>              /* Fall back to bounce buffer if write zeroes is unsupported=
 */
>              BdrvRequestFlags write_flags =3D flags & ~BDRV_REQ_ZERO_WRIT=
E;

This patch invokes the ioctl(BLKZERO) first and then falls back to a
write request. In the bug report this only occurs at the end of qemu-img
convert, so the performance overhead of failing the ioctl first and then
submitting a write doesn't matter.

I would prefer taking advantage of the existing alignment code in
bdrv_co_do_zero_pwritev() instead of falling back like this. The
alignment code currently has no effect because
BlockLimits->request_alignment =3D 1 for cache=3Dwriteback. It is unaware
that ioctl(BLKZERO) requires block alignment. Once that is fixed,
bdrv_co_do_zero_pwritev() will submit a regular write request for the
misaligned tail.

Block drivers with specific alignment requirements for write zeroes
report them in BlockLimits->pwrite_zeroes_alignment. I think
bdrv_co_do_zero_pwritev() should prioritize
bs->bl.pwrite_zeroes_alignment over bs->bl.request_alignment.
file-posix.c already populates pwrite_zeroes_alignment - it's just not
used by bdrv_co_do_zero_pwritev() yet.

Do you want to give that a try?

Thanks,
Stefan

--slfdR39JgnnaEYiw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlcDLkACgkQnKSrs4Gr
c8gbowgAuR38pqOBeiDwtVCPsD6hXscnLuk9KbCDGPckoGs+YhWb7Ts2jXsMfIPN
5H5v1RT2SPkgZeZC+wNoXFOvgg3gq3MhiuyVLfMpS17rkab1TX0WQZYSjjorx8yf
OJWwBjBPCLErkEf2jKAVyDIkChMTkCUUXAayXoLQtD3gN1SjKe+i+gBg9imgr0kr
eFhgAnrjeMkTCgO9uU+zXzEpbw81hZgZzKqEcUfB+1vjjIaq2Mp3kf9Rh8mSZQs4
BHF2+tlc+Gy4kgctCzrF8Vwaojs1FW7zYUEgaKwacJ/FHMD415oM0GnjodOFqZyQ
gVd/tEjvtKg2NuCW7Lf+JspTvmVgnA==
=wl9x
-----END PGP SIGNATURE-----

--slfdR39JgnnaEYiw--


