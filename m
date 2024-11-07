Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527AED29FBC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rEF-0004eG-Fi; Wed, 06 Nov 2024 20:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rED-0004d3-Ta
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rEB-00030i-Uu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:22:29 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so3992645e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942546; x=1731547346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wdhQZu/6S1S85GJh6bxZsUcTXLrcn3y3RRI1Gj4BARU=;
 b=XiEJbZxJtId4yvVuXNED6r6MEo0apIjt9bEwu3eY1pW1wgWIIsEkFpt/Vx3BwRp9Td
 5xOaBa1X5yzvmHQgAAlY0rIZui87T+U8cCIcKCq7YozHk5KPBUNhnPdr7VVz7uNe2Hcb
 IN8SdDoXdfAaDerou0fGhNZoXAhj5uI4OoGAKExNJ3Q0QL/KpRRld+1DNcJ8petqdVsY
 gE668GC/uBd+TdiSL6Zq6bsdj/D64CoYzQxgr7BwgJiC8Ez7g5zHlA7GzLhHzJqH0ttm
 2AQzhHNgMBNSIoEFL3PrJnOUVIKfO//ZHrGZlwWM4L/5OqbadAzJeX+gbVBiMmHlUpK4
 L2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942546; x=1731547346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdhQZu/6S1S85GJh6bxZsUcTXLrcn3y3RRI1Gj4BARU=;
 b=p7c+fyBxa02rSq7iy0RWgxFBRgVDWV14vOIqX7EgxWIQswQx+0/9Xqzv+JYX3EWXaK
 t7UGwxAyhvRm7A7sN9bC7u5Hi5c7nj79TWsFVC6ArwJ2272+BVqd9QFjrUugV1gVB57O
 wnzm1mPT69mX9SzE0rdlvHv+jMVLma5SyDoJehacKugN5q+/hGPyLdUlNbtV9S1Uwg9v
 cIloRVP5aUssPF7FG5Ml9z3dnUyq/u4zwCxBj27GHdRiKU3WS/Zn6QZhmZSAusrtD5G6
 hcmdeKh2MEzAnsZRyUzNTOWyidleZKmQnpzhQQ7mKMv/B71mI3BU81TaljhoUZm096fH
 Ho2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhBBGWrxtrrvbD93W+6whQSLHzAyaHJdl8CcUC+mA6rJLLS8TMs2xq1f0N+N2DCFEBNzb+OKYaSVUY@nongnu.org
X-Gm-Message-State: AOJu0YyxrV8Y1H+pEm0Zo8HXh9W8+lhosGri4w1eSPjem40yx2DW35Gc
 FbiKFJrnudZ9qz4uN++2a0fNYfgO5lN4ABFPgatt3/AtzRJExfXnwanSH1piecc=
X-Google-Smtp-Source: AGHT+IHyNnufrnlfnZTcTd/T0rmoLI0Rp9OYDQOsytHdrT8dZt7j6fEecyygsLLt1mIU6QCIIU1XmA==
X-Received: by 2002:a05:600c:3b1b:b0:431:5aea:964 with SMTP id
 5b1f17b1804b1-432b14d23demr1445415e9.19.1730942545954; 
 Wed, 06 Nov 2024 17:22:25 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73886bsm41882585e9.39.2024.11.06.17.22.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:22:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/16] hw/microblaze: Allow running cross-endian vCPUs
Date: Thu,  7 Nov 2024 01:22:06 +0000
Message-ID: <20241107012223.94337-1-philmd@linaro.org>
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

Since v1:
- Make device endianness configurable (Edgar)
- Convert more Xilinx devices
- Avoid preprocessor #if (Richard)
- Add R-b tags

Make machines endianness-agnostic, allowing to run a big-endian vCPU
on the little-endian 'qemu-system-microblazeel' binary, and a little
endian one on the big-endian 'qemu-system-microblaze' binary.

Tests added, following combinations covered:
- little-endian vCPU using little-endian binary (in-tree)
- little-endian vCPU using big-endian binary (new)
- big-endian vCPU using little-endian binary (new)
- big-endian vCPU using big-endian binary (in-tree)

To make a target endian-agnostic we need to remove the MO_TE uses.
In order to do that, we propagate the MemOp from earlier in the
call stack, or we extract it from the vCPU env (on MicroBlaze the
CPU endianness is exposed by the 'ENDI' bit).

Next step: Look at unifying binaries.

Please review,

Phil.

Philippe Mathieu-Daudé (16):
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/microblaze: Propagate CPU endianness to microblaze_load_kernel()
  hw/intc/xilinx_intc: Make device endianness configurable
  RFC hw/net/xilinx_ethlite: Simplify by having configurable endianness
  RFC hw/timer/xilinx_timer: Allow down to 8-bit memory access
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable
  hw/ssi/xilinx_spips: Make device endianness configurable
  target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
  target/microblaze: Set MO_TE once in do_load() / do_store()
  target/microblaze: Introduce mo_endian() helper
  target/microblaze: Consider endianness while translating code
  hw/microblaze: Support various endianness for s3adsp1800 machines
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Add microblaze cross-endianness tests

 hw/microblaze/boot.h                          |  4 +-
 include/hw/ssi/xilinx_spips.h                 |  1 +
 target/microblaze/cpu.h                       |  7 +++
 hw/arm/xilinx_zynq.c                          |  1 +
 hw/arm/xlnx-zynqmp.c                          |  4 ++
 hw/char/xilinx_uartlite.c                     | 40 +++++++++----
 hw/intc/xilinx_intc.c                         | 59 +++++++++++++++----
 hw/microblaze/boot.c                          |  8 +--
 hw/microblaze/petalogix_ml605_mmu.c           |  4 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      | 59 ++++++++++++++++---
 hw/microblaze/xlnx-zynqmp-pmu.c               |  2 +-
 hw/net/xilinx_ethlite.c                       | 52 ++++++++++++----
 hw/ppc/virtex_ml507.c                         |  1 +
 hw/ssi/xilinx_spi.c                           | 29 ++++++---
 hw/ssi/xilinx_spips.c                         | 46 +++++++++++----
 hw/timer/xilinx_timer.c                       | 42 ++++++++++---
 target/microblaze/translate.c                 | 49 +++++++++------
 .../functional/test_microblaze_s3adsp1800.py  | 27 ++++++++-
 .../test_microblazeel_s3adsp1800.py           | 25 +++++++-
 19 files changed, 358 insertions(+), 102 deletions(-)

-- 
2.45.2


