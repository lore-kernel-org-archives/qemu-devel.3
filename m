Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0F3C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ThU-0000TW-VK; Wed, 23 Sep 2026 16:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tfz-000890-Ji
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:50 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tfx-0004yr-G0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:47 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4c79fso486082a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195684; x=1790800484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9Y8KV2xuczrrXxAz73HpBBU9vLrlUqWA5m5j/F58oDI=;
 b=OXEYQKHeevchIznQM+g+9herDTN2DjeqyiQKaHrRvtDwGKvfgMUL7X7Gfixd+ZvqN9
 7iOwun9Pvkit/1CYLybSBdoTdW/4nSCi8P0XVbGdaYvbMoVpI1VHvlEU8rwWxecytPKJ
 g07ikQpXcFkC3oXnjREmU6IP8m2Zip7+6fNsm3hYrq8lio5P3UORtQNxE26aseyZA7AA
 MLXu/UeHQ25wKU8OVjEgdIDU4x3MpBHxw0b/1/pNVvROwkcGDS1QAYN0m3V1P1tI+T7y
 R2ZncDWvGh4zuF+6TVUyoxM4NZOfBZz0yPdqclMwfuyCVE4AbtmqLvssdOAcyLfdN6oP
 GOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195684; x=1790800484;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Y8KV2xuczrrXxAz73HpBBU9vLrlUqWA5m5j/F58oDI=;
 b=XAuw9LPnwEGyKj2KeCSw1dSQkIU1ZcpX3RqYYTEDpbOMoZk1a8l2c1eVW57inZYAcv
 bu4HUBYWv1Sn3GFsQ3Qk6F9TlK4LBTQsOAfZlYhvq/4Je+4f4vZ1OO0OA061v0AbVfaT
 5Fo2nHGo2RJXKfjhiN4erVT4XW0xzLp1R5R/CYpuOMPN+/fDDAmV2mNPiwZzTXy3IrqL
 8wbr07Aw/upPGy/cVc4a7rKudDBkm/j3VejV/0qmOlOtGZmOtAQ0IItnJc06kbCoc3xs
 07VPd+VQnbB0AMGr1GGQked+Oie04tEoCgN1youPwcyCb066zWMqt7E6TUHnG3NmFjJS
 zflQ==
X-Gm-Message-State: AFuF++lAWjTjsGgeyAYZpzfh+Xuws5KzECrZcUyBDxgPlvRw7NE+GoPJ
 F11ocR8/EM11xBknEOSDyWz0j7HEah7NxjBKz7YdZSLukme5VA3F8DjO2HYQrgHcG/fu2U/wZUL
 BEQS6
X-Gm-Gg: AYBFou0wDvHTMi2mfZgR6NtD0Kj/4yHD2ConxHDNgsSOQtdfc8rzzPjYafFRn9QDnVa
 yn7eQrUwKJ5hYhFt0nT828fE5r10QECBVVqJHathDdotfd1cj0zBjYVVPMxxOltqTIkE1UEP07N
 0s9Fw4dVJeyNUnR3c4jz7GO9VtPqLwPAlJXVUUo1PO68OUC1ZWxKrhWrHD3BXB7Kg+1xvyZi4dx
 nU5vii8QZI5I7Xr6+b4AmvWyFfO4iS4Ad3esYSpBvx5JsAa+4NVqgCQPbwSIe6XmLpySmEW6KUY
 LNu+r+6N/nq65mRBZmjAaiHFEAEeBhCU4kU2KlLIuD1EUgOVWck/x9M+m1sX1hdBED8bGM9PGBf
 dPqsOW5/uLBvvaAoZx0bxYln908EVoUZKzpzzE5yPXrUC5cleik4r872a4/MNCW95NHNgvVZdEz
 Jd/wm86tWc2GrGxqr4XH4vTTfG9Gys9ui7+d+9u7WYxHkldfSDsalCnHtXtJ8lC4Q1G6ryM4l6V
 AzzcOWKG5bISVuzPw8moymDAxk4eQ==
X-Received: by 2002:a05:6a20:7f83:b0:3dd:85aa:d268 with SMTP id
 adf61e73a8af0-3de0e6ea1d5mr310524637.32.1790195683281; 
 Wed, 23 Sep 2026 13:34:43 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] tcg patch queue 20260923
Date: Wed, 23 Sep 2026 13:34:25 -0700
Message-ID: <20260923203441.31276-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

The following changes since commit 014b1f730c0faa08067f8e9b5829e62ea3d4b177:

  Merge tag 'pull-9p-20260923' of https://github.com/cschoenebeck/qemu into staging (2026-09-23 07:36:52 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260923

for you to fetch changes up to 666879d5477ec41ab46fc10a27d18cbc13e8789e:

  accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags (2026-09-23 13:28:00 -0700)

----------------------------------------------------------------
accel: Change AccelOpsClass.update_guest_debug to void
accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
accel/tcg: Skip the can_do_io stores in user-only builds
accel/tcg: Allow cross-page goto_tb chaining in user-only builds
accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
accel/tcg: Allow some address space wraparound during translation
tcg/optimize: Fix fold_multiply2 vs 1
tcg/optimize: Fix expansion/simplification of deposit
tcg/x86_64: Use the mulx insn from the bmi2 isa
tcg/riscv64: Set vtype before whole-register vector loads

----------------------------------------------------------------
Anton Blanchard (1):
      accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()

Matt Turner (3):
      accel/tcg: Skip the can_do_io stores in user-only builds
      accel/tcg: Allow cross-page goto_tb chaining in user-only builds
      accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags

Richard Henderson (11):
      accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
      tests/guest-debug/run-test: Add --pargs
      tcg/optimize: Fix fold_multiply2 vs 1
      tests/tcg/arm: Add regression test for #4448
      tcg/optimize: Fix expansion/simplification of deposit
      tests/tcg/s390x: Add regression test for #4449
      accel/tcg: Allow some address space wraparound during translation
      tcg: Sort all_outop[] by INDEX name
      tcg/x86_64: Use the mulx insn from the bmi2 isa
      tcg/riscv64: Set vtype before whole-register vector loads
      accel: Change AccelOpsClass.update_guest_debug to void

Tao Cui (1):
      tests/tcg/i386/system: Add regression test for translator_ld wraparound

 accel/tcg/internal-common.h             |  11 +-
 include/accel/accel-cpu-ops.h           |   2 +-
 include/exec/translator.h               |   3 +
 include/gdbstub/user.h                  |  11 +
 include/system/hvf_int.h                |   2 +-
 include/system/tcg.h                    |  12 ++
 tcg/x86_64/tcg-target-con-set.h         |   2 +
 accel/hvf/hvf-accel-ops.c               |   3 +-
 accel/kvm/kvm-accel-ops.c               |   4 +-
 accel/tcg/cpu-exec-common.c             |  37 +++-
 accel/tcg/cpu-exec.c                    |   3 +
 accel/tcg/cputlb.c                      |  16 +-
 accel/tcg/tcg-accel-ops.c               |   1 +
 accel/tcg/translator.c                  |  92 ++++++--
 cpu-target.c                            |   5 +-
 gdbstub/user.c                          |  14 ++
 monitor/hmp-cmds.c                      |   7 +
 system/runstate-hmp-cmds.c              |  18 +-
 tcg/optimize.c                          |  46 ++--
 tcg/tcg.c                               |  39 ++--
 tests/tcg/arm/issue4448.c               |  51 +++++
 tests/tcg/multiarch/test-xpage-chain.c  | 360 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/issue4449.c             |  31 +++
 tcg/riscv64/tcg-target.c.inc            |   6 +
 tcg/x86_64/tcg-target.c.inc             |  36 +++-
 tests/guest-debug/run-test.py           |   5 +
 tests/tcg/arm/meson.build               |   1 +
 tests/tcg/i386/system/meson.build       |   4 +
 tests/tcg/i386/system/wraparound.S      |  35 ++++
 tests/tcg/multiarch/gdbstub/xpage-bp.py |  37 ++++
 tests/tcg/multiarch/meson.build         |   7 +
 tests/tcg/s390x/meson.build             |   1 +
 32 files changed, 810 insertions(+), 92 deletions(-)
 create mode 100644 tests/tcg/arm/issue4448.c
 create mode 100644 tests/tcg/multiarch/test-xpage-chain.c
 create mode 100644 tests/tcg/s390x/issue4449.c
 create mode 100644 tests/tcg/i386/system/wraparound.S
 create mode 100644 tests/tcg/multiarch/gdbstub/xpage-bp.py

