Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E97C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1I4-0007SP-91; Wed, 29 Jul 2026 06:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp1I2-0007SF-7m
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp1I0-00057X-D9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785320007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qS3JlrtRQ9R75QAJxkk6j5PNwsHlt9faBZz4r7EGTK4=;
 b=FAI0WvaV6unw32KtVbEhFxHEJ/aHL8PVU5vcP/Y1xA8GIwNFRaUFngAB+kWUFLjS8wAQIz
 tzfLHZqL6SiZrdChvZdsAAQixZk4vwoCBHxi2tfK40h6GFsbmFnBSRBCvcpqLyam3Qq9wh
 MNfcwK0zqUHYBTY+1uRlY3vjGZeqw7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-4VEN4VPoNLeqru3QXsTDRg-1; Wed,
 29 Jul 2026 06:13:25 -0400
X-MC-Unique: 4VEN4VPoNLeqru3QXsTDRg-1
X-Mimecast-MFC-AGG-ID: 4VEN4VPoNLeqru3QXsTDRg_1785320004
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88AA1195609E; Wed, 29 Jul 2026 10:13:24 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8703341C; Wed, 29 Jul 2026 10:13:23 +0000 (UTC)
Date: Wed, 29 Jul 2026 06:13:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v2 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
Message-ID: <20260729101322.GA1365083@fedora>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L65ydNNB3b9zLfU4"
Content-Disposition: inline
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--L65ydNNB3b9zLfU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--L65ydNNB3b9zLfU4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpp0kIACgkQnKSrs4Gr
c8iZ3wgAoyCnyDrRDWRFi+y1TEVW/jamJUZpZbcxIgf/+hZv47mrmBKM2n5qN4KT
J0PtmQRzkpPnk2pNu7VkKuqrw7+Sw0621U+7i/PrO7XQjOMcYAJYlH3HNzE0Oh6T
bHrbMV+xBwfXnA3psElUXe5A0JQ7bMjBVYAaWiTJWUjQNqlokEmhZAnledz+fgbJ
NhkgNMaCcSlYVYeNM6oAcfje3KgoYkBqErGH9Ga0ss7g0DN/lyq+lXyEEWHOmhyn
z9R00SE1Vk8Aasf6+pt7uzW33f0e8/VWG3ApHYtcVVqQbMEvEY3s8YOEijq/LkYw
DvFa9Minm824nwCQVPbASn0WWUj7dg==
=eEEA
-----END PGP SIGNATURE-----

--L65ydNNB3b9zLfU4--


