Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A93C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol4B-00033T-98; Mon, 25 Mar 2024 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol46-00032e-Oy
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol42-0005mt-OJ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yqglwrLKEzzLwLsAH/0ACR+VzYaFAnvLumfmdY6phO8=;
 b=IagReHF71srRvQxlXX2VxBPNWGfvtiqSaGFgog+wWmjaDN3o9cOYSaWBCyYPWwPeFNHiX6
 zSgp+bTrcpYFAMCBkZo7hiWiw+RBSkVNsiRUnQwQiIpxVkOmXRtgjlUqACLXiPFRIQlC4h
 atGP1WAcVoewCiJc1FtoGOTuFo14qLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-eSZTdtI7PqqJMBFrIWMdgQ-1; Mon, 25 Mar 2024 10:12:33 -0400
X-MC-Unique: eSZTdtI7PqqJMBFrIWMdgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66C1101A526;
 Mon, 25 Mar 2024 14:12:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 583C83C20;
 Mon, 25 Mar 2024 14:12:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/9] Patches for QEMU 9.0-rc1
Date: Mon, 25 Mar 2024 15:12:01 +0100
Message-ID: <20240325141210.788356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:

  Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-25

for you to fetch changes up to f9b29c636442e917a56a725d774ea99be3b28111:

  tests/tcg/s390x: Test TEST AND SET (2024-03-25 15:05:59 +0100)

----------------------------------------------------------------
* Fix timeouts in Travis-CI jobs
* Mark devices with user_creatable = false that can crash QEMU otherwise
* Fix s390x TEST-AND-SET TCG instruction emulation
* Move pc955* devices to hw/gpio/

----------------------------------------------------------------
Cédric Le Goater (3):
      aspeed: Make the ast2600-a3 SoC not user creatable
      aspeed: Make the ast1030-a1 SoC not user creatable
      misc/pca955*: Move models under hw/gpio

Ido Plat (1):
      target/s390x: Use mutable temporary value for op_ts

Ilya Leoshkevich (1):
      tests/tcg/s390x: Test TEST AND SET

Thomas Huth (3):
      .travis.yml: Shorten the runtime of the problematic jobs
      .travis.yml: Remove the unused xfslib-dev package
      hw/microblaze: Do not allow xlnx-zynqmp-pmu-soc to be created by the user

Zheyu Ma (1):
      libqos/virtio.c: Correct 'flags' reading in qvirtqueue_kick

 MAINTAINERS                              |  4 ++--
 include/hw/{misc => gpio}/pca9552.h      |  0
 include/hw/{misc => gpio}/pca9552_regs.h |  0
 include/hw/{misc => gpio}/pca9554.h      |  0
 include/hw/{misc => gpio}/pca9554_regs.h |  0
 hw/arm/aspeed.c                          |  2 +-
 hw/arm/aspeed_ast10x0.c                  |  2 ++
 hw/arm/aspeed_ast2600.c                  |  2 ++
 hw/{misc => gpio}/pca9552.c              |  4 ++--
 hw/{misc => gpio}/pca9554.c              |  4 ++--
 hw/microblaze/xlnx-zynqmp-pmu.c          |  2 ++
 target/s390x/tcg/translate.c             |  5 +++--
 tests/qtest/libqos/virtio.c              |  2 +-
 tests/qtest/pca9552-test.c               |  2 +-
 tests/qtest/pnv-host-i2c-test.c          |  4 ++--
 tests/tcg/s390x/ts.c                     | 35 ++++++++++++++++++++++++++++++++
 .travis.yml                              | 10 ++++-----
 hw/gpio/meson.build                      |  2 ++
 hw/gpio/trace-events                     |  4 ++++
 hw/misc/meson.build                      |  2 --
 hw/misc/trace-events                     |  4 ----
 tests/tcg/s390x/Makefile.target          |  1 +
 22 files changed, 67 insertions(+), 24 deletions(-)
 rename include/hw/{misc => gpio}/pca9552.h (100%)
 rename include/hw/{misc => gpio}/pca9552_regs.h (100%)
 rename include/hw/{misc => gpio}/pca9554.h (100%)
 rename include/hw/{misc => gpio}/pca9554_regs.h (100%)
 rename hw/{misc => gpio}/pca9552.c (99%)
 rename hw/{misc => gpio}/pca9554.c (99%)
 create mode 100644 tests/tcg/s390x/ts.c


