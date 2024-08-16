Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67367C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Sl-0003qb-Ar; Fri, 16 Aug 2024 13:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Si-0003pY-Hy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sg-00079r-71
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:03 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d3ec4bacc5so553267a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828200; x=1724433000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCXM3JU5k8hsJzj/wO+fkExLP4ohAwpv+qr22wqEUSs=;
 b=Zp7Acjoa+gjq2sgA2pWy1NNBwvTpWo0qs/XS45YCpnYVWLNvumdkkck2u625Q/LaLK
 Cu3kNFx5xNfGMtXIZQ1jpJP/Y9OFJDAv84s5SFBkb3BSmz2tR7OThXiHbvS2xfJxdQKZ
 rolFN731sEHzzQJi2WNAD0HPHRtga3Tzjp3sxn8YLxcUGyCO8PuLSgOJk5nYeTY0Lci2
 nGb59rWE0a2vgZxs3mjBpJOQTMTuUGxctdp7QLMo8D302+ysn2ioOCm0PzToqGjlVgU0
 jd/JjloCyDdez9kA5fn89ogAgM8k2S4Z668ZrOS4nZY4lV3Ok/myxxVACbzroa3jmT3i
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828200; x=1724433000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCXM3JU5k8hsJzj/wO+fkExLP4ohAwpv+qr22wqEUSs=;
 b=SfqUlFd3Vrq0VDW6yJt6i1gJbB6s5SMg5YmN+1o9n+Zb8FU3ohO/PeYgtQ79jESNer
 RhOyHdBB7fO32Bu7dRhuvBw2LIVG2usR2DQ7bLb/Ac3jdBZrml+ZfPfxbrcMfrRyuaWF
 n3fmGrDqaUBVep4P0w3RaFsoGgoaN8NIeQemv/4l6Zh7xDI5hTZVO010u3y3/b3KMoPm
 tzbUDvpcK62o+qNdZ3cuwRQLAPWfoFnZ6GKN0/SGyA1v5OXuLWRXhGjd21ecJLCUs+6I
 8DbyZBwfg/kHhOPYr9pV2qvY2alqxI7eJqB054dyjdeaYKZ/hZvUB1rMvDI4VaKoZQwf
 nuyQ==
X-Gm-Message-State: AOJu0YxSbPipR0OddB9lHenwdRd3JXHL0hZQeMJZItrLmS6QmR3mDJaw
 pw6+XAyL7ibCQKTi8MCl5DGkSsL6T/b4GAYIkbR8nPEz97TM1Ke1psS0Smj4
X-Google-Smtp-Source: AGHT+IGrB0ovtJU4OPTRC8wzp9e8GdLntpoUOOoRpaKtoxQS0SY6TJaZLYTZSay1BDkxHAyQZxgjqw==
X-Received: by 2002:a17:90a:d254:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2d3e45d3fafmr4982637a91.15.1723828199455; 
 Fri, 16 Aug 2024 10:09:59 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:09:59 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v2 00/17] bsd-user: Comprehensive RISCV Support
Date: Sat, 17 Aug 2024 03:09:32 +1000
Message-Id: <20240816170949.238511-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Key Changes Compared to Version 1:
Patch 3: Array subscript was replaced by a register constant.
Patches 4 and 5: Merged into a single patch.
Patch 6: Comment was removed.
Patch 10: ROUND_DOWN was used to align the stack.
	  Array subscript was replaced by a register constant.
Patch 15: Register constants were used instead of array subscripts.

Mark Corbin (15):
  bsd-user: Implement RISC-V CPU initialization and main loop
  bsd-user: Add RISC-V CPU execution loop and syscall handling
  bsd-user: Implement RISC-V CPU register cloning and reset functions
  bsd-user: Implement RISC-V TLS register setup
  bsd-user: Add RISC-V ELF definitions and hardware capability detection
  bsd-user: Define RISC-V register structures and register copying
  bsd-user: Add RISC-V signal trampoline setup function
  bsd-user: Implement RISC-V sysarch system call emulation
  bsd-user: Add RISC-V thread setup and initialization support
  bsd-user: Define RISC-V VM parameters and helper functions
  bsd-user: Define RISC-V system call structures and constants
  bsd-user: Define RISC-V signal handling structures and constants
  bsd-user: Implement RISC-V signal trampoline setup functions
  bsd-user: Implement 'get_mcontext' for RISC-V
  bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV

Warner Losh (2):
  bsd-user: Add generic RISC-V64 target definitions
  bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files

 bsd-user/riscv/signal.c               | 170 ++++++++++++++++++++++++++
 bsd-user/riscv/target.h               |  20 +++
 bsd-user/riscv/target_arch.h          |  27 ++++
 bsd-user/riscv/target_arch_cpu.c      |  29 +++++
 bsd-user/riscv/target_arch_cpu.h      | 147 ++++++++++++++++++++++
 bsd-user/riscv/target_arch_elf.h      |  42 +++++++
 bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
 bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
 bsd-user/riscv/target_arch_sigtramp.h |  46 +++++++
 bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
 bsd-user/riscv/target_arch_thread.h   |  47 +++++++
 bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
 bsd-user/riscv/target_syscall.h       |  38 ++++++
 configs/targets/riscv64-bsd-user.mak  |   4 +
 14 files changed, 827 insertions(+)
 create mode 100644 bsd-user/riscv/signal.c
 create mode 100644 bsd-user/riscv/target.h
 create mode 100644 bsd-user/riscv/target_arch.h
 create mode 100644 bsd-user/riscv/target_arch_cpu.c
 create mode 100644 bsd-user/riscv/target_arch_cpu.h
 create mode 100644 bsd-user/riscv/target_arch_elf.h
 create mode 100644 bsd-user/riscv/target_arch_reg.h
 create mode 100644 bsd-user/riscv/target_arch_signal.h
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h
 create mode 100644 bsd-user/riscv/target_arch_thread.h
 create mode 100644 bsd-user/riscv/target_arch_vmparam.h
 create mode 100644 bsd-user/riscv/target_syscall.h
 create mode 100644 configs/targets/riscv64-bsd-user.mak

-- 
2.34.1


