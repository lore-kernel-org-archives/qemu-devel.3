Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AB5C982E6
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8G8h-0006Yh-Kz; Sun, 20 Sep 2026 07:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8e-0006Wg-Ar; Sun, 20 Sep 2026 07:55:20 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8c-0001c3-Hm; Sun, 20 Sep 2026 07:55:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C9071A0029;
 Sun, 20 Sep 2026 13:55:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB1831A0018;
 Sun, 20 Sep 2026 13:55:16 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D95B1180006C;
 Sun, 20 Sep 2026 19:55:14 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 08/10] MAINTAINERS: Merge MCIMX8MM-EVK and MCIMX8MP-EVK
 entries
Date: Sun, 20 Sep 2026 17:24:56 +0530
Message-Id: <20260920115458.481605-9-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Merge the separate MCIMX8MM-EVK and MCIMX8MP-EVK MAINTAINERS entries
into a single combined entry covering both SoC families.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 MAINTAINERS | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6be9c5725b..7120784ec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -933,29 +933,24 @@ F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
 
-MCIMX8MM-EVK / iMX8MM
+MCIMX8MP-EVK / MCIMX8MM-EVK
+M: Bernhard Beschow <shentey@gmail.com>
 M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/fsl-imx8mm.c
 F: hw/arm/imx8mm-evk.c
-F: include/hw/arm/fsl-imx8mm.h
-F: docs/system/arm/imx8m.rst
-F: tests/functional/aarch64/test_imx8mm_evk.py
-
-MCIMX8MP-EVK / i.MX8MP
-M: Bernhard Beschow <shentey@gmail.com>
-L: qemu-arm@nongnu.org
-S: Maintained
 F: hw/arm/imx8mp-evk.c
 F: hw/arm/fsl-imx8mp.c
 F: hw/misc/imx8mp_*.c
 F: hw/pci-host/fsl_imx8m_phy.c
 F: hw/rtc/rs5c372.c
+F: include/hw/arm/fsl-imx8mm.h
 F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8m.rst
+F: tests/functional/aarch64/test_imx8mm_evk.py
 F: tests/functional/aarch64/test_imx8mp_evk.py
 F: tests/qtest/rs5c372-test.c
 
-- 
2.34.1


