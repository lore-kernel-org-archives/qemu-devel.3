Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336E3CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 17:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKfjf-0000QW-17; Wed, 06 May 2026 13:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKfja-0000QE-6h
 for qemu-devel@nongnu.org; Wed, 06 May 2026 13:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKfjX-0003h3-LI
 for qemu-devel@nongnu.org; Wed, 06 May 2026 13:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778087305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3kXKB7xFBoUaqrspvOTg58ODH9HAvZ4Et8NKC0kXNQ=;
 b=BPnELGOfEzi9bPi/LRgUPyby2QndUgE0OtZSDnZXL/AuUeAnhUcfyOTsdP9RCaAgfPUtbu
 enkTUEFCy7ESddsQ9U3Kv00NWTsBBPffadxw304W3xzvJ3z7ayJVzSPtGrl3K3ObKqdiFI
 J4S1v8b7QV9KI4plcmMn/VwMHp5HhTk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-z9SARbRmNwqucZrHwvKKww-1; Wed,
 06 May 2026 13:08:22 -0400
X-MC-Unique: z9SARbRmNwqucZrHwvKKww-1
X-Mimecast-MFC-AGG-ID: z9SARbRmNwqucZrHwvKKww_1778087300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83B8018005BF; Wed,  6 May 2026 17:08:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BB6D1953947; Wed,  6 May 2026 17:08:19 +0000 (UTC)
Date: Wed, 6 May 2026 13:08:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PULL 0/2] Build system: add stubs per target
Message-ID: <20260506170818.GA203585@fedora>
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
 <CAPMQPEJMDp=9TgXvKPYhGDbyiePz6Q7RLycWDsUxG3SyR8gHog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i7INrcEqfFORku5F"
Content-Disposition: inline
In-Reply-To: <CAPMQPEJMDp=9TgXvKPYhGDbyiePz6Q7RLycWDsUxG3SyR8gHog@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--i7INrcEqfFORku5F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 05:16:21PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Stefan, Pierrick,
>=20
> On Wed, 6 May 2026 at 16:42, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Tue, May 5, 2026 at 7:07=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >
> > > The following changes since commit a85c588d07f8d3345ccad38b22026569a0=
4571d1:
> > >
> > >   Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armb=
ru into staging (2026-05-05 10:11:49 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-20260505
> > >
> > > for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c3=
8e:
> > >
> > >   target/arm: define stub library (2026-05-05 16:06:00 -0700)
> > >
> > > ----------------------------------------------------------------
> > > Changes:
> > > - [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier =
<pierrick.bouvier@oss.qualcomm.com>)
> > >   Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-p=
ierrick.bouvier@oss.qualcomm.com
> > >
> > > ----------------------------------------------------------------
> > > Pierrick Bouvier (2):
> > >       meson.build: define stubs library per target base architecture
> > >       target/arm: define stub library
> > >
> > >  meson.build                | 22 +++++++++++++++++++---
> > >  target/arm/meson.build     |  8 +++-----
> > >  target/arm/tcg/meson.build |  2 +-
> > >  3 files changed, 23 insertions(+), 9 deletions(-)
> >
> > Is this a pull request for Paolo's build system tree?
> >
> > I'm not merging this directly because I prefer to follow MAINTAINERS
> > so it's clear who sends pull requests for each subsystem. That way
> > maintainers won't be surprised by me merging a pull request from
> > another contributor who is not officially the maintainer and it's also
> > better for security.
>=20
> I did not notice Pierrick's PR and actually included these 2
> commits in my latest "single-binary" pull request:
> https://lore.kernel.org/qemu-devel/20260506135524.20617-1-philmd@linaro.o=
rg/

That can be fine, sometimes changes are cross-cutting or part of another
sub-system (e.g. ARM target) even though they touch files a different
subsystem.

My concern is only about the pull request process. Please don't send
pull requests with a new tag/branch name that is not in MAINTAINERS. No
PR has ever been merged from Pierrick with a build_system-* tag and he
is not listed in MAINTAINERS for Build System.

This could be a sign that something in MAINTAINERS needs to be changed
or it could be a sign that these patches should go through another tree
(Paolo's or yours).

> Pierrick and I are simply reviewers on the "Build System" topic,
> but it happens that I send patches there where they are related to
> the overall single binary objective, and I see Pierrick as a co-maintainer
> in this area. However there is no clearly defined MAINTAINERS
> section, we happen to touch build system related files all over
> the tree.

I can't accept random pull requests, even from regular contributors.
Patches should go through subsystem maintainers listed in the
MAINTAINERS file. This way we can be sure that only commits reviewed by
a subsystem maintainers are merged and reduce the risk that malicious
pull requests are merged (while I trust Pierrick, it lowers my guard if
I'm accepting random pull requests from anyone at all).

Stefan

--i7INrcEqfFORku5F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7dYIACgkQnKSrs4Gr
c8j8lQgAwruSoni29UKDlSsuT8d0SCGWigmmpKpT5qMRZKo4j8Z2HmnntjndzaAk
0qg4hnWSWqbMB8Kk4Ir53MPf4mMiulIfyxtnk/8TVmnoFUJNvVcwxC8CEHMjLmNs
CUEvZtL8O5slpPE5T80LTroF8XYpIsYbFCFZJD4agRG4RKu8rkhZigtlm4p3lLmm
NPI6y8FwR8pwRMp9VAfa0eP7t3KkQK0PCyg2i8H+ubQSZV7VPz3FM17ufztrTvdg
RHgcnawxoYApzRyDXiGErID6UiYqEzD0fvOJGraYR5/MtWH0djBk08F4re/2pLnz
14qV/6gc9WiYmyLbIKoQOjQ6ptUbNA==
=tuMn
-----END PGP SIGNATURE-----

--i7INrcEqfFORku5F--


