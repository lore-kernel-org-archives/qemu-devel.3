Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrnE-0004w7-DM; Mon, 19 May 2025 00:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn5-0004pD-S1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrn3-0004Aj-Mu
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso2333322a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627668; x=1748232468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AzDyKx6OgyWxTzZBTwniZzUexKQarca/x+PapVXPjc=;
 b=Ymi9hx60J1t14QaqdI7xWwT5JkdDSGEcY7f/Z+G9AFwFWkLZoNBc0mnzZb2DPxh0Xu
 HTAgLRL786Xmsn16MBiSNNBkHM8vEjMWJe84TomR8JCrJdq49xjvTXPHI+UC9axBDRDF
 tsMhJvhPaV3v523CE2xzyAcGzWVoVRpRxFop+acX9WTTGq8F5RhlEIhrYyNH6tmVu6Uk
 LZlBrqQhH0NfeW6/2/l82++XylYQKagJRp9S9P/BJ1h1xHtGH3enHA0R4tyNZsuT43Jk
 D3gxPpFalxdVW9QgZIqlmsNjRQZkfYF1/kViW+FfbmahFwkxw+exwZI54H9JJt6HU9on
 lWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627668; x=1748232468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AzDyKx6OgyWxTzZBTwniZzUexKQarca/x+PapVXPjc=;
 b=i2GKdTXVmQmiWvRRjsRf3BM0uAuj0rmAthlOkVcTpqO53WXhMaZalk2vYqTdummWux
 8vDahGK7nCC5o6LJ0jvb5jD1lNovvZdGcSNpNaaFgXjKpoybK2TMVpYQZyDstJUfF0ec
 6cKrlqfxaGqMeg13uHoVbxfrQtLeTOHquUaLbnM9e9xgbawBjE6lNfGoSk8NW8oJx6zS
 HVF2BTv6ReIXhRrGj7dkDYltTB5MnJyHxmEcFBkfN2ngXK2ykVVarXKPCrv/umu6k7l8
 qfgQ+yr8o6ozP6FGl2XOXts1hquypFyBhVC7z3FQyIjJ2I8fKnHSpZCFBx0zxYYSoUFS
 l3bg==
X-Gm-Message-State: AOJu0Ywe6KheHyCcNfhOxoxSrCM7giO4SXFyA0ga4q93wdCrhEmBZQpu
 ehbrzKm1stO5uIpfXmuKmuB4xaVLJ9eMr+ohSQ+dR07gLtlsFdVU0RUz2E9UFg==
X-Gm-Gg: ASbGncuRy9B77790LSW+sIIQxPV6Y0DTlR/dCWsWM0alLHxeEl0GAl+OHJhzsPXksEN
 xhicDWrp6FNxEAqBfBI0yIZqc05FDSRzmN+4/cHjB/o4NfLsmloQSX9YtuhE0B7QQL3mwhf/IUC
 ikTS8UijMHAuH/Bmi0SFXFK1Lfsoi4kb5kHq4KurirDLDKWMPjBBAwM+TD1x1fcFiV4zdVGivZq
 6aq+CwsYWKWyC7yhXDAolXaGEjZcg5gyXqlLcsNtcvhAqrg7js7nkthsXSguVClUqQ96ra7Lyne
 EiyyvSSSb5mnrHS/n1Ntdv8qXftJwCgqyyo3DsGmNtR+Gkuf/vRYkBudv2y5eSfVwVD2P3TI5/f
 3ZobPdAbb80lIeNmjxEBM71A61Na6ow2kv+zj8iulPZ1/iYQUnQvsXIR8
X-Google-Smtp-Source: AGHT+IFnM5JL57he9gnOUOZWyRkUlh5VB8Q5b8OHNWGjqmZSXhO2mGZaPuVfK4Jyof5Vbe3NYQME+g==
X-Received: by 2002:a17:902:f706:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-231de3001cemr183769335ad.12.1747627668034; 
 Sun, 18 May 2025 21:07:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/56] hw/riscv: microchip_pfsoc: Rework documentation
Date: Mon, 19 May 2025 14:05:11 +1000
Message-ID: <20250519040555.3797167-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

Mention that running the HSS no longer works.  Document the changed boot
options.  Reorder documentation blocks.  Update URLs.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-7-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/microchip-icicle-kit.rst | 124 +++++++--------------
 1 file changed, 43 insertions(+), 81 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 40798b1aae..9809e94b84 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -5,10 +5,10 @@ Microchip PolarFire SoC Icicle Kit integrates a PolarFire SoC, with one
 SiFive's E51 plus four U54 cores and many on-chip peripherals and an FPGA.
 
 For more details about Microchip PolarFire SoC, please see:
-https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
+https://www.microchip.com/en-us/products/fpgas-and-plds/system-on-chip-fpgas/polarfire-soc-fpgas
 
 The Icicle Kit board information can be found here:
-https://www.microsemi.com/existing-parts/parts/152514
+https://www.microchip.com/en-us/development-tool/mpfs-icicle-kit-es
 
 Supported devices
 -----------------
@@ -26,95 +26,48 @@ The ``microchip-icicle-kit`` machine supports the following devices:
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
 
+The memory is set to 1537 MiB by default.  A sanity check on RAM size is
+performed in the machine init routine to prompt user to increase the RAM size
+to > 1537 MiB when less than 1537 MiB RAM is detected.
+
 Boot options
 ------------
 
-The ``microchip-icicle-kit`` machine can start using the standard -bios
-functionality for loading its BIOS image, aka Hart Software Services (HSS_).
-HSS loads the second stage bootloader U-Boot from an SD card. Then a kernel
-can be loaded from U-Boot. It also supports direct kernel booting via the
--kernel option along with the device tree blob via -dtb. When direct kernel
-boot is used, the OpenSBI fw_dynamic BIOS image is used to boot a payload
-like U-Boot or OS kernel directly.
-
-The user provided DTB should have the following requirements:
-
-* The /cpus node should contain at least one subnode for E51 and the number
-  of subnodes should match QEMU's ``-smp`` option
-* The /memory reg size should match QEMU’s selected ram_size via ``-m``
-* Should contain a node for the CLINT device with a compatible string
-  "riscv,clint0"
-
-QEMU follows below truth table to select which payload to execute:
-
-===== ========== ========== =======
--bios    -kernel       -dtb payload
-===== ========== ========== =======
-    N          N don't care     HSS
-    Y don't care don't care     HSS
-    N          Y          Y  kernel
-===== ========== ========== =======
-
-The memory is set to 1537 MiB by default which is the minimum required high
-memory size by HSS. A sanity check on ram size is performed in the machine
-init routine to prompt user to increase the RAM size to > 1537 MiB when less
-than 1537 MiB ram is detected.
-
-Running HSS
------------
-
-HSS 2020.12 release is tested at the time of writing. To build an HSS image
-that can be booted by the ``microchip-icicle-kit`` machine, type the following
-in the HSS source tree:
-
-.. code-block:: bash
-
-  $ export CROSS_COMPILE=riscv64-linux-
-  $ cp boards/mpfs-icicle-kit-es/def_config .config
-  $ make BOARD=mpfs-icicle-kit-es
-
-Download the official SD card image released by Microchip and prepare it for
-QEMU usage:
-
-.. code-block:: bash
-
-  $ wget ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz
-  $ gunzip core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz
-  $ qemu-img resize core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic 4G
-
-Then we can boot the machine by:
-
-.. code-block:: bash
-
-  $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
-      -bios path/to/hss.bin -sd path/to/sdcard.img \
-      -nic user,model=cadence_gem \
-      -nic tap,ifname=tap,model=cadence_gem,script=no \
-      -display none -serial stdio \
-      -chardev socket,id=serial1,path=serial1.sock,server=on,wait=on \
-      -serial chardev:serial1
+The ``microchip-icicle-kit`` machine provides some options to run a firmware
+(BIOS) or a kernel image.  QEMU follows below truth table to select the
+firmware:
 
-With above command line, current terminal session will be used for the first
-serial port. Open another terminal window, and use ``minicom`` to connect the
-second serial port.
+============= =========== ======================================
+-bios          -kernel    firmware
+============= =========== ======================================
+none                    N this is an error
+none                    Y the kernel image
+NULL, default           N hss.bin
+NULL, default           Y opensbi-riscv64-generic-fw_dynamic.bin
+other          don't care the BIOS image
+============= =========== ======================================
 
-.. code-block:: bash
+Direct Kernel Boot
+------------------
 
-  $ minicom -D unix\#serial1.sock
+Use the ``-kernel`` option to directly run a kernel image.  When a direct
+kernel boot is requested, a device tree blob may be specified via the ``-dtb``
+option.  Unlike other QEMU machines, this machine does not generate a device
+tree for the kernel.  It shall be provided by the user.  The user provided DTB
+should meet the following requirements:
 
-HSS output is on the first serial port (stdio) and U-Boot outputs on the
-second serial port. U-Boot will automatically load the Linux kernel from
-the SD card image.
+* The ``/cpus`` node should contain at least one subnode for E51 and the number
+  of subnodes should match QEMU's ``-smp`` option.
 
-Direct Kernel Boot
-------------------
+* The ``/memory`` reg size should match QEMU’s selected RAM size via the ``-m``
+  option.
 
-Sometimes we just want to test booting a new kernel, and transforming the
-kernel image to the format required by the HSS bootflow is tedious. We can
-use '-kernel' for direct kernel booting just like other RISC-V machines do.
+* It should contain a node for the CLINT device with a compatible string
+  "riscv,clint0".
 
-In this mode, the OpenSBI fw_dynamic BIOS image for 'generic' platform is
-used to boot an S-mode payload like U-Boot or OS kernel directly.
+When ``-bios`` is not specified or set to ``default``, the OpenSBI
+``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot an
+S-mode payload like U-Boot or OS kernel directly.
 
 For example, the following commands show building a U-Boot image from U-Boot
 mainline v2021.07 for the Microchip Icicle Kit board:
@@ -146,4 +99,13 @@ CAVEATS:
   ``u-boot.bin`` has to be used which does contain one. To use the ELF image,
   we need to change to CONFIG_OF_EMBED or CONFIG_OF_PRIOR_STAGE.
 
+Running HSS
+-----------
+
+The machine ``microchip-icicle-kit`` used to run the Hart Software Services
+(HSS_), however, the HSS development progressed and the QEMU machine
+implementation lacks behind.  Currently, running the HSS no longer works.
+There is missing support in the clock and memory controller devices.  In
+particular, reading from the SD card does not work.
+
 .. _HSS: https://github.com/polarfire-soc/hart-software-services
-- 
2.49.0


