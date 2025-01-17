Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7810EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjUy-00086h-Hh; Fri, 17 Jan 2025 05:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tYjUv-00086N-8K
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tYjUr-0003N5-7T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXhNpmpcpCn6asqOUtdNwDyHyd4Oly/AE+O2vMsLGDA=;
 b=FJJLrOIsAl29zuPutS2Syac0f4o7hh9tAjgVaYGEhOyOOGMG9eoOOXmzwPyTlgomTjG4HV
 UxJ3tSBSRtF5DU0oeVmFSdfNPeWXQQcB2D79r81jxDfpMlbRo+q1GgAG5B/6AIwgZY6rMB
 YgDrFzzOmX3aIRn7VHUWvSk+T+IG/7M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-2vHKkwz8OAuJ4ZSdQlc23w-1; Fri,
 17 Jan 2025 05:22:32 -0500
X-MC-Unique: 2vHKkwz8OAuJ4ZSdQlc23w-1
X-Mimecast-MFC-AGG-ID: 2vHKkwz8OAuJ4ZSdQlc23w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27F3219560BA
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:22:31 +0000 (UTC)
Received: from localhost (unknown [10.45.225.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D35E19560BF; Fri, 17 Jan 2025 10:22:30 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:22:28 +0100
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
Message-ID: <pfvm5ngc2etid42mcu2kqdk5j7hib6evz7xnglfyijm7qwln3y@fn2shbudygks>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <20250110104946.74960-2-victortoso@redhat.com>
 <Z4osq2u_UIQOGfze@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6yh3p4gfmgtjzknb"
Content-Disposition: inline
In-Reply-To: <Z4osq2u_UIQOGfze@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--6yh3p4gfmgtjzknb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
MIME-Version: 1.0

Hi,

On Fri, Jan 17, 2025 at 10:10:51AM +0000, Daniel P. Berrang=E9 wrote:
> On Fri, Jan 10, 2025 at 11:49:39AM +0100, Victor Toso wrote:
> > This patch handles QAPI enum types and generates its equivalent in Go.
> > We sort the output based on enum's type name.
> >=20
> > Enums are being handled as strings in Golang.
> >=20
> > 1. For each QAPI enum, we will define a string type in Go to be the
> >    assigned type of this specific enum.
> >=20
> > 2. Naming: CamelCase will be used in any identifier that we want to
> >    export, which is everything.
> >=20
> > Example:
> >=20
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
> >=20
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
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 266 +++++++++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py   |   3 +
> >  2 files changed, 269 insertions(+)
> >  create mode 100644 scripts/qapi/golang.py
> >=20
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > new file mode 100644
> > index 0000000000..1e04c99f1c
> > --- /dev/null
> > +++ b/scripts/qapi/golang.py
> > @@ -0,0 +1,266 @@
> > +"""
> > +Golang QAPI generator
> > +"""
> > +
> > +# Copyright (c) 2025 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Victor Toso <victortoso@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.
> > +# See the COPYING file in the top-level directory.
>=20
> Did you mean to say GPL-2.0-only ? Generally we'd expect
> new code to be GPL-2.0-or-later.

Right. I've copied from another scripts/qapi/*.py
I'll fix it.
=20
> Also we'd now desire "SPDX-License-Identifier: GPL-2.0-or-later"
> for any newly added files,

I'll add it too.

> which reminds me to finish my patches to checkpatch.pl to
> enforce SPDX usage.

Cheers,
Victor

--6yh3p4gfmgtjzknb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmeKL2QACgkQl9kSPeN6
SE/QihAAruCZya40nx5BIPYFjSi8EpT926AfqQzJn1TKBBeYqNMEO+St6+Kpo41h
Nmc6oV0Y7qIxVN6FScAHvdrs5hnjv+dg8FVYYpmYuxo/z816JEpZa3dtzhiJd+tx
56QncEIOAdegfLdEEJp5rnSlbYdIBK/95jXkJ1n13AmoP/6Qd2dyVuWyY0yL5NwF
aqbNte5IyhXzdeihanVNDqhyR55G8JFsdiKAUV8lBkcUdPSLMiUF0yACLcGqR23J
6UQ1dJyLRbU7UAMvD1cMF0bof32801VsZCAHiHYfZuq2DVHfyg1InKuWvhe6CV1Z
22scWnR6UV5G3xVVv+bnuu5ZL7TLMwIAuV+mRmzHFnL0/tQQvOikjofcelTtzABO
bq5TVyrbeLI7l4qA/5jfzSuIfU5I5NttlDYScACej0WiDPG704jq3S+/9hzJZkHk
LBGnlBKvqr2ZP9ynVLp2jllR5HT//g4W9Mjt3gZMll9RRPAXMTF0pZfSR+/T/7UO
tfcKAF0gHYbzkx32HZr+y5+fEd3HqB/Lt+IACPZGZxNOTYHYrtZjDMsSVhsi+9hE
/a9EDtpczjbsCecXxkx7TPeMNVS0UAyJlKRScwMTPt4qYDpW0NmTKTNuqKiHWcLw
mPCQCvGqQQXh5JI6IJdSQfBPZldk0fhwE/PQFXegpxbZPimyg7I=
=sCZp
-----END PGP SIGNATURE-----

--6yh3p4gfmgtjzknb--


