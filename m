Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E850CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 18:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6YYh-0007aK-Ij; Wed, 08 Oct 2025 14:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YYZ-0007Zr-II
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6YYR-00081y-9i
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759946775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bBCgC1Ap4fol/JWZcFp6h0saBjXFyMIzcDO/pFtWzMg=;
 b=XhGeK9VjqvjtCv5ZR8mi4gOweMzFKPM3Y415WM9n1XohacY9ygk5BATVt1whN9TvlHo2uX
 uhMrTmEmhszADd+rGIDIdDrD+5BudL9L90DQ5EGu1DKlly4NwiQL9WLegsvXlOol2s5Gda
 TdcaC4hBiTKkXPJlUfrYHvqsiScuQJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-Ie0_K6U4PDG221lYPTPLRg-1; Wed,
 08 Oct 2025 14:06:10 -0400
X-MC-Unique: Ie0_K6U4PDG221lYPTPLRg-1
X-Mimecast-MFC-AGG-ID: Ie0_K6U4PDG221lYPTPLRg_1759946769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F69519560B0; Wed,  8 Oct 2025 18:06:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9159E1956056; Wed,  8 Oct 2025 18:06:08 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:06:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 1/6] tracetool: rename variable with conflicting types
Message-ID: <20251008180607.GC181748@fedora>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rxzx/uAuRN+dnOwB"
Content-Disposition: inline
In-Reply-To: <20251008063546.376603-2-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Rxzx/uAuRN+dnOwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:35:40AM +0200, Paolo Bonzini wrote:
> "backend" is used as both a string and a backend.Wrapper.  In preparation
> for adding type annotations, use different names.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Rxzx/uAuRN+dnOwB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjmqA8ACgkQnKSrs4Gr
c8hVPggAjihrvvNE9jCqImQbz9Lt5R3IaAmzOHUZUGvpRMxPAiyOURqGblfINpeX
w9OtYkhOEJMwacxNbVJfKRQE/pkAZa08H3NSYr6a6GNN79fSi86C8GIp15PiY6ry
+YfDRpa/nXoCTx6BYmZnjCaxVs5Ovj4jYKAqYE8XrGH26X3gLNkAXxeeoHgHoPLH
2zw15meNNF8UvXQS9Y2Y+08rMwMc4jws0l5TZp5KEGQywsIWgJHrOK4FY8BU8DRo
T/5uAKOTE0bpH1DbwgUGdBLuVTj4L+PG+2znayc2GNEpjdk40pQew84eJNq+awJO
JH7UTFlquHDj5wKVYqPTKWXr+Bnw4Q==
=6ZV6
-----END PGP SIGNATURE-----

--Rxzx/uAuRN+dnOwB--


