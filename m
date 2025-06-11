Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ABFC71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ2H-0004L3-Ot; Wed, 11 Jun 2025 14:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ2D-0004KU-Nt
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ29-0000QE-U4
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749665923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxGliXXFXs2SNJqBxwGoWhk1rLrVHAp0ii/73BIQpjw=;
 b=DodU3HEG0mSrfiwWm1xZ739lno1Ic1DCAetoBLogwhk8npUgEdkqVh4xMaRa3qX5dr1pBP
 /bnOGMf5ohFJNchc91sL+h5M+sVz4cqks9rOFDSxrxv2u3qrYxhp+eETKATy0JZ3iOeZGD
 RGJG/M3LA8B74PfLbdxhwQ9uL8egbP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-UsTL7yl9N2ybhOZpE3QqKg-1; Wed,
 11 Jun 2025 14:18:41 -0400
X-MC-Unique: UsTL7yl9N2ybhOZpE3QqKg-1
X-Mimecast-MFC-AGG-ID: UsTL7yl9N2ybhOZpE3QqKg_1749665920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B8B18089B7; Wed, 11 Jun 2025 18:18:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67E0B30002C3; Wed, 11 Jun 2025 18:18:39 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:18:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
Message-ID: <20250611181838.GC190743@fedora>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uAiv5t4X8/fyFrRJ"
Content-Disposition: inline
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--uAiv5t4X8/fyFrRJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 11:45:04AM +0200, oltolm wrote:
> Sorry, I forgot to cc the maintainers.
>=20
> The build failed when run on Windows. I replaced calls to Unix programs
> like =B4cat=B4, =B4sed=B4 and =B4true=B4 with calls to =B4python=B4. I wr=
apped calls to
> =B4os.path.relpath=B4 in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>=20
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>  contrib/plugins/meson.build         |  2 +-
>  plugins/meson.build                 |  2 +-
>  scripts/tracetool/__init__.py       | 15 ++++++++++++---
>  scripts/tracetool/backend/ftrace.py |  4 +---
>  scripts/tracetool/backend/log.py    |  4 +---
>  scripts/tracetool/backend/syslog.py |  4 +---
>  tests/functional/meson.build        |  4 +---
>  tests/include/meson.build           |  2 +-
>  tests/tcg/plugins/meson.build       |  2 +-
>  trace/meson.build                   |  5 +++--
>  10 files changed, 23 insertions(+), 21 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--uAiv5t4X8/fyFrRJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyH4ACgkQnKSrs4Gr
c8jupAgAqOrBfO7EPNPBs6ICqaNTgW2N/wzesS5F6tqGG/R2bBgANNE/sP6RjvJc
zWVt70EqgDMzkll+TCZdlQeVMiVz8XR4ISwu/CysfCvOqzCyBEpaqRpfr358B2jh
tcewy3lCshgDAnTnE8C/y6POLDQW9YZVcPMVoyX/9vx/gBPERBTe8Qhm6d3NUTx7
0i49jwjByM6Qdk4cljtKXkj9DXFKwb9WSuEVU/lhr+G6FJlcLhtGgUMj//U1Abcn
vFNL9F6akyrFghY72yzDN+xK0yOaOVUufSvdnAEsufScu8wI5AC387D6qBMn3ps/
e0AnUQlaII3I8EaR3VbK73YfU51l0g==
=JoeK
-----END PGP SIGNATURE-----

--uAiv5t4X8/fyFrRJ--


