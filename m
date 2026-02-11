Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01422EEA84A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbol-0003u5-QT; Thu, 12 Feb 2026 13:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqboj-0003sv-E7
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqboh-0003y7-JN
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfdxI7fh1Qx0VviEcIb3Ckv/uWuMSVDXKkrH6I76EQk=;
 b=T9hkVBxCpiP+M55R9VDN1vo3rqVZVqXeHE8RC1v/7jAUZtgxD2ubo6Px9iKGncmbjPBOgf
 4qfSIfX7JlxKTS9I2Da2tTLPKM6+iY0NlKDkUnwPM0sn9g1by9yu/iNkV3aVI0udnJBScw
 x7vI1KvV37cxjLR0WfK5tKXtTy4wki8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-N88FZ-iPNFGza6oxsqZ24Q-1; Thu,
 12 Feb 2026 13:53:26 -0500
X-MC-Unique: N88FZ-iPNFGza6oxsqZ24Q-1
X-Mimecast-MFC-AGG-ID: N88FZ-iPNFGza6oxsqZ24Q_1770922405
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A52BE180025C; Thu, 12 Feb 2026 18:53:25 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 507EE18003F5; Thu, 12 Feb 2026 18:53:25 +0000 (UTC)
Date: Wed, 11 Feb 2026 15:00:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20260211200031.GA234094@fedora>
References: <20260210201454.177202-1-stefanha@redhat.com>
 <CAFEAcA_jXEr1E+CP7C=Q0tkDQYkhkc3ccXRykYzgN7jw2spr5Q@mail.gmail.com>
 <aYyeY8Vu1W5gnCNw@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8AcHqtCWw7xkwni5"
Content-Disposition: inline
In-Reply-To: <aYyeY8Vu1W5gnCNw@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--8AcHqtCWw7xkwni5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 03:21:07PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Feb 11, 2026 at 03:12:18PM +0000, Peter Maydell wrote:
> > On Tue, 10 Feb 2026 at 20:14, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > >
> > > The following changes since commit 0b91040d23dc8820724a60c811223b777f=
3bc6b7:
> > >
> > >   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong71=
5/qemu into staging (2026-02-10 09:12:38 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> > >
> > > for you to fetch changes up to 80c15bcc5eb6d30abf90b2fd120cdf01f6ed20=
82:
> > >
> > >   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=3D1 support (2026-02-10 =
14:47:14 -0500)
> > >
> > > ----------------------------------------------------------------
> > > Pull request
> > >
> > > ----------------------------------------------------------------
> > >
> > > Stefan Hajnoczi (1):
> > >   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=3D1 support
> > >
> > >  tests/tracetool/tracetool-test.py | 24 ++++++++++++++++++++----
> > >  1 file changed, 20 insertions(+), 4 deletions(-)
> >=20
> > This change seems to use some Python construct not supported
> > by all our platforms. CI job failures due to the tracetool tests
> > failing:
> >=20
> > https://gitlab.com/qemu-project/qemu/-/jobs/13074647460
> > https://gitlab.com/qemu-project/qemu/-/jobs/13074647473
> >=20
> > Traceback (most recent call last):
> >   File "/builds/qemu-project/qemu/tests/tracetool/tracetool-test.py",
> > line 121, in <module>
> >     with tempfile.TemporaryDirectory(prefix=3Dsys.argv[4],
> > TypeError: __init__() got an unexpected keyword argument 'delete'
>=20
> Yep, that's too new to rely on:
>=20
>   https://docs.python.org/3/library/tempfile.html#tempfile.TemporaryDirec=
tory
>=20
>   Changed in version 3.12: Added the delete parameter.
>=20
>=20
> since this is just a debugging aid, perhaps only set the 'delete' param
> when we know python is new enough, and don't bother trying to make
> QEMU_TEST_KEEP_SCRATCH=3D1 work on older python

Thanks, for tracking this down. I'm going to drop the patch.

Stefan

--8AcHqtCWw7xkwni5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM398ACgkQnKSrs4Gr
c8j5Pgf7BD3kqyuaFoQGOd2PPSK84JV6bTPiUnjAE0nHhvKhKdnlWCdvhdxJT9+t
iwyZXFqhPAu5+8kKeU2fqmA0UKxeJ5YDSdUjyivuDHbrYbdMwjfH7nnMHYlTC81z
pSshc1M0ltKMTe+dwE4AqYciXdk0pMDrtkHS5zSWIbPBLylGieyNXa/VjxIr6dJP
Y2CL8spH1M56vmq5yPBHBl7DovIZ+02wpDLThQ2EfaGMW6JHtL65Ux7sMKvo84Tl
rYXtJUL0NJhBWmdNqBdW7BFxGcrkgqJWG8WhKpYlu/LrrMvDPchkZhvAbY4WHULj
FU6V1cY0c4kyHHQT/W8qH8z+3vOAqQ==
=+FCL
-----END PGP SIGNATURE-----

--8AcHqtCWw7xkwni5--


