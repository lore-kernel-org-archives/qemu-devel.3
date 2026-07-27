Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E735EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE0o-0000v5-Ij; Mon, 27 Jul 2026 01:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE0n-0000uT-D2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE0l-0003JX-3M
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k1VrmNRFQkEflkbH34qlxpctdHn82ilr3AyvEi4T4Hc=;
 b=eiWv/oZNPc7/mBchP14yJt2julLz4HicXOT4C5xGrycIf95SWsNidXrBIkFpL1AOX8ZBr7
 /T2gDWzobkuWFMAUNOQ/YW01FT4roSDm38lX/NyH+cKgzTaLYXjLXvVEQjsA2Jx8jipvO6
 P/ccMz+cMvJXnCnaFD9DfoYAMSSQmZs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-K9SpNBJdMMe5zroQUgpJYw-1; Mon,
 27 Jul 2026 01:36:16 -0400
X-MC-Unique: K9SpNBJdMMe5zroQUgpJYw-1
X-Mimecast-MFC-AGG-ID: K9SpNBJdMMe5zroQUgpJYw_1785130575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 930AF18011F9; Mon, 27 Jul 2026 05:36:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36E5A180034F; Mon, 27 Jul 2026 05:36:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/1] aspeed queue
Date: Mon, 27 Jul 2026 07:36:10 +0200
Message-ID: <20260727053611.1388339-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 6333226c2abb72f31648c251624c56e70993d625:

  Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu into staging (2026-07-26 08:30:07 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260727

for you to fetch changes up to d71fa99ca8769947ec4f59790fde4b0bf4a4e295:

  tests/functional/aspeed: Fix remaining hostname-specific login prompts (2026-07-27 07:32:56 +0200)

----------------------------------------------------------------
aspeed queue:

* Fix remaining hostname-specific login prompts in functional tests

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional/aspeed: Fix remaining hostname-specific login prompts

 tests/functional/aarch64/test_aspeed_ast2700a1.py   | 2 +-
 tests/functional/aarch64/test_aspeed_ast2700a2.py   | 2 +-
 tests/functional/aarch64/test_aspeed_ast2700fc.py   | 2 +-
 tests/functional/arm/test_aspeed_ast2500_sdk.py     | 2 +-
 tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 2 +-
 tests/functional/arm/test_aspeed_ast2600_sdk.py     | 2 +-
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)


