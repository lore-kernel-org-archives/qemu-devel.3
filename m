Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BB8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6JK-0008PM-EZ; Thu, 21 Aug 2025 10:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6JJ-0008Ox-Dx
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6JH-00072l-37
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755786633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86xfhadHv62EUAgE1Gfl6cKTiNoha5CSmGLqrUfwdLw=;
 b=K1b9b8NPAaSvWy5fVs86sfpSzpnom64zwACed0abxhU8a3UxbwNOIEIwla0Sq9KYaNRcfW
 RFVZrBt0uCaK7q+N2vJIV967jNmkSuO9b+w7jN4UiTX6Q7JZBaJGiS/AvltvRY5W92hM+W
 cIu4f5B7E1UNzlgMkoq3vc93RTbIRlg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-QygswYtoPsa4yCI2o5TrZQ-1; Thu,
 21 Aug 2025 10:30:31 -0400
X-MC-Unique: QygswYtoPsa4yCI2o5TrZQ-1
X-Mimecast-MFC-AGG-ID: QygswYtoPsa4yCI2o5TrZQ_1755786630
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09077195C15A; Thu, 21 Aug 2025 14:29:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 763C81955F24; Thu, 21 Aug 2025 14:29:11 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:29:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 0/7] tracetool: add test suite to improve reviewability
Message-ID: <20250821142910.GD7010@fedora>
References: <20250819161053.464641-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YACCkNcH7AcOjKIe"
Content-Disposition: inline
In-Reply-To: <20250819161053.464641-1-berrange@redhat.com>
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


--YACCkNcH7AcOjKIe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 05:10:46PM +0100, Daniel P. Berrang=E9 wrote:
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
> Changed in v4:
>=20
>  - Drop patch adding '-' as an output filename for tracetool
>  - Rewrite test to always use relative filenames for both
>    inputs and outputs
>  - Pass python code through 'black'
>  - Minor docs punctuation tweak
>  - Drop unused python method
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
> Daniel P. Berrang=E9 (7):
>   checkpatch: cull trailing '*/' in SPDX check
>   tracetool: eliminate trailing whitespace in C format
>   tracetool: avoid space after "*" in arg types
>   tracetool: include SPDX-License-Identifier in generated files
>   tracetool: add test suite for tracetool with reference output
>   tracetool: drop the probe "__nocheck__" wrapping
>   qapi: switch to use QEMU_TEST_REGENERATE env var
>=20
>  MAINTAINERS                                  |   1 +
>  docs/devel/testing/main.rst                  |  40 +++++++
>  scripts/checkpatch.pl                        |   3 +
>  scripts/tracetool/__init__.py                |   9 +-
>  scripts/tracetool/format/c.py                |   3 +-
>  scripts/tracetool/format/d.py                |   3 +-
>  scripts/tracetool/format/h.py                |  17 +--
>  scripts/tracetool/format/log_stap.py         |   1 +
>  scripts/tracetool/format/simpletrace_stap.py |   1 +
>  scripts/tracetool/format/stap.py             |   1 +
>  scripts/tracetool/format/ust_events_c.py     |   1 +
>  scripts/tracetool/format/ust_events_h.py     |   1 +
>  tests/Makefile.include                       |   1 +
>  tests/meson.build                            |   1 +
>  tests/qapi-schema/test-qapi.py               |   7 +-
>  tests/tracetool/dtrace.c                     |  32 ++++++
>  tests/tracetool/dtrace.d                     |  10 ++
>  tests/tracetool/dtrace.h                     |  45 ++++++++
>  tests/tracetool/dtrace.log-stap              |  15 +++
>  tests/tracetool/dtrace.simpletrace-stap      |  16 +++
>  tests/tracetool/dtrace.stap                  |  14 +++
>  tests/tracetool/ftrace.c                     |  32 ++++++
>  tests/tracetool/ftrace.h                     |  59 +++++++++++
>  tests/tracetool/log.c                        |  32 ++++++
>  tests/tracetool/log.h                        |  43 ++++++++
>  tests/tracetool/meson.build                  |  25 +++++
>  tests/tracetool/simple.c                     |  61 +++++++++++
>  tests/tracetool/simple.h                     |  40 +++++++
>  tests/tracetool/syslog.c                     |  32 ++++++
>  tests/tracetool/syslog.h                     |  43 ++++++++
>  tests/tracetool/trace-events                 |   5 +
>  tests/tracetool/tracetool-test.py            | 105 +++++++++++++++++++
>  tests/tracetool/ust.c                        |  32 ++++++
>  tests/tracetool/ust.h                        |  41 ++++++++
>  tests/tracetool/ust.ust-events-c             |  14 +++
>  tests/tracetool/ust.ust-events-h             |  56 ++++++++++
>  36 files changed, 821 insertions(+), 21 deletions(-)
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
>=20
> --=20
> 2.50.1
>=20

Thanks, applied to my tracing-next tree:
https://gitlab.com/stefanha/qemu/commits/tracing-next

Stefan

--YACCkNcH7AcOjKIe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminLTYACgkQnKSrs4Gr
c8jAywf/V06t1I4DJPQauTVNa/f2GmZEKY0cDxSfeKzbYHHj8PJUYXR+c5a4qcuD
QtwOhxgr84HOyuVssHMeKpx7eMLAF46RFSlG5Qwr5VQeee2Rlz7TG8tg8oIHXllM
eO10yFYMhHn7r2w+ti4NBmGtQ0umAUDuU0NWwjY01vtZ7puVQGPqJjFAACzWhrDM
Cf69LPITgVibEger2JvY7kxu4imJTg2lTUHlp71YOAdafU9cYQE3NDRdc1KnEyId
7tswj5hCjpbZXR186e/h7WhvBCaKggl/N16SFhHQU7947yuKlKIZ2vYZeQxjCSQt
IiIfPD61lDtnyKDn2nv3aODLStzmeg==
=pt8i
-----END PGP SIGNATURE-----

--YACCkNcH7AcOjKIe--


