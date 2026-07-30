Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D850C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpXqK-00028l-KF; Thu, 30 Jul 2026 16:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpXqI-000280-Dy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wpXqH-0002YF-3r
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 16:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785445137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPVcbKltiVJqsYpM+lP07ITg2sCgh23u4SrWCBij99M=;
 b=I7uYyywDYZy9Fd6niEUQ7kteU4JyMuwFa71p2biSdkgDc0vJEwMkSxCP9QyX6FbJpOAK+k
 q0Ww/89K3QO0Sl38agsE6WLgkHDCMtoEVopYw01BlvazPxb7hCW6KBMupZ06qsGYDwLunM
 yrFoyxEuw9bJgQgkl8ZYFrHZMxXWS18=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-YRsZpa7WPQGl-lT2z5d6VQ-1; Thu,
 30 Jul 2026 16:58:54 -0400
X-MC-Unique: YRsZpa7WPQGl-lT2z5d6VQ-1
X-Mimecast-MFC-AGG-ID: YRsZpa7WPQGl-lT2z5d6VQ_1785445132
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BF47195609E; Thu, 30 Jul 2026 20:58:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.217])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9B5918004AD; Thu, 30 Jul 2026 20:58:51 +0000 (UTC)
Date: Thu, 30 Jul 2026 15:13:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL 0/3] Linux user patches
Message-ID: <20260730191340.GA8617@fedora>
References: <20260729205902.3767-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="92TQFZpZX8XooZ1Q"
Content-Disposition: inline
In-Reply-To: <20260729205902.3767-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--92TQFZpZX8XooZ1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--92TQFZpZX8XooZ1Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpromQACgkQnKSrs4Gr
c8g/hAgAj92AYaR0UKIKN2nig/74e8AfvIInOJSaAHLOUoAU3QsHOVHm/j1V5Ov5
1fFUGh9Gc6TxV+p046icZv0TrBdShu9gZ5HUmCd3Pf8Enp5eQ6Alc7r2DJAHNUUY
zcI8ReaKmibABI76mJFyMQbXQvRD/UF4SaB66ACI+84CJOAnzvKv7OzGM1DKQRbU
E2jpnBlFHepB6N6CulPQUjEPwIZex43vH9qyRCevXz6XOxntDKjgFcpUNAmFlQPT
ICiorcVRH3qWHzWw5wQpmFEJQQrloePKt6/xJ4KDMa0KGZxChV/s7Chdy6Gv5DQv
d/eaNQl5EEbEMolkOxPiE42AFvIgTw==
=cfFM
-----END PGP SIGNATURE-----

--92TQFZpZX8XooZ1Q--


