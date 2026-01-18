Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65969C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhasr-0000Sv-NV; Sun, 18 Jan 2026 17:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhash-0000IU-PT
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:23 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasf-0000Rk-DQ
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:23 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so23587665ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773859; x=1769378659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UZAFhu7TfDn5aaNMlKUvKyLzCWjV5RJwlKIFUP2eYl4=;
 b=xZuQ3kHwE4RKZ72JnYfLcdExQVmUGnajgXDNB9tly5vjD4YyYIi3KeTJv+f37rqVUE
 O2roTIIZ9ff20GmQ2FLo06AEdTDbyVyVLnK/P1BfN2WA9I+HFpoljt7P162pCHe5fCFt
 nbDZtdDjXTtexNJNFR1qU8tdait/YczUENHFml+PXDnT+1kFATa4BekNv5gmGM1EbYll
 ETx1H/s9cbVfq2npmoYQdNWc17F7lHtE6qdWq5g9/iTj6bF5EDQEqaJRe1YiMXSDrgYM
 mAPMfrxJq1AYEs7FKvuPYp/3BpCEbRZeKeX+i/jzHXpLgCI3esM+eeV2A4xulZAD+2nP
 9Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773859; x=1769378659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZAFhu7TfDn5aaNMlKUvKyLzCWjV5RJwlKIFUP2eYl4=;
 b=ibCvcttGxFo2PUUsbHjE1i41xm0zhU8cG3Kb8phRlc/zIxkIq5eBxT5FbDOlJcJ5Ah
 KwCeu1Z/XFwEj7AuMheR5vGvZkQdGgdnGPpbiFkWt975tD0PMDoRhWDf2XbKtvE6MdSp
 FFdBkmE/imOIbLChKFmg/ENhzvLoZmfsrYdemQlhNzxuRAIu4PE+QURSHBRZIJQ4Atpk
 p0MUSYmziGAePkjy5JDx3Bw73S+ASchgyAegMqpL5EPGVw3Vi7CT2UDTUctGXJdtWoZ3
 7uDQWg48ISwJItF8srbLlxMIuvYEkahziXBy97PWU2blqFbxzmxueVyUtob+fO4V84OG
 YU3Q==
X-Gm-Message-State: AOJu0Yy4i884Orf1JwS7DlwYK24UXrJJ2BtIsnfM0SHHrdrEHJCIoPGu
 0y6CQFrw8pJw+M/ENcTN2JmlhWE+jIHFDEk7o9/QLg61YgPSNmAyBB4tvgo1PxKQm4gnfF14qNv
 ju23IQmOgkg==
X-Gm-Gg: AY/fxX5bNpKzraAWi9N1GpeUiYd7XHZ0YpA1tm3dRSImMv5SGfAM9OSfMNk4cq54rv8
 iABV0H3zXZo2idPRniT6Pt3sCh2HHxazfR4mQNJgvv2QN6x2myIdOL4Tyd4Qh/vH7yL8Vi9h9zw
 9p9efRD8MCljInX3tfOUz1NoamWY0JIY/kYNVL3WYTWigNwJLveOZAHufLyjvKViAdnA6+Pidod
 Jj1tPp132owFIn7DoS+KMDAiE7WxetfArXOiR8hK73Etf2KRhWc8MzMkgqnGvTjdZOZ6TY9eEav
 9+l98onTVupBT28OMIGa4v/DIJTN7xpLzZEu586JNBOS+vVBMimJRE2U0Pw1CDWrEVdiFH9YsJc
 OF8Ic9NjRmOlYLZgCwe19mPb7iXt3V2c11dBi6k88T/x8OCG8EbQUMpsx1znl6KVhUqDYRM6q5r
 RcoOZKLPWLoom9pguvKg==
X-Received: by 2002:a17:902:e551:b0:295:738f:73fe with SMTP id
 d9443c01a7336-2a7175a6371mr104318875ad.30.1768773859099; 
 Sun, 18 Jan 2026 14:04:19 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/54] Remove 32-bit host support
Date: Mon, 19 Jan 2026 09:03:20 +1100
Message-ID: <20260118220414.8177-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 42a5675aa9dd718f395ca3279098051dfdbbc6e1:

  Merge tag 'accel-20260116' of https://github.com/philmd/qemu into staging (2026-01-16 22:26:36 +1100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260119

for you to fetch changes up to 239b9d0488b270f5781fd7cd7139262c165d0351:

  include/qemu/atomic: Drop aligned_{u}int64_t (2026-01-17 10:46:51 +1100)

----------------------------------------------------------------
Remove support for 32-bit hosts.

----------------------------------------------------------------
Richard Henderson (54):
      gitlab-ci: Drop build-wasm32-32bit
      tests/docker/dockerfiles: Drop wasm32 from emsdk-wasm-cross.docker
      gitlab: Remove 32-bit host testing
      meson: Reject 32-bit hosts
      meson: Drop cpu == wasm32 tests
      *: Remove arm host support
      bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
      *: Remove __i386__ tests
      *: Remove i386 host support
      host/include/x86_64/bufferiszero: Remove no SSE2 fallback
      meson: Remove cpu == x86 tests
      *: Remove ppc host support
      tcg/i386: Remove TCG_TARGET_REG_BITS tests
      tcg/x86_64: Rename from i386
      tcg/ppc64: Rename from ppc
      meson: Drop host_arch rename for mips64
      meson: Drop host_arch rename for riscv64
      meson: Remove cpu == riscv32 tests
      tcg: Make TCG_TARGET_REG_BITS common
      tcg: Replace TCG_TARGET_REG_BITS / 8
      *: Drop TCG_TARGET_REG_BITS test for prefer_i64
      tcg: Remove INDEX_op_brcond2_i32
      tcg: Remove INDEX_op_setcond2_i32
      tcg: Remove INDEX_op_dup2_vec
      tcg/tci: Drop TCG_TARGET_REG_BITS tests
      tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
      tcg: Drop TCG_TARGET_REG_BITS test in region.c
      tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op.c
      tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
      tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-ldst.c
      tcg: Drop TCG_TARGET_REG_BITS tests in tcg.c
      tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
      tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
      include/tcg: Drop TCG_TARGET_REG_BITS tests
      target/i386/tcg: Drop TCG_TARGET_REG_BITS test
      target/riscv: Drop TCG_TARGET_REG_BITS test
      accel/tcg/runtime: Remove 64-bit shift helpers
      accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
      tcg: Unconditionally define atomic64 helpers
      accel/tcg: Drop CONFIG_ATOMIC64 checks from ldst_atomicicy.c.inc
      accel/tcg: Drop CONFIG_ATOMIC64 test from translator.c
      linux-user/arm: Drop CONFIG_ATOMIC64 test
      linux-user/hppa: Drop CONFIG_ATOMIC64 test
      target/arm: Drop CONFIG_ATOMIC64 tests
      target/hppa: Drop CONFIG_ATOMIC64 test
      target/m68k: Drop CONFIG_ATOMIC64 tests
      target/s390x: Drop CONFIG_ATOMIC64 tests
      target/s390x: Simplify atomicity check in do_csst
      migration: Drop use of Stat64
      block: Drop use of Stat64
      util: Remove stats64
      include/qemu/atomic: Drop qatomic_{read,set}_[iu]64
      meson: Remove CONFIG_ATOMIC64
      include/qemu/atomic: Drop aligned_{u}int64_t

 accel/tcg/atomic_template.h                        |    4 +-
 accel/tcg/tcg-runtime.h                            |   23 -
 bsd-user/syscall_defs.h                            |    2 +-
 host/include/i386/host/cpuinfo.h                   |   41 -
 host/include/i386/host/crypto/aes-round.h          |  152 -
 host/include/i386/host/crypto/clmul.h              |   29 -
 host/include/ppc/host/cpuinfo.h                    |   30 -
 host/include/ppc/host/crypto/aes-round.h           |  182 -
 host/include/ppc64/host/cpuinfo.h                  |   31 +-
 host/include/ppc64/host/crypto/aes-round.h         |  183 +-
 host/include/{riscv => riscv64}/host/cpuinfo.h     |    0
 host/include/x86_64/host/cpuinfo.h                 |   42 +-
 host/include/x86_64/host/crypto/aes-round.h        |  153 +-
 host/include/x86_64/host/crypto/clmul.h            |   30 +-
 include/accel/tcg/cpu-ldst-common.h                |    9 -
 include/block/block_int-common.h                   |    3 +-
 include/qemu/atomic.h                              |   39 +-
 include/qemu/cacheflush.h                          |    2 +-
 include/qemu/osdep.h                               |    6 +-
 include/qemu/processor.h                           |    2 +-
 include/qemu/stats64.h                             |  199 --
 include/qemu/timer.h                               |    9 -
 include/system/cpu-timers-internal.h               |    2 +-
 include/tcg/helper-info.h                          |    2 +-
 .../tcg/target-reg-bits.h                          |    8 +-
 include/tcg/tcg-op.h                               |    9 +-
 include/tcg/tcg-opc.h                              |    9 +-
 include/tcg/tcg.h                                  |   29 +-
 linux-user/include/host/arm/host-signal.h          |   43 -
 linux-user/include/host/i386/host-signal.h         |   38 -
 .../include/host/{mips => mips64}/host-signal.h    |    0
 linux-user/include/host/ppc/host-signal.h          |   39 -
 .../include/host/{riscv => riscv64}/host-signal.h  |    0
 migration/migration-stats.h                        |   36 +-
 tcg/aarch64/tcg-target-reg-bits.h                  |   12 -
 tcg/arm/tcg-target-con-set.h                       |   47 -
 tcg/arm/tcg-target-con-str.h                       |   26 -
 tcg/arm/tcg-target-has.h                           |   73 -
 tcg/arm/tcg-target-mo.h                            |   13 -
 tcg/arm/tcg-target-reg-bits.h                      |   12 -
 tcg/arm/tcg-target.h                               |   73 -
 tcg/i386/tcg-target-reg-bits.h                     |   16 -
 tcg/loongarch64/tcg-target-reg-bits.h              |   21 -
 tcg/mips/tcg-target-reg-bits.h                     |   16 -
 tcg/{mips => mips64}/tcg-target-con-set.h          |    0
 tcg/{mips => mips64}/tcg-target-con-str.h          |    0
 tcg/{mips => mips64}/tcg-target-has.h              |    0
 tcg/{mips => mips64}/tcg-target-mo.h               |    0
 tcg/{mips => mips64}/tcg-target.h                  |    0
 tcg/{ppc => ppc64}/tcg-target-con-set.h            |    0
 tcg/{ppc => ppc64}/tcg-target-con-str.h            |    0
 tcg/{ppc => ppc64}/tcg-target-has.h                |    0
 tcg/{ppc => ppc64}/tcg-target-mo.h                 |    0
 tcg/{ppc => ppc64}/tcg-target.h                    |    0
 tcg/riscv/tcg-target-reg-bits.h                    |   19 -
 tcg/{riscv => riscv64}/tcg-target-con-set.h        |    0
 tcg/{riscv => riscv64}/tcg-target-con-str.h        |    0
 tcg/{riscv => riscv64}/tcg-target-has.h            |    0
 tcg/{riscv => riscv64}/tcg-target-mo.h             |    0
 tcg/{riscv => riscv64}/tcg-target.h                |    0
 tcg/s390x/tcg-target-reg-bits.h                    |   17 -
 tcg/sparc64/tcg-target-reg-bits.h                  |   12 -
 tcg/tcg-has.h                                      |    5 -
 tcg/tcg-internal.h                                 |   21 +-
 tcg/tci/tcg-target-has.h                           |    2 -
 tcg/tci/tcg-target-mo.h                            |    2 +-
 tcg/tci/tcg-target-reg-bits.h                      |   18 -
 tcg/{i386 => x86_64}/tcg-target-con-set.h          |    0
 tcg/{i386 => x86_64}/tcg-target-con-str.h          |    0
 tcg/{i386 => x86_64}/tcg-target-has.h              |    8 +-
 tcg/{i386 => x86_64}/tcg-target-mo.h               |    0
 tcg/{i386 => x86_64}/tcg-target.h                  |   13 +-
 accel/kvm/kvm-all.c                                |    2 +-
 accel/qtest/qtest.c                                |    4 +-
 accel/tcg/cputlb.c                                 |   37 +-
 accel/tcg/icount-common.c                          |   25 +-
 accel/tcg/tcg-runtime.c                            |   15 -
 accel/tcg/translator.c                             |    4 +-
 accel/tcg/user-exec.c                              |    2 -
 block/io.c                                         |   10 +-
 block/qapi.c                                       |    2 +-
 disas/disas-host.c                                 |    9 -
 hw/display/xenfb.c                                 |   10 +-
 hw/virtio/virtio-mem.c                             |    2 +-
 linux-user/arm/cpu_loop.c                          |   19 +-
 linux-user/hppa/cpu_loop.c                         |   14 +-
 linux-user/mmap.c                                  |    2 +-
 linux-user/syscall.c                               |    9 -
 migration/cpu-throttle.c                           |    4 +-
 migration/migration-stats.c                        |   16 +-
 migration/migration.c                              |   24 +-
 migration/multifd-nocomp.c                         |    2 +-
 migration/multifd-zero-page.c                      |    4 +-
 migration/multifd.c                                |   12 +-
 migration/qemu-file.c                              |    6 +-
 migration/ram.c                                    |   30 +-
 migration/rdma.c                                   |    8 +-
 system/dirtylimit.c                                |    2 +-
 target/arm/ptw.c                                   |   18 +-
 target/arm/tcg/gengvec.c                           |   32 +-
 target/arm/tcg/gengvec64.c                         |    4 +-
 target/arm/tcg/translate-sve.c                     |   26 +-
 target/hppa/op_helper.c                            |    6 +-
 target/i386/cpu.c                                  |   10 -
 target/m68k/op_helper.c                            |    7 +-
 target/s390x/tcg/mem_helper.c                      |   18 +-
 tcg/optimize.c                                     |  322 --
 tcg/region.c                                       |   12 -
 tcg/tcg-op-gvec.c                                  |  113 +-
 tcg/tcg-op-ldst.c                                  |  130 +-
 tcg/tcg-op-vec.c                                   |   14 +-
 tcg/tcg-op.c                                       |  765 +----
 tcg/tcg.c                                          |  376 +--
 tcg/tci.c                                          |   73 +-
 tests/unit/test-rcu-list.c                         |   17 +-
 util/atomic64.c                                    |   85 -
 util/cacheflush.c                                  |    4 +-
 util/qsp.c                                         |   12 +-
 util/stats64.c                                     |  148 -
 .gitlab-ci.d/buildtest.yml                         |    9 -
 .gitlab-ci.d/container-cross.yml                   |   20 -
 .gitlab-ci.d/containers.yml                        |    3 -
 .gitlab-ci.d/crossbuilds.yml                       |   45 -
 MAINTAINERS                                        |   16 +-
 accel/tcg/atomic_common.c.inc                      |   32 -
 accel/tcg/ldst_atomicity.c.inc                     |  149 +-
 common-user/host/arm/safe-syscall.inc.S            |  108 -
 common-user/host/i386/safe-syscall.inc.S           |  127 -
 .../host/{mips => mips64}/safe-syscall.inc.S       |    0
 common-user/host/ppc/safe-syscall.inc.S            |  107 -
 .../host/{riscv => riscv64}/safe-syscall.inc.S     |    0
 configure                                          |   52 +-
 docs/about/deprecated.rst                          |   29 -
 docs/about/removed-features.rst                    |    6 +
 docs/devel/tcg-ops.rst                             |   32 +-
 host/include/i386/host/bufferiszero.c.inc          |  125 -
 host/include/x86_64/host/bufferiszero.c.inc        |  121 +-
 meson.build                                        |  105 +-
 target/i386/tcg/emit.c.inc                         |   39 +-
 target/riscv/insn_trans/trans_rvv.c.inc            |   56 +-
 tcg/arm/tcg-target-opc.h.inc                       |   16 -
 tcg/arm/tcg-target.c.inc                           | 3489 --------------------
 tcg/loongarch64/tcg-target.c.inc                   |    4 +-
 tcg/{mips => mips64}/tcg-target-opc.h.inc          |    0
 tcg/{mips => mips64}/tcg-target.c.inc              |    0
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc            |    0
 tcg/{ppc => ppc64}/tcg-target.c.inc                |    2 +-
 tcg/{riscv => riscv64}/tcg-target-opc.h.inc        |    0
 tcg/{riscv => riscv64}/tcg-target.c.inc            |    4 +-
 tcg/tci/tcg-target.c.inc                           |   84 +-
 tcg/{i386 => x86_64}/tcg-target-opc.h.inc          |    0
 tcg/{i386 => x86_64}/tcg-target.c.inc              |  552 +---
 tests/docker/dockerfiles/emsdk-wasm-cross.docker   |   15 +-
 util/meson.build                                   |    4 -
 154 files changed, 1169 insertions(+), 8460 deletions(-)
 delete mode 100644 host/include/i386/host/cpuinfo.h
 delete mode 100644 host/include/i386/host/crypto/aes-round.h
 delete mode 100644 host/include/i386/host/crypto/clmul.h
 delete mode 100644 host/include/ppc/host/cpuinfo.h
 delete mode 100644 host/include/ppc/host/crypto/aes-round.h
 rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
 delete mode 100644 include/qemu/stats64.h
 rename tcg/ppc/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
 delete mode 100644 linux-user/include/host/arm/host-signal.h
 delete mode 100644 linux-user/include/host/i386/host-signal.h
 rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
 delete mode 100644 linux-user/include/host/ppc/host-signal.h
 rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
 delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/arm/tcg-target-con-set.h
 delete mode 100644 tcg/arm/tcg-target-con-str.h
 delete mode 100644 tcg/arm/tcg-target-has.h
 delete mode 100644 tcg/arm/tcg-target-mo.h
 delete mode 100644 tcg/arm/tcg-target-reg-bits.h
 delete mode 100644 tcg/arm/tcg-target.h
 delete mode 100644 tcg/i386/tcg-target-reg-bits.h
 delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/mips/tcg-target-reg-bits.h
 rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
 rename tcg/{mips => mips64}/tcg-target-has.h (100%)
 rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
 rename tcg/{mips => mips64}/tcg-target.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target.h (100%)
 delete mode 100644 tcg/riscv/tcg-target-reg-bits.h
 rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target.h (100%)
 delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
 delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 delete mode 100644 tcg/tci/tcg-target-reg-bits.h
 rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-has.h (92%)
 rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target.h (86%)
 delete mode 100644 util/atomic64.c
 delete mode 100644 util/stats64.c
 delete mode 100644 common-user/host/arm/safe-syscall.inc.S
 delete mode 100644 common-user/host/i386/safe-syscall.inc.S
 rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
 delete mode 100644 common-user/host/ppc/safe-syscall.inc.S
 rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
 delete mode 100644 host/include/i386/host/bufferiszero.c.inc
 delete mode 100644 tcg/arm/tcg-target-opc.h.inc
 delete mode 100644 tcg/arm/tcg-target.c.inc
 rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
 rename tcg/{mips => mips64}/tcg-target.c.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target.c.inc (99%)
 rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
 rename tcg/{riscv => riscv64}/tcg-target.c.inc (99%)
 rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
 rename tcg/{i386 => x86_64}/tcg-target.c.inc (89%)

