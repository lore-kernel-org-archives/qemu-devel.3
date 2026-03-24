Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EABAE9A779
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w514t-0007jv-VJ; Tue, 24 Mar 2026 08:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w514t-0007jT-21
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w514r-0001Qm-By
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774356103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uC6OJG1xTdrJ5kZXaGv+BJtQZ6+HAz8P//quPlR31ng=;
 b=FxRbyUsMbdLBuIFSdMaEfcjHF+vQQqXT812O+Izw7siFUdG/64g7sDxZ82YmnGZ4dC6RbZ
 iqCN8MDXXtUmhVQ9C7vniseJkFgRJLNQ6IuOrcYq0mffN/XM5b+rrcduEOim9BKqh1SQmz
 46A/NHA73RQKBc2m9Cl3hxNhVu6Hec0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-aVXQAg2iPLSGi1WltesS3g-1; Tue,
 24 Mar 2026 08:41:42 -0400
X-MC-Unique: aVXQAg2iPLSGi1WltesS3g-1
X-Mimecast-MFC-AGG-ID: aVXQAg2iPLSGi1WltesS3g_1774356101
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BEA01954B2B; Tue, 24 Mar 2026 12:41:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAA401953947; Tue, 24 Mar 2026 12:41:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/5] aspeed queue
Date: Tue, 24 Mar 2026 13:41:26 +0100
Message-ID: <20260324124131.1053711-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 750ed363ebfb108082b40bc532b20564bf00f913:

  Merge tag 'hw-misc-20260323' of https://github.com/philmd/qemu into staging (2026-03-23 16:58:15 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260324

for you to fetch changes up to 5fca367b89de2d11631cb27a90a8c5431d004f58:

  hw/i2c/aspeed_i2c: Remove assert (2026-03-24 11:19:40 +0100)

----------------------------------------------------------------
aspeed queue:

* Rework Aspeed SMC mem ops to improve error handling
* Fix race in Aspeed I2C model
* Disable kernel crypto self-tests in AST2700 boot tests

----------------------------------------------------------------
Cédric Le Goater (2):
      hw/ssi/aspeed_smc: Convert mem ops to read/write_with_attrs for error handling
      hw/i2c/aspeed_i2c: Remove assert

Jamin Lin (2):
      MAINTAINERS: Add Kane Chen as reviewer for Aspeed machines
      tests/functional/aarch64/test_aspeed: Disable kernel crypto self-tests in AST2700 boot tests

Jithu Joseph (1):
      hw/i2c/aspeed: fix lost interrupts on back-to-back commands

 MAINTAINERS                                       |  1 +
 include/hw/i2c/aspeed_i2c.h                       |  1 +
 hw/i2c/aspeed_i2c.c                               | 47 +++++++++++++++++++++-
 hw/ssi/aspeed_smc.c                               | 49 +++++++++++++----------
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 11 ++++-
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 11 ++++-
 tests/functional/aarch64/test_aspeed_ast2700fc.py |  9 ++++-
 7 files changed, 101 insertions(+), 28 deletions(-)


