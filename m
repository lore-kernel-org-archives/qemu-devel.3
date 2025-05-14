Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4936C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBgo-0002hL-47; Wed, 14 May 2025 08:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgl-0002XI-Am; Wed, 14 May 2025 08:58:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBgi-0007pu-Qx; Wed, 14 May 2025 08:58:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F271B121ADF;
 Wed, 14 May 2025 15:57:48 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D99C20B84D;
 Wed, 14 May 2025 15:57:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 01/34] docs/specs/riscv-iommu: Fixed broken link to
 external risv iommu document
Date: Wed, 14 May 2025 15:57:23 +0300
Message-Id: <20250514125758.92030-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>

The links to riscv iommu specification document are incorrect. This patch
updates all the said link to point to correct location.

Cc: qemu-stable@nongnu.org
Cc: qemu-riscv@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e768f0246ce2625880800a2bdce78438b5e9282c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 463f4cffb6..decd81cf4f 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
 ========================================
 
 QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
-version 1.0 `iommu1.0`_.
+version 1.0 `iommu1.0.0`_.
 
 The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
 RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
@@ -14,7 +14,7 @@ riscv-iommu-pci reference device
 --------------------------------
 
 This device implements the RISC-V IOMMU emulation as recommended by the section
-"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
+"Integrating an IOMMU as a PCIe device" of `iommu1.0.0`_: a PCI device with base
 class 08h, sub-class 06h and programming interface 00h.
 
 As a reference device it doesn't implement anything outside of the specification,
@@ -83,7 +83,7 @@ Several options are available to control the capabilities of the device, namely:
 - "s-stage": enable s-stage support
 - "g-stage": enable g-stage support
 
-.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
+.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
 .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
 
-- 
2.39.5


