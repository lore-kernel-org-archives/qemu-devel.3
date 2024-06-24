Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37BCC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlXJ-0003ub-OJ; Mon, 24 Jun 2024 11:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sLlXI-0003tt-26
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sLlXF-0007YO-Vy
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719242592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWfNFYTsknWkhTQuQ6eNHmBpUAojSNNVrUtEypoQS20=;
 b=KZ3jI/5ibJ70o8+NvhubCWGm4f+HTiOu8dw15hSFX/s1qTpVEOaZ+Z9yEKo1kte+qsGYJ/
 s69FLwtMQ/caj6Tm+srdcJ6pU+Qc6y7Hfmb/M35K/ZeYclGIOltmeb33rVjUhrIlb9gp0g
 IGRpF725NXpt38o6JMIncf6PL0M2Qrs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-EwaheHxgPRKi9BgpIohZRw-1; Mon,
 24 Jun 2024 11:23:07 -0400
X-MC-Unique: EwaheHxgPRKi9BgpIohZRw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72D28195608C; Mon, 24 Jun 2024 15:23:05 +0000 (UTC)
Received: from localhost (unknown [10.39.193.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89F1F1956087; Mon, 24 Jun 2024 15:23:04 +0000 (UTC)
Date: Mon, 24 Jun 2024 11:23:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
Message-ID: <20240624152302.GA2402845@fedora.redhat.com>
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p+GQ7bAq4WM9FWxL"
Content-Disposition: inline
In-Reply-To: <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


--p+GQ7bAq4WM9FWxL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> Tested using:

Hi Nir,
This looks like a good candidate for the qemu-iotests test suite. Adding
it to the automated tests will protect against future regressions.

Please add the script and the expected output to
tests/qemu-iotests/test/write-zeroes-unmap and run it using
`(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.

See the existing test cases in tests/qemu-iotests/ and
tests/qemu-iotests/tests/ for examples. Some are shell scripts and
others are Python. I think shell makes sense for this test case. You can
copy the test framework boilerplate from an existing test case.

Thanks,
Stefan

>=20
> $ cat test-unmap.sh
> #!/bin/sh
>=20
> qemu=3D${1:?Usage: $0 qemu-executable}
> img=3D/tmp/test.raw
>=20
> echo
> echo "defaults - write zeroes"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -z 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
> du -sh $img
>=20
> echo
> echo "defaults - write zeroes unmap"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
> du -sh $img
>=20
> echo
> echo "defaults - write actual zeros"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw >/dev/null
> du -sh $img
>=20
> echo
> echo "discard=3Doff - write zeroes unmap"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Doff >/dev/null
> du -sh $img
>=20
> echo
> echo "detect-zeros=3Don - write actual zeros"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw,detect-zeroes=3Don >/dev/nu=
ll
> du -sh $img
>=20
> echo
> echo "detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' |  $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw,detect-zeroes=3Dunmap,disca=
rd=3Dunmap
> >/dev/null
> du -sh $img
>=20
> echo
> echo "discard=3Dunmap - write zeroes"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -z 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null
> du -sh $img
>=20
> echo
> echo "discard=3Dunmap - write zeroes unmap"
> fallocate -l 1m $img
> echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
>     -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null
> du -sh $img
>=20
> rm $img
>=20
>=20
> Before this change:
>=20
> $ cat before.out
>=20
> defaults - write zeroes
> 1.0M /tmp/test.raw
>=20
> defaults - write zeroes unmap
> 0 /tmp/test.raw
>=20
> defaults - write actual zeros
> 1.0M /tmp/test.raw
>=20
> discard=3Doff - write zeroes unmap
> 0 /tmp/test.raw
>=20
> detect-zeros=3Don - write actual zeros
> 1.0M /tmp/test.raw
>=20
> detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros
> 0 /tmp/test.raw
>=20
> discard=3Dunmap - write zeroes
> 1.0M /tmp/test.raw
>=20
> discard=3Dunmap - write zeroes unmap
> 0 /tmp/test.raw
> [nsoffer build (consider-discard-option)]$
>=20
>=20
> After this change:
>=20
> $ cat after.out
>=20
> defaults - write zeroes
> 1.0M /tmp/test.raw
>=20
> defaults - write zeroes unmap
> 1.0M /tmp/test.raw
>=20
> defaults - write actual zeros
> 1.0M /tmp/test.raw
>=20
> discard=3Doff - write zeroes unmap
> 1.0M /tmp/test.raw
>=20
> detect-zeros=3Don - write actual zeros
> 1.0M /tmp/test.raw
>=20
> detect-zeros=3Dunmap,discard=3Dunmap - write actual zeros
> 0 /tmp/test.raw
>=20
> discard=3Dunmap - write zeroes
> 1.0M /tmp/test.raw
>=20
> discard=3Dunmap - write zeroes unmap
> 0 /tmp/test.raw
>=20
>=20
> Differences:
>=20
> $ diff -u before.out after.out
> --- before.out 2024-06-19 20:24:09.234083713 +0300
> +++ after.out 2024-06-19 20:24:20.526165573 +0300
> @@ -3,13 +3,13 @@
>  1.0M /tmp/test.raw
>=20
>  defaults - write zeroes unmap
> -0 /tmp/test.raw
> +1.0M /tmp/test.raw
>=20
>  defaults - write actual zeros
>  1.0M /tmp/test.raw
>=20
>  discard=3Doff - write zeroes unmap
> -0 /tmp/test.raw
> +1.0M /tmp/test.raw
>=20
> On Wed, Jun 19, 2024 at 8:40=E2=80=AFPM Nir Soffer <nsoffer@redhat.com> w=
rote:
>=20
> > When opening an image with discard=3Doff, we punch hole in the image wh=
en
> > writing zeroes, making the image sparse. This breaks users that want to
> > ensure that writes cannot fail with ENOSPACE by using fully allocated
> > images.
> >
> > bdrv_co_pwrite_zeroes() correctly disable BDRV_REQ_MAY_UNMAP if we
> > opened the child without discard=3Dunmap or discard=3Don. But we don't =
go
> > through this function when accessing the top node. Move the check down
> > to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.
> >
> > Issues:
> > - We don't punch hole by default, so images are kept allocated. Before
> >   this change we punched holes by default. I'm not sure this is a good
> >   change in behavior.
> > - Need to run all block tests
> > - Not sure that we have tests covering unmapping, we may need new tests
> > - We may need new tests to cover this change
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >
> > Changes since v1:
> > - Replace the incorrect has_discard change with the right fix
> >
> > v1 was here:
> > https://lists.nongnu.org/archive/html/qemu-block/2024-06/msg00198.html
> >
> >  block/io.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/io.c b/block/io.c
> > index 7217cf811b..301514c880 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -1860,10 +1860,15 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> > int64_t offset, int64_t bytes,
> >      /* By definition there is no user buffer so this flag doesn't make
> > sense */
> >      if (flags & BDRV_REQ_REGISTERED_BUF) {
> >          return -EINVAL;
> >      }
> >
> > +    /* If opened with discard=3Doff we should never unmap. */
> > +    if (!(bs->open_flags & BDRV_O_UNMAP)) {
> > +        flags &=3D ~BDRV_REQ_MAY_UNMAP;
> > +    }
> > +
> >      /* Invalidate the cached block-status data range if this write
> > overlaps */
> >      bdrv_bsc_invalidate_range(bs, offset, bytes);
> >
> >      assert(alignment % bs->bl.request_alignment =3D=3D 0);
> >      head =3D offset % alignment;
> > @@ -2313,14 +2318,10 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild
> > *child, int64_t offset,
> >  {
> >      IO_CODE();
> >      trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
> >      assert_bdrv_graph_readable();
> >
> > -    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
> > -        flags &=3D ~BDRV_REQ_MAY_UNMAP;
> > -    }
> > -
> >      return bdrv_co_pwritev(child, offset, bytes, NULL,
> >                             BDRV_REQ_ZERO_WRITE | flags);
> >  }
> >
> >  /*
> > --
> > 2.45.1
> >
> >

--p+GQ7bAq4WM9FWxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZ5j1YACgkQnKSrs4Gr
c8iRkwf+I2ThSdjsDhIwOKSOkemyydBJ7a2xzjcv0UxecCWhyA5kgCG7QLs88XsR
2GiXK6P7mSmL74mfLXHAfVg6bsfYOLRuG1IFEY7RzPHHD+tJH1+5LPFYKTmKkCLR
zTfds3x0z+WI090nKPSAEIeVApriYo6ftvzHmmP0q8XyrQqBXu/xaJs4AxXea/8L
iNjXttreNZ/tMOP4isdm8cPqIgviUjfPrcpMkPffz/uVp6tTcJrLMH+o/fLn2TS9
P3PgjLnbY92E3pjB0BK+S2f7qhVFr2h14Ywwrd8xcOYfTG7Vjsq3925wUMvYwRWY
q3vI4bHBax157+X6RNXlh+CUcpBkJA==
=PWvB
-----END PGP SIGNATURE-----

--p+GQ7bAq4WM9FWxL--


