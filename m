Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC5DC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeI-0008S8-GU; Mon, 13 Jul 2026 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe8-0008Ph-6R
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:40 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe5-00015l-Sz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:39 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b4e7be03so175505e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956755; x=1784561555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mGwNmsnFNYS4uKMqaZS+vAeRGRayVktiMo+FBV6fPiE=;
 b=BBqRI6N81rOECkfNzqesS8UPgC9/owbhZpJlxcoEipZ/aVnRt/dgCY4bdEBsFqXq7O
 d8u+Q9fUmEbyrz4sRARon/iMzhlAext2lZta6rFjHAlND2513ELlojX8xv2tsN4g2BxC
 190cuCEdKaAbLUppydEgzEbrWblOsOXdkLphrTTP7c9G5qNCTrEPxcGnDlhopeckxNN0
 PyxvRxFcyvDbm+CDW+JP0NNIo09/FFy1WOaPok0vlohd8QE73chAjJGfYMfrkaPOysvR
 Gh1eXoX2jKy4BOi82nZaTtKEU8jCV0NVw29EDKyXeCfnNhOxE8TYCkvXr+MaZl7MBOzf
 DGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956755; x=1784561555;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mGwNmsnFNYS4uKMqaZS+vAeRGRayVktiMo+FBV6fPiE=;
 b=dOIu5xZiA/ZJa4gmuFNqHBnIICd7Zen1Sc8T541EVjxCOWMa/QHIyOEPQFgfF6W95O
 K+1Hv8F4FZNI94DtDtXueVim8c9CzzpvFAnk2A64l+s25xXa/coLVyoFiYentCq9mJBx
 ywpR96qX83CiCwRRVr8fBzvJECOeN6a0LG7wUgyNXOB+RGCBcMcL99KhtZAby8rcnDjb
 9ChwKtooqsU7Vccl3DqZXeEteUskyu8Zo146Z7RYegEbprsH5VUvJ2KyTCsy+W2GGeA/
 anLqE8LZX02PfrHp339kVDCfCs7ehMEJmMnxTGzgWezHdbuo29DX2WAz8eq/iOFtlKZS
 s6Fw==
X-Gm-Message-State: AOJu0YziuwC0UaXEP5jgAYmrm9JN9LtA55b2BWuzP534xzxYiCZ/cYuQ
 bFiyp28FRnGBisRO79NHVmDLRA9yH/MvUYA/gpqfL5hoRO7Z9R/V4uUIQY98a6GNCB7miv+Cy1m
 yQYP2FU3/wNWU
X-Gm-Gg: AfdE7clH6bA+MV0muJP5qGYwLtqc2asqoxqRFKgS5Y1dsf6i80ZI7zkdbBLZAnDvGtE
 pK8AthTkNXW2JhO2DXG1GpStisnf1H/d6V2/d7M4cnfBkrgbf2LJVY0Gc9qlwsaJK2QsgSfxJN2
 M/5kecIRKaC7OF9Kxv0uFCtCSHR7txwkUlRqMFQlnNm7mAl+2+zQ4Tr0L3QBf82dPXRtRXimPrr
 UyIxnGtMIxXH6pc8Njfh0Y6NsA2ukH4r/4xxMkoHRMXhQxSavPDnVbiK3yfBlT9M48s8ZKF/hLV
 3vuzQan+c/OaufV3b6Tof9krvRTFA+LpMlzG+Dcq95YrJ9tjE8WXBfyh4E7XBnM4pjp6+Cz1j2y
 F5RMxDvE3OGvT3S/0g7w5yx3hmRkdUixvqkz8uDk7CU5Nikt05m8T1tXPysmOxgx1Yx2h/lfspm
 5+YhiPmsJUCvBkrzBI9fOirZXbT51LWAlLGGePbDbtQctfR/ajrMQRullBE5t2bvQPGw1XuwIeQ
 ejDPjm+yEW+qCWj5u5TXQ==
X-Received: by 2002:a05:600c:16ca:b0:493:c1bc:79bd with SMTP id
 5b1f17b1804b1-493f88180f9mr61431205e9.20.1783956755213; 
 Mon, 13 Jul 2026 08:32:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Mon, 13 Jul 2026 16:32:07 +0100
Message-ID: <20260713153233.3391818-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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

Hi; here's an arm pullreq. These are all bugfixes and minor docs updates.

thanks
-- PMM

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260713

for you to fetch changes up to 3c2749443429a2a6b60bfa5c32964628631dfa23:

  hw/misc/stm32_rcc: Correct offset-to-irq calculation (2026-07-13 12:34:17 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/misc/zynq_slcr.c: drop duplicate reset value for DDRIOB_DCI_CTRL
 * hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ allocation
 * hw/arm/smmuv3: Sanitize fields provided by guest
 * hw/i2c: pmbus: clear output buffer on write
 * docs/system/arm: Add some missing FEAT_FOO we already implement
 * arm/virt: fix smmuv3_devices leak
 * target/arm: Be more defensive for invalid tlbi_aa64_get_range
 * hw/dma: don't allow weird transfer lengths for bcm2835
 * hw/net/vmxnet3: Correct bounds check on tx queue index
 * hw/usb/dev-wacom: Don't write off end of buffer
 * hw/display/sm501: Don't let guest write off end of buffer
 * hw/misc/allwinner-r40-ccu.c: Correct handling of out of range accesses
 * hw/misc/stm32_rcc: Correct offset-to-irq calculation

----------------------------------------------------------------
Alex Bennée (9):
      docs/system: declare support for FEAT_EVT2
      docs/system: add big and little endian features names
      docs/system: document FEAT_Secure
      docs/system: document FEAT_MTE4
      docs/system: document FEAT_IVIPT
      docs/system: fix sorting of FEAT_S2[PIE|FWB]
      docs/system: add FEAT_S2TGran[4|16|64]K features
      docs/system: add FEAT_HAF
      hw/dma: don't allow weird transfer lengths for bcm2835

Corvin Köhne (1):
      hw/misc/zynq_slcr.c: drop duplicate reset value for DDRIOB_DCI_CTRL

Eric Auger (5):
      hw/arm/smmuv3: Fix off-by-one bug in alignment strtab mask
      hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
      hw/arm/smmuv3: Fix possible overflow in strtab_base computation
      hw/arm/smmuv3: Check L1STD.SPAN
      hw/arm/smmuv3: Enforce alignment of L2Ptr according to the span

Marc-André Lureau (1):
      arm/virt: fix smmuv3_devices leak

Peter Maydell (7):
      hw/net/vmxnet3: Correct bounds check on tx queue index
      hw/usb/dev-wacom: Don't write off end of buffer
      hw/display/sm501: Catch bad coordinates for RTL operations
      hw/display/sm501: Avoid overflow problems in bounds check calculations
      hw/display/sm501: Don't allow guest to set ram size larger than it is
      hw/misc/allwinner-r40-ccu.c: Correct handling of out of range accesses
      hw/misc/stm32_rcc: Correct offset-to-irq calculation

Richard Henderson (1):
      target/arm: Be more defensive for invalid tlbi_aa64_get_range

Shameer Kolothum (1):
      hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ allocation

titusr (1):
      hw/i2c: pmbus: clear output buffer on write

 docs/system/arm/emulation.rst | 14 +++++++++-
 hw/arm/smmuv3-internal.h      |  3 ++
 hw/arm/smmuv3.c               | 32 ++++++++++++++++++----
 hw/arm/tegra241-cmdqv.c       |  7 ++---
 hw/arm/virt.c                 |  1 +
 hw/display/sm501.c            | 64 +++++++++++++++++++++++++++++++++++++------
 hw/dma/bcm2835_dma.c          | 17 ++++++++++++
 hw/i2c/pmbus_device.c         | 10 +++++++
 hw/misc/allwinner-r40-ccu.c   |  6 ++--
 hw/misc/stm32_rcc.c           | 31 ++++++++++++++++++---
 hw/misc/zynq_slcr.c           |  1 -
 hw/net/vmxnet3.c              |  2 +-
 hw/usb/dev-wacom.c            |  4 +++
 include/hw/misc/stm32_rcc.h   |  6 +++-
 target/arm/cpu-max.c          |  2 +-
 target/arm/tcg/tlb-insns.c    |  2 +-
 tests/qtest/adm1266-test.c    | 10 ++++---
 17 files changed, 176 insertions(+), 36 deletions(-)

