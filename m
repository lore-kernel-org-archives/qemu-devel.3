Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F729C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6M9-0004kX-Nn; Thu, 06 Feb 2025 13:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tg6M8-0004kD-8D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tg6M6-0005DN-O8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738865519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H18chP8vcMKJlj1ap3zu93xcG7AFdqv8ktePH07O41Q=;
 b=fv6/njCs0ipFxMebGnsI07dhyQA9vyaXMRL0Sa5YTuuMHIX0aL8/N0vRIk9ZEEL6F3xZZZ
 qXTIWW0+OpJvM141qW6KpkztdEbXz+SkYfJAztsMLJeYYu3qdueRPsIu15t1hNDamC8RL2
 0e3rFP4hVn8Drms1HXLhBlGc57igcgU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-FOUoGwksPsW8wcZ74wmvGA-1; Thu,
 06 Feb 2025 13:11:57 -0500
X-MC-Unique: FOUoGwksPsW8wcZ74wmvGA-1
X-Mimecast-MFC-AGG-ID: FOUoGwksPsW8wcZ74wmvGA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E17F1955D68; Thu,  6 Feb 2025 18:11:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D838D1955BCB; Thu,  6 Feb 2025 18:11:54 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:11:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] block: Remove unused blk_op_is_blocked()
Message-ID: <20250206181153.GB413673@fedora>
References: <20250206165331.379033-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qP1VNw5tG7WZiypO"
Content-Disposition: inline
In-Reply-To: <20250206165331.379033-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--qP1VNw5tG7WZiypO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:53:31PM +0100, Kevin Wolf wrote:
> Commit fc4e394b28 removed the last caller of blk_op_is_blocked(). Remove
> the now unused function.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/system/block-backend-global-state.h |  1 -
>  block/block-backend.c                       | 12 ------------
>  2 files changed, 13 deletions(-)

Nice! This can be merged after my patch that removes
BLOCK_OP_TYPE_DATAPLANE.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qP1VNw5tG7WZiypO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmek+2kACgkQnKSrs4Gr
c8hmNgf/WI2IAJOzp86Ok6q8mOu7TPdz2CHRuAS6W5UEblyGOyHzY0RueHUIW1O/
v6c58UQlADCxRex3ibNS5+VX8lvE+evoaK/TDRpKVLXyK3a/6NilVy7+Q64v/iZi
TRc9De5pw2q+rIJDhmVC+b/AkIsat5ETeR7KnBn7LSIa7lsZGnuzcKZOywGLGksZ
RgAPqeSpGKyGPkJ9ZIFFbBnwlgSqGCciLA+vYi4GIi1H8Vgir6X5TB2oVXEr88H9
vy/E2L/b4QC00kO9rbbrv7VPkHkvGehvSCmHMyhscxZGowEDHPczHdc07Qv8suiR
hkBV69FxDofa+gViTvAaL6ZMaepb9w==
=2fGu
-----END PGP SIGNATURE-----

--qP1VNw5tG7WZiypO--


