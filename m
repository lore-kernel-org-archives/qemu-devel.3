Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058DBE83063
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnC9g-0004p5-Fl; Tue, 03 Feb 2026 03:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9f-0004kd-5t; Tue, 03 Feb 2026 03:53:03 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9d-0002qU-NH; Tue, 03 Feb 2026 03:53:02 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:33 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:33 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v2 08/20] hw/i3c/dw-i3c: Add register RO field masks
Date: Tue, 3 Feb 2026 16:52:08 +0800
Message-ID: <20260203085229.1543287-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

Adds read-only register masks for the DwC I3C controller.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 7bb33c7a9e..02fa9b3c00 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0x00000023,
 };
 
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
+    [R_DEVICE_CTRL]                 = 0x04fffe00,
+    [R_DEVICE_ADDR]                 = 0x7f807f80,
+    [R_HW_CAPABILITY]               = 0xffffffff,
+    [R_IBI_QUEUE_STATUS]            = 0xffffffff,
+    [R_DATA_BUFFER_THLD_CTRL]       = 0xf8f8f8f8,
+    [R_IBI_QUEUE_CTRL]              = 0xfffffff0,
+    [R_RESET_CTRL]                  = 0xffffffc0,
+    [R_SLV_EVENT_CTRL]              = 0xffffff3f,
+    [R_INTR_STATUS]                 = 0xffff809f,
+    [R_INTR_STATUS_EN]              = 0xffff8080,
+    [R_INTR_SIGNAL_EN]              = 0xffff8080,
+    [R_INTR_FORCE]                  = 0xffff8000,
+    [R_QUEUE_STATUS_LEVEL]          = 0xffffffff,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0xffffffff,
+    [R_PRESENT_STATE]               = 0xffffffff,
+    [R_CCC_DEVICE_STATUS]           = 0xffffffff,
+    [R_I3C_VER_ID]                  = 0xffffffff,
+    [R_I3C_VER_TYPE]                = 0xffffffff,
+    [R_DEVICE_ADDR_TABLE_POINTER]   = 0xffffffff,
+    [R_DEV_CHAR_TABLE_POINTER]      = 0xffcbffff,
+    [R_SLV_PID_VALUE]               = 0xffff0fff,
+    [R_SLV_CHAR_CTRL]               = 0xffffffff,
+    [A_VENDOR_SPECIFIC_REG_POINTER] = 0xffffffff,
+    [R_SLV_MAX_LEN]                 = 0xffffffff,
+    [R_MAX_READ_TURNAROUND]         = 0xffffffff,
+    [R_MAX_DATA_SPEED]              = 0xffffffff,
+    [R_SLV_INTR_REQ]                = 0xfffffff0,
+    [R_SLV_TSX_SYMBL_TIMING]        = 0xffffffc0,
+    [R_DEVICE_CTRL_EXTENDED]        = 0xfffffff8,
+    [R_SCL_I3C_OD_TIMING]           = 0xff00ff00,
+    [R_SCL_I3C_PP_TIMING]           = 0xff00ff00,
+    [R_SCL_I2C_FMP_TIMING]          = 0xff000000,
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   = 0x0000fff0,
+    [R_BUS_IDLE_TIMING]             = 0xfff00000,
+    [R_EXTENDED_CAPABILITY]         = 0xffffffff,
+    [R_SLAVE_CONFIG]                = 0xffffffff,
+};
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
 
     trace_dw_i3c_write(s->id, offset, value);
 
+    value &= ~dw_i3c_ro[addr];
     switch (addr) {
     case R_HW_CAPABILITY:
     case R_RESPONSE_QUEUE_PORT:
-- 
2.43.0


