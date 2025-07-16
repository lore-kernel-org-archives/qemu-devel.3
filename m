Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1Vr-0000yV-HX; Wed, 16 Jul 2025 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1QZ-0005kM-8b
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uc1QS-00089k-3U
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752669592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dPPrzZBLhGlmVmXvWyvyx0EsYhilbUGir6fa9dF9kAA=;
 b=EudNx/7DQmKPFMC0F2cyzH22euZcLceNs6ENSwJqln7OTFWBd0iBBn/i6/rfO2zOkPThNg
 vOYwSygCRuqn+nXiwXmGlL71o8PAmkKo7f126jfq591c9Lrbt7v8cHT+VORFzdviyaYq64
 u2OsE8ZX6mgg+N8gke5SGYc/kl8dhZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-CodkkOfVMcm7t3UvDiy7FA-1; Wed,
 16 Jul 2025 08:39:51 -0400
X-MC-Unique: CodkkOfVMcm7t3UvDiy7FA-1
X-Mimecast-MFC-AGG-ID: CodkkOfVMcm7t3UvDiy7FA_1752669590
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3159E1956048
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 12:39:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7D3C1954213; Wed, 16 Jul 2025 12:39:49 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:39:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL V2 00/16] Net patches
Message-ID: <20250716123948.GA328058@fedora>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aPcjQERlRfU40/16"
Content-Disposition: inline
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--aPcjQERlRfU40/16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--aPcjQERlRfU40/16
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh3nZQACgkQnKSrs4Gr
c8gFYgf/demKPBOquM7gJz1baDzbgLBGY6RNH7tYdpZCG0pN2ROWCkmKd3SA/vHO
6o3F3Ztk11SccnvMKB+JtgBUflCYXjTboxWJG+yjoLY4dWZrX84Tg4HAYqg8Pwai
vvLV0Qvkw6J1EmIjk3pCq11ziCQMkrn0r3ab4jo2GELSYDpIoZQ2dlyVc8s22BZa
VnIfy/wRKI2MjD5j8P7kbNKynYNOWGm+Af3Xec36rQ6CeA85iGKubYDwVuJHPBst
2TLrRPX1wVge88s/BKFQQ0kUhU7FPe/YL33hgPZlkREky4tZ5NHrctNjSyH7aym8
UK7Ve7ph84FxMJsl3OFpatpBSdbwSw==
=esVf
-----END PGP SIGNATURE-----

--aPcjQERlRfU40/16--


