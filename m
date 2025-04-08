Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8214C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2B7K-0002v4-Fy; Tue, 08 Apr 2025 11:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2B7C-0002ro-PB
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2B7B-0004Nt-CP
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744127031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxBxRwAYyLNmXovfcW1/77YZLpfXHuziDa/t1gvt3AY=;
 b=B8v+Np2cROiprw1R+3tZQGj3AnHZg2FlBxqyB9tmkXsVyVCdBJPSy15BkJ8q2uRmDk8tTz
 adR3QDnaVT/NGFqXme9utiAUyEUoLLTT4E9/bMDe7PIygBRffutAjh5pYwzW1c4bTn0eVy
 N7rCCixKo2C8PQduJpe8ae01RrB/z4U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-mo1TYGtUPE2GdFU7aaDg2g-1; Tue,
 08 Apr 2025 11:43:45 -0400
X-MC-Unique: mo1TYGtUPE2GdFU7aaDg2g-1
X-Mimecast-MFC-AGG-ID: mo1TYGtUPE2GdFU7aaDg2g_1744127021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52163180AF52; Tue,  8 Apr 2025 15:43:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5AC5180B487; Tue,  8 Apr 2025 15:43:39 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:43:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pinku Deb Nath <prantoran@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] block/file-posix.c: Use pwritev2() with RWF_DSYNC for
 FUA
Message-ID: <20250408154338.GD550845@fedora>
References: <20250407154730.23008-1-prantoran@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z/PUxPJMfkpIMmxa"
Content-Disposition: inline
In-Reply-To: <20250407154730.23008-1-prantoran@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--z/PUxPJMfkpIMmxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 08:47:30AM -0700, Pinku Deb Nath wrote:
> Full Unit Access (FUA) is an optimization where a disk write with the
> flag set will be persisted to disk immediately instead of potentially
> remaining in the disk's write cache.
>=20
> This commit address the todo task
> for using pwritev2() with RWF_DSYNC in the thread pool section of
> raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
> which is always the case for Linux kernel >=3D 4.7.
>=20
> The intent for FUA is indicated with the BDRV_REQ_FUA flag.
> The old code paths are preserved in case BDRV_REQ_FUA is off
> or pwritev2() with RWF_DSYNC is not available.
>=20
> Support for disk writes with FUA is handled in qemu_pwritev_fua(),
> which uses pwritev2() with RWF_DSYNC if available, otherwise falls
> back to pwritev2() with no flags followed by flush using
> handle_aiocb_flush().
>=20
> If pwritev2() is not implemented, then disk write in the linear FUA
> will fallback to pwrite() + handle_aiocb_flush().
>=20
> Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>
>=20
> ---
>=20
> v5:
> - Use pwritev for unsupported OSes
>=20
> v4:
> - Add fallback when qemu_pwritev_fua() returns ENOSYS
> - Similar fallback was not added for handle_aiocb_rw_vector()
> since there is a preadv_present check in handle_aiocb_rw()
>=20
> v3:
> - Changed signature to add fd, iov, nr_iov
> - Return -ENOSYS for non-Linux hosts
>=20
> v2:
> - Moved handle_aiocb_flush() into qemu_pwritev_fua()
> - In handle_aiocb_rw_linear(), iovec with iovcnt=3D1 is created
> based on the assumption that there will be only one buffer
> ---
>  block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--z/PUxPJMfkpIMmxa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf1RCoACgkQnKSrs4Gr
c8jIMgf/SenIgQ+5dvJ8YwwtaxYZCQg8nSQbYsT379L1OS/hSh7IJqUq9Mou2+cC
Rn7NSwRr5kP/cY8Uo9uQWPgDRfZxT1L4L4i8pZZxR7Jb4n0fqM/1lvqK+soOwiYT
g1Aqp3fxUEGER9MHkAY3rbYLXDqoW5EEeA3hb/HH3mRAFbV6yW5S9uw7UPNWSteI
yiD9KSrcqGsGu9bxk17rb0ZcWvTdHopcEfx4JdS6hE8PxRMtwGysKvIr0KV2onTn
FChck6LmwFqMk6rST6nd+3t/O5X8LuJeQRiMKWE1fdZQUGaemD9JEvpHVXC1/Jgh
nBNO5BDm/VBfzmr9mCBrNH16QdGLsA==
=Qh38
-----END PGP SIGNATURE-----

--z/PUxPJMfkpIMmxa--


