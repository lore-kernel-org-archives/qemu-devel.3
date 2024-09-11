Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37959EE4983
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJkO-00016d-4P; Wed, 11 Sep 2024 05:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soJkH-00011Q-GZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1soJkE-0005U9-CQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726047276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yx7TpjPadaZrt74OTo/SGjbePwAgjzKi8atJQJr963I=;
 b=d7I9Ruz15QWB927jEe3z8jAWm2KlYafiYlwTOPV5VuhhQDi/Nb8P5CafwCw5IRasJkDRAw
 MT4RJO1Zx6tn7WAz0jYy5KVGQfdzRV321pJEj4HVWxGB4LHfKhOqp/T1o0xRpMPTZgpCKV
 PVgIrjJYgGBBnQG4/cqOdrxyka6cyFs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-uXEmyjj9NNmCDPdemivukw-1; Wed,
 11 Sep 2024 05:34:31 -0400
X-MC-Unique: uXEmyjj9NNmCDPdemivukw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AFE21944DDE; Wed, 11 Sep 2024 09:34:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FCE919560AD; Wed, 11 Sep 2024 09:34:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/24] Tests and misc patches
Date: Wed, 11 Sep 2024 11:34:24 +0200
Message-ID: <20240911093426.287808-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Peter!

The following changes since commit a66f28df650166ae8b50c992eea45e7b247f4143:

  Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-09-10 11:19:22 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-11

for you to fetch changes up to b4358ed4fd29c21c69e492d814f0926c58caa10f:

  Update FreeBSD CI jobs FreeBSD 14.1 (2024-09-11 11:26:41 +0200)

----------------------------------------------------------------
* Split --enable-sanitizers to --enable-{asan, ubsan}
* Build MSYS2 job using multiple CPUs
* Fix "make distclean" wrt contrib/plugins/
* Convert more Avocado tests to plain standalone functional tests
* Fix bug that breaks "make check-functional" when tesseract is missing
* Use builtin hashlib of Python in the functional tests
* Update the FreeBSD CI jobs to 14.1

v2:
 - Use python hashlib instead of external programs
 - Update FreeBSD CI jobs FreeBSD 14.1

----------------------------------------------------------------
Beraldo Leal (1):
      MAINTAINERS: Remove myself as reviewer

Philippe Mathieu-Daudé (10):
      gitlab-ci: Build MSYS2 job using multiple CPUs
      tests/functional: Convert mips64el Fuloong2e avocado test (2/2)
      tests/functional: Convert mips64el I6400 Malta avocado tests
      tests/functional: Convert mips64el 5KEc Malta avocado tests
      tests/functional: Convert mips32el Malta YAMON avocado test
      tests/functional: Convert nanomips Malta avocado tests
      tests/functional: Convert mips32eb 4Kc Malta avocado tests
      tests/functional: Convert ARM Raspi2 avocado tests
      tests/functional: Convert Aarch64 Raspi3 avocado tests
      tests/functional: Convert Aarch64 Raspi4 avocado tests

Richard Henderson (2):
      meson: Split --enable-sanitizers to --enable-{asan, ubsan}
      meson: Move -fsanitize=undefined into normal configuraton

Thomas Huth (11):
      contrib/plugins/Makefile: Add a 'distclean' target
      MAINTAINERS: Remove myself from the Meson section
      tests/functional: Add the LinuxKernelTest for testing the Linux boot process
      tests/functional: Convert the m68k Q800 Avocado test into a functional test
      tests/functional: Convert the Alpha Clipper Avocado test
      tests/functional: Convert the m68k MCF5208EVB Avocado test
      tests/functional: Convert the or1k-sim Avocado test
      tests/functional: Convert the multiprocess avocado test into a standalone test
      tests/functional: Fix bad usage of has_cmd
      tests/functional/qemu_test: Use Python hashlib instead of external programs
      Update FreeBSD CI jobs FreeBSD 14.1

 MAINTAINERS                                        |  12 +-
 docs/devel/testing/fuzzing.rst                     |   4 +-
 meson.build                                        |  26 +-
 tests/qtest/fdc-test.c                             |   2 +-
 .gitlab-ci.d/buildtest.yml                         |  12 +-
 .gitlab-ci.d/cirrus.yml                            |   6 +-
 .../cirrus/{freebsd-13.vars => freebsd-14.vars}    |   2 +-
 .../custom-runners/ubuntu-22.04-aarch64.yml        |   2 +-
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml |   2 +-
 .gitlab-ci.d/windows.yml                           |   3 +-
 contrib/plugins/Makefile                           |   2 +-
 meson_options.txt                                  |   6 +-
 scripts/meson-buildoptions.sh                      |   9 +-
 tests/avocado/avocado_qemu/__init__.py             |  10 -
 tests/avocado/boot_linux_console.py                | 483 ---------------------
 tests/avocado/machine_mips_malta.py                | 162 -------
 tests/avocado/multiprocess.py                      | 102 -----
 tests/docker/test-debug                            |   4 +-
 tests/functional/meson.build                       |  26 +-
 tests/functional/qemu_test/__init__.py             |   1 +
 tests/functional/qemu_test/asset.py                |  16 +-
 tests/functional/qemu_test/cmd.py                  |   6 +-
 tests/functional/qemu_test/linuxkernel.py          |  41 ++
 tests/functional/qemu_test/tesseract.py            |   3 +-
 tests/functional/test_aarch64_raspi3.py            |  41 ++
 tests/functional/test_aarch64_raspi4.py            |  99 +++++
 tests/functional/test_alpha_clipper.py             |  38 ++
 tests/functional/test_arm_raspi2.py                |  95 ++++
 tests/functional/test_m68k_mcf5208evb.py           |  29 ++
 tests/functional/test_m68k_q800.py                 |  37 ++
 tests/functional/test_mips64el_fuloong2e.py        |  25 +-
 tests/functional/test_mips64el_malta.py            | 186 ++++++++
 tests/functional/test_mips_malta.py                |  81 ++++
 tests/functional/test_mipsel_malta.py              |  96 ++++
 tests/functional/test_multiprocess.py              | 100 +++++
 tests/functional/test_or1k_sim.py                  |  29 ++
 tests/lcitool/refresh                              |   4 +-
 tests/vm/freebsd                                   |   6 +-
 38 files changed, 998 insertions(+), 810 deletions(-)
 rename .gitlab-ci.d/cirrus/{freebsd-13.vars => freebsd-14.vars} (95%)
 delete mode 100644 tests/avocado/machine_mips_malta.py
 delete mode 100644 tests/avocado/multiprocess.py
 create mode 100644 tests/functional/qemu_test/linuxkernel.py
 create mode 100755 tests/functional/test_aarch64_raspi3.py
 create mode 100755 tests/functional/test_aarch64_raspi4.py
 create mode 100755 tests/functional/test_alpha_clipper.py
 create mode 100755 tests/functional/test_arm_raspi2.py
 create mode 100755 tests/functional/test_m68k_mcf5208evb.py
 create mode 100755 tests/functional/test_m68k_q800.py
 create mode 100755 tests/functional/test_mips64el_malta.py
 create mode 100755 tests/functional/test_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py
 create mode 100755 tests/functional/test_multiprocess.py
 create mode 100755 tests/functional/test_or1k_sim.py


