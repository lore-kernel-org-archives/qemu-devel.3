Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A44C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxyB-0000fI-HW; Sun, 26 Jul 2026 08:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxy9-0000dJ-3f
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:28:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxy4-0002tI-M8
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:28:36 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso1927561b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068908; x=1785673708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g/XAcSm17QqKQ9ETpqNQkH3Hsms2HSSgWJglT/dAeR0=;
 b=qGwvbEoOvjwKT70A1wiISoYhv7o6G4IETgCSMfLrmcGoqn88EPIUR/RSVX2G/U6+Cv
 8cHviXpKhW+QZPIlHK5eGoXwZq/z5uig3mREaZqBbX7LxDgL8K0EAJ39+6k65eiJYM6+
 +t7kxCYf3lE9sOpcg9cpqie1TIY1mZWmtacsBfScc2kVWpKCfyWHrgRMPdJ1YWw8qLvz
 r8QeeVmhQut1oDf4wOETQinybxZY+2JkCWoOIZuhT5ForAPB3hHzoMNAIfkyJ7GdDCww
 ZPKcK4um1KQqkmoioez2QtKpJwxa3OC4x0TPEMidIfHkEyPrsu2oM4UHkRr2PW0lbwPg
 fwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068908; x=1785673708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/XAcSm17QqKQ9ETpqNQkH3Hsms2HSSgWJglT/dAeR0=;
 b=Dl5OQfzppeB9hxrlPmt5XSr/am5DA0WJkLGBG91NNlhpVoAEoe0qVfSNxlt8qUmTXG
 /HbkN5j//frU06UFC5TP0p+uOXLHsq79MyhLZHYGspM/duOAropsduVo4ZIEOi/FmtVY
 cIh+9QpXoJXHIc0MGahOmBl/2B/9UGZnNAF7DrrL2Fa/Klaqv+5g+oJvsJzRtnWA8V1s
 ++canEwMzwJ4s1YifZ+qA9ex/55ia1ItHoRQR1SNAIScs+CcXjxuLSxfwlT+HALIrRo7
 63V02dwaT9yuGUMYJ/cDvuYgS9WyO/vZWDf1bGp5pTybcKT25BaZ0IHW9RSTxHhrTTTV
 brDQ==
X-Gm-Message-State: AOJu0YwF/w0Z6whm3BaDkfMj3gxY1IG0NU/JTXq4Qoc3CInI+y4Vai75
 fiYXC7tOr1xCC/GIZIBC3FgvM7N4x5EiL8cpsTjNHiBd7ijuU63XBz3hteXr66jYkKw=
X-Gm-Gg: AR+sD12hjdtiY6OWKSLqlXaCECmAqUVnK1ExweNci3AoXZIcfdrgNzpjk5cVINRQR4/
 wSX/BPqaxb8wSuNP8Jfrjsm0tlfHmeMjwZsINuyaNYJ6l8dVg4d0nZ/4fyadnRpbUWZDDM/CwZ7
 L1r/kgMyzJ36ThfKgq/T5FGOP3wPbhviL2byHEr/kp2h4L8ILTMKdNvJD4F5o89trIccGVtHbIp
 SlK7eO//F5zY6gTSCIMXppK0LDgOxd/xHkrnYZknlu2siVyuNAXdaTD26tSAoMRhwQ7HdeY/fGm
 f2IqgrspviiB4P78UP5AoqAIcGa6PhSHz7+llppnZZHT7fQi88VmXwsTyung9TiBnCJJvm3V57X
 u3p5urVcvUm+n/nMDtoOF8F4vVivdeZ1TkpCf6ma5iy14YclVljoZ3vBD6dqhTUQrxGT+b6a0fi
 S843PwgEAXcMgaRErAf8od
X-Received: by 2002:a05:6a00:b42:b0:84e:2722:5d9e with SMTP id
 d2e1a72fcca58-84e593ff2e6mr3917400b3a.1.1785068908246; 
 Sun, 26 Jul 2026 05:28:28 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e533d13f0sm1836751b3a.35.2026.07.26.05.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:28:27 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 00/11] hw/riscv: Add K230 SPI, QSPI, IDMA and XIP support
Date: Sun, 26 Jul 2026 20:27:57 +0800
Message-ID: <cover.1785064312.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x433.google.com
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

Hi,

The k230 machine currently models the C908 core, CLINT, PLIC, watchdogs
and UARTs, but cannot yet model the real boot path. This series adds the
Kendryte K230 DesignWare SSI controllers and their machine integration
as groundwork for full boot support, enabling U-Boot to boot from SPI
NOR through standard PIO, QSPI IDMA, and the XIP read window.

K230 contains three SSI instances with different capabilities. The SDK
numbers them according to the address map: spi0 is the SPI-OPI instance,
while spi1 and spi2 are QSPI0 and QSPI1. The series models the register
contract documented in the K230 Technical Reference Manual V0.3.1
(2024-11-18), standard FIFO-backed SPI transfers, interrupt routing,
Dual/Quad SDR transfers, SPI NOR attachment, synchronous internal DMA,
the HI_SYS SSI_CTRL wrapper, and the spi0 XIP read window.

The implementation is split so that the register model and machine
integration come first, followed by the PIO data path, interrupt support,
enhanced transfers, flash integration, IDMA, HI_SYS, and XIP. A single
K230 SSI qtest binary grows with the series and exercises each layer when
it becomes available.

The final patch adds trace events covering register accesses (excluding
DR, whose per-frame traffic would drown out everything else during U-Boot
and Linux SPI NOR transfers), transaction boundaries, interrupt levels,
IDMA start/completion/error, and XIP reads. The trace points are placed
in a dedicated patch at the end of the series so that the functional
patches stay focused on behaviour and the trace surface can be reviewed
in one place. The events only observe model behaviour and do not change
it.

Testing:

* Built qemu-system-riscv64 at every commit with the riscv64-softmmu
  configuration.
* Ran the cumulative K230 SSI qtest after every commit that provides the
  test target. The final revision passes all ten scenarios:
  register-contract, pio-data-path, interrupt-controller, plic-routing,
  qspi-config, spi-nor, qspi-sdr, idma, hi-sys, and xip-read-window.
* Standard SPI: U-Boot detected W25Q256, loaded OpenSBI, Linux, initrd,
  and DTB with sf read, and reached the Linux initramfs shell.
* Quad SPI: with spi0 configured for 4-bit transfers, U-Boot erased a
  64 KiB sector, wrote and read back 256 bytes successfully, loaded all
  boot payloads from QSPI flash, and reached the Linux initramfs shell.
* XIP: U-Boot read the OpenSBI uImage header from 0xc0000000, verified
  its checksum, and reached the Linux initramfs shell through bootm.
* git diff --check reports no whitespace errors.
* checkpatch reports no errors.

Kangjie Huang (11):
  hw/ssi: Add K230 DesignWare SSI register model
  hw/riscv/k230: Instantiate K230 SSI controllers
  hw/ssi: Implement K230 SSI FIFO and standard PIO transfers
  hw/ssi: Add K230 SSI interrupt controller
  hw/riscv: Route K230 SSI IRQs to the PLIC
  hw/ssi: Implement K230 enhanced QSPI transfers
  hw/riscv/k230: Attach SPI NOR flash to spi0
  hw/ssi: Implement K230 SSI internal DMA transfers
  hw/misc: Add K230 HI_SYS SSI control
  hw/ssi: Add K230 SSI XIP read window
  hw/ssi: Add trace events for K230 DesignWare SSI

 docs/system/riscv/k230.rst     |    4 +
 hw/misc/k230_hi_sys.c          |  169 +++
 hw/misc/meson.build            |    1 +
 hw/riscv/Kconfig               |    2 +
 hw/riscv/k230.c                |  165 ++-
 hw/ssi/Kconfig                 |    4 +
 hw/ssi/k230_dw_ssi.c           | 1754 ++++++++++++++++++++++++++++++++
 hw/ssi/meson.build             |    1 +
 hw/ssi/trace-events            |   11 +
 include/hw/misc/k230_hi_sys.h  |   55 +
 include/hw/riscv/k230.h        |    9 +
 include/hw/ssi/k230_dw_ssi.h   |  111 ++
 tests/qtest/k230-dw-ssi-test.c |  917 +++++++++++++++++
 tests/qtest/meson.build        |    4 +-
 14 files changed, 3191 insertions(+), 16 deletions(-)
 create mode 100644 hw/misc/k230_hi_sys.c
 create mode 100644 hw/ssi/k230_dw_ssi.c
 create mode 100644 include/hw/misc/k230_hi_sys.h
 create mode 100644 include/hw/ssi/k230_dw_ssi.h
 create mode 100644 tests/qtest/k230-dw-ssi-test.c


base-commit: f893c46c3931b3684d235d221bf8b7844ddbf1d7
-- 
2.43.0

