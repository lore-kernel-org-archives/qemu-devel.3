Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07BBC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGR9-0002PD-Ho; Fri, 24 Jul 2026 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQx-0002J7-FS; Fri, 24 Jul 2026 09:59:36 -0400
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1640586082@qq.com>)
 id 1wnGQs-0003Pr-CE; Fri, 24 Jul 2026 09:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784901550; bh=jRCHhEy3Ym//nIqFz4nduByULiPG8zb4EYEv8H9caPM=;
 h=From:Subject:Date:To:Cc;
 b=LrOnQHFFDgite14ASZcrz0DCjd4K0e3mY3L8bqPEupbtGTazomqSnC3BM6V9pqK2x
 7m9oTP+IkoSY2EdYA+cTGqDZo5c5y47IiJZ7N82leoIk97oAurFq5XaYb0sLqqEzqa
 HKFf0S2epEPEJW9NOeWbvln6AT7nnimrwxUB3jHQ=
Received: from [127.0.1.1] ([240e:3bb:a98:9fe1:fbb4:4428:c3bc:a339])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id EC68C209; Fri, 24 Jul 2026 21:59:06 +0800
X-QQ-mid: xmsmtpt1784901546te02jlweo
Message-ID: <tencent_EA98FCE27E3F63CFA80C69037A207CCDAF07@qq.com>
X-QQ-XMAILINFO: NqJ9OIiNOgx8Z/xS5vBtraVvHjerB0/s2bsocaBL+SQP+6rbH5ZT1rI0r9OzZd
 8K8ycBdis8JS0/cuz9zpH/S8h4FbusC0xLEIl9OCkznBMF+SeJVUmhMtAh4ZpxHMvXRZXFLAqKAB
 d5nw6lgnbWugGhYxFjAnHzwlhgMM8fobwX6yU8dF8K00fmqRqqq5pcnHb+FLTMibe/O9toahw2ql
 vvz/ST33BQ7IqBFT2m9uAm/4DHsWePrJjIAZFV1zXaJCiBXQB1vGnFFTG8Qnp8ywGUKqUQDJKy1N
 dcMIAjMnr2zssv4I/mTyspO8bMUpUJxq2nYfcrzEoY4RHH5CZzPqTJ0pDcGDRQiBp6fdfFjRQd5d
 UJ3E2DBQvR5ghSmYighfb+bgvT7u2XHhOEmUrIQB5xpLg2FOOTF7QQMVyN1iqaPtkjWStA5jAOFf
 fg1RjhVj2K9eYXBfNhMQsp2jSvYdgYojX+bnU/sIyfSa3XmfnWeRKlVt6EfCEUL/RAErDF+noZoF
 zWfYXsBA1lAikjZ6kWUcR3LsgkAvY3flSc2oub8o/FqcPhvaN9L4suneWF2b0tYp8mpnQ25t7QVW
 62bOBLDvMN+siqyNWyMt2HP0LzAqh9vxHIvBGMc9WjEtPAELJDG8bY7sJEwBYpf85DdIAGQMj5iO
 X2y3SN1Q6tKUUXiHr9NBWXpuUtt+n4VH2UcyBPkd/cAu14Cs5yIayRFccdPn4ueQG8/t+um1kqjF
 odZNAdS9WEES7PiVSL4to9xpcl3CkqQyqsexQcAT5VR7GEC8v2ypWvRBVnztUL8d4PJDnSScaiEU
 7wvZzu488h+ve4B5HM58jcBujkwGdwGx0xVvXT3jUOmHqQEmC/6i2heVQ+PTvFq43gVR+vaqpiRH
 IO48Ef64HB5nvdbOXw7CP/Ud1qRh0SyBdQshqgI3ZS3S2PXTtRn2J+9hrCpXCLp5bCprVeG5ZLpv
 D0VhZ44kEFiT794nuFwhbnPFcfh9zHxQ8gBlo4nhHovKAuelS7BBBfiS5GLpPxTTaf2Z2CWGyfHE
 u5d2HnNgiXVGh3RsSz/axBtTKwWYwxMJz4aRm48W6L73G/JneeK/kmzs4d6K18aqn9pjRqh+bpfL
 mJmXdgOL1RtQEQwfn6uufA2D2aA+7n6Uvmg+pq6ICuUw2j0RHfdHsulmFje/+jjG8jgZfjIstZ5l
 uaSaIjZg7efP2rHlTZWFrwbyw5paml7wNF2uHx+PWlE6F0RublGb+cz7liJ09+RgB8NbU=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: zhenbaii <1640586082@qq.com>
Subject: [PATCH 0/3] riscv: Add K230 DW 8250-compatible UART
Date: Fri, 24 Jul 2026 21:58:58 +0800
X-OQ-MSGID: <20260724-k230-uart-v2-v1-0-4c0657a703e5@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJvY2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3WwjYwPd0sSiEt0yI93kpCQDc4PEVONUyzQloJaCotS0zAqwcdG
 xtbUALv3dIV4AAAA=
X-Change-ID: 20260724-k230-uart-v2-cbb070ae3e9f
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 zhenbaii <1640586082@qq.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784901547; l=1497;
 i=1640586082@qq.com; s=20260721; h=from:subject:message-id;
 bh=LX92DradPJ5JKhlIaOJIvmN/IsOvWjrWWfmEihRc9X4=;
 b=LZNTwPXcI1ZvFXev2p4hr3snWobfmVjZqB3TrMkBkdNXQfrl4rQSU1Ahf8nBfwaxj707bBMUW
 rbZHPG65SZEADMgCrq9186zjfoyNsDX635tPK9CkYF0i7zkKcL4oGYi
X-Developer-Key: i=1640586082@qq.com; a=ed25519;
 pk=AjRy6i+I/zX9djX87K/xR2OQ2Myy7s7j7bDdi9Qz3zw=
Received-SPF: pass client-ip=203.205.221.173; envelope-from=1640586082@qq.com;
 helo=out203-205-221-173.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
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

This series adds a QEMU model for the K230 SoC DesignWare 8250-compatible
UART controller, wires it into the K230 SoC, and adds qtest coverage.

The implementation supports the registers and features required by the
Linux 8250_dw driver, providing an interactive shell over the serial port.

Changes since v1 [1]:
  - Split into a 3-patch series.
  - Fixed indentation of preprocessing macros.

Testing: 8 qtest cases pass.  With the k230-boot-assets image from
https://github.com/zevorn/k230-boot-assets, the driver probes
successfully and the shell works bidirectionally over pty.

[1] https://lore.kernel.org/qemu-devel/tencent_FE5823EA5F7A9EDE163FEDCB3DBFBE1FD905@qq.com/

Signed-off-by: zhenbaii <1640586082@qq.com>
---
zhenbaii (3):
      hw/char: add K230 DW 8250-compatible UART
      hw/riscv: k230: connect DW 8250 UART
      tests/qtest: add K230 UART test

 hw/char/Kconfig              |   3 +
 hw/char/k230_uart.c          | 840 +++++++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build          |   1 +
 hw/riscv/k230.c              |  33 +-
 include/hw/char/k230_uart.h  | 180 ++++++++++
 include/hw/riscv/k230.h      |   6 +-
 tests/qtest/k230-uart-test.c | 514 ++++++++++++++++++++++++++
 tests/qtest/meson.build      |   2 +-
 8 files changed, 1565 insertions(+), 14 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260724-k230-uart-v2-cbb070ae3e9f

Best regards,
-- 
zhenbaii <1640586082@qq.com>


