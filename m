Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F655C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQwb-00062B-6a; Thu, 30 Jul 2026 09:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpQwX-00060h-J8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpQwV-0005v7-JW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785418618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoVnwZJlubM4ByO+oH4lT4p2iRwlWm/TCyEBUs8QijM=;
 b=WOGyP9bod2X1QxUfUbtQvICjk711t5XMVbI9yTkU5o/lVBTbpuLswseeNWMKruPe/MvOWW
 CXl8+1848/96giHPfzBlyu7FIfdOtm8SDs7iCs/OdmjcRPAiKKJ3EyTfXzrpgrB1imLcYf
 DSJumdea5dtwXGwjC27OKy1BOFm7R4Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-crqjbs6lNNiQ_cDZR1Q4nw-1; Thu,
 30 Jul 2026 09:36:53 -0400
X-MC-Unique: crqjbs6lNNiQ_cDZR1Q4nw-1
X-Mimecast-MFC-AGG-ID: crqjbs6lNNiQ_cDZR1Q4nw_1785418610
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D59A19539B4; Thu, 30 Jul 2026 13:36:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73CB9414; Thu, 30 Jul 2026 13:36:49 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:36:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 7/7] hw/scsi/spapr_vscsi: do not crash QEMU on
 migration errors
Message-ID: <20260730133648.GB1442692@fedora>
References: <20260729231904.775331-1-lvivier@redhat.com>
 <20260729231904.775331-8-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OtAQh+GnUA29mUL/"
Content-Disposition: inline
In-Reply-To: <20260729231904.775331-8-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--OtAQh+GnUA29mUL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 01:19:04AM +0200, Laurent Vivier wrote:
> Currently vscsi asserts on invalid SCSI requests.
>=20
> Fail migration gracefully instead.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>=20
> Notes:
>     v2: New patch to manage vscsi
>=20
>  hw/scsi/spapr_vscsi.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OtAQh+GnUA29mUL/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmprU3AACgkQnKSrs4Gr
c8glkQf/SLZkm+HZzliQR1S/fK89reyhCrwOXkuyYBILc/oEZd1yTwDQNelBW1fs
LCtcWGXxZni6JAoouZT/gSD/RO17g56rGQwfKBdHzITOG8S0md6xSYBT30PcT5PG
Zh+jhjLjpEN6yG1ATSs5aOQCRr5sBX72bEJR2RvaMyOuu4iPqAC6UwTVickL2e78
9hIiK/uapIHOfpkqhKlY6qacjwiC4A1Ah3FDVTi00RNsUvdEMu3pq7h7RLNm0Aso
iQ7wctRWleOf5uv+6I9tFGXmwyrP5OJCwQ+SWcH778tgu+2pGZ7mlP53pTck7liQ
suSJV7GmaS5rx3e0NDksh5i85jVPew==
=fZnL
-----END PGP SIGNATURE-----

--OtAQh+GnUA29mUL/--


