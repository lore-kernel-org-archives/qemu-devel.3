Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A4C5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 01:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdgTo-0006FN-Nb; Fri, 23 Feb 2024 20:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTl-0006Eg-H3
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:25 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTi-0006qR-Mz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:24 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso1023991a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708736721; x=1709341521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVVwWHYL5fqEiUV6/+r1NeamRJp1tuqDaCQyL3sc6a4=;
 b=FJjwYJM5KJdTpuJp3CZ8P8dlhpPV2HJBAQ7kkvd6gymIAw5Aa1ZKSBa+EXOOrhBhqh
 BjDyBZ8osf1cKA4Jet2ZdyPfCaBb7/lYrSB8bhWgaQA46z6B+TmNqASBJ/BZxuIb0YB+
 eVoWt5oQdAT46gUfOHgCS03ZjwmE7a3d/Bhi6qHaHpIdPFTV+VbBYsg4M/Ib+xlOzxTs
 2Wc6XSQRiyEFkF8SP+j2lwCSor7rikLZoBD9Qm62CQqNPGT/ZI1KbD8Ok35OZzjiju4B
 2340Bq04JmPFEb9knjhsJEzi7pJuHBQRuxw8KgL4N4wtDViJ1bmK0eUofjItVKQxc1gh
 Y3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708736721; x=1709341521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVVwWHYL5fqEiUV6/+r1NeamRJp1tuqDaCQyL3sc6a4=;
 b=g2DYQ+/f4dobEtEzBi5TLue/0exnZbCg4oUeWsdc9yyQfcg5LDYF+f2SDAFEfgnzDa
 kc9TdgxtzWDJ1AFZx4bmidADkN/rxh0IEzB/sY+F2qYoWwOxbtmNmXSGb+XL/DJmjX5c
 jvcbVZvwzgUoGartTUABCS+wul+LeBTvwcIF8BN26rdSrUpqp6BrZnRklk8iDVMU8xAj
 tGhO+IRSBjM0S/YhfTJQE/oFaLqWpN8gZDSG9XuboTteSvOxHTxlPpuoWvbM1rVDZyXM
 KceQMXNeibMLV5sAIazCbqUtz+yDBwIjGmrqHv6ZPPEU7+wU/D4Pri/PChmL36EXcTC/
 kNiA==
X-Gm-Message-State: AOJu0YydbBjc3kqTHK4xW+gm9AbhQJzpB59zGnnGSakX2QSvL0w/Elug
 ksjIwAFbJdBoacAJyGdsb+rL1XleWdd7YWxPTseU8EcDYOud5b9nXW7CNafS/hDfTuaV8n6acY6
 S
X-Google-Smtp-Source: AGHT+IFyPpnPmU/vXpCYV5shQAxAJdbvmS0TmtEbIIfQBgWPuWBTKwp24lxAYbYuNUn7F8t4DCAVPQ==
X-Received: by 2002:a05:6a21:1799:b0:1a0:9939:c7f9 with SMTP id
 nx25-20020a056a21179900b001a09939c7f9mr1936939pzb.13.1708736720847; 
 Fri, 23 Feb 2024 17:05:20 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a62e311000000b006ddc7ed6edfsm93513pfh.51.2024.02.23.17.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 17:05:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/39] tcg and linux-user patch queue
Date: Fri, 23 Feb 2024 15:05:15 -1000
Message-Id: <20240224010517.619640-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2: Fix bsd-user build errors.


r~


The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:

  Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240222-2

for you to fetch changes up to fcc6ad372f56d3f47b6d5457a904916b48b9e114:

  linux-user: Remove pgb_dynamic alignment assertion (2024-02-23 15:07:03 -0800)

----------------------------------------------------------------
tcg/aarch64: Apple does not align __int128_t in even registers
accel/tcg: Fixes for page tables in mmio memory
linux-user: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
migration: Remove qemu_host_page_size
hw/tpm: Remove qemu_host_page_size
softmmu: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
linux-user: Split and reorganize target_mmap.
*-user: Deprecate and disable -p pagesize
linux-user: Allow TARGET_PAGE_BITS_VARY
target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
linux-user: Remove pgb_dynamic alignment assertion

----------------------------------------------------------------
Jonathan Cameron (1):
      tcg: Avoid double lock if page tables happen to be in mmio memory.

Peter Maydell (1):
      accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

Richard Henderson (37):
      tcg/aarch64: Apple does not align __int128_t in even registers
      accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
      linux-user: Adjust SVr4 NULL page mapping
      linux-user: Remove qemu_host_page_{size, mask} in probe_guest_base
      linux-user: Remove qemu_host_page_size from create_elf_tables
      linux-user/hppa: Simplify init_guest_commpage
      linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
      linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
      linux-user: Remove qemu_host_page_{size, mask} from mmap.c
      linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
      linux-user: Remove HOST_PAGE_ALIGN from mmap.c
      migration: Remove qemu_host_page_size
      hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
      softmmu/physmem: Remove qemu_host_page_size
      softmmu/physmem: Remove HOST_PAGE_ALIGN
      linux-user: Remove qemu_host_page_size from main
      linux-user: Split out target_mmap__locked
      linux-user: Move some mmap checks outside the lock
      linux-user: Fix sub-host-page mmap
      linux-user: Split out mmap_end
      linux-user: Do early mmap placement only for reserved_va
      linux-user: Split out do_munmap
      linux-user: Use do_munmap for target_mmap failure
      linux-user: Split out mmap_h_eq_g
      linux-user: Split out mmap_h_lt_g
      linux-user: Split out mmap_h_gt_g
      tests/tcg: Remove run-test-mmap-*
      tests/tcg: Extend file in linux-madvise.c
      *-user: Deprecate and disable -p pagesize
      cpu: Remove page_size_init
      accel/tcg: Disconnect TargetPageDataNode from page size
      linux-user: Allow TARGET_PAGE_BITS_VARY
      target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
      linux-user: Bound mmap_min_addr by host page size
      target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
      target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
      linux-user: Remove pgb_dynamic alignment assertion

 docs/about/deprecated.rst                 |  10 +
 docs/user/main.rst                        |   3 -
 bsd-user/qemu.h                           |   7 +
 include/exec/cpu-common.h                 |   7 -
 include/hw/core/cpu.h                     |   2 -
 target/alpha/cpu-param.h                  |  16 +-
 target/arm/cpu-param.h                    |   6 +-
 target/ppc/cpu-param.h                    |   9 +-
 tcg/aarch64/tcg-target.h                  |   6 +-
 accel/tcg/cpu-exec.c                      |   8 +
 accel/tcg/cputlb.c                        |  34 +-
 accel/tcg/translate-all.c                 |   1 -
 accel/tcg/user-exec.c                     |  31 +-
 bsd-user/main.c                           |  23 +-
 cpu-target.c                              |  16 -
 hw/tpm/tpm_ppi.c                          |   6 +-
 linux-user/elfload.c                      |  68 +--
 linux-user/main.c                         |  34 +-
 linux-user/mmap.c                         | 767 ++++++++++++++++++------------
 migration/ram.c                           |  22 +-
 system/physmem.c                          |  17 +-
 system/vl.c                               |   1 -
 target/arm/cpu.c                          |  51 +-
 tests/tcg/multiarch/linux/linux-madvise.c |   2 +
 tests/tcg/alpha/Makefile.target           |   3 -
 tests/tcg/arm/Makefile.target             |   3 -
 tests/tcg/hppa/Makefile.target            |   3 -
 tests/tcg/i386/Makefile.target            |   3 -
 tests/tcg/m68k/Makefile.target            |   3 -
 tests/tcg/multiarch/Makefile.target       |   9 -
 tests/tcg/ppc/Makefile.target             |  12 -
 tests/tcg/sh4/Makefile.target             |   3 -
 tests/tcg/sparc64/Makefile.target         |   6 -
 33 files changed, 701 insertions(+), 491 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

