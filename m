Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C011BC83F1D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 07:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaqpQ-0004YF-Px; Sun, 13 Jul 2025 03:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnb-0001pE-FW
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uaqnZ-0007Ej-VK
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 03:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752390417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXnJPVI8JTlohJeUz97PRuVjbR/byS/CW9CiZKRo3zE=;
 b=dAITQcTP5V3iWzh5zoLFj9dtbbn2Nqeb4ln7TMmZ8gaarRYMdZM8k0v+hVX1EtnF+725V0
 1htCPLLD6HFwsTa6JFCUSo/LXT0ffzrSJ95TyUWElvFQrgNdbs1KoC4M/cjIEfwL9hvqzU
 mgOG+diGjpG5GtX/EXGvgw4NThyn8eI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-jCoMnnWOOyqUTDn6tXxYgQ-1; Sun,
 13 Jul 2025 03:06:55 -0400
X-MC-Unique: jCoMnnWOOyqUTDn6tXxYgQ-1
X-Mimecast-MFC-AGG-ID: jCoMnnWOOyqUTDn6tXxYgQ_1752390414
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72CB51801BD8; Sun, 13 Jul 2025 07:06:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B251956094; Sun, 13 Jul 2025 07:06:52 +0000 (UTC)
Date: Sun, 13 Jul 2025 03:06:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/26] Migration patches for 2025-07-11
Message-ID: <20250713070650.GA204759@fedora>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LJVPrUEj+hDrbYk/"
Content-Disposition: inline
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--LJVPrUEj+hDrbYk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--LJVPrUEj+hDrbYk/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhzWwoACgkQnKSrs4Gr
c8grNQgAmB3q654H3+jXIhPoBly2ewD9uFGC2FlnZARj3RT2MNDMmOqvUxDJbht9
znQIWaX7vYyRvur/c952j+PBKbHN6+OQ5zYosraGDxaVNlA1r6IxqayKYjKgJXd9
GjRl/nZ4vzkswUcqTdxu58qSCQYc7Ru41Wb3eeSZpSBWTuhtlxMW++so6YYHGLJh
EcMo/Q0kGfm5MPM2xQMhXfcZ1UnmrMhyTw2iSNKfr9AXnQb/nDQ+/ouGcPCdO3ga
UBlrwZJNAjbAd4sL0bxuf+VeSXP8iOuUMQkfTBorAtGRZUryTM0HPXQ8tQ6Yus2m
xGNyfpcB0Mimt/oTLJBLzFZpt/+sZg==
=ak/I
-----END PGP SIGNATURE-----

--LJVPrUEj+hDrbYk/--


