Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35806C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUvQ0-0000Wc-Fc; Tue, 30 Jan 2024 16:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvPz-0000TG-4g
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUvPx-0007KU-Aa
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706649195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BFbO4wo5LAEm+T7DAJIO2K9o/PbHMK58TUCI1DjtNg=;
 b=f6g7FLsC5eQmi1ZCsXA1TI9Ak0hQDwP3P4z4QjDM6kZF/xZwlzNO+uu9bDzUFdvb7KjPvy
 OvYJwwU9QDaLSOlLQe28ntVBTIpxfvkpnjr/EZK+WN5bKdW5xzjbZHKQDnSbi8r5yGDMb+
 KVBsYi8mSF+ZOD1mRU+tSlYRkUdEQL4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-JfHGItIyMYS5S5Qs6nLzYQ-1; Tue, 30 Jan 2024 16:13:11 -0500
X-MC-Unique: JfHGItIyMYS5S5Qs6nLzYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 520371064DA8;
 Tue, 30 Jan 2024 21:13:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4B0F2026D66;
 Tue, 30 Jan 2024 21:13:10 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:13:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com
Subject: Re: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Message-ID: <20240130211309.GB320474@fedora>
References: <20240129185427.2952727-1-rjones@redhat.com>
 <20240129185427.2952727-2-rjones@redhat.com>
 <Zbi4r90M8K3o6EgZ@redhat.com> <20240130103050.GJ7636@redhat.com>
 <Zbjl3jQbF05QcQD5@redhat.com> <20240130121937.GK7636@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AetR3ckxPwEc0vQq"
Content-Disposition: inline
In-Reply-To: <20240130121937.GK7636@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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


--AetR3ckxPwEc0vQq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:19:37PM +0000, Richard W.M. Jones wrote:
> On Tue, Jan 30, 2024 at 01:04:46PM +0100, Kevin Wolf wrote:
> > Am 30.01.2024 um 11:30 hat Richard W.M. Jones geschrieben:
> > > On Tue, Jan 30, 2024 at 09:51:59AM +0100, Kevin Wolf wrote:
> > > > Am 29.01.2024 um 19:53 hat Richard W.M. Jones geschrieben:
> > > > > With GCC 14 the code failed to compile on i686 (and was wrong for=
 any
> > > > > version of GCC):
> > > > >=20
> > > > > ../block/blkio.c: In function =E2=80=98blkio_file_open=E2=80=99:
> > > > > ../block/blkio.c:857:28: error: passing argument 3 of =E2=80=98bl=
kio_get_uint64=E2=80=99 from incompatible pointer type [-Wincompatible-poin=
ter-types]
> > > > >   857 |                            &s->mem_region_alignment);
> > > > >       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > >       |                            |
> > > > >       |                            size_t * {aka unsigned int *}
> > > > > In file included from ../block/blkio.c:12:
> > > > > /usr/include/blkio.h:49:67: note: expected =E2=80=98uint64_t *=E2=
=80=99 {aka =E2=80=98long long unsigned int *=E2=80=99} but argument is of =
type =E2=80=98size_t *=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99}
> > > > >    49 | int blkio_get_uint64(struct blkio *b, const char *name, u=
int64_t *value);
> > > > >       |                                                         ~=
~~~~~~~~~^~~~~
> > > > >=20
> > > > > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > > >=20
> > > > Why not simply make BDRVBlkioState.mem_region_alignment a uint64_t
> > > > instead of keeping it size_t and doing an additional conversion with
> > > > a check that requires an #if (probably to avoid a warning on 64 bit
> > > > hosts because the condition is never true)?
> > >=20
> > > The smaller change (attached) does work on i686, but this worries me a
> > > little (although it doesn't give any error or warning):
> > >=20
> > >     if (((uintptr_t)host | size) % s->mem_region_alignment) {
> > >     error_setg(errp, "unaligned buf %p with size %zu", host, size);
> > >         return BMRR_FAIL;
> > >     }
> >=20
> > I don't see the problem? The calculation will now be done in 64 bits
> > even on a 32 bit host, but that seems fine to me. Is there a trap I'm
> > missing?
>=20
> I guess not.  Stefan, any comments on whether we need to worry about
> huge mem-region-alignment?  I'll post the updated patch as a new
> message in a second.

An alignment of 32 or more bits is not required in any scenario that I'm
aware of.

Stefan

--AetR3ckxPwEc0vQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmW5ZmUACgkQnKSrs4Gr
c8jWFwgAwzSJe1rzlApdkAiYwUwYcXDZTMhqncNGiBsIzy137jrEiL01jMYrUcf1
CmpvpIjyShgY5RlGE7yCXOMv3PVQPf1CDzFwLZ1cwCVcG2viUPcYlDZvRTLw0Agh
+14NNZVvaEXKs0Y+PPSHEFnAlm7RjBfI8RbXRlB4qXKTNYPy0ohMo3aQ9+rMBmV0
9YN/ZqOmSWwEHNCCKNzxpsDcQ5uALo4dXKDvyLqF5i+kjx7/YhR7r2HOyNrbsRix
YXxUiCCX9xWFRBiMPEchEiIYj/e7GjiTIwk3TSDu2YrLyR2XK4Pc21v2aJ0B9pjJ
UZwb9K/PqWSRDErqFaPw3be/uFXZng==
=Koxp
-----END PGP SIGNATURE-----

--AetR3ckxPwEc0vQq--


