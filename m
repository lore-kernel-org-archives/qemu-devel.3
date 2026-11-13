Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C280606E0D9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Cid1jVSO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjN-0001c1-7v; Fri, 13 Nov 2026 08:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnup-000562-Sv; Fri, 13 Nov 2026 04:49:51 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnun-0007Hi-Jz; Fri, 13 Nov 2026 04:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=MmyOStf5xcrVxt22llyhBMFjYeGiPmpNfp
 Lc/K78E6k=; b=Cid1jVSO/xU6uXQYOfCLWR5A3pBVsPUOHWFHWfR6wURS1LWXYV
 GqXztP3A+jw26YKbCurg9Sk6F4OzoyJj52+ROkrwYsG24doJeBimK8gmaij/j4C4
 PvgFYhi0pLAUvVhF5043COI2py3eBV0LabjA43lVLcKfDEEnP/kP7OE8Q=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S22;
 Fri, 13 Nov 2026 17:49:45 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 20/20] docs/system/arm: document the Radxa ROCK 5B machine
Date: Fri, 13 Nov 2026 17:47:54 +0800
Message-ID: <b4391e55f4808e01db4636de67b2ab926ffa879b.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S22
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkXr15Xr4fuF1UWF4fGrg_yoWrCrWUpa
 nIk34fKrZ7GFyfurs3GF4xXFy3J3Wvv3yUCr1xJ3s5AFsxAry8tw1DtF1Fka47WFWFkF4Y
 vryIqFyUur4rWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
 xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
 M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
 kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
 72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
 C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8
 uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
 1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSfO7UUU
 UU=
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

Document the currently implemented RK3588 SoC and ROCK 5B board,
covering the modeled hardware and the boot commands.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 MAINTAINERS                 |  1 +
 docs/system/arm/rock-5b.rst | 86 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 3 files changed, 88 insertions(+)
 create mode 100644 docs/system/arm/rock-5b.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6303b99755..3adebdcafa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1074,6 +1074,7 @@ F: hw/timer/rockchip-hptimer.c
 F: include/hw/arm/rk3588.h
 F: include/hw/misc/rk3588-scmci.h
 F: include/hw/timer/rockchip-hptimer.h
+F: docs/system/arm/rock-5b.rst
 F: tests/functional/aarch64/test_rock_5b.py
 
 SABRELITE / i.MX6
diff --git a/docs/system/arm/rock-5b.rst b/docs/system/arm/rock-5b.rst
new file mode 100644
index 0000000000..0de25cdb6d
--- /dev/null
+++ b/docs/system/arm/rock-5b.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Radxa ROCK 5B (``rock-5b``)
+===========================
+
+The ``rock-5b`` machine models the Radxa ROCK 5B single-board computer,
+which is built around the Rockchip RK3588 SoC.
+
+Supported devices
+-----------------
+
+The ``rock-5b`` machine supports the following devices:
+
+* 4 Cortex-A55 and 4 Cortex-A76 CPUs
+* GICv3 and the architectural timers
+* On-chip SRAM
+* HPTIMER boot control register (enable bit)
+* UART1 through UART9
+* Rockchip SFC with a 16 MiB SPI NOR flash
+* Clock and reset unit (CRU) registers
+* SCMI Base and Clock protocols over SMC (CPU and DSU clocks)
+* OTP controller
+
+The machine always uses all eight CPUs and supports 128 MiB to 16 GiB
+of RAM, with 2 GiB as the default.
+
+Boot options
+------------
+
+The ``rock-5b`` machine boots U-Boot SPL when ``-bios`` is given and
+Linux directly when ``-kernel`` is given; one of the two is required.
+Both methods start the primary CPU in non-secure EL2 and provide PSCI
+through SMC calls. DRAM is assumed to be initialized;
+BootROM, DDR training firmware and BL31 are not modeled.
+
+U-Boot SPL is supplied as a raw binary with ``-bios``. QEMU loads it
+at ``0x00000000``; SPL loads U-Boot proper from SPI NOR. The device tree
+is taken from the Linux FIT image loaded by U-Boot, so ``-dtb`` cannot be
+used with this method.
+
+Direct Linux boot supplies an AArch64 Linux ``Image`` with ``-kernel``
+and a device tree with ``-dtb``; ``-initrd`` and ``-append`` are optional.
+QEMU does not generate a device tree for this machine.
+
+Running
+-------
+
+The first ``-serial`` option connects to UART2, the debug console on
+the board's header; further ``-serial`` options connect to UART1 and
+UART3 through UART9 in that order.
+
+U-Boot SPL boot
+~~~~~~~~~~~~~~~
+
+With ``u-boot-spl.bin`` and ``spi-nor.img``:
+
+.. code-block:: bash
+
+   $ qemu-system-aarch64 \
+       -machine rock-5b -m 2G -smp 8 \
+       -display none -monitor none -serial stdio \
+       -bios u-boot-spl.bin \
+       -drive if=mtd,index=0,file=spi-nor.img,format=raw
+
+The SPI NOR image must be exactly 16 MiB. Add ``snapshot=on`` to the
+drive option to discard guest writes.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+With ``Image``, ``rootfs.cpio.gz`` and ``rk3588-rock-5b.dtb``:
+
+.. code-block:: bash
+
+   $ qemu-system-aarch64 \
+       -machine rock-5b -m 2G -smp 8 \
+       -display none -monitor none -serial stdio \
+       -kernel Image -initrd rootfs.cpio.gz -dtb rk3588-rock-5b.dtb \
+       -append "console=ttyS2,1500000n8 rdinit=/init"
+
+Limitations
+-----------
+
+The machine is TCG-only; KVM is not supported. Only the devices listed
+above are modeled, and the remaining RK3588 peripherals are unimplemented.
+Migration and VM snapshots are unsupported.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 260cd7e4d6..f195f74ce2 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -95,6 +95,7 @@ Board-specific documentation
    arm/mcimx7d-sabre
    arm/imx8m
    arm/orangepi
+   arm/rock-5b
    arm/raspi
    arm/collie
    arm/sx1
-- 
2.53.0


