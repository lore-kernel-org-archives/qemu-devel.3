Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E36D1091933
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MkG-0000TU-It; Thu, 19 Mar 2026 19:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkE-0000Sb-Th
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkD-0007Zt-6G
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so6888545ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962735; x=1774567535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l7VURy1zxnhOKNNcO5CG8zTLjsSiXMJAZArRfBnF7MY=;
 b=hkT/FtULP03bKcji/PXe4pB4uUil15K0KaC9Pno+3deWyE1tUDPcnDSicdRQhpO5dN
 L/DdrFsr8Pg4cKis6Nq4YpyWslg9qjg8wJJtGj0SGQdRYUkvaW6jwtGES82lJDrEaw+U
 h/eSQkMREu7FwdRCXUx+WwuW9UzlCI/sAf3xkSZnezNmC2Fe3QTTw9xvmCL6t3Btetc3
 P2LhfqfPUg3uGxzAdRS+jstwtvRBcfV4Ms9XKTb+EZcNdNLpECcqf/QVuoqrrrJVWtgX
 EtrwJZaQGmfVtwLmuzFDdbjuvMUyzyM2sBwTLQAVmgVsmIIcy4qJcfTRp3BaH6GgqlPr
 SPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962735; x=1774567535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7VURy1zxnhOKNNcO5CG8zTLjsSiXMJAZArRfBnF7MY=;
 b=aQteDYXoSbQu9+Uo692PLYsBA/8dKaRXfTJquma4fAA50BSM3stvzl08cI6BMiaaL8
 Jaq3a5hny2ddpFenoErOjmjVkQtoAu68X/oELTYQGjNnlw2yv9TrkEjS6r8w6t3MZsJu
 xP1t8Kz+pe72BdcimoajhuHu17F0q0onKo4tGAitJ8VbC9sP5s//pHw6uppVUq5okOps
 zpDmvZcF6ND+ZomdNYBOK2L9YfxNMCFFqfsDDUEw3Sm2i4KUNEInmX47817TVPY6gcD9
 HaXMxyKl7B3OvAiGIYdAYdeD1uIqPLH1P9N6JH31kr2S1jj81xhgR1tYkSafOhROxAxO
 PGew==
X-Gm-Message-State: AOJu0Yz1OhEkH1dv1qdoa1ajSv4XoBkeNV/AkLCIUfja0gp+Zyjc+R4E
 T9KAjrvXOYX5XFO5z0HBkwXkKKrMtGfrKxu2Tgnz/UAQsOh1XRaIqMEEtq8g/g==
X-Gm-Gg: ATEYQzwuKBVc0ugnVwtJfVdQKJKi2WozVXGdfrvoKB3XyZaoyukdAxGaRx4Z6JuSkhd
 tExi7ZKxfnoHMX3S/kEmNu17SZaCVJ0g4NMdjoYekKW1tFMB6dD1qu2reDFWnTxo7BUspOSrT5o
 84vna0pmBWAB1hcqjj0yNKLl8aYYu0JRwpmTkwIf78438969DLSVZjkrcrz73QcoArVueixnXgP
 LRVDAdF1c4KPldSaL2OdU9KQCO66lbiCUVvarY/O1tViiBPyplMEvCKTm8YHpn0d9cA+grP0/jo
 yHssNq5LO7WGsFXUldh3QZ/WVbnh+/OtciKaDEiwtvjnUUU5br04FSCWclFKrNtPR3zpgkCgRti
 +50FWNJLmk5LTiCcJTBvq6r6XKtnxUHUCXo6DMzrMPW/+/n6eM2K5+fdJU2lt9jLqajAtiDdOZV
 /VDyQZEvNN9BUjCzpuYDPeTXRtGj8Oe9JvBjVBHLtTdw==
X-Received: by 2002:a17:902:d488:b0:2b0:6d2d:f1d5 with SMTP id
 d9443c01a7336-2b0827c2c55mr7691555ad.45.1773962734973; 
 Thu, 19 Mar 2026 16:25:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/17] riscv-to-apply queue
Date: Fri, 20 Mar 2026 09:25:05 +1000
Message-ID: <20260319232522.1867400-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 5a68a3add61208aad34d47134fdcfd3f407d2ce4:

  Update version for v11.0.0-rc0 release (2026-03-18 15:56:51 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260320

for you to fetch changes up to 38937473da3ebdd89bbe6bbc3effc0b153ceb414:

  target/riscv: Fix scountovf CSR behavior in VS-mode and M-mode (2026-03-20 08:41:15 +1000)

----------------------------------------------------------------
RISC-V PR for 11.

* Fix integer overflow in cm_base calculation
* Fix null pointer dereference in cpu_set_exception_base
* Update Daniel Henrique Barboza's email
* Add Chao Liu as reviewer
* Set SiFive PDMA done bit upon completion
* Remove deprecated 'riscv, delegate' device-tree property
* Fix OCP FP8 E4M3 conversion issues
* Fix IOMMU instance_init allocations in instance_finalize
* Support Smpmpmt extension
* Fix SiFive UART spurious IRQ issue and misc updates
* Fix missing flags merge in probe_pages for cross-page accesses
* Fix page probe issues in vext_ldff
* Fix scountovf CSR behavior in VS-mode and M-mode

----------------------------------------------------------------
Chao Liu (1):
      MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs

Daniel Henrique Barboza (1):
      MAINTAINERS: update my email

Djordje Todorovic (2):
      hw/riscv: Fix integer overflow in cm_base calculation
      target/riscv: Fix null pointer dereference in cpu_set_exception_base

Frank Chang (4):
      hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
      hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO enqueue
      hw/char: sifive_uart: Update IRQ when rxctrl is written
      hw/char: sifive_uart: Remove ip variable

Jay Chang (2):
      hw/dma: sifive_pdma: Set done bit upon completion
      target/riscv: Support Smpmpmt extension

Jim Shu (1):
      target/riscv: Fix scountovf CSR behavior in VS-mode and M-mode

Max Chou (4):
      fpu: Fix repacking issues in the uncanonical step for E4M3 overflow
      fpu: Fix unexpected exception flags when converting infinity to OCP E4M3
      target/riscv: rvv: Fix missing flags merge in probe_pages for cross-page accesses
      target/riscv: rvv: Fix page probe issues in vext_ldff

Peter Maydell (1):
      hw/riscv/riscv-iommu: Free instance_init allocations in instance_finalize

Philippe Mathieu-Daudé (1):
      hw/riscv: Remove deprecated 'riscv, delegate' device-tree property

 MAINTAINERS                       |  4 +++-
 docs/about/deprecated.rst         | 11 ----------
 docs/about/removed-features.rst   | 11 ++++++++++
 include/hw/char/sifive_uart.h     |  3 ++-
 include/hw/riscv/cps.h            |  2 +-
 target/riscv/pmp.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 hw/char/sifive_uart.c             | 46 +++++++++++++++++++++++++++++++--------
 hw/dma/sifive_pdma.c              |  1 +
 hw/riscv/riscv-iommu.c            | 16 +++++++++++---
 hw/riscv/virt.c                   |  9 --------
 target/riscv/cpu.c                |  3 +++
 target/riscv/csr.c                | 16 ++++++++++++--
 target/riscv/pmp.c                | 16 ++++++++++++++
 target/riscv/vector_helper.c      | 23 ++++++--------------
 fpu/softfloat-parts.c.inc         |  4 +++-
 16 files changed, 113 insertions(+), 54 deletions(-)

