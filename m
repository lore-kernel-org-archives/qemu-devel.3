Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31A7C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr0yB-000050-Td; Mon, 03 Aug 2026 18:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wqueC-0001NJ-Ns
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:32:13 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wque8-0004qn-V8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1785771116;
 bh=8BVzs/IT6pVQ73xUL2jI08jtpjaUmlmJAohvK5vWoWk=;
 h=From:To:Cc:Subject:Date;
 b=KBsMFss18lbjl0vUa4A9i0h6CErmq7jDSYRpCKEo0+5rG6jI0odJ9C1sELOq1U1lG
 RlV06Ls1vfjTn1NheHq9bxX20uQ9ECZcK4VaS80+8KfpwkqURjXP4+eQsSj6+S6DwA
 1YXC8aWcA3TJXzIVxTqLlSx8cln/FSC7+Y5oQFbI=
Received: from DESKTOP-8MIQOKD.localdomain ([117.13.168.66])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 72397CE1; Mon, 03 Aug 2026 23:28:35 +0800
X-QQ-mid: xmsmtpt1785770915txxdcygnp
Message-ID: <tencent_B90E44EAD06F6676AF9B572898242037BB0A@qq.com>
X-QQ-XMAILINFO: MR06con9IFZDhRyiZ6G5z/7aaDNJMBgV97bLjzI92pdJ5Y250OKN2I1NNwDzI8
 XHU/vRhg0bCGACTw3e2JN+dL5DnwYNmkezXCCtEvKb5U9CPZSSXJGPIHITU/+pb7diciN+vHBv4A
 3Huk+Bhc7HRZgNB1wjKRowTHfpKB9jVc85ac+iAMHDuhmtO2Ie5kwzIHFrzCIbo0Dccl8wOUBqD1
 E+nvtBjvWWzFSuX798a1BWznQXOcMsdW2j0XGcI92+gpLDIovBub3/L2xSj8z5rIYyx95plXV6MQ
 T7O2B1nRU9Rab8irlVxKtUsHNn8LLwpO/syeUM/enuwH1G7YrzFh3FJK3lsmG5gQOeucDCmbZyMK
 fTL1OyHBQ3fpjqeTzNEwKDb6NA7O7MG+61Kk+hufd5thywhzjhhiiiysrOk4flBqZI4OmPjrUtx3
 g6CKxkxh2zPoOjKt61MYNh7C1niE8BHTyoPugx5y0nVgrkXzUjOGpjexm34ebvGalh6Ix2p4Eivh
 71rG5MGwQRyxnsSvRN+QkPHrv3cdG4QjG5wLX1SWBgmEjc7Tg5H4yOJRqsaCqVCPjvozza6aYeDK
 2p8cRx0eE/drfIG14wie57AaE13wJdnhaRj76Ksv4xOIvRZHIVotmLfMV2afqtg3e8DGbzt7xRQ1
 31RlLND8jIceVpTbWle6I2v3N+0weJIwN/Vw9EEQ23mn5IW97gvYNLXGDQ13MG1IczMd4kJyuati
 NLY1VdxfBuMMp/Y/2qzaW6aZoDjmRoHG6IuKbQ08z8cPI9Mu+cgl5Ait28Et2akzosVzgRY8jnbK
 QVbeo2sUxCnGvPHBzSvK1rpxTsI87Kp0mIo5HWTRC/Dccfy8PQ3PAOKYUZeTMyYvjAECbymXp2ba
 Zb92YXjEZmqyTxEvwazJbI4sWa8NI7LwpbrM7+NIdf2/shU1xragDHftGfu/NhGfMPZwiSkaULuv
 x/OBLU5cwxAKtcw20FvQf9OmxH3U3Q2iYesSoGJ8gXYbfbtz9IQOtLBFiBc9FuCMucCQjXJ5rndA
 adtdpX0ES27keZUaKltb62jvmulcGfF+kkTKdNE4BVzNTPzbRTjxVOkOH+zVFwR1JD6g5BrwOG2C
 JBahnFeuE87s5nS/U=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: guochun.wang@foxmail.com
To: qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, qemu-riscv@nongnu.org,
 guochun wang <guochun.wang@foxmail.com>
Subject: [PATCH 0/2] Add K230 SoC GPIO controller support
Date: Mon,  3 Aug 2026 23:28:30 +0800
X-OQ-MSGID: <20260803152832.222022-1-guochun.wang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.49;
 envelope-from=guochun.wang@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Aug 2026 18:17:05 -0400
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

From: guochun wang <guochun.wang@foxmail.com>

The Kendryte K230 SoC contains two APB GPIO controllers derived from
the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is itself
based on gpio-dwapb.c, and shares the same register layout), with a
Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
integration. This series implements the device model, wires it into
the K230 SoC, and adds qtest coverage.

Patch 1 implements the controller model following the K230 Technical
Reference Manual v0.3.1: software control mode (DR/DDR/CTL), external
port multiplexing, per-pin IRQ output, edge and level interrupt
detection, EOI/mask/gating logic, DDR/CTL mode switching with pending
interrupt preservation, and three-phase Resettable API support with
VMState migration. It also instantiates the two controllers (gpio0 at
0x9140B000, gpio1 at 0x9140C000) in the K230 SoC, replacing the
previous unimplemented-device placeholders, and wires each controller's
32 per-pin IRQ lines to the PLIC (sources 32..63 and 64..95).

Patch 2 adds 16 qtest cases covering reset values, edge and level
interrupts (rising/falling/both-edge, active-high/active-low), EOI
clearing, INTEN gating and INTMASK masking, mode-switching behaviour,
PLIC claim/complete flow, and the second controller instance.

Hardware control mode, debounce logic, the combined interrupt output,
and clock-domain synchronization are intentionally not modelled; they
have no observable effect under QEMU and are documented in the patch 1
commit message.

The series has been tested against the Linux gpio-k230 driver and the
existing K230 qtest suite.

Cc: Chao Liu <chao.liu@processmission.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-riscv@nongnu.org

guochun wang (2):
  hw/gpio: add K230 GPIO controller model
  tests/qtest: add K230 GPIO controller test

 MAINTAINERS                  |   3 +
 hw/gpio/Kconfig              |   3 +
 hw/gpio/k230_gpio.c          | 362 ++++++++++++++++++++++++++++++
 hw/gpio/meson.build          |   1 +
 hw/riscv/Kconfig             |   1 +
 hw/riscv/k230.c              |  27 ++-
 include/hw/gpio/k230_gpio.h  |  73 +++++
 include/hw/riscv/k230.h      |   5 +
 tests/qtest/k230-gpio-test.c | 521 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 10 files changed, 991 insertions(+), 7 deletions(-)
 create mode 100644 hw/gpio/k230_gpio.c
 create mode 100644 include/hw/gpio/k230_gpio.h
 create mode 100644 tests/qtest/k230-gpio-test.c

-- 
2.43.0


