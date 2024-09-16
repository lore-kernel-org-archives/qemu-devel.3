Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B31C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE0n-0006KD-J3; Mon, 16 Sep 2024 11:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0l-0006JS-D0; Mon, 16 Sep 2024 11:51:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0j-0000T1-KH; Mon, 16 Sep 2024 11:51:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2057835395aso53611245ad.3; 
 Mon, 16 Sep 2024 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501891; x=1727106691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bBtvoVox2RUSeTNQwgs4Yx+VK6plG325eHNyeYJHDms=;
 b=kGF2ossFGXqReMTt3XVbCXA4mm5g0HZlD8ThWRJZ1u5INZDstTpENxb5SXfRsJE7t0
 2ZevJbOANd07A3XVTPjSC2pu7BD75llyV5+9k6DKpwlY/zP70N1XYEVtR0FGtN8GUXyy
 erc80spAs6D0PTkmETbWj2rgzTvHv/b2TXA97GHmLhEhC0r7YYE1ubCLnY2LvBuqRO5o
 kM1Z8p+aLJz/rHakJ+QTEOgU2kXczTyAAbsnRfKUbkUbwL4zqcN4PU9RdSIFq5+QnFPw
 P5ZDTozzP6cCFClWT0wK0+8C3MnEGv9IJTvnmpU0WfPibQ4Y9eKQOpdMBxmW5/aL37Xe
 xzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501891; x=1727106691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bBtvoVox2RUSeTNQwgs4Yx+VK6plG325eHNyeYJHDms=;
 b=cM3oZAGOw4ZAyoek8MJrKC5fHV/XTRTNVadT4otPuAJVJ3CmA81OkVEYV1O91LjUNW
 N7SCf1xEQKI7PvrvO0/bWEcz1lq8TWil9c00op/OFchBwzWUHZDnivtB2/SRAYyQGo1T
 2S4JTIBrLfoSJS4Et135c/y8RHHWXWdriv6cvE4YXBWHxSWIVJGmeuh6m78C9hmpfj8u
 BaDaHbalKsNAxqH8SeakvxBB/ac8RjVKc1aoSO6HJi9nUkMM3n/8Lqu+K+gOdwh/dMYW
 WQFRWINJ40771U025OwXCWHk0RhSPnuONm5A3Y8+lnvapL/S2W7rgWI5TMJaCfBqtv0p
 mM8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/bNVF8iLYG2tP2qoIXppJNoM3p2hqTAyVVLnxAzQrqtTn0Q5hnyB3KUkYNhYhW5rU8HjeVydt1vS@nongnu.org
X-Gm-Message-State: AOJu0YxUhjoPY2QWumqmcLVZC533hpb2S85/NJPNC7Rl2ieQb5+t+YSv
 7zchQODryuOt4rLKDFb0L492q25QVqi9S4We2ztDhGvgQxMshcAicRUwfurG
X-Google-Smtp-Source: AGHT+IFkrxqg1J629tZEzrB779L8AnNm4k8pQoQf3hXbKEdGkDmCPo6or8rL9kd34/bP/ogJA+vbsw==
X-Received: by 2002:a17:903:22c3:b0:206:bbaa:84e9 with SMTP id
 d9443c01a7336-2076e3eaadfmr247964125ad.47.1726501890582; 
 Mon, 16 Sep 2024 08:51:30 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:30 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v7 00/17] bsd-user: Comprehensive RISCV Support
Date: Tue, 17 Sep 2024 01:51:02 +1000
Message-Id: <20240916155119.14610-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62b.google.com
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

Key Changes Compared to Version 6:
Included "signal-common.h" in target_arch_cpu.h

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
 bsd-user/riscv/target_arch_cpu.h      | 148 ++++++++++++++++++++++
 bsd-user/riscv/target_arch_elf.h      |  42 +++++++
 bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
 bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
 bsd-user/riscv/target_arch_sigtramp.h |  41 +++++++
 bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
 bsd-user/riscv/target_arch_thread.h   |  47 +++++++
 bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
 bsd-user/riscv/target_syscall.h       |  38 ++++++
 configs/targets/riscv64-bsd-user.mak  |   4 +
 14 files changed, 823 insertions(+)
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


