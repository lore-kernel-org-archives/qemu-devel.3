Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8DAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdNh-0001qt-U6; Tue, 14 Jan 2025 04:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tXdNf-0001mq-3q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tXdNc-00057Y-VX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736847514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEUk92E2PzQZby6maPs4dcy5ISs05J17SCcfKAK334Y=;
 b=Diw5SupxCRCN8EwWtWjWQbs96rITVXmFgO2mRw3Vh+i7Xq/2fdpBRUuNi/+2SXepPDqiSH
 sR7w+uEboqRjnnT5y6YgT7vg0GLxQZ/jRAoWN+cwEJ1sKMdgaimKl1shrdD8KLtzmPbrNK
 2Z+S+DDrjimfM82DU/LEgSGNJXhj4qU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-8ScMnoc5OPGZdSYDshKEPQ-1; Tue,
 14 Jan 2025 04:38:32 -0500
X-MC-Unique: 8ScMnoc5OPGZdSYDshKEPQ-1
X-Mimecast-MFC-AGG-ID: 8ScMnoc5OPGZdSYDshKEPQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273901955DA5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:38:31 +0000 (UTC)
Received: from localhost (unknown [10.45.225.199])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C62019560BC; Tue, 14 Jan 2025 09:38:29 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:38:28 +0100
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
Message-ID: <rh5dbmvcz6bxtbotrv3wbh5vmv3d6pj7hoyzfvygvwiaoffzzo@fetdx2znjro2>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <20250110104946.74960-2-victortoso@redhat.com>
 <878qrdkcag.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o7u5yezkixoj3uk5"
Content-Disposition: inline
In-Reply-To: <878qrdkcag.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--o7u5yezkixoj3uk5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
MIME-Version: 1.0

Hi,

On Tue, Jan 14, 2025 at 09:52:23AM +0100, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > This patch handles QAPI enum types and generates its equivalent in Go.
> > We sort the output based on enum's type name.
>=20
> Any particular reason for sorting?

It was a request from Daniel that I've accepted.
https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg07042.html

We did the same thing in the code generator in libvirt-go-module
and the result helps with navigating the code and also with the
diff itself when we regenerate.
=20
> The existing backends generate output it source order, on the (bold?)
> assumption that developers care to pick an order that makes sense.
>=20
> > Enums are being handled as strings in Golang.
> >
> > 1. For each QAPI enum, we will define a string type in Go to be the
> >    assigned type of this specific enum.
> >
> > 2. Naming: CamelCase will be used in any identifier that we want to
> >    export, which is everything.
> >
> > Example:
> >
> > qapi:
> >   | ##
> >   | # @DisplayProtocol:
> >   | #
> >   | # Display protocols which support changing password options.
> >   | #
> >   | # Since: 7.0
> >   | ##
> >   | { 'enum': 'DisplayProtocol',
> >   |   'data': [ 'vnc', 'spice' ] }
> >
> > go:
> >   | // Display protocols which support changing password options.
> >   | //
> >   | // Since: 7.0
> >   | type DisplayProtocol string
> >   |
> >   | const (
> >   | 	DisplayProtocolVnc   DisplayProtocol =3D "vnc"
> >   | 	DisplayProtocolSpice DisplayProtocol =3D "spice"
> >   | )
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 266 +++++++++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py   |   3 +
> >  2 files changed, 269 insertions(+)
> >  create mode 100644 scripts/qapi/golang.py
> >
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > new file mode 100644
> > index 0000000000..1e04c99f1c
> > --- /dev/null
> > +++ b/scripts/qapi/golang.py
>=20
> [...]
>=20
> > +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
>=20
> [...]
>=20
> > +    def write(self, output_dir: str) -> None:
> > +        for module_name, content in self.target.items():
> > +            go_module =3D module_name + "s.go"
> > +            go_dir =3D "go"
> > +            pathname =3D os.path.join(output_dir, go_dir, go_module)
> > +            odir =3D os.path.dirname(pathname)
> > +            os.makedirs(odir, exist_ok=3DTrue)
> > +
> > +            with open(pathname, "w", encoding=3D"utf8") as outfile:
> > +                outfile.write(content)
>=20
> Your write() serves the same purpose as QAPIGen.write().  The latter
> touches output files only when their contents actually changes.
>=20
> Have you considered use of QAPIGen?

I have not, didn't know that actually.
I have to investigate if it'd be beneficial. Considering this is
once per release execution, shouldn't be a big problem either
way.
=20
> The backends generating C use QAPISchemaMonolithicCVisitor or
> QAPISchemaModularCVisitor, which use QAPIGenC, QAPIGenH and
> QAPIGenTrace, all specializations of QAPIGen.
>=20
> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 316736b6a2..f1f813b466 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -15,6 +15,7 @@
> >  from .common import must_match
> >  from .error import QAPIError
> >  from .events import gen_events
> > +from .golang import gen_golang
> >  from .introspect import gen_introspect
> >  from .schema import QAPISchema
> >  from .types import gen_types
> > @@ -54,6 +55,8 @@ def generate(schema_file: str,
> >      gen_events(schema, output_dir, prefix)
> >      gen_introspect(schema, output_dir, prefix, unmask)
> > =20
> > +    gen_golang(schema, output_dir, prefix)
> > +
> > =20
> >  def main() -> int:
> >      """

Thanks for the review,
Victor

--o7u5yezkixoj3uk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmeGMJQACgkQl9kSPeN6
SE9w7A/8DvyB4vbsxFZfZXGhDInk6CFyErSLP3MyG0H9AVx9lFofl1jikIdg9QLj
qOi4l629+9AFPMPc4vDPX7zde1TnV1jWh5v0LmNxOS8FzAr8dFbOrB3dKTe+lZ7V
XvfbtTHc3TmEgSN43rWWe9rdzqQBUwNo9Aro0M4Xu2q0nzX2QAhPuWN8yBIskmRZ
OLZQZERBe/P1Us9AXSJTTwYWqoSyXcxzUZfgsOCGVPPXYvj8sXQOWCm0QUqAWQlf
pHfethVPPumttIXPkNbh+eF1T9/irUH+onsI2suYPYflgNc2TnZThB6Uu9AOCdRs
sLkFEzrk4c41HEesL6tFAyYIFUsngNtouPOOBphkieuDVoqKtXPnOsO9JfSyELyi
053CbVpKajIBOAOOG+aaRpw42q492lS09bwq9ffA6BFN0yq0nF/PXJ51YMFsjUkW
pqA7RVXRTL0Hjcx1LXY4Nw2gghQO7pihP/NV3Y1NIBjzwQ52Ti5R4byjelUcNZB4
KA7qx5hZUqDWn7aotHG4ihmXSa36StZZbqLwq7aH6xWd0+d0pwUgqiV6Z3Gx7Rum
Tb5sxYtAceTlBl3ez3z2uvfv4vl3ihHcThToxURf96dfmnQHk6ZJU4FnJtb6yuo9
8FHW/CFekrXGfUZcFVShWlZtXG7y5dAk4myZVQ+SpvtX5qw1vsU=
=TIFo
-----END PGP SIGNATURE-----

--o7u5yezkixoj3uk5--


