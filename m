Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080ADD31A0C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsbB-00061X-4U; Tue, 13 Jan 2026 23:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsb7-00060G-1s
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:09 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsb4-0008Ga-CT
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:08 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c227206e6dcso5303513a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768365305; x=1768970105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=WSTzd1zt8Kmp62mB8WHhW/+1mzpFRUlimqYUMYs65fg=;
 b=HyvQSPy9gzMXm9JKU35oJa9nLx/jEP2cwu2IQUWrkqZdOzXhOtjJKNx7eURpIEFV+X
 fvCThmxtC6GOfhVkkzVsrpsAP2NCJHLGg6JrBTSW+VdyniB84wqsCkgwJSXKZ4kBM7gF
 5oK3UdzQ/KSFLNdSGXK5i3xdOc65SbMEezxZa/cSUT1njiY6u/wFfOvB0O72T/iWkQdz
 9cHVF5lVrGkiNPPf/fxbI9Qip+A3wbn2WR0MgN7dK78916KK4q+wEe5mchK4IQ/+BkNk
 TQ2fzPZ70+zciZLUmsO9FpX2SPSFc+0cg9isZmUmUfg1wSXPB2DO7LF1XlnZ2tUz/gbR
 /GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768365305; x=1768970105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSTzd1zt8Kmp62mB8WHhW/+1mzpFRUlimqYUMYs65fg=;
 b=bh4aLR4s4CnZeRT07UifKbcksxeRQ8s/Z+wu8MXniNlxWhK6WVDkxiMPhURt3RZzpF
 3MP35NFHNbE43aFBMC83v4GirYqwTWVx16mQ44lUUUY+Y3XncATIOnQ8Di435L65Xf7p
 /8A94lS/HyoLkkMl36YN0cmrkIx8rpEuN8unRRnT2h3VhrXMH442DBbqve5RKAiNrQ2C
 QQxtzBwC5Aj3nJAIajfIFohxBypXFU+7SR5UfILCpK/pwGxp5G3tR47zizjAm8jeZow3
 M3tyBgcxvOQMc0DGxR/CHWFtYWjDm5VqcmelghcIjagJUdGU5k2C7yAmZFZeLE408lqg
 tOeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDSpidGrxeyYQMub0Vl4idqOWpul2f7zVTr2HXK1xiYytxA9OG2ZPiZ5DWQ+eDRJZXx35pn8K9sevZ@nongnu.org
X-Gm-Message-State: AOJu0Yzzv4Nzz7b6uLFVskfc24r2tevbgFUMEy+OYcGXGtUqmyiW2DWM
 Ke78XP3H8S9S65JPmftbWR8eCXZHkfyFjnfoEwK3+4Sj2tI7qDT0vD7I
X-Gm-Gg: AY/fxX4WMbptkxuo1fp+IokAhSQ6pz2LOkaEUwlKus/I3ip/lQmKKNRGWDb0m6NpS2T
 pULUSsUtMv7j33F6VE2dU1mPVcFYRkzyx/7pSN08xihWMBc+OmbSb7pAranfN/JxIEo/mD/G9ov
 9JYbuWVJmjc0x4iucOHzfGLdFgHsFUX1i6ISlS0Z4ILy+zajUd0+iHKfmOGszcrzvpKLJg4xxIe
 o01nn0NgxgoqfR7fVjL2kOlIJj37oLzNaQzS2QM6MJbXNeWh2bLYEigsJcS6+hPuUQyyEv4NlT/
 rEhs3RJ6Olq6KsmE78FVV6NgSFtdKXRRIhJYXBJHZU+YH+TBEe0NT2Hqm79sjzoojhdojNsI86a
 ckl8jU8QNpb8YgNSA8cmTw6E9fe5u/BKIiafBBaQmV5lIRNO3SqDa1PRkwhUxa25aGS0g7fhmr1
 EngheVVycAtRpRX6OUX/Tm
X-Received: by 2002:a05:6a20:7293:b0:384:f573:42b9 with SMTP id
 adf61e73a8af0-38bed21db38mr1408044637.67.1768365304817; 
 Tue, 13 Jan 2026 20:35:04 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm20702659a12.0.2026.01.13.20.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:35:04 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 0/6] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Wed, 14 Jan 2026 15:04:22 +1030
Message-ID: <20260114043433.1056021-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

v2 separates out prep patches so the machine can be reviewed
independently. It depends on the following two series:

 AIA: https://lore.kernel.org/qemu-devel/20260109133125.397364-1-joel@jms.id.au
 Boot: https://lore.kernel.org/qemu-devel/20260109131657.396794-1-joel@jms.id.au

Original cover letter:

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

This initial series adds the base machine support including:

 - AIA (Advanced Interrupt Architecture) support
 - PCIe controller and DesignWare I2C integration
 - Serial console and device tree generation
 - Functional tests for OpenSBI+Linux boot

Based-on: 20260114012846.981884-1-joel@jms.id.au 20260109131657.396794-1-joel@jms.id.au

Joel Stanley (3):
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c buses
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (3):
  hw/riscv/atlantis: Add PCIe controller
  tests/functional/riscv64: Add tt-atlantis tests
  hw/riscv/atlantis: Use halting kernel if there is no payload

 MAINTAINERS                                  |   9 +
 docs/system/riscv/tt_atlantis.rst            |  38 +
 docs/system/target-riscv.rst                 |   1 +
 include/hw/riscv/tt_atlantis.h               |  94 ++
 hw/riscv/tt_atlantis.c                       | 916 +++++++++++++++++++
 hw/riscv/Kconfig                             |  21 +
 hw/riscv/meson.build                         |   1 +
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  68 ++
 10 files changed, 1153 insertions(+)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.47.3


