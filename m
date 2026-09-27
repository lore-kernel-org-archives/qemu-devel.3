Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E44AC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvFr-0008HX-H0; Sun, 27 Sep 2026 16:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvFp-0008H0-08
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:45 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvFn-0003XL-7e
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:13:44 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1522765a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540021; x=1791144821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SC5u1TEkkTmpzmjfXJSiSaeUYsB8fTVgLJ01O88pTjY=;
 b=pf2zmoY+c3Ovpu6Xuoe1Dpu51mQCxcr45VmG9TYMmyBmqpTvj+nzSdv4IRwshA7mBp
 AdK7aN/t3seNGcZtvPTwtxV7D9SsBLq98PtA852oUlF4VxnyoWgHdbRVqC8uJOrHZwPQ
 nc5FU4SjjYqW7EeupgsUa9ODKUgGXH7ziXYZRttGZCydCYHDniY7DhVe1OpU5JyeUoEp
 k2wCgGYXAFLswufvrN6SrUzVkRdrrlo+u95agiTdRl8DbKM2tenWa1r1Ua6eylYfcI9v
 lKt6f8dy7eoBn+rVb8eLnicOytqQSS45994LSxQgfe+vFwiYwXjoiugcqeQgS9TN6j9o
 x8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540021; x=1791144821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SC5u1TEkkTmpzmjfXJSiSaeUYsB8fTVgLJ01O88pTjY=;
 b=wC6ocAsBdJsCGNvFLuyTuWhoLeZr765+g6tac4SlX/LTKBZ4cw5ZNMDXQds70aPn6v
 g3IaOliffZa96yUZI5oukNcySN7qXNcKM1Fd5kQhvBPFdWmWhqAwbUCMSBAaFFPWpE4v
 L/3ik9Q3DfzURMNS8ePrZWquAIWW3o/Ys3bjaMJXitZ/Hsr+tF5UE5Dgx43Vti3BiAGU
 2Du4kEF4hwN3P9vKIesODluWinybJFvbk9sfPs4+rwVVD31QvD/vi//RJMbzO89FC2mU
 oQmLzJna89yWRRUUFZh6NsCd+trp4zROSUBSRdu9V52zcRkLCdOujVP3CfHIMmMMxZEC
 knOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqIJYA4ylRfAppKe+gxGOW8fqxxK8gJDG01BlileMs9Y4m7JNq55KLUzzdv8Yl3pFIrNh33BiYIu/Y@nongnu.org
X-Gm-Message-State: AFq9FYI58IXPH7LOUX7qkLI3U2Lx+rwuczUWbg87SLIQ1hzwMh15yPSv
 bhbIlSbdGPON+4ey7VSGD0No480Qm+dfvBQRVUlyTZbhjLTuGBa1nh28
X-Gm-Gg: AYBFou0JplKZQufMhb9+zQdByphqoV42NPwLNMaocl8cZE2VMK3R6SskgunwWLFISql
 1X5fggl7zHls7m3kchfX+eMxs3tm31uQyJkyhC48B8/B+ueN4h5+Qqmu5NXdhOlmpofr4M5woB8
 H3mdLbn+Kx97L93hJrHXHFgAPIQGk5EuNPn5SBA+7KIk5LDw8jnhDMM1HaMTJLmcsi8ww0hRkOn
 1M1rDOxn6Wd3B1XMWJrbSEMkTYOawfecQ4mugTNVI2w6B571QXIbePprSevI2oiN2N7SxrxhjHY
 Q9BCfJFGQ3bPkw8pCv5GEtfIni8sLvHVXdsFSEnYeLzXJ3TxaMo6vFhYlGSLOEYGKU8hw8PaSfU
 GAE/fzfI2lyKEcAuP1zvKKuRTCtcNOFja09SKYcQVCSy0KBcfWq3izt/PkU6ERPk6vjViL1hJzA
 duRCvLtmarxbfPGfMdkDYos01zXEF1pn37SnBdvX898HJYpBZRLkYiEDGbQxKUXouWAvugsZQIe
 feJkxGkj/NRIBZ21vVDsKoXVqnsNxjaLUxfQXGRsTMxGhKos8/VG6SQOlq6pt1qei+c/r7TZg==
X-Received: by 2002:a17:90b:48d0:b0:3a0:e22b:1b16 with SMTP id
 98e67ed59e1d1-3a0e22b1df8mr3745452a91.25.1790540021518; 
 Sun, 27 Sep 2026 13:13:41 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:13:41 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 0/7] hw/riscv: Add support for Milk-V Duo board
Date: Sun, 27 Sep 2026 20:13:19 +0000
Message-ID: <20260927201326.650943-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=visitorckw@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add initial support for the Milk-V Duo board.

The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
and CLINT controllers, a dw8250 uart, and basic clock control. The
current implementation can successfully run OpenSBI and boot Linux v7.0
from an SD card to the Linux shell.
---
Changes in v5:
- Rebase on master branch.
- dw8250: Split MAINTAINERS entry into a standalone section.
- cv1800b_clk: Use sizeof(uint32_t) for REG_BYTE_WIDTH, check bounds
               against CV1800B_CLK_IOSIZE, and log guest errors on
               out-of-bounds accesses.
- boot test: Switch assets from personal github repo to tuxboot.

Changes in v4:
- dw8250: Fix memory access sizes, handle dynamic 'regshift', log
          unimplemented writes, and propagate errors.
- cv1800b_clk: Replace magic numbers with macros and sizeof().
- cv1800b: Move static properties and child device initialization to
           instance_init and propagate errp.
- milkv_duo: Use riscv_default_firmware_name(), riscv_load_fdt(), and
             DEFINE_TYPES().
- docs: Add a doc for milk-v duo board.
- tests: Add an end to end boot test.

Changes in v3:
- Rebase on master branch.
- Drop custom T-Head PMU CSR patch to avoid duplication.
- Use REG_BYTE_WIDTH macro in clock controller.

Changes in v2:
- Added link for the custom T-Head PMU CSRs
- Added qtest to validate basic for the dw8250 and clock controller.
- Removed RFC tag.

Kuan-Wei Chiu (7):
  hw/char: Add dw8250 UART
  hw/misc: Add Sophgo CV1800B clock controller
  hw/riscv: Add Sophgo CV1800B SoC support
  hw/riscv: Add Milk-V Duo board support
  tests/qtest: Add qtest for Milk-V Duo board
  tests/functional/riscv64:  Add boot test for Milk-V Duo board
  docs/system/riscv: Add Milk-V Duo board documentation

 MAINTAINERS                                 |  18 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/milkv-duo.rst             |  49 ++++++
 docs/system/target-riscv.rst                |   1 +
 hw/char/Kconfig                             |   4 +
 hw/char/dw8250.c                            | 131 +++++++++++++++
 hw/char/meson.build                         |   1 +
 hw/misc/Kconfig                             |   3 +
 hw/misc/cv1800b_clk.c                       |  98 +++++++++++
 hw/misc/meson.build                         |   1 +
 hw/riscv/Kconfig                            |  14 ++
 hw/riscv/cv1800b.c                          | 177 ++++++++++++++++++++
 hw/riscv/meson.build                        |   3 +
 hw/riscv/milkv_duo.c                        | 118 +++++++++++++
 include/hw/char/dw8250.h                    |  27 +++
 include/hw/misc/cv1800b_clk.h               |  26 +++
 include/hw/riscv/cv1800b.h                  |  56 +++++++
 tests/functional/riscv64/meson.build        |   1 +
 tests/functional/riscv64/test_milkv_duo.py  |  53 ++++++
 tests/qtest/meson.build                     |   3 +-
 tests/qtest/milkv-duo-test.c                |  70 ++++++++
 21 files changed, 854 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/riscv/milkv-duo.rst
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py
 create mode 100644 tests/qtest/milkv-duo-test.c

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


