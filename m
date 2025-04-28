Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FB8C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 17:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9SjE-0004A7-9T; Mon, 28 Apr 2025 13:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9Sj3-00045C-LX
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9Sj0-0001a7-Vf
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745863020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5bdTy8OLmSuU6V5oHMicXnuoYaBNCSP1V3v7KCF5xjc=;
 b=ARa1F2y1xxqLjC5kw4r3dHHYB0MUAvXE+u2tqipGEkFSyhh3XpefYYNfPfgeaHpPRPDLhQ
 qT/luavuH9JKM1u1Kbzw35jr4UMFcMP1rdDDRAZjBr8KULTQSPXOfKTYDjRz8gZ+1wm+wA
 icR01TluJZmHWS02OgbHkemPlozO7/Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-QauTcZNHMHWy2rBFlIh8tQ-1; Mon,
 28 Apr 2025 13:56:54 -0400
X-MC-Unique: QauTcZNHMHWy2rBFlIh8tQ-1
X-Mimecast-MFC-AGG-ID: QauTcZNHMHWy2rBFlIh8tQ_1745863013
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD2DD180120D; Mon, 28 Apr 2025 17:56:47 +0000 (UTC)
Received: from localhost (unknown [10.2.17.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A23819560A3; Mon, 28 Apr 2025 17:56:46 +0000 (UTC)
Date: Mon, 28 Apr 2025 13:56:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Block layer patches
Message-ID: <20250428175645.GA634411@fedora>
References: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qRsPLetdqUehYP3j"
Content-Disposition: inline
In-Reply-To: <20250425175252.316807-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--qRsPLetdqUehYP3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--qRsPLetdqUehYP3j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgPwV0ACgkQnKSrs4Gr
c8j/xwf+JkkZKdccrsyjP2h8P6nbIhECSP5ScA1jrsgpWQOTBO9VOhzYw9TTXXlX
GBCpYytL/Hi3oMNvi71nZ9qhD5be1ZesWCh5UVjy0se562gdNM9rlYJfFa6dMF2M
3PHyUBmjmN/kZqqaAGTcrJDG3qG1UpoHXWmMSaIf1knryn2O6s/xkIytbXelroo4
NS9vkhjOIFF78ODr3pH6y+QI8fSZMZyO15GbeUdg8PbipPasIiVIU6avXpukr05E
kU8GSPDmGeeiSHTsoJXc/v+SFycCxATrPoiseVq4TDsBFrH/dhobShJQqryACqk9
CKLaF7Ops5riztWXWpdCMQXKeVoulw==
=6NAU
-----END PGP SIGNATURE-----

--qRsPLetdqUehYP3j--


