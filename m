Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4709ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XtD-0003Zk-1f; Wed, 08 Oct 2025 13:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6XtB-0003ZQ-Fx
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6Xt3-0001xy-Nm
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759944210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1s14lP7x/DCfMMjy1DR0mcaE7DDk+B3XLcHJubEnWEg=;
 b=FY1Bk2nYh47rv7foL0Y0UaCn7rHuEr/hzqmCEotwIMyd76r6Q317swrCEHCOUUy2VaPmaa
 z+acEF2rFz1/UqyTJjUNj8u1KLb7M/IszVKV907g+7n/W1XknTcGxGX1hONfSPWcPYyAfw
 ormv7pNHbueKo3qrZveNAjtIkZMvE2k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-Wb_qg3rqOMWCbvDYxXASmg-1; Wed,
 08 Oct 2025 13:23:29 -0400
X-MC-Unique: Wb_qg3rqOMWCbvDYxXASmg-1
X-Mimecast-MFC-AGG-ID: Wb_qg3rqOMWCbvDYxXASmg_1759944208
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE2E18002C1; Wed,  8 Oct 2025 17:23:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E49BB19560BC; Wed,  8 Oct 2025 17:23:26 +0000 (UTC)
Date: Wed, 8 Oct 2025 13:23:25 -0400
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
Message-ID: <20251008172325.GA181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3PagkpawiRdYagkh"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--3PagkpawiRdYagkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:39AM +0200, Paolo Bonzini wrote:
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

Here are my thoughts:

- Type annotations are probably not copyrightable. Although I think AI
  output contributions should be allowed for non-copyrightable work, I
  understand the slippery slope argument. Also, at QEMU Summit the
  consensus was to give it some time and then revisit the AI policy next
  year. I think we should stick to that so that the QEMU community has
  time to consider other scenarios involving AI. Then we can make a
  policy change next year that combines the new items that have come up
  rather than making a series of shifting policy changes over the coming
  months. That will make it simpler for everyone to understand and
  follow the policy correctly.

- Markus pointed out why generating them automatically may not result in
  the same quality as manually-written annotations because the AI
  doesn't have the context that is missing from the code itself. It's
  the same reason why generating API docs using AI produces something
  resembling documentation, but it consists of obvious stuff apparent
  from the code itself and not the context that only the author can
  communicate about the intended use of the API. The difference between
  manually-written type hints and AI-generated ones is probably less
  significant than with API documentation though, so I think they are
  sufficiently valuable and high quality enough to merge.

Stefan

--3PagkpawiRdYagkh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmng0ACgkQnKSrs4Gr
c8jyKAgAqD+7kDA3JumyUrTWgRKHsXGcOFxUTzaIVUwQOea8T+gMDkRg2GzyfDv2
WsEtoOm/lHDBB6VA/V9011yVQBgylh9p9SXqRgJ6PQpdUZgb//IQ/UV+qJ4Hv1TC
lobrK3V56JmEXOR+Ae03SKwc1wtH6+zfMis6FLlwmwBr2Zhdt/bHias5xERjkC9/
vr2rqkk5Ftc0WJ6cTDsPKFWp6pwyaijWAsDMY0zFz4tct1xp+x1qfgNzzuzuqCRs
10P6bfBnlIxiRbMatR0hsW77R/X3Pw2hWsoGTTCQDuDs830Y4Vv2zAeUYg/fuhon
qpstcExz5K5Kr1XDF2w1ZuuoLoIrxA==
=OuG4
-----END PGP SIGNATURE-----

--3PagkpawiRdYagkh--


