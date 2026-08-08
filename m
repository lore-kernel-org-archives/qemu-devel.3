Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D8C5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 18:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsloz-0008RF-Ef; Sat, 08 Aug 2026 14:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslow-0008QT-SY
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:30:59 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wslov-0007Po-0Y
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 14:30:58 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so564646a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786213855; x=1786818655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JYliWj+bsWqNMt78IzfjVnsYllEiSM2D2J7nVonr0dI=;
 b=au1bkErm9QbCTgMjxdD0vK8XCx2U19PYUTsaUpj0G9+rM6isI2rzh1MFbVzpDzsFSj
 6CPfMW1mG4tQlET3LTF7GWAAC8QEgULdNTw3BfVA2Km9QotheH+mmY79On4brvGVbhJd
 mscB1ZQ7Ug+FUeWu/8PCNa9sytmo7ZzIxsRFRcmoQKbfkvFIv2O6FRyLxs+d2xBx+dXo
 zOBEsu//UupdUzrXFStTaohRQmNEGMeY4Gn2w6VzAjlEz2srfZ2/RyYKnPIXTzTgAUsG
 oTIS/hRAECTTAX3CvGheRa8bpB1thSkvVYxDSx4oxMeqfi3S+kQGp88fJXqFnMexde/Q
 0E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786213855; x=1786818655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYliWj+bsWqNMt78IzfjVnsYllEiSM2D2J7nVonr0dI=;
 b=HPAuGL1UMeryZLJ6Xf5OiZFb60kydRqfHXyiDnvh/T3sNw50zUE5Lr9qQ9Sdq01xQv
 vyLJ6SKxE5Mc1V41ETGF0wT3EOv4OXdfKh3fgQwCfOpgmIyiSeWTl2uocKadqzCGr+lJ
 dPGS8WQf1pVkZhblsZ9JD2i9M39b1DVH4OZ+hYxuqkViJQsNuKQalCSePVyi7l7/QV2+
 6bBAphonPsAX2wQBozZ586TJNHW2BSOny0J88VdJooJOvDomL0o/6Ajonll3GYUbFft2
 oJQkaG8bzZpjeePvljYJfYD3HQ8vAVXGdVvjOrKFFz7t9u0bZjdSsde7o+5icW9/WCHR
 BaYg==
X-Gm-Message-State: AOJu0Ywz10qzpExExBwMJDewqIS0xpd7O8ghuxmYLrZOgWFd3JRU/Nbg
 gQ13uq60+LgtUfujYGhhK5Q4xop02wp/25plww1jIF1NaJlw6BwJLWR2B2m6wukECPnsZg==
X-Gm-Gg: AR+sD123h2T+EMk4DLG59Z6TxklVXSrc/x3kALKryNARHxO0Hdlqyki9oCmhjE3zSBN
 ZbgZC2WtSIfey2qOoE41HGJeVYRaL58QjIQxdzvas2sha1iFXZXvPjX/QUt4Y21gSwYvdfxp7FV
 1VWf7Hj0KcT/C2ldTHqh4GTF8vh4EO+X4USL9zJ/fPxo7xFwhtRgKz6eS9ycsX1sEYfhSm6V3Mn
 VxVStrb0FN15eI9LciJ0L5/miwg4+Z0RpYmcOxYNBEumbhczcbjooGoi9aQ7nekFTYrUfxrsQjp
 T6d57TgoOT8O+Z/xTyP+NKGJFb3QPBf0Uq4gjxKwatsYSGPY64ORcJbGEg3wy2ShrwVfR+b75bA
 GMzJ9DOgjvZlI4tBA9y21siQu8s81OnxSuL+bSQSsl2/RkPVulcJhglqv7jRv8wl129PxNdWLWa
 RycSG4TfKmv4hNHXaX4e0mMfayzn8dd8yveJ9+CsIr0eHClWtU3O7v1XAJ8FQaSV4Z2oZ9hhFTG
 +z4LcyVIkKk9qdtPRM=
X-Received: by 2002:a17:90b:528c:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-3903c5993cemr33404029a91.5.1786213855102; 
 Sat, 08 Aug 2026 11:30:55 -0700 (PDT)
Received: from LAPTOP-CS7CB8K1.localdomain
 ([2409:8a00:6035:79d0:50fd:3a6e:508:beb2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm6772393a91.2.2026.08.08.11.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 11:30:54 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 0/5] hw/riscv: Add K230 DWC SSI Standard PIO support
Date: Sun,  9 Aug 2026 02:29:51 +0800
Message-ID: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

This series adds a reusable Standard PIO model for the Synopsys DWC SSI
controller. The K230 machine has three such controllers, and the later
patches add their machine integration.

This series supersedes the previous V2 series:

  https://lore.kernel.org/qemu-devel/20260801192848.30606-1-flamboyant.h.01@gmail.com/T/

The V2 series superseded the previous K230-specific SSI series:

  https://lore.kernel.org/qemu-devel/cover.1785064312.git.flamboyant.h.01@gmail.com/

The first patch adds the Standard SPI register subset, configurable FIFO
and chip-select resources, four transfer modes, reset and migration state,
and RAZ/WI handling for unsupported enhanced SPI, DMA, and XIP registers.
It uses the DWC CTRLR0 layout, where TMOD is at bits [11:10]. The second
patch adds the Standard PIO interrupt support. The remaining patches add
the K230 instances, PLIC routing, and an optional SPI NOR on spi0 CS0.

Changes since v2:

* Rename the controller model and integration from DesignWare/DW to DWC.
* Clarify the DWC CTRLR0.TMOD layout and keep DW APB SSI variants out of
  scope.
* Refine Standard PIO transfer pacing and FIFO handling for long transfers.

Enhanced SPI, internal IDMA, HI_SYS, and XIP remain separate follow-up
series. The older DW APB SSI TMOD encoding is not part of this series.

References:

K230 Technical Reference Manual:

  https://github.com/revyos/external-docs/blob/79b3a79072412ead81427e6755b4d9e6d9ded8d8/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

Linux DWC SSI driver and binding:

  https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw-core.c
  https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw.h
  https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

Intel Arria 10 HPS TRM, used only for comparison with the DW APB SSI
layout:

  https://www.intel.com/content/www/us/en/docs/programmable/683711/21-2/hard-processor-system-technical-reference.html

Testing:

* Built qemu-system-riscv64 and the K230 DWC SSI qtest target.
* Ran all 14 K230 DWC SSI qtests, including Standard PIO modes, register
  contracts, interrupts and PLIC routing, and Standard SPI NOR reads.
* Standard 1-1-1 transfers were also exercised manually through the K230
  SDK U-Boot and Linux SPI paths against the attached flash.
* git diff --check passed.
* checkpatch.pl reported no code errors; its MAINTAINERS coverage warnings
  are expected because this series does not modify MAINTAINERS.

Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Suggested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Kangjie Huang (5):
  hw/ssi: Add Synopsys DWC SSI standard PIO controller
  hw/ssi: Add DWC SSI standard interrupt support
  hw/riscv/k230: Instantiate DWC SSI controllers
  hw/riscv/k230: Route SSI interrupts to the PLIC
  hw/riscv/k230: Attach a standard SPI NOR flash

 docs/system/riscv/k230.rst      |    2 +
 hw/riscv/Kconfig                |    2 +
 hw/riscv/k230.c                 |  178 ++++-
 hw/ssi/Kconfig                  |    4 +
 hw/ssi/dwc_ssi.c                | 1103 +++++++++++++++++++++++++++++++
 hw/ssi/meson.build              |    1 +
 include/hw/riscv/k230.h         |    7 +
 include/hw/ssi/dwc_ssi.h        |   79 +++
 tests/qtest/k230-dwc-ssi-test.c |  702 ++++++++++++++++++++
 tests/qtest/meson.build         |    4 +-
 10 files changed, 2066 insertions(+), 16 deletions(-)
 create mode 100644 hw/ssi/dwc_ssi.c
 create mode 100644 include/hw/ssi/dwc_ssi.h
 create mode 100644 tests/qtest/k230-dwc-ssi-test.c


base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
-- 
2.43.0

