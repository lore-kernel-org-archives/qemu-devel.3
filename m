Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2016606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=HHUeXT2P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2tg-0000Q6-Eq; Tue, 24 Nov 2026 21:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2tB-0000EO-IG
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t6-0007JB-Mj
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:41 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b4d86f5328so35996847b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574255; x=1796179055; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LOUfIjat+MroaKY2x0Bigjz50tx25K856bVnBvDhOOw=;
 b=HHUeXT2Py3434QYMbBYZUviCEYZjg7vIjf/DN/zxrl+A6A7jzNFdiVn0l96LWqSM79
 jEG15gBS/UECPNBh8yKwpDF0BW85MzRkXNvZshYNjtrUEO10HhbzTio2TdVB9RHR+XJR
 9SBk24v4AZQ41jU2u2u5bltUJklgGGWKWCgKxlno+OS3eLKPtKblJCvUJ9PViCX0o55c
 lc3Ni1jLpvQtwyakYOzuVVA+b5cOt/49sVqiEKNJaGh3SHX2s7kJKUXuzlMdvwPNFdeU
 UHBQxISRRrFMgcOrglfrmumXNoqoj4Cury5ZfyCl2GFkI9RxZs2Rf4Xrj64K+00F6bBB
 aPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574255; x=1796179055;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LOUfIjat+MroaKY2x0Bigjz50tx25K856bVnBvDhOOw=;
 b=SPIZ5CX6ZzdS22rOY3B3h0sUab8mgb8shY/TRwKKC5BDSFvyPyC5rF918hKoDyHn6U
 1k4CD00fe9kUJ0768uIhUcALSwXiFjAZqR5gH14f2tmQySRrA7hkJo2m90P9FKNfCdne
 YaxxjY15WNNaCsEqVcLgzdss8XpaN7NhWKfKnuGtK1YrB+XfIvoIvvV9YJFaWcyNAuBN
 ZRCnYnriLTuC6xLvAUDNloooHa4Numh1PDPoaKMnKrh9YapXNy6jwZarUOfVux2IRwxf
 TH254SgRFRYd0qIAfYI8c/oGvElQG7suluQBAT7+bBCnG8W3VkXTv38Ne+DhTVgUTfnU
 NCvg==
X-Gm-Message-State: APuU4Z8+T2a1P8Ird6O3DLxEWe9L1JUkYCy5VbuiZ+cymFt8l/r0knkt
 zZBaFYLNds9t9OiJZuAXPUXimLgUdwVfXnNHno+0cXuyPD+QeKo3LifzQwxj2OG/EC8=
X-Gm-Gg: AZFdTZeWm+qoUvfuaBTMZNvOTehtTUdYrexgZWQqyTp8Xx3VVxDE9deEbwAqW4SG0jb
 Ygg8ukltevHQCXr5DQ4kaF8UnSdJGxEsueTnkppJfgztdqY3GuTtePSK2jxBuCHyiXg610WR0J7
 7Ri3pqpeCoiZhYGtLh37AwA7oph/Tdbj/g3S5aitbVJ2yiv2RMmp58s5fdSaHqiXbaIc7+i74HG
 ALgDDxj1CAMAaQ/IDsSyrRiLPr+R1NEF9zCUXd3Y/YYa/wSx4YoCFCUApPeQbgB2fDY2rNaY/FE
 vlRX2BOccsOaeXBNns7K/ne8N+ruDWOu/dg+2NlWGe4c+4rCoAJmrSdb4PjDT1DdLGJiDy5felu
 cN+g0pxWwwPG+NeH2jYYaXKNkLc37pSBDKBY84Jn/y2zHV9Yl2H6AxnU1qSpOc3iZlINoEeTBWi
 M6U9GdfFPorO3s4SVHPV0mNJARJvCbsNUo3uSa3Q4ISwRO6thIIwXKOYsqzQ8Kq/KqJFo5A87QZ
 Mr3bAW4/x6xFWookT2IlExY/MEe5uxYuEC6dle95ujk8twTfghi7cSuxzp8HoG+S9u7c5fsMkCn
 Dap6mwmEGWWwvpa3TUQPfKJiQ60VdTy32c9vd1sYrJrcFE23sSowYiUVnhiHzX5Ys4hy7A+4bgl
 Pv1smX+qZPyETYQI+diGqZS7Yd4/Yuw==
X-Received: by 2002:a05:690c:48c3:b0:8b4:c1ef:79d2 with SMTP id
 00721157ae682-8b5204bc1bfmr65090937b3.40.1795574255341; 
 Tue, 24 Nov 2026 18:37:35 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:34 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:27 -0600
Subject: [PATCH 8/8] docs: Document spacemit-k3 machine
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-8-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document spacemit-k3 machine, how to build boot media for it and
how to boot it using the different boot modes it supports.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 MAINTAINERS                       |   1 +
 docs/system/riscv/spacemit_k3.rst | 259 ++++++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst      |   1 +
 3 files changed, 261 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0227d92be2..5c2ce76516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1858,6 +1858,7 @@ Spacemit Machines
 M: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: docs/system/riscv/spacemit_*.rst
 F: hw/misc/spacemit_*.c
 F: hw/riscv/spacemit_*.c
 F: hw/ssi/spacemit_*.c
diff --git a/docs/system/riscv/spacemit_k3.rst b/docs/system/riscv/spacemit_k3.rst
new file mode 100644
index 0000000000..5d5bbda84f
--- /dev/null
+++ b/docs/system/riscv/spacemit_k3.rst
@@ -0,0 +1,259 @@
+Spacemit K3 (``spacemit-k3``)
+======================================
+
+The Spacemit K3 is a RISC-V SoC from Spacemit, containing 8 RVA23 compliant
+X100 cores, 8 A100 cores with large vector len (1024), a real-time cpu (RCPU)
+and RISC-V AIA.
+
+The ``spacemit-k3`` QEMU machine can be used for firmware and OS development.
+This machine supports the same boot paths that real hardware does and can
+serve as a tool to test firmware images without access to hardware. It is
+possible to boot U-Boot SPL, OpenSBI and U-Boot/EDK2. While it is possible
+to boot Linux (UART works with a defconfig kernel + busybox initrd), many
+of the peripherals that Linux exercises aren't modelled yet.
+
+spacemit-k3 QEMU model features
+-------------------------------
+
+* 8 Spacemit X100 Cores
+* RISC-V compliant Advanced Interrupt Architecture
+* 16550A compatible UART
+* Syscon/Clock Controllers
+* 1 QSPI Controller with NOR Flash
+* 2 SD and 1 EMMC Controllers
+* 1 UFS Controller
+
+Known limitations
+-----------------
+
+The 8 A100 cores and the Realtime CPU on the K3 SoC are not modelled.
+I2C, Networking and PCIe are not modelled.
+
+Bootrom
+-------
+
+The spacemit-k3 machine optionally accepts a bootrom binary dumped
+from hardware via ``-bios``. If this file is supplied, the machine starts
+executing this, just as real hardware would. The bootrom can be dumped
+following `this <https://gist.github.com/asrinivasanTT/4498e3b37015cd5c6e8ca6641c2a3340>`_
+guide.
+
+In case the bootrom is not supplied, a fallback loading method is implemented.
+Look for more details at the end of the next section.
+
+Boot Modes
+----------
+
+The spacemit-k3 machine accepts a boot-mode machine property ``-M spacemit-k3,boot-mode=nor``
+that determines which boot media the bootrom loads the next boot stage from.
+This argument can be set to one of the following options:
+
+1. ``boot-mode=emmc`` - SD -> EMMC -> XMODEM
+2. ``boot-mode=nor`` - SD -> NOR -> XMODEM
+3. ``boot-mode=nand`` - SD -> NAND -> XMODEM
+4. ``boot-mode=ufs`` - SD -> UFS -> XMODEM
+5. ``boot-mode=usb`` - USB FASTBOOT
+6. ``boot-mode=uart`` - UART XMODEM
+
+All boot modes try SD first. ``boot-mode=nor`` is the default option. At the
+moment, the spacemit-k3 machine doesn't support NAND flash and USB, so those
+boot methods aren't supported.
+
+If a bootrom isn't supplied via ``-bios``, qemu loads the next stage from boot
+media in the same manner as the bootrom would, trying to load from one boot
+medium and falling back to the next if it fails to. Only the ``emmc``, ``nor``
+and ``ufs`` boot methods are supported in this case. The xmodem fallback for
+these methods isn't implemented either.
+
+
+Building Firmware Binaries from Vendor BSP
+------------------------------------------
+
+1. OpenSBI: A bug in vendor OpenSBI causes writes to an out of bound address
+and results in store faults. We need to patch 3 lines to use it
+
+.. code-block:: bash
+
+	$ git clone -b k3-br-v1.0.y https://github.com/spacemit-com/opensbi/
+	$ cd opensbi
+	$ # Patch out of bound writes
+	$ sed -i 's|^\([[:space:]]*\)\(cci_enable_snoop_dvm_reqs([456]);\)|\1// \2|' platform/generic/spacemit/spacemit_k3.c
+	$ CROSS_COMPILE=riscv64-unknown-linux-gnu- PLATFORM_RISCV_XLEN=64 make O=build PLATFORM=generic PLATFORM_DEFCONFIG=k3_defconfig BUILD_INFO=y -j$(nproc)
+	$ # Enable logging and rebuild
+	$ KCONFIG_CONFIG=build/platform/generic/kconfig/.config OPENSBI_PLATFORM_SRC_DIR=./platform/generic OPENSBI_SRC_DIR=./ OPENSBI_PLATFORM=generic ./scripts/Kconfiglib/setconfig.py ENABLE_LOGGING=y
+	$ CROSS_COMPILE=riscv64-unknown-linux-gnu- PLATFORM_RISCV_XLEN=64 make O=build PLATFORM=generic BUILD_INFO=y -j$(nproc)
+
+2. U-Boot
+
+.. code-block:: bash
+
+   $ git clone -b k3-br-v1.0.y https://github.com/spacemit-com/uboot-2022.10/
+   $ cd uboot-2022.10
+   $ make k3_defconfig
+   $ CROSS_COMPILE=riscv64-unknown-linux-gnu- make -j$(nproc)
+
+This produces 4 files ``bootinfo_block.bin``, ``bootinfo_spinor.bin``,
+``FSBL.bin`` and ``u-boot.itb``.
+
+3. EDK2: EDK2 can be used instead of U-Boot. You'll still have to use the FSBL
+and bootinfo from U-Boot.
+
+.. code-block:: bash
+
+	$ git clone -b k3 https://github.com/spacemit-com/edk2.git
+	$ git clone -b k3 https://github.com/spacemit-com/edk2-platforms.git
+	$ git -C edk2 submodule update --init
+	$ git -C edk2-platforms submodule update --init
+	$ export WORKSPACE=$PWD
+	$ export PACKAGES_PATH=$WORKSPACE/edk2:$WORKSPACE/edk2-platforms
+	$ export GCC5_RISCV64_PREFIX=riscv64-unknown-linux-gnu-
+	$ source edk2/edksetup.sh
+	$ make -C edk2/BaseTools
+	$ build -a RISCV64 -t GCC5 -b RELEASE -n $(nproc) -p Platform/Spacemit/K3/MUSE-Pico/MUSE-Pico.dsc
+
+This will produce a ``fitimage/MUSE-Pico/MUSE-Pico.itb``. Use this instead of
+``u-boot.itb``.
+
+Building Firmware Binaries from Upstream Sources
+------------------------------------------------
+
+While upstream OpenSBI is a drop-in replacement for vendor OpenSBI, support in
+upstream U-Boot is limited at the moment. The U-Boot build can only be loaded
+via YMODEM via U-Boot SPL. Build instructions for U-Boot will be added once
+support is more stable.
+
+1. OpenSBI
+
+.. code-block:: bash
+
+	$ git clone https://github.com/riscv-software-src/opensbi/
+	$ cd opensbi
+	$ CROSS_COMPILE=riscv64-unknown-linux-gnu- PLATFORM_RISCV_XLEN=64 make O=build PLATFORM=generic PLATFORM_RISCV_ISA=rv64gc FW_TEXT_START=0x100000000 BUILD_INFO=y -j$(nproc)
+	$ pushd build/platform/generic/firmware
+	$ wget https://github.com/spacemit-com/opensbi/raw/refs/heads/k3-br-v1.0.y/platform/generic/spacemit/fw_dynamic.its
+	$ mkimage -f fw_dynamic.its fw_dynamic.itb
+
+This should produce a ``build/platform/generic/firmware/fw_dynamic.itb``. This
+can replace the ``fw_dynamic.itb`` from vendor OpenSBI.
+
+Booting with firmware on NOR Flash
+----------------------------------
+
+Creating an image
+
+.. code-block:: bash
+
+	$ truncate -s 8M nor.img
+	$ dd if=bootinfo_spinor.bin of=nor.img bs=1 seek=0 conv=notrunc status=none
+	$ dd if=FSBL.bin of=nor.img bs=1 seek=$((0x20000)) conv=notrunc status=none
+	$ # esos at 0xb0000 is skipped as it is not needed
+	$ dd if=fw_dynamic.itb of=nor.img bs=1 seek=$((0x1b0000)) conv=notrunc status=none
+	$ dd if=u-boot.itb of=nor.img bs=1 seek=$((0x210000)) conv=notrunc status=none
+
+
+To boot the image
+
+.. code-block:: bash
+
+	$ ./build/qemu-system-riscv64 -M spacemit-k3 \
+		-nographic -drive if=mtd,format=raw,file=nor.img
+
+Booting with firmware on SD/EMMC/UFS
+------------------------------------
+
+Creating an image
+
+.. code-block:: bash
+
+	$ truncate -s 32M sd.img
+	$ echo 'label: gpt' | sfdisk sd.img
+	$ dd if=bootinfo_block.bin of=sd.img bs=1 seek=$((0x100000)) conv=notrunc status=none
+	$ dd if=FSBL.bin of=sd.img bs=1 seek=$((0x180000)) conv=notrunc status=none
+	$ # esos at 0x400000 is skipped as it is not needed
+	$ dd if=fw_dynamic.itb of=sd.img bs=1 seek=$((0x700000)) conv=notrunc status=none
+	$ dd if=u-boot.itb of=sd.img bs=1 seek=$((0x800000)) conv=notrunc status=none
+
+
+To boot the image with SD,
+
+.. code-block:: bash
+
+	$ ./build/qemu-system-riscv64 -M spacemit-k3 \
+		-nographic -drive if=sd,format=raw,file=sd.img,index=0
+
+To boot with EMMC, use ``-M spacemit-k3,boot-mode=emmc`` to set the boot mode
+and attach the image to the EMMC controller via ``if=sd,file=sd.img,index=2``.
+
+To boot with UFS, use ``-M spacemit-k3,boot-mode=ufs`` to set the boot mode and
+attach the image to the UFS controller via ``if=scsi,file=sd.img``.
+
+Rootfs on UFS
+-------------
+
+Most Spacemit K3 boards boot with the boot firmware on NOR flash and rootfs on
+UFS.
+
+The UFS image for this must be built with a block size of 4096. Most pre-built
+distro images off the internet are built with a block size of 512 and aren't
+compatible.
+
+To build an UFS image with a rootfs,
+
+.. code-block:: bash
+
+	$ truncate -s 8G ufs.img
+	$ # Attach this image to a loop device
+	$ sudo losetup --sector-size 4096 -fP --show ufs.img
+	$ # Loop device /dev/loopN
+	$ sudo sfdisk /dev/loopN <<EOF
+	label: gpt
+	start=2048, size=131072, type=uefi,  name=ESP
+	size=, type=linux, name=rootfs
+	EOF
+	$ # Create filesystems
+	$ sudo mkfs.vfat -F 32 -S 4096 /dev/loopNp1
+	$ sudo mkfs.ext4 -b 4096 /dev/loopNp2
+	$ # Mount partitions
+	$ sudo mkdir -p /mnt/k3/ /mnt/k3/boot/efi
+	$ sudo mount /dev/loopNp2 /mnt/k3/ && sudo mount /dev/loopNp1 /mnt/k3/boot/efi/
+	$ # Copy over rootfs/ESP to /mnt/k3/
+
+To boot with this UFS image,
+
+.. code-block:: bash
+
+	$ ./build/qemu-system-riscv64 -M spacemit-k3 \
+		-nographic -drive if=mtd,format=raw,file=nor.img \
+		-drive if=scsi,format=raw,file=ufs.img
+
+
+If you want to use the UFS image to store both the boot firmware and the
+rootfs, write the boot firmware binaries to the SD/EMMC/UFS offsets, then
+follow the steps in this section, substituting the start LBA of the ESP to a
+higher value like 4096 so that the first 16MB is free for the firmware
+partitions.
+
+Booting from XMODEM
+-------------------
+
+The Spacemit K3 bootrom implements UART boot via XMODEM as a fallback in case
+none of the boot media has a valid U-Boot SPL on it. This can be used in QEMU
+if you supply the bootrom via ``-bios``. You can boot the ``FSBL.bin`` from
+vendor U-Boot, or any M-mode payload wrapped in the header that vendor U-Boot
+wraps U-Boot SPL in using this method.
+
+To boot the ``FSBL.bin`` from the vendor U-Boot via XMODEM,
+
+.. code-block:: bash
+
+	$ ./build/qemu-system-riscv64 -M spacemit-k3,boot-mode=uart \
+		-bios k3.bin -nographic -serial pty
+	# QEMU prints a /dev/pts/N
+
+In a separate terminal,
+
+.. code-block:: bash
+
+	$ picocom -b 115200 --send-cmd sx /dev/pts/N
+	# Ctrl-A + Ctrl-S
+	# Select FSBL.bin to send
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index cc0ef4b64f..d38ad98642 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -74,6 +74,7 @@ undocumented; you can get a complete list by running
    riscv/riscv-server-ref
    riscv/shakti-c
    riscv/sifive_u
+   riscv/spacemit_k3
    riscv/tt_atlantis
    riscv/virt
    riscv/xiangshan-kunminghu

-- 
2.43.0


