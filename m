Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C4EE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCoc-00043m-9T; Tue, 07 Jan 2025 11:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoa-00042M-Eu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoO-0005p0-6y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so7639696f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268731; x=1736873531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ETVcdYawHw9PabUk74gz9REVsCEoFRnRmtR83wHydA=;
 b=G5LShjcnI+JX+ExDTVg5Mvsk4Vo4hFqKP4NJ1zktuzAziJcRPeXIWV92AtwmP8wbkL
 fx3mlyD4RrkPAsN+2P9Uve99/dKSe4D/6rzpTuBAIynqypDYfM2xMky3Ze1ZN3RvK4hm
 qJ0j07O9E63EdZXCi7754FQCAcup19eGcGsIyK63OqM55Ef5/mghej4VhIXReR+qjmLw
 s7uhZEBpQJGI75jtdSi2nR7deQVZdyM4lH9MfIjDWHtpClroXvXUiZiFhvILYem8z8Iz
 e22qC+TNH9ETlxaaKqjpb7fBkE34q8QBOoQAZTr0YSe384Y9u/DB/epq8iNmU5O/cyns
 BAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268731; x=1736873531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ETVcdYawHw9PabUk74gz9REVsCEoFRnRmtR83wHydA=;
 b=xAv5aFJ6Aw+7uX1WP2QPm1dH3AyE9zyL6jsuedn/nkhGBsyoeIy85MuyoR3CnUvJZY
 xfZ/+vbpvr+OatW0FBG7gvWV+D36DazAtx8UZbJhJjtdGqx5EN48ayaGpKq8k/mu10R8
 MXLy3Sq9cVKgv7roCIb1WgWdli5mQ8VJPiYMBNhCj5XkRSXrNzSOZ9DSXteHlkHvbxmv
 208ljyqxhKzqiWjTjiYCUVqm1IBGuaQuigFm5ArzMGa++xJb4HV00sY7z9/QI/bQjW55
 np8MYl/PIV9GMcoFOyA01Gsfx/VUk711Mrd9aZiKJQpJyrgCnZjdc775qlDoRdiE3+7Z
 BEFA==
X-Gm-Message-State: AOJu0YwjQ03s0wxzYG1RvgzPTqVbYVw4GhWcooWgrWBXpWd0cYB926YG
 CTRoQQ6w795XWABbwUg+mJ7oFWwPkaADm5I/tuQfKnZ0vw14uFch2fkLipbNM28=
X-Gm-Gg: ASbGncuINjmQlRwCpxuqiIwAJvunAYiyFdK1m2zV4bSqtERVZK0OjJB0dUHo4WSjjvB
 SDB7QeffZsblQf5WHWMMfOn+UCAaG1eGcQML9JeY0PlPgQQgrRD5SkZcP32pKQeZaD/n7L6SulJ
 yRHckFSHWuBxdUO3tcTa055Q82UnK4f7CmB9kuuAobWYHDX0iiyz7n3UqFQumr9fBBKCkq8oBF/
 7DSik8JNk+7zocve7EI6SBSNIzxJlkT2rjF3gZIfEO1e+gPiKOilyc=
X-Google-Smtp-Source: AGHT+IEDG7sBg6cqebfLyz7AssCga1HxLeHwZxJaky860FZzgxZKiSJmGrkz2cNTCglBV4tey/bTnw==
X-Received: by 2002:a05:6000:154f:b0:385:ef2f:92ad with SMTP id
 ffacd0b85a97d-38a221e181cmr60459122f8f.10.1736268730689; 
 Tue, 07 Jan 2025 08:52:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm50011358f8f.14.2025.01.07.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F5C75F869;
 Tue,  7 Jan 2025 16:52:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 00/29] testing/next: functional tests, qtest clocks,
 vm and keymaps (pre-PR)
Date: Tue,  7 Jan 2025 16:51:38 +0000
Message-Id: <20250107165208.743958-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There are number of parts to this series.

The first is the updated images for all the guests that didn't make it
into 9.2. There are also some new functional tests for virtio-gpu
along with some other clean-ups.

The qtest patches focus on ensuring things calling clock_step and
clock_set actually pay attention to return values. The virtio tests
needed a little little re-jigging as they don't need timeout
loops at all (v2).

We bump libvirt-ci so we can move the riscv64 cross container to
testing/trixie which will hopefully make the image less prone to sid
breakages.

Finally we make a few tweaks to tests/vm which were helpful when
chasing the keymap issue. I still think there is a race condition in
there somewhere as I can't reliably build the FreeBSD VMs from
scratch.

The pc-bios dependency fixup I think addresses the failure but I'm a
little unsure about the meason stuff.

I'll send a PR for everything that is reviewed later this week.

For v2
  - add test/vm and lcitool updates
  - don't move clock_step, remove them for virtio tests

For v3
  - review comments and checkpatch fixes
  - MAINTAINERS updates
  - add zstd uncompress function and use it

The following still need review:

  pc-bios: ensure keymaps dependencies set vnc tests
  tests/vm: allow interactive login as root
  tests/vm: partially un-tabify help output
  tests/docker: move riscv64 cross container from sid to trixie
  tests/functional: extend test_aarch64_virt with vulkan test
  tests/functional: add zstd support to uncompress utility
  tests/qtest: remove clock_steps from virtio tests

Alex.

Alex Bennée (25):
  tests/functional: update the arm tuxrun tests
  tests/functional: update the i386 tuxrun tests
  tests/functional: add a m68k tuxrun tests
  tests/functional: update the mips32 tuxrun tests
  tests/functional: update the mips32el tuxrun tests
  tests/functional: update the mips64 tuxrun tests
  tests/functional: update the mips64el tuxrun tests
  tests/functional: update the ppc32 tuxrun tests
  tests/functional: update the ppc64 tuxrun tests
  tests/functional: update the riscv32 tuxrun tests
  tests/functional: update the riscv64 tuxrun tests
  tests/functional: update the s390x tuxrun tests
  tests/functional: update the sparc64 tuxrun tests
  tests/functional: update the x86_64 tuxrun tests
  tests/qtest: remove clock_steps from virtio tests
  system/qtest: properly feedback results of clock_[step|set]
  tests/functional: remove hacky sleep from the tests
  tests/functional: add zstd support to uncompress utility
  tests/functional: extend test_aarch64_virt with vulkan test
  tests/lcitool: bump to latest version of libvirt-ci
  tests/docker: move riscv64 cross container from sid to trixie
  tests/vm: fix build_path based path
  tests/vm: partially un-tabify help output
  tests/vm: allow interactive login as root
  pc-bios: ensure keymaps dependencies set vnc tests

Daniel P. Berrangé (1):
  tests/lcitool: remove temp workaround for debian mips64el

Philippe Mathieu-Daudé (1):
  dockerfiles: Remove 'MAINTAINER' entry in debian-tricore-cross.docker

Pierrick Bouvier (1):
  tests/functional/aarch64: add tests for FEAT_RME

Wainer dos Santos Moschetta (1):
  MAINTAINERS: Remove myself from reviewers

 MAINTAINERS                                   |   3 +-
 system/qtest.c                                |  23 ++--
 tests/qtest/libqos/virtio.c                   |   4 -
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 pc-bios/keymaps/meson.build                   |  17 ++-
 .../dockerfiles/debian-mips64el-cross.docker  |   9 ++
 .../dockerfiles/debian-riscv64-cross.docker   |   4 +-
 .../dockerfiles/debian-tricore-cross.docker   |   2 -
 tests/functional/meson.build                  |   5 +
 tests/functional/qemu_test/uncompress.py      |  17 +++
 tests/functional/test_aarch64_rme_sbsaref.py  |  69 +++++++++++
 tests/functional/test_aarch64_rme_virt.py     |  98 +++++++++++++++
 tests/functional/test_aarch64_virt.py         | 114 +++++++++++++++---
 tests/functional/test_arm_tuxrun.py           |  28 ++---
 tests/functional/test_i386_tuxrun.py          |   8 +-
 tests/functional/test_m68k_tuxrun.py          |  34 ++++++
 tests/functional/test_mips64_tuxrun.py        |   8 +-
 tests/functional/test_mips64el_tuxrun.py      |   8 +-
 tests/functional/test_mips_tuxrun.py          |   8 +-
 tests/functional/test_mipsel_tuxrun.py        |   8 +-
 tests/functional/test_ppc64_tuxrun.py         |  16 +--
 tests/functional/test_ppc_tuxrun.py           |   8 +-
 tests/functional/test_riscv32_tuxrun.py       |   8 +-
 tests/functional/test_riscv64_tuxrun.py       |  16 +--
 tests/functional/test_s390x_tuxrun.py         |   8 +-
 tests/functional/test_sparc64_tuxrun.py       |   8 +-
 tests/functional/test_x86_64_tuxrun.py        |   8 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/mappings.yml                    |  29 -----
 tests/lcitool/refresh                         |   4 +-
 tests/qtest/meson.build                       |   2 +-
 tests/vm/Makefile.include                     |  29 ++---
 tests/vm/basevm.py                            |  12 +-
 tests/vm/generated/freebsd.json               |   2 +-
 34 files changed, 453 insertions(+), 168 deletions(-)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py
 create mode 100644 tests/functional/test_m68k_tuxrun.py

-- 
2.39.5


