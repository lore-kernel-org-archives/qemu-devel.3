Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0256EC55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqFPL-0002ix-1F; Sat, 01 Aug 2026 15:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPJ-0002iB-Cm
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:05 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqFPH-0002Ex-9C
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 15:30:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1475340a91.2
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785612601; x=1786217401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pby37PpeiSHslJQ+0ggvR8fN47WjAojT6mCnegk4S+0=;
 b=SZY6ILqNg2lGSZR/z6p7M9YRe/ClIfCnWWi5ZRUspK/ov8Tm2yEwkTjajO3X/UmVdq
 zMdmV9eRBfJ3iJVIh2XUxhcODcRwoGbFseftwLBKLojDtHT/4rEXKCn1PM0MT0aOgj/q
 l8Xsdg/KX9s8ubCyz4spoWFMejSft+jWtIy9fLM4IytrnPZ4SpVLZ6m5KWFXuZBH4Pmt
 Bf79WiOTVAPzGgxmMZnE9epFfNIPbLFJLQllWQXh0sgH0qA9ovv64jHzQCnz4yU7v46O
 f/tkTOp9rgMeB5jwF4ryAtTJT52JcZwUt/63tWfWpGrhTDuWCMgoMK4XISJ9+t97Wy+T
 mEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785612601; x=1786217401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pby37PpeiSHslJQ+0ggvR8fN47WjAojT6mCnegk4S+0=;
 b=qEI413rYCOo2DIIN+U4vvaJ/ax7A+vQwY9O8M9IIOcJ5zyWSDJd3Ma+4mtB6YWDrif
 23yRGStWSnnWTiGI0YbAXyfbr1jEEvFXoRE/PnuC0izDB0l/kmrq0klxigY1byG6Di+9
 /zO3JT5T7GNAD26Fjm3uXC1xy8kjeFcCeAA1bFhEsDmYSVIr2kF26/zIixVw8Ma30Q2v
 otjGd9Avy4ZB23RrdtPCSxz4xNn+2LzHgqfbmJTyd8r9wbrGtXbUIC09eKndFMQ8ZXPQ
 8mfV2WDO18g0FvCKb8njK74mPABJOI8bgulmg7amOqv1OP07UxsVFfmkDcgSLV5seXvB
 TfvA==
X-Gm-Message-State: AOJu0YyUmp+ghAeQQnpGzMwEOumrOqOfoSY1+2uoOtaKwfXpsYxQbrPq
 8ifIcaN0ME6YByQI5/QICz4i6s2R7AN338+UfhF0xsqWH7gg+ZWeq9eDoeU1Rw==
X-Gm-Gg: AR+sD11i9CpHevZM7Vvm5YDOcLr21ZqNkqb5HXkIjeaj4nV485+LBYy4mPBEbSYpF/k
 UJPJQE8lcJPWfSx28lkCE1xhFAH7sB83KvrN99uTU4B0GqZGQ6J0atminlqEMfMEkZbbIK3pyLI
 I53Xs5yJE6LmtZaCck1Fbe9KSz76JKJEXfepOzjlh3r6VotrA/RPqTAv0a3Dkwl9KfMPJQ760wn
 efhyouUSPznGJWuuJZGHDieGFfGGE0PSy2msLgTsOdvh9lkwW4Rvn52KPkYnnGspKtzvIv2YzwD
 OfYaM2ssWR8lo4Lo8J1XwwMzlZLdzUgYI5wyUbs4Tg7NT4AjwzzTf+x5PKCgl41XZxkWKOoajLM
 +ZFkNivTTYEGIGnFw9eUwy7nlvwZeYLYvTAeivyL3W0KWLVIhZCQgrVKfBitvnw2jjFTTzJCjBl
 t1DkHg6jjIlSJGiQcevW47yUy8fZdR6uO+Ej7Gc0g+0qVfR/6k8/28yAiY4A6iD9H4lXOgLCKhC
 X427NpyIw==
X-Received: by 2002:a17:90a:e704:b0:38d:3ca9:434 with SMTP id
 98e67ed59e1d1-38fbc5344a9mr3830867a91.28.1785612601014; 
 Sat, 01 Aug 2026 12:30:01 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2bac654sm2148766a91.10.2026.08.01.12.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 12:30:00 -0700 (PDT)
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
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v2 0/5] hw/ssi: Add DesignWare SSI standard PIO support for
 K230
Date: Sun,  2 Aug 2026 03:28:43 +0800
Message-ID: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pj1-x1034.google.com
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

Hello,

This series adds a reusable Synopsys DesignWare SSI controller model and
uses it to model the three SSI instances on the Kendryte K230 machine.

This series supersedes the previous K230-specific SSI series:

  https://lore.kernel.org/qemu-devel/cover.1785064312.git.flamboyant.h.01@gmail.com/

Following review of v1, the controller has been split into a reusable
DesignWare SSI model and a K230 integration layer. The controller no longer
depends on K230 types, addresses, or HI_SYS state. K230-specific instance
profiles, MMIO mapping, PLIC routing, and flash attachment now live in the
K230 machine code.

The v1 implementation combined DesignWare SSI behaviour and K230-specific
SoC integration in one device. That made the reuse boundary unclear for
other SoCs using the same IP. This revision makes that boundary explicit:
the generic model implements the documented controller behaviour, while the
K230 machine supplies only its instance configuration and SoC connections.

The implemented controller scope is deliberately limited to Standard
single-line SPI PIO: configurable chip selects and FIFO depth, four TMOD
modes, FIFO and status handling, Standard interrupt state, and migration
state for the implemented data path. Enhanced SPI, internal DMA/IDMA, and
XIP transactions are deferred to follow-up series.

K230 has nine SSI interrupt source lines per instance. This series wires all
nine lines to preserve the documented PLIC topology. TXU, DONE, and AXIE
remain deasserted because their transfer engines are outside the Standard
PIO scope modeled here.

The final patch adds an optional M25P80-compatible SPI NOR flash on logical
spi0 CS0. It supports and tests Standard 1-1-1 accesses only; the enhanced
SPI and IDMA boot paths are outside the scope of this series.

Changes since v1:

* Replace the K230-specific controller type with a reusable DesignWare SSI
  model configured through num-cs, fifo-depth, and imr-reset properties.
* Keep K230 instance profiles, MMIO mapping, PLIC routing, and flash
  attachment in the K230 machine code.
* Limit this revision to Standard PIO, FIFO, interrupt, and 1-1-1 SPI NOR
  support; defer enhanced SPI, internal DMA/IDMA, and XIP to follow-up
  series.

Testing on the current V2 development tree:

* riscv64-softmmu build succeeds.
* K230 SSI qtest: 14/14 pass, covering register/reset contracts, Standard
  PIO TMOD modes, FIFO behaviour, interrupt state, PLIC routing, Standard
  1-1-1 flash identification and fixed-address reads, and
  unsupported-register semantics.
* U-Boot Standard SPI payload boot: U-Boot loads OpenSBI, Linux, initramfs,
  and the DTB from a W25Q256 flash and reaches a Linux initramfs shell.
  Standard sf probe, erase, write, readback, and compare also pass.
* Linux 5.10.4 Standard SPI PIO: dw_spi_mmio and spi-nor probe successfully;
  the MTD test partition completes erase, write, readback, and byte-wise
  comparison (K230_MTD_TEST_PASS mode=standard).

Kangjie Huang (5):
  hw/ssi: Add Synopsys DesignWare SSI standard PIO controller
  hw/ssi: Add DesignWare SSI standard interrupt support
  hw/riscv/k230: Instantiate DesignWare SSI controllers
  hw/riscv/k230: Route SSI interrupts to the PLIC
  hw/riscv/k230: Attach a standard SPI NOR flash

 docs/system/riscv/k230.rst     |    2 +
 hw/riscv/Kconfig               |    2 +
 hw/riscv/k230.c                |  178 +++++-
 hw/ssi/Kconfig                 |    4 +
 hw/ssi/dw_ssi.c                | 1083 ++++++++++++++++++++++++++++++++
 hw/ssi/meson.build             |    1 +
 include/hw/riscv/k230.h        |    7 +
 include/hw/ssi/dw_ssi.h        |   78 +++
 tests/qtest/k230-dw-ssi-test.c |  569 +++++++++++++++++
 tests/qtest/meson.build        |    4 +-
 10 files changed, 1912 insertions(+), 16 deletions(-)
 create mode 100644 hw/ssi/dw_ssi.c
 create mode 100644 include/hw/ssi/dw_ssi.h
 create mode 100644 tests/qtest/k230-dw-ssi-test.c

-- 
2.43.0

