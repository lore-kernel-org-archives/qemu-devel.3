Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB18E6FE4D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzL-00031C-O2; Fri, 06 Sep 2024 23:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzF-0002wj-GT
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzA-0004qO-Va
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2021c08b95cso29383835ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679177; x=1726283977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3tMqY8rCxLTkE8ayemTC/1nbep0EmXZkXPq/OsTmB1Y=;
 b=OceazGu6oHsXI417EaSgzTjS2yd0HQMRzZ06Nayl/hZ3JU2pQzdxZ6u+uFxs8aaY2B
 OyC+Lg7AZdbclWxnBgDfegBCnDFQXK+SGDlb6wZh+LzuJzFNQoEdMYhfq8BhDbgkBeSb
 wPnmqBObkkHYCvXyZCQ6kaZw3bn0ZyHMzhqR0L6fTIs2h1SXKivM/Pf2LGy8NOfghzxz
 rP+zP2+hBzNTfCess74llifJ4W55DdSi1540FsEe/+qhHq02PmfF19DTYYq8FQhy6xEF
 vrWXgyqOmdDQSMDcKRbHNaPqgUe/TCo3UzQvOc1kCxxZpSlMM+FWby8JoT06nWLXXxf7
 003g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679177; x=1726283977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3tMqY8rCxLTkE8ayemTC/1nbep0EmXZkXPq/OsTmB1Y=;
 b=PYyx5HyE9kguc7kqMlDRj00xt5alwmfiJu0MMwPYor833H9Zqjkx1/hIf533cxPOqL
 egibgTqqq+Xvd1IfnTMnyVRmCaanB/NhHuJmIWhf9E4D8IuQbsBbVKnerULy13OQZrfu
 Hnzz9qfEs8rk3LGQU+q6IOrA9FEktLhAdjW/kHJ3vGj3xPgR3JiljQmDK7/DL4lEG9di
 cYkYpbg0/GSt5IxSEIXyxmKRiVrXQDQyVKfOiaBOBq9yUjRvSAqmk/60eW16X3Y8Rp0G
 PTjal9BBCj/TKcr87fpqG6wfzanOFs8O+i9N6LZvMTOe4/edUxAjc7imxAjLDZXcc4Hj
 OcdA==
X-Gm-Message-State: AOJu0YxtCEviPTZ+nNrjZZMKg0fCO3tlm1JvTdlGPw7YxttMmLcpA8Mq
 M++7tC6OxEUFq5ICy9oebP+4EgzAcsr0XIHf+VaqBe1LxQXHNW7VzsFxlg==
X-Google-Smtp-Source: AGHT+IH5Jptvbn9XplNjJ9u0aamR8JJy5OL+mAW8b5pMPPnF4+krZNoEpBXJv4s1dQJUMcmWVesCrQ==
X-Received: by 2002:a17:903:283:b0:205:656d:5f46 with SMTP id
 d9443c01a7336-206b8461b10mr192565515ad.28.1725679176918; 
 Fri, 06 Sep 2024 20:19:36 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:36 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v5 00/17] bsd-user: Comprehensive RISCV Support
Date: Sat,  7 Sep 2024 13:19:10 +1000
Message-Id: <20240907031927.1908-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x631.google.com
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

Key Changes Compared to Version 4:
Minor formatting changes

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
 bsd-user/riscv/target_arch_sigtramp.h |  42 +++++++
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


