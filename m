Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF64606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXqUy/NZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNb-0007w0-V9; Tue, 10 Nov 2026 22:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNa-0007vi-Dq
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNY-0006V3-Ga
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ff5D5pqbHPd+3i3+5HgWOV+7wg4pBRB9ukxjYxf2J7g=;
 b=eXqUy/NZt0BxXLh0aR/Gk9OgJDFxTjRnbz8BaDP9pNk+M3pmEw9l6UZSU1Ow5XyPTy6lk9
 vZCN/XmiGE8sgBrFThwftwIj7IbY6SJscv/9qCl/RgJNReIkxb7+eZSBzUo65pFGqlSr2Z
 9PaGbpU3i4y7jApB2d7G66eEOQGtX3U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-4S6F_HivO_i4Ghtdu5JOyw-1; Tue,
 10 Nov 2026 22:52:04 -0500
X-MC-Unique: 4S6F_HivO_i4Ghtdu5JOyw-1
X-Mimecast-MFC-AGG-ID: 4S6F_HivO_i4Ghtdu5JOyw_1794369123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 958A61956051
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:52:03 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22C0A300019F
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:52:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] NBD patches through 2026-11-10
Date: Tue, 10 Nov 2026 21:51:25 -0600
Message-ID: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

The following changes since commit 723622bedb0b423de7d1c61ebbe6e7a71934949c:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-11-09 11:58:07 -0800)

are available in the Git repository at:

  https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-10

for you to fetch changes up to 1be14f69a8350349388763f83578f071fdbfee07:

  iotests: Add another nbd-robustness test (2026-11-10 11:20:24 -0600)

----------------------------------------------------------------
NBD patches through 2026-11-10

A few bug fixes:
- Guillaume Vincke: improve connection retry if NBD client hangs up quickly
- Eric Blake: fix two low-severity CVEs with non-compliant NBD clients

----------------------------------------------------------------
Eric Blake (6):
      docs: Mention security considerations for NBD
      iotests: Refactor python NBD server setup
      nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
      iotests: Add new nbd-robustness test
      nbd/server: Reject rather than assert on non-compliant NBD_OPT_SET_META_CONTEXT
      iotests: Add another nbd-robustness test

Guillaume Vincke (2):
      nbd/client-connection: Fix client returning a closed channel
      iotests: Add coverage for NBD connect thread start delay

 docs/system/security.rst                          |  23 +++
 nbd/client-connection.c                           |  32 ++++
 nbd/server.c                                      |  10 +-
 tests/qemu-iotests/iotests.py                     |  30 ++++
 tests/qemu-iotests/tests/nbd-multiconn            |  44 +----
 tests/qemu-iotests/tests/nbd-robustness           | 205 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out       |   5 +
 tests/qemu-iotests/tests/nbd-stale-connection     |  60 +++++++
 tests/qemu-iotests/tests/nbd-stale-connection.out |  17 ++
 9 files changed, 388 insertions(+), 38 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-robustness
 create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

-- 
2.56.0


