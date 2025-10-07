Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2CDCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66IL-0002XI-Bi; Tue, 07 Oct 2025 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66ID-0002W3-Ff
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I2-0001Is-0b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so3297551f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838128; x=1760442928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wadTPCwXFuxv3rkBg5psQt7Tdr2R+gDLUZcgA9SZcQQ=;
 b=IufPZloLFg60XbbQN84180SDerR2/frgSDl3rfugj00WZf8bN6dzMdBSehiN28Zrl5
 H0H41gojv1cLjNVdDaXzKWCpXjQUVZyz+pJpND22DEFTko8PCjMfHRYNtr7cHN2wERI1
 /swUzqkFEmX3gzKarEhhxbWZe4oQl27sY/N1E5KK4VmKymZVL7sRs3tdhBW+R9nzRPav
 FTeUSs37I07uqVEdckyX50MmyEfVs9aHTIaW6EHPdcddUhkwCtchDKHRdn7O8CZfc+Ok
 rfNpoZOtGxh+96OEY7veXjjkkMF/Woe+yXxzkLSfoYjkWkQI7/kp0gYKXX8sih+WNvdA
 fL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838128; x=1760442928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wadTPCwXFuxv3rkBg5psQt7Tdr2R+gDLUZcgA9SZcQQ=;
 b=ZVdbTkV9BJFiMwv6Cfmkh7L42GYvMzfwt8ymLGV+OFnuZ8+Lvlklphgd/kh58AskiZ
 efJ0Qy/IrT5HoNvkepKcvnarUwocJvjRUhiE7nubvu7/y6zZNYz4Y9XK0w18HCr9oLF/
 DjA32Dr37JdJxV09ib/r/HMi33mdc3SiQkn3N4T4Zj+WFFyQ9QPcO2Grhk+67Mq4vzf5
 O+WsEGHLIA7wS5ZFeEDwKJ5k/wGfPIRXqV0RBIKHWtESVlamUeQwc7JyNZw6EBhUOZ0T
 JDwfxQG7JsvcN+6XgXIH3tU7d49LI9K8ReCTTKQQzSmHdMGPMAsQtLRVerM+8jyg8i8g
 dvyg==
X-Gm-Message-State: AOJu0YxNdkPiw4omdh2lY6GrSSEwDlk8Ej1fgXIs9QVDmC49co5hXztR
 KXcplB3unRCuEbZ86q7taqpDBCCZJ+PwjxZ0Nr33g3oQLTqvAp2C7ykFuRxrROvyrard2aBEJJJ
 GvBzd
X-Gm-Gg: ASbGncuTUV2EVg9NpI553uCHeUD2LH9ZiNQdzewMn6YvABrmQBYVjaDhVCkybeGlGOV
 j5yupyIfunsPyAabnsquu4VC5Uy28Z0uZwng5gSD7wFPGq+5kpaL5wRDZdD1ehF9RYQWG3lFEik
 JmbSF6BcQvZvyI/sQXuGZAFoazwzUL+cgBa+UsppwTK2wGlgQfTaUAZADn7gW3l6oJZjqzP7igA
 FUZGv60iB1VirCKvswixjq56QHF2/EZKZncjt6wZtTD14sMuOcpvfIC7vyhsYyl6QeFI9+bcxdC
 e8Ur3yheXrw8YdMW8vNjKGiz5Ell55obKW9ol6oNqUwCpnBW40MVgEt0r4wxMY4A+nAfgZ28cdH
 dxsCqLQRt1W8Jhxk9cHGRhnt3HMfMo0/l5/QRqxi1hqjzOIbMQBM=
X-Google-Smtp-Source: AGHT+IHDNIfxpMs/gTM3z+Zw9lVKKIMZ5/YGPThuFK7X6t/vCocXNZ/4K4NivCNlnjx5nDt/a58mow==
X-Received: by 2002:a5d:5f54:0:b0:3ee:155e:f61f with SMTP id
 ffacd0b85a97d-42567129e10mr8350657f8f.8.1759838127730; 
 Tue, 07 Oct 2025 04:55:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8fdsm24889300f8f.15.2025.10.07.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06ED05F872;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/17] testing updates
Date: Tue,  7 Oct 2025 12:55:08 +0100
Message-ID: <20251007115525.1998643-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:

  hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-071025-1

for you to fetch changes up to 41f8f2be27736192bab29aa38380c9ebaae810fa:

  record/replay: fix race condition on test_aarch64_reverse_debug (2025-10-07 09:15:45 +0100)

----------------------------------------------------------------
testing updates

 - tweak .gitpublish base to origin/master
 - restore .gitmodules to qemu-project hosts
 - drop 64 bits guests from i686
 - update aarch64/s390x custom runners to 24.04
 - tweak gitlab-runner registration method
 - make check-venv dependency for functional tests
 - replace avocado's gdb support with pygdbmi
 - remove avocado dependencies from reverse_debug tests
 - ensure replay.bin doesn't loose events after SHUTDOWN_HOST_QMP

----------------------------------------------------------------
Alex Bennée (7):
      .gitpublish: use origin/master as default base
      .gitmodules: restore qemu-project mirror of u-boot
      .gitmodules: restore qemu-project mirror of u-boot-sam460ex
      tests/lcitool: drop 64 bit guests from i686 cross build
      tests/lcitool: bump custom runner packages to Ubuntu 24.04
      gitlab: move custom runners to Ubuntu 24.04
      scripts/ci: use recommended registration command

Daniel P. Berrangé (2):
      tests/functional: replace avocado process with subprocess
      tests/functional: drop datadrainer class in reverse debugging

Gustavo Romero (7):
      tests/functional: Re-activate the check-venv target
      python: Install pygdbmi in meson's venv
      tests/functional: Provide GDB to the functional tests
      tests/functional: Add GDB class
      tests/functional: Add decorator to skip test on missing env vars
      tests/functional: Adapt reverse_debugging to run w/o Avocado
      tests/functional: Adapt arches to reverse_debugging w/o Avocado

Vladimir Lukianov (1):
      record/replay: fix race condition on test_aarch64_reverse_debug

 configure                                          |   2 +
 replay/replay.c                                    |   2 +
 .gitlab-ci.d/custom-runners.yml                    |   6 +-
 ...-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} |   8 +-
 ...-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} |  32 ++---
 ...untu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} |  28 ++--
 .gitmodules                                        |   6 +-
 .gitpublish                                        |  16 +--
 meson_options.txt                                  |   2 +
 pythondeps.toml                                    |   1 +
 scripts/ci/setup/gitlab-runner.yml                 |  12 +-
 scripts/ci/setup/ubuntu/build-environment.yml      |  12 +-
 ...-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} |   4 +-
 ...untu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} |   4 +-
 scripts/ci/setup/vars.yml.template                 |   5 +-
 scripts/meson-buildoptions.sh                      |   2 +
 tests/Makefile.include                             |   4 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   2 +-
 tests/functional/aarch64/test_reverse_debug.py     |  12 +-
 tests/functional/meson.build                       |   6 +
 tests/functional/ppc64/test_reverse_debug.py       |  15 +-
 tests/functional/qemu_test/__init__.py             |   4 +-
 tests/functional/qemu_test/decorators.py           |  18 +++
 tests/functional/qemu_test/gdb.py                  |  86 ++++++++++++
 tests/functional/reverse_debugging.py              | 152 +++++++++++----------
 tests/functional/x86_64/test_reverse_debug.py      |  15 +-
 tests/lcitool/refresh                              |   6 +-
 27 files changed, 288 insertions(+), 174 deletions(-)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} (78%)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} (89%)
 rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} (88%)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)
 create mode 100644 tests/functional/qemu_test/gdb.py

-- 
2.47.3


