Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D20CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsmT-0006aw-Kx; Thu, 28 Mar 2024 12:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpsmR-0006aR-U2; Thu, 28 Mar 2024 12:39:07 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpsmQ-0003JZ-1E; Thu, 28 Mar 2024 12:39:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id F30CB260836;
 Thu, 28 Mar 2024 17:39:01 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TWqNmQbt-Rtw; Thu, 28 Mar 2024 17:38:59 +0100 (CET)
Received: from applejack.lan (83.11.22.169.ipv4.supernova.orange.pl
 [83.11.22.169])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 60F1A2600D1;
 Thu, 28 Mar 2024 17:38:59 +0100 (CET)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 1/1] docs: sbsa: update specs, add dt note
Date: Thu, 28 Mar 2024 17:38:51 +0100
Message-ID: <20240328163851.1386176-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Hardware of sbsa-ref board is nowadays defined by both BSA and SBSA
specifications. Then BBR defines firmware interface.

Added note about DeviceTree data passed from QEMU to firmware. It is
very minimal and provides only data we use in firmware.

Added NUMA information to list of things reported by DeviceTree.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 docs/system/arm/sbsa.rst | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index bca61608ff..2bf22a1d0b 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -1,12 +1,16 @@
 Arm Server Base System Architecture Reference board (``sbsa-ref``)
 ==================================================================
 
-While the ``virt`` board is a generic board platform that doesn't match
-any real hardware the ``sbsa-ref`` board intends to look like real
-hardware. The `Server Base System Architecture
-<https://developer.arm.com/documentation/den0029/latest>`_ defines a
-minimum base line of hardware support and importantly how the firmware
-reports that to any operating system.
+The ``sbsa-ref`` board intends to look like real hardware (while the ``virt``
+board is a generic board platform that doesn't match any real hardware).
+
+The hardware part is defined by two specifications:
+
+  - `Base System Architecture <https://developer.arm.com/documentation/den0094/>`__ (BSA)
+  - `Server Base System Architecture <https://developer.arm.com/documentation/den0029/>`__ (SBSA)
+
+The `Arm Base Boot Requirements <https://developer.arm.com/documentation/den0044/>`__ (BBR)
+specification defines how the firmware reports that to any operating system.
 
 It is intended to be a machine for developing firmware and testing
 standards compliance with operating systems.
@@ -35,16 +39,29 @@ includes both internal hardware and parts affected by the qemu command line
 (i.e. CPUs and memory). As a result it must have a firmware specifically built
 to expect a certain hardware layout (as you would in a real machine).
 
+Note
+''''
+
+QEMU provides the guest EL3 firmware with minimal information about hardware
+platform using minimalistic devicetree. This is not a Linux devicetree. It is
+not even a firmware devicetree.
+
+It is information passed from QEMU to describe the information a hardware
+platform would have other mechanisms to discover at runtime, that are affected
+by the QEMU command line.
+
+Ultimately this devicetree may be replaced by IPC calls to an emulated SCP.
+
 DeviceTree information
 ''''''''''''''''''''''
 
-The devicetree provided by the board model to the firmware is not intended
-to be a complete compliant DT. It currently reports:
+The devicetree reports:
 
    - CPUs
    - memory
    - platform version
    - GIC addresses
+   - NUMA node id for CPUs and memory
 
 Platform version
 ''''''''''''''''
@@ -70,4 +87,4 @@ Platform version changes:
   GIC ITS information is present in devicetree.
 
 0.3
-  The USB controller is an XHCI device, not EHCI
+  The USB controller is an XHCI device, not EHCI.
-- 
2.44.0


