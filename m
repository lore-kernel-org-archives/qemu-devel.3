Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65489C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFpp-0004am-Iw; Thu, 05 Jun 2025 15:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFpS-0004XR-3W
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFpQ-0002Mp-KF
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749150039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giJOO7XY4XINFVeTv6Ja9PsKCFsnEh81tuJYqyco94w=;
 b=RiylaVjm0R7P7cUezG1UJR7MiShu/3gqqbTrt+tPZHKs5LDbS8sU5PuQBYmTY9eDFoFpwZ
 GuEN5PwG8HfLhhmDry/n4aCttt+PFjOAelpmvCrdfUGP4Rmu9zleEgvyTl+Duom1bdKyQc
 PajD/Zx+qMQNMUm4D3nTJfNHTZBalLY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-YVWS3TO7M3-dKSAhNHbG9A-1; Thu,
 05 Jun 2025 15:00:37 -0400
X-MC-Unique: YVWS3TO7M3-dKSAhNHbG9A-1
X-Mimecast-MFC-AGG-ID: YVWS3TO7M3-dKSAhNHbG9A_1749150036
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 677B01800361
 for <qemu-devel@nongnu.org>; Thu,  5 Jun 2025 19:00:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 921731956087; Thu,  5 Jun 2025 19:00:35 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:00:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/16] vfio queue
Message-ID: <20250605190034.GA495072@fedora>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vl8ArqAbb6xJ7M1g"
Content-Disposition: inline
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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


--vl8ArqAbb6xJ7M1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--vl8ArqAbb6xJ7M1g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhB6VEACgkQnKSrs4Gr
c8h3fwf+OOAe2t8trQyBaaAxxdzO5V2UaCR3RVTg8pIXU+DvEafPyMBdFZTEuho4
rE/Vv2kvfpoxmq2PLK00sY1dXzayZnq7oZp/Kxq5YB1dQeYTS87aDRXD4KNfSH4l
bDL/NpSSsgBzp1bQziFthiYy+PZzrxHco1zR6iiSPGASBjdmtbBDC0VeJn1oMP/N
VquvZ+DFL7SJ1GenfhKI54jj0GtYYbc/8wG2BLeomJrlzvZv1gYtRvyE4lVeIMge
RrLKsl6b4Ccp7ztTUw31ROLi5SIasr3ayNl4r674VigqvZGT8TJOx41Wa7Z983w7
Ai4fRufcGOUoJY5uKzpasOU6GtwB3A==
=sPcC
-----END PGP SIGNATURE-----

--vl8ArqAbb6xJ7M1g--


