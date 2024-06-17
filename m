Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA9DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYf-0003xx-UX; Mon, 17 Jun 2024 14:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYe-0003xY-Ci
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYc-0004vn-OY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70435f4c330so3765201b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650700; x=1719255500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2lue1NYs8pzYvkVM8I+Vf9elZ0KvTkfQjkhNGZa4vlA=;
 b=UZZolZNlBVDALp+f7G0XEVvFRHyo7LHwSZCU4KYGU+CyWk1dzJxkBF56YgCKb25LFz
 9/Z5/B7IPLsOtDfx7AN3eZzY34BKrXvq4dnCJ6DPG/wLmdlyEj95WErcQ5sjJ1pOugrW
 WT0OJW5KDhsyh+l0e0PoDWz8QVrFtjVioOnG+QKb19+pIbq5gb0O7Wa5hJU8NlrfMF3X
 oH8jQcn/+5C5z1BEG5CEDGV+SCX7pBNnLUd1IHZjva/lbhLMadrcHNytPbyJ/PFVhk8m
 2mMCF3xzM2eJ9IOcgBEneik5N3rr3970HkZUb9bZqo+Y5K6AlrMM+hBS8/KRreQmUDl3
 nJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650700; x=1719255500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2lue1NYs8pzYvkVM8I+Vf9elZ0KvTkfQjkhNGZa4vlA=;
 b=dRCBqwGsOU9h6tru2qusRFlK9LOaGHWWHE6ZhHut1Gf/e76iH1ChUwHUaDVoJJ591z
 rXx9HyEHBPdLA/Kwa1AdilJ2aZVs9Br8VjM2wCEEuG4kILU/ofq5aEyZ3Dh3zd3QJ1Sf
 5EP0/genT+JwWqmhZfc/88S6vCSdR+Mymp+j8IZhPb/OjMffzm9ZRQU/MbGjVByaqoUR
 tF++8fv7Vr38lBnbWY8D0nM8HJKnMbN7AOaXudIuJzgZz2GYUGBEcGU7aDTKnu6QwnEb
 cfEmCqbLbF6yWj41krBugM9FJUBcqppD97Ks2kbkrnBDXYpOipqxtOlU608w5C3Rv922
 OvKA==
X-Gm-Message-State: AOJu0YwZlEQwaavxjtWGsbPd/oaAwFFyxOzH8vPeazAzCEiYYB1pzE9Y
 Y+JIQENX/i4TmrmEs1DwkTwiJCSMdJ66P5uuRrHWSXHOJuM5/7vBFpJceVOFCik=
X-Google-Smtp-Source: AGHT+IE0rOOemu0InWND8vW9CAm87ESOdH2Dc3rNpuW+SLCbiXyViu/dkHyHSIeXL8LxeoJMSW1KQA==
X-Received: by 2002:a05:6a20:9148:b0:1b2:cf6c:d5a4 with SMTP id
 adf61e73a8af0-1bae82ecde1mr11046839637.61.1718650700311; 
 Mon, 17 Jun 2024 11:58:20 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:20 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 00/23] ARM AArch64 Support for BSD
Date: Tue, 18 Jun 2024 00:27:41 +0530
Message-Id: <20240617185804.25075-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42d.google.com
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

making sure to credit all the authors correctly

Stacey Son (18):
  Add CPU initialization function
  Added CPU loop function
  Added function to clone CPU state
  AArch64 specific CPU for bsd-user
  Managing CPU register for BSD-USER
  Add Aarch64 register handling
  Add ARM AArch64 TLS Management Prototypes for BSD-User
  Add Aarch64 sysarch() system call emulation for BSD-USER
  Add thread setup for BSD-USER
  Add thread initialization for BSD-USER
  Update ARM AArch64 VM parameter definitions for bsd-user
  Add ARM AArch64 ELF definitions for bsd-user
  Add ARM AArch64 sigcode setup function for bsd-user
  Add ARM AArch64 specific signal definitions for bsd-user
  Add ARM AArch64 signal trampoline argument setup for bsd-user
  Add get_mcontext function for ARM AArch64 in bsd-user
  Add set_mcontext function for ARM AArch64 in bsd-user
  Add get_ucontext_sigreturn function

Warner Losh (5):
  Add ability to get rval2
  Add ARM AArch64 hardware capability definitions
  Add function to retrieve ARM AArch64 hardware capabilities
  Add function to retrieve additional ARM AArch64 hwcap
  Add setup_sigframe_arch function for ARM AArch64 in bsd-user

 bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
 bsd-user/aarch64/target_arch.h          |  28 ++++
 bsd-user/aarch64/target_arch_cpu.c      |  34 +++++
 bsd-user/aarch64/target_arch_cpu.h      | 191 ++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_elf.h      | 165 ++++++++++++++++++++
 bsd-user/aarch64/target_arch_reg.h      |  56 +++++++
 bsd-user/aarch64/target_arch_signal.h   |  80 ++++++++++
 bsd-user/aarch64/target_arch_sigtramp.h |  48 ++++++
 bsd-user/aarch64/target_arch_sysarch.h  |  42 ++++++
 bsd-user/aarch64/target_arch_thread.h   |  61 ++++++++
 bsd-user/aarch64/target_arch_vmparam.h  |  74 +++++++++
 bsd-user/aarch64/target_syscall.h       |  51 +++++++
 12 files changed, 967 insertions(+)
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

-- 
2.34.1


