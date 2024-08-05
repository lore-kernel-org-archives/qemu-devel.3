Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C3C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26O-0005OP-9K; Mon, 05 Aug 2024 14:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26J-0005Ni-RI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:32 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26I-0006L0-1J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so1092588366b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881187; x=1723485987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nOghvEqM1lafZIm2kgjq99HQSQNfaJ4N/kBrqQYunpM=;
 b=FMASOlHOwr/NYcLtF4wkrAnAvGfJ1uMYpQkuGz/RX6JWVXJJf+64tCb8GJ+gkWo6wd
 Xp4NW3dEVA5lH3U4ue/bhA2aTJxTJLX+hP9Dhh4q5v/SmUkHGHKV1PaugXx6o14VqDrH
 6wIZG+UjGvOgboZ9+E4I+WmlvWLjJIHAsngESIDijrd2Lxtp9ukAxG8Nhi4wN7AYFxPr
 n1/ot9e969xvXu/RfEn2Ck5ZYkKBAFbE8R6ZjLlgsn0PisK8ggatqir+G5DL2HFmHcst
 B1NVBUmOVRIqNi23oQ+gXDCn+mhYPTJ+D/AzNqKRoa5JRi6lvt4tm+rAFMZnRDoURMRQ
 dbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881187; x=1723485987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOghvEqM1lafZIm2kgjq99HQSQNfaJ4N/kBrqQYunpM=;
 b=ZLW9FMEZJGG7cWluAyxUoMaHAKuTzANeWMXxPl8NnMnOjyPRdEAy1wUfDfdPMbdnEx
 q/oxoJJP2OWSNxizrD+4FCHJsf/Bsu38iuTbxKgIrLMB6aSbGuoV0kVjTmhAHG6j7f4R
 kWWiJUPla4oxbMOiPtv4GIvE6JT6mwmcLtnOJQUcXlgdhx/ofEHv4GLkC1yhCqLMiknI
 h6RONbLvY3ctsRO7vK30L14D75D9V9ZMD19Hi0Ey+D9AHhs1K2hNBTG2tdJF4u2UZMnS
 GWmaifQZ16O+sQbMn1kWrmN9sN/jQCM40p4VmNKmL7Ds38gcgyXJl+kqTuRlvZVhTMXX
 8XOw==
X-Gm-Message-State: AOJu0Ywc1gqZwUcPnymDyUFmPGCaiQRBxXveA7AfnEGl3xq32+Kfj1Pr
 /J6262C279qdIXJIBTf4/5ab0Rjfr9d5E5bKyGtF4eomtoamnDYv0l7C2cT9Ye+FEk/op4X3N4i
 P
X-Google-Smtp-Source: AGHT+IEcZJN5/JTGpRIn9a0JIV2BVWTNl33gXeCR0BMpX6KLqgowCn9zLQrmL/vB82fXv0WyLIoYxg==
X-Received: by 2002:a17:906:794e:b0:a77:d85c:86fa with SMTP id
 a640c23a62f3a-a7dc4d8fe0emr961297766b.13.1722881187121; 
 Mon, 05 Aug 2024 11:06:27 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ecabb2sm472307466b.214.2024.08.05.11.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:06:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v6 00/15] Reconstruct loongson ipi driver
Date: Mon,  5 Aug 2024 20:06:07 +0200
Message-ID: <20240805180622.21001-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

(series fully reviewed, patches 1-15 will be posted
 tomorrow in pull request)

Since v5:
- Add missing .class_size / .instance_size to
  avoid heap-buffer-ovf

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

Bibo Mao (14):
  hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
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

Philippe Mathieu-Daudé (1):
  hw/intc/loongson_ipi: Remove unused headers

 MAINTAINERS                           |   6 +-
 include/hw/intc/loongarch_ipi.h       |  25 ++
 include/hw/intc/loongson_ipi.h        |  51 +---
 include/hw/intc/loongson_ipi_common.h |  74 ++++++
 include/hw/loongarch/virt.h           |   1 -
 hw/intc/loongarch_ipi.c               |  68 +++++
 hw/intc/loongson_ipi.c                | 347 +++-----------------------
 hw/intc/loongson_ipi_common.c         | 347 ++++++++++++++++++++++++++
 hw/loongarch/virt.c                   |   4 +-
 hw/intc/Kconfig                       |   8 +
 hw/intc/meson.build                   |   2 +
 hw/loongarch/Kconfig                  |   2 +-
 12 files changed, 574 insertions(+), 361 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c

-- 
2.45.2


