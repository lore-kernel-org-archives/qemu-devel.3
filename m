Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AB0C5AD48
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgtz-0006M8-Ai; Sat, 08 Aug 2026 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wseZ1-00057U-BR; Sat, 08 Aug 2026 06:46:04 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wseYx-0001sk-5h; Sat, 08 Aug 2026 06:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786185944;
 bh=k48Wq9hSp8qvFW7zrRKjDe6w3UQ1q1FoazuXrhv9R3M=;
 h=Date:Subject:To:Cc:From;
 b=GRpuYNaWESpGiPP7UCnS7IzJrtu/Ws184G5eHVG+BcvunecqizzElzdxeYfFUyx3Y
 q+3qTNIRSN+kmKr+QyHx12TJJ2bdjDY9vKnS+XKHUG7gsxn9MM3GC0Xh1hFdG8y9u8
 5TpU3wYy+02GAQd9BsqGdMzczBCeX0VEYVnSBOHk=
Received: from localhost ([111.52.124.140])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id B682BEF5; Sat, 08 Aug 2026 18:45:40 +0800
X-QQ-mid: xmsmtpt1786185940tmobnfysx
Message-ID: <tencent_A2EA48A88233AE87D10D48AB3C0AC3953905@qq.com>
X-QQ-XMAILINFO: OZILsD/zN1fMLabsJqSwcmnhUSpehanzcEc9n65AL+wrHdAbPR1S1dgUKeD9x7
 sSf57Gmj5h4SxQ/fKGmKlN/Df/VZ14YC8rfysl1LCSgWFTUnAavu+qLbgu/JNoZD7fEGadFibHi8
 UGbnpMonkhsF3fj9usYA3RBWwwaY8MXubqUmOt47w05OVTBiKHISA9XMZX0zWzLKdsPNeuRQx2P7
 CdB8r484yQxlLs0BkpCj9WXdff7X0hiJ88uD47thOs4TOmJLgCsaGcB/DKAet8Fbwv9S2ZXsH8xh
 WW/krVbJWD9GFuxFHXGAoGnEfCTZFyiksR55W2pAsIv2M4uczpszDC2/oUuRLUSSZtCFB8VkVGMh
 IEMfZQMUyxS59bUhfZ49tZ2Wa7UAkmT9bRdrZyHlTV0KcJLUr2DEVi8HplAIGx7eD4aVgVRiouYA
 FQ+PPwI+szL7iyFNPhpyM/McTRc2uMuN40R2OdHVodpO2yO4Q/xfH6rZOzA6nPedvgQNqHqXqHmk
 XaWeUvB7qgKCEqWiWwCq6dfX+3/EVEcofumh57twb9yc4OJfE5y+tEbYq6lE02krPzmo4Ko6GvBY
 4nohIzL8aTPRp9d1+ltdzHCqEoYJQVMpNpeb5DLxzrNPZgeGQkwNDLu3wHDziS6YKbBQBSCxO64T
 2HBURIHy4WSQqPmv/C75dVJhzkrYwIiObtHsmFyMQR2HwUnQ0JXUIHayXI6CVDDpWxF+TZi2fOGT
 NJZjMWmIZqjuJ8yGG8+sFfns+kRh7ab7aMraT0fsGRm0LqpIKrdmlRNIMTFTKsoDX6rv8zmTcB8f
 8LpJ8N8LLOC9rr73+7RnZh74Ret/UC16eDGY/DVUUkyog6YqFaaAWzzo4dDrdPO2maRPzqtCj8nS
 ptc4j3NA6Ckf2CQLi6E0dlz8wc2O2SQNxYSr2/xn6YJTZFl1kwq3q/QDAmk2xms8nkUeu9ndXAH0
 edg4YuqfotssIiHo9QIvHUCRbeXXTqmMWZ4KBzfVRvyAOC6yQcm/wAQ03mifs3ZIQXJABIcxOy4u
 II6tuJ6l3iK11H9ivV48Xcsba4v6zwzRNqJvU+JL5xLSJmcoQTLjUIXvK8W8SxIEMWSwXglpFrjB
 vs9hDpz1lljObLzHLRdNjt69TE0A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <cover.1786185889.git.chengkelfan@qq.com>
Date: Sat, 8 Aug 2026 18:44:49 +0800
Subject: [PATCH 0/5] hw/riscv: K230 peripheral device models
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From: Leo Cheng <leo-cheng@vip.qq.com>
Received-SPF: pass client-ip=43.163.128.47; envelope-from=leo-cheng@vip.qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:40 -0400
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

The K230 machine and its watchdog are already in tree. This series adds
device models for the peripherals on the c908 little-core bus and wires them
into the machine, each with a qtest.

Patch 1 adds the DesignWare APB GPIO controller (one PLIC line per pin).
Patch 2 adds the RTC (date/time, masked alarm, periodic tick, live sub-second
count).
Patch 3 adds the IOMUX pin controller and the mailbox/IPCM block (doorbell
interrupts + hardware spinlock).
Patch 4 adds the SD/eMMC host (DesignWare dw_mmc) register model.
Patch 5 wires the devices into the k230 machine, adds two SiFive PWM instances,
a satellite-safety fault-injection qtest, and updates docs and MAINTAINERS.

Register layouts are taken from the K230 TRM v0.3.1, the upstream Linux
pinctrl-k230 driver, and the Canaan k230_sdk. Exercised by the k230 qtests
(gpio, rtc, iomux, mailbox, dwmmc, pwm, safety) under qtest-riscv64.

Based on commit f893c46 (qemu-openbios-20260707 merge); hw/riscv/k230.c and
include/hw/riscv/k230.h are unchanged from that base upstream.

Leo Cheng (5):
  hw/gpio: add K230 GPIO controller.
  hw/rtc: add K230 RTC.
  hw/misc: add K230 IOMUX and mailbox/IPCM.
  hw/sd: add K230 SD/eMMC (DesignWare dw_mmc).
  hw/riscv: wire K230 peripherals into the machine.

 MAINTAINERS                     |  12 +-
 docs/system/riscv/k230.rst      |   6 +
 hw/gpio/Kconfig                 |   3 +
 hw/gpio/k230_gpio.c             | 270 ++++++++++++++++++++++++++++
 hw/gpio/meson.build             |   1 +
 hw/gpio/trace-events            |   4 +
 hw/misc/Kconfig                 |   6 +
 hw/misc/k230_iomux.c            | 101 +++++++++++
 hw/misc/k230_mailbox.c          | 206 +++++++++++++++++++++
 hw/misc/meson.build             |   2 +
 hw/misc/trace-events            |  10 ++
 hw/riscv/Kconfig                |   7 +
 hw/riscv/k230.c                 |  89 ++++++++--
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/k230_rtc.c               | 306 ++++++++++++++++++++++++++++++++
 hw/rtc/meson.build              |   1 +
 hw/rtc/trace-events             |   5 +
 hw/sd/Kconfig                   |   3 +
 hw/sd/k230_dwmmc.c              | 139 +++++++++++++++
 hw/sd/meson.build               |   1 +
 hw/sd/trace-events              |   4 +
 include/hw/gpio/k230_gpio.h     |  68 +++++++
 include/hw/misc/k230_iomux.h    |  44 +++++
 include/hw/misc/k230_mailbox.h  |  61 +++++++
 include/hw/riscv/k230.h         |  18 ++
 include/hw/rtc/k230_rtc.h       |  61 +++++++
 include/hw/sd/k230_dwmmc.h      |  61 +++++++
 tests/qtest/k230-dwmmc-test.c   |  79 +++++++++
 tests/qtest/k230-gpio-test.c    | 143 +++++++++++++++
 tests/qtest/k230-iomux-test.c   |  62 +++++++
 tests/qtest/k230-mailbox-test.c |  89 ++++++++++
 tests/qtest/k230-pwm-test.c     |  43 +++++
 tests/qtest/k230-rtc-test.c     | 188 ++++++++++++++++++++
 tests/qtest/k230-safety-test.c  | 127 +++++++++++++
 tests/qtest/meson.build         |   2 +-
 35 files changed, 2211 insertions(+), 14 deletions(-)
 create mode 100644 hw/gpio/k230_gpio.c
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 hw/misc/k230_mailbox.c
 create mode 100644 hw/rtc/k230_rtc.c
 create mode 100644 hw/sd/k230_dwmmc.c
 create mode 100644 include/hw/gpio/k230_gpio.h
 create mode 100644 include/hw/misc/k230_iomux.h
 create mode 100644 include/hw/misc/k230_mailbox.h
 create mode 100644 include/hw/rtc/k230_rtc.h
 create mode 100644 include/hw/sd/k230_dwmmc.h
 create mode 100644 tests/qtest/k230-dwmmc-test.c
 create mode 100644 tests/qtest/k230-gpio-test.c
 create mode 100644 tests/qtest/k230-iomux-test.c
 create mode 100644 tests/qtest/k230-mailbox-test.c
 create mode 100644 tests/qtest/k230-pwm-test.c
 create mode 100644 tests/qtest/k230-rtc-test.c
 create mode 100644 tests/qtest/k230-safety-test.c

-- 
2.43.0


