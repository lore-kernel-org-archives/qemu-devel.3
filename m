Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05219C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdkk-0003e3-PB; Mon, 09 Jun 2025 10:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOdki-0003dY-NX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uOdkg-0007iG-Qg
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749480330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVmTIGueD+jVw0J1onyWshU08PG/lW/jCzJxqrKQ0eQ=;
 b=B4G4QamBv9qHyLl1bnaRs5P5yefWPAI7r3ivLfyhGQSAb0Y0gSlvLogbecxe+QamjYRqNW
 WyHcEmqNe5wu6LTDs3/FHDDT+6/dfFytTHk210sxE+PIKdIUK+n+kZEE+Flc0+04rmVQSH
 UA5el6gOntFwdj0JhBFK+BKugr657dk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-RJFE20AwMDStTN5uVC1ZAw-1; Mon,
 09 Jun 2025 10:45:27 -0400
X-MC-Unique: RJFE20AwMDStTN5uVC1ZAw-1
X-Mimecast-MFC-AGG-ID: RJFE20AwMDStTN5uVC1ZAw_1749480325
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E4C01800287; Mon,  9 Jun 2025 14:45:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDB3819560A3; Mon,  9 Jun 2025 14:45:24 +0000 (UTC)
Date: Mon, 9 Jun 2025 10:45:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v2 01/21] fuse: Copy write buffer content before polling
Message-ID: <20250609144523.GD29452@fedora>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hqmh3syZhVVH+iG3"
Content-Disposition: inline
In-Reply-To: <20250604132813.359438-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--hqmh3syZhVVH+iG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 03:27:53PM +0200, Hanna Czenczek wrote:
> aio_poll() in I/O functions can lead to nested read_from_fuse_export()
> calls, overwriting the request buffer's content.  The only function
> affected by this is fuse_write(), which therefore must use a bounce
> buffer or corruption may occur.
>=20
> Note that in addition we do not know whether libfuse-internal structures
> can cope with this nesting, and even if we did, we probably cannot rely
> on it in the future.  This is the main reason why we want to remove
> libfuse from the I/O path.
>=20
> I do not have a good reproducer for this other than:
>=20
> $ dd if=3D/dev/urandom of=3Dimage bs=3D1M count=3D4096
> $ dd if=3D/dev/zero of=3Dcopy bs=3D1M count=3D4096
> $ touch fuse-export
> $ qemu-storage-daemon \
>     --blockdev file,node-name=3Dfile,filename=3Dcopy \
>     --export \
>     fuse,id=3Dexp,node-name=3Dfile,mountpoint=3Dfuse-export,writable=3Dtr=
ue \
>     &
>=20
> Other shell:
> $ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
> $ killall -SIGINT qemu-storage-daemon
> $ qemu-img compare image copy
> Content mismatch at offset 0!
>=20
> (The -t none in qemu-img convert is important.)
>=20
> I tried reproducing this with throttle and small aio_write requests from
> another qemu-io instance, but for some reason all requests are perfectly
> serialized then.
>=20
> I think in theory we should get parallel writes only if we set
> fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
> if we do that, that throttle-based reproducer works (i.e. does get
> parallel (nested) write requests).  I have no idea why we still get
> parallel requests with qemu-img convert anyway.
>=20
> Also, a later patch in this series will set fi->parallel_direct_writes
> and note that it makes basically no difference when running fio on the
> current libfuse-based version of our code.  It does make a difference
> without libfuse.  So something quite fishy is going on.
>=20
> I will try to investigate further what the root cause is, but I think
> for now let's assume that calling blk_pwrite() can invalidate the buffer
> contents through nested polling.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hqmh3syZhVVH+iG3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhG84MACgkQnKSrs4Gr
c8hQXQgAuksQqKt83+9A7jq/UzhrNkFAscpsmUjLojwkAmZH1Qg7CKVSOKvuxrwu
AqYRTOrF6TTti8MmZ5m3XFKMpNXPcORaQKDTPVFZB8meH9Ek+prowszCuOjHjTt3
LPCzqdP+lM9vzgAaqUcIzsMCKlQMypA/mgWRn1ROamxkGLlY/GeZJQuOtNe3XBr1
o40NS6Zc19FpLHQaNalUp4puOHLT0C1SOinFQEQ2gOiDYzIOs2udbk8qV1iULpuY
d/eX2xCYipxnEH9S5DSiIlGWxTaq2w09JUwoTtvmiAxh+4rkUsWHNfcgwB0qgCvR
tS1zhhSvGFU2nClbwE2tnhjP4vIM+g==
=Ybrd
-----END PGP SIGNATURE-----

--hqmh3syZhVVH+iG3--


