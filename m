Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EGaOlIVE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXPq-0004jO-Gt; Mon, 23 Nov 2026 12:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPY-0004ep-Fc
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVXPW-0007Vm-3a
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795453256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CjEQeSI+IBv9Cq9K9eY8mcQt99p+7NVboanVYzzRZmU=;
 b=EGaOlIVEEarmgyIWHtKK18AqZxBvYyWngY5yRtLp4qs3ZxOT7VAe1jhvMPaw7ud08uk281
 zM593qCJV8khVF5DA9aU3UW2g/KF2lDScIpYbj0BNDtx9pLDA5VMR96Vgx3sr5NiCqtV6Q
 i2iUDmQ3aQ7VXS0+n7WwaRjzbRsFqiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-L2pGm4NqOeOxbL_-gRJF5A-1; Mon,
 23 Nov 2026 17:00:54 +0000
X-MC-Unique: L2pGm4NqOeOxbL_-gRJF5A-1
X-Mimecast-MFC-AGG-ID: L2pGm4NqOeOxbL_-gRJF5A_1795453253
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DFAA1800BCF
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:00:53 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45FD118011D4; Mon, 23 Nov 2026 17:00:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/6] Misc fixes patches
Date: Mon, 23 Nov 2026 17:00:44 +0000
Message-ID: <20261123170050.4166517-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The following changes since commit d2f99dc8ddbd8922ae2550f9197a79304c17e692:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-11-23 07:29:14 -0800)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to df235ec670000e277ed0490ea974494242c77a61:

  qapi: correctly mark 'ignore-unavailable' deprecated (2026-11-23 16:55:20 +0000)

----------------------------------------------------------------
* Fix error handling when erasing keyslots in LUKS driver
* Fix URLs for sunxi kernels in functional tests
* Satisfy Anubis challenges when downloading assets in
  functional tests by setting Accept header
* Correctly deprecate 'ignore-unavailable' tracing QAPI

----------------------------------------------------------------

Daniel P. Berrangé (6):
  crypto: avoid overwriting Error object erasing keyslot
  crypto: add newline in error hint messages
  tests/functional: update to newer sunxi kernel package
  tests/functional: add Accept header when downloading assets
  docs: document 'unavailable' state is no longer output
  qapi: correctly mark 'ignore-unavailable' deprecated

 crypto/block-luks.c                     | 19 +++++++++----------
 docs/about/deprecated.rst               |  8 ++++++++
 docs/about/removed-features.rst         |  8 ++++++++
 qapi/trace.json                         | 10 ++++++++--
 tests/functional/arm/test_bpim2u.py     | 19 ++++++++++---------
 tests/functional/arm/test_cubieboard.py | 15 ++++++++-------
 tests/functional/arm/test_orangepi.py   | 19 ++++++++++---------
 tests/functional/arm/test_replay.py     | 12 ++++++------
 tests/functional/qemu_test/asset.py     | 11 ++++++++++-
 9 files changed, 77 insertions(+), 44 deletions(-)

-- 
2.56.1


