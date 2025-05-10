Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5872C3ABC9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 18:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDp4u-0002xj-IY; Sat, 10 May 2025 14:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4k-0002om-KS
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4i-0007dn-MX
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746902246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwFEh6TeQ/8H51vJTIhIozvJpz7tQ/a2+PVeDJq/CUE=;
 b=c3vckzzOoSDvIyFaBzUMSGm71LUaEQPEiOUZkYVGvK9cS/aFymbRfiYTlO7+QTgpBDk+Sx
 xLjcBrUiOXf/cGtzNjob/NOc4EXwiWzNJUMsHItvaL0PyrlP6f5cXI7aiKS3b+P1cN46tp
 pSi29UlBLFuqu6vxlUqkwk1wbvj0lYk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-RsyE8OITNZmsNK-Eh3G34g-1; Sat,
 10 May 2025 14:37:23 -0400
X-MC-Unique: RsyE8OITNZmsNK-Eh3G34g-1
X-Mimecast-MFC-AGG-ID: RsyE8OITNZmsNK-Eh3G34g_1746902241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B83180035E; Sat, 10 May 2025 18:37:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9D9F19560B0; Sat, 10 May 2025 18:37:19 +0000 (UTC)
Date: Sat, 10 May 2025 14:35:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, sstabellini@kernel.org,
 anthony@xenproject.org, paul@xen.org, alex.pentagrid@gmail.com,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: Re: [PULL v1 0/2] xen: mapcache: Fixes
Message-ID: <20250510183530.GA116869@fedora>
References: <20250506182647.302961-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/i3kukPHmWcJP39C"
Content-Disposition: inline
In-Reply-To: <20250506182647.302961-1-edgar.iglesias@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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


--/i3kukPHmWcJP39C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--/i3kukPHmWcJP39C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgfnHEACgkQnKSrs4Gr
c8j8tggAvnRrQweJgUw6K7reSq12P9b9XzUcjumibOgBBolATBPlplHyEtE9ACvB
NRsd6Bs/yfcCpKc8elPDC0jhrWC/Ii9d/a7xOLpSJpb4X6Jvmvl2LIC2IYmbMQ7x
zJGZuKSQ39p8RqpHQbS8Lc7vM83susWIiV6o6N0ErjvCUbQ/0h5iCCd4t0GPszWE
tT/7YXlCnpdR/S4e7E9W51+JKdD+r+rgFayQjvZb+oJZaMkB3u6laSeGkbicsWh4
JgDmRN6jagWI03mSTK111WVYR40uXtKVxEKCHxCMQzE3YLzGvFcS567KLMuRLfIQ
oWxSrz3tDIpJLDUdKz31VOHzLm6y/Q==
=+iw6
-----END PGP SIGNATURE-----

--/i3kukPHmWcJP39C--


