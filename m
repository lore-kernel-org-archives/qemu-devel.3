Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB23D26289
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGdS-0007m9-Dl; Tue, 20 Jan 2026 13:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdG-0007gu-JY
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:18 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdC-0005ud-Vx
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:12 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso701255e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934346; x=1769539146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bZN2rVENHtu99EBcPdBrwcNflvrUjjbRG/7TgKKA2yA=;
 b=EtARPt17Ig4BMwCCE0ISmEz6TF7yV7BLJ6ZAw0Mlw6en+C6cxUov9VtK7u4/oMebiA
 /jBSkOpLSpc8AhOw2+QP78lwE1rJlbL0IJToLPp8wctMrcPcXbNYqBCs00ZwUPCE42d1
 v3Ao5e2+DCkJMo/rwp188r4hh1w4fN+FKm3J+ILFC2B5OZ02yPBNNqP7kzFMHzkDNMqK
 qs3wEhoXsdqPmDUvzrglFF3kNgrgBz2Xtb+XBGd3w8WeZemCm9RlcBvwWcD5O47h3Z87
 rx5ZwiekmSecfvHh+76Gqqhw/yU3hiL7D3kpqRa1P/A09fb9W6d4h/i6U00dNqhxwSWc
 zXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934346; x=1769539146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZN2rVENHtu99EBcPdBrwcNflvrUjjbRG/7TgKKA2yA=;
 b=BYUh0+AWH6uiJjwgO2DWS5/gZbga+qQBvMpvMvgbg8BsnLp3xwwJuUcK/SQwGvtdcb
 0sLrnxJO0n90fNpVTWqi1+eJ29wDtwD5B2zU38pLG3o+jDGspzBZkimMa0bSMvgJ+OQp
 tmqlhfhiFJ5VMaJdwODRvclW5Z9yAzW54hEVBH6RoZ36cxDI/BXNZVAeotxrmFWvZ9X5
 cIfaVQZ/oSibDS4Uag1PPpiZFzEqnyjNwp6nxXmksHYl8oCtKrlRcQXd0vD5jlN0hOWX
 WIkB4uPozdieF9mEPTZVDpZDUa5JytQI7PSLndtS7BLvvZHILUrDI87KtCrn7nSdFYSi
 vjmA==
X-Gm-Message-State: AOJu0YwSbFj62cUNw28mR8ArJCZzyMqYBlT7obb/m/qc9KM1rNUvp27V
 S+XGVocGjhORoS8vGykDPVhEQDNvOkl3TTIrzK7ixQcHzXtQe7iSyWxilg4GcHt9Yq9cFRE6MSy
 QU5XBW3A=
X-Gm-Gg: AY/fxX7pRB63XmS5mUol/ehkwCm7e0EsU32foNqgMmwHJ8llBxf7PyDN5C993royiQx
 t+WNagsopT/ZanhUm2F1NECOaNoKN2C02brz7kyElemYPY78I0LiIxWFQ9ufmwjP3FBo1JbVnQm
 YKkcvH2Cg8SKGvxk4AFo7ULy9/y0OmSOLgL+vFFOkaH0rBhd9jdClm9ilFtjjD5q/IqUubZSxrT
 Ss1cLXsdQ//3Qd2zvqyqKzBMkRXtFgnQoKZxxkuhLIHk8w9ii9Ai8PkCKBHvNSnY+TWA2GgMTdF
 vIPEgxO9IBmZX/SJBmft6G9l17GfWtmVNOKTt9RUtvUAoVqM8YnR5BSZ7pcpjkeaQoYPbtzHNnE
 TP2bAw8nm1AZam2yIsKVyMErsEwzqYgSkY1Bnwf73c2VcUAjFP7vtDBkgaB2Rfgh66BX+IZmwTE
 Zo0SSro7J4PRIUBn+SE/H9oRTjAj0Zl4hr//H49IFx0TIdOuatpjAopMzaLQj6sbl4xoU8oro=
X-Received: by 2002:a05:600c:60f:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-47f4289abb5mr160864665e9.1.1768934345831; 
 Tue, 20 Jan 2026 10:39:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm317820645e9.9.2026.01.20.10.39.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] Misc HW patches for 2026-01-20
Date: Tue, 20 Jan 2026 19:38:33 +0100
Message-ID: <20260120183902.73845-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

The following changes since commit 38879a667fbb4ef54c70de71494882615f600a64:

  Merge tag 'pull-tcg-20260119' of https://gitlab.com/rth7680/qemu into staging (2026-01-19 09:04:31 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260120

for you to fetch changes up to 84f82697f8294377224aad9f7cc499116ae0ec49:

  meson: Do not try to build module for empty per-target hw/ directory (2026-01-20 19:34:44 +0100)

----------------------------------------------------------------
Misc HW patches

- Generalized IOMMU test framework
- Fix Freescale SDHCI endianness issues
- Support for zboot images compressed with Zstd
- Pcap support to analyze UEFI firmware traffic
----------------------------------------------------------------

Bernhard Beschow (13):
  hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by
    default
  hw/arm/fsl-imx6: Remove now redundant setting of "sd-spec-version"
    property
  hw/arm/fsl-imx6: Fix naming of SDHCI related constants and attributes
  hw/arm/fsl-imx25: Apply missing reset quirk
  Revert "hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*"
  hw/sd/sdhci: Consolidate eSDHC constants
  hw/sd/sdhci: Rename usdhc_ functions
  hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
  hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
  hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
  hw/sd/sdhci: Remove endianness property
  hw/sd/sdhci: Remove vendor property
  hw/sd/trace-events: Remove redundant "SWITCH " command name

Daan De Meyer (4):
  hw/loader: Rename LOAD_IMAGE_MAX _GUNZIP_BYTES to _DECOMPRESSED_BYTES
  hw/loader: Rename UBOOT_MAX _GUNZIP_BYTES to _DECOMPRESSED_BYTES
  hw/loader: Use g_autofree in unpack_efi_zboot_image()
  hw/loader: Add support for zboot images compressed with zstd

Gerd Hoffmann (2):
  hw: move pcap structs to header file
  hw/uefi: add pcap support

Paolo Bonzini (1):
  hw/virtio-nsm: include qemu/osdep.h

Philippe Mathieu-Daudé (1):
  meson: Do not try to build module for empty per-target hw/ directory

Tao Tang (8):
  hw/arm/smmuv3: Extract common definitions to smmuv3-common.h
  hw/arm/smmuv3-common: Define STE/CD fields via registerfields
  hw/misc: Introduce iommu-testdev for bare-metal IOMMU testing
  hw/arm/smmuv3-common: Add NSCFG bit definition for CD
  hw/arm/smmuv3-common: Add STE/CD set helpers for repeated field setup
  tests/qtest: Add libqos iommu-testdev helpers
  tests/qtest/libqos: Add SMMUv3 helper library
  tests/qtest: Add SMMUv3 bare-metal test using iommu-testdev

 MAINTAINERS                            |  14 +
 docs/specs/index.rst                   |   1 +
 docs/specs/iommu-testdev.rst           | 140 ++++++
 meson.build                            |   7 +-
 hw/arm/smmuv3-internal.h               | 255 +---------
 hw/sd/sdhci-internal.h                 |   3 -
 include/hw/arm/fsl-imx6.h              |   4 +-
 include/hw/arm/smmuv3-common.h         | 423 +++++++++++++++++
 include/hw/core/loader.h               |   4 +-
 include/hw/misc/iommu-testdev.h        |  87 ++++
 include/hw/sd/sdhci.h                  |   8 +-
 include/hw/uefi/var-service.h          |  10 +
 include/qemu/pcap.h                    |  30 ++
 tests/qtest/libqos/qos-iommu-testdev.h |  43 ++
 tests/qtest/libqos/qos-smmuv3.h        | 242 ++++++++++
 hw/arm/boot.c                          |   4 +-
 hw/arm/fsl-imx25.c                     |   5 +-
 hw/arm/fsl-imx6.c                      |  18 +-
 hw/core/loader-fit.c                   |   2 +-
 hw/core/loader.c                       |  44 +-
 hw/misc/iommu-testdev.c                | 318 +++++++++++++
 hw/nvram/fw_cfg.c                      |   3 +-
 hw/ppc/e500.c                          |  10 +-
 hw/sd/sdhci.c                          | 181 ++++---
 hw/uefi/var-service-core.c             |   7 +
 hw/uefi/var-service-pcap.c             |  95 ++++
 hw/uefi/var-service-sysbus.c           |   1 +
 hw/usb/pcap.c                          |  24 +-
 hw/virtio/cbor-helpers.c               |   1 +
 tests/qtest/iommu-smmuv3-test.c        | 132 ++++++
 tests/qtest/libqos/qos-iommu-testdev.c |  82 ++++
 tests/qtest/libqos/qos-smmuv3.c        | 629 +++++++++++++++++++++++++
 hw/misc/Kconfig                        |   5 +
 hw/misc/meson.build                    |   1 +
 hw/misc/trace-events                   |  10 +
 hw/sd/trace-events                     |   2 +-
 hw/uefi/meson.build                    |   1 +
 tests/qtest/libqos/meson.build         |   4 +
 tests/qtest/meson.build                |   3 +
 39 files changed, 2445 insertions(+), 408 deletions(-)
 create mode 100644 docs/specs/iommu-testdev.rst
 create mode 100644 include/hw/arm/smmuv3-common.h
 create mode 100644 include/hw/misc/iommu-testdev.h
 create mode 100644 include/qemu/pcap.h
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.h
 create mode 100644 tests/qtest/libqos/qos-smmuv3.h
 create mode 100644 hw/misc/iommu-testdev.c
 create mode 100644 hw/uefi/var-service-pcap.c
 create mode 100644 tests/qtest/iommu-smmuv3-test.c
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.c

-- 
2.52.0


