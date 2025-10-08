Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82693CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Ybs-0000BQ-Fo; Wed, 08 Oct 2025 14:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Ybg-00008O-Ee
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YbY-0008GF-TR
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759946974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AAF4ir0VZrFFrCbpH80pnR0lOHaQOAPXNiIyr3X+ClU=;
 b=YWkTLVCUuuZ7r8825ofU7c0t3awa0hAFbdF1WbjHlrufd9R5THEt37wupqGblt3PtPax4Q
 DzROjMTVrHlal7bKekrQU77B7pIFnDvZXbmkSulgU0yRbDMq4DPy7zYwpeybjm1NIwWd6y
 PauHSyTHgsxDkEs1L4dhm9w4MeJKirY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-J0wAm8dlMMGaj33tHQpgAA-1; Wed,
 08 Oct 2025 14:09:30 -0400
X-MC-Unique: J0wAm8dlMMGaj33tHQpgAA-1
X-Mimecast-MFC-AGG-ID: J0wAm8dlMMGaj33tHQpgAA_1759946969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 513311956050; Wed,  8 Oct 2025 18:09:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9B44180047F; Wed,  8 Oct 2025 18:09:28 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:09:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 4/6] tracetool: add type annotations
Message-ID: <20251008180927.GE181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/vKNVEWyu7CD5zU8"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-5-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--/vKNVEWyu7CD5zU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:43AM +0200, Paolo Bonzini wrote:
> Created with a profiling-based tool, righttyper.  I used this script:
>=20
>   python -m righttyper --generate-stubs --no-sampling --overwrite  -- ./t=
racetool.py --help
>   find . -name "*.pyi" | while read fname; do
>     merge-pyi --in-place -b bak.$fmt ${fname%i} $fname
>   done
>=20
>   for fmt in c h rs d log-stap simpletrace-stap stap ust-events-c ust-eve=
nts-h; do
>     find . -name '*.pyi*' | xargs rm
>     python -m righttyper --generate-stubs --no-sampling --overwrite ./tra=
cetool.py \
>       --format=3D$fmt --backends=3Dust,simple,syslog,ftrace,dtrace,log --=
group=3Dtestsuite \
>       --binary=3Dqemu --probe-prefix=3Dqemu ../tests/tracetool/trace-even=
ts outfile.$fmt
>     find . -name "*.pyi" | while read fname; do
>       merge-pyi --in-place -b bak.$fmt ${fname%i} $fname
>     done
>   done
>=20
>   python -m isort $(find tracetool -name "*.py")
>=20
> Running the script took about 5 minutes.  The errors were mostly
> due to misunderstanding the "try_import" function:
>=20
>   tracetool/backend/__init__.py:83: error: Incompatible types in assignme=
nt (expression has type Module, variable has type "tuple[bool, Module]")  [=
assignment]
>   tracetool/backend/__init__.py:117: error: Incompatible types in assignm=
ent (expression has type Module, variable has type "str")  [assignment]
>   tracetool/__init__.py:543: error: Incompatible return value type (got "=
tuple[bool, None]", expected "tuple[bool, Module]")  [return-value]
>   tracetool/format/__init__.py:60: error: Incompatible types in assignmen=
t (expression has type Module, variable has type "tuple[bool, Module]")  [a=
ssignment]
>   tracetool/format/__init__.py:85: error: Argument 2 to "try_import" has =
incompatible type "str"; expected "None"  [arg-type]
>   tracetool/format/__init__.py:88: error: Module not callable  [operator]
>=20
> On top of this I fixed a little weirdness, while leaving the unannotated
> functions unchanged.  Being profiling-based, righttyper did not annotate
> anything not covered by the check-tracetool testsuite:
> - error cases
> - PRIxxx macros
>=20
> It also reported list[Never] for always-empty lists, which is incorrect.
> Righttyper also has a few limitations: it does not annotate nested functi=
ons
> (there were only four of them), or "*args" argument lists.  These are fix=
ed
> in the next patch.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool.py                         |  5 +-
>  scripts/tracetool/__init__.py                | 54 ++++++++++----------
>  scripts/tracetool/backend/__init__.py        | 19 +++----
>  scripts/tracetool/backend/dtrace.py          | 16 +++---
>  scripts/tracetool/backend/ftrace.py          | 10 ++--
>  scripts/tracetool/backend/log.py             | 10 ++--
>  scripts/tracetool/backend/simple.py          | 16 +++---
>  scripts/tracetool/backend/syslog.py          | 10 ++--
>  scripts/tracetool/backend/ust.py             |  8 +--
>  scripts/tracetool/format/__init__.py         |  7 +--
>  scripts/tracetool/format/c.py                |  5 +-
>  scripts/tracetool/format/d.py                |  5 +-
>  scripts/tracetool/format/h.py                |  5 +-
>  scripts/tracetool/format/log_stap.py         |  7 +--
>  scripts/tracetool/format/rs.py               |  5 +-
>  scripts/tracetool/format/simpletrace_stap.py |  5 +-
>  scripts/tracetool/format/stap.py             |  7 +--
>  scripts/tracetool/format/ust_events_c.py     |  5 +-
>  scripts/tracetool/format/ust_events_h.py     |  5 +-
>  19 files changed, 109 insertions(+), 95 deletions(-)

I skimmed through the type annotations and they look reasonable to me:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--/vKNVEWyu7CD5zU8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmqNcACgkQnKSrs4Gr
c8iqwgf/SOPwVBz1vXQNgAGHUZtyXxtKwuZhm9JixcPJ7z/GwKubmWdPNUyynwfS
luQlUS1Gv+vpy3spThuPC9xyPxUipRu388rJhWNPUSLBTNZy1ISjhHzXwtdzL4mp
108qFdaIRgiCvUDAecl8xuf1Iky5zmHba6fUoxm7VzcEyiaYZ/DQYcbXqH3xm+Ng
zwr3sn8xYU2g63YZY5TBL1uWLRIKPn1g4P21+gbkSHygj8Xqn6DHaJ4rE/xY3xNT
KflLuzJObd0KlzxxlVqOy7gvgolfLxIYe0x5LEfwC5BONQ0xNBCIQ4QSlwmLAkDi
42yz2sJZI6sg0x14HLDsNiU4N0Da6g==
=3l5h
-----END PGP SIGNATURE-----

--/vKNVEWyu7CD5zU8--


