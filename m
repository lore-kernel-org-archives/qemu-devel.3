Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC3C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYEe-0001zC-T4; Thu, 13 Feb 2025 07:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYEc-0001yj-HK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:22:26 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYEZ-0002T3-Gk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:22:26 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so159140066b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739449341; x=1740054141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7wSgwIZJNS5wWvbHzf6KxQQFZR0DskwF9SNahv2jROc=;
 b=i662A7aLptifJBx3QrXlvQoAykt3nAK7M52Lik+r4rrykk1aowUksff7QDRhId53y7
 xoIBlncILrfPNzN+XkKx2IZW08bHABLASLAzefTaGDVY4Pp6JKEANHc5QCTgwSckTKd3
 YRdkMjHpb74BQJQBOkW5OPtVIrOvbke7qCetZwon6qntSJDRB30m/NgsE28n7OA1Rlq+
 fdo6WNlNx+42l7PZvYzdjme+r/yTPF64JfhYKcSTqpci//9541KCRFdLqaS5AGHe0W07
 91txf0/wZJBwMT2P1Ua9Z4U1rN17RmqScED0pNvBIwwI6/Cg87WykD+vqzpm+UYBc8HC
 4zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739449341; x=1740054141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wSgwIZJNS5wWvbHzf6KxQQFZR0DskwF9SNahv2jROc=;
 b=IpuUfXfsP33hvSd0BL04xe4dtUCw46vJreCltPMzObM15WPU5qlsmsUhLKi1XPGN9P
 Pw9DURxG5PvLYL7x3h4BViVHBnrNA6syW//7NoJH4EeP0zwXiwMN3H1kFh0QkVbEtg/2
 5Le1XMPOqG4lQt2d2dleRB7qqNB3VcOUDGNtmdG0xKS13HH/LZ1M8CYEZ4QrR8V31NOU
 ukNEfThbcMxY/FoMduS4Y1FtrsxagTRq92OvQdFP+Tv1g2Kn5+3cT5ny0Uz9n6mujn98
 DdlD9jgEdFyYIZWBAs+gSdtJKsRgk8VUtiBJqua+yJmnpFHJqg89JCQHGBX3K2h5qef4
 gxDw==
X-Gm-Message-State: AOJu0Yx+amp1RUf/+x3oSF+mjy5J8rTqBTWOze7KqBXz0ocp88usng7s
 a0WGLXHSxdFg9M6zI16xLmNtQmFV346cQZyo6eQKpl1yAWXGyxRE1YNuhnmE8qxVeK5J6MlRgZ+
 fetY=
X-Gm-Gg: ASbGncusscstwvi7QChW3BxSC/LbYCi2uemyQ/4geWoRwHrlJ5RvQKhqOeJf4jiBsO7
 grF4DEarEETklTuwWlW4UzKlBjKpfquk7N3rJZrNdWq+/zYhIO6HYzX0yszDtVd1Pz/a+mvbPnb
 FJS+z4IK47CLMHwInfPBENbDTjqwD2oYBv7Zu2ZWI6JFe2y6P8ASipVw7W4JszJaynkD4TmoF3c
 Grji4WVpWXfnEAzPbkzMfMtldjxt8gTMNiUCdb/tZVawakzIuv2CRbESdKD4KvN7eOJ5zqTFj/2
 eHYsDATaqG4V0zCgt1s8qXFM7tmJQAD5relCEBXf4AksJZkr+YuHlOhMD8mr
X-Google-Smtp-Source: AGHT+IEShprbey5/yy6IiNK+WOto7g5nqUk3ldvlAZ/dqFDaTv0yRduBDi4IkAcE2yNN3VkXMB+BXw==
X-Received: by 2002:a17:907:7f27:b0:aa6:a7ef:7f1f with SMTP id
 a640c23a62f3a-ab7f3325255mr651627466b.11.1739449341337; 
 Thu, 13 Feb 2025 04:22:21 -0800 (PST)
Received: from localhost.localdomain (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53284042sm120308366b.82.2025.02.13.04.22.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Feb 2025 04:22:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 0/6] hw/microblaze: Allow running cross-endian vCPUs
Date: Thu, 13 Feb 2025 13:22:11 +0100
Message-ID: <20250213122217.62654-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(series fully reviewed)

Since v7:
- Corrected commit descriptions
- Consider TARGET_BIG_ENDIAN for petalogix-ml605 machine (Thomas)
- Remove pointless QAPI description (Markus)

Since v6:
- Simplify MemoryRegionOps indexing (Thomas)

Since v5:
- Introduce QAPI EndianMode
- Update RISCV machine while rebasing
- Fixed INTC use on PPC (Thomas)
- Dropped patch adding more machines (Daniel)

Since v4 & v3:
- Addressed Thomas review comments

Since v2:
- Addressed Richard's review comments

Since v1:
- Make device endianness configurable (Edgar)
- Convert more Xilinx devices
- Avoid preprocessor #if (Richard)
- Add R-b tags

Philippe Mathieu-Daudé (6):
  hw/qdev-properties-system: Introduce EndianMode QAPI enum
  hw/intc/xilinx_intc: Make device endianness configurable
  hw/net/xilinx_ethlite: Make device endianness configurable
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable

 qapi/common.json                         | 14 ++++++
 include/hw/qdev-properties-system.h      |  7 +++
 hw/char/xilinx_uartlite.c                | 34 +++++++++-----
 hw/core/qdev-properties-system.c         | 11 +++++
 hw/intc/xilinx_intc.c                    | 59 ++++++++++++++++++------
 hw/microblaze/petalogix_ml605_mmu.c      |  5 ++
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  6 +++
 hw/net/xilinx_ethlite.c                  | 29 +++++++++---
 hw/ppc/virtex_ml507.c                    |  2 +
 hw/riscv/microblaze-v-generic.c          |  5 ++
 hw/ssi/xilinx_spi.c                      | 32 +++++++++----
 hw/timer/xilinx_timer.c                  | 43 +++++++++++------
 12 files changed, 194 insertions(+), 53 deletions(-)

-- 
2.47.1


