Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E20C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5db-0006r8-JQ; Tue, 11 Mar 2025 15:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dS-0006qS-1I
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:31 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dQ-0007PV-3f
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso117141f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722685; x=1742327485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1LNxq97AL9tIfUd5CRs+zIjvQKOEYV6jhbavAz1QA4=;
 b=yMZnY30nvQQ34mo+Nar7UJLItaiXybB2W3AOcxNTkMYcf99YomolHVNW10uT570qz/
 1hL6CfIPg5figltRE7a/kgms5EhvCx4Qfo+tt5yo2F1SsjH0kreqFW4z6xPZSt1tnSyP
 hL/Ttxn5Tt+EI+xpUdivQd/1QHvKoN06oEJzLliT9gFXFhQ2g3HhuJTElK6YpeoDMyBf
 Y7TRAeMSVdzPQuU2H4fPUa1SGu+DyY108HsaF6Hw8jghQPuEV+BzHtTnWIAABQKEmKA0
 tXdQFD5/KfrwP88w4RRtbRyxdL0ec8Qee4a4E11kJ71QElQ8J3C8J/zkzUOEBXfZx/VJ
 kcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722685; x=1742327485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1LNxq97AL9tIfUd5CRs+zIjvQKOEYV6jhbavAz1QA4=;
 b=ceSrA9T9aOElhh19A02QX/s6Heo0CYROfy9+wxcRQiTJyg21lvSFCZlNnJ7Cr2j5Db
 ILYQ3d88ytVB/0KDaQNG7hphXUVZ5cmaQtOLmE50OUQyBAGAXcQTIhKkFbEIyKgbKdWv
 uSwLuHmg/2GomkpkuwOYOZ3tNkyRVlLkVdo+x895Bxv1GVbskm0vHWdReN0mXvb1ClI1
 bzGVmIxC54imrAX60C2Y9UXGP0GWuvaJ9Nl/aBKrHoRgEi6UQWibY2w8051R+o0XUjjM
 ezLjSgvfAcHTVF+6LbbndRCzWHLe5NGPGUYSf1UZNqaVpVFtIYm7rnYqYwjJrrAl4svL
 a28A==
X-Gm-Message-State: AOJu0Yw+SQ7D29O3udotY8O6nQ/hbZ307BfwnQEzUrYZXd8igSzckaUB
 xVs8mJusCIDw9fmFQed+NDv/GRAAPMZaGszjlDMPD4sjGWA84S3zFMW7kp7Mzyi8mn2KghAA6lI
 9ZXI=
X-Gm-Gg: ASbGncvXk7cZgKsx3gu2tjb088TRi9++9NJvytvV+25Ez6HWK0iTtIlXTmK3LhLiflY
 VRRkMkNkFkJf+rERZyr24mI6HpcvwTD0LOXsIU6RQRfsF+E/pQ4Igrw8PGxmk7Iaz7mkh80whz2
 KJvS/HPRQ6eMuy5/ntB2XUgYOXtYW0Yum0+9+Rg95zzptY99HdPBslXWMgaU6q4cECh9v4rafRQ
 HHb48dqWpUmgiX+NTBBB4jo7s1xBqTYpbcxnJCqqnDDIbcs1ONWYEKFMTAz/u+sgVa4YTv8mv/L
 gP4C4np4kAGCQBa2mmvWpdfd9ZB+ARWmgYABfEP1GDHnfOqRIKq6mi8qxxyd4tfQGLUxhUnRDK6
 wOAbLhqa+xAISGmKL1yk=
X-Google-Smtp-Source: AGHT+IF2S0lrAq49xD2z5psGodoE2nyR/um2kGZ/sDcVUgTeIAkvdYUAlkxCdesguLeIe6Y4p6MmBQ==
X-Received: by 2002:a5d:47c2:0:b0:38d:d166:d44 with SMTP id
 ffacd0b85a97d-39279e5172emr5953770f8f.23.1741722684987; 
 Tue, 11 Mar 2025 12:51:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e222dsm19027792f8f.72.2025.03.11.12.51.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] Misc HW patches for 2025-03-11
Date: Tue, 11 Mar 2025 20:51:09 +0100
Message-ID: <20250311195123.94212-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250311

for you to fetch changes up to a5368f2e00c81c8c2b5dd0318293b11f8ed7c7c8:

  hw/sd/sdhci: Remove need for SDHCI_VENDOR_FSL definition (2025-03-11 20:03:30 +0100)

----------------------------------------------------------------
Misc HW patches

- Set correct values for MPC8569E's eSDHC (Zoltan)
- Emulate Ricoh RS5C372 RTC device (Bernhard)
- Array overflow fixes in SMSC91C111 netdev (Peter)
- Fix typo in Xen HVM (Philippe)
- Move graphic height/width/depth globals to their own file (Philippe)
- Introduce qemu_arch_available() helper (Philippe)
- Check fw_cfg's ACPI availability at runtime (Philippe)
- Remove virtio-mem dependency on CONFIG_DEVICES (Philippe)
- Sort HyperV SYNDBG API definitions (Pierrick)
- Remove need for SDHCI_VENDOR_FSL definition (Philippe)

----------------------------------------------------------------

BALATON Zoltan (1):
  hw/sd/sdhci: Set reset value of interrupt registers

Bernhard Beschow (1):
  hw/rtc: Add Ricoh RS5C372 RTC emulation

Peter Maydell (4):
  hw/net/smc91c111: Sanitize packet numbers
  hw/net/smc91c111: Sanitize packet length on tx
  hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic numbers
  hw/net/smc91c111: Don't allow data register access to overrun buffer

Philippe Mathieu-Daudé (7):
  hw/xen/hvm: Fix Aarch64 typo
  system: Extract target-specific globals to their own compilation unit
  system: Replace arch_type global by qemu_arch_available() helper
  hw/acpi: Introduce acpi_builtin() helper
  hw/i386/fw_cfg: Check ACPI availability with acpi_builtin()
  hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
  hw/sd/sdhci: Remove need for SDHCI_VENDOR_FSL definition

Pierrick Bouvier (1):
  hw/hyperv/hyperv-proto: Move SYNDBG definitions from target/i386

 MAINTAINERS                      |   2 +
 include/hw/acpi/acpi.h           |   3 +
 include/hw/hyperv/hyperv-proto.h |  12 ++
 include/hw/sd/sdhci.h            |   2 +-
 include/hw/xen/arch_hvm.h        |   2 +-
 include/system/arch_init.h       |   2 +-
 target/i386/kvm/hyperv-proto.h   |  12 --
 hw/acpi/acpi-stub.c              |   8 ++
 hw/acpi/core.c                   |   5 +
 hw/arm/fsl-imx25.c               |   2 -
 hw/arm/fsl-imx6.c                |   2 -
 hw/arm/fsl-imx6ul.c              |   2 -
 hw/arm/fsl-imx7.c                |   2 -
 hw/arm/fsl-imx8mp.c              |   2 -
 hw/i386/fw_cfg.c                 |   8 +-
 hw/net/smc91c111.c               | 148 ++++++++++++++++---
 hw/ppc/e500.c                    |   1 +
 hw/rtc/rs5c372.c                 | 236 +++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c              |   2 +-
 hw/sd/sdhci.c                    |  18 ++-
 hw/virtio/virtio-mem.c           |   6 +-
 system/arch_init.c               |  19 +--
 system/globals-target.c          |  24 ++++
 system/qdev-monitor.c            |   4 +-
 system/vl.c                      |   6 +-
 tests/qtest/rs5c372-test.c       |  43 ++++++
 hw/rtc/Kconfig                   |   5 +
 hw/rtc/meson.build               |   1 +
 hw/rtc/trace-events              |   4 +
 system/meson.build               |   1 +
 tests/qtest/meson.build          |   1 +
 31 files changed, 503 insertions(+), 82 deletions(-)
 create mode 100644 hw/rtc/rs5c372.c
 create mode 100644 system/globals-target.c
 create mode 100644 tests/qtest/rs5c372-test.c

-- 
2.47.1


