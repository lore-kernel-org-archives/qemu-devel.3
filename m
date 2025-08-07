Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A6C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk6tM-0006IR-QV; Thu, 07 Aug 2025 16:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6tI-0006Hc-Dq
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6tE-0001cr-Eg
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754597220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDP79SMj48NdB0znxmUwRirmRoTCG1ExygAE6CKx0wI=;
 b=fIJuAxQbwTmx23t4XCn+MNRWSETPHczr7mzcENgezQ/o1f5eL31xXThsnJIdX9Qhtxqy7F
 veLXsCi9GGS6IZQECldYLdUMinmCz5lnjFH1aqf+l4KdtWQG+3qG5Bvre6HRwZmLDkIhlV
 SuhDVAgo3p96jIZ/IbdqsnXyRhhjbzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-0VBzmF0eOtyUQlx0fTvdTw-1; Thu,
 07 Aug 2025 16:06:57 -0400
X-MC-Unique: 0VBzmF0eOtyUQlx0fTvdTw-1
X-Mimecast-MFC-AGG-ID: 0VBzmF0eOtyUQlx0fTvdTw_1754597216
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7D4D195608C; Thu,  7 Aug 2025 20:06:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37B0319560AD; Thu,  7 Aug 2025 20:06:55 +0000 (UTC)
Date: Thu, 7 Aug 2025 16:06:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/8] tracetool: add test suite to improve reviewability
Message-ID: <20250807200653.GG51368@fedora>
References: <20250806164832.1382919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mcXyWKLwrNhoj2OU"
Content-Disposition: inline
In-Reply-To: <20250806164832.1382919-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--mcXyWKLwrNhoj2OU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 05:48:24PM +0100, Daniel P. Berrang=E9 wrote:
> To repeat the start of the commit message in patch 5....
>=20
> When reviewing tracetool patches it is often very unclear what the
> expected output will be for the generated backends. Compounding
> this is that a default build will only enable the 'log' trace
> backend, so developers won't see generated code for other backends
> without making a special effort. Some backends are also platform
> specific, so can't be enabled in QEMU builds, even though tracetool
> could generate the code.
>=20
> To address this, introduce a test suite for tracetool which is
> conceptually similar to the qapi-schema test. It is a simple
> python program that runs tracetool and compares the actual output
> to historical reference output kept in git.
>=20
> This was inspired by noticing the now pointless "__nocheck__"
> method wrapping in the inline probe functions.
>=20
> Changed in v3:
>=20
>  - Also modify the QAPI schema test to use QEMU_TEST_REGENERATE=3D1
>    env & document / hint this
>  - Make tracetool accept '-' as shorthand for stdout to
>    avoid relative paths in the reference output
>=20
> Changed in v2:
>=20
>  - Add tracetool info to docs/devel/testing.rst
>=20
> Daniel P. Berrang=E9 (8):
>   checkpatch: cull trailing '*/' in SPDX check
>   tracetool: eliminate trailing whitespace in C format
>   tracetool: avoid space after "*" in arg types
>   tracetool: include SPDX-License-Identifier in generated files
>   tracetool: support "-" as a shorthand for stdout
>   tracetool: add test suite for tracetool with reference output
>   tracetool: drop the probe "__nocheck__" wrapping
>   qapi: switch to use QEMU_TEST_REGENERATE env var
>=20
>  MAINTAINERS                                  |  1 +
>  docs/devel/testing/main.rst                  | 40 +++++++++
>  scripts/checkpatch.pl                        |  3 +
>  scripts/tracetool/__init__.py                | 17 +++-
>  scripts/tracetool/format/c.py                |  3 +-
>  scripts/tracetool/format/d.py                |  3 +-
>  scripts/tracetool/format/h.py                | 17 +---
>  scripts/tracetool/format/log_stap.py         |  1 +
>  scripts/tracetool/format/simpletrace_stap.py |  1 +
>  scripts/tracetool/format/stap.py             |  1 +
>  scripts/tracetool/format/ust_events_c.py     |  1 +
>  scripts/tracetool/format/ust_events_h.py     |  1 +
>  tests/Makefile.include                       |  1 +
>  tests/meson.build                            |  1 +
>  tests/qapi-schema/test-qapi.py               |  7 +-
>  tests/tracetool/dtrace.c                     | 32 +++++++
>  tests/tracetool/dtrace.d                     | 10 +++
>  tests/tracetool/dtrace.h                     | 45 ++++++++++
>  tests/tracetool/dtrace.log-stap              | 15 ++++
>  tests/tracetool/dtrace.simpletrace-stap      | 16 ++++
>  tests/tracetool/dtrace.stap                  | 14 +++
>  tests/tracetool/ftrace.c                     | 32 +++++++
>  tests/tracetool/ftrace.h                     | 59 +++++++++++++
>  tests/tracetool/log.c                        | 32 +++++++
>  tests/tracetool/log.h                        | 43 +++++++++
>  tests/tracetool/meson.build                  | 25 ++++++
>  tests/tracetool/simple.c                     | 61 +++++++++++++
>  tests/tracetool/simple.h                     | 40 +++++++++
>  tests/tracetool/syslog.c                     | 32 +++++++
>  tests/tracetool/syslog.h                     | 43 +++++++++
>  tests/tracetool/trace-events                 |  5 ++
>  tests/tracetool/tracetool-test.py            | 91 ++++++++++++++++++++
>  tests/tracetool/ust.c                        | 32 +++++++
>  tests/tracetool/ust.h                        | 41 +++++++++
>  tests/tracetool/ust.ust-events-c             | 14 +++
>  tests/tracetool/ust.ust-events-h             | 56 ++++++++++++
>  36 files changed, 813 insertions(+), 23 deletions(-)
>  create mode 100644 tests/tracetool/dtrace.c
>  create mode 100644 tests/tracetool/dtrace.d
>  create mode 100644 tests/tracetool/dtrace.h
>  create mode 100644 tests/tracetool/dtrace.log-stap
>  create mode 100644 tests/tracetool/dtrace.simpletrace-stap
>  create mode 100644 tests/tracetool/dtrace.stap
>  create mode 100644 tests/tracetool/ftrace.c
>  create mode 100644 tests/tracetool/ftrace.h
>  create mode 100644 tests/tracetool/log.c
>  create mode 100644 tests/tracetool/log.h
>  create mode 100644 tests/tracetool/meson.build
>  create mode 100644 tests/tracetool/simple.c
>  create mode 100644 tests/tracetool/simple.h
>  create mode 100644 tests/tracetool/syslog.c
>  create mode 100644 tests/tracetool/syslog.h
>  create mode 100644 tests/tracetool/trace-events
>  create mode 100755 tests/tracetool/tracetool-test.py
>  create mode 100644 tests/tracetool/ust.c
>  create mode 100644 tests/tracetool/ust.h
>  create mode 100644 tests/tracetool/ust.ust-events-c
>  create mode 100644 tests/tracetool/ust.ust-events-h

Aside from the stdout filename comment I posted:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mcXyWKLwrNhoj2OU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiVB10ACgkQnKSrs4Gr
c8gJHwf+KukVXzd6LQ0TMD7Tm1SWsaTWlzl/iCqI32na99q/x93YIVLfuWpitJXk
Fw9nUFKzlWiePOfMXZR5ZayN6H3wLCWHkDyetZL5CQOXpQ2fZg4owYIWDHVFcV05
qsC9qpXuCWZ8C1eH477qgzEBrO12dY6ds32HCJ4qPXgkspswfH+m2r7wcuDDpjmC
HF+Q3crUMCe2oVZ/MS+0XvXESXjwfn++/+CkcwkNJMc1aJfbM4Z/bzE3YAtyr6p1
5W9EQNQMaui6W5Hvt/toTn0LsWPHXpcDMcz1pUNPr5Hw9u+d3+0SFkPN5c8pcAcy
rq3jpj4o4vRxBgfh6TTWRDSP6ogEGQ==
=Pk59
-----END PGP SIGNATURE-----

--mcXyWKLwrNhoj2OU--


