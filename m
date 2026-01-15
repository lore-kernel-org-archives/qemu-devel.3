Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E256AD46627
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVXZ-0000Ae-N2; Thu, 15 Jan 2026 17:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vgVXL-0008Te-QI
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vgVXK-0007sB-2P
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768514987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loO0rZE3FDoZlq//LYOix3Z9yCYq+iTPHwh9qQF1fpo=;
 b=YoES2hCk/VGhp9QG8DwXJubyT3Pv0YJixiVuo8yMYpFI7phpYqn9gHyUOYcH2kkIlKdTdz
 r6c9UtTnbYp3hraQxpc3ferDGHWijquTbE5syXHfYZofTFMZC1AnFfo8DeYKA5r5c7WAMn
 +3vJsvJ5WxRdq95YkS3uKU5KknbGCas=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-oM_VkrDdNFefGbpxsJ4YsQ-1; Thu,
 15 Jan 2026 17:09:44 -0500
X-MC-Unique: oM_VkrDdNFefGbpxsJ4YsQ-1
X-Mimecast-MFC-AGG-ID: oM_VkrDdNFefGbpxsJ4YsQ_1768514983
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B512619560B1; Thu, 15 Jan 2026 22:09:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.134])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE48619560BA; Thu, 15 Jan 2026 22:09:41 +0000 (UTC)
Date: Thu, 15 Jan 2026 17:09:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
Message-ID: <20260115220935.GA674111@fedora>
References: <20260115180123.848640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZIqsFPo65eo6Q10G"
Content-Disposition: inline
In-Reply-To: <20260115180123.848640-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--ZIqsFPo65eo6Q10G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 06:01:23PM +0000, Daniel P. Berrang=E9 wrote:
> Informally we have approximately three groups of platforms
>=20
>  * Tier 1: fully built and fully tested by CI. Must always be
>            kept working & regressions fixed immediately
>=20
>  * Tier 2: fully built and partially tested by CI. Should
>            always be kept working & regressions fixed quickly
>=20
>  * Tier 3: code exists but is not built or tested by CI.
>            Should not be intentionally broken but not
> 	   guaranteed to work at any time. Downstream must
> 	   manually test, report & fix bugs.
>=20
> Anything else is "unclassified" and any historical code
> remnants may be removed.
>=20
> It is somewhat tricky to define unambiguous rules for each tier,
> but this doc takes a stab at it. We don't need to cover every
> eventuality. If we get the core points of view across, then it
> at least sets the direction for maintainers/contributors/users.
> Other aspects can be inferred with greater accuracy than today.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>=20
> This came out of the discussion about recent unnoticed breakage
> in NetBSD builds and what maintainers are expected todo about
> it (if anything)
>=20
>   https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02543.html
>=20
>  docs/about/build-platforms.rst | 152 +++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZIqsFPo65eo6Q10G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlpZZ8ACgkQnKSrs4Gr
c8g7cgf/e18a5KOMuBuZhM8C0mO/Bd47ANmajqWLdqmyTKpNRSI+UoXlGiXT5HAG
r2kCykvJNwGVQybDi3UQ6WorzQzgX5uq9zPKWsL1bnVgByyxGqz+kain8uOiXkbd
U4zlkeYoVcagWT99qswzS8Gz57c/q5cnhiBqAo2Jk9pQ40pgsCVwHc+pbrkoslFs
cs5Tm3Ig11w1ex8cUms0NUUlC2/ivqDMzEEYjYGFAfAOjleOc/iE1Hjot3KJP5UO
K16sSF3HoRWQOfYF4z6QmhLqzuDEJED2OL/l9WvbVfX9tBkruMTgvYsXGlQHqjSF
QUlEymJuuG7buHHUeaufMBdJrGOrnA==
=Iv0s
-----END PGP SIGNATURE-----

--ZIqsFPo65eo6Q10G--


