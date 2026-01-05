Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F9EC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckAi-0005dG-VA; Mon, 05 Jan 2026 07:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9Q-0004e4-5a
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9J-00087u-Lh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7PnNdkMr7GqJLMntFWlItt1vMRaPIoDbRubisjevB4=;
 b=jECL6h7EW58y0PbYuwa1u+cDTmE14Szn/FE15Njqq7QXSrRnKe214FUzLwkRtlfrc/LiC4
 k+0GdAW/AZRkun1U1wkJJklvxddgzFhjabJlcNAmFGEamgHjOF46UgBRL+hCgboXTGZxY0
 YQ/2M+5pfVbgAFuteCeVtK2mMCsYRks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-uuIHRbMkMrGZ0TDMv0ZgFg-1; Mon,
 05 Jan 2026 07:57:26 -0500
X-MC-Unique: uuIHRbMkMrGZ0TDMv0ZgFg-1
X-Mimecast-MFC-AGG-ID: uuIHRbMkMrGZ0TDMv0ZgFg_1767617845
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8FC1956053; Mon,  5 Jan 2026 12:57:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C77619560A7; Mon,  5 Jan 2026 12:57:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/36] docs/specs/aspeed-intc: Remove GIC 128 - 136
Date: Mon,  5 Jan 2026 13:56:10 +0100
Message-ID: <20260105125613.622667-34-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The GIC interrupts 128 - 136 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250901040808.1454742-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/specs/aspeed-intc.rst | 92 +++++++++++---------------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

diff --git a/docs/specs/aspeed-intc.rst b/docs/specs/aspeed-intc.rst
index 9cefd7f37f85..892a74a0c357 100644
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
@@ -68,69 +57,38 @@ Block Diagram of GICINT 196 for AST2700 A1 and GICINT 132 for AST2700 A0
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
-- 
2.52.0


