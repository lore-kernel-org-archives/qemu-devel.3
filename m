Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB36D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hb8-0004Qn-NF; Tue, 05 Nov 2024 06:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb6-0004QI-K2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb3-00074s-I7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso47184625e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805577; x=1731410377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+fr8xMcc/UTE8if4NaFHepUm0PBrgttT8j2+6FTnwA=;
 b=uSURsJpAtgqFrTaoZutJV43ABolQJOn5gSe9U+ugglgWLxSNFXiAhvr43J9fx7lGJ3
 7C0fTwYNh02lx9rvRwH94MQ+yXPrn39d4NdxlqRqlds9mlkqvGVCZ1ouko9yWd3NDP1I
 +qlfhBLkQFewe3MpdMyM7Oq9ft8H8SQEDLMkOzSy8oHDRXBigZzT29FnDMFdltnhOq8a
 WyCq3LA6MtiyON85I1ba2z+L98CfK4xU1IKME+4nUXC8Ft30FrXM1uk2HOhnwfgpsuMf
 YtvlRBhkQI9bqsBmMB9lsPBxdRprhodBkSsVCw0YT/Tx6t5k6+UcwZAKLNw4I7bRsyoE
 iA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805577; x=1731410377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+fr8xMcc/UTE8if4NaFHepUm0PBrgttT8j2+6FTnwA=;
 b=gFC7jklXHlkxphnT0cFQj1xukQ5uXu8ZHUETbc825PTaLHb8VbkB2h+CCZW4pB0W+s
 vFs4t7PupVZD9Uh7gVkEjoUOLZQZ2P31AFWA2c+FEeRcPZ31YSF0VNlcm3FSLqe67Vxq
 kRsd30wCy9fYUc5qYqFNojiQMR5cqcTi3JaYQRVEiTdVZLm/tKIoQ0oyF7rN2P8abu9k
 XGDGfPovDx4SNXRJBh6BBUwnRu5WEPu87MbektsHjpBJena0vOoKkAZo4RqrvJ2yCdmE
 q4YFkpdvA/PCBCNNuS7/Ern5BmSCj3sChu/obirfmB5KjZVtgBeZMPrlq8mMOjb/5/ti
 5e8A==
X-Gm-Message-State: AOJu0Yw99JedcrRbLczDospSIZaFKKmYz8ZtNjJkQwf5k8Gh06dOVP4k
 8l0ZqIPtPLg24hX4ElHtMIoYw4tNwOc15ODbX5p4Qs/8Kj+HG8PXRTdd9YY85VFsV1bJlJ9KrA9
 f
X-Google-Smtp-Source: AGHT+IFp5+DooIk5rDzauvBn6PhZuewV2nu1L+wxwtdY6dY1jF/yTwItahzEZ2WT8BaLsZYwVcUTVw==
X-Received: by 2002:a05:6000:3cf:b0:37c:d54e:81fd with SMTP id
 ffacd0b85a97d-381c7ab3368mr12311321f8f.54.1730805577175; 
 Tue, 05 Nov 2024 03:19:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] target-arm queue
Date: Tue,  5 Nov 2024 11:19:04 +0000
Message-Id: <20241105111935.2747034-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:

  Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241105

for you to fetch changes up to 374cdc8efe4a039510cca47e8399d54a1aeb4f2d:

  target/arm: Enable FEAT_CMOW for -cpu max (2024-11-05 10:10:00 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix MMU indexes for AArch32 Secure PL1&0 in a less complex and buggy way
 * Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
 * softfloat: set 2-operand NaN propagation rule at runtime
 * disas: Fix build against Capstone v6 (again)
 * hw/rtc/ds1338: Trace send and receive operations
 * hw/timer/imx_gpt: Convert DPRINTF to trace events
 * hw/watchdog/wdt_imx2: Remove redundant assignment
 * hw/sensor/tmp105: Convert printf() to trace event, add tracing for read/write access
 * hw/net/npcm_gmac: Change error log to trace event
 * target/arm: Enable FEAT_CMOW for -cpu max

----------------------------------------------------------------
Bernhard Beschow (4):
      hw/rtc/ds1338: Trace send and receive operations
      hw/timer/imx_gpt: Convert DPRINTF to trace events
      hw/watchdog/wdt_imx2: Remove redundant assignment
      hw/sensor/tmp105: Convert printf() to trace event, add tracing for read/write access

Gustavo Romero (1):
      target/arm: Enable FEAT_CMOW for -cpu max

Nabih Estefan (1):
      hw/net/npcm_gmac: Change error log to trace event

Peter Maydell (24):
      softfloat: Allow 2-operand NaN propagation rule to be set at runtime
      tests/fp: Explicitly set 2-NaN propagation rule
      target/arm: Explicitly set 2-NaN propagation rule
      target/mips: Explicitly set 2-NaN propagation rule
      target/loongarch: Explicitly set 2-NaN propagation rule
      target/hppa: Explicitly set 2-NaN propagation rule
      target/s390x: Explicitly set 2-NaN propagation rule
      target/ppc: Explicitly set 2-NaN propagation rule
      target/m68k: Explicitly set 2-NaN propagation rule
      target/m68k: Initialize float_status fields in gdb set/get functions
      target/sparc: Move cpu_put_fsr(env, 0) call to reset
      target/sparc: Explicitly set 2-NaN propagation rule
      target/xtensa: Factor out calls to set_use_first_nan()
      target/xtensa: Explicitly set 2-NaN propagation rule
      target/i386: Set 2-NaN propagation rule explicitly
      target/alpha: Explicitly set 2-NaN propagation rule
      target/microblaze: Move setting of float rounding mode to reset
      target/microblaze: Explicitly set 2-NaN propagation rule
      target/openrisc: Explicitly set 2-NaN propagation rule
      target/rx: Explicitly set 2-NaN propagation rule
      softfloat: Remove fallback rule from pickNaN()
      Revert "target/arm: Fix usage of MMU indexes when EL3 is AArch32"
      target/arm: Add new MMU indexes for AArch32 Secure PL1&0
      target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)

Richard Henderson (1):
      disas: Fix build against Capstone v6 (again)

 docs/system/arm/emulation.rst     |   1 +
 meson.build                       |   1 +
 hw/sensor/trace.h                 |   1 +
 include/disas/capstone.h          |   1 +
 include/fpu/softfloat-helpers.h   |  11 +++
 include/fpu/softfloat-types.h     |  38 ++++++++++
 target/arm/cpu-features.h         |   5 ++
 target/arm/cpu.h                  |  49 ++++++------
 target/arm/internals.h            |  41 +++++-----
 target/arm/tcg/translate.h        |   2 -
 target/i386/cpu.h                 |   3 +
 target/mips/fpu_helper.h          |  22 ++++++
 target/xtensa/cpu.h               |   6 ++
 hw/net/npcm_gmac.c                |   5 +-
 hw/rtc/ds1338.c                   |   6 ++
 hw/sensor/tmp105.c                |   7 +-
 hw/timer/imx_gpt.c                |  18 ++---
 hw/watchdog/wdt_imx2.c            |   1 -
 linux-user/arm/nwfpe/fpa11.c      |  18 +++++
 target/alpha/cpu.c                |  11 +++
 target/arm/cpu.c                  |  25 ++++--
 target/arm/helper.c               |  73 ++++++++++++------
 target/arm/ptw.c                  |  10 +--
 target/arm/tcg/cpu64.c            |   1 +
 target/arm/tcg/hflags.c           |   4 -
 target/arm/tcg/op_helper.c        |  14 +++-
 target/arm/tcg/translate-a64.c    |   2 +-
 target/arm/tcg/translate.c        |  12 +--
 target/arm/tcg/vec_helper.c       |   9 ++-
 target/hppa/fpu_helper.c          |   6 ++
 target/i386/cpu.c                 |   4 +
 target/i386/tcg/fpu_helper.c      |  40 ++++++++++
 target/loongarch/tcg/fpu_helper.c |   1 +
 target/m68k/cpu.c                 |  16 ++++
 target/m68k/fpu_helper.c          |   1 +
 target/m68k/helper.c              |   4 +-
 target/microblaze/cpu.c           |  10 ++-
 target/mips/cpu.c                 |   2 +-
 target/mips/msa.c                 |  17 +++++
 target/openrisc/cpu.c             |   6 ++
 target/ppc/cpu_init.c             |   8 ++
 target/rx/cpu.c                   |   7 ++
 target/s390x/cpu.c                |   1 +
 target/sparc/cpu.c                |  10 ++-
 target/sparc/fop_helper.c         |  10 ++-
 target/xtensa/cpu.c               |   2 +-
 target/xtensa/fpu_helper.c        |  35 +++++----
 tests/fp/fp-bench.c               |   2 +
 tests/fp/fp-test-log2.c           |   1 +
 tests/fp/fp-test.c                |   2 +
 fpu/softfloat-specialize.c.inc    | 156 ++++++++++++++------------------------
 hw/net/trace-events               |   1 +
 hw/rtc/trace-events               |   4 +
 hw/sensor/trace-events            |   6 ++
 hw/timer/trace-events             |   6 ++
 55 files changed, 516 insertions(+), 239 deletions(-)
 create mode 100644 hw/sensor/trace.h
 create mode 100644 hw/sensor/trace-events

