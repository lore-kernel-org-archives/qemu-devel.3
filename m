Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0FBC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURG5-0002oO-AB; Thu, 18 Jul 2024 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURG2-0002ei-Pd
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURG0-0008Os-SO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4267300145eso3174555e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309595; x=1721914395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jB3mtKONLKfvyrmi/JZWiHst5BTxmflq/YkBdDFq/4o=;
 b=TOEKOWKdxqgmCoYmb9KxNDFgL8tm1HTxxKUqqMrWzeHgL7vvYloRS9VxXVh4LtcAZ8
 t6iyINQRx9jfbTISgrojTUtQi3NBVO8lv76tUpnKqVrRP0GahAi2ZMXrbjCYQ/4cEbJG
 gQUZjhpqxtbVjPien+P82Awt9G3BBccXCYT/CG3A7RB8oc46Zi9hnmQUNhNEW8//X5hy
 8Y8OqwidXtCGCMt6q+qqElcOdeNWX0/zF3l/kAGlBoyPCPFOf0cVr4s3y/knN1SuNfYT
 1ezc86KhVnAkj5bKp6Y+VKwjMVG+eoHW6ESY+hYlMg/PoGETSSiu0Zutjo7Tv/knAh3H
 j8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309595; x=1721914395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jB3mtKONLKfvyrmi/JZWiHst5BTxmflq/YkBdDFq/4o=;
 b=tjvtNYwxvmYGjSuL2deVa8khcVKBrYRo+Iyb1wsSHzGlDrJwp/JTAJ3WK012vFk6zJ
 akG+kGb1w4VPH2JErYFweZ14Vem8M8OefSQJPuSnKV39/IfgeV0BS7iQAuc7QXlWilVG
 8dBPRajY1gBTzqXDhy63ytIMuLBZbfMaTznmNu1ocNPnaU1LYoKwMoicn9Ttc/O7Ryx1
 nvjYsWPPHuEr9RCUk7NAekabBvZuDCRASJwP+gAKwQ05hC2V9r3oEbavpeOkwJTeiz8n
 s3u4JnsxvhmsemXlB+50WYS5HE1Niy352iF266ZXwhG4ub8aEo+JnYBy/upqAVtmPnuV
 oe6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoruUzQwW37o+lAIjzQws5/B4377b3I+6GnAzVGQMbjYvoxAonA7BGuBazjUjqZHS7bAIge7MeGwFkOGwAwdveOI9Qu7o=
X-Gm-Message-State: AOJu0Yz6oLxxWjg/4U411vT3ZvbyTDYMOPg2+VtlTIt35Ci9BKUjvHjl
 Mbyi8SJhaQ6OrsSnVkF7uAnlaH/gXvOX4xBUP4f3TRcA73gP8MsgVtc9JPGIC1Y=
X-Google-Smtp-Source: AGHT+IF73AEpdxRhuinlFnhoa3aTsuWNcvdd6geUFoqnWga9d+uicS6S8lQIBp7fZ0sdme5XCvsyDQ==
X-Received: by 2002:a05:600c:1988:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-427c2cc9904mr40750745e9.22.1721309595050; 
 Thu, 18 Jul 2024 06:33:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a95099sm14163295e9.48.2024.07.18.06.33.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 00/19] Reconstruct loongson ipi driver
Date: Thu, 18 Jul 2024 15:32:52 +0200
Message-ID: <20240718133312.10324-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since v4:
- Fix build failure due to rebase (Song)
- Loongarch -> LoongArch (Song)
- Added Song's tags

Since v3:
- Use DEFINE_TYPES() macro (unreviewed patch #1)
- Update MAINTAINERS
- Added Bibo's tags

Thanks,

Phil.

Bibo Mao (16):
  hw/intc/loongson_ipi: Access memory in little endian
  hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
  hw/intc/loongson_ipi: Extract loongson_ipi_common_finalize()
  hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
  hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
  hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
  hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
  hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
  hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
  hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
    handler
  hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
  hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
  hw/intc/loongarch_ipi: Add loongarch IPI support
  hw/loongarch/virt: Replace Loongson IPI with LoongArch IPI
  hw/intc/loongson_ipi: Restrict to MIPS

Philippe Mathieu-Daudé (3):
  hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
  hw/intc/loongson_ipi: Remove unused headers
  docs: Correct Loongarch -> LoongArch

 MAINTAINERS                           |   6 +-
 docs/about/emulation.rst              |   2 +-
 include/hw/intc/loongarch_ipi.h       |  25 ++
 include/hw/intc/loongson_ipi.h        |  50 +---
 include/hw/intc/loongson_ipi_common.h |  72 ++++++
 include/hw/loongarch/virt.h           |   1 -
 hw/intc/loongarch_ipi.c               |  68 +++++
 hw/intc/loongson_ipi.c                | 355 +++-----------------------
 hw/intc/loongson_ipi_common.c         | 344 +++++++++++++++++++++++++
 hw/loongarch/virt.c                   |   4 +-
 hw/rtc/ls7a_rtc.c                     |   2 +-
 hw/intc/Kconfig                       |   8 +
 hw/intc/meson.build                   |   2 +
 hw/loongarch/Kconfig                  |   2 +-
 14 files changed, 570 insertions(+), 371 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c

-- 
2.41.0


