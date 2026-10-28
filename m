Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE483606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKSmybh6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7OA-00058a-Nz; Wed, 28 Oct 2026 13:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7NV-0004jR-Qx
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7NS-0004z4-GS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793208231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xveKo9rJHCrBQxGXKA6dwrZ7gnrPNH0x3Yw0t9YbERc=;
 b=FKSmybh63XPdnWSkXwulubfzDVMkDlBmZt2Xdet6bOgmHLpyCyAfmPK3jHs6fxidWBzRGL
 DWjxLH9wUB0tPCuS1VqCRVlbADPxBpv/Ryijh3lrFsTHv1LtMZwQHiqzQ49GDO4quv0mzU
 40J6AUb+CBTnE9lZNNsb46hDWPmK6NM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-PyXHJ8_7PeibyyvyC0eJ5A-1; Wed,
 28 Oct 2026 13:23:47 -0400
X-MC-Unique: PyXHJ8_7PeibyyvyC0eJ5A-1
X-Mimecast-MFC-AGG-ID: PyXHJ8_7PeibyyvyC0eJ5A_1793208226
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A46D91955DC3; Wed, 28 Oct 2026 17:23:46 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62131195608D; Wed, 28 Oct 2026 17:23:44 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/2] Misc fixes for QEMU Guest Agent (2026-10-28, set 2)
Date: Wed, 28 Oct 2026 19:23:40 +0200
Message-ID: <20261028172342.96036-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:

  Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-10-28-2

for you to fetch changes up to e8953bf0be6f4399d1333f92db41e4d146f754af:

  qga/vss: fix provider handling of snapshots (2026-10-28 18:51:22 +0200)

----------------------------------------------------------------
qga-pull-2026-10-28-2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEwsLBCepDxjwUI+uE711egWG6hOcFAmriKGQACgkQ711egWG6
hOe4MA//QPrZFrDOa3y9qZFvFavMBxRgvLB2ebvwLiIeFSdw8PVo2Vt5x2PbLBgV
z64IK7SIr9XI6kw+XC/a4gG4RjpS7zmBVixCqKwOD9YBwLFKA7SkqCl/jEe1IlFG
krLIga/wEc3a1VVo1UuExEIHBERmeWy/JPJm8FT6DamiVnN9JS/kf5iCID2KsCG8
QMHWpBEOgyQDQqbDnmPuoxfGytuSFLtwF9QXF+bobWQ3xUPipuLnMam+2hIhKv8n
oaoWyCFGPyLq9pc6kqnSrS+0R6nrOuHF+oZyju6oQa5hUUXU7TWk5qZs30lxZNNR
DPqFtky0nsb8FbUfLhhoEZIgzQsiUpstt7RSXvLP0giHwdrsZvapzPUntQA8cSH0
moCiuJOnztB313nw3848kE9RQLmnV9En2BI5Yeb60A9t8q7xWn6sfLJjD3xmwYn2
FPyap7DplIqnT5unD/0g4moT5lc+rNdw+75JWSQUtnPrqMxVDXRajee0eufe1GjG
t4LLt1o2zJkB5t+qHtUi2gGU3/M8SEj8DRSy1aJsJI0cz37hiHEL3q7lTx1UXzL7
H9twj/ZQkF+7RupqMK2EFuNIhIlJ+xsT8ZU/5K+f3z1zOpPKLIvnQEBEi1VlZTOF
+qpPuBV2tM6C3CIXYdNrSaHAcQDWTg0eWhIeBPH0KVeKWPod/NA=
=0YyQ
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Marc-André Lureau (1):
      qga/vss: fix provider handling of snapshots

Roman Bogorodskiy (1):
      qga: do not run hwclock(8) on non-Linux POSIX OSes

 qga/commands-posix.c        |  14 ++++
 qga/vss-win32/install.cpp   |   1 +
 qga/vss-win32/provider.cpp  | 200 +++++++++++++++++++++++++++++++++++++++++++-
 qga/vss-win32/requester.cpp |  26 ++++++
 4 files changed, 240 insertions(+), 1 deletion(-)

-- 
2.54.0 (Apple Git-157)


