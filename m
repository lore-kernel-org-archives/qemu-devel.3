Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB7CCD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk0-0000Aq-1t; Tue, 16 Jun 2026 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjq-00089U-53
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:46 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjn-00046w-RZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8584e80bd9so1646153a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604582; x=1782209382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXWOnEtF/0/IAhq675fj/v8UPIe82YgPSMA/HkHI4VY=;
 b=gaeS8J05WZ+LaFF9W8ka/jo3FbZMST/KHlkU0SLHYvbvUNE2/uqM2oaecQVjYllo7j
 w7plKAEvgAGRmtfAY11AIqqNUSYevMZwd3GnTrT3IL0mPkFv7sc0FUHXlizT7FHprOdl
 rxonvBUqDWwMXk5DPhNlLyz6eI8S29E5Jsi8eLiLXlJoJIwlkcmUJQ4Ibh8v0RLq100A
 vMK/KlfNvYjjFe8oOztM0JOahnEh4/vIaKIKs2iWYtNk415CvahglovtpsdaORdSy5cF
 loSRF8q+3oTQfypCo7esUjccrOeBo1cwEULdQP8Eg19HI5M7TyAdlrpLg6VOE85+U0Um
 JVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604582; x=1782209382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXWOnEtF/0/IAhq675fj/v8UPIe82YgPSMA/HkHI4VY=;
 b=KpeQrv8MjAMoeotZx/kGM1i1ElcGevkzwKTNAxNtEhIbPwqFcwAk2fO5zKyDhvQzPa
 t927ogIL9jCUIQpYxnC4xYBga+B0Rz8XVRBS8cQabBhUmgjtdZIkE8/RUim9DOjO2o+6
 ArdpWVXdSFIwihedR07IzH0+esSebPbM/OpcVktK6VsG0Wk2Bie4RR3GItHBQmoa9qD8
 55AUS1r6ibL1JnPibRZitZvqouFG5V3vIya6Ph4Q+WYZvM3j+uYCcL5lf335fj/fPW1G
 j9SqLnnvR4RsS6E+q5eTz2930x2HebQGKbHnWSNFF1472p3XODaNhPLym+l2U2g64QMK
 do3Q==
X-Gm-Message-State: AOJu0YxGHR3ebyXqFM/neNqmVCcIVFqlCBW2EGHkGwvWrCdg2WJJcEWH
 VoqkRBo98GO6QaZJ67kv7T31wf9QcThp552B59nMXc1Yosb5gC5+nIkZ21OVQYip
X-Gm-Gg: Acq92OHo22YDd3IZzLyQeYvhl74L5OwFtS1+lg9WQfGrJoW8bhNUWwLLsWkrCiLZVuz
 wRv2z3lOTL4rEBOvPRWSENLzPGIbJlrtOfYxK0DzZZ+zuZOoID0muhJ99Vv24nC8Jf1y6HPnQ3m
 7icSq8ZqiBzClv7UO6GXogpnMmH79vyp2UUUZpeNjRVq6F+Ccm2SjNBsJdya1I7w6EK6hQ0dfA5
 d8KmtanrHhcaUOHLIPjoQ49sdE+KRP6901+PmQWUVPQ3q/CGawSdMOBw1V3pXEx57q18FctpCvC
 fi9EGZNh+XySrXm/6kDRvYZdyRAmcjM3J6s/9yRLmLm6LsjIJeYIZq28T3TxjBgSkQkDCpJHUYM
 65PbppShn+StGwHP+FURSc4kAmfudW5F5CCU/bXFvjjgzTwoln5snpl9mb0Lb0VshITuTzCbL7a
 Yf5VurrbiFrc0uszAFnAPm/na9E5kRes2v+noqdKME
X-Received: by 2002:a05:6a20:3d82:b0:3b4:bdd5:2f8 with SMTP id
 adf61e73a8af0-3b7e4d5c9e2mr2998968637.38.1781604582466; 
 Tue, 16 Jun 2026 03:09:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 70/83] docs/system/riscv: add documentation for k230 machine
Date: Tue, 16 Jun 2026 20:05:13 +1000
Message-ID: <20260616100527.1939565-71-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <81d2e2fa42ecabf638f841321cf36cee8f10af01.1781246408.git.chao.liu@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                  |   1 +
 docs/system/riscv/k230.rst   | 113 +++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |   1 +
 3 files changed, 115 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 44654b5798..4fc073b7ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,6 +1790,7 @@ K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..cea8202e55
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,113 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with the Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores (little core)
+* Core Local Interruptor (CLINT)
+* Platform-Level Interrupt Controller (PLIC)
+* 2 K230 Watchdog Timer
+* 5 UART
+
+Boot options
+------------
+The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
+starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
+
+K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
+does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
+built with standard RISC-V PTE bits before they can boot under QEMU.
+
+Running
+-------
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+This flow lets QEMU load OpenSBI, Linux, initrd, and DTB directly, without
+running SDK U-Boot. The Linux Image must be rebuilt with standard RISC-V PTE
+bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ qemu-system-riscv64 -machine k230 \
+      -kernel "$SDK/images/little-core/Image" \
+      -dtb "/tmp/user-k230-qemu.dtb" \
+      -initrd "$SDK/images/little-core/rootfs.cpio.gz" \
+      -append "console=ttyS0,115200 earlycon=sbi cma=0" \
+      -nographic
+
+Direct boot uses the SDK little-core RAM layout for OpenSBI at
+``0x08000000``, Linux at ``0x08200000``, and the DTB at ``0x0a000000``. The
+initrd is placed by QEMU's generic RISC-V boot helper, and QEMU writes the
+initrd range and kernel command line into ``/chosen``. The DTB passed with
+``-dtb`` should be derived from ``$SDK/images/little-core/k230.dtb`` and must
+describe that initrd location as usable memory and disable any devices that are
+not emulated by this machine.
+
+U-Boot boot
+~~~~~~~~~~~
+
+This flow starts SDK U-Boot in M-mode with ``-bios``. Until the SDK storage
+path is modeled, place OpenSBI, Linux, initrd, and DTB in RAM with loader
+devices and run ``bootm`` manually. The Linux Image must be rebuilt with
+standard RISC-V PTE bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ IMAGE=$SDK/images/little-core/Image
+   $ INITRD=$SDK/images/little-core/rootfs.cpio.gz
+   $ DTB=$SDK/images/little-core/k230.dtb
+   $ FWJUMP_UIMAGE=/tmp/k230-fw-jump.uImage
+   $ INITRD_END=$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$INITRD"))))
+   $ "$SDK/little/buildroot-ext/host/bin/mkimage" \
+      -A riscv -O linux -T kernel -C none \
+      -a 0x8000000 -e 0x8000000 -n opensbi \
+      -d "$SDK/images/little-core/fw_jump.bin" "$FWJUMP_UIMAGE"
+   $ qemu-system-riscv64 -machine k230 \
+      -bios "$SDK/little/uboot/u-boot" \
+      -device loader,file="$FWJUMP_UIMAGE",addr=0xc100000,force-raw=on \
+      -device loader,file="$IMAGE",addr=0x8200000,force-raw=on \
+      -device loader,file="$INITRD",addr=0xa100000,force-raw=on \
+      -device loader,file="$DTB",addr=0xa000000,force-raw=on \
+      -nographic
+
+The loader addresses mirror the SDK ``k230_canmv_defconfig`` output. Read the
+U-Boot addresses from the generated environment, and read the Linux RAM base
+from the generated ``hw/k230.dts.txt``. This replaces the SDK storage and
+decompression steps.
+
+Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
+
+.. code-block:: bash
+
+   K230# setenv bootargs console=ttyS0,115200 earlycon=sbi cma=0
+   K230# fdt addr 0xa000000
+   K230# fdt resize 8192
+   K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
+   K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
+   K230# fdt set /soc/sdhci0@91580000 status disabled
+   K230# fdt set /soc/sdhci1@91581000 status disabled
+   K230# bootm 0xc100000 - 0xa000000
+
+Use ``setenv`` so ``bootm`` writes the kernel command line into
+``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
+edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
+this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
+with the host-calculated value above when typing the command. ``cma=0`` avoids
+the SDK kernel reserving too much of the little-core memory window for initramfs
+boot.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index afd86ca2ba..896f14e78b 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips
-- 
2.54.0


