Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524E1CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcza-0003rO-LK; Fri, 16 Oct 2026 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczK-0003oc-II; Fri, 16 Oct 2026 04:08:29 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHczG-0005xE-Pm; Fri, 16 Oct 2026 04:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138086; bh=gk3HZKAxOpyO5yJT8ekYuu2NFizbkjOTQwvrWEecYeo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VNQPxLT/5aqhQVBgwYAhx6iW7N9MaTLXt+hWw67L44lOWr1qFkXnzvhvTSqh/ppGN
 PYOdFyReZkOb2ZnGGSvDg4NCjAQ/dAxFy8UQo1M0bFr8s0diF8+xD9JuEF1tyLhQHH
 +gORC2DXF3eB03V6nKjJOCtO16OPmUcIYPT7CJSA=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G885BH3825273; Fri, 16 Oct 2026 13:38:06 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id B7E4F100234DC;
 Fri, 16 Oct 2026 13:37:55 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 5684914E17D2;
 Fri, 16 Oct 2026 13:37:55 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 5/7] docs/system/riscv: Add VEGA machine documentation
Date: Fri, 16 Oct 2026 13:37:05 +0530
Message-ID: <20261016080709.17331-6-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016080709.17331-1-karthika.b@cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: B7E4F100234DC.A27E0
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.999, required 6, ALL_TRUSTED -1.00, URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 docs/system/riscv/vega.rst   | 219 +++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |   1 +
 2 files changed, 220 insertions(+)
 create mode 100644 docs/system/riscv/vega.rst

diff --git a/docs/system/riscv/vega.rst b/docs/system/riscv/vega.rst
new file mode 100644
index 0000000000..78656682d0
--- /dev/null
+++ b/docs/system/riscv/vega.rst
@@ -0,0 +1,219 @@
+CDAC VEGA series RISC-V SoC (``vega``)
+=======================================
+
+VEGA is a series of 32-bit and 64-bit processors based on the RISC-V ISA, developed by C-DAC (Centre for Development of Advanced Computing, India) under the DIR-V program. The vega QEMU machine model supports both the 32-bit and 64-bit VEGA variants.
+
+As with other QEMU RISC-V machine models, vega provides functional emulation of the VEGA SoC’s memory map, interrupt controllers, and peripherals.
+
+For more details on the VEGA processor series, please see:
+https://vegaprocessors.in/
+
+For VEGA documentation, please see:
+https://cdac-vega.gitlab.io/
+
+Supported devices
+------------------
+
+The ``vega`` machine supports the following devices:
+
+ * Up to 4 RISC-V cores, RV32 or RV64
+ * Platform-Level Interrupt Controller (PLIC)
+ * Core Level Interruptor (CLINT)
+ * 1 UART
+ * 4 virtio-mmio transports
+
+Boot options
+------------
+
+The ``vega`` machine supports two boot modes.
+
+Bare-metal
+~~~~~~~~~~
+
+Bare-metal payloads are loaded via ``-bios`` (not ``-kernel``). No
+device tree is generated or loaded in this mode; the UART is always
+accessed with a fixed 4-byte register stride (shift=2, io-width=4).
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega,dram-base=0x80000000 \
+       -smp 1 -m 2G \
+       -display none -serial stdio \
+       -bios path/to/baremetal.elf
+
+VEGA SDK
+^^^^^^^^
+
+VEGA SDK can be used to build baremetal example applications, such as
+a "hello world" UART program, for both the Thejas32 (``vega32``, RV32)
+and Thejas64 (``vega64``, RV64) SoCs.
+
+Install VEGA tools
+''''''''''''''''''
+
+For Thejas32 SoC (Aries boards):
+
+.. code-block:: bash
+
+   $ git clone https://gitlab.com/cdac-vega/vega-tools-rv32.git
+   $ cd vega-tools-rv32
+   $ ./setup-env.sh
+   $ cd ..
+
+For Thejas64 SoC:
+
+.. code-block:: bash
+
+   $ git clone https://gitlab.com/cdac-vega/vega-tools-rv64.git
+   $ cd vega-tools-rv64
+   $ ./setup-env.sh
+   $ cd ..
+
+Install VEGA SDK
+''''''''''''''''
+
+For Thejas32 SoC (Aries boards):
+
+.. code-block:: bash
+
+   $ git clone https://gitlab.com/cdac-vega/vega-sdk.git
+   $ cd vega-sdk
+   $ git checkout aries
+   $ ./setup.sh
+
+For Thejas64 SoC:
+
+.. code-block:: bash
+
+   $ git clone https://gitlab.com/cdac-vega/vega-sdk.git
+   $ cd vega-sdk
+   $ ./setup-thejas64.sh
+
+Build and run the hello world example
+''''''''''''''''''''''''''''''''''''''
+.. code-block:: bash
+
+   $ cd vega-sdk
+   $ cd examples/uart/hello_world
+   $ make
+
+
+.. note::
+
+   The ``dram-base`` value must match the address the payload was
+   actually linked for; it is not a fixed VEGA default. The examples
+   below use ``dram-base=0x20000``, matching this SDK's hello-world
+   build for both Thejas32 and Thejas64 -- other payloads (e.g. a
+   Linux boot via BBL) are linked for a different address and need
+   their own matching ``dram-base`` value.
+
+.. code-block:: bash
+
+   $ qemu-system-riscv32 -M vega,dram-base=0x20000 \
+       -smp 1 -m 2G \
+       -display none -serial stdio \
+       -bios hello.elf
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega,dram-base=0x20000 \
+       -smp 1 -m 2G \
+       -display none -serial stdio \
+       -bios hello.elf
+
+Both should print::
+
+   Hello World
+
+
+Linux / BBL
+~~~~~~~~~~~
+
+Linux boot requires a user-supplied device tree via ``-dtb``. The
+``vega`` machine does not generate a device tree internally; passing
+``-kernel`` without ``-dtb`` (and without ``-bios``) is a
+configuration error and QEMU will refuse to start.
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega,dram-base=0x400000000 \
+       -smp 4 -m 2G \
+       -display none -serial stdio -bios none \
+       -kernel bbl -dtb vega.dtb -initrd rootfs.cpio
+
+Networking (virtio-net) can be attached the same way as on other
+virtio-mmio boards:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega,dram-base=0x400000000 \
+       -smp 4 -m 2G \
+       -display none -serial stdio -bios none \
+       -kernel bbl -dtb vega.dtb -initrd rootfs.cpio \
+       -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
+       -device virtio-net-device,netdev=net0
+
+.. note::
+
+   VEGA's PLIC uses the ``cdac,plic-1.0.0`` compatible string,
+   recognized by CDAC's own PLIC driver bundled in CDAC's
+   Buildroot-based BBL/Linux builds. The CLINT is addressed as a
+   standard ``riscv,clint0``, which CDAC's firmware uses directly
+   without a vendor-specific driver; all CDAC-produced VEGA firmware
+   variants use this generic CLINT compatible string.
+
+CPU defaults
+------------
+
+The ``vega`` machine supports both RV32 and RV64 harts, matching the
+VEGA processor series. The CPU type defaults automatically to the
+correct width for the binary in use (``qemu-system-riscv32`` selects
+``vega32``, ``qemu-system-riscv64`` selects ``vega64``) and bakes in
+VEGA's fixed baseline: I, M, A, S and U, Zicsr, and Zifencei, with the
+current RISC-V privileged architecture specification and SV32/SV39
+paging respectively. No ``-cpu`` argument is required to boot.
+Additional extensions (e.g. F/D/C) can still be enabled explicitly if
+needed:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega -cpu vega64,f=true,d=true,c=true ...
+   $ qemu-system-riscv32 -M vega -cpu vega32,f=true,d=true,c=true ...
+
+.. note::
+
+   ``TYPE_RISCV_CPU_VEGA32``/``TYPE_RISCV_CPU_VEGA64`` are parented on
+   ``TYPE_RISCV_CPU_SIFIVE_U`` rather than the generic base CPU type,
+   since the generic type's default ISA extensions cannot be fully
+   narrowed for VEGA's actual silicon (QEMU's CPU-class extension
+   merge is additive only). One consequence worth documenting: SiFive
+   U's default privileged specification version (1.10.0) is explicitly
+   overridden back to the current version in both VEGA CPU types,
+   since firmware built against the modern privileged spec can hang
+   early in boot (in CLINT/timer setup) against the older version. If
+   you build a custom CPU subtype from a similar parent, do not assume
+   privileged spec version propagates the way ISA extension bits
+   might.
+
+dram-base option
+-----------------
+
+VEGA silicon can be configured with DRAM at different base addresses.
+This is exposed as a machine property:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -M vega,dram-base=0x400000000 ...
+
+If ``dram-base`` is not specified, QEMU falls back to a default
+address and prints a warning.
+
+PLIC and CLINT address overlap
+-------------------------------
+
+On real VEGA silicon, the PLIC and CLINT are mapped at the same base
+address but are distinguished by non-overlapping register offset
+ranges, decoded internally by the SoC's interconnect. This is a
+genuine hardware characteristic, not a QEMU modelling error; compiling
+a VEGA device tree will produce a ``dtc`` ``unique_unit_address``
+warning for this reason, which is expected and can be ignored.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..cf056011d5 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
    riscv/mips
    riscv/shakti-c
    riscv/sifive_u
+   riscv/vega
    riscv/virt
    riscv/xiangshan-kunminghu
 
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


