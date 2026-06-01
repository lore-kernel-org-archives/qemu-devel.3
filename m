Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF16CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU83x-0004um-Ge; Mon, 01 Jun 2026 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU83v-0004tS-Vp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU83u-0002wO-1h
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780341152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1bZGVxEXRrstAPErDIeFsKsfbCV0yuX4PpZNArEvY0=;
 b=RzeCPjV4VR+T0G2NK9bc/2UjVf8jaU9pon4pY4Qia5AofDDDGPpWd8qwwUMcrDBLgCxkCW
 BOhy/vuYkioZNJ4TWP/Suys9IoGM0QOruaMnEiXJpybr4tsfP+b86QHFL6so/7iJ42QlaE
 woqgEPZJt5B9AB/uRZMV8l+Jcpt4iVo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-DMjpQw8lMBe1ZnyCqKlvow-1; Mon,
 01 Jun 2026 15:12:30 -0400
X-MC-Unique: DMjpQw8lMBe1ZnyCqKlvow-1
X-Mimecast-MFC-AGG-ID: DMjpQw8lMBe1ZnyCqKlvow_1780341149
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35ADD1956048; Mon,  1 Jun 2026 19:12:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1591D1688; Mon,  1 Jun 2026 19:12:27 +0000 (UTC)
Date: Mon, 1 Jun 2026 15:12:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 0/2] util/envlist: fix prefix-match in name lookup
Message-ID: <20260601191226.GA470697@fedora>
References: <20260520212628.479772-1-den@openvz.org>
 <266801b3-c127-422b-be48-d898a944deca@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDcC4PU2vE3xkW+U"
Content-Disposition: inline
In-Reply-To: <266801b3-c127-422b-be48-d898a944deca@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--qDcC4PU2vE3xkW+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
> > safe (it included the '=' byte in its strncmp window and that '='
> > served as a boundary) but is converted to the same helper so the name
> > boundary becomes a structural property of the entry rather than a
> > property of its byte layout. Without that, the two sites can easily
> > drift apart again.
> >
> > Patch 2 backfils test coverage for util/envlist -- there was none --
> > in tests/unit/test-envlist. I verified that the regression case
> > (envlist_unsetenv("FOO") vs. a stored "FOOBAR=...") fails against the
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

CCing Laurent, Helge, and Warner in case they are interested in this
-user fix.

Stefan

--qDcC4PU2vE3xkW+U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmod2ZoACgkQnKSrs4Gr
c8hPBAf/bIuLr5+BcxK/a8X5qw9Np4unsz8qZWv/rvGdhziKwMYI84496XawAwGn
CtsoLCVo1JM4xdvoqhqS28/amAaISWoUtLNGkdPqRahZS5T8bFTVKJveQV3SFU3J
uWd1Tv9wCjBvemHuvBVYf+oyDa8ecQru8O4/nG8jL6GPz41SL/N/+fReBeUolHl6
lGl8Fl2fdmwr1jTRGGwNOjVurMH0ZI/i0xdKNkIS/cFu8UChjWE/hWZRTTosUw2u
XNF3abqCrH+zvSdib9PHsJEQhIMyeywYjBS6fZ/utZKYQ9qRX1g4o7wqoPYQ7TNP
ur7xzThrE1bzna01BkRAp354MvY/Pw==
=Cqtb
-----END PGP SIGNATURE-----

--qDcC4PU2vE3xkW+U--


