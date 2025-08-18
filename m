Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF8CA0EE9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 20:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo6g1-0006RN-01; Mon, 18 Aug 2025 16:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uo6fz-0006R1-5Z
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 16:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uo6fx-0005ug-2t
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 16:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755549710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sXcA3eT4yNEpNu794FMadm8ZiXmc8VfpAUdd6d+1DUA=;
 b=aYtGOHaCUsjGwJdbYCYE0BB8FPpK4OHwdNt6UmXtIrBJWqOLLBJXxEx6xWbE3As46BLHZr
 blbzlHlwwqZeYBUJU8XNBjPl7+f5VdoestqNf9b0Qzcchitw3RjnuRt/3hTrw77hg0av82
 RK4jOn1/FViw2+Rp1RPRLOU/XBOrQM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-aWRXPNvrPJ-8tQ2imdUUwA-1; Mon,
 18 Aug 2025 16:41:47 -0400
X-MC-Unique: aWRXPNvrPJ-8tQ2imdUUwA-1
X-Mimecast-MFC-AGG-ID: aWRXPNvrPJ-8tQ2imdUUwA_1755549706
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD23719775A6; Mon, 18 Aug 2025 20:41:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F2F71955F24; Mon, 18 Aug 2025 20:41:44 +0000 (UTC)
Date: Mon, 18 Aug 2025 13:55:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, oleg.tolmatcev@gmail.com
Subject: Re: [PATCH v3 5/8] tracetool: support "-" as a shorthand for stdout
Message-ID: <20250818175548.GA16685@fedora>
References: <20250806164832.1382919-1-berrange@redhat.com>
 <20250806164832.1382919-6-berrange@redhat.com>
 <20250807194608.GF51368@fedora> <aKNBsOekKkCSqgD7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rWZidU2v4zyJ7x3G"
Content-Disposition: inline
In-Reply-To: <aKNBsOekKkCSqgD7@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--rWZidU2v4zyJ7x3G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 04:07:28PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Aug 07, 2025 at 03:46:08PM -0400, Stefan Hajnoczi wrote:
> > On Wed, Aug 06, 2025 at 05:48:29PM +0100, Daniel P. Berrang=E9 wrote:
> > > This avoids callers needing to use the UNIX-only /dev/stdout
> > > workaround.
> > >=20
> > > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > ---
> > >  scripts/tracetool/__init__.py | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init=
__.py
> > > index 0f33758870..c8fd3a7ddc 100644
> > > --- a/scripts/tracetool/__init__.py
> > > +++ b/scripts/tracetool/__init__.py
> > > @@ -38,8 +38,12 @@ def error(*lines):
> > > =20
> > >  def out_open(filename):
> > >      global out_filename, out_fobj
> > > -    out_filename =3D posix_relpath(filename)
> > > -    out_fobj =3D open(filename, 'wt')
> > > +    if filename =3D=3D "-":
> > > +        out_filename =3D "[stdout]"
> >=20
> > A few lines above:
> >=20
> >   out_filename =3D '<none>'
> >   out_fobj =3D sys.stdout
> >=20
> > Stick to '<none>' here for consistency?
>=20
> Curious - that suggests that it was intended to be able to write to
> stdout by default, but tracetool.py unconditionally calls out_open()
> so those default assignments are effectively dead code, unless this
> internal code is called by something other than the tracetool.py main
> entrypoint ?
>=20
> I guess I'd be inclined to change the global initialization to just
> be 'None' to make it explicit that out_open is expected to always be
> called ?

Originally the script wrote to stdout, but I added an explicit output
filename argument in commit c05012a365c2 ("tracetool: add output
filename command-line argument") because #line directives emitted by
tracetool need to know the output filename.

Your next patch tests/tracetool/tracetool-test.py uses "-" as the
output filename but leaves the existing meson.build files unchanged.
They will still specify an output filename.

This commit doesn't break anything, at least not in how this patch
series uses "-", but I see a contradiction with commit c05012a365c2
since we're now allowing the output filename to be effectively empty.

Could you avoid special casing stdout and instead pass a relative path
to the output file? The relative path is important so the test reference
output is portable across machines. Then you don't need this commit.

Stefan

>=20
> > > +        out_fobj =3D sys.stdout
> > > +    else:
> > > +        out_filename =3D posix_relpath(filename)
> >=20
> > I have CCed Oleg in case he spots any portability issues, but I think
> > this should still work on Windows.
>=20
> This use of posix_relpath() was pre-existing, so there shouldn't be
> any new issues from this.
>=20
> >=20
> > > +        out_fobj =3D open(filename, 'wt')
> > > =20
> > >  def out(*lines, **kwargs):
> > >      """Write a set of output lines.
>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--rWZidU2v4zyJ7x3G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmijaSQACgkQnKSrs4Gr
c8gYoAgAlEkSUEyDDQeBBTIV4XNairZHJiBpexQ8GNX6dFpbblN9M7u6jPAwotxK
nnQRn4tqr71ibiuAhBrCGJAHz52CgB92bjsEV5xNOE7L2uKVpksp3pb4GEsUlEQa
BJJVbSSF9MwXyIWLK2oz5wy8b7PPmB4UhRJJeJMHYv/prtSmT6p0sIy71kuhiPFT
+4fS747/kWSvqrt5lnupA/arwZH+WqgZTYMUQPwlAP4SVpcm7GKkZm7t48CtR0/y
1OqPc8YUDlhfJQqLFop7/MOo0SNv+MCrpoIe323EAiwyhoHN8v8l9VaVOyy9/D3E
FOoB28woGm9+7GvfSvj36N6H0IwnTQ==
=diaI
-----END PGP SIGNATURE-----

--rWZidU2v4zyJ7x3G--


