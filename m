Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9D8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6HV-0006K1-SW; Thu, 21 Aug 2025 10:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6HT-0006Hk-Ra
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6HN-0006h2-Od
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755786515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGGRtk6L8xzUetLZyrzQ7Twz1pf5BLMAFwrHypIWxFk=;
 b=UJY10/Zvv+brCa/Ul3mPqtB2bzIBTu3FKGb3HfLWiwSEwSbORJC/hBzoYEu4kom/6nS5+i
 UGRmMYm8GZRd0QDvQaRz5NfJ8ECqVYKmuWAq4HWVkDMSK3WYE9sCoUb0glkTRmms9oV02F
 1Gis2dbL5k1GcM37LF/eGO/gTXdkG5U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-lF2Cf7oDMzeN-VSvkhfyDg-1; Thu,
 21 Aug 2025 10:28:30 -0400
X-MC-Unique: lF2Cf7oDMzeN-VSvkhfyDg-1
X-Mimecast-MFC-AGG-ID: lF2Cf7oDMzeN-VSvkhfyDg_1755786509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75C64195609F; Thu, 21 Aug 2025 14:28:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD29E19560B7; Thu, 21 Aug 2025 14:28:25 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:28:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 5/7] tracetool: add test suite for tracetool with
 reference output
Message-ID: <20250821142824.GC7010@fedora>
References: <20250819161053.464641-1-berrange@redhat.com>
 <20250819161053.464641-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EUuULvH3hx/MrK7R"
Content-Disposition: inline
In-Reply-To: <20250819161053.464641-6-berrange@redhat.com>
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


--EUuULvH3hx/MrK7R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 05:10:51PM +0100, Daniel P. Berrang=C3=A9 wrote:
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
> to historical reference output kept in git. The test directly
> emits TAP format logs for ease of integration with meson.
>=20
> This can be run with
>=20
>   make check-tracetool
>=20
> to make it easier for developers changing generated output, the
> sample expected content can be auto-recreated
>=20
>   QEMU_TEST_REGENERATE=3D1 make check-tracetool
>=20
> and the changes reviewed and added to the commit. This will also
> assist reviewers interpreting the change.
>=20
> Developers are reminded of this in the test output on failure:
>=20
>   $ make check-tracetool
>   1/6 qemu:tracetool / dtrace        OK              0.14s
>   2/6 qemu:tracetool / ftrace        FAIL            0.06s   exit status 1
>   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
>   1..2
>   ok 1 - ftrace.c
>   #
>   not ok 1 - ftrace.h (set QEMU_TEST_REGENERATE=3D1 to recreate reference=
 output if tracetool generator was intentionally changed)
>   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
>=20
>   3/6 qemu:tracetool / log           OK              0.06s
>   4/6 qemu:tracetool / simple        OK              0.06s
>   5/6 qemu:tracetool / syslog        OK              0.06s
>   6/6 qemu:tracetool / ust           OK              0.11s
>=20
>   Summary of Failures:
>=20
>   2/6 qemu:tracetool / ftrace FAIL            0.06s   exit status 1
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS                             |   1 +
>  docs/devel/testing/main.rst             |  28 +++++++
>  tests/Makefile.include                  |   1 +
>  tests/meson.build                       |   1 +
>  tests/tracetool/dtrace.c                |  32 ++++++++
>  tests/tracetool/dtrace.d                |  10 +++
>  tests/tracetool/dtrace.h                |  59 +++++++++++++
>  tests/tracetool/dtrace.log-stap         |  15 ++++
>  tests/tracetool/dtrace.simpletrace-stap |  16 ++++
>  tests/tracetool/dtrace.stap             |  14 ++++
>  tests/tracetool/ftrace.c                |  32 ++++++++
>  tests/tracetool/ftrace.h                |  73 ++++++++++++++++
>  tests/tracetool/log.c                   |  32 ++++++++
>  tests/tracetool/log.h                   |  57 +++++++++++++
>  tests/tracetool/meson.build             |  25 ++++++
>  tests/tracetool/simple.c                |  61 ++++++++++++++
>  tests/tracetool/simple.h                |  54 ++++++++++++
>  tests/tracetool/syslog.c                |  32 ++++++++
>  tests/tracetool/syslog.h                |  57 +++++++++++++
>  tests/tracetool/trace-events            |   5 ++
>  tests/tracetool/tracetool-test.py       | 105 ++++++++++++++++++++++++
>  tests/tracetool/ust.c                   |  32 ++++++++
>  tests/tracetool/ust.h                   |  55 +++++++++++++
>  tests/tracetool/ust.ust-events-c        |  14 ++++
>  tests/tracetool/ust.ust-events-h        |  56 +++++++++++++
>  25 files changed, 867 insertions(+)
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EUuULvH3hx/MrK7R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminLQgACgkQnKSrs4Gr
c8hKPggAuqxtRJHpHDJb1gWGI/q90Ja0UG6sX7fbE8vY0+T0Gp3MkMaoGndkvFoa
dPAT+sQvKqYt1SlEVBdP9uJyUQHvvyuoc01DnhNRLbGmL34JflH4utpWHN8lmb0B
aAWW8qFLPRgsWmgCn5rYCPCXT2C54wST3Ir+KlYNcIs2ARljDwQ0UOwg8dxFWG8n
cM0438l/pChpI0yiUYFFMUQiyvk0o+o2czcMMFvw101CcwV8y62RlhGZmwgGREMI
M288l9c+i8EIWpPZgDAxw3urjDO+SWyhV0x/J49RtHD6MGWAHRxNNYK9kUeqqAr/
I/9hIRnTnT4N1NkOTmg+aMDrXbvlyg==
=9fpi
-----END PGP SIGNATURE-----

--EUuULvH3hx/MrK7R--


