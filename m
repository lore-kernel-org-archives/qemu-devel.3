Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F3AC021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmjEV-0003AU-V8; Mon, 24 Feb 2025 19:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE9-00031c-3e; Mon, 24 Feb 2025 19:55:14 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE6-0004qL-6g; Mon, 24 Feb 2025 19:55:12 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE4-000HPj-1o; Tue, 25 Feb 2025 01:55:08 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjE4-0009qK-2F; Tue, 25 Feb 2025 01:55:08 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id C341C48005D;
 Tue, 25 Feb 2025 01:55:07 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hg3HWs0rej5Q; Tue, 25 Feb 2025 01:55:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 4848E48005B;
 Tue, 25 Feb 2025 01:55:07 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id E_aU0qZ5NuuB; Tue, 25 Feb 2025 01:55:07 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 95A9C48005D;
 Tue, 25 Feb 2025 01:55:05 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2 6/6] hw/riscv: microchip_pfsoc: Rework documentation
Date: Tue, 25 Feb 2025 01:54:46 +0100
Message-ID: <20250225005446.13894-7-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mention that running the HSS no longer works.  Document the changed boot
options.  Reorder documentation blocks.  Update URLs.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 docs/system/riscv/microchip-icicle-kit.rst | 124 +++++++--------------
 1 file changed, 43 insertions(+), 81 deletions(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
index 40798b1aae..9809e94b84 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -5,10 +5,10 @@ Microchip PolarFire SoC Icicle Kit integrates a PolarFi=
re SoC, with one
 SiFive's E51 plus four U54 cores and many on-chip peripherals and an FPG=
A.
=20
 For more details about Microchip PolarFire SoC, please see:
-https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc=
-fpga
+https://www.microchip.com/en-us/products/fpgas-and-plds/system-on-chip-f=
pgas/polarfire-soc-fpgas
=20
 The Icicle Kit board information can be found here:
-https://www.microsemi.com/existing-parts/parts/152514
+https://www.microchip.com/en-us/development-tool/mpfs-icicle-kit-es
=20
 Supported devices
 -----------------
@@ -26,95 +26,48 @@ The ``microchip-icicle-kit`` machine supports the fol=
lowing devices:
 * 2 GEM Ethernet controllers
 * 1 SDHC storage controller
=20
+The memory is set to 1537 MiB by default.  A sanity check on RAM size is
+performed in the machine init routine to prompt user to increase the RAM=
 size
+to > 1537 MiB when less than 1537 MiB RAM is detected.
+
 Boot options
 ------------
=20
-The ``microchip-icicle-kit`` machine can start using the standard -bios
-functionality for loading its BIOS image, aka Hart Software Services (HS=
S_).
-HSS loads the second stage bootloader U-Boot from an SD card. Then a ker=
nel
-can be loaded from U-Boot. It also supports direct kernel booting via th=
e
--kernel option along with the device tree blob via -dtb. When direct ker=
nel
-boot is used, the OpenSBI fw_dynamic BIOS image is used to boot a payloa=
d
-like U-Boot or OS kernel directly.
-
-The user provided DTB should have the following requirements:
-
-* The /cpus node should contain at least one subnode for E51 and the num=
ber
-  of subnodes should match QEMU's ``-smp`` option
-* The /memory reg size should match QEMU=E2=80=99s selected ram_size via=
 ``-m``
-* Should contain a node for the CLINT device with a compatible string
-  "riscv,clint0"
-
-QEMU follows below truth table to select which payload to execute:
-
-=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D
--bios    -kernel       -dtb payload
-=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D
-    N          N don't care     HSS
-    Y don't care don't care     HSS
-    N          Y          Y  kernel
-=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D
-
-The memory is set to 1537 MiB by default which is the minimum required h=
igh
-memory size by HSS. A sanity check on ram size is performed in the machi=
ne
-init routine to prompt user to increase the RAM size to > 1537 MiB when =
less
-than 1537 MiB ram is detected.
-
-Running HSS
------------
-
-HSS 2020.12 release is tested at the time of writing. To build an HSS im=
age
-that can be booted by the ``microchip-icicle-kit`` machine, type the fol=
lowing
-in the HSS source tree:
-
-.. code-block:: bash
-
-  $ export CROSS_COMPILE=3Driscv64-linux-
-  $ cp boards/mpfs-icicle-kit-es/def_config .config
-  $ make BOARD=3Dmpfs-icicle-kit-es
-
-Download the official SD card image released by Microchip and prepare it=
 for
-QEMU usage:
-
-.. code-block:: bash
-
-  $ wget ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icic=
le-kit-es-sd-20201009141623.rootfs.wic.gz
-  $ gunzip core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs=
.wic.gz
-  $ qemu-img resize core-image-minimal-dev-icicle-kit-es-sd-202010091416=
23.rootfs.wic 4G
-
-Then we can boot the machine by:
-
-.. code-block:: bash
-
-  $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
-      -bios path/to/hss.bin -sd path/to/sdcard.img \
-      -nic user,model=3Dcadence_gem \
-      -nic tap,ifname=3Dtap,model=3Dcadence_gem,script=3Dno \
-      -display none -serial stdio \
-      -chardev socket,id=3Dserial1,path=3Dserial1.sock,server=3Don,wait=3D=
on \
-      -serial chardev:serial1
+The ``microchip-icicle-kit`` machine provides some options to run a firm=
ware
+(BIOS) or a kernel image.  QEMU follows below truth table to select the
+firmware:
=20
-With above command line, current terminal session will be used for the f=
irst
-serial port. Open another terminal window, and use ``minicom`` to connec=
t the
-second serial port.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+-bios          -kernel    firmware
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+none                    N this is an error
+none                    Y the kernel image
+NULL, default           N hss.bin
+NULL, default           Y opensbi-riscv64-generic-fw_dynamic.bin
+other          don't care the BIOS image
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-.. code-block:: bash
+Direct Kernel Boot
+------------------
=20
-  $ minicom -D unix\#serial1.sock
+Use the ``-kernel`` option to directly run a kernel image.  When a direc=
t
+kernel boot is requested, a device tree blob may be specified via the ``=
-dtb``
+option.  Unlike other QEMU machines, this machine does not generate a de=
vice
+tree for the kernel.  It shall be provided by the user.  The user provid=
ed DTB
+should meet the following requirements:
=20
-HSS output is on the first serial port (stdio) and U-Boot outputs on the
-second serial port. U-Boot will automatically load the Linux kernel from
-the SD card image.
+* The ``/cpus`` node should contain at least one subnode for E51 and the=
 number
+  of subnodes should match QEMU's ``-smp`` option.
=20
-Direct Kernel Boot
-------------------
+* The ``/memory`` reg size should match QEMU=E2=80=99s selected RAM size=
 via the ``-m``
+  option.
=20
-Sometimes we just want to test booting a new kernel, and transforming th=
e
-kernel image to the format required by the HSS bootflow is tedious. We c=
an
-use '-kernel' for direct kernel booting just like other RISC-V machines =
do.
+* It should contain a node for the CLINT device with a compatible string
+  "riscv,clint0".
=20
-In this mode, the OpenSBI fw_dynamic BIOS image for 'generic' platform i=
s
-used to boot an S-mode payload like U-Boot or OS kernel directly.
+When ``-bios`` is not specified or set to ``default``, the OpenSBI
+``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot a=
n
+S-mode payload like U-Boot or OS kernel directly.
=20
 For example, the following commands show building a U-Boot image from U-=
Boot
 mainline v2021.07 for the Microchip Icicle Kit board:
@@ -146,4 +99,13 @@ CAVEATS:
   ``u-boot.bin`` has to be used which does contain one. To use the ELF i=
mage,
   we need to change to CONFIG_OF_EMBED or CONFIG_OF_PRIOR_STAGE.
=20
+Running HSS
+-----------
+
+The machine ``microchip-icicle-kit`` used to run the Hart Software Servi=
ces
+(HSS_), however, the HSS development progressed and the QEMU machine
+implementation lacks behind.  Currently, running the HSS no longer works=
.
+There is missing support in the clock and memory controller devices.  In
+particular, reading from the SD card does not work.
+
 .. _HSS: https://github.com/polarfire-soc/hart-software-services
--=20
2.43.0


