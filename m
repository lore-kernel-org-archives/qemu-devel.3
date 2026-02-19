Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21D6E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ZH-0007qA-WF; Thu, 19 Feb 2026 14:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZD-0007pE-R0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Z9-0007NL-Tx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so14084765e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528798; x=1772133598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8+pnWOJBJoMrrb3M/TGtd76e4GjVLqIYK4EQBYWzI8Y=;
 b=exXgHUWl3WbmP43nll+yuYQ9yfrPhVNGetPti07kOpDb9QZDqgSFaPoXkqhQYgrypD
 Dz+2cxtjBnNm10pUVfEORewbDlx2lqxqcpuxnP099J8UayzNohfSC92T83SpPvP/yrDz
 hOYzAUGqKk07+h/8xtNlvDj5j5gqxHBRqmgxoYCQUjihBjIGiAgZ1VD3X3jOlU+1p2nO
 frI7NQuycRuTJXx9nYja85FW4qcy8INBXyMihwZ7tyFG1DQDvYcGFNx80qVb32KlRpnK
 Fsbtk8nscOLQT3LfNeL4V6o4gcIPRQzeDM98iuJkKBGRLTdLzQ5SYn9nptIDDnpxDf0S
 VZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528798; x=1772133598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+pnWOJBJoMrrb3M/TGtd76e4GjVLqIYK4EQBYWzI8Y=;
 b=ZOh5PxRy/9BGNmNlNviVnxQfpyMtXMGoT4dVEQbWyp/BxypjEmhZxRMgxBuY4ZpH//
 0fy/pbqbu3zGTAQ3vdXJ+imgdYssQFeT44iERAeLAVaa6O3duz8aB24gqmjg6QiSiCH7
 +G5il15M9kK79zjEXL06bBH/BxOzznSWX0jLcmWKt2ahs2J4O6/zIVSf++LkH+9I0Uqa
 34xPqLccoAY0QOpQsJg7vHqglcK11FsUrhZT3qiTts6/Ar5Y+9WfBQ7/hqbjRonvQbLz
 ceB9FnLHgo2RpgAjtz3tTTugxctYLZPd62Tv6WfcUJ/alEZJNqIfTH+TKufcNlBXe6p/
 ixsg==
X-Gm-Message-State: AOJu0Ywt9jR9VJHnvWxoda9PHcvnEDn+0q5HD1LC6YHzFNGflN/Kka3j
 3rVMdu6Jy3ZSJiNNCoOP2EBnV3tcNORRQsGpdKrqOHH02lRSGesYSwF2MfXXANF7/jFBCPTzcgX
 Pb9xRmvOw4g==
X-Gm-Gg: AZuq6aJVUPxwhfNHawS0S/u8H7gw324on/nSGI6Nw+tizTmpfDJ2YWackNFzwFXe44N
 uRkBK5TVTDNSHSbbqoDMOscFtlIt+bPS0qWgoBhr3sjlEmZVSxoG6hzmxr2RwNtfavE1eo0Z62/
 o+Vb4bOMEJDDrHhcmyHhZvvgtyA94jRnHX841GKFqf/9j3KTgswWwHNv2ksfBQHGWba6Au0rt4h
 V7sLNbaSsU9VU30E6I7nvrXzl1Qm5v3Aj/1eiyPfZcL0aTxBqJh/EK54S8w9KsS1IYc0mb+JcBQ
 3Gtr5t1SAvQ52IU+JX2bVTExA5rogJfMSIIpMaQDQDxV4uuBFiDgqicpGDA6HJ1htYdpuISJYJZ
 3iCEmNSdWuv4lFmYoDNyzHuWM/vQ5zz6p8X7PuLhC/+Bi3WYbf+6unxFUvVd9zIbrRoaMcvc8H4
 ctfvAaLuvEbj32QfpGbY1zeaE53dQU6+CyYYmID0X+QkWj3q/BETV8q5x+GuTkykRlOHRmBhN8
X-Received: by 2002:a05:600c:8411:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-48398b7d820mr97920305e9.34.1771528797856; 
 Thu, 19 Feb 2026 11:19:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bfbd0sm21494795e9.6.2026.02.19.11.19.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:19:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/50] gdbstub: Build once on various targets
 (single-binary)
Date: Thu, 19 Feb 2026 20:19:02 +0100
Message-ID: <20260219191955.83815-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

This series absorbed "monitor/hmp: Automatically handle
gdb-xml exposed registers", thus version 2. Previous cover:

  MonitorDef registers parsing is one of the oldest APIs in QEMU,
  thus predates gdbstub and XML register files. The latters are
  maintained by the GDB/binutils project and are more up-to-date.
  Getting the target register list from them allows to expose
  all accessible registers to the HMP commands.

  This series adds gdb_get_register() to monitor to use XML
  generated registers, and remove the legacy MonitorDef entries
  which became unreachable.

  First we need to have the SPARC target better follow the
  gdb-xml API.

On top of that we remove more TARGET_LONG_BITS uses, replacing
ldtul_p() -> ldn_p() and gdb_get_regl() -> gdb_get_reg32/64(),
allowing to build various gdbstub.c files once. Few other meson
cleanups on the way.

Philippe Mathieu-Daudé (50):
  target/ppc: Move user_only_helper.c to target_user_arch[] source set
  target/ppc: Remove PPC_DEBUG_SPR left-over comment
  target/i386: Inline GDB_FORCE_64 definition
  target/avr: Fix typo in gdb-xml feature name
  target/alpha: Document gdbstub register indexes
  target/riscv: Extract monitor-related code to monitor.c
  target/ppc: Fix CPUClass::gdb_num_core_regs value
  target/ppc: Remove dead code depending on USE_APPLE_GDB
  gdbstub: Always infer gdb_num_core_regs when using XML file
  target/sparc: Introduce sparc_cpu_register_gdb_regs() stub
  target/sparc: Restore 'gdb-xml/sparc64-cp0.xml'
  target/sparc: Restore 'gdb-xml/sparc64-fpu.xml'
  target/sparc: Restore 'gdb-xml/sparc64-cpu.xml'
  target/sparc: Expose gdbstub registers to sparc32plus target
  target/sparc: Expose gdbstub registers to sparc32 targets
  monitor/hmp: Handle gdb-xml exposed registers via  gdb_get_register()
  target/sparc: Remove MonitorDef register entries available via gdbstub
  target/i386: Remove MonitorDef register entries available via gdbstub
  target/m68k: Remove MonitorDef register entries available via gdbstub
  target/ppc: Remove MonitorDef register entries available via gdbstub
  target/ppc: Extract monitor-related code to monitor.c
  target/or1k: Use XML register definitions from GDB
  target/riscv: Remove empty target_monitor_defs() symbol
  target/sparc: Factor sparc_cpu_gdb_write_register() out
  target/ppc: Replace ldtul_p() -> ldn_p()
  target/mips: Replace ldtul_p() -> ldn_p()
  target/riscv: Replace ldtul_p() -> ldn_p()
  target/riscv: Remove unnecessary target_ulong type uses
  target/i386: Replace ldtul_p() -> ldn_p()
  target/i386: Expand 64-bit definitions when TARGET_LONG_BITS == 64
  gdbstub: Remove ldtul*() macros
  target/alpha: Expand gdb_get_regl() -> gdb_get_reg64()
  target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
  target/rx: Expand gdb_get_regl() -> gdb_get_reg32()
  target/sh4: Expand gdb_get_regl() -> gdb_get_reg32()
  target/sparc: Expand gdb_get_regl() in gdb_get_rega()
  gdbstub/helpers: Convert gdb_get_regl() macro to inlined helper
  target/microblaze: Build 'gdbstub.c' once for system binaries
  target/sh4: Build 'monitor.c' once for system binaries
  target/sh4: Build 'gdbstub.c' once for system binaries
  target/or1k: Rename 'openrisc' -> 'or1k' in meson.build
  target/or1k: Build 'gdbstub.c' once for system single binary
  target/alpha: Build 'gdbstub.c' once for system single binary
  target/avr: Build 'gdbstub.c' once for system single binary
  target/loongarch: Build 'gdbstub.c' once for system single binary
  target/m68k: Build 'gdbstub.c' once for system single binary
  target/rx: Build 'gdbstub.c' once for system single binary
  target/s390x: Build 'gdbstub.c' once for system single binary
  target/tricore: Build 'gdbstub.c' once for system single binary
  DONOTREVIEW Revert "target/loongarch: Build 'gdbstub.c' once"

 configs/targets/or1k-linux-user.mak           |   1 +
 configs/targets/or1k-softmmu.mak              |   1 +
 configs/targets/sparc-linux-user.mak          |   1 +
 configs/targets/sparc-softmmu.mak             |   1 +
 configs/targets/sparc32plus-linux-user.mak    |   1 +
 configs/targets/sparc64-linux-user.mak        |   2 +-
 configs/targets/sparc64-softmmu.mak           |   2 +-
 include/gdbstub/helpers.h                     |  28 +-
 include/hw/core/cpu.h                         |   4 +-
 target/ppc/cpu.h                              |   2 -
 target/sparc/cpu.h                            |   1 +
 gdbstub/gdbstub.c                             |   1 +
 monitor/hmp.c                                 |  49 ++-
 target/alpha/cpu.c                            |   1 -
 target/alpha/gdbstub.c                        |  27 +-
 target/hexagon/gdbstub.c                      |  12 +-
 target/i386/gdbstub.c                         |  23 +-
 target/i386/monitor.c                         |  39 ---
 target/m68k/monitor.c                         |  18 -
 target/mips/gdbstub.c                         |  14 +-
 target/or1k/cpu.c                             |   2 +-
 target/ppc/cpu_init.c                         |  10 -
 target/ppc/gdbstub.c                          | 146 +-------
 target/ppc/monitor.c                          |  41 +++
 target/ppc/ppc-qmp-cmds.c                     | 148 +-------
 target/riscv/gdbstub.c                        |  20 +-
 target/riscv/monitor.c                        | 135 ++++++++
 target/riscv/riscv-qmp-cmds.c                 | 150 ---------
 target/rx/gdbstub.c                           |  20 +-
 target/sh4/gdbstub.c                          |  32 +-
 target/sparc/cpu.c                            |   7 +-
 target/sparc/gdbstub.c                        | 317 +++++++++++-------
 target/sparc/monitor.c                        | 107 ------
 gdb-xml/avr-cpu.xml                           |   2 +-
 gdb-xml/or1k-core.xml                         |  65 ++++
 gdb-xml/sparc32-cp0.xml                       |  18 +
 gdb-xml/sparc32-cpu.xml                       |  42 +++
 gdb-xml/sparc32-fpu.xml                       |  42 +++
 gdb-xml/sparc64-cp0.xml                       |  16 +
 gdb-xml/sparc64-cpu.xml                       |  42 +++
 gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} |  44 +--
 target/alpha/meson.build                      |  14 +-
 target/avr/meson.build                        |   5 +-
 target/m68k/meson.build                       |   9 +-
 target/microblaze/meson.build                 |  11 +-
 target/or1k/meson.build                       |  23 +-
 target/ppc/meson.build                        |   7 +-
 target/rx/meson.build                         |   6 +-
 target/s390x/meson.build                      |   3 +-
 target/sh4/meson.build                        |  14 +-
 target/tricore/meson.build                    |  10 +-
 51 files changed, 836 insertions(+), 900 deletions(-)
 create mode 100644 target/ppc/monitor.c
 create mode 100644 gdb-xml/or1k-core.xml
 create mode 100644 gdb-xml/sparc32-cp0.xml
 create mode 100644 gdb-xml/sparc32-cpu.xml
 create mode 100644 gdb-xml/sparc32-fpu.xml
 create mode 100644 gdb-xml/sparc64-cp0.xml
 create mode 100644 gdb-xml/sparc64-cpu.xml
 rename gdb-xml/{sparc64-core.xml => sparc64-fpu.xml} (59%)

-- 
2.52.0


