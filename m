Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E761C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGdS-0005sd-L1; Sat, 17 Aug 2024 06:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wHrAZgUKCvMoVqdkbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--tavip.bounces.google.com>)
 id 1sfGdQ-0005qU-LW
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:12 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wHrAZgUKCvMoVqdkbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--tavip.bounces.google.com>)
 id 1sfGdO-00036Y-Ck
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:12 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1fc5e1ab396so27443065ad.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890368; x=1724495168; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gJ7FkzR4rnRxOTRm9HDwdpqUjndpT48FwsqUgOZ8ewk=;
 b=cbSb0DBg8j1A8h7kXeeK4MPSG3tgdeVUuHFkFxlBsmpNkm0U+UjVl4U7FTicW/xqFc
 3aeF81ttiq/TCvUi6B9lBsEEVsLAVGFMqG4vPonsT6PUNfTdziLAuUnbQaMVNQUolpz3
 1mu6JT6QO9v+au8tBwrx+hbTzrhb0dXmX0tP9bSdo3t6WnF4quXskwsH+93amT1W5BqX
 kfS309fBS8K4jt18ha8oorA0wFk/bv0Fj4p9iyrkga+Pu3pwJC91bnNmqe3NY9MEsue+
 PVPMOcTExBOdN0YoiwvxM3t2M0W2FCUnUNrGTxg6+USVJpyS9mFDlzmWWGw52XJdfO7L
 i0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890368; x=1724495168;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJ7FkzR4rnRxOTRm9HDwdpqUjndpT48FwsqUgOZ8ewk=;
 b=tXkCkAOSPdCR+bnaM1Q/GMRcEN040WFmpLKO46IgNqgCt3iCSMU/RFvy7zLRIDHCZ/
 OEEEoo2P4mld5N3cOQpAApcdE5YQamrxX+YDTUVt7Fi9WaIY7BNdsedkHyjR+wlHNYpy
 M7wFJvTVtm8fGBw6oru+5X5OPiDy1tclPZZbe0ftcy+yjhPFXhMxU1S/SMlWWfLSQhiN
 oYDOr4cTm211MwmyNsYyN1p5PPE+TlrabcOvPR7H99nKZq20AjRxpfQivh57C5rnLPDv
 SFrIT3G0Scs9P+pU9gDJ4vMYz/7WyMELNiw6nmGmO8QjgsR3IRfTYpBXDqODZWk3V2DF
 Rzow==
X-Gm-Message-State: AOJu0YyNHQKPhh3WX+vonl4VgQwjCiN6VD030vJQTxk4FknNviJa74RR
 O0kx5g2NIC4mojFdUqsewgNTh39FHe3r+6OdlB38/9dz+RQ3tq9PFCYvlyDTqZfuXc+FjkgxJVg
 mRWaOKr6m6e87A7XSqSDO0g+WqMVVjhf9ddAWUtBlWEjd83KQG83hbjF+a+axKpVEJwL3txD7+N
 VSm3szE4qLi7BXV1o+FyjuZyYy5Q==
X-Google-Smtp-Source: AGHT+IFNvVi8mzoJTYk9zBbP74jhKAwTOoL4/lzvYKPqFPAAsDaS//wBccQ1rdFL3HvBPY5+z6li9apKaw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:c40d:b0:1fb:8620:e113
 with SMTP id
 d9443c01a7336-20203e35d20mr5870355ad.3.1723890368005; Sat, 17 Aug 2024
 03:26:08 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-1-tavip@google.com>
Subject: [RFC PATCH v2 00/23] NXP i.MX RT595,
 ARM SVD and device model unit tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3wHrAZgUKCvMoVqdkbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
allows running the NXP MCU SDK hello world example[4].

The patch set introduces a (python) tool that generates C header files
from ARM SVD files[3]. This significantly reduces the effort to write
a new device model by automatically generating: register definitions
and layout (including bit fields), register names for easier debugging
and tracing, reset register values, register write masks, etc.

The generated files are commited and not generated at compile
time. Build targets are created so that they can be easily regenerated
if needed.

It also introduces unit tests for device models. To allow accessing
registers from unit tests a system bus mock is created.

This can potentially introduce maintainance issues, due to mocks or
unit tests getting outdated when code is refactored. However, I think
this is not an issue in this case because the APIs we mocked (system
bus MMIO access) or directly used (irq APIs, chardev APIs, clock tree
APIs) to interact with device models are stable at this
point. Anecdotally, our experience seems to confirm this: we only run
into one (trivially fixed) breaking upstream change (gpio getting
removed from hwcore) in the last three years.

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

Octavian Purdila (19):
  fifo32: add peek function
  tests/unit: add fifo test
  Add mcux-soc-svd subproject
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
  hw/misc: add support for RT500's reset controller
  hw/arm: add basic support for the RT500 SoC
  hw/arm: add RT595-EVK board

Sebastian Ene (2):
  hw/ssi: add support for flexcomm spi
  test/unit: add unit tests for flexcomm spi

Stefan Stanacar (1):
  scripts: add script to generate C header files from SVD XML files

Valentin Ghita (1):
  tests/unit: add system bus mock

 meson.build                                   |    4 +
 include/hw/arm/rt500.h                        |   44 +
 include/hw/arm/svd/flexcomm.h                 |  109 +
 include/hw/arm/svd/flexcomm_i2c.h             | 1134 ++++++
 include/hw/arm/svd/flexcomm_spi.h             |  980 ++++++
 include/hw/arm/svd/flexcomm_usart.h           |  959 +++++
 include/hw/arm/svd/flexspi.h                  | 2100 +++++++++++
 include/hw/arm/svd/rt500.h                    |   65 +
 include/hw/arm/svd/rt500_clkctl0.h            | 2287 ++++++++++++
 include/hw/arm/svd/rt500_clkctl1.h            | 3109 +++++++++++++++++
 include/hw/arm/svd/rt500_rstctl0.h            |  832 +++++
 include/hw/arm/svd/rt500_rstctl1.h            | 1344 +++++++
 include/hw/char/flexcomm_usart.h              |   20 +
 include/hw/i2c/flexcomm_i2c.h                 |   27 +
 include/hw/misc/flexcomm.h                    |   85 +
 include/hw/misc/rt500_clk_freqs.h             |   18 +
 include/hw/misc/rt500_clkctl0.h               |   37 +
 include/hw/misc/rt500_clkctl1.h               |   36 +
 include/hw/misc/rt500_rstctl.h                |   32 +
 include/hw/regs.h                             |   34 +
 include/hw/ssi/flexcomm_spi.h                 |   20 +
 include/hw/ssi/flexspi.h                      |   32 +
 include/qemu/fifo32.h                         |   28 +
 tests/unit/i2c_tester.h                       |   30 +
 tests/unit/reg-utils.h                        |   97 +
 tests/unit/spi_tester.h                       |   32 +
 tests/unit/sysbus-mock.h                      |   82 +
 hw/arm/rt500.c                                |  335 ++
 hw/arm/rt595-evk.c                            |   64 +
 hw/char/flexcomm_usart.c                      |  292 ++
 hw/i2c/flexcomm_i2c.c                         |  207 ++
 hw/misc/flexcomm.c                            |  304 ++
 hw/misc/rt500_clkctl0.c                       |  226 ++
 hw/misc/rt500_clkctl1.c                       |  207 ++
 hw/misc/rt500_rstctl.c                        |  225 ++
 hw/ssi/flexcomm_spi.c                         |  439 +++
 hw/ssi/flexspi.c                              |  157 +
 tests/unit/i2c_tester.c                       |  108 +
 tests/unit/spi_tester.c                       |   57 +
 tests/unit/sysbus-mock.c                      |  312 ++
 tests/unit/test-fifo.c                        |   97 +
 tests/unit/test-flexcomm-i2c.c                |  210 ++
 tests/unit/test-flexcomm-spi.c                |  201 ++
 tests/unit/test-flexcomm-usart.c              |  320 ++
 tests/unit/test-flexcomm.c                    |  212 ++
 tests/unit/test-rt500-clkctl.c                |  263 ++
 hw/arm/Kconfig                                |   13 +
 hw/arm/meson.build                            |    4 +
 hw/arm/svd/meson.build                        |   35 +
 hw/char/meson.build                           |    1 +
 hw/char/trace-events                          |    9 +
 hw/i2c/meson.build                            |    1 +
 hw/i2c/trace-events                           |   10 +
 hw/misc/Kconfig                               |   12 +
 hw/misc/meson.build                           |    5 +
 hw/misc/trace-events                          |   18 +
 hw/ssi/Kconfig                                |    4 +
 hw/ssi/meson.build                            |    2 +
 hw/ssi/trace-events                           |   12 +
 meson_options.txt                             |    3 +
 scripts/meson-buildoptions.sh                 |    4 +
 scripts/svd-gen-header.py                     |  343 ++
 subprojects/.gitignore                        |    1 +
 subprojects/mcux-soc-svd.wrap                 |    5 +
 .../packagefiles/mcux-soc-svd/meson.build     |    5 +
 tests/unit/meson.build                        |   56 +-
 66 files changed, 18355 insertions(+), 1 deletion(-)
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
 create mode 100644 include/hw/misc/rt500_clk_freqs.h
 create mode 100644 include/hw/misc/rt500_clkctl0.h
 create mode 100644 include/hw/misc/rt500_clkctl1.h
 create mode 100644 include/hw/misc/rt500_rstctl.h
 create mode 100644 include/hw/regs.h
 create mode 100644 include/hw/ssi/flexcomm_spi.h
 create mode 100644 include/hw/ssi/flexspi.h
 create mode 100644 tests/unit/i2c_tester.h
 create mode 100644 tests/unit/reg-utils.h
 create mode 100644 tests/unit/spi_tester.h
 create mode 100644 tests/unit/sysbus-mock.h
 create mode 100644 hw/arm/rt500.c
 create mode 100644 hw/arm/rt595-evk.c
 create mode 100644 hw/char/flexcomm_usart.c
 create mode 100644 hw/i2c/flexcomm_i2c.c
 create mode 100644 hw/misc/flexcomm.c
 create mode 100644 hw/misc/rt500_clkctl0.c
 create mode 100644 hw/misc/rt500_clkctl1.c
 create mode 100644 hw/misc/rt500_rstctl.c
 create mode 100644 hw/ssi/flexcomm_spi.c
 create mode 100644 hw/ssi/flexspi.c
 create mode 100644 tests/unit/i2c_tester.c
 create mode 100644 tests/unit/spi_tester.c
 create mode 100644 tests/unit/sysbus-mock.c
 create mode 100644 tests/unit/test-fifo.c
 create mode 100644 tests/unit/test-flexcomm-i2c.c
 create mode 100644 tests/unit/test-flexcomm-spi.c
 create mode 100644 tests/unit/test-flexcomm-usart.c
 create mode 100644 tests/unit/test-flexcomm.c
 create mode 100644 tests/unit/test-rt500-clkctl.c
 create mode 100644 hw/arm/svd/meson.build
 create mode 100755 scripts/svd-gen-header.py
 create mode 100644 subprojects/mcux-soc-svd.wrap
 create mode 100644 subprojects/packagefiles/mcux-soc-svd/meson.build

-- 
2.46.0.184.g6999bdac58-goog


