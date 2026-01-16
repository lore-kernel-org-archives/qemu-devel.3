Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62706D4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaR-00052z-6M; Thu, 15 Jan 2026 22:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaP-00052p-S5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:21 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaN-000594-D6
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so9220755ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534398; x=1769139198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7IVpOMjjC9wsrOvoPG6snmAWBzVoq8pPsWgSFbeC5WQ=;
 b=FBCGRTlBUuSAdRpazcAeok7mib27MfZXTkv9ofdHD3QrfS7etThBtDPC1/Q95cAx4I
 1bvgWKvokE79RKFSUaMsdanMz60kgKPHu0canEJitZl5WRXf+F/W7y5Nsau3vTDgLIy0
 yl8tkdDaSVx/CBq8mkVcLc25yti1L0ruKdng9uE7nl0p4p0hyLHTMKtT2Ty2WI8ImE3m
 vgnv6C72qS3bE36mnuOZKZOT+Aiq/hpr3sg4RIu/rkImaV97jw7idgQE/wXasY6M9dsW
 Wh3Oz62n3hbe3FGYXOIfCl8bKGmBp21U9X/GO9q/5P8rlcWfU2s8BlISOfabXQOYMHXN
 o08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534398; x=1769139198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IVpOMjjC9wsrOvoPG6snmAWBzVoq8pPsWgSFbeC5WQ=;
 b=MvlPPSubFXrrXZ9DuwuUbjR44TfBNThAWzlpChIo51Xciw3xl8J/NvPIZRpi7zzonv
 KgCK9QrFC3pkIGMHZjCiE/62LzQXCekHZgGRdV8nyXfEiy9UKe7MlDuIWirDnp53SnQg
 DpQeTh8sEtLcGsJSbmXT15KUxtn/xI2fuySfN0WV3aAJU6ZXqNgnzxs7JKnbgEXqHKEQ
 d+3DNUiOoM6ydBkuBS+zpM97JpchTKhtV76kWGOqIcDD7Q4c08SsiA7BZmgt2M8p95yR
 wthgupKaHYVCyimgDMFFad8W3pmPIhcRsx/G58FBDDi5DS3WrTKeV3cfeD+Mo5w90QA+
 wojg==
X-Gm-Message-State: AOJu0Yy/6VzouJdOBgJ9UI4WXqKsSfQ6eGM2S7pyc5LAkZdJfUonyqPm
 6PNc/eRjd/GtAPkd4SNVntE4792WWFmVem2Z4QZiCuqZ9vMYzsSHGWe2LiYUUOg1O1sVRyXBsOa
 7vWkm7jHE9Q==
X-Gm-Gg: AY/fxX5umXdNHW1OURW0qdpkUB0vhBd20F6XYtoW7vTHHAiO+fKL2A6DageiI3s4jNr
 aB4mvgLEUM1M+QCrdL6kSecuGCdDlEghIYU0uIddnh0PVca1cGWKCWjVBuZiDKMfkK5q22a/LqE
 ksq/MgEFRTnyRq1/AZY986kcfjyrMQI7BD6y7I0yL4DIBJq8h22roI0rnaOpocn3BrEfQomzjOs
 UScaIBaEijWbgD2FLd/PA9ccC0uwFHL4q9ne87gvELCtV1cUnRTbNLTozDSEbgfruvnpUhocM9p
 cqoyb5vyF2a2ELWz2vc5yGOwsuNAALlfh2bXBVY4ct1C+4EdYZQLYI5o75tsLcPzLxtijTQpNTW
 cD2bo5vyW4tLn34JvXN26UnyEPUbp2978Jc4X4FzlK1jHsF16ExsxbcdSyuGRGCRSnBJuXR/SpK
 plGfv87hRyWZlOz/jrcnDYeWNQY0C3
X-Received: by 2002:a17:903:41c8:b0:2a1:360e:53a7 with SMTP id
 d9443c01a7336-2a71887cfabmr14875165ad.13.1768534397516; 
 Thu, 15 Jan 2026 19:33:17 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 00/58] Remove 32-bit host support
Date: Fri, 16 Jan 2026 14:32:06 +1100
Message-ID: <20260116033305.51162-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

32-bit host support was deprecated with the 10.0 release, and so
with the 11.0 release we may remove it.  Phil already did some
cleanup in 10.2, removing support for mips32 and ppc32 within tcg.

Changes for v2:
  - Include wasm64 support, so that removing wasm32 does not
    lose the emstripten feature.
  - Review feedback incorporated.

Patches requiring review:
  05-gitlab-ci-Drop-build-wasm32-32bit.patch
  06-tests-docker-dockerfiles-Drop-wasm32-from-emsdk-w.patch
  07-gitlab-Remove-32-bit-host-testing.patch
  09-meson-Drop-cpu-wasm32-tests.patch
  17-tcg-i386-Remove-TCG_TARGET_REG_BITS-tests.patch
  52-target-s390x-Simplify-atomicity-check-in-do_csst.patch


r~


Kohei Tokunaga (4):
  meson: Add wasm64 support to the --cpu flag
  configure: Enable to propagate -sMEMORY64 flag to Emscripten
  dockerfiles: Add support for wasm64 to the wasm Dockerfile
  gitlab-ci: Add build tests for wasm64

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

 accel/tcg/atomic_template.h                   |    4 +-
 accel/tcg/tcg-runtime.h                       |   23 -
 bsd-user/syscall_defs.h                       |    2 +-
 host/include/i386/host/cpuinfo.h              |   41 -
 host/include/i386/host/crypto/aes-round.h     |  152 -
 host/include/i386/host/crypto/clmul.h         |   29 -
 host/include/ppc/host/cpuinfo.h               |   30 -
 host/include/ppc/host/crypto/aes-round.h      |  182 -
 host/include/ppc64/host/cpuinfo.h             |   31 +-
 host/include/ppc64/host/crypto/aes-round.h    |  183 +-
 .../include/{riscv => riscv64}/host/cpuinfo.h |    0
 host/include/x86_64/host/cpuinfo.h            |   42 +-
 host/include/x86_64/host/crypto/aes-round.h   |  153 +-
 host/include/x86_64/host/crypto/clmul.h       |   30 +-
 include/accel/tcg/cpu-ldst-common.h           |    9 -
 include/block/block_int-common.h              |    3 +-
 include/qemu/atomic.h                         |   39 +-
 include/qemu/cacheflush.h                     |    2 +-
 include/qemu/osdep.h                          |    6 +-
 include/qemu/processor.h                      |    2 +-
 include/qemu/stats64.h                        |  199 -
 include/qemu/timer.h                          |    9 -
 include/system/cpu-timers-internal.h          |    2 +-
 include/tcg/helper-info.h                     |    2 +-
 .../tcg/target-reg-bits.h                     |    8 +-
 include/tcg/tcg-op.h                          |    9 +-
 include/tcg/tcg-opc.h                         |    9 +-
 include/tcg/tcg.h                             |   29 +-
 linux-user/include/host/arm/host-signal.h     |   43 -
 linux-user/include/host/i386/host-signal.h    |   38 -
 .../host/{mips => mips64}/host-signal.h       |    0
 linux-user/include/host/ppc/host-signal.h     |   39 -
 .../host/{riscv => riscv64}/host-signal.h     |    0
 migration/migration-stats.h                   |   36 +-
 tcg/aarch64/tcg-target-reg-bits.h             |   12 -
 tcg/arm/tcg-target-con-set.h                  |   47 -
 tcg/arm/tcg-target-con-str.h                  |   26 -
 tcg/arm/tcg-target-has.h                      |   73 -
 tcg/arm/tcg-target-mo.h                       |   13 -
 tcg/arm/tcg-target-reg-bits.h                 |   12 -
 tcg/arm/tcg-target.h                          |   73 -
 tcg/i386/tcg-target-reg-bits.h                |   16 -
 tcg/loongarch64/tcg-target-reg-bits.h         |   21 -
 tcg/mips/tcg-target-reg-bits.h                |   16 -
 tcg/{mips => mips64}/tcg-target-con-set.h     |    0
 tcg/{mips => mips64}/tcg-target-con-str.h     |    0
 tcg/{mips => mips64}/tcg-target-has.h         |    0
 tcg/{mips => mips64}/tcg-target-mo.h          |    0
 tcg/{mips => mips64}/tcg-target.h             |    0
 tcg/{ppc => ppc64}/tcg-target-con-set.h       |    0
 tcg/{ppc => ppc64}/tcg-target-con-str.h       |    0
 tcg/{ppc => ppc64}/tcg-target-has.h           |    0
 tcg/{ppc => ppc64}/tcg-target-mo.h            |    0
 tcg/{ppc => ppc64}/tcg-target.h               |    0
 tcg/riscv/tcg-target-reg-bits.h               |   19 -
 tcg/{riscv => riscv64}/tcg-target-con-set.h   |    0
 tcg/{riscv => riscv64}/tcg-target-con-str.h   |    0
 tcg/{riscv => riscv64}/tcg-target-has.h       |    0
 tcg/{riscv => riscv64}/tcg-target-mo.h        |    0
 tcg/{riscv => riscv64}/tcg-target.h           |    0
 tcg/s390x/tcg-target-reg-bits.h               |   17 -
 tcg/sparc64/tcg-target-reg-bits.h             |   12 -
 tcg/tcg-has.h                                 |    5 -
 tcg/tcg-internal.h                            |   21 +-
 tcg/tci/tcg-target-has.h                      |    2 -
 tcg/tci/tcg-target-mo.h                       |    2 +-
 tcg/tci/tcg-target-reg-bits.h                 |   18 -
 tcg/{i386 => x86_64}/tcg-target-con-set.h     |    0
 tcg/{i386 => x86_64}/tcg-target-con-str.h     |    0
 tcg/{i386 => x86_64}/tcg-target-has.h         |    8 +-
 tcg/{i386 => x86_64}/tcg-target-mo.h          |    0
 tcg/{i386 => x86_64}/tcg-target.h             |   13 +-
 accel/kvm/kvm-all.c                           |    2 +-
 accel/qtest/qtest.c                           |    4 +-
 accel/tcg/cputlb.c                            |   37 +-
 accel/tcg/icount-common.c                     |   25 +-
 accel/tcg/tcg-runtime.c                       |   15 -
 accel/tcg/translator.c                        |    4 +-
 accel/tcg/user-exec.c                         |    2 -
 block/io.c                                    |   10 +-
 block/qapi.c                                  |    2 +-
 disas/disas-host.c                            |    9 -
 hw/display/xenfb.c                            |   10 +-
 hw/virtio/virtio-mem.c                        |    2 +-
 linux-user/arm/cpu_loop.c                     |   19 +-
 linux-user/hppa/cpu_loop.c                    |   14 +-
 linux-user/mmap.c                             |    2 +-
 linux-user/syscall.c                          |    9 -
 migration/cpu-throttle.c                      |    4 +-
 migration/migration-stats.c                   |   16 +-
 migration/migration.c                         |   24 +-
 migration/multifd-nocomp.c                    |    2 +-
 migration/multifd-zero-page.c                 |    4 +-
 migration/multifd.c                           |   12 +-
 migration/qemu-file.c                         |    6 +-
 migration/ram.c                               |   30 +-
 migration/rdma.c                              |    8 +-
 system/dirtylimit.c                           |    2 +-
 target/arm/ptw.c                              |   18 +-
 target/arm/tcg/gengvec.c                      |   32 +-
 target/arm/tcg/gengvec64.c                    |    4 +-
 target/arm/tcg/translate-sve.c                |   26 +-
 target/hppa/op_helper.c                       |    6 +-
 target/i386/cpu.c                             |   10 -
 target/m68k/op_helper.c                       |    7 +-
 target/s390x/tcg/mem_helper.c                 |   18 +-
 tcg/optimize.c                                |  322 --
 tcg/region.c                                  |   12 -
 tcg/tcg-op-gvec.c                             |  113 +-
 tcg/tcg-op-ldst.c                             |  130 +-
 tcg/tcg-op-vec.c                              |   14 +-
 tcg/tcg-op.c                                  |  765 +---
 tcg/tcg.c                                     |  376 +-
 tcg/tci.c                                     |   73 +-
 tests/unit/test-rcu-list.c                    |   17 +-
 util/atomic64.c                               |   85 -
 util/cacheflush.c                             |    4 +-
 util/qsp.c                                    |   12 +-
 util/stats64.c                                |  148 -
 .gitlab-ci.d/buildtest.yml                    |   17 +-
 .gitlab-ci.d/container-cross.yml              |   17 +-
 .gitlab-ci.d/container-template.yml           |    4 +-
 .gitlab-ci.d/containers.yml                   |    4 +-
 .gitlab-ci.d/crossbuilds.yml                  |   45 -
 MAINTAINERS                                   |   18 +-
 accel/tcg/atomic_common.c.inc                 |   32 -
 accel/tcg/ldst_atomicity.c.inc                |  149 +-
 common-user/host/arm/safe-syscall.inc.S       |  108 -
 common-user/host/i386/safe-syscall.inc.S      |  127 -
 .../host/{mips => mips64}/safe-syscall.inc.S  |    0
 common-user/host/ppc/safe-syscall.inc.S       |  107 -
 .../{riscv => riscv64}/safe-syscall.inc.S     |    0
 configure                                     |   64 +-
 docs/about/deprecated.rst                     |   29 -
 docs/about/removed-features.rst               |    6 +
 docs/devel/tcg-ops.rst                        |   32 +-
 host/include/i386/host/bufferiszero.c.inc     |  125 -
 host/include/x86_64/host/bufferiszero.c.inc   |  121 +-
 meson.build                                   |  105 +-
 target/i386/tcg/emit.c.inc                    |   39 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |   56 +-
 tcg/arm/tcg-target-opc.h.inc                  |   16 -
 tcg/arm/tcg-target.c.inc                      | 3489 -----------------
 tcg/loongarch64/tcg-target.c.inc              |    4 +-
 tcg/{mips => mips64}/tcg-target-opc.h.inc     |    0
 tcg/{mips => mips64}/tcg-target.c.inc         |    0
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc       |    0
 tcg/{ppc => ppc64}/tcg-target.c.inc           |    2 +-
 tcg/{riscv => riscv64}/tcg-target-opc.h.inc   |    0
 tcg/{riscv => riscv64}/tcg-target.c.inc       |    4 +-
 tcg/tci/tcg-target.c.inc                      |   84 +-
 tcg/{i386 => x86_64}/tcg-target-opc.h.inc     |    0
 tcg/{i386 => x86_64}/tcg-target.c.inc         |  552 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} |   19 +-
 util/meson.build                              |    4 -
 155 files changed, 1211 insertions(+), 8446 deletions(-)
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
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (92%)

-- 
2.43.0


