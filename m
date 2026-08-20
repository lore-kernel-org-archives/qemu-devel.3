Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385EDC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqZ-0002Bi-DA; Wed, 19 Aug 2026 22:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsqH-0001yP-Lk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:24 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsqB-0000ch-Hp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:21 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66c711b7f2aso2965943d50.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194154; x=1787798954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gYrJCwDJoPwY3Q++OzxKWkU9UhZqFpzStszdt+XclHI=;
 b=MyB3vpXq2s38D7DbGSVZxmxg9ApVYZ6WF2zG4g01zVSO1C+XM4tDeYRGe4ErxDou0c
 Rsv6Mc1H0XVbxGYKCTiyBpY6Kjbp4K8wfolQ2gQmkmmJ/GtuGs+EyuauHBvRA2wPlj1U
 tB6IoNCIo6fhL3PNnaWCeOwj5JCo1OJuIZeZvW74iTPhRwKWnQxqkLoG2LYm2h+x3rgd
 Pvw/SMy8vbQzZPkJDY2JH21qUmof7TMGZHZDjJI86Te9CdrnyZKGgSYwWzFt0zrH0w/R
 ex62f+UkYqKpidRpBNcn5lu6JPWWzY6Jnjj2caLyPXpvNFnG/fBBEcAgzQRMz26UI4iL
 ZWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194154; x=1787798954;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gYrJCwDJoPwY3Q++OzxKWkU9UhZqFpzStszdt+XclHI=;
 b=dY342JdDHQ7az7HB3+70G47NbxWPPqQD22DntsLerSzvMkj9OuROTD1jT6pSMJV5kz
 UUcCVT96XNAoeuX+dG1YjAs3yem/ehxMmvDEHbL5S0oh+ycjuKmPdYrineYPwRBdkprX
 Abl7L+/o6zEQ2DmXiKJN32p4TSPlVs8+t9cZeuVhxnfEmgQoS9DLCbPQD7WQHIvCj40X
 AMeEHDizi/VyMqUNdJKAmmGV2T06JKj9Vv1Q0rJ8z/pKnizbfaKpvNEOTmMAoFklmGaS
 FE5NtScedFAEvLyvUAfuXXK47hnVxlP7GGiw9mpHn2eiTgJwisyGwPTf5LxPY4MJTgZf
 yzJg==
X-Gm-Message-State: AFuF++lAAU7GUwJACO0IOkAQb/HwbdlkVN6FOGWq6u6ryPelwm37TVih
 mRGBlYUGQBo5MSgx7l5hybhdFepjHbJApa4cuGfqKr5WkKSXYlb8cH0rCu4TPg==
X-Gm-Gg: AR+sD10UpHSnfXVug4zaHF7kTHhnojmetVXkrTebJAsJh3hdCxeh8WRA4MWHsRnRqvM
 Hu/SraruLLNHpX/y5flH+0U1IQp8IQ6S6CQROprT2d8XDeSQiHFaCNsaaUFOFH6dHuHDJj8vNr/
 uNLEzra20MV7hj3aB0uzWU911LoitL0ysPxD8Hyv9HrvM0eAG4cUpUfwC55Qjc4DOYRgQeSo8RT
 9pKod8h4i/S+Z4UFmhdND+DRQbughiHKMJ3zqoEuoLyeYiEbw7OdbVRBzuBUByEhQ7khK63pytP
 jDQTIFYPCim2WrIqGg2LI9x2dEtIg2pemP5qaIHQPXe6rEYbBMJ+n7czSx7QhuJLSkLYQa5lrhw
 5phcoZFd+2FWpFp5g2VnLK0rjgzeO7cOdjimejpFOtNLSeIZ5/A27GWr3xpw4qpl97lwHfypery
 KcppW7fMGOVHIddO014nxFYahgzwT6c8Aj54yvlFyzTI5V8pvg2tScjrhHdQCr12upES22AZ/Gx
 UIS2pG1XxxUZLh8XRjfAfZofBGhCyueFVHuD2lFbKEWfUwqNfU0aQ==
X-Received: by 2002:a05:690e:e0e:b0:667:dd2f:9441 with SMTP id
 956f58d0204a3-66ccb5def37mr2757574d50.13.1787194154046; 
 Wed, 19 Aug 2026 19:49:14 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:12 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 16/16] docs, MAINTAINERS, tests/functional: add i.MX 95 EVK
Date: Wed, 19 Aug 2026 21:48:34 -0500
Message-Id: <20260820024834.3286721-17-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12f.google.com
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

Add the machine documentation (docs/system/arm/imx95-evk.rst, linked
into the target-arm manual), the MAINTAINERS entry, and an
environment-gated functional test that boots Linux to userspace on the
real System Manager firmware.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 MAINTAINERS                                |  18 ++
 docs/system/arm/imx95-evk.rst              | 242 +++++++++++++++++++++
 docs/system/target-arm.rst                 |   1 +
 tests/functional/aarch64/meson.build       |   2 +
 tests/functional/aarch64/test_imx95_evk.py | 157 +++++++++++++
 5 files changed, 420 insertions(+)
 create mode 100644 docs/system/arm/imx95-evk.rst
 create mode 100644 tests/functional/aarch64/test_imx95_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e602..f66082eadc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -956,6 +956,24 @@ F: docs/system/arm/imx8m.rst
 F: tests/functional/aarch64/test_imx8mp_evk.py
 F: tests/qtest/rs5c372-test.c
 
+MCIMX95-19X19-EVK / i.MX95
+M: Kyle Fox <kylefoxaustin.github@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/imx95-evk.c
+F: hw/arm/fsl-imx95.c
+F: hw/misc/imx95_*.c
+F: hw/timer/imx95_sysctr.c
+F: hw/char/imx_lpuart.c
+F: hw/i2c/imx_lpi2c.c
+F: hw/misc/imx_mu.c
+F: include/hw/arm/fsl-imx95.h
+F: include/hw/char/imx_lpuart.h
+F: include/hw/misc/imx_mu.h
+F: include/hw/misc/imx95_*.h
+F: docs/system/arm/imx95-evk.rst
+F: tests/functional/aarch64/test_imx95_evk.py
+
 MPS2 / MPS3
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/docs/system/arm/imx95-evk.rst b/docs/system/arm/imx95-evk.rst
new file mode 100644
index 00000000000..d67cd2de16f
--- /dev/null
+++ b/docs/system/arm/imx95-evk.rst
@@ -0,0 +1,242 @@
+NXP i.MX 95 19x19 Evaluation Kit (``imx95-19x19-evk``)
+======================================================
+
+The ``imx95-19x19-evk`` machine models the NXP i.MX 95 19x19 LPDDR5
+Evaluation Kit. The i.MX 95 is a heterogeneous SoC; the machine
+correspondingly emulates a fixed topology of **6 Cortex-A55 application
+cores, 1 Cortex-M33** that runs the NXP **System Manager** (SM)
+firmware, **and 1 Cortex-M7** real-time core that the System Manager
+boots, manages and fault-recovers (see ``Cortex-M7 real-time core``
+below).
+
+A defining property of this SoC is that the System Manager firmware is
+the only SCMI provider: Linux's clock, perf-domain, power, sensor, and
+reset operations are all served by the SM running on the M33 over a
+shared mailbox (MU2), not by software inside QEMU. Booting Linux to
+userspace on this machine therefore requires the SM firmware as an
+input — see ``Required artifacts`` below.
+
+Supported devices
+-----------------
+
+The ``imx95-19x19-evk`` machine implements the following devices:
+
+ * 6 Cortex-A55 application cores
+ * 1 Cortex-M33 (System Manager core; runs NXP SM firmware)
+ * 1 Cortex-M7 (real-time core; SM-booted and SM-managed)
+ * Generic Interrupt Controller (GICv3, GIC-600 layout)
+ * LPUART serial controllers (LPUART1 = Linux console; LPUART2 = SM
+   debug monitor; LPUART3 = M7 console)
+ * NXP Messaging Unit v2 (MU2) with the dual-aperture A55-MUA <->
+   M33-MUB cross-connect that carries SCMI; plus MUI_A5 (M7 <-> SM
+   SCMI) and MU7 (A55 <-> M7 rpmsg) cross-connects
+ * BLK_CTRL_S_AONMIX M7 CPU-WAIT gate (the SM's M7 hold/run control)
+ * System Counter (24 MHz live up-counter with compare-match IRQ; the
+   Linux broadcast clockevent on this machine)
+ * uSDHC storage controller (SDMA, used by U-Boot SD boot)
+ * LPI2C master (polled; used by the SM for PMIC / IO
+   expander bring-up)
+ * Functional models for the SM bring-up path: ANATOP (PLL lock and
+   DFS), SRC (system reset controller), GPC (general power
+   controller), ELE responder, FSB (fuse shadow block), eMcem, PF53
+   and PCAL6408A on LPI2C
+ * Logging stubs for blocks that are not on the boot critical path or
+   that have no behaviour to emulate (NETC, USB host, PCIe link
+   training, GPU/VPU/NPU MMIO, DPU command sequencer, watchdog, etc.)
+
+The Mali-G310 (GPU), Amphion (VPU), Neutron (NPU), and DPU (display
+controller) are intentionally probe-time stubs only; no rendering,
+codec, inference, or scanout occurs. See ``Caveats`` below.
+
+Boot options
+------------
+
+The ``imx95-19x19-evk`` machine can start a Linux kernel directly
+using ``-kernel``, but **only together with the System Manager firmware
+loaded onto the Cortex-M33** via ``-device loader,...,cpu-num=6``.
+Booting Linux without the SM firmware leaves the M33 halted, nothing
+answers SCMI, and Linux will hang at ``arm-scmi`` probe.
+
+Required artifacts
+''''''''''''''''''
+
+Four artifacts are needed; all are built from NXP source trees:
+
+* **System Manager firmware** (``m33_image.elf``). Built from the NXP
+  ``imx-sm`` source tree, with the ``mx95evk`` board configuration:
+
+  .. code-block:: bash
+
+     git clone https://github.com/nxp-imx/imx-sm.git
+     cd imx-sm
+     make config=mx95evk
+     # Result: build/mx95evk/m33_image.elf
+
+* **aarch64 Linux kernel** (``Image``). Either the NXP BSP kernel
+  (e.g. ``linux-imx`` 6.12.49) built with the NXP defconfig, or a
+  mainline kernel built with the standard arm64 defconfig — both have
+  been tested.
+
+* **Device tree blob** (``imx95-19x19-evk.dtb``). Produced by the same
+  kernel build under
+  ``arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb``.
+
+* **Initramfs** (``*.cpio.gz``) containing an ``/init``. Any aarch64
+  initramfs will do; a small static BusyBox initramfs (for example one
+  built from a prebuilt static-aarch64 BusyBox, no cross compiler
+  required) whose ``/init`` prints a recognisable marker is enough.
+
+Direct Linux Kernel Boot
+''''''''''''''''''''''''
+
+Once the four artifacts are built, boot Linux to userspace as
+follows:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx95-19x19-evk -m 2G -display none \
+      -kernel Image \
+      -dtb imx95-19x19-evk.dtb \
+      -initrd initramfs.cpio.gz \
+      -device loader,file=m33_image.elf,cpu-num=6 \
+      -append "earlycon=lpuart32,mmio32,0x44380010 \
+               console=ttyLP0,115200 cpuidle.off=1 rdinit=/init" \
+      -serial mon:stdio -serial null
+
+On a successful boot, Linux negotiates SCMI with the real SM
+(``SCMI Protocol v2.1 'NXP:IMX' Firmware version 0x333``), brings up
+all 6 A55 cores via PSCI, mounts the initramfs, and starts ``/init``.
+
+LPUART1 (``ttyLP0``) is Linux's console; it is wired to the first
+``-serial`` backend above. LPUART2 carries the System Manager's own
+debug monitor; it is wired to the second ``-serial`` backend
+(``null`` above), and can be redirected to a separate file or pty if
+desired.
+
+System Manager standalone
+'''''''''''''''''''''''''
+
+To exercise the SM in isolation (no Linux), boot it with LPUART2 as
+the only console and stop at the SM debug monitor prompt:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx95-19x19-evk -m 2G -display none \
+      -device loader,file=m33_image.elf,cpu-num=6 \
+      -serial null -serial mon:stdio
+
+Cortex-M7 real-time core
+''''''''''''''''''''''''
+
+The i.MX 95 System Manager owns the Cortex-M7's whole lifecycle. Unlike a
+generic remoteproc model where Linux starts the M-core, on this SoC the SM
+boots the M7 **before** the A-cluster and the AP logical machine does not own
+the M7; Linux's ``imx_rproc`` driver therefore only *attaches* to the
+already-running M7 (kernel log: ``imx-rproc imx95-cm7: lmm(1) not under Linux
+Control``).
+
+Load M7 firmware onto the M7 (CPU index 7) with a second loader device:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx95-19x19-evk -m 2G -display none \
+      -device loader,file=m33_image.elf,cpu-num=6 \
+      -device loader,file=cm7_firmware.elf,cpu-num=7 \
+      ... (kernel/dtb/initrd as above for a full Linux + M7 boot)
+
+When the SM firmware is present it boots the M7 itself: the machine fabricates
+the boot-ROM image handover the SM reads at startup to learn it owns the M7
+(real hardware gets this from the boot ROM; the direct ``-device loader`` path
+bypasses it), so the SM runs its full ``DEV_SM_CpuStart`` for the M7. With no SM
+loaded, the M7 is released at reset if its reset vector was
+populated. The M7's console is LPUART3.
+
+Two SM-managed behaviours are modelled:
+
+* **rpmsg.** Once Linux has attached, the stock NXP ``imx_rpmsg_pingpong``
+  kernel module exchanges 100 messages with an M7 rpmsg-lite client over the
+  MU7 cross-connect (doorbell kicks) and shared vrings (payload) in the M7 DRAM
+  carveout, printing ``goodbye!`` after the final round-trip. The
+  ``Cortex-M7 rpmsg ping/pong`` functional test below exercises this end to
+  end.
+
+* **Fault recovery.** The M7 logical machine is configured ``reaction=lm_reset``,
+  so an M7 fault triggers an SM-driven cold reset of the M7. When the M7 asserts
+  ``SYSRESETREQ`` it is routed to the SM as ``CM7_SYSRESETREQ_IRQn``; the SM runs
+  ``LMM_SystemLmReset`` (stop then start the M7), printing ``Reset LM 1`` on its
+  debug monitor. The ``Cortex-M7 fault recovery`` functional test below
+  exercises this end to end.
+
+Caveats
+-------
+
+* **Deep cpuidle requires** ``cpuidle.off=1`` **on the kernel command
+  line.** Linux's ``cpu-pd-wait`` idle state quiesces the per-CPU GIC
+  CPU interface before WFI; QEMU's GICv3 model has no WakeRequest
+  path, so a halted CPU is not woken by a pending interrupt while its
+  interface is disabled. The kernel-command-line workaround is the
+  recommendation; the deeper fix needs upstream QEMU work in
+  ``hw/intc/arm_gicv3_cpuif.c``.
+
+* **No hardware-accelerated rendering, codec, or inference.** Mali-G310,
+  Amphion VPU, and Neutron NPU are logging stubs. The Mali kernel
+  driver in particular fails probe with ``-22`` at the product-ID
+  check (``Unknown GPU Product ID 0``), so no Mali Vulkan ICD is
+  installed and ``vulkaninfo`` reports
+  ``ERROR_INCOMPATIBLE_DRIVER``. The DPU stub does register
+  ``/dev/dri/card0``, but it has no connectors and no scanout, so
+  ``kmscube`` fails with ``no connected connector``.
+
+* **No networking interfaces.** The NETC blocks are stubs; only the
+  loopback interface ``lo`` appears in the guest.
+
+* **No Linux-visible block storage.** Linux's
+  ``sdhci-esdhc-imx`` driver defers probe on an unmet dependency, so
+  ``/dev/mmcblk*`` is empty even with an SD-card image attached via
+  ``-drive ...,if=sd``. (The uSDHC model itself works — U-Boot SPL
+  boots from SD on this machine — but the Linux MMC stack does not
+  complete probe.)
+
+* **icount is not the default boot mode.** ``-icount shift=auto``
+  delays interrupt/timer delivery to idle CPUs on this heterogeneous
+  A55+M33 machine, where both sides can WFI between SCMI/MU
+  round-trips, inflating the boot ~9x. Enable icount only when
+  debugging a race; do not use it for normal boots.
+
+Functional test
+---------------
+
+``tests/functional/aarch64/test_imx95_evk.py`` has three env-gated cases; each
+takes its artifacts from environment variables and skips cleanly (naming the
+unset variables) if any are absent, since the NXP-source-built artifacts are
+not redistributable:
+
+* **Linux to userspace on the real SM** — needs ``QEMU_TEST_IMX95_KERNEL``,
+  ``QEMU_TEST_IMX95_DTB``, ``QEMU_TEST_IMX95_INITRD`` and
+  ``QEMU_TEST_IMX95_SM_FW``. Boots Linux and checks for the SCMI handshake
+  followed by an init-printed userspace banner (~14 s on a development host).
+
+* **Cortex-M7 rpmsg ping/pong** — needs ``QEMU_TEST_IMX95_KERNEL``,
+  ``QEMU_TEST_IMX95_DTB``, ``QEMU_TEST_IMX95_SM_FW``,
+  ``QEMU_TEST_IMX95_M7_RPMSG_FW`` (the M7 rpmsg-lite pingpong firmware) and
+  ``QEMU_TEST_IMX95_RPMSG_INITRD`` (an initramfs bundling the matching
+  ``imx_rpmsg_pingpong.ko`` and an ``/init`` that loads it). Boots the full
+  A55 + SM + M7 stack and checks for the SCMI handshake followed by the
+  module's ``goodbye!`` line — printed only after the 100-message exchange
+  with the M7 over MU7 completes. The M7 firmware is NXP's
+  ``rpmsg_lite_pingpong_rtos_linux_remote`` multicore example; the NXP BSP
+  ships it prebuilt in the target rootfs at
+  ``/usr/lib/firmware/imx95-19x19-evk_m7_TCM_rpmsg_lite_pingpong_rtos_linux_remote.{elf,bin}``,
+  or it can be built from the MCUXpresso SDK multicore examples.
+
+* **Cortex-M7 fault recovery** — needs ``QEMU_TEST_IMX95_SM_FW`` and
+  ``QEMU_TEST_IMX95_M7_FW`` (an M7 fixture that asserts ``SYSRESETREQ`` on its
+  first boot). Boots
+  the SM + M7 alone and checks the SM debug monitor for ``Reset LM 1`` — the
+  SM taking the M7 fault and cold-resetting the M7 logical machine.
+
+.. code-block:: bash
+
+  $ QEMU_TEST_IMX95_SM_FW=/path/to/m33_image.elf \
+    QEMU_TEST_IMX95_M7_FW=/path/to/cm7_fault.elf \
+    meson test -C build --suite thorough func-aarch64-imx95_evk
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index e34492402f0..514d89e2d59 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -95,6 +95,7 @@ Board-specific documentation
    arm/mcimx6ul-evk
    arm/mcimx7d-sabre
    arm/imx8m
+   arm/imx95-evk
    arm/orangepi
    arm/raspi
    arm/collie
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index e81afd6c39f..972e896c149 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -7,6 +7,7 @@ test_aarch64_timeouts = {
   'device_passthrough' : 720,
   'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
+  'imx95_evk' : 240,
   'raspi4' : 480,
   'reverse_debug' : 180,
   'rme_virt' : 1200,
@@ -33,6 +34,7 @@ tests_aarch64_system_thorough = [
   'hotplug_pci',
   'imx8mm_evk',
   'imx8mp_evk',
+  'imx95_evk',
   'kvm',
   'multiprocess',
   'raspi3',
diff --git a/tests/functional/aarch64/test_imx95_evk.py b/tests/functional/aarch64/test_imx95_evk.py
new file mode 100644
index 00000000000..69ac27f4927
--- /dev/null
+++ b/tests/functional/aarch64/test_imx95_evk.py
@@ -0,0 +1,157 @@
+#!/usr/bin/env python3
+#
+# Functional tests for imx95-19x19-evk: boot Linux on the 6 Cortex-A55s
+# with the real NXP System Manager firmware on the Cortex-M33, and exercise
+# the System-Manager-orchestrated Cortex-M7 (boot + fault recovery).
+#
+# The boot artifacts (aarch64 Linux Image, imx95-19x19-evk.dtb, an initramfs
+# cpio.gz, the NXP System Manager firmware m33_image.elf, and the M7 fault
+# fixture cm7_fault.elf) are built from NXP source trees / the in-tree M7
+# firmware and are not redistributable as QEMU test assets, so the tests take
+# them from environment variables and skip cleanly if any are absent. See
+# docs/system/arm/imx95-evk.rst for the build recipes.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest
+
+
+class Imx95EvkMachine(LinuxKernelTest):
+    """
+    Boot stock NXP BSP Linux on imx95-19x19-evk together with the real NXP
+    System Manager (SM) firmware on the emulated Cortex-M33, and exercise the
+    SM-orchestrated Cortex-M7. The SM is the only SCMI provider on this machine
+    (there is no built-in software SCMI server), so a successful boot validates
+    the M33 <-> A55 mailbox cross-connect as well as the Linux boot path; the
+    M7 test validates the SM's ownership of the M7's lifecycle.
+    """
+
+    def _require(self, *envvars):
+        """Return a dict of resolved artifact paths, or skip if any is unset."""
+        artifacts = {}
+        missing = []
+        for envvar in envvars:
+            path = os.environ.get(envvar)
+            if path and os.path.exists(path):
+                artifacts[envvar] = path
+            else:
+                missing.append(envvar)
+        if missing:
+            self.skipTest(
+                'requires NXP-source-built boot artifacts (see '
+                'docs/system/arm/imx95-evk.rst for build recipes); set '
+                + ', '.join(missing))
+        return artifacts
+
+    def test_aarch64_imx95_evk_real_sm(self):
+        """Linux boots to userspace on 6 A55s, SCMI served by the real SM."""
+        art = self._require('QEMU_TEST_IMX95_KERNEL', 'QEMU_TEST_IMX95_DTB',
+                            'QEMU_TEST_IMX95_INITRD', 'QEMU_TEST_IMX95_SM_FW')
+        self.require_accelerator("tcg")
+        self.set_machine('imx95-19x19-evk')
+        # LPUART1 (ttyLP0, index 0) is the Linux console; LPUART2 carries
+        # the SM debug monitor and is left null here.
+        self.vm.set_console(console_index=0)
+        # The machine has a fixed heterogeneous topology of 6 Cortex-A55 +
+        # 1 Cortex-M33 (SM) + 1 Cortex-M7 (RT), so do not pass -smp; the
+        # machine's default of 8 is the only accepted value.
+        self.vm.add_args(
+            '-m', '2G',
+            '-kernel', art['QEMU_TEST_IMX95_KERNEL'],
+            '-dtb',    art['QEMU_TEST_IMX95_DTB'],
+            '-initrd', art['QEMU_TEST_IMX95_INITRD'],
+            '-device',
+            'loader,file=%s,cpu-num=6' % art['QEMU_TEST_IMX95_SM_FW'],
+            '-append',
+            'earlycon=lpuart32,mmio32,0x44380010 '
+            'console=ttyLP0,115200 cpuidle.off=1 rdinit=/init',
+        )
+        self.vm.launch()
+        # Load-bearing signal #1: SCMI handshake against the real SM.
+        # Confirms the dual-aperture MU2 cross-connect (A55 MUA <-> M33 MUB)
+        # is working end-to-end and the SM answered protocol negotiation.
+        self.wait_for_console_pattern(
+            "SCMI Protocol v2.1 'NXP:IMX' Firmware version 0x333")
+        # Load-bearing signal #2: PID 1 ran. The string is printed by the
+        # /init in the supplied initramfs (QEMU_TEST_IMX95_INITRD).
+        self.wait_for_console_pattern('=== imx95 busybox userspace ===')
+
+    def test_aarch64_imx95_evk_m7_rpmsg_pingpong(self):
+        """Linux + the SM-booted M7 run NXP's rpmsg_lite ping/pong over MU7.
+
+        The full A55 + M33(SM) + M7 stack: the SM boots the M7 running NXP's
+        rpmsg_lite pingpong firmware, Linux's imx_rproc attaches to the
+        SM-managed core, and the stock imx_rpmsg_pingpong module exchanges
+        100 messages with the M7 - kicks over the modelled MU7 cross-connect,
+        payload in the shared vrings. The module prints "goodbye!" after the
+        final round-trip. The initramfs must bundle the matching
+        imx_rpmsg_pingpong.ko and an /init that loads it (see
+        docs/system/arm/imx95-evk.rst).
+        """
+        art = self._require('QEMU_TEST_IMX95_KERNEL', 'QEMU_TEST_IMX95_DTB',
+                            'QEMU_TEST_IMX95_RPMSG_INITRD',
+                            'QEMU_TEST_IMX95_SM_FW',
+                            'QEMU_TEST_IMX95_M7_RPMSG_FW')
+        self.require_accelerator("tcg")
+        self.set_machine('imx95-19x19-evk')
+        self.vm.set_console(console_index=0)
+        self.vm.add_args(
+            '-m', '2G',
+            '-kernel', art['QEMU_TEST_IMX95_KERNEL'],
+            '-dtb',    art['QEMU_TEST_IMX95_DTB'],
+            '-initrd', art['QEMU_TEST_IMX95_RPMSG_INITRD'],
+            '-device',
+            'loader,file=%s,cpu-num=6' % art['QEMU_TEST_IMX95_SM_FW'],
+            # The rpmsg pingpong firmware is a raw M7 TCM image; load it at the
+            # M7 TCM alias the remoteproc carveout points at (0x203c0000),
+            # rather than as an ELF with cpu-num.
+            '-device', 'loader,file=%s,addr=0x203c0000,force-raw=on'
+                       % art['QEMU_TEST_IMX95_M7_RPMSG_FW'],
+            '-append',
+            'earlycon=lpuart32,mmio32,0x44380010 '
+            'console=ttyLP0,115200 cpuidle.off=1 rdinit=/init',
+        )
+        self.vm.launch()
+        # SCMI handshake against the real SM (as in the boot test) - the M7
+        # cannot come up without the SM, which is the only SCMI provider.
+        self.wait_for_console_pattern(
+            "SCMI Protocol v2.1 'NXP:IMX' Firmware version 0x333")
+        # The 100-message ping/pong completed: imx_rpmsg_pingpong prints
+        # "goodbye!" after the final round-trip with the M7 rpmsg-lite client.
+        self.wait_for_console_pattern('goodbye!')
+
+    def test_aarch64_imx95_evk_m7_fault_recovery(self):
+        """The real SM boots the M7, takes its fault, and cold-resets it.
+
+        No A55/Linux: the SM (M33) and the M7 fault fixture run alone. The
+        fixture asserts SYSRESETREQ on its first boot; the SM routes that to
+        CM7_SYSRESETREQ_IRQn, runs lm_reset on the M7 logical machine, and
+        prints the recovery on its debug monitor (LPUART2). Observing that
+        line confirms the whole SM-managed M7 lifecycle - the SM had to learn
+        it owns the M7 (from the machine's fabricated boot-ROM handover),
+        enable the fault IRQ, and drive the CpuStop/CpuStart cold cycle.
+        """
+        art = self._require('QEMU_TEST_IMX95_SM_FW', 'QEMU_TEST_IMX95_M7_FW')
+        self.require_accelerator("tcg")
+        self.set_machine('imx95-19x19-evk')
+        # Console on LPUART2 (index 1) = the SM debug monitor; LPUART1 (the
+        # A55 console) is left null since no Linux runs here.
+        self.vm.set_console(console_index=1)
+        self.vm.add_args(
+            '-m', '2G',
+            '-device',
+            'loader,file=%s,cpu-num=6' % art['QEMU_TEST_IMX95_SM_FW'],
+            '-device',
+            'loader,file=%s,cpu-num=7' % art['QEMU_TEST_IMX95_M7_FW'],
+        )
+        self.vm.launch()
+        # The SM comes up...
+        self.wait_for_console_pattern('SM Debug Monitor')
+        # ...then the M7 faults and the SM cold-resets the M7 logical machine.
+        self.wait_for_console_pattern('Reset LM 1')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


