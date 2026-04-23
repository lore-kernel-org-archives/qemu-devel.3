Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571C7F589D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFunP-0001Sm-A8; Thu, 23 Apr 2026 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunF-0001RB-S4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunE-0004Ba-3K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776953552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WbAUK6Vu0bmzP2vKK+jPR7AobPBkpHHR1xDqF/37MRg=;
 b=KoHvY5RhHsZl8FOcwy4mHxhlQoeRNL0mcuysuQXhQU2xJEllTn/zVgBBWs+quloN8U8jNz
 z4yqJPLKRVRcJ6VS9gnsOXV0m6x+LCvhkkD3TdJJhFHhkp5a1Iu7B+KMHGb2K2iK11iw3i
 u5BXCRO5r2ytCqkEmZBKWhA1+hPna+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-NwR2ROqFPTGqvTgNDRzeAg-1; Thu,
 23 Apr 2026 10:12:30 -0400
X-MC-Unique: NwR2ROqFPTGqvTgNDRzeAg-1
X-Mimecast-MFC-AGG-ID: NwR2ROqFPTGqvTgNDRzeAg_1776953550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD8CE19560B7; Thu, 23 Apr 2026 14:12:29 +0000 (UTC)
Received: from localhost (unknown [10.44.34.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66D741943295; Thu, 23 Apr 2026 14:12:27 +0000 (UTC)
Date: Wed, 22 Apr 2026 21:03:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/14] vfio queue
Message-ID: <20260423010321.GA517351@fedora>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cTTeeLlXfqE6wdc5"
Content-Disposition: inline
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--cTTeeLlXfqE6wdc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

--cTTeeLlXfqE6wdc5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnpb9gACgkQnKSrs4Gr
c8jsKAf5Afwt6spqWKt9wX9kRABDYZGHFEE3P7RKL27hT023R/y6KZaj0r38RNES
aF9PbH0KYUarjStx4jiMgJtm2gOdsShXSzIaiYSO0XG0AxpNOK8bEWb0RFeNLvcl
aSod2ndDj4NxNCkkJYFWpHlfjjsrE0mWymJ83MXGRze7si1JD68WWvAW/y29gFoo
8cupS+lXN2oRfn7Jf16lgiuizJPuwDwnssI/o9jspirwjseh00C7qvtCTuZ4cd3z
gHr1qTOhewtbI/fNIMW4RWVjVkWC/CmvoueJxlRIeAjs5R+jM2T0MFUQL5VY2l8f
QlkAMMAKSbPNPbPJR4fwaCr7uyX2ew==
=EQnq
-----END PGP SIGNATURE-----

--cTTeeLlXfqE6wdc5--


