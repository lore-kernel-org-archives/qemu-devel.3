Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EABD767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZIB-0006tV-3T; Thu, 31 Oct 2024 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZHx-0006pS-9s
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZHs-0006YJ-NS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730396923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AqECK0tko97l+yBziUM2ubdbKh32uMSLuYLNjpHQNTg=;
 b=PyCgfIi+Kj5M1EckcJtfKokzXEEPn0Cna2h59tJG4lc5021afAkywNcVzXitUIy+SwrmUM
 N3ScSbZFTePb/AD5YLtM3qPOOiJtG74VdNuhXMy8POK/ro7M3uSA4xFKZjZdyCRYSVyLJt
 YwZMfZE50LL3snm2S+L1X1hFmkaqqJs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-QyxGzwLKMpedeinLWM6MKQ-1; Thu,
 31 Oct 2024 13:48:37 -0400
X-MC-Unique: QyxGzwLKMpedeinLWM6MKQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A7A1955F69; Thu, 31 Oct 2024 17:48:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69B3C300018D; Thu, 31 Oct 2024 17:48:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/14] Misc patches (functional tests, next-cube machine, ...)
Date: Thu, 31 Oct 2024 18:48:18 +0100
Message-ID: <20241031174832.6574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-31

for you to fetch changes up to d73ad1b1c0e62976d4790606ee29725a0d8a8906:

  tests/functional: Convert the riscv_opensbi avocado test into a standalone test (2024-10-31 07:57:47 +0100)

----------------------------------------------------------------
* Remove the redundant macOS-15 CI job
* Various fixes, improvements and additions for the functional test suite
* Restore the sh4eb target
* Fix the OpenBSD VM test
* Re-enable the pci-bridge device on s390x
* Minor clean-ups / fixes for the next-cube machine

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests/functional: make tuxrun disk images writable
      tests/functional: make cached asset files read-only

Mark Cave-Ayland (2):
      next-cube: fix up compilation when DEBUG_NEXT is enabled
      next-cube: remove cpu parameter from next_scsi_init()

Thomas Huth (10):
      .gitlab-ci.d/cirrus: Remove the macos-15 job
      Revert "Remove the unused sh4eb target"
      tests/functional: Add a test for sh4eb
      tests/vm/openbsd: Remove the "Time appears wrong" workaround
      tests/functional: Fix the s390x and ppc64 tuxrun tests
      hw/s390x: Re-enable the pci-bridge device on s390x
      tests/functional: Convert the tcg_plugins test
      tests/functional: Convert BananaPi tests to the functional framework
      tests/functional: Convert the OrangePi tests to the functional framework
      tests/functional: Convert the riscv_opensbi avocado test into a standalone test

 MAINTAINERS                                        |   4 +-
 configs/devices/sh4eb-softmmu/default.mak          |   3 +
 configs/targets/sh4eb-softmmu.mak                  |   2 +
 qapi/machine.json                                  |   2 +-
 hw/m68k/next-cube.c                                |  14 +-
 tests/qtest/endianness-test.c                      |   1 +
 tests/qtest/machine-none-test.c                    |   1 +
 .gitlab-ci.d/buildtest.yml                         |   2 +-
 .gitlab-ci.d/cirrus.yml                            |  22 +-
 .gitlab-ci.d/cirrus/macos-15.vars                  |  16 -
 .gitlab-ci.d/crossbuilds.yml                       |   2 +-
 .travis.yml                                        |   2 +-
 hw/s390x/Kconfig                                   |   1 +
 tests/avocado/boot_linux_console.py                | 411 ---------------------
 tests/avocado/riscv_opensbi.py                     |  63 ----
 tests/functional/meson.build                       |  22 +-
 tests/functional/qemu_test/asset.py                |   3 +
 tests/functional/qemu_test/tuxruntest.py           |  10 +-
 tests/functional/qemu_test/utils.py                |  21 ++
 .../test_aarch64_tcg_plugins.py}                   |  37 +-
 tests/functional/test_arm_bpim2u.py                | 206 +++++++++++
 tests/functional/test_arm_orangepi.py              | 270 ++++++++++++++
 tests/functional/test_ppc64_tuxrun.py              |   4 +-
 tests/functional/test_riscv_opensbi.py             |  36 ++
 tests/functional/test_sh4eb_r2d.py                 |  33 ++
 tests/lcitool/refresh                              |   1 -
 tests/qemu-iotests/testenv.py                      |   1 +
 tests/qtest/meson.build                            |   1 +
 tests/vm/openbsd                                   |   1 -
 29 files changed, 641 insertions(+), 551 deletions(-)
 create mode 100644 configs/devices/sh4eb-softmmu/default.mak
 create mode 100644 configs/targets/sh4eb-softmmu.mak
 delete mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
 delete mode 100644 tests/avocado/riscv_opensbi.py
 rename tests/{avocado/tcg_plugins.py => functional/test_aarch64_tcg_plugins.py} (78%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_arm_bpim2u.py
 create mode 100755 tests/functional/test_arm_orangepi.py
 create mode 100755 tests/functional/test_riscv_opensbi.py
 create mode 100755 tests/functional/test_sh4eb_r2d.py


