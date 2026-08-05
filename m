Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F9C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdLe-0000GK-Vp; Wed, 05 Aug 2026 11:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wrdLK-0008Uv-E5
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:15:56 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guochun.wang@foxmail.com>)
 id 1wrdLD-00049J-86
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1785942923;
 bh=TEFowdoXfYZ9BeczDycXtG2n/TiomN1Vsvv7pPOPxfI=;
 h=From:To:Cc:Subject:Date;
 b=rlBwZ7ERxvWP3ifZT1OShAI9+stmT4nfMjx3tlNUVBCb01a/Vl5t4JJP1+SIelnZz
 nTDFKk3ztPxZica1mA4k7ClcqbJqFeFIruRtbzkDp8ZlMbSzI423cK2wTJroZ2YnR9
 gquW9dGXcH29nywhdwxJKwm5kodm0/sDaEZOKEiQ=
Received: from DESKTOP-8MIQOKD.localdomain ([117.13.168.66])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 3D43DC51; Wed, 05 Aug 2026 23:15:20 +0800
X-QQ-mid: xmsmtpt1785942920t5xvsp2ym
Message-ID: <tencent_1EE6F17A514580093D329A6B4BA43B7D7506@qq.com>
X-QQ-XMAILINFO: OV56TfPCuCfRZPUhuIhPWdaUJVEo09H1Ep4EMsGaDZ8Lkb13pTB/nFc93DcaQ7
 xWcpcsQEqupzeNVHS/L1T1LCQpBBH4zWNznY//E28hMYhyB7wgPfR2qKiYat3PLNRRZcogE2vfFO
 nEo1Vs33IkujJska1IFg1Mcuzl4AMHgjpv5aYYl+fr71h9KqVXi2AJMPr81tK9buHZ2CCyc7fRAT
 qF3BeCjDM3k6qsO6hSX2Dwj1vN0Oh37MfJKDasGcTOaekREMIPie/SIMfF39krqGPFNVTqQBdpVy
 Nlv6GYDRppts+BL7UbSq8/y4bcugDtNPQ60NtMeyi0+Cwe4EV4moVvzWNbVjzrDynHiiHMibyIMp
 XP5hV9xyUpiK794vP/Ksw7zNqf4C20ATVpsRzvSJsdMdXiATz6DCsYHjkuhUKmsIByRSA5kWoyaZ
 9CJ92JdKJmbaIFcygw2A685A7olU21yfZ6SwdioBdwPm2WkfZ01IXW0KdKLG0o2FNyMk9LF9zqEr
 ztBnUdwmUznGKw79C3U4s+DDgmtnnoE7pcq4QNllfwF9WKxOxEgsh8BfkA+r1TyMXhWA3La1m0df
 hu7Sx8/+FKIa/jC6g0ubngvd+SxwWIEBrFpdWYnqsoLP4lHD34Ita1Mx6QMrgjg76Zu70wr06YYg
 UXmIgz0aYx6ZzFgoehB6qK17yD1mS7FkA8GkO876VpUS7JrqprFBim/doCJRmvYUwL9qXJsWMZ1I
 /FVwF7NXXSevmltAVYDfBUiLaE3J9UA9QZ3iR2CT0EV/cnP3dVCDkm1u0Nt+zm7uQivXYrLg3ZYF
 KhGbgB4A2sL2X20y+fUaRJM0MUAIR5PCnUGqFvEVLxIAVsnhXUk1n1ldRTZ30aJFV7aixPzTo88s
 71PAcBknv9dx+vHQpsocpr7ZrgRc+VzS5AAZH0e2g/I5uUAemZ8rUcPZRRTA6Bn2VivChHpjlFXe
 VRstvTkKO/QIwMr8hWpW4RohzZZQvYYaVYstoZXwkdn4IFGoB96xaVjvOO/E6tMM7bNdkeg2MR2S
 2ixZHaIMHjSCRuwM/v1MLn54V1+YBDL9fDJuLAB8fAN27h43HGvdGDwAXAfBTbKhKCc5VucWVVGA
 YOAM95W9/PZ/WzRTXJDuzbI1wlQYgqkb2yvKUwM9nVO0r8zz8uMIwRq9Z/1Hh82FqlCUEgwdokDX
 REEU6E1hS4XYcgz71boKhSbXApeFm1QwI5Wa17/6vZQT/8JiueWIcw4l2z66SQx5bpECkYzvSgkq
 vbEA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: guochun.wang@foxmail.com
To: qemu-devel@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, qemu-riscv@nongnu.org,
 guochun wang <guochun.wang@foxmail.com>
Subject: [PATCH v2 0/2] Add K230 SoC GPIO controller support
Date: Wed,  5 Aug 2026 23:14:53 +0800
X-OQ-MSGID: <20260805151455.99076-1-guochun.wang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87;
 envelope-from=guochun.wang@foxmail.com; helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Changelog for version 2:
  - Resend the patch series because the v1 submission was not properly
    threaded (the cover letter and the two patches were not linked by
    In-Reply-To/References, so they appeared as separate threads on the
    list / in patchwork).
  - No code changes; the patches are functionally identical to v1.

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


