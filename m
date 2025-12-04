Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C949D1D87C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3Id-0002b9-1R; Thu, 04 Dec 2025 01:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vR3Ic-0002an-6z; Thu, 04 Dec 2025 01:58:46 -0500
Received: from out28-56.mail.aliyun.com ([115.124.28.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vR3IZ-0005dW-Sn; Thu, 04 Dec 2025 01:58:45 -0500
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fcgSBGb_1764831512 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 04 Dec 2025 14:58:32 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v2 5/5] docs/system/riscv: add documentation for k230 machine
Date: Thu,  4 Dec 2025 14:58:26 +0800
Message-ID: <dbb2ed998f8ee739f99d841a5e17c854050828fb.1764830405.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764830405.git.chao.liu@zevorn.cn>
References: <cover.1764830405.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.56; envelope-from=chao.liu@zevorn.cn;
 helo=out28-56.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add documentation for k230 virt reference platform.

Signed-off-by: Chao Liu <chao.liu@zevorn.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS                  |  1 +
 docs/system/riscv/k230.rst   | 48 ++++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |  1 +
 3 files changed, 50 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bdab8fb8a..bfa63f832e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1713,6 +1713,7 @@ F: include/hw/riscv/xiangshan_kmh.h
 K230 Machines
 M: Chao Liu <chao.liu@zevorn.cn>
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..3e6ca295df
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,48 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with with Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+It has multi-precision AI computing ability, works with many common AI computing
+frameworks, and for some typical networks, its usage rate is over 70%. Besides,
+the K230 chip supports many peripheral connections and has several special
+hardware acceleration units (like 2D and 2.5D accelerators). It can speed up
+different tasks (such as image processing, video processing, audio processing
+and AI computing). It also has many good features: low delay, high performance,
+low power use and fast start-up.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores
+* Core Local Interruptor (CLINT)
+* Incoming MSI Controller (IMSIC)
+* 2 K230 Watchdog Timer
+* 4 UART
+
+Boot options
+------------
+The ``k230`` machine can start using the standard ``-bios``
+functionality for loading the boot image. You need to compile and link
+the firmware, kernel, and Device Tree (FDT) into a single binary file with
+K230 SDK(k230_canmv_defconfig), such as ``uboot``.
+
+Running
+-------
+Below is an example command line for running the ``k230``
+machine:
+
+.. code-block:: bash
+
+   $ qemu-system-riscv64 -machine k230 \
+      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
+      -nographic
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..2103ff6173 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/shakti-c
-- 
2.51.0


