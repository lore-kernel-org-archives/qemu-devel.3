Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5D1E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 23:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT8M8-0006cP-Ou; Wed, 01 Jan 2025 18:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tT8M6-0006bs-Qw
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 18:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tT8M5-0001O6-D4
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 18:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735774944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n8Dv21GZlypQzWDS1AJDDNMYbYHT7Edmli0UgMVSb4A=;
 b=WmkwZ7YyHEH9lG3YYtdXoaONVnztjudyRedXosi1ALUuvmpbkXApMeU5le1c78vqr9pG96
 F40rs5ppTGUTWFroYdTpvxNklM60nvNSeSizMoPmxu2A5sGPH6e7XPk+329V4pBye9pa7l
 s1X+mnLCHAwkIjMcN8aYLd2luKl2C34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-QnBNiyB0PYOWm-aj8RENeA-1; Wed,
 01 Jan 2025 18:42:21 -0500
X-MC-Unique: QnBNiyB0PYOWm-aj8RENeA-1
X-Mimecast-MFC-AGG-ID: QnBNiyB0PYOWm-aj8RENeA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8C73195608C; Wed,  1 Jan 2025 23:42:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 466CB1956086; Wed,  1 Jan 2025 23:42:11 +0000 (UTC)
Date: Wed, 1 Jan 2025 18:41:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/1] Trivial patches for 2024-12-31
Message-ID: <20250101234150.GA1197536@fedora>
References: <20241231152324.3307386-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qN7YFZd3V6PsFZmd"
Content-Disposition: inline
In-Reply-To: <20241231152324.3307386-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--qN7YFZd3V6PsFZmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--qN7YFZd3V6PsFZmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd10r4ACgkQnKSrs4Gr
c8jeeQf/cuWXWqHBZ08H+7ogY37BkL95Y9C43uPbdsm7XcP7aBCwR4BtI0lN5q4l
u2R3jCjllFeRQsm50h5NXtgMHp+w4+DeOCwoyY8VET/BbAx+II1n/l2CPm6helXV
YDnvyc8uJ1i3ejdleWWkABfgyNggwgNtz2tWyEmSKaJc4lbYdqLq6primxvgscsH
2uSdWaZALku9D0uHF7gI7dj0x00oa/HiPSqYNjTbZOhPYU2clZAYnoUfYNJi5IMK
FdbaBMH134o+ZSnOhBH9dYlTcYFgwqdIjSHYPUlZxST2+VD12lBu+ell77tsnkZ5
fnSt6dqn1MUMUZak3nFH8Fovsn4rJw==
=NTNJ
-----END PGP SIGNATURE-----

--qN7YFZd3V6PsFZmd--


