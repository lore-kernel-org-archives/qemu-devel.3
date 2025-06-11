Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AB4C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ6d-00065J-JK; Wed, 11 Jun 2025 14:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ6P-0005pe-Cc
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ6N-0000rN-Md
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=evv0iKPX5NZ3UpQRTsEn0zmTWlYDV52gtt05zs7ru/U=;
 b=DIHhC5ZNzb+aaTT4wmUBb9k9OHht/wAjwLJH7W0JTcUbs5dGQAymT5KfOJUsePPSw18K7Q
 1OaVfw+I4okRn6o75d+K08TacztLc9TT/psgbACpLxofPGbIBuZjgFrNUlWpji68xPIwCf
 ht95gelEGqPffmI1KXs9cN6aEpn5Khc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-2h5wjbkIMLimshWU7NF4QA-1; Wed,
 11 Jun 2025 14:23:04 -0400
X-MC-Unique: 2h5wjbkIMLimshWU7NF4QA-1
X-Mimecast-MFC-AGG-ID: 2h5wjbkIMLimshWU7NF4QA_1749666183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97F4180AB13
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 18:22:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D47319560AF; Wed, 11 Jun 2025 18:22:59 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:22:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/27] vfio queue
Message-ID: <20250611182258.GA199085@fedora>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y+mS9zS1O5a6LxRA"
Content-Disposition: inline
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--y+mS9zS1O5a6LxRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--y+mS9zS1O5a6LxRA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyYEACgkQnKSrs4Gr
c8i0bggArwoTkqFKhYGEP0cdbI9zkSk7KAVSFImn6tW9A8ARja6eI8Iq6sgBabD0
eGrZnj2vUhkjTLIkpkevfGbVvLKjQen3cZAOWJVEg0cDJFAsIq5yV/tEnaMfDgNK
7hDMxFfORPAbD5KM+b2zwXGFqTvVs1yGRNFTnXiCRSyAyvtpeC+oIXzplQIu4Gfl
l6GwATVnHImvgxVf5kaucKmyiQ19EQh5a7DPScwW7go+p1TkES1hQoC3nFCyQR/I
HVXULwKbosBAwCqbAwxCHnzk3gFrSBGdy+IKldP/tDNBLQFdml9s8FksdrtcQ1Se
9Y8e3xE11xPstlZ0O8KPkB+R2Se4Vg==
=5z3q
-----END PGP SIGNATURE-----

--y+mS9zS1O5a6LxRA--


