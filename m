Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D25CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUoob-0003RX-OF; Wed, 03 Jun 2026 12:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUooC-0003KS-5I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUooA-0006ms-Jv
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780505469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5C3O4XMGh3GV4eFm7SD1CCeGdG1Mywb1rSG48u/vzY=;
 b=hKKL/taIIHRvCQcZi2iZj+EMyVMGRrw+YeYpzCudYZrQ1uMCqSwJ15+AIJYXbMQUMTu7ga
 Jdp3IADucM3VHUW1oPrOtPfEHtzrhMmVseLRanl0m7uSbI2DTkn1RySIAeD1U5OE5VLIht
 ygBNGLoukmJ3mzOR8GwhjqH2KwSIa3c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-VgJgyRe8MPKbeOAk3PHmmQ-1; Wed,
 03 Jun 2026 12:51:06 -0400
X-MC-Unique: VgJgyRe8MPKbeOAk3PHmmQ-1
X-Mimecast-MFC-AGG-ID: VgJgyRe8MPKbeOAk3PHmmQ_1780505465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F44319560AA; Wed,  3 Jun 2026 16:51:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5220180049F; Wed,  3 Jun 2026 16:51:04 +0000 (UTC)
Date: Wed, 3 Jun 2026 12:51:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] util/envlist: fix prefix-match in name lookup
Message-ID: <20260603165102.GD59214@fedora>
References: <20260520212628.479772-1-den@openvz.org>
 <266801b3-c127-422b-be48-d898a944deca@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MyyNPsY09yT+3MMR"
Content-Disposition: inline
In-Reply-To: <266801b3-c127-422b-be48-d898a944deca@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--MyyNPsY09yT+3MMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:24:48AM +0200, Denis V. Lunev wrote:
> On 5/20/26 23:26, Denis V. Lunev wrote:
> > A bug report against our downstream tree turned out to have its root
> > cause in plain mainstream code: envlist_unsetenv() does a prefix-match
> > lookup that drops the wrong entry when one stored name happens to be a
> > prefix of another. The downstream symptom is specific to our setup and
> > isn't interesting here -- the underlying lookup mistake is the part
> > worth fixing, and it is reachable from a normal qemu-user invocation
> > through the -U command-line option, so the fix belongs upstream.
> >
> > Patch 1 fixes the lookup: each entry now stores its name length at
> > insertion time, and a tiny helper compares with explicit length
> > equality plus memcmp. envlist_setenv()'s self-search was accidentally
> > safe (it included the '=3D' byte in its strncmp window and that '=3D'
> > served as a boundary) but is converted to the same helper so the name
> > boundary becomes a structural property of the entry rather than a
> > property of its byte layout. Without that, the two sites can easily
> > drift apart again.
> >
> > Patch 2 backfils test coverage for util/envlist -- there was none --
> > in tests/unit/test-envlist. I verified that the regression case
> > (envlist_unsetenv("FOO") vs. a stored "FOOBAR=3D...") fails against the
> > pre-fix code and passes after the fix.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >
> > Denis V. Lunev (2):
> >   util/envlist: fix prefix-match in envlist_unsetenv() name lookup
> >   tests/unit: add test-envlist covering setenv/unsetenv name matching
> >
> >  tests/unit/meson.build    |   1 +
> >  tests/unit/test-envlist.c | 196 ++++++++++++++++++++++++++++++++++++++
> >  util/envlist.c            |  19 +++-
> >  3 files changed, 212 insertions(+), 4 deletions(-)
> >  create mode 100644 tests/unit/test-envlist.c
> >
> ping
>=20

Thanks, applied to staging:
https://gitlab.com/qemu-project/qemu/commits/staging

Stefan

--MyyNPsY09yT+3MMR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmogW3YACgkQnKSrs4Gr
c8iY9wf9EPRnd4QCbfCUmq8ETlnTj+gDiSde2zDIyiwFtTbUOaOwUxsiGdYbDFsq
E1afI64ivf5gG4gn3xYIDV4BwWP72g4zDA0GvxolCy1wWn8dWummElhUQ+afzfyR
z0i6mEdOReFgXXoHy212OFiDVo5EOwUtqR2OwiAfoOWuBJ2cyqIHEOvPlUOlnVdC
co/091P9hA3PqJCJmTHoQBcQcp6ZNzd7Dh0UybDNyeSWegmaUZzVCTKuvwCXPhln
oiSHZ2naYSP8cYtREPw6JpHxmplSyyv8tpks8cW9lKeRCfp/FPsfytPWxFQrhfjM
FiHAW2/NlGctaUfVBDN5dQgQpdcFaw==
=ygW4
-----END PGP SIGNATURE-----

--MyyNPsY09yT+3MMR--


