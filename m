Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F80C18E72
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXVh-0004do-GW; Wed, 24 Apr 2024 03:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVf-0004da-8F
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVd-0002zg-8H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cjfSnj1pjeiqIAA5xAQ9TgBGMqfNTSFiezv9BMQqIWQ=;
 b=PZzh61zqeOm5Qo6Zz1P+gsJy723FxLD91wKMIAGNEyeaD+UypJJ98QrcqfzOkg96M2Gtor
 z1EdtFepApa+7mLqZv9PSR1cIMr7J3lAxt9tfccbt+dJH4RndXFfCNb2HFVNq6uU8jmTR+
 YvnyujVbN5qvGIPX/BozCcpoxH5s1Ns=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-tQQLZ-JkNSa9Y9q3MV-asw-1; Wed,
 24 Apr 2024 03:57:37 -0400
X-MC-Unique: tQQLZ-JkNSa9Y9q3MV-asw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66D8B3C12821;
 Wed, 24 Apr 2024 07:57:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC6BA43FAD;
 Wed, 24 Apr 2024 07:57:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/17] CI job updates, header cleanups and other misc patches
Date: Wed, 24 Apr 2024 09:57:18 +0200
Message-ID: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

The following changes since commit 13b1e9667737132440f4d500c31cb69320c6b15a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-23 17:35:57 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24

for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:

  target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 +0200)

----------------------------------------------------------------
* Update OpenBSD CI image to 7.5
* Update/remove Ubuntu 20.04 CI jobs
* Update CentOS 8 CI jobs to CentOS 9
* Some clean-ups and improvements to travis.yml
* Minor test fixes
* s390x header clean-ups
* Doc updates

----------------------------------------------------------------
Brad Smith (1):
      tests/vm: update openbsd image to 7.5

Inès Varhol (1):
      tests/qtest : Use `g_assert_cmphex` instead of `g_assert_cmpuint`

Manos Pitsidianakis (1):
      docs/devel: fix minor typo in submitting-a-patch.rst

Paolo Bonzini (1):
      ci: move external build environment setups to CentOS Stream 9

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
 .../stream/{8 => 9}/build-environment.yml          |  31 ++--
 .../ci/org.centos/stream/{8 => 9}/x86_64/configure |   4 +-
 .../org.centos/stream/{8 => 9}/x86_64/test-avocado |   0
 scripts/ci/setup/build-environment.yml             |  44 +++---
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
 47 files changed, 259 insertions(+), 468 deletions(-)
 rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)
 rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
 delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker


