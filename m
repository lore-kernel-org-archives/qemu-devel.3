Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745E5CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbQv-00021i-Mu; Thu, 28 Aug 2025 08:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQu-000208-1e
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:48 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQr-00076K-Lv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:47 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b49d98691faso673410a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382923; x=1756987723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/dedOAP/avoU8FHp+X4gnz2Q81zNq7EmxwQLTQuP58Q=;
 b=jDI3RAhYGz/ndFnvwDmbtbNlS1lWhGpzKRVzhnwY2YejbhDhejuWNYz/9ZcdyS/vTi
 yAFV4t7xR8jklFCwLLVLvlvC14OkoeAgDSl4huimbOwToJ34KHg1lJDebR7PueU56zsr
 dWluzr7uAo8/XwmMisC3eGVNNatdWg5bWGvcxB1xW0bvCDlueuIY2z3lHiasqhSovbpZ
 +2A4+7MEt3lD0n78IqhZNI9PendBoBdEpdM++qibhT3fCGlHBzndmLI2hIw2hV29YP2B
 8mfgHyHUfxwZWzeKBK5Jijt9f/dhbqa9iUxunOn2wvavEy4JQuf+uLtMqgPqwtBlvJke
 CMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382923; x=1756987723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/dedOAP/avoU8FHp+X4gnz2Q81zNq7EmxwQLTQuP58Q=;
 b=IE62OwIl1OhLuan9esgdXOcTIv+cz2FeB8YnXYf/82E+rvfuQ1KUN1xZfLkM5iB+6f
 EAhWT9Wze7pWPDuvGsGH7ylOI4WT+jDJocRYUR+4WUcCWVSxA19N+hkocomOufpv1/7H
 287CH2DGT7tMx+dy26BohQqEgq+fXz6CPouK8dMNGoOnnHsgkUeIV1f5GL+lOf95Ya9C
 S961R4B3Fe/GwvqqPujFHjIRDXh8J1/13tHAwC+LJHZY90AzzMMlINYWcjOd5Bh2MPkb
 PxOYKDE/znsIpos6V9emIiV//RvTHc/XtsnNn/KANb4zoPEBpmdVUMi2/9qPZb1nw/3b
 Dang==
X-Gm-Message-State: AOJu0YzX0S8dP9M5fyJCFm1TutOZ8MEf/pcm4cG0sn+bAo9aFX+RuXZp
 wLxJarC4yzig3QVrkM8l0uSvKtV7O4dOl/2nfqLV0RWl5qCNfnzLNjrr/ldapb/F3NIJWXb2rF9
 FSXi0WqY=
X-Gm-Gg: ASbGncsObidOAgr3Qwb59HGwpK2GB2BgOEk3VPR0LV1LnaQZTQboWj+xifZIpHZMXnV
 7v2hg2NY/GrNN/HAiaESaeQCzzzO6vVEdMQuO0VCjNMOtk3X+xNGE8BWx23nUoOGjgbb7T0D5Kq
 IQoLarrX2+0VUztVixPF/UuqNWM8RE7WoghjaHfQxFlkQRT6l7WsXMAJPScpllWIAqNYIrEN45/
 6rICySPPRtQvJ4/9HfQFKH43vhkE0MKC3Cg5S6LwdTbyIuNU2UwoUM12KFnr8NayBy58EK3torZ
 DTxnZq9xiL17DajNAXnE1Kh6okw+LCH2SuS5ya3/qX73QlhRK38W54S9BNgxE0ZBRPz2zcZHMrl
 uWqQ4fCIvXrdNJyIpAahTF13s8YImbmkZ+jPV
X-Google-Smtp-Source: AGHT+IF0xLBzYn+OxreRtIuAmnDbuv4r91k3vRh4WqaBXFS/0HCd/B4kycrAm6k5nAbwKKygP1n2uw==
X-Received: by 2002:a17:902:d4d1:b0:246:96bf:c91c with SMTP id
 d9443c01a7336-24696bfd51emr208258885ad.11.1756382922747; 
 Thu, 28 Aug 2025 05:08:42 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 00/87] linux-user: Split up elfload.c
Date: Thu, 28 Aug 2025 22:07:09 +1000
Message-ID: <20250828120836.195358-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

The goal is to kill the massive target ifdef ladder in elfload.c.

The functions get moved to linux-user/target/elfload.c.
The macros get moved to linux-user/target/target_elf.h.
These are mostly use to parameterize include/elf.h or elfload.c.

The init_thread functions, storing into target_pt_regs, have been
merged with target_cpu_copy_regs, copying out of target_pt_regs
into CPUArchState.  Merging these found a few bits of silliness
where pt_regs fields were initialized but not used.  To encourage
this never to return, remove most target_pt_regs and hide the rest
within the relevant signal.c.

Changes for v3:
  - 48 patches merged to master.
  - Don't eliminate target_elf_gregset_t; instead:
    - Convert the array to a struct, which can be declared abstract,
    - Move ptrace-y structure to target_ptrace.h, if applicable.
    - Use it to define target_elf_gregset_t.
    This resolves Peter's primary objection to v2, which over-simplified
    the interface to elf_core_copy_regs.  As an added benefit, cleans up
    some other really ugly bits.

r~

Richard Henderson (87):
  linux-user/x86_64: Convert target_elf_gregset_t to a struct
  linux-user/i386: Convert target_elf_gregset_t to a struct
  linux-user/arm: Convert target_elf_gregset_t to a struct
  linux-user/aarch64: Convert target_elf_gregset_t to a struct
  linux-user/ppc: Convert target_elf_gregset_t to a struct
  linux-user/loongarch64: Convert target_elf_gregset_t to a struct
  linux-user/mips: Convert target_elf_gregset_t to a struct
  linux-user/microblaze: Convert target_elf_gregset_t to a struct
  linux-user/openrisc: Convert target_elf_gregset_t to a struct
  linux-user/sh4: Convert target_elf_gregset_t to a struct
  linux-user/m68k: Convert target_elf_gregset_t to a struct
  linux-user/s390x: Convert target_elf_gregset_t to a struct
  linux-user/xtensa: Convert target_elf_gregset_t to a struct
  linux-user: Update comment for target_elf_gregset_t
  linux-user: Declare elf_core_copy_regs in loader.h
  linux-user: Rename USE_ELF_CORE_DUMP to HAVE_ELF_CORE_DUMP
  linux-user: Move elf_core_copy_regs to {i386,x86_64}/elfload.c
  linux-user: Move elf_core_copy_regs to arm/elfload.c
  linux-user: Move elf_core_copy_regs to aarch64/elfload.c
  linux-user: Move elf_core_copy_regs to ppc/elfload.c
  linux-user: Move elf_core_copy_regs to loongarch64/elfload.c
  linux-user: Move elf_core_copy_regs to mips/elfload.c
  linux-user: Move elf_core_copy_regs to microblaze/elfload.c
  linux-user: Move elf_core_copy_regs to openrisc/elfload.c
  linux-user: Move elf_core_copy_regs to sh4/elfload.c
  linux-user: Move elf_core_copy_regs to m68k/elfload.c
  linux-user: Move elf_core_copy_regs to s390x/elfload.c
  linux-user: Move elf_core_copy_regs to xtensa/elfload.c
  linux-user: Remove target_elf_greg_t, tswapreg from elfload.c
  linux-user/i386: Create target_ptrace.h
  linux-user/i386: Expand target_elf_gregset_t
  linux-user/x86_64: Create target_ptrace.h
  linux-user/x86_64: Expand target_elf_gregset_t
  linux-user/x86_64: Fix dump of fs_base, gs_base
  linux-user/aarch64: Create target_ptrace.h
  linux-user/aarch64: Expand target_elf_gregset_t
  linux-user/arm: Create target_ptrace.h
  linux-user/arm: Expand target_elf_gregset_t
  linux-user/loongarch64: Create target_ptrace.h
  linux-user/loongarch64: Expand target_elf_gregset_t
  linux-user/m68k: Expand target_elf_gregset_t
  linux-user/microblaze: Create target_ptrace.h
  linux-user/microblaze: Fold target_pt_regs.r* to an array
  linux-user/microblaze: Expand target_elf_gregset_t
  linux-user/mips: Create target_ptrace.h
  linux-user/mips: Use target_ulong for target_elf_greg_t
  linux-user/openrisc: Create target_ptrace.h
  linux-user/openrisc: Expand target_elf_gregset_t
  linux-user/ppc: Create target_ptrace.h
  linux-user/ppc: Expand target_elf_gregset_t
  linux-user/s390x: Create target_ptrace.h
  linux-user/s390x: Expand target_elf_gregset_t
  linux-user/sh4: Create target_ptrace.h
  linux-user/sh4: Expand target_elf_gregset_t
  linux-user/xtensa: Create target_ptrace.h
  linux-user/xtensa: Expand target_elf_gregset_t
  linux-user: Move init_guest_commpage to x86_64/elfload.c
  linux-user: Move init_guest_commpage to arm/elfload.c
  linux-user: Move init_guest_commpage to hppa/elfload.c
  linux-user: Replace init_guest_commpage macro with function
  linux-user: Move get_vdso_image_info to arm/elfload.c
  linux-user: Remove ELF_EXEC_PAGESIZE
  linux-user: Remove redundant ELF_DATA definitons
  linux-user: Move elf parameters to {i386,x86_64}/target_elf.h
  linux-user: Move elf parameters to {arm,aarch64}/target_elf.h
  linux-user: Move elf parameters to sparc/target_elf.h
  linux-user: Move elf parameters to ppc/target_elf.h
  linux-user: Move elf parameters to loongarch64/target_elf.h
  linux-user: Move elf parameters to {mips,mips64}/target_elf.h
  linux-user: Move elf parameters to microblaze/target_elf.h
  linux-user: Move elf parameters to openrisc/target_elf.h
  linux-user: Move elf parameters to sh4/target_elf.h
  linux-user: Move elf parameters to m68k/target_elf.h
  linux-user: Move elf parameters to alpha/target_elf.h
  linux-user: Move elf parameters to s390x/target_elf.h
  linux-user: Move elf parameters to riscv/target_elf.h
  linux-user: Move elf parameters to hppa/target_elf.h
  linux-user: Move elf parameters to xtensa/target_elf.h
  linux-user: Move elf parameters to hexagon/target_elf.h
  linux-user: Standardize on ELF_MACHINE not ELF_ARCH
  linux-user: Rename elf_check_arch
  linux-user: Remove ELIBBAD from elfload.c
  linux-user: Remove MAP_DENYWRITE from elfload.c
  linux-user: Move arch_parse_elf_property to aarch64/elfload.c
  linux-user: Remove a.out declarations from elfload.c
  linux-user/sparc: Create target_ptrace.h
  linux-user: Remove target_pt_regs from target_syscall.h

 linux-user/aarch64/target_elf.h         |  21 +
 linux-user/aarch64/target_ptrace.h      |  14 +
 linux-user/aarch64/target_syscall.h     |   7 -
 linux-user/alpha/target_elf.h           |   3 +
 linux-user/alpha/target_syscall.h       |  40 --
 linux-user/arm/target_elf.h             |  18 +
 linux-user/arm/target_ptrace.h          |  16 +
 linux-user/arm/target_syscall.h         |   8 -
 linux-user/hexagon/target_elf.h         |   3 +
 linux-user/hexagon/target_syscall.h     |   5 -
 linux-user/hppa/target_elf.h            |   8 +
 linux-user/hppa/target_syscall.h        |  18 -
 linux-user/i386/target_elf.h            |  34 +
 linux-user/i386/target_ptrace.h         |  31 +
 linux-user/i386/target_syscall.h        |  18 -
 linux-user/loader.h                     |  21 +
 linux-user/loongarch64/target_elf.h     |  13 +
 linux-user/loongarch64/target_ptrace.h  |  15 +
 linux-user/loongarch64/target_syscall.h |  23 -
 linux-user/m68k/target_elf.h            |  27 +
 linux-user/m68k/target_syscall.h        |  16 -
 linux-user/microblaze/target_elf.h      |  17 +
 linux-user/microblaze/target_ptrace.h   |  20 +
 linux-user/microblaze/target_syscall.h  |  44 --
 linux-user/mips/target_elf.h            |  15 +
 linux-user/mips/target_ptrace.h         |  17 +
 linux-user/mips/target_syscall.h        |  19 -
 linux-user/mips64/target_elf.h          |  21 +
 linux-user/mips64/target_ptrace.h       |  16 +
 linux-user/mips64/target_syscall.h      |  16 -
 linux-user/openrisc/target_elf.h        |  15 +
 linux-user/openrisc/target_ptrace.h     |  13 +
 linux-user/openrisc/target_syscall.h    |  11 -
 linux-user/ppc/target_elf.h             |  56 ++
 linux-user/ppc/target_ptrace.h          |  26 +
 linux-user/ppc/target_syscall.h         |  28 -
 linux-user/riscv/target_elf.h           |  10 +
 linux-user/riscv/target_syscall.h       |  35 -
 linux-user/s390x/target_elf.h           |  15 +
 linux-user/s390x/target_ptrace.h        |  18 +
 linux-user/s390x/target_syscall.h       |  22 -
 linux-user/sh4/target_elf.h             |  14 +
 linux-user/sh4/target_ptrace.h          |  18 +
 linux-user/sh4/target_syscall.h         |  11 -
 linux-user/sparc/target_elf.h           |  11 +
 linux-user/sparc/target_ptrace.h        |  24 +
 linux-user/sparc/target_syscall.h       |  19 -
 linux-user/x86_64/target_elf.h          |  16 +
 linux-user/x86_64/target_ptrace.h       |  40 ++
 linux-user/x86_64/target_syscall.h      |  28 -
 linux-user/xtensa/target_elf.h          |  15 +
 linux-user/xtensa/target_ptrace.h       |  22 +
 linux-user/xtensa/target_syscall.h      |  35 -
 linux-user/aarch64/elfload.c            |  29 +
 linux-user/arm/elfload.c                |  76 ++
 linux-user/elfload.c                    | 918 +-----------------------
 linux-user/hppa/elfload.c               |  31 +
 linux-user/i386/elfload.c               |  22 +
 linux-user/loongarch64/elfload.c        |  15 +
 linux-user/m68k/elfload.c               |  25 +
 linux-user/microblaze/elfload.c         |  13 +
 linux-user/microblaze/signal.c          |  71 +-
 linux-user/mips/elfload.c               |  18 +
 linux-user/openrisc/elfload.c           |  10 +
 linux-user/openrisc/signal.c            |   3 +-
 linux-user/ppc/elfload.c                |  15 +
 linux-user/s390x/elfload.c              |  14 +
 linux-user/s390x/signal.c               |   1 +
 linux-user/sh4/elfload.c                |  15 +
 linux-user/sparc/signal.c               |   2 +
 linux-user/x86_64/elfload.c             |  52 ++
 linux-user/xtensa/elfload.c             |  20 +
 72 files changed, 1043 insertions(+), 1353 deletions(-)
 create mode 100644 linux-user/aarch64/target_ptrace.h
 create mode 100644 linux-user/arm/target_ptrace.h
 create mode 100644 linux-user/i386/target_ptrace.h
 create mode 100644 linux-user/loongarch64/target_ptrace.h
 create mode 100644 linux-user/microblaze/target_ptrace.h
 create mode 100644 linux-user/mips/target_ptrace.h
 create mode 100644 linux-user/mips64/target_ptrace.h
 create mode 100644 linux-user/openrisc/target_ptrace.h
 create mode 100644 linux-user/ppc/target_ptrace.h
 create mode 100644 linux-user/s390x/target_ptrace.h
 create mode 100644 linux-user/sh4/target_ptrace.h
 create mode 100644 linux-user/sparc/target_ptrace.h
 create mode 100644 linux-user/x86_64/target_ptrace.h
 create mode 100644 linux-user/xtensa/target_ptrace.h

-- 
2.43.0


