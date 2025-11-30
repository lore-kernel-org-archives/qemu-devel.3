Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9649CFD376
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 09:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPdci-0005mE-0J; Sun, 30 Nov 2025 04:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vPdcf-0005l9-VT; Sun, 30 Nov 2025 04:21:37 -0500
Received: from out28-62.mail.aliyun.com ([115.124.28.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vPdcc-0006Cx-JX; Sun, 30 Nov 2025 04:21:37 -0500
Received: from ZEVORN-PC(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fZX11VX_1764494479 cluster:ay29) by smtp.aliyun-inc.com;
 Sun, 30 Nov 2025 17:21:19 +0800
From: Chao Liu <chao.liu@zevorn.cn>
To: richard.henderson@linaro.org, paolo.savini@embecosm.com, npiggin@gmail.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>
Subject: [PATCH v1 5/5] docs/system/riscv: add documentation for k230 machine
Date: Sun, 30 Nov 2025 17:21:10 +0800
Message-ID: <a303c6a1f48e7ba076bb62d78084d0008ae39526.1764493931.git.chao.liu@zevorn.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764493931.git.chao.liu@zevorn.cn>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.62; envelope-from=chao.liu@zevorn.cn;
 helo=out28-62.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 docs/system/riscv/k230.rst | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

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
-- 
2.51.0


