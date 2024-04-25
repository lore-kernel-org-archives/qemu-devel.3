Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99819C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 14:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00Xp-0004VU-O0; Thu, 25 Apr 2024 10:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00Xl-0004V6-S7
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s00Xh-0004bH-Vc
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714057063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rgs7LMPY5S0Bh8M2hLB8XhIfQxtLOLd94PJmS1yC9+I=;
 b=NkNvDjR1+OQdyb/owTm9uUGPpb0FIfwGaCkIH3noNGA0zDMXaPtZ5X08dn+/Whv6eFrUyc
 FaZSA7Wyudm43j1eCRSDICEjYmHHNLTp3ORthBVX61HUssqVqW1tlF4aWCa31V9Lazl5B9
 YFIfkRtOZc/s2gl/5EDZrsd3qn8yyjE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-fwaz9JefOKGH1bYs48sBPA-1; Thu,
 25 Apr 2024 10:57:39 -0400
X-MC-Unique: fwaz9JefOKGH1bYs48sBPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 413D53C02743;
 Thu, 25 Apr 2024 14:57:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85B8EC15771;
 Thu, 25 Apr 2024 14:57:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 00/16] CI job updates, header cleanups and other misc patches
Date: Thu, 25 Apr 2024 16:57:37 +0200
Message-ID: <20240425145737.451721-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:

  Merge tag 'pull-tcg-20240424' of https://gitlab.com/rth7680/qemu into staging (2024-04-24 15:51:49 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-25

for you to fetch changes up to 17523a38194d80f2955c6a8e0702e0fc86dd083d:

  target/s390x: Remove KVM stubs in cpu_models.h (2024-04-25 15:15:25 +0200)

----------------------------------------------------------------
* Update OpenBSD CI image to 7.5
* Update/remove Ubuntu 20.04 CI jobs
* Update (most) CentOS 8 CI jobs to CentOS 9
* Some clean-ups and improvements to travis.yml
* Minor test fixes
* s390x header clean-ups
* Doc updates

v2: Drop the problematic patch that updates the custom CentOS 8 runner

----------------------------------------------------------------
Brad Smith (1):
      tests/vm: update openbsd image to 7.5

Inès Varhol (1):
      tests/qtest : Use `g_assert_cmphex` instead of `g_assert_cmpuint`

Manos Pitsidianakis (1):
      docs/devel: fix minor typo in submitting-a-patch.rst

Peter Lieven (1):
      MAINTAINERS: update email of Peter Lieven

Philippe Mathieu-Daudé (3):
      hw/s390x: Include missing 'cpu.h' header
      tests/unit: Remove debug statements in test-nested-aio-poll.c
      target/s390x: Remove KVM stubs in cpu_models.h

Thomas Huth (8):
      Revert ".travis.yml: Cache Avocado cache"
      .travis.yml: Remove the unused UNRELIABLE environment variable
      .travis.yml: Update the jobs to Ubuntu 22.04
      .travis.yml: Do some more testing with Clang
      tests: Remove Ubuntu 20.04 container
      tests/lcitool/libvirt-ci: Update to the latest master branch
      tests/docker/dockerfiles: Run lcitool-refresh after the lcitool update
      tests: Update our CI to use CentOS Stream 9 instead of 8

Zhao Liu (1):
      docs: i386: pc: Update maximum CPU numbers for PC Q35

 MAINTAINERS                                        |   6 +-
 docs/devel/submitting-a-patch.rst                  |   2 +-
 docs/system/target-i386-desc.rst.inc               |   2 +-
 hw/s390x/s390-virtio-hcall.h                       |   2 +
 target/s390x/cpu_models.h                          |  15 --
 hw/s390x/s390-stattrib.c                           |   1 +
 tests/qtest/aspeed_fsi-test.c                      |  20 +--
 tests/qtest/cmsdk-apb-dualtimer-test.c             |   2 +-
 tests/qtest/cmsdk-apb-watchdog-test.c              |   2 +-
 tests/qtest/erst-test.c                            |   2 +-
 tests/qtest/ivshmem-test.c                         |  10 +-
 tests/qtest/libqos/ahci.c                          |   4 +-
 tests/qtest/microbit-test.c                        |  46 +++---
 tests/qtest/sse-timer-test.c                       |   4 +-
 tests/qtest/stm32l4x5_exti-test.c                  | 138 +++++++++---------
 tests/qtest/stm32l4x5_syscfg-test.c                |  74 +++++-----
 tests/unit/test-nested-aio-poll.c                  |   7 -
 .gitlab-ci.d/buildtest.yml                         |  16 +--
 .gitlab-ci.d/container-core.yml                    |   4 +-
 .travis.yml                                        |  24 +---
 tests/docker/dockerfiles/alpine.docker             |   3 +-
 .../dockerfiles/{centos8.docker => centos9.docker} |  35 ++---
 tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   3 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
 tests/docker/dockerfiles/debian.docker             |   1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker |   3 +-
 tests/docker/dockerfiles/fedora.docker             |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker      |   1 +
 tests/docker/dockerfiles/ubuntu2004.docker         | 157 ---------------------
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/mappings.yml                         |  20 ---
 tests/lcitool/refresh                              |   3 +-
 tests/vm/centos                                    |   4 +-
 tests/vm/openbsd                                   |   6 +-
 43 files changed, 225 insertions(+), 423 deletions(-)
 rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker


