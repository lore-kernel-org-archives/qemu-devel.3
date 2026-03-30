Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D714FB3D01
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79rM-00016C-AQ; Mon, 30 Mar 2026 06:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79rA-000141-Ix
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79r7-0005DA-Rr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774866504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kv+pcataeWSVGQQKT0N3eugqJf3uqC0uF/kRnCn+yuM=;
 b=Tb6TY4DbH+J3N/WJT9/O0vlzoreyJezYhW32p9ZXHC7e/XX9tl4N/4hbc+VM1wUd4gGpd6
 fM8qYuMdwY915FWdUgLIXnXYfuvuXBKfSoO/HWoFP/dB7bsfKoo2I6ebptIkQzpg5fS1A5
 k8iUv9HfoFSGa8nCbX/BigZuVNEysGA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-f3bC18OfMr68L2gLlCxaTg-1; Mon,
 30 Mar 2026 06:28:20 -0400
X-MC-Unique: f3bC18OfMr68L2gLlCxaTg-1
X-Mimecast-MFC-AGG-ID: f3bC18OfMr68L2gLlCxaTg_1774866499
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7F6195609D; Mon, 30 Mar 2026 10:28:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.35.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C956230001A1; Mon, 30 Mar 2026 10:28:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 0/7] Fixes for QEMU v11.0-rc2
Date: Mon, 30 Mar 2026 12:28:08 +0200
Message-ID: <20260330102815.6759-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:

  Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-30

for you to fetch changes up to c0eaf14d93135e13d8b003f7cb41187e3510373d:

  tests/functional/migration.py: Skip migration_with_exec() if socat is not available (2026-03-30 12:21:09 +0200)

----------------------------------------------------------------
* Fix some warnings from pylint in the functional tests
* Fix migration of the isa-cirrus-vga device
* Remove obsolete linuxboot.bin prebuilt blob
* Fix migration functional test to check for socat instead of ncat now

----------------------------------------------------------------
Daniel P. Berrangé (1):
      pc-bios: remove obsolete linuxboot.bin prebuilt blob

Thomas Huth (5):
      tests/functional/qemu_test: Silence (most) warnings from pylint in asset.py
      tests/functional/qemu_test: Split huge fetch() function in asset.py
      tests/functional/qemu_test: Silence warnings from pylint in config.py
      hw/display/vga-isa: Fix migration of the isa-vga device
      hw/display/cirrus_vga_isa: Disable global_vmstate by default for new machines

Zhao Liu (1):
      tests/functional/migration.py: Skip migration_with_exec() if socat is not available

 hw/core/machine.c                    |   1 +
 hw/display/cirrus_vga_isa.c          |   3 +-
 hw/display/vga-isa.c                 |  13 ++++-
 pc-bios/linuxboot.bin                | Bin 1024 -> 0 bytes
 tests/functional/migration.py        |   4 +-
 tests/functional/qemu_test/asset.py  |  94 +++++++++++++++++++++++------------
 tests/functional/qemu_test/config.py |  11 ++--
 7 files changed, 84 insertions(+), 42 deletions(-)
 delete mode 100644 pc-bios/linuxboot.bin


