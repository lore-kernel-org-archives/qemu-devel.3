Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA8ED47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqj-0007Il-VM; Fri, 16 Jan 2026 06:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqJ-00076S-VQ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:19 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqH-0005eK-9T
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso12962555e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562289; x=1769167089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t9WzqMRuuA0/2oxyRezfpX4mT6hp/EAORI+sidITiX0=;
 b=Rs3/7tjGFpW3K9aU9W/oybetLt43YjuIbl2UXeYfxa5z2iAUP+XFfB6WlaYooN6OAs
 +mIHc4HDavTUi0ItvidzHdMsKPEB1mpJ3FhzPPp62ApSe78+o57uTQXEbzNS4HuFUWKB
 bqA+luQ981qs7FvgjTmgLnqBMMtx6+CC9ZtpbRl+FiLqbuVqCpn++Lw9yYGvhM4a8P5h
 I/uPeDo1F/5IoIYzXsMPcft+yQLOY/6K6feLuyztqbbIM12jq0759rvFBcjH2UPnYPJj
 TnN2m2m6GkjeRC/hr8q0hBRYCRuJN4vcsh0FQr5TWdqEIS3hjP7beCjsEeC0F18HjJGZ
 +Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562289; x=1769167089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9WzqMRuuA0/2oxyRezfpX4mT6hp/EAORI+sidITiX0=;
 b=kEXAJOKh/XsOPOMaITO5r9N2yUGSi40L1Jtt8nI3BUl49E4/MJqi3e8v4mnWdd2aWn
 SVGnus9p5sDpKbmTMX6mdaA0Sc+PK2DMrTvcLRVRRKTmDzzh/lRrEnVzyeXx5u+66ScD
 r2Z5pK9LBzAPDkq7UBSFdw6/zKFYn8xedXZmMD75jCKTQerhtK/O1OVJrTsCjwZn/iNG
 lbs3CQMB9rRCdrYVT25myqpQLpb7MvipGmPfB1k7MwRZfQoPBCAMwnuTR9NNyM1bxWqz
 dkdUoEVPuByxNBay5Kzux9sR9LsZj6oXwsjM81T0CdME3IzAvqijNydRYzfDNHFTq3m6
 65Fw==
X-Gm-Message-State: AOJu0YxEI0ClPJjKpOMGMPxZAK+mNdEcvE/y9kR9nbPJyRMtTKt3An7O
 akRZT9nzdOxbKutwkVa4FJtsBPmVOaHL/lRIt8in1rXCdWFYQoBijNIwT9Ag6vkDCElGdKPzyT/
 V/WCGej0=
X-Gm-Gg: AY/fxX55DPGNa3+jih9K1OgLcSoohqetXpDj9YY1WdNbFf8PokITxj0qhNAM721EJtI
 xyQdk9f6z95myVFJ7PHdlD7m/7W+qm8u8b6bHIw2+w1xXztmkgwC8u8Am4vyAoYh02IbFH3Lhtm
 ZlgfX5BXX0ZeDea9pGXhJtSsuB0WzvB6zocOv50ZD6TAX+PFiWlo8PP4pNas1kppelG3/zQGuB6
 SCNYniPmpRP8RjD5Dg+q6Am1qBrb6khTpBBvgJvtXcFGAkd1yb7Y/QqJRHMI0kD7NJzWDMd9r9n
 SDpDUI1mELHYgyHymOYA5swQ7ifXLSyKDbZldH4fu0EEw8Lh30MHDD9O/jfKGJZZOWNpMqFfhZE
 fGhfiVQGwS1Kcu7+Veyxh4unkBPE6HylcvXbwDnv7UhN7uhYk5XXNLfyZ/aR+qmN61KuCbxs9dv
 vFGCSNbIqVJKX2HBivQI6zITxCjgVUr5k80qreUuUZbZDp00MyD2xFPC+g6WYR
X-Received: by 2002:a05:600c:a411:b0:480:1ecd:e7ce with SMTP id
 5b1f17b1804b1-4801ecde895mr18870285e9.11.1768562289117; 
 Fri, 16 Jan 2026 03:18:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48020312253sm13368395e9.14.2026.01.16.03.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] Accelerators patches for 2026-01-16
Date: Fri, 16 Jan 2026 12:17:37 +0100
Message-ID: <20260116111807.36053-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c1c58cee16380f81f88fbde6b12f247b376839e2:

  Merge tag 'pull-target-arm-20260115' of https://gitlab.com/pm215/qemu into staging (2026-01-16 09:33:20 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20260116

for you to fetch changes up to 7b87e00c25bb7b792c0ea80ac02f0bb6770f5106:

  tests/functional: Require TCG to run reverse debugging tests (2026-01-16 11:17:28 +0100)

----------------------------------------------------------------
Accelerators patches queue

- Enable 64bit WebAssembly guests (TCI)
- Fix migration on HVF
- Remove a signal race with WFI on HVF (Aarch64)
- Correct HVF guest timer frequency (Aarch64)
- Fix NVMM build (x86)

----------------------------------------------------------------

Kohei Tokunaga (4):
  meson: Add wasm64 support to the --cpu flag
  configure: Enable to propagate -sMEMORY64 flag to Emscripten
  dockerfiles: Add support for wasm64 to the wasm Dockerfile
  gitlab-ci: Add build tests for wasm64

Markus Armbruster (1):
  hmp-commands-info.hx: Move definition of "info accel"

Philippe Mathieu-Daudé (15):
  migration/dirtyrate: Do not unlock cpu_list lock twice
  tests/qtest/migration: Make 'has_dirty_ring' generic
  tests/qtest/migration: Add MigrationTestEnv::has_hvf field
  target/i386/hvf: Use host page alignment in ept_emulation_fault()
  accel/hvf: Enforce host alignment in hv_vm_protect()
  accel/hvf: Skip WFI if CPU has work to do
  accel/hvf: Implement WFI without using pselect()
  accel/hvf: Have PSCI CPU_SUSPEND halt the vCPU
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm: Create GTimers *after* features finalized / accel realized
  target/arm/hvf: Really set Generic Timer counter frequency
  target/arm: Only allow disabling NEON when using TCG
  accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
  tests/functional: Require TCG to run reverse debugging tests

Richard Henderson (9):
  accel/hvf: Create hvf_protect_clean_range, hvf_unprotect_dirty_range
  target/i386/hvf: Use hvf_unprotect_dirty_range
  target/i386/hvf: Use address_space_translate in ept_emulation_fault
  accel/hvf: Simplify hvf_log_*
  accel/hvf: Move hvf_log_sync to hvf_log_clear
  accel/hvf: Simplify hvf_set_phys_mem
  accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
  accel/hvf: Remove mac_slots
  target/arm/hvf: Implement dirty page tracking

Thomas Huth (1):
  target/i386/nvmm: Include missing ramlist.h header

 MAINTAINERS                                   |   2 +-
 configure                                     |  16 +-
 meson.build                                   |   4 +-
 include/accel/accel-cpu-ops.h                 |   1 +
 include/system/hvf_int.h                      |  22 +--
 tests/qtest/migration/framework.h             |   1 +
 accel/accel-common.c                          |   5 +
 accel/hvf/hvf-accel-ops.c                     |  18 +-
 accel/hvf/hvf-all.c                           | 186 ++++++------------
 migration/dirtyrate.c                         |   1 -
 target/arm/cpu.c                              |  67 +++----
 target/arm/hvf/hvf.c                          | 167 ++++++++--------
 target/i386/hvf/hvf.c                         |  48 +++--
 target/i386/nvmm/nvmm-all.c                   |   3 +-
 tests/qtest/migration/framework.c             |   3 +-
 tests/qtest/migration/precopy-tests.c         |   3 +-
 .gitlab-ci.d/buildtest.yml                    |  24 ++-
 .gitlab-ci.d/container-cross.yml              |  11 +-
 .gitlab-ci.d/container-template.yml           |   4 +-
 .gitlab-ci.d/containers.yml                   |   3 +-
 accel/hvf/trace-events                        |   1 +
 hmp-commands-info.hx                          |  24 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} |  26 ++-
 tests/functional/reverse_debugging.py         |   2 +
 24 files changed, 303 insertions(+), 339 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (89%)

-- 
2.52.0


