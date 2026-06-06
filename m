Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E90CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 22:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVzEC-0007eu-I9; Sat, 06 Jun 2026 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVzEB-0007eG-1J
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 18:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVzE8-0006JQ-UE
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 18:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780783848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmghMrQEhEjXZNtOXFG1SjawJpI2mVWsQlI09frTRdo=;
 b=N9NHi1GP/rBJhoLteVIK4Q+jl3icNkO4Cwb2hVHKtKIyGgOteJ6S58K4pFz4mGHBSAaaqy
 gD7EHy4pUhWZoCnI83mIrIsd2iiJ7YmqbCAmeJO/HBxelxdgYvljl67S0/J5mjI336z0Rc
 EZ/E4mtOPkFYk3RzSL3h1hnH/csQKWE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-Ywax4FvjOqapZXSIXGpDIA-1; Sat,
 06 Jun 2026 18:10:46 -0400
X-MC-Unique: Ywax4FvjOqapZXSIXGpDIA-1
X-Mimecast-MFC-AGG-ID: Ywax4FvjOqapZXSIXGpDIA_1780783845
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CAC9195608C
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 22:10:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97B2230001BE; Sat,  6 Jun 2026 22:10:44 +0000 (UTC)
Date: Sat, 6 Jun 2026 18:10:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [GIT PULL v2 00/23] Fix various QOM object life-cycle issues
Message-ID: <20260606221043.GA365874@fedora>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JvA7B4EMNzyaWofC"
Content-Disposition: inline
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--JvA7B4EMNzyaWofC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--JvA7B4EMNzyaWofC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmokmuMACgkQnKSrs4Gr
c8iGCwgArlXIcTQTsiZZHDX7BWGpiGv1s9jKaB1Kh/ZOSJmDgLmm5/oVnAubEIDZ
ShbUp+ykExzt8/mdxSX3wpinZZU92G104SdVdmIDCkRBae7wcfbbYtCOlpF0ScMO
W+61UArxt/kzUKgbCJmxOby6Ub+2fagcVw52GToQicER/T4C4m4sXTzqNoKk1tlp
OPg8b+RpyUROV55/uOt3DMIsq9UOBfITM/tZj4SsIQ1WhEhv7NFVYj+D95YR1nk/
yTYh8GBP5pPpDvhI98O8ukxNPN3+BKm1AQEUc9XlQ5OJn49JkUVkpE/zx5rpkhia
Zd8H/UFU+8mfZXzRynJnYkZZlbQZOQ==
=yMPK
-----END PGP SIGNATURE-----

--JvA7B4EMNzyaWofC--


