Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4AFCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWMp-0001D9-Tm; Thu, 15 Oct 2026 21:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM9-0000QY-HR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM7-0004Hc-F9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso1060255ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112609; x=1792717409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KYL6HhtyFA793JPbUapslYIHVg6uGysVF9mZvXC7FuI=;
 b=GWjA0Nod86B+DzywHAvF8aKPROaLTaMe9U3AFftqWHaa7j3N/YZZcsS8OhS1vPVG27
 J8yMsqBMpU/sZRCDN5/Cq7wmyz7Wd0iFTcvvpwXdylsqxVGkIFltAii7fd5DIiyJJnmQ
 /KWZnBlpM+wBfIDXN3+J6g13LWUjQSZ8HdIsvs6h/JvOkISXWy2U0iRfv5cTDIwuJI3u
 lvM7eA4QgHbVWmslfZCQFZ9ETbcMQuYO0FCpN5utpaIofbRZrl4ls+VwrN301vqH1fz7
 yWKeTqoBcT/LCbVkyzAhLPHflh/UrYmvBBAZuw7sR8I95dKnYKAWu27oqKxAzqQUtAdt
 jcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112609; x=1792717409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KYL6HhtyFA793JPbUapslYIHVg6uGysVF9mZvXC7FuI=;
 b=bVSVPqAQuVLdKjeD50CJr815BhH3j4a2E9AeVy5TrkzxioeWAtKoqTnoLT+idE6Dny
 HW6l+HPlYzQKRheCNfKEaj2Y0mHD5jISIS//bpI6kGz87rWaMDu3iZpMzZslxyaRPMqy
 e41x/RZlL0SaW+ITdbb4liI+8j3tsxGIemuQoQooswjcmWmuoAwm3xt4RVJCA0r2cl9i
 KmTYwy8rLKjJNBjSKY4eivSxk3o1PwtebsyRqBsQPpS00HrIi7EQ0h3DNxVXtfJA86fU
 hVn2r8uPLQ6dlyGG47FLXbkWCBf1ZFJqKL08FZOpiYQNse33Xri9LQbKCNqoeghpdeuf
 gSew==
X-Gm-Message-State: AFq9FYLDo7yDLld7WFD/ft5zx8EBxc2iJJc9G72ig2vs5Bg5pNRDQaDY
 BU55jCX2lU45xeXwTJsX0p07JxtqTQOK4E5o91jVhGOvzbGgLF3Yy6wb7SZc7A==
X-Gm-Gg: AYBFou1gpalsr7tE9+R204/z2cr502xkeYUi8ctu9hjEYIhrptsDse+TSug5bikxx0m
 otX13dJvP69z6x8mIQ39LdTaTo5nn9TFoOor6H3Yq6SbSghDDV3+KTiLLH6+WOZDBUd/h5moruT
 RjJjxXhxEr/cz8IiHncDL+UgSTgtwXB1/AsrwsThtKM/3cdJf86cQIz5BrclTXxo+6Of3OVfpg1
 V+Vq+b7kzYhlZIqb/iJrZpa9lJQuR0+nYne1Q67ygWufhgtKSRa/U6KpcIxfvvhCw+xdV9cYIgY
 cKj8O6XU4YIzlIR2uRIbCbGEHTLaoLYqTJGIg5po3nDY8c51yiZcmeL9gjJ7JDcJ+HfNnWVQ1J+
 I7mXFmSu7hSbcgzo99mg4Bt/WyX9mizjQBfyBmxZ5o1AS/LkUbUp9WCs9iO7KD/Nw38m1L/C0EU
 xbUFoaGmWdEfGQ+YOVwVqIupzC2KU+mau/dZzcSsaqSGXm3ISlw3xC7xAvDyR5qvFcUv2NuXMrJ
 W4xCG5DMcMwA1Oc
X-Received: by 2002:a17:902:ecd0:b0:2e4:4eed:5cc5 with SMTP id
 d9443c01a7336-2e842cd23b1mr193985115ad.38.1792112609199; 
 Thu, 15 Oct 2026 18:03:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/50] docs/system/riscv: Add Milk-V Duo board documentation
Date: Fri, 16 Oct 2026 11:02:02 +1000
Message-ID: <20261016010237.1102834-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add documentation for the Milk-V Duo board. This includes a brief
overview of the hardware, a list of supported devices, and practical
instructions on how to boot the machine using OpenSBI and a Linux
kernel with an emulated SD card.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260927201326.650943-8-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                     |  1 +
 docs/system/riscv/milkv-duo.rst | 49 +++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst    |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/riscv/milkv-duo.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index a8751210ac..b912e4b8d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1874,6 +1874,7 @@ F: tests/qtest/k230-decomp-gzip-test.c
 Milk-V Duo
 M: Kuan-Wei Chiu <visitorckw@gmail.com>
 S: Maintained
+F: docs/system/riscv/milkv-duo.rst
 F: hw/misc/cv1800b_clk.c
 F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
diff --git a/docs/system/riscv/milkv-duo.rst b/docs/system/riscv/milkv-duo.rst
new file mode 100644
index 0000000000..1758db2c1e
--- /dev/null
+++ b/docs/system/riscv/milkv-duo.rst
@@ -0,0 +1,49 @@
+Milk-V Duo board (``milkv-duo``)
+================================
+
+The ``milkv-duo`` machine is compatible with the Milk-V Duo development board.
+
+The Milk-V Duo is an ultra-compact embedded development platform based on the
+Sophgo CV1800B SoC. The CV1800B features T-Head C906 RISC-V processing cores
+along with integrated peripherals.
+
+For more information, see <https://milkv.io/duo>
+
+Supported devices
+-----------------
+The ``milkv-duo`` machine supports the following devices:
+
+* T-Head C906 cores
+* Core Local Interruptor (CLINT)
+* Platform-Level Interrupt Controller (PLIC)
+* DesignWare APB UART (dw8250)
+* SDHCI controller
+* CV1800B clock controller
+
+Boot options
+------------
+The ``milkv-duo`` machine supports direct boot using a generic RISC-V OpenSBI
+firmware and a Linux kernel. The root filesystem can be provided via the
+emulated SD card.
+
+Running
+-------
+To boot the machine, you need a Linux kernel (built with CV1800B support), a
+device tree blob (DTB), and a root filesystem image (e.g., built via BusyBox
+or Buildroot).
+
+Use the following command to boot the system directly to the Linux shell:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M milkv-duo -nographic \
+      -bios pc-bios/opensbi-riscv64-generic-fw_dynamic.bin \
+      -dtb /path/to/linux/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dtb \
+      -kernel /path/to/linux/arch/riscv/boot/Image \
+      -drive file=/path/to/rootfs.ext4,format=raw,id=sd-card \
+      -device sd-card,drive=sd-card \
+      -append "console=ttyS0,115200 root=/dev/mmcblk0 rootwait earlycon"
+
+This command boots the generic OpenSBI firmware, loads the Linux Image and the
+specified DTB, and mounts the ext4 root filesystem from the emulated SD card.
+The console output is routed to the ``ttyS0`` serial port.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 2639866a3e..1e49055e29 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -69,6 +69,7 @@ undocumented; you can get a complete list by running
    riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
+   riscv/milkv-duo
    riscv/mips
    riscv/shakti-c
    riscv/sifive_u
-- 
2.55.0


