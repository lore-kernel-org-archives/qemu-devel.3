Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE2C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 17:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Sjg-0004gn-CS; Mon, 28 Apr 2025 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9SjP-0004SS-4X
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9SjN-0001cE-77
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745863044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlUYwXiNYhBFSWIGO5nE4kOcVgbKmIIRRwvjfI7EGvA=;
 b=ifSgzx/uQQjCxHIxsPqDJkhRxXMp6pBfBC3K/6/rXWyNMzn23J0ZjbRor/Y0NY6/jffJPQ
 PDl1vbmpwA/Dst+5RgjTajyWhHfSJLSDiLqC+CMWCPydrrnK21FyzCBr5wAzuaPvnulMp8
 s5Zt6tLVVDdQPEwaN/1cOsu1Kq8lFWo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-H2_YKnpqPHa_-bxyK-KtoA-1; Mon,
 28 Apr 2025 13:57:02 -0400
X-MC-Unique: H2_YKnpqPHa_-bxyK-KtoA-1
X-Mimecast-MFC-AGG-ID: H2_YKnpqPHa_-bxyK-KtoA_1745863021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91611956068
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 17:57:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E37F180045C; Mon, 28 Apr 2025 17:57:00 +0000 (UTC)
Date: Mon, 28 Apr 2025 13:56:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/50] vfio queue
Message-ID: <20250428175659.GA634479@fedora>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RDKANbzPNMgYrmez"
Content-Disposition: inline
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--RDKANbzPNMgYrmez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--RDKANbzPNMgYrmez
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgPwWsACgkQnKSrs4Gr
c8i2Swf+KOrKts97VT7/iwZG3SxLto7ZxLz6O/b4jy/cFoo3TIOCD8f6P5ibhC2h
oarwgEHLnizFPyHasRMerhEm6wLrpd3WB40wP1N2Bo0gp1B3kpiQQwN0dPkCMczy
HAuUAl3B6DsVgLiNxm8bY6B48M8wcjq5MACsZaL61b0cFCBKb7y2ONdCaHde8JIm
A8S8iTkPJIGPuScjgx5E/VrYilN19fcnpNiiTk1UGpXRimGboMihdehdXHg5U8TU
PsDEUIQUjAp+/yn++irkhwpeiA7dWSI1XeUdpJfyjbMrbDw2GaIm9gkfHJdb16Tq
nTw8/c8Y8leukPAKw+c5wKF+/W1eJg==
=/La9
-----END PGP SIGNATURE-----

--RDKANbzPNMgYrmez--


