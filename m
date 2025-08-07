Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F9C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 19:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk6ZH-0003dw-So; Thu, 07 Aug 2025 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6Z9-0003b6-Lp
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6Z7-0007Nz-Gx
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754595975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+bum5DFFdrvCsAMBQ63S7iJ2/vrsbTwMSczXzuPhFs=;
 b=AKBkj7aN7NUIo31wnclVzl7n9UY6ko5jWP7z8KYUugvEM/7RXS4tpYfh9FvAEXH+rQ972m
 9F7iSlWnO9BBoEbDCy0qeKphqWmWefpENeIZqOuaSWTzLCKBo2nsrpRZCi5x2uRrqOd4qI
 4VFoZd8uumtX2IlhGv3zy9hiAldaPWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-1UpP5PmhPzuQwSl4XOsBlA-1; Thu,
 07 Aug 2025 15:46:12 -0400
X-MC-Unique: 1UpP5PmhPzuQwSl4XOsBlA-1
X-Mimecast-MFC-AGG-ID: 1UpP5PmhPzuQwSl4XOsBlA_1754595971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1513B180044F; Thu,  7 Aug 2025 19:46:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A7861954185; Thu,  7 Aug 2025 19:46:10 +0000 (UTC)
Date: Thu, 7 Aug 2025 15:46:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, oleg.tolmatcev@gmail.com
Subject: Re: [PATCH v3 5/8] tracetool: support "-" as a shorthand for stdout
Message-ID: <20250807194608.GF51368@fedora>
References: <20250806164832.1382919-1-berrange@redhat.com>
 <20250806164832.1382919-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WMtHKMSit7orA+UG"
Content-Disposition: inline
In-Reply-To: <20250806164832.1382919-6-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--WMtHKMSit7orA+UG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 05:48:29PM +0100, Daniel P. Berrang=E9 wrote:
> This avoids callers needing to use the UNIX-only /dev/stdout
> workaround.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 0f33758870..c8fd3a7ddc 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -38,8 +38,12 @@ def error(*lines):
> =20
>  def out_open(filename):
>      global out_filename, out_fobj
> -    out_filename =3D posix_relpath(filename)
> -    out_fobj =3D open(filename, 'wt')
> +    if filename =3D=3D "-":
> +        out_filename =3D "[stdout]"

A few lines above:

  out_filename =3D '<none>'
  out_fobj =3D sys.stdout

Stick to '<none>' here for consistency?

> +        out_fobj =3D sys.stdout
> +    else:
> +        out_filename =3D posix_relpath(filename)

I have CCed Oleg in case he spots any portability issues, but I think
this should still work on Windows.

> +        out_fobj =3D open(filename, 'wt')
> =20
>  def out(*lines, **kwargs):
>      """Write a set of output lines.
> --=20
> 2.50.1
>=20

--WMtHKMSit7orA+UG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiVAoAACgkQnKSrs4Gr
c8gExAf+NOVL4z7dTsgHDza4iNBT+sG/ONcHdCC/kBTL7mZK7XIDkZEaMKG4pitN
wJ+riOX/lIbehlq/7v9KWy9Ne8a0quTg+DeNaIVGdwW4MqfNB4FWB5ZigbN/5fm0
an7TqBnkbBgZJcXCjD/B52EVvTwytMHd9AjKBoc/Ycm5pFtinj0yBDkYljHJLFG/
wY4Kfj1Zk4X3g4RI58UOwLe5krIwxw6zdd5nBnO435y0TTPOKloQTO7zbdyeb5mX
3yywfE3b2EMkd+DKA+G6CkSCvgVJnz00N9qizKbuki+FrJNR4D6qPFgB8euLGfX1
IoMUdjZdyxe7dRR5Spiovp5ShBQ3lA==
=P7jQ
-----END PGP SIGNATURE-----

--WMtHKMSit7orA+UG--


