Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E4DCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6Jb-0004J7-AI; Tue, 26 Mar 2024 08:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp6JY-0004I6-6g
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp6JW-000490-LM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711457642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EIl14wxj3W6lON4jR9olKaR7bR6xu50JtK/eCNAcpzg=;
 b=Ke0BsRV2fTCC4LYFpkwFD6o0csPiFGp4euM2i+kS2sAvs0+UxC0df1s96Z8H0sr4A3jYto
 EvUP4Oo9g3JWCvLxOc+z2wxqo23OAkrapywIrTeWvxZqzySN3uunG7tkIBcJKhSQvoO5Rn
 5zeX/0fmc6YAarzxnhGd+J/jHdaRNM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-5iLHOLEXOQmGzpnh5QYE6A-1; Tue, 26 Mar 2024 08:53:56 -0400
X-MC-Unique: 5iLHOLEXOQmGzpnh5QYE6A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16CC0810469;
 Tue, 26 Mar 2024 12:53:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51B76492BDC;
 Tue, 26 Mar 2024 12:53:53 +0000 (UTC)
Date: Tue, 26 Mar 2024 13:53:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 fam@euphon.net, t.lamprecht@proxmox.com, w.bumiller@proxmox.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 0/4] fix two edge cases related to stream block jobs
Message-ID: <ZgLFXEd6JsVTnKCv@redhat.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240325201116.GE1944176@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HtzA1h09/Nl67ztt"
Content-Disposition: inline
In-Reply-To: <20240325201116.GE1944176@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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


--HtzA1h09/Nl67ztt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.03.2024 um 21:11 hat Stefan Hajnoczi geschrieben:
> On Fri, Mar 22, 2024 at 10:50:05AM +0100, Fiona Ebner wrote:
> > Changes in v3:
> >     * Also deal with edge case in bdrv_next_cleanup(). Haven't run
> >       into an actual issue there, but at least the caller in
> >       migration/block.c uses bdrv_nb_sectors() which, while not a
> >       coroutine wrapper itself (it's written manually), may call
> >       bdrv_refresh_total_sectors(), which is a generated coroutine
> >       wrapper, so AFAIU, the block graph can change during that call.
> >       And even without that, it's just better to be more consistent
> >       with bdrv_next().
> >=20
> > Changes in v2:
> >     * Ran into another issue while writing the IO test Stefan wanted
> >       to have (good call :)), so include a fix for that and add the
> >       test. I didn't notice during manual testing, because I hadn't
> >       used a scripted QMP 'quit', so there was no race.
> >=20
> > Fiona Ebner (3):
> >   block-backend: fix edge case in bdrv_next() where BDS associated to BB
> >     changes
> >   block-backend: fix edge case in bdrv_next_cleanup() where BDS
> >     associated to BB changes
> >   iotests: add test for stream job with an unaligned prefetch read
> >=20
> > Stefan Reiter (1):
> >   block/io: accept NULL qiov in bdrv_pad_request
> >=20
> >  block/block-backend.c                         | 18 ++--
> >  block/io.c                                    | 31 ++++---
> >  .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
> >  .../tests/stream-unaligned-prefetch.out       |  5 ++
> >  4 files changed, 117 insertions(+), 23 deletions(-)
> >  create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
> >  create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.=
out
>=20
> Looks good to me. I will wait until Thursday before merging in case
> Hanna, Vladimir, or Kevin have comments. Thanks!

Let's not delay it to -rc2. If something turns out to be wrong with it,
we can still revert it, but I think getting fixes in earlier is better
during freeze.

Thanks, applied to the block branch.

Kevin

--HtzA1h09/Nl67ztt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmYCxVwACgkQfwmycsiP
L9Y+JQ/+I8OpJCvbnK+MrGggafMd/P+WMOgVRxSSW22Ms61RlH9GOBGYuKIWwwPL
8DJXB5VGMrPIX58SEHyL5PGyoFfieHAW5eNVzPLJcxyWdkRYwOEnjSVzIkXOGtsp
XhTLILi15dXUHLw7DbzqzllQILKdTNqm/kkkP6W0TgS9AnnfLUT9rtWRYS586YuC
k422c32/Dh6iZjGhEI2m9ArNWIfFhS//vLL/FZRl4wIKUSjH7CbKO8/U6UdZerVz
Mfr3ramJEn77CdHwV1WYKj86bIbqUvdSxAXmEpTN75gaC/40wJFji7jrCVgJ2sQA
PXjRhk/mqgk2PmxXB/kn1auBUr4MGNZWuSCpOdC9GxKuQ+gNPQhwhBQfkkcoIuP+
xNX79XV41KebdaG1WAUryPJTFgzeNlBr72HX40LZjoa4zGpoUeL0ga5xDSOZoLQO
74yhniBcG7XkXTKrAXMrNRZewLACdgG1m+t3GDMkTDK8NJSzEB7dfFCFUdyLgWLP
oLxoml9XMGwnji/1Fh1BXfSpsp5NyX0NbEik0wYwFhqpmQ+OjkiT3e4oe14RBMP/
wiyraHz+mjjesMKKohZBSOafcqG/MVlk/r9S0Q2gd+rnzlhb5BYJk1MgY+HQ6mxY
UMLqJkvyI6JarOEMAIP31b4cnVpH510Pq3LYyfn1sr8ZZw+zCWA=
=EUwr
-----END PGP SIGNATURE-----

--HtzA1h09/Nl67ztt--


