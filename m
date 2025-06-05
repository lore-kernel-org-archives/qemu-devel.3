Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABBCC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFpc-0004Xh-C2; Thu, 05 Jun 2025 15:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFpN-0004X8-Ay
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNFpL-0002ML-8b
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749150031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MiX3C0Q4ypEkN6b9f0PPoJZ5wd5a0y/oZQk5eXk/Cg=;
 b=E8pAP7taBEzpH3N2mRZ+TQYo8ERYHnCrevF9fLH79Ai8qlJ8iC9VkJU4JqYy5WdvhHoHbH
 7IG1PAvYmEbAQnmnB0FCwA4PbmRoQ2f1fcfqH1+/d8x5LPf1GXQVzKNpX+nUBEJzfpdAk6
 l7rEnitGv0rrn8IFwkVvLdWTr5zzYOA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-dheLDomQPkKCeUhUszbcig-1; Thu,
 05 Jun 2025 15:00:29 -0400
X-MC-Unique: dheLDomQPkKCeUhUszbcig-1
X-Mimecast-MFC-AGG-ID: dheLDomQPkKCeUhUszbcig_1749150028
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC2D195608A; Thu,  5 Jun 2025 19:00:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 768611956087; Thu,  5 Jun 2025 19:00:27 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:00:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 00/24] Block layer patches
Message-ID: <20250605190024.GA494844@fedora>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eIpvEDQqVfEyJ7Sr"
Content-Disposition: inline
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--eIpvEDQqVfEyJ7Sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--eIpvEDQqVfEyJ7Sr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhB6UgACgkQnKSrs4Gr
c8jL3Af+KY6FmBHb6mgQthg7pkJgwIhx+W5gxbN5pUdPJm3e9b7KN8eTujZuKVlp
wB8VYjMwwXjM6+vhFdsTrtAArL17pj2rCE7Chq25WIzEjwbz/gMfhjJkhugsYnm8
Dliy07IhblaRYlKYCAbVIVYzDSlahAzc+EjStor1NR6ABLCLjgLl/reBIMRcfUjT
YD8HSQvV9Rr+W7XQUq+jrTCnJUYTfmmwtasaeX+tm/52H4gQHLX8nGsa703DPkzD
43KrJjKNrWFfiFhvdD9ELX9hwlko1gh0GaS3HqLkJpMwhVY0LkNSPctMPEZhLbSW
L8q7hjeBQp5FESWxH/d1ZODN0LzeFA==
=8u8N
-----END PGP SIGNATURE-----

--eIpvEDQqVfEyJ7Sr--


