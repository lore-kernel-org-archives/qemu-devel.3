Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FB7D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JEl-00014J-Kx; Tue, 05 Nov 2024 08:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEj-000148-Bd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:04:45 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JEf-00029g-Iz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:04:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso46028975e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811879; x=1731416679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0d0MdOdBk05YfkTKMh9QebQk9C1dE5Lu0NYo5nI56TA=;
 b=jr9NeVr3Png5Fo9XrNwrhUrLfYWuvpRAQ8dglGrLXPQ36CyU3l/X1eHvIfE9eRp5E6
 512NPsphIiSvwfnO3BBTc+Kc9LcThRBM/I02ZfbTvg6TSOkZzWwyYsjMwHyCcYqw+qYO
 C05CXrxBFMGcCBPBGJFsWQYr39GDwHoRG8QTREIgX9IJiYzc08TegNGcRi5m1H0W9fKf
 k/kQl6Xt1ItTMe8P6M0RIHe+ncMboNCP52/rgaS0xi5ynL/ps37wFY5BjWwLvYD5TgMg
 NbgUHz/A4EUxrkX1rsA7S0FXSfboBQf0A671+m5Ja3rPTiEb/NEAdCnW01HVoKKI3BsM
 gzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811879; x=1731416679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0d0MdOdBk05YfkTKMh9QebQk9C1dE5Lu0NYo5nI56TA=;
 b=WhijZa3rmXK9GfDfMWfbPZUR9dTUxYfai0z+wnkGrlGdHJIVYhNCAYyjp2xy9HdsPg
 w4McsKGbBuGfzz6W/1HpgeXlzRWIPghXUlzrf24TRzx8ojAXlLuLge/Ji0P5mh0vZOgA
 rZijbzmX3y7FwUTAI+4CQpmN3+gaSoubgNRE5XjFKUvSxzCSZ1mKoBg8GYBZ0mv48DQf
 H+NAerw0Nd8a5m2X0NSWBhZRb5hqbz83Rg7clzTin/estJiozQIsJ5EA9wRGCY9EJcna
 WbEBG/1/XvaN3/mH8I73kj2ChFpzMxwTTtLmB9k1aQeRjd8AGkxvjPohtOu3PN74udpc
 EVjQ==
X-Gm-Message-State: AOJu0YxriLYPygwBtsEQaaOiWMxyycnSv+zyYxuYWh9+9UGQIIkgLHTE
 B3wt5t1GuD15D17dR1in5w76TqywsX1hlMEYvHHNYT34nIC9bkrZ+XsuxKjU3+9aXPq/AF2nObr
 u5To=
X-Google-Smtp-Source: AGHT+IH3aiRfPBaI7M5oKHPBcUXl3T5JanQZ78E2jyPLCYqwkN0cYdROZT3AAJxDGXS/gaHC/ce9uw==
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4328328481dmr143793185e9.25.1730811879052; 
 Tue, 05 Nov 2024 05:04:39 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983b7sm186005865e9.43.2024.11.05.05.04.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:04:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/19] hw/microblaze: Allow running cross-endian vCPUs
Date: Tue,  5 Nov 2024 14:04:12 +0100
Message-ID: <20241105130431.22564-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Make machines endianness-agnostic, allowing to run a big-endian vCPU
on the little-endian 'qemu-system-microblazeel' binary, and a little
endian one on the big-endian 'qemu-system-microblaze' binary.

Tests added, following combinations covered:
- little-endian vCPU using little-endian binary (in-tree)
- little-endian vCPU using big-endian binary (new)
- big-endian vCPU using little-endian binary (new)
- big-endian vCPU using big-endian binary (in-tree)

Deprecate untested big-endian machines, likely build on the big
endian binary by mistake:
- petalogix-ml605
- xlnx-zynqmp-pmu

To make a target endian-agnostic we need to remove the MO_TE uses.
In order to do that, we propagate the MemOp from earlier in the
call stack, or we extract it from the vCPU env (on MicroBlaze the
CPU endianness is exposed by the 'ENDI' bit).

Note, since vCPU can run in any endianness, the
MemoryRegionOps::endianness should not be DEVICE_NATIVE_ENDIAN
anymore, because this definition expand to the binary endianness,
swapping data regardless how the vcpu access it.
See adjust_endianness() -> devend_memop(). Something to keep in
mind, possibly requiring further work and optimizations (avoid
double-swap).

Next step: Look at unifying binaries.

Please review,

Phil.

Philippe Mathieu-Daudé (19):
  target/microblaze: Rename CPU endianness property as 'little-endian'
  hw/microblaze: Deprecate big-endian petalogix-ml605 & xlnx-zynqmp-pmu
  hw/microblaze/s3adsp1800: Explicit CPU endianness
  hw/microblaze/s3adsp1800: Rename unimplemented MMIO region as xps_gpio
  hw/microblaze/s3adsp1800: Declare machine type using DEFINE_TYPES
    macro
  hw/microblaze: Fix MemoryRegionOps coding style
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/microblaze: Propagate CPU endianness to microblaze_load_kernel()
  hw/intc/xilinx_intc: Only expect big-endian accesses
  hw/timer/xilinx_timer: Only expect big-endian accesses
  hw/timer/xilinx_timer: Allow down to 8-bit memory access
  hw/net/xilinx_ethlite: Only expect big-endian accesses
  target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
  target/microblaze: Set MO_TE once in do_load() / do_store()
  target/microblaze: Introduce mo_endian() helper
  target/microblaze: Consider endianness while translating code
  hw/microblaze: Support various endianness for s3adsp1800 machines
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Add microblaze cross-endianness tests

 docs/about/deprecated.rst                     |  6 ++
 .../devices/microblaze-softmmu/default.mak    |  2 -
 .../devices/microblazeel-softmmu/default.mak  |  5 +-
 hw/microblaze/boot.h                          |  4 +-
 target/microblaze/cpu.h                       |  7 ++
 hw/char/xilinx_uartlite.c                     |  8 ++-
 hw/intc/xilinx_intc.c                         | 23 +++++--
 hw/microblaze/boot.c                          |  8 +--
 hw/microblaze/petalogix_ml605_mmu.c           | 11 ++-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      | 67 +++++++++++++++++--
 hw/microblaze/xlnx-zynqmp-pmu.c               | 12 ++--
 hw/net/xilinx_ethlite.c                       | 28 ++++++--
 hw/timer/xilinx_timer.c                       | 15 +++--
 target/microblaze/cpu.c                       |  2 +-
 target/microblaze/translate.c                 | 49 ++++++++------
 .../functional/test_microblaze_s3adsp1800.py  | 27 +++++++-
 .../test_microblazeel_s3adsp1800.py           | 25 ++++++-
 17 files changed, 236 insertions(+), 63 deletions(-)

-- 
2.45.2


