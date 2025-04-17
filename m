Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73759C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 20:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WGW-0004pb-S0; Thu, 17 Apr 2025 16:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WGU-0004kN-LC
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WGT-0008HE-1d
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 16:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91VGUSZeI+aabfESXFqSVL9xoQGOCc71fbbpdViRqh4=;
 b=EHIcOEZP/7NFqwXQGD12dZTCRCaG0VeF470r96oMvvIitKMThyQx3QZ1k1tcrNll9+gSnQ
 L4xZ0i9GkOelR4PQjPlhN5J7LnWPE4tPwQn5HqkbsKzLxp4YYYcqztlexzAwQjt5/3+xdt
 5aD/GQtbVlDEAxi5+ZkFO0w7tvAE8rs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-jvtxja51PuewGTBGJYd-3A-1; Thu,
 17 Apr 2025 16:55:13 -0400
X-MC-Unique: jvtxja51PuewGTBGJYd-3A-1
X-Mimecast-MFC-AGG-ID: jvtxja51PuewGTBGJYd-3A_1744923312
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 495A719560AF; Thu, 17 Apr 2025 20:55:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81EC180047F; Thu, 17 Apr 2025 20:55:11 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:55:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 10/11] tests: Add iotest mirror-sparse for recent
 patches
Message-ID: <20250417205510.GI85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RrPDBfZLfhB+NY6m"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-23-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--RrPDBfZLfhB+NY6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 01:39:15PM -0500, Eric Blake wrote:
> Prove that blockdev-mirror can now result in sparse raw destination
> files, regardless of whether the source is raw or qcow2.  By making
> this a separate test, it was possible to test effects of individual
> patches for the various pieces that all have to work together for a
> sparse mirror to be successful.
>=20
> Note that ./check -file produces different job lengths than ./check
> -qcow2 (the test uses a filter to normalize); that's because when
> deciding how much of the image to be mirrored, the code looks at how
> much of the source image was allocated (for qcow2, this is only the
> written clusters; for raw, it is the entire file).  But the important
> part is that the destination file ends up smaller than 3M, rather than
> the 20M it used to be before this patch series.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/tests/mirror-sparse     | 109 +++++++++++++++
>  tests/qemu-iotests/tests/mirror-sparse.out | 153 +++++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/mirror-sparse
>  create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RrPDBfZLfhB+NY6m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBaq4ACgkQnKSrs4Gr
c8ji8gf/YGUompPBTJBVfb+AUyv5cglwZTQz0xAFnB58oIIPmWiG65U8SyHSu5Mr
k4L5d+9l6KNf07VbB+7h6jfkyHMBjfgaJG29HlSWdc47t7qySP2fzbUUqNfS5Aao
4JJTsxMv6hL3HEQQznHfqXFBaF1ir1GdZm8+8JFqLmzxtSiSf/6qfKYh5eahG+1s
HLNNrxZESfWfLRcCtUqdbHNSJWd0fn1A/943LMwSUhagP7i5bdrLeEFmPhJzqzkJ
Q24ASShZtGrvcUX71qMfkNaGCrOaCVegluqXz/4xvWT7WRHRsplKEEUA7+cG4v4Q
GktxWNEsFd3LsmS75IcfpW6Bh9wc0w==
=A5Kw
-----END PGP SIGNATURE-----

--RrPDBfZLfhB+NY6m--


