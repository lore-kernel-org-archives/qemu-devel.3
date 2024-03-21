Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D406C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKev-0004IT-Ct; Thu, 21 Mar 2024 11:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKeu-0004I3-2P
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:48:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKer-00019M-7a
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:48:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e570ef661so558779f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036123; x=1711640923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zh/FaIsWmIi3a25Yrb9MOaHVvh0tuDxkCn+67cE8e8k=;
 b=aAgM9Whgg92GwEMr1jUMu/+LHM22nW7V284d2zpS3y0ckp7wwZZiSH9UhJKqgTy+Pk
 qLg8qqUXRli37p4FTOIcsFqz5QQQdYriAS9nP3vO8g/5ihl12UFfMTNfyrsUJ7une6cU
 +mvdafQfE0IYQwACnNXsfFHHk9aJboxkdP12VND0aNkgF9DS+gg/zsOkttH01weSA3Gm
 ey2r6dOJRODTULYUDnfHALGb7evB9zgI9Jp4PVgiI2HyTLIw+H37qYke0byiHB1Rn0r9
 R1ZkYdrCgX7g9w8q2rhBX5QnBaXUQBJsg+DAEskXrBMWhuOXsQSWHtqc93J9tXpgLWHK
 HKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036123; x=1711640923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zh/FaIsWmIi3a25Yrb9MOaHVvh0tuDxkCn+67cE8e8k=;
 b=blt9qhFA9vRmpG+KCE7/3x7pwcRqZ5l0k1fkY2kW52NjuO6ID7yXQ8gaThtx8RpPTM
 oQEMzwEYjsOo0Uupa7Vzo3acFPRmlRDIQkEbxbmwEeuzbOXkW5weBjlV3bKqA7u2gZCA
 VmrKSz89cH0+opLPam6MkfrTRaoZwbQ7TKhosNuhsRhKDIsosklZEkeLkjL8VzDWkg5i
 hwWjiztkUlmHf0gsO6nEXZa7tN8HQaZgjouPOpDWsHJxf0wprMXFIHAllE7Iq8tT/FRW
 f4931AdOtiSoN/TbnQxRVaYJ1YK0QvRbSZHS3BDfUn9j6qz6weeBH2KL1wCnfBHGd9Zy
 GvHA==
X-Gm-Message-State: AOJu0YxLAYHZlRVrOR1AnZj+E1fp1gasXC1YzGrE/2lYp6c+TrFaXDZT
 j39vwLrsgziMYNFIqMiS1ue2UUzpYpoXuOb9+bE3nrf7B33i0gaosIeuEP/VQDsT0Ew7DEY5OVx
 J8Do=
X-Google-Smtp-Source: AGHT+IE0j0GHohj7TY3zQ9i/2Vc5AK/dh9s56mMhx1SAyqHJyGmeUOfxoMBpNPcqu136EpMwMolWkA==
X-Received: by 2002:adf:fed2:0:b0:33e:cc27:a9b8 with SMTP id
 q18-20020adffed2000000b0033ecc27a9b8mr18568258wrs.32.1711036123344; 
 Thu, 21 Mar 2024 08:48:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a0560001a4400b0033e756ed840sm17411892wry.47.2024.03.21.08.48.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:48:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 00/21] target/monitor: Cleanup around hmp_info_tlb()
Date: Thu, 21 Mar 2024 16:48:16 +0100
Message-ID: <20240321154838.95771-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

In [*] I posted preliminary steps to unify hmp_info_tlb()
and hmp_info_mem() after making them per-CPU handler,
rather than target-specific method (which break single
binary). Since there is no rush and we need to figure
the usefulness of 'info tlb/mem' and what we want to do
with it, I dropped the series but salvaged these cleanup
patches.

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/20240320164055.60319-1-philmd@linaro.org/

Philippe Mathieu-Daudé (21):
  host/atomic128: Include missing 'qemu/atomic.h' header
  hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
  target/i386: Move APIC related code to cpu-apic.c
  target/i386: Extract x86_dump_mmu() from hmp_info_tlb()
  target/m68k: Replace qemu_printf() by monitor_printf() in monitor
  target/m68k: Have dump_ttr() take a @description argument
  target/m68k: Move MMU monitor commands from helper.c to monitor.c
  target/microblaze: Prefix MMU API with 'mb_'
  target/mips: Prefix MMU API with 'mips_'
  target/nios2: Prefix MMU API with 'nios2_'
  target/nios2: Move monitor commands to monitor.c
  target/nios2: Replace qemu_printf() by monitor_printf() in monitor
  target/ppc: Replace qemu_printf() by monitor_printf() in monitor
  target/sh4: Extract sh4_dump_mmu() from hmp_info_tlb()
  target/sparc: Fix string format errors when DEBUG_MMU is defined
  target/sparc: Replace qemu_printf() by monitor_printf() in monitor
  target/xtensa: Prefix MMU API with 'xtensa_'
  target/xtensa: Extract MMU API to new mmu.c/mmu.h files
  target/xtensa: Simplify dump_mpu() and dump_tlb()
  target/xtensa: Move monitor commands to monitor.c
  target/xtensa: Replace qemu_printf() by monitor_printf() in monitor

 host/include/generic/host/atomic128-cas.h  |    2 +
 host/include/generic/host/atomic128-ldst.h |    2 +
 include/hw/core/tcg-cpu-ops.h              |    2 -
 target/i386/cpu.h                          |    7 +
 target/m68k/cpu.h                          |    3 +-
 target/microblaze/mmu.h                    |   10 +-
 target/mips/tcg/tcg-internal.h             |    2 +-
 target/nios2/cpu.h                         |    2 +-
 target/nios2/mmu.h                         |   11 +-
 target/ppc/cpu.h                           |    2 +-
 target/sh4/cpu.h                           |    2 +
 target/sparc/cpu.h                         |    2 +-
 target/xtensa/cpu.h                        |   32 +-
 target/xtensa/mmu.h                        |   95 ++
 target/i386/cpu-apic.c                     |  112 +++
 target/i386/cpu-sysemu.c                   |   77 --
 target/i386/mmu.c                          |  231 +++++
 target/i386/monitor.c                      |  240 -----
 target/m68k/helper.c                       |  223 -----
 target/m68k/monitor.c                      |  225 ++++-
 target/microblaze/cpu.c                    |    2 +-
 target/microblaze/helper.c                 |    4 +-
 target/microblaze/mmu.c                    |   14 +-
 target/microblaze/op_helper.c              |    4 +-
 target/mips/cpu.c                          |    2 +-
 target/mips/tcg/sysemu/tlb_helper.c        |    2 +-
 target/nios2/cpu.c                         |    2 +-
 target/nios2/helper.c                      |    4 +-
 target/nios2/mmu.c                         |   34 +-
 target/nios2/monitor.c                     |   27 +-
 target/ppc/mmu_common.c                    |  147 +--
 target/ppc/ppc-qmp-cmds.c                  |    2 +-
 target/sh4/monitor.c                       |   22 +-
 target/sparc/ldst_helper.c                 |   26 +-
 target/sparc/mmu_helper.c                  |  102 +-
 target/sparc/monitor.c                     |    2 +-
 target/xtensa/cpu.c                        |    2 +-
 target/xtensa/mmu.c                        |  889 +++++++++++++++++
 target/xtensa/mmu_helper.c                 | 1037 +-------------------
 target/xtensa/monitor.c                    |  149 ++-
 target/i386/meson.build                    |    2 +
 target/xtensa/meson.build                  |    1 +
 42 files changed, 1943 insertions(+), 1815 deletions(-)
 create mode 100644 target/xtensa/mmu.h
 create mode 100644 target/i386/cpu-apic.c
 create mode 100644 target/i386/mmu.c
 create mode 100644 target/xtensa/mmu.c

-- 
2.41.0


