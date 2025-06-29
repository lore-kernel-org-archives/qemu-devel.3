Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8F4C7EE30
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 13:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVrzs-0001nJ-MK; Sun, 29 Jun 2025 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVrzq-0001n2-MU
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 09:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uVrzo-0008SU-Q8
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 09:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751203378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VEMJGb+6CQtMX4SpgOwK+JcWK4D4m72t9nsePicQjDs=;
 b=XtXNOb9kUJzLvJorU7yuK4fK1H6NZL3AcDc7XIieZ5HTJcgGcxDxFF8G/x+e7fh5OyhhM0
 2zAGafJtnZJl9dOCezAtZoCi4gM+NUlWB/R/TeGJtC9EKEpHcyAwvPPFDDvUzrj3jyI8pO
 Pt5KGJyCX4XoRjnNtDjqOrnQykoL68c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-qXnjHWPZMZ6rESyu49xkJA-1; Sun,
 29 Jun 2025 09:22:54 -0400
X-MC-Unique: qXnjHWPZMZ6rESyu49xkJA-1
X-Mimecast-MFC-AGG-ID: qXnjHWPZMZ6rESyu49xkJA_1751203373
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16DA1954215; Sun, 29 Jun 2025 13:22:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.16])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B800D19560B2; Sun, 29 Jun 2025 13:22:51 +0000 (UTC)
Date: Sun, 29 Jun 2025 06:58:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk
Subject: Re: [PATCH] trace: log.py: human-readable timestamp
Message-ID: <20250629105842.GA187790@fedora>
References: <20250626195514.366177-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mVNb6vN5xOiCfCAF"
Content-Disposition: inline
In-Reply-To: <20250626195514.366177-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--mVNb6vN5xOiCfCAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:55:14PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> So tired to parse all these timestamps, when need to compare them
> with other logs.
>=20
> Use iso8601 format as in warn_report() (info_report(), error_report())
> already used.
>=20
> Also, start line with date, to be similar with warn_report() as well.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/tracetool/backend/log.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--mVNb6vN5xOiCfCAF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhhHGIACgkQnKSrs4Gr
c8iwTwgAlfbmGLHBvwYC7iMLQkWMZ/JU59QdG7N7MXcfMfYFjLDOz07os+yRM16Q
qmdzwtoCeShT/gBRpPA+6Gn3jikL0ngztl8o4bUc5MhA8GYpUtvGZqh2n9JtLeHW
McxhKyXbuB76lJTjWwumwxCRjnT6/1YTN2V1waXTvReNlBLKlX009mxGMwvQzmfs
tp3Mnwix2g1IKHjc5HbqEa86pR7b3GNdmuPbD3E8rCbTlQDWWxZdni1xcW0QKYo2
Mp/akqxmFFmXS5C2qQnxLFfEPVah/VN8LcrdercP+Q6EaUNL/2bfatE/7OdvIfNs
PZN9Gw8W9Q+JgrHO//1YjDARrIXwLg==
=Ixg6
-----END PGP SIGNATURE-----

--mVNb6vN5xOiCfCAF--


