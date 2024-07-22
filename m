Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB20C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0q3-0005Bl-Db; Mon, 22 Jul 2024 17:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0pt-00051l-KN
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:50 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0pq-0004HB-7z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:48 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7f70a708f8aso195010239f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684682; x=1722289482;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mcZb5YItFOMqqJrIuqjuWAfUzsfp40iXsHzNY3+LniI=;
 b=bW39cLkuzQIbfXRB5IXR1T4ogc0+HrGeHaAptQ+Hktv2jaxz+T4S0KvXEb4yoqvPik
 ggkpNEU77QQ8sBIooQncxyVA1ur6bmHGKZNZt2wA9ekGgHnMzIokBAoPCZVJblqHHjT5
 J7Ws1mXXbtI5D3N1cEfzcW8W0LnAFIm5kjRP9YG7rJmS+Ove+JCB0j0GGPFub6VodLNM
 Qo48+dZV6nJwxEk/jPahb+nWrbzIzIESm8CRwRcpOy0tzD3rHtMjGHm4fSE3K2AS0vxI
 rlhUijMZbHgQiyNbUX2scqULlG91l0zA7+jLnOEa0gh1VSRv3TcI0uXU6UQshReU1pwH
 UY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684682; x=1722289482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mcZb5YItFOMqqJrIuqjuWAfUzsfp40iXsHzNY3+LniI=;
 b=MbJFFElHEdOm62WZcb/vyPnYpYL0AFYs+Nv2e3rrhY9sHPrIzSMXzEDZA0oUA83aMU
 nuK41uc2rdNuhs0wvzt8v2t3+G8olWqK7nJf8g8VYj35LjVMJCyeYbhkT1P6KL/q9xSP
 8SaLDFn+n6EwJ1ZwNbLhv4WbCULXDJYDZMGy9t8YblMLSkuk+nByq+/QuRrTdLBgIhg6
 bH2yD+iMv6bM+OW2VeiZNf0dLZ8+yar/miBEar1yhS8K9Y353sx6oh3znoquv1WO4YGc
 NQjKr4w1E7S63EwprOY30Yd4nZmt7g24hGQE6bJJkcCch9unsowyvGaqsFVos7BjPsUg
 Zagw==
X-Gm-Message-State: AOJu0YxD8k/mJWybXfuO8o6GPI5zSGnGUXEFduuX+Vr4blCfozCBnBQ8
 a/F9dmnVIEqx1F24+9gshG7KX7uC/8rYhel11nyzFzP9evjJhyHnSVYIdQUCh9tRG2Z0kogFTMB
 LXio=
X-Google-Smtp-Source: AGHT+IFQBrheJxH3hpcGT94Cvgq8hrIIMBtG42ne79yKTqkBnD+2ZDNE0qhMeDrUceGG9I0q0xg9QA==
X-Received: by 2002:a05:6602:2ccb:b0:804:b327:52d5 with SMTP id
 ca18e2360f4ac-81ea30a2126mr148544939f.4.1721684682374; 
 Mon, 22 Jul 2024 14:44:42 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 00/14] bsd-user: Misc changes for 9.1 (I hope)
Date: Mon, 22 Jul 2024 15:42:59 -0600
Message-ID: <20240722214313.89503-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This patch series includes two main sets of patches. To make it simple to
review, I've included the changes from my student which the later changes depend
on. I've included a change from Jessica and Doug as well. I've reviewed them,
but more eyes never hurt.

I've also included a number of 'touch up' patches needed either to get the
aarch64 building, or to implmement suggestions from prior review cycles. The
main one is what's charitably described as a kludge: force aarch64 to use 4k
pages. The qemu-project (and blitz branch) hasn't had the necessary changes to
bsd-user needed to support variable page size.

Sorry this is so late... Live has conspired to delay me.

Doug Rabson (1):
  bsd-user: Simplify the implementation of execve

Jessica Clarke (1):
  bsd-user: Sync fork_start/fork_end with linux-user

Stacey Son (6):
  bsd-user:Add CPU initialization and management functions
  bsd-user:Add AArch64 register handling and related functions
  bsd-user:Add ARM AArch64 signal handling support
  bsd-user:Add get_mcontext function for ARM AArch64
  bsd-user:Add set_mcontext function for ARM AArch64
  bsd-user:Add AArch64 improvements and signal handling functions

Warner Losh (6):
  bsd-user:Add ARM AArch64 support and capabilities
  bsd-user:Add setup_sigframe_arch function for ARM AArch64
  bsd-user: Hard wire aarch64 to be 4k pages only
  bsd-user: Define TARGET_SIGSTACK_ALIGN and use it to round stack
  bsd-user: Make compile for non-linux user-mode stuff
  bsd-user: Add aarch64 build to tree

 bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
 bsd-user/aarch64/target_arch.h          |  29 ++++
 bsd-user/aarch64/target_arch_cpu.c      |  31 ++++
 bsd-user/aarch64/target_arch_cpu.h      | 189 ++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_elf.h      | 163 ++++++++++++++++++++
 bsd-user/aarch64/target_arch_reg.h      |  56 +++++++
 bsd-user/aarch64/target_arch_signal.h   |  82 ++++++++++
 bsd-user/aarch64/target_arch_sigtramp.h |  48 ++++++
 bsd-user/aarch64/target_arch_sysarch.h  |  42 ++++++
 bsd-user/aarch64/target_arch_thread.h   |  61 ++++++++
 bsd-user/aarch64/target_arch_vmparam.h  |  74 ++++++++++
 bsd-user/aarch64/target_syscall.h       |  51 +++++++
 bsd-user/arm/target_arch_signal.h       |   2 +
 bsd-user/freebsd/os-proc.c              | 118 +--------------
 bsd-user/i386/target_arch_signal.h      |   2 +
 bsd-user/main.c                         |  46 ++----
 bsd-user/qemu.h                         |   3 +
 bsd-user/signal.c                       |   9 +-
 bsd-user/x86_64/target_arch_signal.h    |   2 +
 configs/targets/aarch64-bsd-user.mak    |   3 +
 target/arm/cpu-param.h                  |   4 +
 target/arm/gdbstub64.c                  |   4 +
 22 files changed, 1001 insertions(+), 155 deletions(-)
 create mode 100644 bsd-user/aarch64/signal.c
 create mode 100644 bsd-user/aarch64/target_arch.h
 create mode 100644 bsd-user/aarch64/target_arch_cpu.c
 create mode 100644 bsd-user/aarch64/target_arch_cpu.h
 create mode 100644 bsd-user/aarch64/target_arch_elf.h
 create mode 100644 bsd-user/aarch64/target_arch_reg.h
 create mode 100644 bsd-user/aarch64/target_arch_signal.h
 create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h
 create mode 100644 bsd-user/aarch64/target_arch_sysarch.h
 create mode 100644 bsd-user/aarch64/target_arch_thread.h
 create mode 100644 bsd-user/aarch64/target_arch_vmparam.h
 create mode 100644 bsd-user/aarch64/target_syscall.h
 create mode 100644 configs/targets/aarch64-bsd-user.mak

-- 
2.45.1


