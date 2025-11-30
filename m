Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9706ED111A8
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 09:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPdch-0005lj-1D; Sun, 30 Nov 2025 04:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vPdcf-0005l5-QH; Sun, 30 Nov 2025 04:21:37 -0500
Received: from out28-59.mail.aliyun.com ([115.124.28.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vPdcc-0006Cg-IO; Sun, 30 Nov 2025 04:21:37 -0500
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fZX11RJ_1764494475 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 30 Nov 2025 17:21:16 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v1 0/5] Add K230 board and thead-c908 CPU support
Date: Sun, 30 Nov 2025 17:21:05 +0800
Message-ID: <cover.1764493931.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.59; envelope-from=chao.liu@zevorn.cn;
 helo=out28-59.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi,

This patch series adds support for the K230 development board,
which is based on the T-Head C908 RISC-V CPU. The series includes
the following key features:

- patch1: Add T-Head C908 and C908v CPU support
- patch2: Add K230 board initial support(big core is not supported yet)
- patch3: Add Programmable Watchdog Timer (WDT) peripheral support
- patch4: Add QEMU test for K230 watchdog
- patch5: Add documentation for K230 machine

Thanks,
Chao

Chao Liu (5):
  target/riscv: add thead-c908 cpu support
  hw/riscv: add k230 board initial support
  hw/watchdog: add k230 watchdog initial support
  tests/qtest: add test for K230 watchdog
  docs/system/riscv: add documentation for k230 machine

 MAINTAINERS                    |  10 +
 docs/system/riscv/k230.rst     |  48 ++++
 hw/riscv/Kconfig               |  11 +
 hw/riscv/k230.c                | 501 +++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   2 +-
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 307 ++++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        | 153 ++++++++++
 include/hw/watchdog/k230_wdt.h | 130 +++++++++
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  43 +++
 target/riscv/th_csr.c          | 380 ++++++++++++++++++++++++-
 tests/qtest/k230-wdt-test.c    | 199 +++++++++++++
 tests/qtest/meson.build        |   3 +-
 16 files changed, 1800 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c

-- 
2.51.0


