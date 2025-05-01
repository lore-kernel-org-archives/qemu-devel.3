Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7BCC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXnp-00060v-Ng; Thu, 01 May 2025 13:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXno-00060R-Cz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uAXnm-00059n-RW
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746120865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mRnG5SEleQfLfuRe7vzUo2wRnk/X4L5vgFlDB3Z2Mrs=;
 b=cbD6jLuxhrY1iFszZw+dqnIAU/F0i15fRCfIKiRZYccI1TOH4FgSmkJSnmI+SQd9BVUdUd
 kwEWerWlz4mN9CwOS54tz84SRdAh3n9Fd8yttaiBysM2aS0RxY8InVSFDp3+pQx1nMQIGX
 4otSf9X2Jx70BkMIRIn1IGC+bTBLzag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Mid0vIBZO-axDCtB8-SsKw-1; Thu,
 01 May 2025 13:34:22 -0400
X-MC-Unique: Mid0vIBZO-axDCtB8-SsKw-1
X-Mimecast-MFC-AGG-ID: Mid0vIBZO-axDCtB8-SsKw_1746120861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EF1A1956094; Thu,  1 May 2025 17:34:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF48119560A3; Thu,  1 May 2025 17:34:20 +0000 (UTC)
Date: Thu, 1 May 2025 13:34:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 10/11] tests: Add iotest mirror-sparse for recent
 patches
Message-ID: <20250501173419.GF99177@fedora>
References: <20250425005439.2252467-13-eblake@redhat.com>
 <20250425005439.2252467-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ehSHft0qe3ZAk6h"
Content-Disposition: inline
In-Reply-To: <20250425005439.2252467-23-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--9ehSHft0qe3ZAk6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2025 at 07:52:10PM -0500, Eric Blake wrote:
> +TEST_IMG="$TEST_IMG.base" _make_test_img 20M
> +$QEMU_IO -c 'w 8M 2M' -f $IMGFMT "$TEST_IMG.base" | _filter_qemu_io
> +
> +_launch_qemu -machine q35 \

Does the machine type matter? This test would be more portable without
q35.

--9ehSHft0qe3ZAk6h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgTsJsACgkQnKSrs4Gr
c8gMdgf/TLhniLy8hYNl1pshh1/NNa8t443v/nInZDkLB92BmKlVJJEDE/xvtbei
QijU3m1k1UtvGP79VTz7esUcqPdpNYLMVn+4L9eRgWrY4m57SPydhpdgjSqZXPgI
3c2xqVIJNRg4KMptXS5d5+Ta9vjK12tx5fxf8mLSAhkKQgrbCmlGAosup6KmCGpW
hUMK+8SofL/0oJX+8SauOJYEqhkUcBQyDF5iK60XopYot/h97vr9Ru7Z3BGYLGgs
wxWZkrMXLeCJHMVDFU6jPBAaa0RCp0Z2QSKCQD5QcBtmkPTo7027FgjPG1RGe+Od
/c9Mk8UwTePk9hI6RNiU90/C8wY5Hw==
=rR+d
-----END PGP SIGNATURE-----

--9ehSHft0qe3ZAk6h--


