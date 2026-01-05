Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0EFC79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8p-0003z7-QI; Mon, 05 Jan 2026 07:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8d-0003rr-Fj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8a-0007y7-Ai
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgScfA+yBMg9P14PP4V/MiHScFQJmqGIiDTtMN/i71M=;
 b=gB/3qHBSj6zaqY9EBPeh8A0E2F599cO2sIG7FSf8EuUUF5bVuTUrcv9PZLjVqCHDs7AUtQ
 jLCGDXEMPII5Pg9S/BD+TLi7izq+qI5CeITcriGexuFh8DTWQLEo+1RAmGKSvFnkG4Fk3D
 6FoYAPnbNskrOzNDdKSpqogUrGGy1eU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-8cl8JiOOMnisCgN6ZjEUIg-1; Mon,
 05 Jan 2026 07:56:40 -0500
X-MC-Unique: 8cl8JiOOMnisCgN6ZjEUIg-1
X-Mimecast-MFC-AGG-ID: 8cl8JiOOMnisCgN6ZjEUIg_1767617799
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7024B1956096; Mon,  5 Jan 2026 12:56:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1B9E19560A7; Mon,  5 Jan 2026 12:56:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/36] docs/system/arm/aspeed: Update Aspeed MiniBMC section to
 include AST1060 processor
Date: Mon,  5 Jan 2026 13:55:48 +0100
Message-ID: <20260105125613.622667-12-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Added details describing AST1060 as a Platform Root of Trust processor board alongside
AST1030 MiniBMC, and extended the list of missing devices to include
SMBus Filter and QSPI Monitor controllers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 81a96994559c..4fa1739cb549 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -448,23 +448,24 @@ Use ``tio`` or another terminal emulator to connect to the consoles:
    $ tio /dev/pts/57
 
 
-Aspeed minibmc family boards (``ast1030-evb``)
-==================================================================
+Aspeed MiniBMC and Platform Root of Trust processor family boards (``ast1030-evb``, ``ast1060-evb``)
+====================================================================================================
 
-The QEMU Aspeed machines model mini BMCs of various Aspeed evaluation
-boards. They are based on different releases of the
-Aspeed SoC : the AST1030 integrating an ARM Cortex M4F CPU (200MHz).
+The QEMU Aspeed machines model mini BMCs and Platform Root of Trust processors of various Aspeed
+evaluation boards. They are based on different releases of the Aspeed SoC : the AST1030 (MiniBMC)
+and AST1060 (Platform Root of Trust Processor), both integrating an ARM Cortex M4F CPU (200MHz).
 
 The SoC comes with SRAM, SPI, I2C, etc.
 
-AST1030 SoC based machines :
+AST10x0 SoC based machines :
 
 - ``ast1030-evb``          Aspeed AST1030 Evaluation board (Cortex-M4F)
+- ``ast1060-evb``          Aspeed AST1060 Evaluation board (Cortex-M4F)
 
 Supported devices
 -----------------
 
- * SMP (for the AST1030 Cortex-M4F)
+ * SMP (for the Cortex-M4F)
  * Interrupt Controller (VIC)
  * Timer Controller
  * I2C Controller
@@ -492,6 +493,8 @@ Missing devices
  * Virtual UART
  * eSPI Controller
  * I3C Controller
+ * SMBus Filter Controller
+ * QSPI Monitor Controller
 
 Boot options
 ------------
@@ -507,4 +510,4 @@ To boot a kernel directly from a Zephyr build tree:
 .. code-block:: bash
 
   $ qemu-system-arm -M ast1030-evb -nographic \
-        -kernel zephyr.elf
+        -kernel zephyr.bin
-- 
2.52.0


