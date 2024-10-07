Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F96ECFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmGB-0006jb-B5; Mon, 07 Oct 2024 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmG4-0006j7-SM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmG3-00056L-1q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5n0uUK7z41pa06W8F43imtWr4cYXH2FHeHj+ol0Mha4=;
 b=Fo4cmBRYD4MNaRynfrKSPcvIQQBcYP/Adl0NEKmIp95UxfOk2uKqtDTeUigzeTvG+Jyj7S
 J7Zp7XcCChyA3HvYM1jg50MSe5fZy/XrU7Z533NfHvu5sapFTNn0U+twl6zyWXYCAjT2xB
 pwAUfkYZZ4AqSbe+rKweKGPpMIMTb/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-R83qilbZNfmUYJzfxvuhSw-1; Mon,
 07 Oct 2024 07:50:32 -0400
X-MC-Unique: R83qilbZNfmUYJzfxvuhSw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DAA51944D21; Mon,  7 Oct 2024 11:50:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93F4C19560AE; Mon,  7 Oct 2024 11:50:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/12] CI fixes and various clean-ups
Date: Mon,  7 Oct 2024 13:50:15 +0200
Message-ID: <20241007115027.243425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-07

for you to fetch changes up to d841f720c98475c0f67695d99f27794bde69ed6e:

  tests/functional: Bump timeout of some tests (2024-10-07 13:21:41 +0200)

----------------------------------------------------------------
* Mark "gluster" support as deprecated
* Update CI to use macOS 14 instead of 13, and add a macOS 15 job
* Use gitlab mirror for advent calendar test images (seems more stable)
* Bump timeouts of some tests
* Remove CRIS disassembler
* Some m68k and s390x cleanups with regards to load and store APIs

----------------------------------------------------------------
Michael Tokarev (1):
      gitlab-ci/build-oss-fuzz: print FAILED marker in case the test failed and run all tests

Philippe Mathieu-Daudé (8):
      .gitlab-ci.d/cirrus: Drop support for macOS 13 (Ventura)
      .gitlab-ci.d/cirrus: Add manual testing of macOS 15 (Sequoia)
      disas: Remove CRIS disassembler
      hw/m68k: Use explicit big-endian LD/ST API
      target/m68k: Use explicit big-endian LD/ST API
      hw/s390x: Use explicit big-endian LD/ST API
      target/s390x: Replace ldtul_p() -> ldq_p()
      target/s390x: Use explicit big-endian LD/ST API

Thomas Huth (3):
      docs: Mark "gluster" support in QEMU as deprecated
      tests/functional: Switch back to the gitlab URLs for the advent calendar tests
      tests/functional: Bump timeout of some tests

 MAINTAINERS                                        |    5 -
 docs/about/deprecated.rst                          |    9 +
 meson.build                                        |    1 -
 qapi/block-core.json                               |    8 +-
 hw/m68k/bootinfo.h                                 |   28 +-
 include/disas/dis-asm.h                            |    6 -
 include/exec/poison.h                              |    1 -
 block/gluster.c                                    |    2 +
 disas/cris.c                                       | 2863 --------------------
 hw/m68k/mcf5208.c                                  |    2 +-
 hw/m68k/next-cube.c                                |    2 +-
 hw/m68k/q800.c                                     |    4 +-
 hw/s390x/ipl.c                                     |    4 +-
 hw/s390x/s390-pci-inst.c                           |  166 +-
 target/m68k/gdbstub.c                              |    2 +-
 target/m68k/helper.c                               |   10 +-
 target/s390x/gdbstub.c                             |   34 +-
 target/s390x/ioinst.c                              |    2 +-
 .gitlab-ci.d/buildtest.yml                         |    5 +-
 .gitlab-ci.d/cirrus.yml                            |   12 +-
 .../cirrus/{macos-13.vars => macos-15.vars}        |    2 +-
 disas/meson.build                                  |    1 -
 tests/docker/dockerfiles/opensuse-leap.docker      |    2 +-
 tests/functional/meson.build                       |    9 +-
 tests/functional/test_arm_vexpress.py              |    2 +-
 tests/functional/test_m68k_mcf5208evb.py           |    2 +-
 tests/functional/test_or1k_sim.py                  |    2 +-
 tests/functional/test_ppc64_e500.py                |    2 +-
 tests/functional/test_ppc_mac.py                   |    2 +-
 tests/functional/test_sh4_r2d.py                   |    2 +-
 tests/functional/test_sparc_sun4m.py               |    2 +-
 tests/functional/test_xtensa_lx60.py               |    2 +-
 tests/lcitool/libvirt-ci                           |    2 +-
 tests/lcitool/refresh                              |    2 +-
 34 files changed, 173 insertions(+), 3027 deletions(-)
 delete mode 100644 disas/cris.c
 rename .gitlab-ci.d/cirrus/{macos-13.vars => macos-15.vars} (95%)


