Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D30C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPeb-0007FJ-Gd; Mon, 28 Jul 2025 11:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPeA-000612-4X
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPe5-0008Ao-Ou
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/9mdkJiaEIu48KKBXZB3x0p0llX29VqyVZbeuMhXWRA=;
 b=aLNo5ISyw//eeiztGifwU59v9Lse+DMz97Qo75FWa7+nkAwtI/7dgku9OC8RZtP1ACQyBq
 3cM2XBqKwlRnPU8mMy4UvckOqpFp4WX2rd+fCBPUczjRshFs74NrxNtt4uigfKdJ5pIrhz
 gAuzFEFAgdcqsxtfJPkLjLKvEXuhKY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-lXoTGFbCPCOKHF7Gmrj0Vg-1; Mon,
 28 Jul 2025 11:20:03 -0400
X-MC-Unique: lXoTGFbCPCOKHF7Gmrj0Vg-1
X-Mimecast-MFC-AGG-ID: lXoTGFbCPCOKHF7Gmrj0Vg_1753716003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9852D19560B1; Mon, 28 Jul 2025 15:20:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAF1119560A2; Mon, 28 Jul 2025 15:19:59 +0000 (UTC)
Date: Mon, 28 Jul 2025 11:19:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL for-10.1 0/1] Trivial patches for 2025-07-25
Message-ID: <20250728151958.GA71237@fedora>
References: <20250725155504.2409-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6QuUkPfvkHQ1VTLL"
Content-Disposition: inline
In-Reply-To: <20250725155504.2409-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--6QuUkPfvkHQ1VTLL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--6QuUkPfvkHQ1VTLL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiHlR4ACgkQnKSrs4Gr
c8hseAgApYB+nVBCj3fuG4Yc1PJKnPmwMe95nXoxzQdDABhfBYkYK8DS+javlkpU
mNbfdppUNxn2MExl3OPCZuumH+oEUR99lMUZrYuVZDeaxbylP2WN3OS48V5IlucO
f9pg86OrTOU0ZUSxqjtMW3SAItbg89WjaIFum6D1eFd7m1ScrNApsLQzO3U9hG/G
2Hs5dfP/8dPyVQzy+H/mpgsWa0A+m7RE7wy11ct7sboahJazG1JpMNFongR4AEDb
BidlqWZKfDW8+7A1VQgafiXEDurNDOn/9lm0pR3TqiJqr7SjUfcbu7tUSBM8NNaU
JpjWHzMERyT/X+VcxEn6exOK9ZgeIg==
=fSj1
-----END PGP SIGNATURE-----

--6QuUkPfvkHQ1VTLL--


