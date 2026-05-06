Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F94CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKh2q-0001xf-40; Wed, 06 May 2026 14:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKh2p-0001xU-0c
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKh2m-0002ZU-7E
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778092340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WK9qRyujHVSc1KEJlsY2jggqZIwybqubb0k7aT9moOc=;
 b=FYPEKh5ANPkE9UAaEQXIVh9YoStLXbjrE/1RVFEITzCmcm3cTDE3++rvQOJLMMMp6sI3UE
 dnqUq6nYScpftEjU3bjmyTSgmk/3rHMFp6s9BIXTOH8be3jfWKdfHzpjY5N1TdxOJoYoOZ
 qfh7wVVU5W3b54hBJpnz2er8scSI1Xc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-45LtOBWcMUOtAh-GSltsaw-1; Wed,
 06 May 2026 14:32:17 -0400
X-MC-Unique: 45LtOBWcMUOtAh-GSltsaw-1
X-Mimecast-MFC-AGG-ID: 45LtOBWcMUOtAh-GSltsaw_1778092336
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCAC819560A2; Wed,  6 May 2026 18:32:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F12F300019F; Wed,  6 May 2026 18:32:15 +0000 (UTC)
Date: Wed, 6 May 2026 14:32:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PULL 0/2] Build system: add stubs per target
Message-ID: <20260506183214.GA209372@fedora>
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
 <CAPMQPEJMDp=9TgXvKPYhGDbyiePz6Q7RLycWDsUxG3SyR8gHog@mail.gmail.com>
 <20260506170818.GA203585@fedora>
 <fdf34d9e-75aa-43b0-a70c-9ea59e4a3902@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="itLR8uCA3kJpxMGm"
Content-Disposition: inline
In-Reply-To: <fdf34d9e-75aa-43b0-a70c-9ea59e4a3902@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--itLR8uCA3kJpxMGm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 10:45:07AM -0700, Pierrick Bouvier wrote:
> On 5/6/2026 10:08 AM, Stefan Hajnoczi wrote:
> > On Wed, May 06, 2026 at 05:16:21PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Hi Stefan, Pierrick,
> >>
> >> On Wed, 6 May 2026 at 16:42, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >>>
> >>> On Tue, May 5, 2026 at 7:07=E2=80=AFPM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> The following changes since commit a85c588d07f8d3345ccad38b22026569a=
04571d1:
> >>>>
> >>>>   Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/arm=
bru into staging (2026-05-05 10:11:49 -0400)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-202605=
05
> >>>>
> >>>> for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c=
38e:
> >>>>
> >>>>   target/arm: define stub library (2026-05-05 16:06:00 -0700)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Changes:
> >>>> - [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier=
 <pierrick.bouvier@oss.qualcomm.com>)
> >>>>   Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-=
pierrick.bouvier@oss.qualcomm.com
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Pierrick Bouvier (2):
> >>>>       meson.build: define stubs library per target base architecture
> >>>>       target/arm: define stub library
> >>>>
> >>>>  meson.build                | 22 +++++++++++++++++++---
> >>>>  target/arm/meson.build     |  8 +++-----
> >>>>  target/arm/tcg/meson.build |  2 +-
> >>>>  3 files changed, 23 insertions(+), 9 deletions(-)
> >>>
> >>> Is this a pull request for Paolo's build system tree?
> >>>
> >>> I'm not merging this directly because I prefer to follow MAINTAINERS
> >>> so it's clear who sends pull requests for each subsystem. That way
> >>> maintainers won't be surprised by me merging a pull request from
> >>> another contributor who is not officially the maintainer and it's also
> >>> better for security.
> >>
> >> I did not notice Pierrick's PR and actually included these 2
> >> commits in my latest "single-binary" pull request:
> >> https://lore.kernel.org/qemu-devel/20260506135524.20617-1-philmd@linar=
o.org/
> >=20
> > That can be fine, sometimes changes are cross-cutting or part of another
> > sub-system (e.g. ARM target) even though they touch files a different
> > subsystem.
> >=20
> > My concern is only about the pull request process. Please don't send
> > pull requests with a new tag/branch name that is not in MAINTAINERS. No
> > PR has ever been merged from Pierrick with a build_system-* tag and he
> > is not listed in MAINTAINERS for Build System.
> >=20
> > This could be a sign that something in MAINTAINERS needs to be changed
> > or it could be a sign that these patches should go through another tree
> > (Paolo's or yours).
> >=20
> >> Pierrick and I are simply reviewers on the "Build System" topic,
> >> but it happens that I send patches there where they are related to
> >> the overall single binary objective, and I see Pierrick as a co-mainta=
iner
> >> in this area. However there is no clearly defined MAINTAINERS
> >> section, we happen to touch build system related files all over
> >> the tree.
> >=20
> > I can't accept random pull requests, even from regular contributors.
> > Patches should go through subsystem maintainers listed in the
> > MAINTAINERS file. This way we can be sure that only commits reviewed by
> > a subsystem maintainers are merged and reduce the risk that malicious
> > pull requests are merged (while I trust Pierrick, it lowers my guard if
> > I'm accepting random pull requests from anyone at all).
> >
>=20
> That's totally my fault here, sorry.
>=20
> I have been assuming that "Build and test automation, general continuous
> integration" was by extension integrating build system, but it seems
> like it doesn't. I would not dare sending PR for an area I don't
> maintain officially.
>=20
> As well, in the past, Richard integrated some of those patches on build
> system for single-binary, but I appreciate that he's definitely more
> legitimate than me for pulling these kind of patches.
>=20
> Philippe and I will remove those patches, and I'll ping Paolo to let him
> pull this instead.

Including the patches in Philippe's pull request is probably fine as
long as they are not something that Paolo needs to review. Sometimes
files outside the subsystem are touched in a pull request and that's
okay.

My concern is only that each pull request email series should come from
someone listed as maintainer for that area. For example, if I send a
migration pull request and then Peter or Richard would probably be
confused because I'm not the maintainer.

Stefan

--itLR8uCA3kJpxMGm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7iS4ACgkQnKSrs4Gr
c8iCTQf9Grarwp1L1wbJuPyp83yIIdEmJwVq1VFvM2OSY0nkCvTWUVaJoW5xzKYd
ymvv0dOB7yWwOuDSJUz7CJneugjZXeRiCDhoTkpOSBN25zmEngEP9eu0JtqNuJki
Y0HnyA/hzLI0W+rO8vQGHcL9fzRCGpYEokZOB00kftTfsah8Um/WldWPy69x5MXE
XT1hU0XzWVQCsZJYopNwaIvIBhlm6osW564PZWQcYXJWE/WMu+XuVbCwpGtR0dt4
yrImEkUQHVtNrV/JvHQJpHuxWI/HJwyXufuIvuXSWaZYPfL5rx0NYNV/URnsNoHs
zGF9MbGoMQbgUR+BH9YGHqVnEhUZ6Q==
=deHA
-----END PGP SIGNATURE-----

--itLR8uCA3kJpxMGm--


