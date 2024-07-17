Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BB1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCUZ-0006pA-Fw; Wed, 17 Jul 2024 17:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUX-0006of-Rw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUV-0001rP-R1
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso947915e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252834; x=1721857634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+f/KVJUEDho/j4I/Tg6zeoQ3B9CtIz8Yu6yDHAPIQgo=;
 b=XmkpUwLiYx804ma73DIRqesiS1cxwXZZOz5bh/p2V2/Hky8XMN6ge7jKWW5YFMegWr
 jzZBckQrN+wzPGaPR9mDngMy1GCh/f42GIKkYbvVdregOm2jApD8AElRj2J3gL5bpl9u
 JFB/07/6B/pwdpRlmq9S3ixNKY3PRbCfe1kUPLDiGMPfDEaurB5d3+2YJyxf/fUU6XM/
 rnKEkqoBA8gAbOSIaEc1rBNnXDBoEBP7RZ39lRddFgUse+MaIkWV20lX9NDIyBJxGubr
 CCp08x+tdIAlu+3u+MDgiIlm0x115oRm9lLw1kgNoFQn22xbNLAw0WgSnWs+SwhT6tv1
 kITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252834; x=1721857634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+f/KVJUEDho/j4I/Tg6zeoQ3B9CtIz8Yu6yDHAPIQgo=;
 b=qPucgzTFXXS+SEBRchpfv08KInV0xu5BA8K1smxFUqYHysnOAKBIPHwhjG18chxr6e
 kRaUObt0JrtgyTWbcBst4NPGZYEM4q/4P4vEDeDbgd5VOeEi+doHp13M/r+dPaMEqAQN
 3QYjTiHNjlD/+y5z0OSsgIDA8PpmB0OkJT5N9TbnWDlsZBWsp87XVcxkgY8Iq6SzAyVT
 NulsVajM06Ya9dDwAU7kLKpFYB7MEneV0uzIbthcJYyRfDOJmH/bKFFnBC2OJpswtPF7
 elAspW8v1x0LllitbiZ1S+Lms85+U+P1GUDKYr2TI4+6Y1d2KNnTIrODIk7l948NDxEZ
 y0pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+8ntB+OmeWyAN7Uo7CtejDGDPGytbNfLYYc+GDxg9aSAegECbvIICTwb12Enm70ChN8L/IstL8lsrTBdeqr8DSayi1HE=
X-Gm-Message-State: AOJu0YzMFXcn7LhgumRLjAMzL5Ct7cnPAOKYOVOBRufZI1ZzIGSMPr5P
 OJQ78j61Dpqye3f7k1LbGkRRQo0LQzPb2ApzDTdBYnwZm3EqdOQoHH4BuSpASEo=
X-Google-Smtp-Source: AGHT+IFqNi9eVVQDq1fTByhlkvTsdFBkPPmuBDcAl52LqG/olOA9Voe4pYRaBMNirjJSymGv97Y8Zg==
X-Received: by 2002:a05:600c:1d18:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-427c2c99bfbmr21268055e9.2.1721252833429; 
 Wed, 17 Jul 2024 14:47:13 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c77e52c7sm11591905e9.24.2024.07.17.14.47.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 00/17] Reconstruct loongson ipi driver
Date: Wed, 17 Jul 2024 23:46:51 +0200
Message-ID: <20240717214708.78403-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi, this is a respin of Bibo v2 [*] splitting the patches in
atomic/trivial changes as I was taking notes reviewing it.

I suppose I shoudn't have done that way and asked Bibo to
do it, but I felt responsible for merging Jiaxun series and
soft freeze is urging.

Patch descriptions are expected to be self-explicit. I'm
getting sick so I'll defer to Bibo & Jiaxun to follow up.
I only build-tested so far, not run any guest code...

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/20240704033802.3838618-1-maobibo@loongson.cn/

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
  hw/loongarch/virt: Replace loongson IPI with loongarch IPI
  hw/intc/loongson_ipi: Restrict to MIPS

Philippe Mathieu-Daudé (1):
  hw/intc/loongson_ipi: Remove unused headers

 include/hw/intc/loongarch_ipi.h       |  25 ++
 include/hw/intc/loongson_ipi.h        |  50 +---
 include/hw/intc/loongson_ipi_common.h |  72 ++++++
 include/hw/loongarch/virt.h           |   1 -
 hw/intc/loongarch_ipi.c               |  71 ++++++
 hw/intc/loongson_ipi.c                | 338 ++-----------------------
 hw/intc/loongson_ipi_common.c         | 347 ++++++++++++++++++++++++++
 hw/loongarch/virt.c                   |   4 +-
 hw/intc/Kconfig                       |   8 +
 hw/intc/meson.build                   |   2 +
 hw/loongarch/Kconfig                  |   2 +-
 11 files changed, 563 insertions(+), 357 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c

-- 
2.41.0


