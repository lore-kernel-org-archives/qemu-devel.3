Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65250D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhnV-0001BS-3g; Wed, 03 Dec 2025 03:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnT-00017P-QL; Wed, 03 Dec 2025 03:01:11 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnR-00072k-LG; Wed, 03 Dec 2025 03:01:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5735A170772;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24DA432B499;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 101/116] MAINTAINERS: Add functional tests that are
 not covered yet
Date: Wed,  3 Dec 2025 10:59:21 +0300
Message-ID: <20251203075939.2366131-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Some functional tests are currently not covered by the entries
in MAINTAINERS yet, so scripts/get_maintainers.pl fails to suggest
the right people who should be CC:-ed for related patches.
Add the uncovered tests to the right sections to close this gap.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250414121520.213665-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 12c6b6153063aafcdbadca8fee7eac793ef85e4b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fd757c5dd..c6d9b022f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -475,6 +475,7 @@ F: docs/system/i386/sgx.rst
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
+F: tests/functional/test_x86_64_hotplug_cpu.py
 
 Xen emulation on X86 KVM CPUs
 M: David Woodhouse <dwmw2@infradead.org>
@@ -626,6 +627,7 @@ S: Maintained
 F: hw/alpha/
 F: hw/isa/smc37c669-superio.c
 F: tests/tcg/alpha/system/
+F: tests/functional/test_alpha_clipper.py
 
 ARM Machines
 ------------
@@ -950,7 +952,7 @@ F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
-F: tests/functional/test_aarch64_sbsaref*.py
+F: tests/functional/test_aarch64_*sbsaref*.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1019,9 +1021,10 @@ S: Maintained
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
-F: tests/functional/test_aarch64_virt*.py
+F: tests/functional/test_aarch64_*virt*.py
 F: tests/functional/test_aarch64_tuxrun.py
 F: tests/functional/test_arm_tuxrun.py
+F: tests/functional/test_arm_virt.py
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
@@ -1262,6 +1265,7 @@ F: hw/m68k/mcf_intc.c
 F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
+F: tests/functional/test_m68k_mcf5208evb.py
 
 NeXTcube
 M: Thomas Huth <huth@tuxfamily.org>
@@ -1406,6 +1410,7 @@ S: Maintained
 F: docs/system/openrisc/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/openrisc/openrisc_sim.c
+F: tests/functional/test_or1k_sim.py
 
 PowerPC Machines
 ----------------
@@ -1827,6 +1832,7 @@ F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 F: tests/functional/test_i386_tuxrun.py
+F: tests/functional/test_linux_initrd.py
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
 F: tests/functional/test_x86_64_tuxrun.py
@@ -3150,6 +3156,7 @@ F: include/ui/
 F: qapi/ui.json
 F: util/drm.c
 F: docs/devel/ui.rst
+F: tests/functional/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -3815,6 +3822,7 @@ F: configs/targets/*linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
 F: scripts/update-syscalltbl.sh
 F: scripts/update-mips-syscall-args.sh
+F: tests/functional/test_arm_bflt.py
 
 Tiny Code Generator (TCG)
 -------------------------
@@ -4187,6 +4195,7 @@ F: hw/remote/vfio-user-obj.c
 F: include/hw/remote/vfio-user-obj.h
 F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
+F: tests/functional/test_multiprocess.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
-- 
2.47.3


