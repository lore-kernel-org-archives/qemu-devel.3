Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C912C3ABA4
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr8g-0005OR-RA; Sun, 15 Sep 2024 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8d-0005Nq-7O
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8b-00089W-Ij
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20551e2f1f8so27338565ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413967; x=1727018767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2CIVaOsJyx0xl/tJKXU94DniFfARDg5CfcNJk6ZugCU=;
 b=l4AiN5yp4ByPC5Hr3nx89BtsZhNJWVtcN1GlnpuNUScud6NbrcKmMpIjZ0/icto6zt
 q2a30OLBAnQUtI9Lo4k/oAIPJ08Kzzt7IElLWhTbBlndITRqngGoHJn/QWX4FkSrwTyG
 u8GLCNAlPEQqBHNUd+/qER+/7dPEd9Lt7Hf0eMDh3GL1JIfY+RERYYX+8t9to3CYu/C/
 RBoFLa43sJVwkxB6VOXbAE2mOGSTxxkR29y0PYWuf/OF25jtx/RUy8CTlIp9EPKAtg6n
 xusWtqsOPB5zo9XyaXFOTMD81IruB01Ha/nW0cKP2jpoNqJflwDfzXqVj6CPxvs9c8Sy
 mHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413967; x=1727018767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CIVaOsJyx0xl/tJKXU94DniFfARDg5CfcNJk6ZugCU=;
 b=GqKIr2bXUSSNj/UNLf3rFFgbjQPiT1V3NaCn/T957TuzZcvUBURJv1MP63J6PbmH4z
 D3c4aouCWNrN1aqWRe8TaB0/sM88ZxFMWo8Sxrzy2Lj2SKZy4+mP8CPDWOjQbzVqmBDL
 YIB6yRMVxzcK7dsdGKZNYpVYV1PQWspW37aT9M0GzH03/yVzRe1fSAS+ujSWvks4Ax82
 dWgKR3LQnQ6NG0yTNpqOWIAOg2bnM4RYGgSqEktNNDPpn82GH6QeYPUwPTgtxJf405sU
 lcl+eRrJU4XOQjKTlXRhheFs73/PJxZMdhxxJmLbVOxqTkdHix2iZ5+jEYK4viuPZa8l
 l3Bw==
X-Gm-Message-State: AOJu0YwAdf3EhX1vcVq8cgctdrApPoDFP9S8ZYYnbPGGcu/Vt+ri7CFx
 EfsaHMHoI0+jQGh8d3cJbY6lAbbXEUuSzPLCA5SaOFnuyggpK/iw0ihPpw==
X-Google-Smtp-Source: AGHT+IHBMw0DC9BVzRU7/FSamRSJhpPwUWjShMu2Hjaycg9yPcWUoT/gOM1N0tSwt8LE7tx1MWt7cA==
X-Received: by 2002:a17:902:e80c:b0:207:20c5:42c with SMTP id
 d9443c01a7336-20782a69ebemr155622365ad.45.1726413966393; 
 Sun, 15 Sep 2024 08:26:06 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:05 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v6 00/17] bsd-user: Comprehensive RISCV Support
Date: Mon, 16 Sep 2024 01:25:37 +1000
Message-Id: <20240915152554.8394-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Key Changes Compared to Version 5:
In target_arch_sigtramp.h removed static const,
as there was a compile-time constant issue

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
 bsd-user/riscv/target_arch_sigtramp.h |  41 +++++++
 bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
 bsd-user/riscv/target_arch_thread.h   |  47 +++++++
 bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
 bsd-user/riscv/target_syscall.h       |  38 ++++++
 configs/targets/riscv64-bsd-user.mak  |   4 +
 14 files changed, 822 insertions(+)
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


