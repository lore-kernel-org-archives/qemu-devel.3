Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B67C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4L2R-0004bk-UG; Mon, 14 Apr 2025 10:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4L2K-0004Zt-QT
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u4L2I-0000P6-2u
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744641823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFVVnSzyb9FDUrIfAz46FvkvnVICAsiHlfUYX0fzRIw=;
 b=ZAhWAS/21wd/dIBZkYLJT9gKHdgkCVxqNF7/ENlxjHo3PMqMg03fUGcifH7jAgjZ21h8Ke
 16BqTsFQkn+B+1HoKo1zcRnlzsUaBXOoCCdJEDvQc+5rxqWrXYkfsv1FuUhgP3e1S4V2cN
 5CTI8seIOgcphzFmJ8gCp2LnIyZoRVI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-_0WzAfJHOdS344sUHFCCDQ-1; Mon,
 14 Apr 2025 10:43:40 -0400
X-MC-Unique: _0WzAfJHOdS344sUHFCCDQ-1
X-Mimecast-MFC-AGG-ID: _0WzAfJHOdS344sUHFCCDQ_1744641819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EEAB19560AB; Mon, 14 Apr 2025 14:43:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C58BE18009BC; Mon, 14 Apr 2025 14:43:37 +0000 (UTC)
Date: Mon, 14 Apr 2025 10:43:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: Arthur Sengileyev <arthur.sengileyev@gmail.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH for-10.0] Fix objdump output parser in "nsis.py"
Message-ID: <20250414144336.GA117758@fedora>
References: <20250412180830.52742-1-arthur.sengileyev@gmail.com>
 <d0f79ab8-5e02-4f9d-aa6b-acf8220e5d11@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DqzfdfZwe9OJl8fC"
Content-Disposition: inline
In-Reply-To: <d0f79ab8-5e02-4f9d-aa6b-acf8220e5d11@weilnetz.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--DqzfdfZwe9OJl8fC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 08:19:50PM +0200, Stefan Weil wrote:
> Am 12.04.25 um 20:08 schrieb Arthur Sengileyev:
>=20
> > In msys2 distribution objdump from gcc is using single tab character
> > prefix, but objdump from clang is using 4 white space characters instea=
d.
> > The script will not identify any dll dependencies for a QEMU build
> > generated with clang. This in turn will fail the build, because there
> > will be no files inside dlldir and no setup file will be created.
> > Instead of checking for whitespace in prefix use lstrip to accommodate
> > for differences in outputs.
> >=20
> > Signed-off-by: Arthur Sengileyev <arthur.sengileyev@gmail.com>
> > ---
> >   scripts/nsis.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/nsis.py b/scripts/nsis.py
> > index af4e064819..8f469634eb 100644
> > --- a/scripts/nsis.py
> > +++ b/scripts/nsis.py
> > @@ -23,7 +23,7 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
> >       output =3D subprocess.check_output(["objdump", "-p", exe_or_dll],=
 text=3DTrue)
> >       output =3D output.split("\n")
> >       for line in output:
> > -        if not line.startswith("\tDLL Name: "):
> > +        if not line.lstrip().startswith("DLL Name: "):
> >               continue
> >           dep =3D line.split("DLL Name: ")[1].strip()
>=20
>=20
> Thanks. I use nearly the same code `if not line.strip().startswith("DLL
> Name: "):` in my builds for WoA.
>=20
> @Stefan, can this trivial patch still be applied for 10.0?

Yes, it is included in Michael Tokarev's latest trivial patches pull
request.

> I had planned to replace the whole code with objdump by platform independ=
ent
> Python code, but that's a larger change, and I missed the deadline.
>=20
>=20
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>=20
>=20

--DqzfdfZwe9OJl8fC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf9HxgACgkQnKSrs4Gr
c8hvZQgAmS2Tvkzr+kbkuEJPvPbPEhA9WPv5AVpQnmqvWRZTLPw4m8LpeDB82LYg
INOESp++X/k4kuBeKeH/p2qKprD/C/EdGGO6VexkU4EXdwJbt1il9QzXB/gg8gMp
RyjbaDLoBuIRdS8jbZyFUQF/2oREF2ABf4fPGh5kVdPCS2HvXtSyraZRiu0Teu7r
LiweRXbO+MPaEBxr6tSdzzcrowFPBigiQAF6QRzcmj59TinmrGEtzC+dMdnwnztW
HNKCJu5y9xZS1BnPzFaA9QakTyzpCGXK9zxeNzehHBJ0nXNaRV7rCgbmSa6sOqoU
3IYR+NdWFwLDtVs2adIoj5Q8C9cVwQ==
=i4vd
-----END PGP SIGNATURE-----

--DqzfdfZwe9OJl8fC--


