Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A448CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 19:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIAt4-0003N8-9p; Sun, 09 Nov 2025 14:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIAt1-0003LQ-UZ
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 14:15:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vIAsz-0007uY-FK
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 14:15:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso11430185e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762715735; x=1763320535;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NCCK9Oe+I1gY0kGy2RpxD3infyCf1thfOGBfeu861Y4=;
 b=PYACgXtFZXLKem0xamUYxSq/VbuzMbvXwHIkFHPN/h2zjsfMtLd51AYX91yOe02UPD
 J3DuyZV22npdhnzebKb4Jd4oEjZfeydORZoJzBikJa7+2pZwJi9K9Vln61Vho6qED5k/
 FccuJOfbCnfbkG9KmbCEqsFxnZ4WU3njl4+1r9R7RC8zy5XKsZL+P567UaacBRB2uJeh
 AhuNcyaJWRpaRLCpoI5CaqKGiMC5nKJFyXosjuN68Uu0NnrKCWEVZ7JXEKLjZJDiSVE4
 vT62Kjpt1tWiK1GWz9gku8Z2Cecq619XPyvzKdERJb+UQfUt/iTC/yYyFuzoFD/WXty0
 Uzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762715735; x=1763320535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCCK9Oe+I1gY0kGy2RpxD3infyCf1thfOGBfeu861Y4=;
 b=Z8Y8F0PH4a2/EKRKrjEPcAnWMXFVV2FzAqFj9xCk/qeKXzu9vWTWETQFSxpKZpYbHN
 kjoZaMSwGaXSXB+Dv56lLHGaZxpdesx/Q82vZjqDaaikXCXmMX8ZIVCOie96sFT8LKWo
 BEaT8FD/0XrDgWEFFuSNdeZu+7onuAoQlpnikX4tLfGUkCkvjw5uz2GHiAirRTkFpjui
 4eGXw6xLnC/GSxb1ETNGAb9QhmHH+Zt9NxXeVFv3K5hE/agR4lwF04YSwa9xBmcTDJQI
 FH02sLzuijYwHFlypbtW6WCDhmfCHDSJ3A3h/j6nKGHeVqmI2RVNAzL7UiYG+kUI7yJX
 +XgA==
X-Gm-Message-State: AOJu0Yxnm/1nH7mvcqptj00r9S0IAn9tLEchcSe1eq45ItGas4gNiIVd
 yrxRoeVT6rY+rjccmh19rgWWqW4mxTLM5Be2mj5ir6yAwmNEpfYJ/naB5w+QAeKIXO7XVt250lp
 lZIvfgmk=
X-Gm-Gg: ASbGncsb5I1TB1o1kNmmjqh2oWltf73IRcxB1r8DTl5R583k+ZRAoprgB3fIS5liJyF
 zQRw6Tbxz1OYgHRKgutVCCTFQYRjRzsRx1P/12Zs1wSOvFqsd2BOfUCXlqQXk+3O9kVl2hUiXby
 V+DGgpPC5yLF9vHCLHHByhB+F7dAE9+a24JtkEEIaMnPmUL94FNB7xrUeETM4zXBOl+kE0TTVA1
 6+3B9Gily712/FQZyS6CzG9zj8OM6iLpEZ1/qnvauKChANDaN43PAEfbuaaX0kRIV0TwLve8tfH
 Ec2nPnYHkAgJ1sZP3XBWRbERpE1Ddm69qSxDYkjWjEaRpjekBmEBBh2DF7OxKWrRL2CuvLyH8n6
 p5qJy6+xLnwYXFaoIvjJOKekswmIZDpr17LHRgcQwBBgb26PEDj2f8oXWdvE2c2CtGNkwHVkYCl
 vJYT0gSe5UG3w=
X-Google-Smtp-Source: AGHT+IGoJJbjXnZ2XKSTmzsN4/AFw1d3PuOYTuieDaVEj0gaLq4hLV04pKWXV7hhzQOSsuOyrzaNHw==
X-Received: by 2002:a05:600c:3b01:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-47773288bf9mr58891775e9.31.1762715734398; 
 Sun, 09 Nov 2025 11:15:34 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:1:b32a:35:83e6:baea:8ad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47778daf2c3sm54600265e9.10.2025.11.09.11.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 11:15:34 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v4 0/5] RISC-V: NEORV32 CPU, peripherials, and machine
Date: Sun,  9 Nov 2025 21:15:27 +0200
Message-ID: <20251109191532.32419-1-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32e;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x32e.google.com
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


This v4 reworks the initial NEORV32 submissions.

The series introduces:
  * a minimal NEORV32 RV32 CPU type and vendor CSR hook,
  * the SYSINFO MMIO block,
  * a small UART device,
  * an SPI controller with command-mode chip-select,
  * and the 'neorv32' RISC-V board wiring the above, plus docs.

Tested by booting the NEORV32 bootloader as -bios and chaining into a
Hello World from an MTD-backed SPI flash image, with UART on stdio.

Changes since v3:
  * Clean-up and fix documentation build errors
  * Fixed extra blank lines

Thanks Daniel for the review and for providing the documentation fix suggestions.

Changes since v2:
  * Clean-up all errors and most of the warnings generated by scripts/checkpatch.pl
  * Sync with master, fix compile error
  * No intentional functional changes; only file organization and clarity.
  * Kept default.mak entry off by default (n).

Patch layout
============
  1/5  target/riscv: add NEORV32 RV32 CPU type and vendor CSR hooks
  2/5  hw/misc: add NEORV32 SYSINFO block (CLK/MISC/SOC/CACHE)
  3/5  hw/char: add NEORV32 UART (CTRL/DATA, fifo, chardev)
  4/5  hw/ssi: add NEORV32 SPI controller (SSI master, CS command)
  5/5  hw/riscv: introduce 'neorv32' board, docs, and riscv32 device config

Quick usage
===========
  $ ./configure --target-list=riscv32-softmmu --enable-debug --enable-fdt
  $ make -j$(nproc)

Prepare a flash image (64MiB) and place your app at 4MiB offset:
  $ dd if=/dev/zero of=$HOME/flash_contents.bin bs=1 count=$((0x04000000))
  $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \\
       bs=1 seek=$((0x00400000)) conv=notrunc

Run bootloader and chain-load your app:
  $ ./build/qemu-system-riscv32 -nographic -machine neorv32 \\
      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \\
      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw

Debugging:
  $ ... -s -S   # gdbstub on :1234, start paused



Thanks for reviewing!
Michael

Michael (5):
  target/riscv: add NEORV32 RV32 CPU type and vendor CSR hooks
  hw/misc: add NEORV32 SYSINFO block (CLK/MISC/SOC/CACHE)
  hw/char: add NEORV32 UART (CTRL/DATA, fifo, chardev)
  hw/ssi: add NEORV32 SPI controller (SSI master, CS command)
  hw/riscv: introduce 'neorv32' board, docs, and riscv32 device config

 configs/devices/riscv32-softmmu/default.mak |   1 +
 docs/system/riscv/neorv32.rst               | 112 +++++
 docs/system/target-riscv.rst                |   1 +
 hw/char/Kconfig                             |   3 +
 hw/char/meson.build                         |   1 +
 hw/char/neorv32_uart.c                      | 285 ++++++++++++
 hw/misc/Kconfig                             |   2 +
 hw/misc/meson.build                         |   1 +
 hw/misc/neorv32_sysinfo.c                   | 201 ++++++++
 hw/misc/neorv32_sysinfo.h                   |  88 ++++
 hw/misc/neorv32_sysinfo_rtl.h               | 239 ++++++++++
 hw/riscv/Kconfig                            |   8 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/neorv32.c                          | 215 +++++++++
 hw/ssi/Kconfig                              |   4 +
 hw/ssi/meson.build                          |   1 +
 hw/ssi/neorv32_spi.c                        | 478 ++++++++++++++++++++
 include/hw/char/neorv32_uart.h              |  54 +++
 include/hw/riscv/neorv32.h                  |  54 +++
 include/hw/ssi/neorv32_spi.h                |  57 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  17 +
 target/riscv/cpu.h                          |   3 +
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/cpu_cfg_fields.h.inc           |   1 +
 target/riscv/cpu_vendorid.h                 |   2 +
 target/riscv/meson.build                    |   1 +
 target/riscv/neorv32_csr.c                  |  40 ++
 28 files changed, 1872 insertions(+)
 create mode 100644 docs/system/riscv/neorv32.rst
 create mode 100644 hw/char/neorv32_uart.c
 create mode 100644 hw/misc/neorv32_sysinfo.c
 create mode 100644 hw/misc/neorv32_sysinfo.h
 create mode 100644 hw/misc/neorv32_sysinfo_rtl.h
 create mode 100644 hw/riscv/neorv32.c
 create mode 100644 hw/ssi/neorv32_spi.c
 create mode 100644 include/hw/char/neorv32_uart.h
 create mode 100644 include/hw/riscv/neorv32.h
 create mode 100644 include/hw/ssi/neorv32_spi.h
 create mode 100644 target/riscv/neorv32_csr.c

-- 
2.51.1


