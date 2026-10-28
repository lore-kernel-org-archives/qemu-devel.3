Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B660A2637
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wzo+g83m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0Ar-000711-Fk; Wed, 28 Oct 2026 05:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ab-0006rk-OU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0AZ-0008R6-PK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QO/U9nNnY6LziYs+eSpAQh7JltRrb+djP5DsioS1ZuE=;
 b=Wzo+g83m/xL+M99m6SNU8Apv+ap/aYOLfu4IEhjbgs2Y7MNOyQgtmM+FEEs81MZzAdHFVa
 ZRDlADU505ATnkap2N3ZO0f142UDTojFLM/NRU+lmX3epnfgw69HOyNl0XrdKhiFd5EtMi
 PS2bVrWJum6vyMq5E+EAzvvCma/Y8zo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-YNmNyDh_MWi-wUnezi6mQg-1; Wed,
 28 Oct 2026 05:41:58 -0400
X-MC-Unique: YNmNyDh_MWi-wUnezi6mQg-1
X-Mimecast-MFC-AGG-ID: YNmNyDh_MWi-wUnezi6mQg_1793180517
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DFA51800611; Wed, 28 Oct 2026 09:41:57 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D02061956086; Wed, 28 Oct 2026 09:41:55 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/6] Misc fixes for QEMU Guest Agent (2026-10-28)
Date: Wed, 28 Oct 2026 11:41:46 +0200
Message-ID: <20261028094152.14934-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-10-28

for you to fetch changes up to 0ae3840f612ba00330940f26758ae03754f6c6b6:

  qga: implement 'guest-network-get-route' for FreeBSD (2026-10-28 11:21:01 +0200)

----------------------------------------------------------------
qga-pull-2026-10-28
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEwsLBCepDxjwUI+uE711egWG6hOcFAmrhwGcACgkQ711egWG6
hOe52BAApWlo/di5Xm2I5nn5w557gzxCollTjzHRQYFFqvvhTqWqAFO01uE4q09p
O/BJmUeqdvYUm+mX2Q7syduEhCzbwRM0wwfs6GmlxC7JbKYmYNlEAMN/9M9H7XTo
AN4fFq991tDYrQoBPbdAfsa9TIPmN4O1l+WJvrcRFytw4BpRolCqALuX7/Hensq+
ds3wZw4RtVNO/lxymGmggKYPN9HxFi94HPd/+332cqw+sdM39zy/n7oUr24Y6/ph
MSuCIW4AdyOT0Z+FBxUk63OAZba52CXljiJSdK/gO5qcYGmlSZcoMdnAnFEB6FlE
qHUc0J3mbLzmsJCaj+Tt5Nvf4Cdzlg2vv0Smb3BxPp0sWyN8GP5C5AwQqJP0eD/2
r08ZsjqqiYu3bqSeT9y2IBO6kPkIMMS+oLDROjNY1G3gGAhK9a7q6HkEvy1MVSr6
mdxIG4i4FQDwqX3vYu6WhEGHWaPqfJqzHvzBorqfYXkAbNgXUj6PdC0PpAIOEtDk
+uQBMzLk+EMz4wGpDnk6oz8BgbyQ1Lg9oPc0vjCmRF5BPvWOQQ1RGJaOmhheKe5y
p8fI4ZdNRPjVsjTzEsMvYVLV0W/6gO1uBtRWZP1MTh30nDHFNuUc3LwiPyAkA258
6nj/uvnUq6LGZaV7XEwb8Z7j0n358T4YGqwTZ6KfKaPIZwMWn6A=
=CeeI
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Abed Agbaria (1):
      qga/vss-win32: remove orphaned VSS provider service

Brad Smith (1):
      qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD

Fabian Grünbichler (1):
      qga: fix typo in guest-file-read warning

Roman Bogorodskiy (3):
      qga: implement 'guest-get-diskstats' for FreeBSD
      tests/unit/test-qga: enable on FreeBSD
      qga: implement 'guest-network-get-route' for FreeBSD

 meson.build               |   6 +
 qga/commands-bsd.c        | 308 +++++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-common.h     |  12 +-
 qga/commands-posix.c      |   4 +-
 qga/commands.c            |   2 +-
 qga/meson.build           |   3 +
 qga/qapi-schema.json      |  49 ++++----
 qga/vss-win32/install.cpp | 118 +++++++++++++++---
 tests/unit/meson.build    |   2 +-
 tests/unit/test-qga.c     |   4 +-
 10 files changed, 451 insertions(+), 57 deletions(-)

-- 
2.54.0 (Apple Git-157)


