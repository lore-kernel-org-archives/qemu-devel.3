Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6408AE87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHxL-0000IS-HA; Tue, 03 Feb 2026 10:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxK-0000H9-B2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxI-0001Kf-CB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:42 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so76850595e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131078; x=1770735878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DNMvwvqcNxPO7XREDEFoJV31BtUT3xnR6T/fIAPLrIE=;
 b=JOqaf87k8YBl65ziOo14XIAfDRwNbY1QxfH82Jhuk/24VR6V052C1IqH0d6Ft1HJsL
 07nJYjr+CQaQL9U0to2g0igfRNT8ildDEb6sNhAfu8mI/nQ/r0Ez1stimnmwIkmet+1l
 ttRDcC/KsyH+Oxj5UQZMyGBkTtXmNVuEFqRUPIsZUKdBqus2//obaQELJRHUvmbYGoph
 b6gewbATOLnDJDVVBPKUw5GL2ANnbSwCAvXTA9ExvXUeqQS3CTFsOz0GETiPhBqrVRJ8
 GmZkBEdyk5DXqypUJ9cwhnlP/uRJUv7Bn/ZBWOiFfa2MTGI4KD59nPdFQ+3fN9AWcTFu
 w6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131078; x=1770735878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNMvwvqcNxPO7XREDEFoJV31BtUT3xnR6T/fIAPLrIE=;
 b=X+vp8QTabBdt+2IWYSGVGm4aQmam5YC5Xre+oC74jTw4pGxbSRJGFnswDEcOOzb/8H
 jrNjhVk6tPNUz48Hl9KiRN3opKXjBw3bm3Tc044GjQBgM2VtLp8WpNmbteUpY7tMuLZE
 YQf2zHJQ04v79Wh/HLC+wlvgsJ3zJj/3xVyIP8j7FT23Becjp1lQ+4KGYVErEcRgPEb3
 T8dl/SdLICMj2n0LZkdjkWnHp4LS0NYEDY3wldD7Y/+MJXVUiCGU3lzVDPCtNyP8A+cc
 yFAGh/91J6HCwtoaE6NWUA0GTk4/7sucRDt2oIWVkuG2UcLjshvyrTEO4CIRmgccgSQ0
 9brg==
X-Gm-Message-State: AOJu0YyB/B317/qW243Bfnwfnm7VToPOvDWBLqf5UFhdIx/bjPrl4VHG
 PsbvsFOrC1Ew6l9nFP2EvqhEOAUiVlwMai2hzb9x4sKvfGt7NL0Z7hZq5rayb65nUbGjW8aSLSi
 FQtwMCJ0=
X-Gm-Gg: AZuq6aKVeExbhfynhMs+T+a72dqhIny7rpDbXm4aa5GOzTxDPH0ANBwCDcI6TaKTEPv
 nanEhTd7qRGWktR90grkVuh6qNA/WgzdAzvx2tSONMvrHxwuFnZ2yo3t8GfMq7UUX29Xkz0pp9d
 Ou9BVWq52VcEZxOfbVbbcI3ixJFSTl8yr1Cb/u0VvRRUvfsfG2JzH3c3vsCWCftXDxr2z4rHORk
 FyiduKJqoH2bQ9LtoH7zBABgq/vy1xRz/Zz1Z6aYgN/jHpkT21PnQX/UvRZt04BlKyt4Uk/WOjr
 dEFPCNdCw6aI+84dw7XBb/uWtesPL9zXOYTFcxl7RjfKfJIcl10MI/nJ2XaAxsCGC1SzMzYuLJ2
 vHOcPVmJx31LPbqtnIxRZ7udu7Q4nZHP8DnJGPVIuRD1B9F5T3N4ZrMSHTLwMJCJNpjoWGB/Cvm
 LWw8zd5B4jmo2CP2YMOxMamvvtH9SHBSUhTDK6Hhpoj8giqg69qBiXFXd4/8qp
X-Received: by 2002:a05:6000:402a:b0:436:1565:17d5 with SMTP id
 ffacd0b85a97d-43615651bdamr2817681f8f.12.1770131077961; 
 Tue, 03 Feb 2026 07:04:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm54679619f8f.5.2026.02.03.07.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:04:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] Single binary patches for 2026-02-03
Date: Tue,  3 Feb 2026 16:04:05 +0100
Message-ID: <20260203150436.71907-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:

  Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260203

for you to fetch changes up to a63b90ca6ce8d00dee5150b84bbc65428519ef2b:

  disas: Have disas_set_info() take a const CPUState (2026-02-03 14:57:34 +0100)

----------------------------------------------------------------
Various patches related to single binary effort:

- Endianness cleanups on various targets (PPC in particular)
- Few cleanups around target_ulong type on Alpha
- Have CPUClass::disas_set_info() take a const CPUState
----------------------------------------------------------------

Philippe Mathieu-Daudé (29):
  target/ppc: Inline cpu_ldl_data_ra() calls in ICBI helpers
  target/ppc: Inline cpu_ld/st_mmuidx_ra() calls in memory helpers
  target/ppc: Inline cpu_ld/st_data_ra() calls in do_hash()
  target/ppc: Expect page translation hash addresses to be aligned
  target/ppc: Introduce ppc_data_endian_env() helper
  target/ppc: Introduce ppc_code_endian_dc() helper
  target/ppc: Inline need_byteswap() and replace translator_ldl_swap()
  target/ppc: Check endianness via env in ppc_disas_set_info()
  target/ppc: Introduce ppc_env_is_little_endian() helper
  target/ppc: Check endianness at runtime in ppc_data_endian_env()
  target/ppc: Inline cpu_ldl_code() call in ppc_ldl_code()
  target/riscv: Inline cpu_ld[lq]_code() calls
  target/riscv: Inline translator_ld[uw,l,q]() calls
  target/i386: Inline translator_ld[uw,l,q]() calls
  target/m68k: Inline translator_ld[uw,l,q]() calls
  target/alpha: Avoid target-specific migration headers in machine.c
  target/alpha: Build system units in common source set
  target/alpha: Replace target_ulong -> uint64_t in gdb_write_register()
  target/alpha: Do not use target_ulong for trap arguments
  target/alpha: Do not use target_ulong for page table entries / indexes
  target/alpha: Remove target_ulong uses in get_physical_address()
  target/alpha: Expand TCGv type for 64-bit target
  target/arm: Have arm_feature() take a const @env argument
  target/arm: Have cpu_isar_feature() use a const ARMCPU object
  target/arm: Have is_64() take a const @env argument
  target/arm: Have arm_sctlr_b() take a const @env argument
  disas/riscv: Make rv_decode::cfg const
  disas: Make disassemble_info::target_info field const
  disas: Have disas_set_info() take a const CPUState

Pierrick Bouvier (1):
  target-info: add target_base_ppc, target_ppc and target_ppc64

 disas/riscv.h                    |   2 +-
 include/disas/dis-asm.h          |   2 +-
 include/hw/core/cpu.h            |   2 +-
 include/qemu/target-info.h       |  21 +++
 target/arm/cpu-features.h        |   2 +-
 target/arm/cpu.h                 |   6 +-
 target/ppc/internal.h            |  17 +++
 disas/riscv.c                    |   5 +-
 target-info.c                    |  21 +++
 target/alpha/cpu.c               |   3 +-
 target/alpha/gdbstub.c           |   2 +-
 target/alpha/helper.c            |  17 +--
 target/alpha/machine.c           |   3 +-
 target/alpha/translate.c         | 228 ++++++++++++++++---------------
 target/arm/cpu.c                 |   6 +-
 target/avr/cpu.c                 |   2 +-
 target/hexagon/cpu.c             |   3 +-
 target/hppa/cpu.c                |   2 +-
 target/i386/cpu.c                |   6 +-
 target/loongarch/cpu.c           |   3 +-
 target/m68k/cpu.c                |   2 +-
 target/m68k/translate.c          |   6 +-
 target/microblaze/cpu.c          |   2 +-
 target/mips/cpu.c                |   7 +-
 target/openrisc/cpu.c            |   2 +-
 target/ppc/cpu_init.c            |  14 +-
 target/ppc/gdbstub.c             |   2 +-
 target/ppc/mem_helper.c          |  60 +++++---
 target/ppc/tcg-excp_helper.c     |  27 ++--
 target/ppc/translate.c           |  21 +--
 target/riscv/cpu.c               |   7 +-
 target/riscv/translate.c         |  18 ++-
 target/riscv/zce_helper.c        |   8 +-
 target/rx/cpu.c                  |   2 +-
 target/s390x/cpu.c               |   2 +-
 target/sh4/cpu.c                 |   3 +-
 target/sparc/cpu.c               |   3 +-
 target/xtensa/cpu.c              |   3 +-
 target/i386/tcg/decode-new.c.inc |   6 +-
 target/alpha/meson.build         |   2 +-
 40 files changed, 329 insertions(+), 221 deletions(-)

-- 
2.52.0


