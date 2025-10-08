Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA94CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6YQu-0006IC-44; Wed, 08 Oct 2025 13:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YQr-0006Hy-EL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YQl-0006yk-GD
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759946300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIJ0WH06wT9OxHP9tl3dANlNqe64TRPcBIAfDX4ExrQ=;
 b=KQpyW5nmGNZLro/sOCFx3Az9CFusN/i0N8CtB3E8Tfu7Gt0QHZxdsuPQPhTsX4AiFSwKfM
 zgBTo5o1rf+xi31dcaCCt+nhEfiuWQiB+F3H3MnGvxcrElQ8QlTOb/bznZVm/yPw6k9pTe
 5Gnfw2efvLDI94/sYmxM6rAUKES1MYA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-n9yqeFrEPtyrSe25paRA8w-1; Wed,
 08 Oct 2025 13:58:17 -0400
X-MC-Unique: n9yqeFrEPtyrSe25paRA8w-1
X-Mimecast-MFC-AGG-ID: n9yqeFrEPtyrSe25paRA8w_1759946295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C310F1800366; Wed,  8 Oct 2025 17:58:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E32C1800576; Wed,  8 Oct 2025 17:58:13 +0000 (UTC)
Date: Wed, 8 Oct 2025 13:58:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
Message-ID: <20251008175811.GB181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+m0AKT1t4welzCRE"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--+m0AKT1t4welzCRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:41AM +0200, Paolo Bonzini wrote:
> Sort imports automatically, to keep the coding style more uniform.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/tests/tracetool-isort.sh      | 4 ++++
>  scripts/tracetool.py                 | 5 ++---
>  scripts/tracetool/backend/dtrace.py  | 1 -
>  scripts/tracetool/backend/ftrace.py  | 3 +--
>  scripts/tracetool/backend/log.py     | 3 +--
>  scripts/tracetool/backend/simple.py  | 1 -
>  scripts/tracetool/backend/syslog.py  | 3 +--
>  scripts/tracetool/backend/ust.py     | 1 -
>  scripts/tracetool/format/d.py        | 2 +-
>  scripts/tracetool/format/log_stap.py | 1 -
>  scripts/tracetool/format/stap.py     | 1 -
>  11 files changed, 10 insertions(+), 15 deletions(-)
>  create mode 100755 python/tests/tracetool-isort.sh
>=20
> diff --git a/python/tests/tracetool-isort.sh b/python/tests/tracetool-iso=
rt.sh
> new file mode 100755
> index 00000000000..b23f3d48448
> --- /dev/null
> +++ b/python/tests/tracetool-isort.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +python3 -m isort --sp . -c ../scripts/tracetool/

I wonder why python/tests/isort.sh doesn't already cover this with its
`python3 -m isort -c scripts/` line?

Also, why the --settings-path (--sp) option that python/tests/isort.sh
doesn't use?

It would be great to have just 1 script that runs isort on all Python
code in QEMU.

--+m0AKT1t4welzCRE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmpjIACgkQnKSrs4Gr
c8gN5Af/cj9bdReZ5Js3LOJ37zVJFZRYJTghv8FEk/nQCGXudV6htUsYKDrKYspZ
oaBd899Qwo6TzQ2lzs9TuUXUl1UolXwLi7ziArhs5/QrqJN5tAVO+zwRL38uPZUf
Oifuja3j0T+fSZ+Rg8d41vDVjY4G1djYJ06+rD2pxeYvCjSQj8MuBeFo1wTmiapY
SFLoOVOhH15ne7kFsm03CKDPYCay24ck+IvZOLoGk4F8tkXazlYwpsi5sxLQ+qe+
agKd4Gr/XNHQC7vjUKz3Cicx1dyKHc8Fp+rOU13NAE2sroRvoytPBZrmNhytkFA/
TMfz9q1lS4y/woIGee5T4BQmUn4t2w==
=mK1d
-----END PGP SIGNATURE-----

--+m0AKT1t4welzCRE--


