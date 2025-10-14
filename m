Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A02CCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92kE-0001iE-1V; Wed, 15 Oct 2025 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92kC-0001hx-GE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92jw-0006b5-Pv
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BokBiYY68P5CZ1Xv8YSoIjXU9RYAKbF/4jQgDGCFQOI=;
 b=OLgOMhSMTvQsHBzcMFzvuv7dHiV7dplfFJNTh+aYnNgGdtB8VM1L5AJgtwUdGqyL0ackUs
 zqbe5InSPElBtXpFxreegm/SV8ujArpcGCkuyLGxNg8qoBAbGjAen6PpdeLfgGJjILcf9G
 EoK9svxip9m3GG5GY2yQCVUOzuZc70E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-Ry8qsE0xPY6q_b6ZMMupZQ-1; Wed,
 15 Oct 2025 10:44:25 -0400
X-MC-Unique: Ry8qsE0xPY6q_b6ZMMupZQ-1
X-Mimecast-MFC-AGG-ID: Ry8qsE0xPY6q_b6ZMMupZQ_1760539464
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BDF11954190; Wed, 15 Oct 2025 14:44:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26EDA30001A1; Wed, 15 Oct 2025 14:44:23 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:02:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI discussion
 ahead!]
Message-ID: <20251014190241.GC18850@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GqHc6SBSe3we1CLD"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--GqHc6SBSe3we1CLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:39AM +0200, Paolo Bonzini wrote:
> [People in Cc are a mix of Python people, tracing people, and people
>  who followed the recent AI discussions. - Paolo]
>=20
> This series adds type annotations to tracetool. While useful on its own,=
=20
> it also served as an experiment in whether AI tools could be useful and
> appropriate for mechanical code transformations that may not involve
> copyrightable expression.
>=20
> In this version, the types were added mostly with the RightTyper tool
> (https://github.com/RightTyper/RightTyper), which uses profiling to detect
> the types of arguments and return types at run time.  However, because
> adding type annotations is such a narrow and verifiable task, I also deve=
loped
> a parallel version using an LLM, to provide some data on topics such as:
>=20
> - how much choice/creativity is there in writing type annotations?
>   Is it closer to writing functional code or to refactoring?
>=20
> - how does AI output for such mechanical transformations compare to other
>   automated tools, whose output is known not to be copyrightable?=20
>=20
> - what is the kind of time saving that the tool can provide?
>=20
> - how effective is an LLM for this task?  Is the required human help a
>   pain to provide, or can the human keep the fun part for itself?
>=20
> While the version submitted here does not use any LLM-generated content
> in compliance with QEMU's policy, the first version was developed using
> an LLM tool (Claude Code) with a very simple prompt:
>    =20
>       Add type annotations to tracetool.py and all .py files in
>       tracetool/*.py.  Use new-style annotations, for example list[str]
>       instead of typing.List[str].  When done, use mypy to find any
>       issues.
>=20
> The results were surprisingly good for such a simple-minded test, and
> while there were some issues they turned out to be mostly due to dead
> code that confused the LLM.  Thus, I removed the dead code (this is
> already in qemu.git) and then did the actual experiment, running
> both the RightTyper script (which is detailed in patch 4) and the LLM
> in separate branches.  The remaining errors from the LLM were also
> reasonably easy to fix, so I did that manually:
>=20
>       tracetool/__init__.py:239: error: Need type annotation for "_args" =
(hint: "_args: list[<type>] =3D ...")  [var-annotated]
>       tracetool/__init__.py:272: error: Argument 1 to "Arguments" has inc=
ompatible type "list[tuple[str, str]]"; expected "list[tuple[str, str] | Ar=
guments]"  [arg-type]
>       tracetool/__init__.py:579: error: Incompatible types in assignment =
(expression has type "str | None", variable has type "None")  [assignment]
>       tracetool/__init__.py:580: error: Incompatible types in assignment =
(expression has type "str | None", variable has type "None")  [assignment]
>=20
> After reviewing the changes, I followed up with another prompt for mechan=
ical
> changes:
>=20
>       Change "backend: Any" to "backend: Wrapper" in all tracetool/format=
/ files
>=20
> Honestly, I could have done this part in less time without any help; I
> was just curious to see if the LLM would also remove the unused import.
> Not only it didn't; this prompt didn't even touch most of the files so
> I did the change, ran isort and called it a day.
>=20
> Comparing the results from RightTyper and AI, both tools benefit from hum=
an
> help: the dead code removal which I mentioned, the small cleanups in patc=
h 1,
> the final manual fixes for the remaining (mostly trivial) errors.  But at
> least in this case, AI is a winner:
>=20
> - it left basically no unannotated code: fixing the above errors was enou=
gh
>   to pass "mypy --strict", unlike RightTyper which needed a little more w=
ork
>   due to its profiling-based nature and a few other limitations (see patc=
h 5).
>=20
> - most importantly, trying various other tools that didn't work, as well =
as
>   figuring out how to use RightTyper, took a couple hours more.  Surprisi=
ng
>   as it was, I could not find any static type inferencing tool for Python;
>   neither pytype nor pyre worked for me.  This is also why I think this
>   is not apples to oranges, but a fair comparison between AI-based and
>   regular tooling.
>=20
> I want to highlight "in this case".  I had other experiments where the
> LLM's output was all but awful, and I wasted time debugging code that
> I should have thrown away immediately!
>=20
> After the diffstat, you can find a diff from this series to the version
> based on Claude Code.  It's impossible to be 100% objective but,
> besides being functionally equivalent, I don't think either would be
> identifiable as written by an LLM, by a person, by a tool+human combo,
> or even by a good type inferencing tool (if it existed).
>=20
> Based on this experience, my answer to the copyrightability question is
> that, for this kind of narrow request, the output of AI can be treated as
> the output of an imperfect tool, rather than as creative content potentia=
lly
> tainted by the training material.  Of course this is one data point and
> is intended as an experiment rather than a policy recommendation.
>=20
> Paolo
>=20
>=20
>=20
> Paolo Bonzini (6):
>   tracetool: rename variable with conflicting types
>   tracetool: apply isort and add check
>   tracetool: "import annotations"
>   tracetool: add type annotations
>   tracetool: complete typing annotations
>   tracetool: add typing checks to "make -C python check"
>=20
>  python/tests/tracetool-isort.sh              |  4 +
>  python/tests/tracetool-mypy.sh               |  5 ++
>  scripts/tracetool.py                         | 12 +--
>  scripts/tracetool/__init__.py                | 84 ++++++++++----------
>  scripts/tracetool/backend/__init__.py        | 21 ++---
>  scripts/tracetool/backend/dtrace.py          | 19 ++---
>  scripts/tracetool/backend/ftrace.py          | 13 +--
>  scripts/tracetool/backend/log.py             | 13 +--
>  scripts/tracetool/backend/simple.py          | 19 ++---
>  scripts/tracetool/backend/syslog.py          | 13 +--
>  scripts/tracetool/backend/ust.py             | 11 +--
>  scripts/tracetool/format/__init__.py         |  9 ++-
>  scripts/tracetool/format/c.py                |  7 +-
>  scripts/tracetool/format/d.py                |  7 +-
>  scripts/tracetool/format/h.py                |  7 +-
>  scripts/tracetool/format/log_stap.py         | 12 +--
>  scripts/tracetool/format/rs.py               |  7 +-
>  scripts/tracetool/format/simpletrace_stap.py |  7 +-
>  scripts/tracetool/format/stap.py             | 10 ++-
>  scripts/tracetool/format/ust_events_c.py     |  7 +-
>  scripts/tracetool/format/ust_events_h.py     |  7 +-
>  21 files changed, 173 insertions(+), 121 deletions(-)
>  create mode 100755 python/tests/tracetool-isort.sh
>  create mode 100755 python/tests/tracetool-mypy.sh
> --=20
> 2.51.0
>=20

Discussion on AI policy (does not affect these patches) and future
cleanups aside, this looks good to go.

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--GqHc6SBSe3we1CLD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjunlEACgkQnKSrs4Gr
c8h5wwf/Q/EdRzKEpwinWcF0pv3yoqZ6lu0TfDqDg2oEdGDeTC65XLPp4pn+OagY
NQuVqOGvUQLyDy8neWuqHXjy1zmU6dA+Ys5XYXAeq3uVulbItA+n4xC4SVWHg6HG
9zoHw7SN23Miz/MgFJnOfG81fZBBPoF9LJ7K4BW/seMwBgMTOw/W6mTVmuOz6XwT
n+iLVrzjSFM+K1lUEJn9pl6D7HhBNbutM+cd521icBeZ2FXbwnNioVLCGdGeqFHX
nnNpP1JBL6uYSAsIJgUliCEbcsNK2dsXLaH+w/5o11QPRbdgOvt1W2wB4aIaLhRa
CZl5LbyDvVJQVMs9DRoOWIW6HWZvxw==
=QQh8
-----END PGP SIGNATURE-----

--GqHc6SBSe3we1CLD--


