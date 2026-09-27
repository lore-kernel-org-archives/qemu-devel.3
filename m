Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7444ACA5FA4
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvGW-0000JM-Fs; Sun, 27 Sep 2026 16:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGT-0000I0-Qg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:25 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xAvGR-0003aF-Qg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:14:25 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so933821a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790540062; x=1791144862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=96SiFbVYD8apnRQj28w96i7aN7o9LA5MwEa3NqgqTVA=;
 b=kevtGqM10yk2zu2pFBDS88B/d11d0Mg6lRDc74SP4RRB5WXFk0sZof85PmgkDLdrsv
 FZ44+UiLfCgvT+ywcqskZ4eUO/UlTz7EobP7NZpgJd37QoH5mjFC0EFl+KHExCI6mO5S
 nUCoe9TFDTmL7Fxn/x45kcjzY0AJpUzGFnZdnBkf+oeMrnJ2RToQgSRPrY5ijN0yPeJ0
 A5B04cy9artN7j5HHZAXXiS/04JTC1JPGphNDzrhRLyXP+1VLSYT0KvtjQ8ZoY8ylx/x
 niAUSM29Hvvx6HZThnzL/vpNzBrJGgTs9tpDsnFFgDQTVcG8FCpWN7zZa1Nl4pDmePnk
 nEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790540062; x=1791144862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=96SiFbVYD8apnRQj28w96i7aN7o9LA5MwEa3NqgqTVA=;
 b=Kfjs+x+JWLThlAhYNEeBSxLtSa99Bi/tbYxiSnS3K6p7+ai4ULTzTlflqaGVBzuTLK
 9bgzI1azLZMznk2Vsf3h1yDFfbenk/lpjIg488EJV/LAXjpLF3HpC3jRqmLaNROJ6ToT
 vPWlhMJ3oEX5bkcSR0DAGh3iLq6ZQw+qLC4/E5Twi0DyddKQyyTh4fXtQWPJga9HnV/3
 Iyfxz4AAVg8eHTYdHboVge+VIogQtGc0abF8CtP8/Ools5GvsNQtGrDk/rhkHZ7WtSKx
 dZgd/dUFvANeb9JODUDRDZ1/Vx2YMcet6NM4wn0U/ZTRg5VaN3zIZgfgPL6lTkgl7QLS
 evuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByjtLdyh7HTL32B1z1f+/G7PrR2yg6a+5D6m5qt7AdzoqAoopA++KvtkYlYWo9xWXot0uU1lUI0SWR8@nongnu.org
X-Gm-Message-State: AFq9FYJ7pzCndCbduThvsdoN0sn1JqtT3y0zQPn2G/y+0LE5lKOFjStO
 g68YltOEORhpPCiatc+c6hlPlzp8SamOCs5gifRmOH0+AN5IgOxaB6Hg
X-Gm-Gg: AYBFou2Xif/V7T6FKu8NPkY7BH9UQ+T5g82D4Lz7q05GmyIGarc4ka400NbC3rptT6j
 nBbq2ByloKdx4z17akzLnOWNLCZrj180pKzsvTOS/VQhIBPvElBodyv2XbfWZMAmQvPNliOrXB5
 Cc66S+LfQ+S34DDRAgd4dOteaT7GyeHvTng/5pu1rxqerLSKqtbVWi2tE1jaog339mO8OCCOQqR
 eQEU/U+bZrABAsDUDlCbaECyLfNviAFA25+jYsOczCUAh0K9/tRA/0SK5awWaqGHoU4C7HANz32
 Rirp+krARncfHqoxD/76rFpWQ+Zgy/z4UPZF7L1l47Pa+yoWJKVdtzXfh6POu/WpIvcIpaWo+9d
 ACirfXhUfmbJePDDVierSvQ4lrBbgHCy/6ZI4qkfattEXVtYX7Q6L0iHiQS0ZcB4/+g97Vk21y0
 AH66IuSGRZOabZTIvWpK1qWBm+L8RuCaQyoRq65jJL3esmNzrfh+jcb1IrK2s/dPBAepSVXE05N
 VQwechdzHq49EqKLyaQy41qEjlWXgSR56X4T9eN7U5CGBr3yFn0HjLwMO4+FYVUkfSkj+HS0dVP
 t63J5U03
X-Received: by 2002:a17:90a:e7cf:b0:3a4:6e84:e7ee with SMTP id
 98e67ed59e1d1-3a46e84e9f0mr404430a91.16.1790540062457; 
 Sun, 27 Sep 2026 13:14:22 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c719f86fsm13932737a91.7.2026.09.27.13.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 13:14:22 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 portias@oss.tenstorrent.com, wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw,
 marscheng@google.com, eleanor15x@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 7/7] docs/system/riscv: Add Milk-V Duo board documentation
Date: Sun, 27 Sep 2026 20:13:26 +0000
Message-ID: <20260927201326.650943-8-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260927201326.650943-1-visitorckw@gmail.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=visitorckw@gmail.com; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add documentation for the Milk-V Duo board. This includes a brief
overview of the hardware, a list of supported devices, and practical
instructions on how to boot the machine using OpenSBI and a Linux
kernel with an emulated SD card.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                     |  1 +
 docs/system/riscv/milkv-duo.rst | 49 +++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst    |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/riscv/milkv-duo.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 689424fd1c..027139bde2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,6 +1875,7 @@ F: tests/qtest/k230-decomp-gzip-test.c
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
2.56.0.rc1.315.gc6ed9934b7-goog


