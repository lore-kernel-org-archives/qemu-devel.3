Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BEAC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 14:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkm5h-0008BZ-1O; Thu, 14 Mar 2024 10:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkm5e-0008Av-93
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkm5b-0001O4-Uq
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 10:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710426586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLN468TyQHbOUB6laCVtRxLqUFs0jLNPG7UOmufCxgM=;
 b=SXXPKGgMnaCOlSyNOdnYBp2hTlgtkWBJ3Hljo9n3cXgd0W2e2eeQprhioR45Q1TQohgVKU
 LEJ+xbopgVYUkRUrHq4zvOJIKYs/3nN39JTi/2/yMx2rThGWhZvShClom997jX5bTWp5xw
 lahoRMk/Sna+0irwmUNpoe/z6yReuHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-6fqMHo6VPUut-B3AKhphWA-1; Thu, 14 Mar 2024 10:29:42 -0400
X-MC-Unique: 6fqMHo6VPUut-B3AKhphWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1E05800270;
 Thu, 14 Mar 2024 14:29:41 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 519A32166B4F;
 Thu, 14 Mar 2024 14:29:41 +0000 (UTC)
Date: Thu, 14 Mar 2024 10:29:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 aliang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0] mirror: Don't call job_pause_point() under graph
 lock
Message-ID: <20240314142939.GE611723@fedora>
References: <20240313153000.33121-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4f7Iuz/GAeJAzZaM"
Content-Disposition: inline
In-Reply-To: <20240313153000.33121-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--4f7Iuz/GAeJAzZaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 04:30:00PM +0100, Kevin Wolf wrote:
> Calling job_pause_point() while holding the graph reader lock
> potentially results in a deadlock: bdrv_graph_wrlock() first drains
> everything, including the mirror job, which pauses it. The job is only
> unpaused at the end of the drain section, which is when the graph writer
> lock has been successfully taken. However, if the job happens to be
> paused at a pause point where it still holds the reader lock, the writer
> lock can't be taken as long as the job is still paused.
>=20
> Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.
>=20
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-28125
> Fixes: 004915a96a7a40e942ac85e6d22518cbcd283506
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h |  2 +-
>  block/mirror.c     | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 9ea98b5927..2b873f2576 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -483,7 +483,7 @@ void job_enter(Job *job);
>   *
>   * Called with job_mutex *not* held.
>   */
> -void coroutine_fn job_pause_point(Job *job);
> +void coroutine_fn GRAPH_UNLOCKED job_pause_point(Job *job);
> =20
>  /**
>   * @job: The job that calls the function.
> diff --git a/block/mirror.c b/block/mirror.c
> index 5145eb53e1..1bdce3b657 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -479,9 +479,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int=
64_t offset,
>      return bytes_handled;
>  }
> =20
> -static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
> +static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob =
*s)
>  {
> -    BlockDriverState *source =3D s->mirror_top_bs->backing->bs;
> +    BlockDriverState *source;
>      MirrorOp *pseudo_op;
>      int64_t offset;
>      /* At least the first dirty chunk is mirrored in one iteration. */
> @@ -489,6 +489,10 @@ static void coroutine_fn GRAPH_RDLOCK mirror_iterati=
on(MirrorBlockJob *s)
>      bool write_zeroes_ok =3D bdrv_can_write_zeroes_with_unmap(blk_bs(s->=
target));
>      int max_io_bytes =3D MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
> =20
> +    bdrv_graph_co_rdlock();
> +    source =3D s->mirror_top_bs->backing->bs;

Is bdrv_ref(source) needed here so that source cannot go away if someone
else write locks the graph and removes it? Or maybe something else
protects against that. Either way, please add a comment that explains
why this is safe.

> +    bdrv_graph_co_rdunlock();
> +
>      bdrv_dirty_bitmap_lock(s->dirty_bitmap);
>      offset =3D bdrv_dirty_iter_next(s->dbi);
>      if (offset < 0) {
> @@ -1066,9 +1070,7 @@ static int coroutine_fn mirror_run(Job *job, Error =
**errp)
>                  mirror_wait_for_free_in_flight_slot(s);
>                  continue;
>              } else if (cnt !=3D 0) {
> -                bdrv_graph_co_rdlock();
>                  mirror_iteration(s);
> -                bdrv_graph_co_rdunlock();
>              }
>          }
> =20
> --=20
> 2.44.0
>=20

--4f7Iuz/GAeJAzZaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXzCdMACgkQnKSrs4Gr
c8h2ogf/XKvlyuw9KxsTEgBrbNiGWqNSswZrNQnCaEbKcEKs7aU4Gjhr4N2Ay4NZ
A4VbtLRiI85r15jaciFmzeimyB40XY9BmUluBjrsVGpkVbs+PTheO0ifAWrn1LaR
izYiAP+smzeu3KYhPKj4foWAauIMLS2bUHDNHJfIBskrxPADXO6uSNTXtI8cWvdT
NY+RCtKUOmN6OR169sJTIUXGCXjsp8R9v3dxkO/IDiCO4MehrBTRjRmGnbe8h0El
pMb1b7ycx+FBtXaOgDvdUVHa9o3gnTbjXlUmimDzUIcRhBjEO6WIiVDeZN5Xys1q
6Eacym35CXXHrQP32uRZlvtlLx2fHA==
=V0Fe
-----END PGP SIGNATURE-----

--4f7Iuz/GAeJAzZaM--


