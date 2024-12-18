Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49068E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwnU-0007S4-Pi; Wed, 18 Dec 2024 11:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnS-0007Q7-LD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:14 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnN-0006cg-Ji
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:14 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so1708514a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538868; x=1735143668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mFxtokJTmV9YXqorDmZaKi+Dd7+RY6QHS5xgjxfqOhY=;
 b=hy3B+jOGyPio1YofV1MqDlImRojtiWrqBLFqFbBhZNWi64KOjzz8w/79146dvoC2Om
 okb0FqJpQ0J6yULt7AHw1UhrDtGKTt8QxeQsAuAjSAF/PLssp2tqSjTTUK2yoUtiCkUg
 FIjTuGg2WyS0851GBNwLBOkzipETP8IdPmQU0/9pbJLmuFkgDDmct03bwZVkO9kw2++x
 hwIr4zsXOjsLVMewhu/0+YSrcB7oMvgZLoMuQL6NEacaKRu94TMgD0zqbj1bRYhq4Iw3
 EW2BlHN2jNMYzmCA/GS83vzhgywWWdVKP1cjfps7Ycqbffzn2YnE7hgWNpQ0kE/RdefM
 NdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538868; x=1735143668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mFxtokJTmV9YXqorDmZaKi+Dd7+RY6QHS5xgjxfqOhY=;
 b=Ug16YvpuWdNTZcjnNSczMV7gHtLU0tXh23XxXvhSZSBBotbq0ytGMzLzHdK9bTTSSY
 ooSDs7YS3lfjklalEKSx6ljoyz9sTc9rdrXae+SDmy4jeQoue6BWTRgFEPxe7jTT4gBo
 1dZxp/XLv8JifbsMgSNt22Yioxf258cm2t49wiqdz4XgFCwJmObUlws1Uow1Z3Y+COni
 G/lKUTKTgH6OpmvUiliryvWb2LkkcdNE1RGSMOQZcnd4G5sEoc9dcWU3+uCyL1kWn4Lu
 4jqf2WQKy0LBvig0PaqSSGJiCvnUff4CLmXsl7G7WtD/2aPKAyfCaIKxWJ3O4bfoLrL2
 Q9+g==
X-Gm-Message-State: AOJu0YwhTV/awpzAmv2niti2tjxi/5RTihc1q7pCp7VCeuKqohAAk7yF
 MAEW6LF4Mw1uNIT1/9sTsYQzut4yzgGMPg5hfIXIYKhoRgx8cSO0PtFAAbwD1+8=
X-Gm-Gg: ASbGncuDXOOHIjVlxQHW2w0wRPxvy4MTPZJWtyc5mnI+m1/H8C6EKTy/OtQbNAoF5GQ
 8cYfKk5NAZ1JRNF8R+ST+Rx++QQ8rdAW4dL/VHzdS4nUaWfqa6J1HldRJY9NvrMv4VPMGzkL86C
 uEg6oUKmVM5NaOBJONSF0Vs8HrnSAv2ztY1KmoRuBpD48ro2dnjSVX6BRTgCmo+yN2cyuv0qjOC
 dYMJ5BeXMhdO8dUvuztwBA0TUnZE9/pMk3uby7w3dpwHbXfpp36ARw=
X-Google-Smtp-Source: AGHT+IFHHAiIAM08YhllwgVvz8heQR42+SUHwU0RAyc43uh3+LVzo3vOMxKuxRHTzUL6E7xjdwulZw==
X-Received: by 2002:a17:906:794c:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-aabdcba2655mr548405766b.23.1734538867631; 
 Wed, 18 Dec 2024 08:21:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96359831sm569381466b.95.2024.12.18.08.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18E245F796;
 Wed, 18 Dec 2024 16:21:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/27] testing/next: functional tests, qtest clocks,
 vm and keymaps
Date: Wed, 18 Dec 2024 16:20:36 +0000
Message-Id: <20241218162104.3493551-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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
clock_set actually pay attention to return values. Currently only the
virtio tests needed a little re-jigging although arguably the timeout
loops aren't needed at all.

We bump libvirt-ci so we can move the riscv64 cross container to
testing/trixie which will hopefully make the image less prone to sid
breakages.

Finally we make a few tweaks to tests/vm which were helpful when
chasing the keymap issue. I still think there is a race condition in
there somewhere as I can't reliably build the FreeBSD VMs from
scratch.

The pc-bios dependency fixup I think addresses the failure but I'm a
little unsure about the meason stuff.

For v2
  - add test/vm and lcitool updates
  - don't move clock_step, remove them for virtio tests

I was planning on on making this a pre-PR but as I'm off for Christmas
this may as well percolate on the list for now. If any of the other
testing maintainers want to cherry-pick stuff into their PRs then be
my guest.

The following still need review:

  pc-bios: ensure keymaps dependencies set vnc tests
  tests/vm: allow interactive login as root
  tests/vm: partially un-tabify help output
  tests/vm: fix build_path based path
  tests/docker: move riscv64 cross container from sid to trixie
  tests/lcitool: bump to latest version of libvirt-ci
  tests/functional: extend test_aarch64_virt with vulkan test
  tests/functional: remove hacky sleep from the tests
  system/qtest: properly feedback results of clock_[step|set]
  tests/qtest: remove clock_steps from virtio tests
  util/qemu-timer: fix indentation

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
  util/qemu-timer: fix indentation
  tests/qtest: remove clock_steps from virtio tests
  system/qtest: properly feedback results of clock_[step|set]
  tests/functional: remove hacky sleep from the tests
  tests/functional: extend test_aarch64_virt with vulkan test
  tests/lcitool: bump to latest version of libvirt-ci
  tests/docker: move riscv64 cross container from sid to trixie
  tests/vm: fix build_path based path
  tests/vm: partially un-tabify help output
  tests/vm: allow interactive login as root
  pc-bios: ensure keymaps dependencies set vnc tests

Daniel P. Berrangé (1):
  tests/lcitool: remove temp workaround for debian mips64el

Pierrick Bouvier (1):
  tests/functional/aarch64: add tests for FEAT_RME

 MAINTAINERS                                   |   1 +
 system/qtest.c                                |  23 ++--
 tests/qtest/libqos/virtio.c                   |   4 -
 util/qemu-timer.c                             |   2 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 pc-bios/keymaps/meson.build                   |  17 ++-
 .../dockerfiles/debian-mips64el-cross.docker  |   9 ++
 .../dockerfiles/debian-riscv64-cross.docker   |   4 +-
 tests/functional/meson.build                  |   5 +
 tests/functional/test_aarch64_rme_sbsaref.py  |  70 +++++++++++
 tests/functional/test_aarch64_rme_virt.py     | 100 ++++++++++++++++
 tests/functional/test_aarch64_virt.py         | 113 +++++++++++++++---
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
 33 files changed, 441 insertions(+), 163 deletions(-)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py
 create mode 100644 tests/functional/test_m68k_tuxrun.py

-- 
2.39.5


