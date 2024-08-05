Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D32C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb493-0001hM-Pf; Mon, 05 Aug 2024 16:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UDOxZgUKCrcqXsfmdlldib.Zljnbjr-absbiklkdkr.lod@flex--tavip.bounces.google.com>)
 id 1sb491-0001W9-Rt
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:27 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UDOxZgUKCrcqXsfmdlldib.Zljnbjr-absbiklkdkr.lod@flex--tavip.bounces.google.com>)
 id 1sb48y-0001NW-I4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:27 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6688c44060fso240017457b3.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889040; x=1723493840; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XerA3mOsf4a50OWNf/gGXm4sNrAu9HVWQtZ4JJlFGM4=;
 b=yApR8IwlgevTiwn0D7LeL9BEWCKPynfz818jl0wpTLB9FhbpgOPXy85sL3+dBixmDU
 IjDmdNLA8b588dHlBopCDPA65MN5PnnmMYF56tMyWHlIMQHEnaE5wihVw8rU3jYp4S6x
 58oA4k2EZo3KBf8w+v55IKeOEt/KHwaSW8bzZH/gm1oo9nVk6fGuwv5JIuCN0yguDenm
 YRGLemX2xaiKkoTHDk/ttgLOu+KhcpFiInJhmnLsiRGd7RrcuRJI0Sds1qZeo5+FdfGY
 d8GBxcranlGl5zU6ZW8NhwK34wyJL3cBrg49h7b3lnHaMsDbgRKC8ndqALOLA9BfrPir
 C9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889040; x=1723493840;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XerA3mOsf4a50OWNf/gGXm4sNrAu9HVWQtZ4JJlFGM4=;
 b=pCeAzTf84MzmhH80d9jN2Tf7yjTtfEmpUZboMO4xzgFrVqofMYnhS+yRSVKh64YOHr
 jvcSGEpl5dnN59VEX7cOeIw6blnBy/9YWWl4l9vL980PWV4IQL7/fj3LOp89PdnC1Xgo
 4O+QnEn4Z7cf+B6CPAut3KQ7H5wLvcvUrp8bRhWa2TP6UeLLulJDldZ+TjJADItcIGpp
 qeRS+oykFbJyt5BAV1FOjl24lJsC2S/8E7kjAbsWhRGxBH19TIhXSYQiLElTDK6Vjz9O
 giNe3/Ey8FPeFOGpZISb7exIO1fNqycAvl4Fu7CzZxSrxf59mDKevUAf2GeqZNopwfuR
 U5zQ==
X-Gm-Message-State: AOJu0YxT7DYj6KNRGdxhrulaS9FXvvXOM+pn1DRgeDSCflYp1vgu3Rm9
 sPHdND/cmeAQ2OauFQHk2Fgbtkkzd1+xmxfmDlHaZKpibZMc7VJ4Nlt+Csg0pohm9P2lzXzr77H
 ljgTcG2dnnE3U/fsw+JSIs2nF2pEMQHP9myJTPEw0/AMjO28yPi/D+aKtJecKwsuBTvP2S6A3iz
 2txY+v2e8I+m8I5rrRFxlToM1BfQ==
X-Google-Smtp-Source: AGHT+IGqaTTPDERThIQ2lScByzIxC7MD4g+tlWTVvyLfl5S4gKHi5XMT98i4r1gqhOcJr9iKVMbiNcbz3A==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:3008:b0:68d:1d96:6a72
 with SMTP id
 00721157ae682-68d1d966f02mr1246467b3.1.1722889040430; Mon, 05 Aug 2024
 13:17:20 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:16:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-1-tavip@google.com>
Subject: [RFC PATCH 00/23] NXP i.MX RT595, ARM SVD and device model unit tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3UDOxZgUKCrcqXsfmdlldib.Zljnbjr-absbiklkdkr.lod@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch set adds support for NXP's RT500 MCU [1] and the RT595
EVK[2]. More RT500 device models will be submitted in future patch sets.

The goal of this first patch set is to provide a minimal set that
allows running the NXP MCU SDK hello world example[4] and to get feedback
on a couple of new / non-standard approaches.

First, this patch set introduces a (python) tool that generates C
header files from ARM SVD files[3]. This significantly reduces the
effort to write a new device model by automatically generating:
register definitions and layout (including bit fields), register names
for easier debugging and tracing, reset register values, etc.

It also introduces unit tests for device models. To allow accessing
registers from unit tests a system bus mock is created. The main
advantage of unit tests for device models over QTest is that device
models can be tested in isolation and do not require a full qemu
machine.

[1] https://www.nxp.com/docs/en/data-sheet/IMXRT500EC.pdf
[2] https://www.nxp.com/webapp/Download?colCode=MIMXRT595EVKHUG
[3] https://arm-software.github.io/CMSIS_5/SVD/html/index.html
[4] Building and running the NXP MCU SDK hello world example

    Clone the following git repos:

    https://github.com/nxp-mcuxpresso/cmsis.git,
    https://github.com/nxp-mcuxpresso/mcux-sdk.git
    https://github.com/nxp-mcuxpresso/mcux-sdk-examples.git

    in the following directories: CMSIS, core, examples.

    cd examples/evkmimxrt595/demo_apps/hello_world/armgcc

    ARMGCC_DIR=/usr CFLAGS=-I../../../../../CMSIS/CMSIS/Core/Include \
      sh build_flash_debug.sh

    qemu-system-arm --machine rt595-evk -kernel flash_debug/hello_world.elf \
      -global armv7m.init-nsvtor=0x08001000 -global armv7m.init-svtor=0x08001000 \
      -chardev stdio,id=flexcomm0

Octavian Purdila (19):
  fifo32: add peek function
  tests/unit: add fifo test
  hw/arm: add SVD file for NXP i.MX RT595
  hw: add register access utility functions
  hw/misc: add basic flexcomm device model
  test/unit: add register access macros and functions
  test/unit: add flexcomm unit test
  hw/char: add support for flexcomm usart
  test/unit: add flexcomm usart unit test
  hw/i2c: add support for flexcomm i2c
  test/unit: add i2c-tester
  test/unit: add unit tests for flexcomm i2c
  test/unit: add spi-tester
  hw/misc: add support for RT500's clock controller
  test/unit: add unit tests for RT500's clock controller
  hw/ssi: add support for flexspi
  hw/misc: add support for RT500 reset controller
  hw/arm: add basic support for the RT500 SoC
  hw/arm: add RT595-EVK board

Sebastian Ene (2):
  hw/ssi: add support for flexcomm spi
  test/unit: add unit tests for flexcomm spi

Stefan Stanacar (1):
  scripts: add script to generate C header files from SVD XML files

Valentin Ghita (1):
  tests/unit: add system bus mock

 configure                         |      2 +-
 hw/arm/Kconfig                    |     13 +
 hw/arm/meson.build                |      4 +
 hw/arm/rt500.c                    |    348 +
 hw/arm/rt595-evk.c                |     64 +
 hw/arm/svd/MIMXRT595S_cm33.xml    | 224052 +++++++++++++++++++++++++++
 hw/arm/svd/meson.build            |     42 +
 hw/char/flexcomm_usart.c          |    302 +
 hw/char/meson.build               |      1 +
 hw/char/trace-events              |      9 +
 hw/i2c/flexcomm_i2c.c             |    224 +
 hw/i2c/meson.build                |      1 +
 hw/i2c/trace-events               |     10 +
 hw/misc/Kconfig                   |     12 +
 hw/misc/flexcomm.c                |    304 +
 hw/misc/meson.build               |      5 +
 hw/misc/rt500_clkctl0.c           |    243 +
 hw/misc/rt500_clkctl1.c           |    224 +
 hw/misc/rt500_rstctl.c            |    219 +
 hw/misc/trace-events              |     18 +
 hw/ssi/Kconfig                    |      4 +
 hw/ssi/flexcomm_spi.c             |    443 +
 hw/ssi/flexspi.c                  |    216 +
 hw/ssi/meson.build                |      2 +
 hw/ssi/trace-events               |     12 +
 include/hw/arm/rt500.h            |     49 +
 include/hw/char/flexcomm_usart.h  |     20 +
 include/hw/i2c/flexcomm_i2c.h     |     27 +
 include/hw/misc/flexcomm.h        |     92 +
 include/hw/misc/rt500_clk_freqs.h |     18 +
 include/hw/misc/rt500_clkctl0.h   |     37 +
 include/hw/misc/rt500_clkctl1.h   |     38 +
 include/hw/misc/rt500_rstctl.h    |     38 +
 include/hw/regs.h                 |     89 +
 include/hw/ssi/flexcomm_spi.h     |     20 +
 include/hw/ssi/flexspi.h          |     34 +
 include/qemu/fifo32.h             |     29 +
 meson.build                       |      4 +
 python/setup.cfg                  |      1 +
 python/tests/minreqs.txt          |      3 +
 pythondeps.toml                   |      3 +
 scripts/svd-gen-header.py         |    342 +
 tests/unit/i2c_tester.c           |    111 +
 tests/unit/i2c_tester.h           |     34 +
 tests/unit/meson.build            |     56 +-
 tests/unit/reg-utils.h            |    103 +
 tests/unit/spi_tester.c           |     60 +
 tests/unit/spi_tester.h           |     32 +
 tests/unit/sysbus-mock.c          |    314 +
 tests/unit/sysbus-mock.h          |     82 +
 tests/unit/test-fifo.c            |     98 +
 tests/unit/test-flexcomm-i2c.c    |    209 +
 tests/unit/test-flexcomm-spi.c    |    204 +
 tests/unit/test-flexcomm-usart.c  |    321 +
 tests/unit/test-flexcomm.c        |    215 +
 tests/unit/test-rt500-clkctl.c    |    270 +
 56 files changed, 229725 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/rt500.c
 create mode 100644 hw/arm/rt595-evk.c
 create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
 create mode 100644 hw/arm/svd/meson.build
 create mode 100644 hw/char/flexcomm_usart.c
 create mode 100644 hw/i2c/flexcomm_i2c.c
 create mode 100644 hw/misc/flexcomm.c
 create mode 100644 hw/misc/rt500_clkctl0.c
 create mode 100644 hw/misc/rt500_clkctl1.c
 create mode 100644 hw/misc/rt500_rstctl.c
 create mode 100644 hw/ssi/flexcomm_spi.c
 create mode 100644 hw/ssi/flexspi.c
 create mode 100644 include/hw/arm/rt500.h
 create mode 100644 include/hw/char/flexcomm_usart.h
 create mode 100644 include/hw/i2c/flexcomm_i2c.h
 create mode 100644 include/hw/misc/flexcomm.h
 create mode 100644 include/hw/misc/rt500_clk_freqs.h
 create mode 100644 include/hw/misc/rt500_clkctl0.h
 create mode 100644 include/hw/misc/rt500_clkctl1.h
 create mode 100644 include/hw/misc/rt500_rstctl.h
 create mode 100644 include/hw/regs.h
 create mode 100644 include/hw/ssi/flexcomm_spi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100755 scripts/svd-gen-header.py
 create mode 100644 tests/unit/i2c_tester.c
 create mode 100644 tests/unit/i2c_tester.h
 create mode 100644 tests/unit/reg-utils.h
 create mode 100644 tests/unit/spi_tester.c
 create mode 100644 tests/unit/spi_tester.h
 create mode 100644 tests/unit/sysbus-mock.c
 create mode 100644 tests/unit/sysbus-mock.h
 create mode 100644 tests/unit/test-fifo.c
 create mode 100644 tests/unit/test-flexcomm-i2c.c
 create mode 100644 tests/unit/test-flexcomm-spi.c
 create mode 100644 tests/unit/test-flexcomm-usart.c
 create mode 100644 tests/unit/test-flexcomm.c
 create mode 100644 tests/unit/test-rt500-clkctl.c

-- 
2.46.0.rc2.264.g509ed76dc8-goog


