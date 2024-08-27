Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B75C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipxh-00038T-Ul; Tue, 27 Aug 2024 02:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CnbNZgUKCmkaHcPWNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--tavip.bounces.google.com>)
 id 1sipxb-0002tt-Q7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:47 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CnbNZgUKCmkaHcPWNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--tavip.bounces.google.com>)
 id 1sipxT-00063V-4F
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:47 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-204e310e050so6646335ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741130; x=1725345930; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AqiuqeLPs//G+UZrMjCPw9P3JOIbNGDF4RHaSINlp+E=;
 b=B6LqBhU3xI+mZKneUW8H1dADzmICT1xZGMBhrGXxSWbmx5uJRFPQwJcA3vlqv4UcAF
 nJ+8lnmBTE5ea8sx6buLA3xwcmK3w1BOjnEgixtkKvtmXaqY2QV7SW58DqmgrnVZ2k7E
 SrBCvplsfvmqdtZFao7EjnWprvg7WFIAVECvuIAYCatQufcFlmWQoXZQGxnAFb673Isu
 PxgM0e2GlrWiKY0PwjBdenRWglu+wFg3UV2/8+g82/55TaqP4p8aCpwMer4HErRywBrB
 20BxkwxzBrFBMRV1ZZpK+vZnUmETL0nVSXcl5vdW2Xp6tFIB34opfwORnG/rYfHsi7Ht
 L30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741130; x=1725345930;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AqiuqeLPs//G+UZrMjCPw9P3JOIbNGDF4RHaSINlp+E=;
 b=EoLrUd9j73zsJBy5+4t+w895u7ZA7w7dw/UYRNzogEYP41uqx7WKwlPQfjNu3GBdwi
 NkpGUnTwY/LJE2AnuG87073yabuXcG0g2/aRIY6Jt2OBEXqFWnz5ETpkPnVG10lfDAnI
 65wg6RyDf6DXnR082fCgxNLOQL9dF2pgc1RH/JJZlOiDA2JEKxYBdCkepXJmU3s7Kx0+
 Mq6FXFHWw9gZDcLoZ7yJt3ORwCIcqsLJOM+KxrXLdCTsm72Jj1Hc/D89eccEKCAAZq/e
 UZ4Ozu/97ryU8dLbBju5FqiAWYo9CLt1hM/xRaPMl8iSYn8MH1s9Ppu75D+yO+B+ka4B
 l+YQ==
X-Gm-Message-State: AOJu0Yyo7QNqe2TdwrHqkfITCCBh4rxZtFmJbCjDoKEI2cMdojw0RYk6
 LUNv9JGuRhOxLI6ddKwIjrnmLvnOch7oUenLaP3TDbT94Y2hEP5+8ViOmTrCyxZnTpCETvtBEYI
 zDZuJk+EEUWsUzbyvJnfP5XUHDHHpqDgvxKWdA0Q2M6nQtzzJMBC2sx16P8fR6+CNLE8phzbrf6
 YMbbM1uKXp4NLx023WxtCixLqD6Q==
X-Google-Smtp-Source: AGHT+IFdk6HNDxWIuREheZZ9OP7GdcSasgIE+sSFJg+Z4CaV7A5PrjEFeshmAHDSIP3iDnUr8x5v4rNqEw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d48d:b0:202:36fc:5d4b
 with SMTP id
 d9443c01a7336-204df5210ebmr1014305ad.12.1724741130495; Mon, 26 Aug 2024
 23:45:30 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-1-tavip@google.com>
Subject: [RFC PATCH v3 00/24] NXP i.MX RT595
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3CnbNZgUKCmkaHcPWNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
allows running the NXP MCU SDK hello world example[4].

The patch set introduces a (python) tool that generates C header files
from ARM SVD files[3]. This significantly reduces the effort to write
a new device model by automatically generating: register definitions
and layout (including bit fields), register names for easier debugging
and tracing, reset register values, register write masks, etc.

The generated files are commited and not generated at compile
time. Build targets are created so that they can be easily regenerated
if needed.

Changes since v2:
 * convert tests from unit to qtest
 * move i2c and spi testers from unit tests to hw/misc devices
 * switch to using RegisterAccessInfo to generate register information
   like register names, reset values, or read-only mask
 * use register_write instead of adding a new reg32_write API
 * remove reg32_aligned_access completly and rely on memops access
   constraints and size of access for alignment checks
 * add qtest APIs for checking memory access faulires
 * add qtest APIs for accessing the device clock frequency
 * fix bugs detected by address sanitizers

Changes since v1:
 * setup scripts/git.orderfile
 * svd_gen_header: add support for multi line comments
 * svd_gen_header: use qemu register fields instead of bitfields
 * svd_gen_header: generate register write mask array
 * add mcux-soc-svd as a subproject instead of commiting the rt595 SVD
   file directly
 * svd generated headers: don't generate them at compile time, instead
   commit the generated headers and create compile targets so that it is
   easy to regenerate them
 * remove pysvd dependency; developers who need to (re)generate svd
   headers need to have it installed on the host machine
 * use DEFINE_TYPES where possible
 * use g_strdup_printf where possible
 * reduce iterator variables scopes
 * hard code rt500 to use the cortex-m33
 * use static for local arrays initializers
 * remove rt500 properties as they are not yet used
 * drop private/public comments
 * remove unused headers
 * free rt500 mem regions in rt500_unrealize() instead of
   rt500_finalize
 * use memops access constraints where possible instead of
   reg32_aligned_access
 * flexspi: use 64bit properties for mmap_size property
 * rstctl: use a generic abstract type and remove the  "num" property
 * flexspi: don't call get_system_memory() directly and remove
   mmap_base property

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

Octavian Purdila (21):
  fifo32: add peek function
  tests/unit: add fifo test
  Add mcux-soc-svd subproject
  hw/misc: add basic flexcomm device model
  hw/char: add support for flexcomm usart
  hw/i2c: add support for flexcomm i2c
  hw/misc: add support for RT500's clock controller
  hw/ssi: add support for flexspi
  hw/misc: add support for RT500's reset controller
  hw/arm: add basic support for the RT500 SoC
  hw/arm: add RT595-EVK board
  tests/qtest: add register access macros and functions
  system/qtest: add APIS to check for memory access failures
  tests/qtest: add flexcomm tests
  tests/qtest: add flexcomm usart tests
  hw/misc: add i2c-tester
  tests/qtest: add tests for flexcomm i2c
  hw/ssi: allow NULL realize callbacks for peripherals
  hw/misc: add spi-tester
  systems/qtest: add device clock APIs
  test/unit: add unit tests for RT500's clock controller

Sebastian Ene (2):
  hw/ssi: add support for flexcomm spi
  tests/qtest: add tests for flexcomm spi

Stefan Stanacar (1):
  scripts: add script to generate C header files from SVD XML files

 meson.build                                   |    4 +
 include/hw/arm/rt500.h                        |   44 +
 include/hw/arm/svd/flexcomm.h                 |  114 +
 include/hw/arm/svd/flexcomm_i2c.h             | 1192 ++++++
 include/hw/arm/svd/flexcomm_spi.h             | 1038 +++++
 include/hw/arm/svd/flexcomm_usart.h           | 1023 +++++
 include/hw/arm/svd/flexspi.h                  | 2658 +++++++++++++
 include/hw/arm/svd/rt500.h                    |   63 +
 include/hw/arm/svd/rt500_clkctl0.h            | 2485 ++++++++++++
 include/hw/arm/svd/rt500_clkctl1.h            | 3398 +++++++++++++++++
 include/hw/arm/svd/rt500_rstctl0.h            |  860 +++++
 include/hw/arm/svd/rt500_rstctl1.h            | 1373 +++++++
 include/hw/char/flexcomm_usart.h              |   20 +
 include/hw/i2c/flexcomm_i2c.h                 |   27 +
 include/hw/misc/flexcomm.h                    |   85 +
 include/hw/misc/i2c_tester.h                  |   30 +
 include/hw/misc/rt500_clk_freqs.h             |   18 +
 include/hw/misc/rt500_clkctl0.h               |   37 +
 include/hw/misc/rt500_clkctl1.h               |   36 +
 include/hw/misc/rt500_rstctl.h                |   32 +
 include/hw/misc/spi_tester.h                  |   32 +
 include/hw/qdev-clock.h                       |   10 +
 include/hw/ssi/flexcomm_spi.h                 |   20 +
 include/hw/ssi/flexspi.h                      |   32 +
 include/qemu/fifo32.h                         |   28 +
 tests/qtest/libqtest-single.h                 |  116 +
 tests/qtest/libqtest.h                        |   98 +
 tests/qtest/reg-utils.h                       |   70 +
 hw/arm/rt500.c                                |  335 ++
 hw/arm/rt595-evk.c                            |   64 +
 hw/char/flexcomm_usart.c                      |  306 ++
 hw/core/qdev-clock.c                          |    2 +-
 hw/i2c/flexcomm_i2c.c                         |  222 ++
 hw/misc/flexcomm.c                            |  323 ++
 hw/misc/i2c_tester.c                          |   94 +
 hw/misc/rt500_clkctl0.c                       |  239 ++
 hw/misc/rt500_clkctl1.c                       |  223 ++
 hw/misc/rt500_rstctl.c                        |  235 ++
 hw/misc/spi_tester.c                          |   52 +
 hw/ssi/flexcomm_spi.c                         |  442 +++
 hw/ssi/flexspi.c                              |  169 +
 hw/ssi/ssi.c                                  |    4 +-
 system/qtest.c                                |   95 +-
 tests/qtest/flexcomm-i2c-test.c               |  169 +
 tests/qtest/flexcomm-spi-test.c               |  144 +
 tests/qtest/flexcomm-test.c                   |   86 +
 tests/qtest/flexcomm-usart-test.c             |  314 ++
 tests/qtest/libqtest.c                        |  102 +-
 tests/qtest/rt500-clkctl-test.c               |  195 +
 tests/unit/test-fifo.c                        |   97 +
 hw/arm/Kconfig                                |   12 +
 hw/arm/meson.build                            |    4 +
 hw/arm/svd/meson.build                        |   35 +
 hw/char/meson.build                           |    1 +
 hw/char/trace-events                          |    9 +
 hw/i2c/meson.build                            |    1 +
 hw/i2c/trace-events                           |   10 +
 hw/misc/Kconfig                               |   21 +
 hw/misc/meson.build                           |    7 +
 hw/misc/trace-events                          |   18 +
 hw/ssi/Kconfig                                |    4 +
 hw/ssi/meson.build                            |    2 +
 hw/ssi/trace-events                           |   12 +
 meson_options.txt                             |    3 +
 scripts/meson-buildoptions.sh                 |    4 +
 scripts/svd-gen-header.py                     |  330 ++
 subprojects/.gitignore                        |    1 +
 subprojects/mcux-soc-svd.wrap                 |    5 +
 .../packagefiles/mcux-soc-svd/meson.build     |    5 +
 tests/qtest/meson.build                       |    3 +
 tests/unit/meson.build                        |    1 +
 71 files changed, 19321 insertions(+), 22 deletions(-)
 create mode 100644 include/hw/arm/rt500.h
 create mode 100644 include/hw/arm/svd/flexcomm.h
 create mode 100644 include/hw/arm/svd/flexcomm_i2c.h
 create mode 100644 include/hw/arm/svd/flexcomm_spi.h
 create mode 100644 include/hw/arm/svd/flexcomm_usart.h
 create mode 100644 include/hw/arm/svd/flexspi.h
 create mode 100644 include/hw/arm/svd/rt500.h
 create mode 100644 include/hw/arm/svd/rt500_clkctl0.h
 create mode 100644 include/hw/arm/svd/rt500_clkctl1.h
 create mode 100644 include/hw/arm/svd/rt500_rstctl0.h
 create mode 100644 include/hw/arm/svd/rt500_rstctl1.h
 create mode 100644 include/hw/char/flexcomm_usart.h
 create mode 100644 include/hw/i2c/flexcomm_i2c.h
 create mode 100644 include/hw/misc/flexcomm.h
 create mode 100644 include/hw/misc/i2c_tester.h
 create mode 100644 include/hw/misc/rt500_clk_freqs.h
 create mode 100644 include/hw/misc/rt500_clkctl0.h
 create mode 100644 include/hw/misc/rt500_clkctl1.h
 create mode 100644 include/hw/misc/rt500_rstctl.h
 create mode 100644 include/hw/misc/spi_tester.h
 create mode 100644 include/hw/ssi/flexcomm_spi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100644 tests/qtest/reg-utils.h
 create mode 100644 hw/arm/rt500.c
 create mode 100644 hw/arm/rt595-evk.c
 create mode 100644 hw/char/flexcomm_usart.c
 create mode 100644 hw/i2c/flexcomm_i2c.c
 create mode 100644 hw/misc/flexcomm.c
 create mode 100644 hw/misc/i2c_tester.c
 create mode 100644 hw/misc/rt500_clkctl0.c
 create mode 100644 hw/misc/rt500_clkctl1.c
 create mode 100644 hw/misc/rt500_rstctl.c
 create mode 100644 hw/misc/spi_tester.c
 create mode 100644 hw/ssi/flexcomm_spi.c
 create mode 100644 hw/ssi/flexspi.c
 create mode 100644 tests/qtest/flexcomm-i2c-test.c
 create mode 100644 tests/qtest/flexcomm-spi-test.c
 create mode 100644 tests/qtest/flexcomm-test.c
 create mode 100644 tests/qtest/flexcomm-usart-test.c
 create mode 100644 tests/qtest/rt500-clkctl-test.c
 create mode 100644 tests/unit/test-fifo.c
 create mode 100644 hw/arm/svd/meson.build
 create mode 100755 scripts/svd-gen-header.py
 create mode 100644 subprojects/mcux-soc-svd.wrap
 create mode 100644 subprojects/packagefiles/mcux-soc-svd/meson.build

-- 
2.46.0.295.g3b9ea8a38a-goog


