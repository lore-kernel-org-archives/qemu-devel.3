Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4135CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0SK-0008Ri-Lh; Mon, 18 Aug 2025 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uo0SJ-0008RU-6n
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uo0SH-0001hu-IT
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755525798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nk+MhEN7Ea4Vdc/oDnqmeHHxKuRPHEKe2LmFTs2iebw=;
 b=GsK1wZuMRf88iGRGc83bx34C2rW1EV3TaixtfiVvVZM3frk8b+7lviwLipurYg6ATVHhne
 3rfImud2X3BNtL/39QtNDjc9mFUfOOaRpYSa2oip33hyqbEaXEnu7Of62kD4l3UiNsRKVs
 YszUH7eC8S+IuGfwTWcOf+EzuMgAKeg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-bDeI_RpRPBSKuds0dAjGfg-1; Mon,
 18 Aug 2025 10:03:16 -0400
X-MC-Unique: bDeI_RpRPBSKuds0dAjGfg-1
X-Mimecast-MFC-AGG-ID: bDeI_RpRPBSKuds0dAjGfg_1755525795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348D1180035F; Mon, 18 Aug 2025 14:03:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59F9A30001A5; Mon, 18 Aug 2025 14:03:14 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:03:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
Message-ID: <20250818140313.GA7391@fedora>
References: <20250807110806.409065-1-lvivier@redhat.com>
 <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y/vzq+LRRQd8dtr0"
Content-Disposition: inline
In-Reply-To: <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Y/vzq+LRRQd8dtr0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:08:18AM +0800, Jason Wang wrote:
> On Thu, Aug 7, 2025 at 7:08=E2=80=AFPM Laurent Vivier <lvivier@redhat.com=
> wrote:
> >
> > A race condition between guest driver actions and QEMU timers can lead
> > to an assertion failure when the guest switches the e1000e from legacy
> > interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
> > RDTR) is active, but the guest enables MSI-X before the timer fires,
> > the pending interrupt cause can trigger an assert in
> > e1000e_intmgr_collect_delayed_causes().
> >
> > This patch removes the assertion and executes the code that clears the
> > pending legacy causes. This change is safe and introduces no unintended
> > behavioral side effects, as it only alters a state that previously led
> > to termination.
> >
> > - when core->delayed_causes =3D=3D 0 the function was already a no-op a=
nd
> >   remains so.
> >
> > - when core->delayed_causes !=3D 0 the function would previously
> >   crash due to the assertion failure. The patch now defines a safe
> >   outcome by clearing the cause and returning. Since behavior after
> >   the assertion never existed, this simply corrects the crash.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
> > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
>=20
> Acked-by: Jason Wang <jasowang@redhat.com>
>=20
> Consider rc3 is out. Can this be applied directly by maintainers or a
> PULL request is expected?

The commit description doesn't mention whether this fixes a regression
introduced since QEMU 10.0, whether there is a security impact, etc.
In the absence of more information, this looks like a regular bug fix
that does not need to be merged for -rc4.

Only release blockers will be merged for -rc4 (Tue 19 Aug). Please
provide a justification if this commit is a release blocker. Reasoning:
- From -rc3 onwards the goal is to make the final release and adding
  additional patches risks introducing new issues that will delay the
  release further.
- Commits should include enough information to make the decision to
  merge easy and documented in git-log(1). Don't rely on me to judge the
  severity in areas of the codebase I'm not an expert in.

Thanks!

Stefan

--Y/vzq+LRRQd8dtr0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmijMqAACgkQnKSrs4Gr
c8hUywf/VAy5PfEPiPKqzi0pgkLjsMrQ8loioQTeqjH0RR+5Yf4SwHVq3fsETFuX
gFQG+pwTWVPfIqIVDiJLK0hY4727/tKxg7urWpYq2THHnzRgK+YC5tuEpZBc/Z7k
ewAcH5rmNGZk48xXCxeOBZmPhy/UbTNhBdMQG/VQ70aip77qA7FQ37WVffLBmu/a
FsqALI2+EtmQeXt7vVsts3kjkRu9mpSsmMbYcUoaElWysiY/D2rriYqhANCA1t0K
AGw/nWSbS9USMiPJMiYyod+INaxEMEl0tIqocg+BYCIDQ2dUSv6KvroqejhHdGbE
+yyuKQgXVDzfoGNLhBXoA0cc65uSqg==
=fFQh
-----END PGP SIGNATURE-----

--Y/vzq+LRRQd8dtr0--


