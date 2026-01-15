Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E88D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVR-0000jX-Sl; Thu, 15 Jan 2026 13:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV3-0000ci-OO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSUz-0005hO-24
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso4825735e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503309; x=1769108109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xH7Vjl1eJH80wqrfjzngkEtIrSK7E1AY90dS9LHsuaM=;
 b=uP91kcNAyGiSz1Wn8ZbZ32eu1aFezvoZ8BhWzBNKgC173X6yamSw5eDrxa0HrNoZlU
 JXAwpU+jMJmCad89t65yWucJzXZem5comBDudJ7d5FjmrB6SmPJ2Jqb5mCwnqzNKwpVa
 fZIMeISCndCKB2i0PZduMNZrKinCcu/sSD3YjGkUWcFyrv6aHLaiTFsAHwtPgwg1viRF
 V/rFgmuiOzPBFbweGXvT9b64FLOLktWRwZ85h9e6ZBSbJyND6j1ln2/QxP5bQEevP3CD
 lOSj+29stlJfJGCmA5r6E+iY7L1dfFzkX8R9XMH71RYiwwqHSOqc3E7UyCe7XAZEdSER
 pYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503309; x=1769108109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xH7Vjl1eJH80wqrfjzngkEtIrSK7E1AY90dS9LHsuaM=;
 b=kNbDOxYEP3oZCqaAEXy2N+fCQ1E41ULhd5iR6+ya62RVKWkyoy7InaPp3i6j7JsSYB
 AwfoAAg+gfYHE20zjP1faVk5R+96sW6jq8vkXPZwmH1MoLQ3vB0e1JiHlBB1arwV29L9
 DPO62iMErStDq5pXhsFPE6+LW07rntR35ipFQ3/tRvfuNBFT6MYQp5mXB8fLucwNUshs
 IeBp6hl0X9cVTooMx0MiMmIq1Dq3wHgN1raWnC9XeqY+o3sqD65bT45MXhJonVlE6GzW
 yxmiGVFeXqFO1am97anMp/p12LQEW3lhM5ctDj4Az9OtRgVZvOVTdxWJF8xaT0BBYOqE
 DL+A==
X-Gm-Message-State: AOJu0YyCA7fAeWOgE5AXD9a44t/Q6AB+yJXcvJRrUs60iQbAWzv6Ab8f
 PxqhB3WjVvO1Su7iCUHJymESmzWrNbXRJVCnp2SliTyG7e4XfJ5HD6cvVo5OK32D1eCE8XJgHLa
 ti2J3
X-Gm-Gg: AY/fxX7CMS54z5C17YSeU9QOOe7Jsy1FaQqcYNkZn9XTEHH8awiHSY32/OnF6NVzI7G
 VtYuxL5mzzuJikYtaEGfkQVYJAGmSKH2Wa/f6+1jIUvOwzKRWkuDFR+yv9sr8YZydGLJtnc+rfP
 FHLhwT6AnjSqK/V1+8VZYTqVgl3+6y6aaYUsojH9Vc+aLvbD1OX8PBM1OG8IXHrBUEVmJ42Lq8Z
 9H91u5cVlpssOOcrm0I8R+12/RFRcEy9xKVVZdpaIodqs02UzMLA/OFxSQJlKa4XQPgMuNalqWk
 5CBMv2Taf3lTJ4apeG16imBLHACdmg6b4Cj9jaeZAwWphyqBjoRwt1Yl0xp2uOEQnIx4vbnYspt
 HB0o3xGZiwEQo50DvCcuPw/jtvxAWI6Wui8Buw2B6Mb/mBRal2syaLqm8hm2ij9ATlTFVcDnFJg
 P5XHOLhOKbjj7LiDECNaYoqgqSr8q35x+hcrcJoPKbLMk4pMvxJhN5uSKICzTZxIQopqhqUhzRb
 3dw1Sqvd1wYUrB9NzT7Dm1orkH3zv2MKExq6UTBci69gA==
X-Received: by 2002:a05:600c:c0ce:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-4801eb14ffbmr1246465e9.34.1768503309439; 
 Thu, 15 Jan 2026 10:55:09 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] target-arm queue
Date: Thu, 15 Jan 2026 18:54:42 +0000
Message-ID: <20260115185508.786428-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Hi; here's the first pullreq for arm for 2026. I had a big backlog
of code review after the holidays so this is mostly "things that
were fairly easy to review and collect up"...

-- PMM

The following changes since commit 4cfa1ce0365f56832f46ed8a82d8bd954d16be11:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-01-15 11:29:21 +1100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260115

for you to fetch changes up to 4efed64ffcdb99b977ad0b2129a9c0208456a6c9:

  target/arm: Rename access_aa64_tid5() to access_tid5() (2026-01-15 15:30:16 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/raspi: remove duplicate include
 * target/arm: Enable FEAT_ASID2 emulation
 * hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to disabled uart
 * hw/arm: Re-enable the MAX78000FTHR machine in qemu-system-arm/aarch64
 * target/arm/ptw: make granule_protection_check usable without a cpu
 * hw/arm/omap: Remove omap_badwidth_* functions
 * hw/arm/smmu: add memory regions as property for an SMMU instance
 * docs/system/generic-loader: clarify
 * tests/functional: migrate aspeed_rainier image
 * target/arm: Correctly handle HCR.TID1 and TID3 traps on v7A CPUs

----------------------------------------------------------------
Alex Bennée (1):
      tests/functional: migrate aspeed_rainier image

Jim MacArthur (4):
      target/arm: Enable ID_AA64MMFR4_EL1 register
      target/arm: Allow writes to FNG1, FNG0, A2
      target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
      tests: Add test for ASID2 and write/read of feature bits

Osama Abdelkader (1):
      hw/arm/raspi: remove duplicate include

Peter Maydell (14):
      hw/sd/omap_mmc: Remove omap_badwidth_* calls
      hw/i2c/omap_i2c: Remove omap_badwidth_* calls
      hw/gpio/omap_gpio: Remove omap_badwidth_* calls
      hw/dma/omap_dma: Remove omap_badwidth_* calls
      hw/arm/omap1: Remove omap_badwidth_read* calls
      hw/arm/omap1: Remove omap_badwidth_write* calls
      hw/arm/omap1: Remove omap_badwidth_* implementations
      docs/system/generic-loader: Clarify behaviour of cpu-num
      docs/system/generic-loader: Don't mention QemuOpts implementation detail
      docs/system/generic-loader: move TODO to source code
      target/arm: Don't specify ID_PFR1 accessfn twice
      target/arm: Correctly honour HCR.TID3 for v7A cores
      target/arm: Correctly trap HCR.TID1 registers in v7A
      target/arm: Rename access_aa64_tid5() to access_tid5()

Philippe Mathieu-Daudé (1):
      hw/arm: Re-enable the MAX78000FTHR machine in qemu-system-arm/aarch64

Pierrick Bouvier (2):
      target/arm/ptw: make granule_protection_check usable without a cpu
      hw/arm/smmu: add memory regions as property for an SMMU instance

Tao Tang (1):
      target/arm: Move ARMSecuritySpace to a common header

julia (1):
      hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to disabled uart

 docs/system/arm/emulation.rst               |   1 +
 docs/system/generic-loader.rst              |  56 ++++----
 hw/arm/max78000fthr.c                       |   3 +-
 hw/arm/omap1.c                              | 203 +++++++++++++-------------
 hw/arm/raspi.c                              |   1 -
 hw/arm/sbsa-ref.c                           |  16 ++-
 hw/arm/smmu-common.c                        |  11 ++
 hw/arm/virt.c                               |  13 +-
 hw/char/cmsdk-apb-uart.c                    |   8 ++
 hw/core/generic-loader.c                    |  18 +++
 hw/dma/omap_dma.c                           |   7 +-
 hw/gpio/omap_gpio.c                         |   7 +-
 hw/i2c/omap_i2c.c                           |   7 +-
 hw/sd/omap_mmc.c                            |   7 +-
 include/hw/arm/arm-security.h               |  37 +++++
 include/hw/arm/omap.h                       |  10 --
 include/hw/arm/smmu-common.h                |   4 +
 include/hw/arm/virt.h                       |   2 +
 target/arm/cpu-features.h                   |   7 +
 target/arm/cpu-sysregs.h.inc                |   1 +
 target/arm/cpu.h                            |  59 ++++----
 target/arm/helper.c                         | 211 +++++++++++++++-------------
 target/arm/internals.h                      |   5 +
 target/arm/ptw.c                            |  57 +++++---
 target/arm/tcg/cpu64.c                      |   4 +
 tests/functional/arm/test_aspeed_rainier.py |   6 +-
 tests/tcg/aarch64/system/asid2.c            |  76 ++++++++++
 27 files changed, 537 insertions(+), 300 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h
 create mode 100644 tests/tcg/aarch64/system/asid2.c

