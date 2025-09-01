Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5336CCA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 04:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvqR-0002o4-CO; Mon, 01 Sep 2025 00:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqK-0002nE-Ji; Mon, 01 Sep 2025 00:08:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqI-000862-JK; Mon, 01 Sep 2025 00:08:32 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 12:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 12:08:09 +0800
To: "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/4] docs/specs/aspeed-intc:  Remove GIC 128 - 136
Date: Mon, 1 Sep 2025 12:08:07 +0800
Message-ID: <20250901040808.1454742-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GIC interrupts 128 - 136 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 docs/specs/aspeed-intc.rst | 93 +++++++++++---------------------------
 1 file changed, 26 insertions(+), 67 deletions(-)

diff --git a/docs/specs/aspeed-intc.rst b/docs/specs/aspeed-intc.rst
index 9cefd7f37f..c0a4b4d150 100644
--- a/docs/specs/aspeed-intc.rst
+++ b/docs/specs/aspeed-intc.rst
@@ -47,18 +47,7 @@ Bit   GIC
 9     201
 ====  ====
 
-AST2700 A0
-----------
-It has only one INTC controller, and currently, only GIC 128-136 is supported.
-To support both AST2700 A1 and AST2700 A0, there are 10 OR gates in the INTC,
-with gates 1 to 9 supporting GIC 128-136.
-
-Design for GICINT 132
----------------------
-The orgate has interrupt sources ranging from 0 to 31, with its output pin
-connected to INTC. The output pin is then connected to GIC 132.
-
-Block Diagram of GICINT 196 for AST2700 A1 and GICINT 132 for AST2700 A0
+Block Diagram of GICINT 196 for AST2700 A1
 ------------------------------------------------------------------------
 
 .. code-block::
@@ -68,69 +57,39 @@ Block Diagram of GICINT 196 for AST2700 A1 and GICINT 132 for AST2700 A0
    |           To GICINT196                                                                                |
    |                                                                                                       |
    |   ETH1    |-----------|                    |--------------------------|        |--------------|       |
-   |  -------->|0          |                    |         INTCIO           |        |  orgates[0]  |       |
+   |   ------->|0          |                    |         INTCIO           |        |  orgates[0]  |       |
    |   ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|------->| 0            |       |
-   |  -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|------->| 1            |       |
+   |   ------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|------->| 1            |       |
    |   ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|------->| 2            |       |
-   |  -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|------->| 3  OR[0:9]   |-----| |
+   |   ------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|------->| 3  OR[0:9]   |-----| |
    |   UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|------->| 4            |     | |
-   |  -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|------->| 5            |     | |
+   |   ------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|------->| 5            |     | |
    |   UART1   |         22|   orgates[6]------>|inpin[6]-------->outpin[6]|------->| 6            |     | |
-   |  -------->|8        23|   orgates[7]------>|inpin[7]-------->outpin[7]|------->| 7            |     | |
+   |   ------->|8        23|   orgates[7]------>|inpin[7]-------->outpin[7]|------->| 7            |     | |
    |   UART2   |         24|   orgates[8]------>|inpin[8]-------->outpin[8]|------->| 8            |     | |
-   |  -------->|9        25|   orgates[9]------>|inpin[9]-------->outpin[9]|------->| 9            |     | |
+   |   ------->|9        25|   orgates[9]------>|inpin[9]-------->outpin[9]|------->| 9            |     | |
    |   UART3   |         26|                    |--------------------------|        |--------------|     | |
-   |  ---------|10       27|                                                                             | |
+   |   ------->|10       27|                                                                             | |
    |   UART5   |         28|                                                                             | |
-   |  -------->|11       29|                                                                             | |
+   |   ------->|11       29|                                                                             | |
    |   UART6   |           |                                                                             | |
-   |  -------->|12       30|     |-----------------------------------------------------------------------| |
+   |   ------->|12       30|     |-----------------------------------------------------------------------| |
    |   UART7   |         31|     |                                                                         |
-   |  -------->|13         |     |                                                                         |
-   |   UART8   |  OR[0:31] |     |                |------------------------------|           |----------|  |
-   |  -------->|14         |     |                |            INTC              |           |     GIC  |  |
-   |   UART9   |           |     |                |inpin[0:0]--------->outpin[0] |---------->|192       |  |
-   |  -------->|15         |     |                |inpin[0:1]--------->outpin[1] |---------->|193       |  |
-   |   UART10  |           |     |                |inpin[0:2]--------->outpin[2] |---------->|194       |  |
-   |  -------->|16         |     |                |inpin[0:3]--------->outpin[3] |---------->|195       |  |
-   |   UART11  |           |     |--------------> |inpin[0:4]--------->outpin[4] |---------->|196       |  |
-   |  -------->|17         |                      |inpin[0:5]--------->outpin[5] |---------->|197       |  |
-   |   UART12  |           |                      |inpin[0:6]--------->outpin[6] |---------->|198       |  |
-   |  -------->|18         |                      |inpin[0:7]--------->outpin[7] |---------->|199       |  |
-   |           |-----------|                      |inpin[0:8]--------->outpin[8] |---------->|200       |  |
-   |                                              |inpin[0:9]--------->outpin[9] |---------->|201       |  |
-   |-------------------------------------------------------------------------------------------------------|
-   |-------------------------------------------------------------------------------------------------------|
-   |  ETH1    |-----------|     orgates[1]------->|inpin[1]----------->outpin[10]|---------->|128       |  |
-   | -------->|0          |     orgates[2]------->|inpin[2]----------->outpin[11]|---------->|129       |  |
-   |  ETH2    |          4|     orgates[3]------->|inpin[3]----------->outpin[12]|---------->|130       |  |
-   | -------->|1         5|     orgates[4]------->|inpin[4]----------->outpin[13]|---------->|131       |  |
-   |  ETH3    |          6|---->orgates[5]------->|inpin[5]----------->outpin[14]|---------->|132       |  |
-   | -------->|2        19|     orgates[6]------->|inpin[6]----------->outpin[15]|---------->|133       |  |
-   |  UART0   |         20|     orgates[7]------->|inpin[7]----------->outpin[16]|---------->|134       |  |
-   | -------->|7        21|     orgates[8]------->|inpin[8]----------->outpin[17]|---------->|135       |  |
-   |  UART1   |         22|     orgates[9]------->|inpin[9]----------->outpin[18]|---------->|136       |  |
-   | -------->|8        23|                       |------------------------------|           |----------|  |
-   |  UART2   |         24|                                                                                |
-   | -------->|9        25|                       AST2700 A0 Design                                        |
-   |  UART3   |         26|                                                                                |
-   | -------->|10       27|                                                                                |
-   |  UART5   |         28|                                                                                |
-   | -------->|11       29| GICINT132                                                                      |
-   |  UART6   |           |                                                                                |
-   | -------->|12       30|                                                                                |
-   |  UART7   |         31|                                                                                |
-   | -------->|13         |                                                                                |
-   |  UART8   |  OR[0:31] |                                                                                |
-   | -------->|14         |                                                                                |
-   |  UART9   |           |                                                                                |
-   | -------->|15         |                                                                                |
-   |  UART10  |           |                                                                                |
-   | -------->|16         |                                                                                |
-   |  UART11  |           |                                                                                |
-   | -------->|17         |                                                                                |
-   |  UART12  |           |                                                                                |
-   | -------->|18         |                                                                                |
-   |          |-----------|                                                                                |
+   |   ------->|13         |     |                                                                         |
+   |   UART8   |  OR[0:31] |     |                |-----------------------------|          |----------|    |
+   |   ------->|14         |     |                |            INTC             |          |     GIC  |    |
+   |   UART9   |           |     |                |inpin[0:0]--------->outpin[0]|--------->|192       |    |
+   |   ------->|15         |     |                |inpin[0:1]--------->outpin[1]|--------->|193       |    |
+   |   UART10  |           |     |                |inpin[0:2]--------->outpin[2]|--------->|194       |    |
+   |   ------->|16         |     |                |inpin[0:3]--------->outpin[3]|--------->|195       |    |
+   |   UART11  |           |     |--------------> |inpin[0:4]--------->outpin[4]|--------->|196       |    |
+   |   ------->|17         |                      |inpin[0:5]--------->outpin[5]|--------->|197       |    |
+   |   UART12  |           |                      |inpin[0:6]--------->outpin[6]|--------->|198       |    |
+   |   ------->|18         |                      |inpin[0:7]--------->outpin[7]|--------->|199       |    |
+   |           |-----------|                      |inpin[0:8]--------->outpin[8]|--------->|200       |    |
+   |                                              |inpin[0:9]--------->outpin[9]|--------->|201       |    |
+   |                                              |-----------------------------|          |----------|    |
+   |                                                                                                       |
    |                                                                                                       |
    |-------------------------------------------------------------------------------------------------------|
+
-- 
2.43.0


