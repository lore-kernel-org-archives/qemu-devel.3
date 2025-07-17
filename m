Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B1C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFZ5-0001GB-Td; Wed, 16 Jul 2025 23:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVn-000447-BO; Wed, 16 Jul 2025 23:42:23 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVk-0000g2-Fr; Wed, 16 Jul 2025 23:42:22 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:41:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:41:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP SCU
 initialization support
Date: Thu, 17 Jul 2025 11:40:47 +0800
Message-ID: <20250717034054.1903991-20-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
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

The updated boot ROM includes logic to initialize and enable SSP/TSP using SCU
registers, based on reserved-memory regions defined in the device tree.

Its source code is available at:
https://github.com/google/vbootrom/commit/f9eb0bb57decbab860a81712c56132c2102fa98e

Build Information:
Build Date : Jul 17 2025 02:26:07
FW Version : git-f9eb0bb

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 17192 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
index 0b9b3a2360e375bb6007ecdf13b39d931870f6fa..339ae7ca8759b9e4e0100bf6e123963bccab4920 100644
GIT binary patch
delta 6044
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
Q=h!2QQpE{_x+?kq0rxu(?EnA(

delta 4461
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
S@EX)+x=|G_%m|U^82$?nlNqA`

-- 
2.43.0


