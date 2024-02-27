Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D53C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexav-00014j-Oo; Tue, 27 Feb 2024 08:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaY-0000pE-NX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0002v6-HN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a38e2adaso16987615e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040814; x=1709645614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/gB32I1sR09/AJAVuS8WOYWpV/CkkUOZlRnkYlseuVI=;
 b=ENMl5WDodGddbLuoHtWzMwLnXO5npR1JCtCocXgxWLEy5qfEasBMvlGKVdJlHvmPUQ
 veCPZOCgd2wt8c4xKj70heU8lnaMd6tpfOFUL9WK0ZMUzm2OuCPPVOJHmk69xQG8vXXK
 aBKi7KAxZwNJo9btsA5xKBHseyowvuodIDJ3aWUuZ+c5Q95+s2qGCBzExTJif1pW4k5E
 CDcirgApa/QtZZiqVGygMT4bM4F5AOdC+0omDn9z2FsQU70W35IIBvXhoQQRs9SxVUho
 ru7h/GOUKyWO0MziNlTUvrccRGxHLTF7O0TEtTbV0zqFyqI+G6dpdKoTztEepvYNQA7f
 IhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040814; x=1709645614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gB32I1sR09/AJAVuS8WOYWpV/CkkUOZlRnkYlseuVI=;
 b=uMMNhmYYqLWaPkL7dCeQOjGV/uXkrKm/e5ma61Er7pgFeCg1X/Ld7fzySSJ4LujdD0
 jeG3b7L7NCgbyGFdLaDgIBOzwnqQvqxxuhVv+wX0pTb3hw4F8dWdaAX0dzeItZ6jzGUa
 hYZ58xhK1G/SSyyifku36VuvVzpP9p9/lMPoPFLnNl23KqeJNcz06cHXzN7XuC4BE+Xz
 vbNmOWv03xM7DIZun1y1exQ2QNjL8TKcDUnDinpDi+29ya5nEqQuaPYpacn/OpUyfBD4
 weXK/p2CUNfG+tZk2slgLzilgNviDPs54PFfhPf6VfbNB1t1p04f/uVckAuteqDbDMMS
 zLig==
X-Gm-Message-State: AOJu0Yx2p3y71vgUAgs11b190XDiXfH7BY0FobXp8wgUKtDyGbyKWFHS
 P5ir9me7sjs/B0n74EePo3FyoC5x7x1HOjIxm7w7mbxI+6qUQ9UR/sDhhWbRkqSqIwELslyjkra
 1
X-Google-Smtp-Source: AGHT+IHJ1HcalN+UjETkF2nZSXEhNw4bEmqs40wBrqSZkokTKmOUZjdrdQ9AjiJE+nUub5N1aJr/NA==
X-Received: by 2002:a05:6000:1364:b0:33d:7e99:babc with SMTP id
 q4-20020a056000136400b0033d7e99babcmr6974817wrz.50.1709040814031; 
 Tue, 27 Feb 2024 05:33:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/45] tests/qtest/bcm2828-mailbox: Add mailbox test constants
Date: Tue, 27 Feb 2024 13:33:05 +0000
Message-Id: <20240227133314.1721857-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-id: 20240226000259.2752893-33-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mailbox.h | 88 +++++++++++++++++++++++++++++++++++
 tests/qtest/bcm2838-mailbox.c |  1 +
 2 files changed, 89 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index e9e1f53bc98..9222b38bad7 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -7,6 +7,94 @@
  * See the COPYING file in the top-level directory.
  */
 
+#define MBOX0_BASE 0xFE00B880
+#define MBOX1_BASE 0xFE00B8A0
+
+#define MBOX_REG_READ   0x00
+#define MBOX_REG_WRITE  0x00
+#define MBOX_REG_PEEK   0x10
+#define MBOX_REG_SENDER 0x14
+#define MBOX_REG_STATUS 0x18
+#define MBOX_REG_CONFIG 0x1C
+
+#define MBOX_READ_EMPTY 0x40000000
+
+#define MBOX_CHANNEL_ID_PROPERTY 8
+
+#define MBOX_PROCESS_REQUEST      0x00000000
+#define MBOX_SUCCESS              0x80000000
+#define MBOX_ERROR_PARSING_BUFFER 0x80000001
+
+#define BOARD_REVISION    0xB03115
+#define FIRMWARE_REVISION 0x548E1
+#define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
+
+#define ARM_MEMORY_BASE 0x00000000
+#define ARM_MEMORY_SIZE 0x3c000000
+#define VC_MEMORY_BASE  0x3c000000
+#define VC_MEMORY_SIZE  0x04000000
+#define VC_FB_BASE      0x3c100000
+#define VC_FB_SIZE      0x00096000
+
+#define CLOCK_ID_ROOT      0x00000000
+#define CLOCK_ID_EMMC      0x00000001
+#define CLOCK_ID_UART      0x00000002
+#define CLOCK_ID_ARM       0x00000003
+#define CLOCK_ID_CORE      0x00000004
+#define CLOCK_ID_UNDEFINED 0x12345678
+
+#define CLOCK_RATE_EMMC 50000000
+#define CLOCK_RATE_UART 3000000
+#define CLOCK_RATE_CORE 350000000
+#define CLOCK_RATE_ANY  700000000
+
+#define DEVICE_ID_SD_CARD   0x00000000
+#define DEVICE_ID_UART0     0x00000001
+#define DEVICE_ID_UART1     0x00000002
+#define DEVICE_ID_USB HCD   0x00000003
+#define DEVICE_ID_I2C0      0x00000004
+#define DEVICE_ID_I2C1      0x00000005
+#define DEVICE_ID_I2C2      0x00000006
+#define DEVICE_ID_SPI       0x00000007
+#define DEVICE_ID_CCP2TX    0x00000008
+#define DEVICE_ID_UNKNOWN_0 0x00000009
+#define DEVICE_ID_UNKNOWN_1 0x0000000a
+
+#define TEMPERATURE_ID_SOC 0x00000000
+
+#define TEMPERATURE_SOC     25000
+#define TEMPERATURE_SOC_MAX 99000
+
+#define ALIGN_4K 4096
+
+#define PIXEL_ORDER_BGR 0
+#define PIXEL_ORDER_RGB 1
+
+#define ALPHA_MODE_ENABLED  0
+#define ALPHA_MODE_REVERSED 1
+#define ALPHA_MODE_IGNORED  2
+
+#define GPIO_MASK 0x003c
+
+#define GPIO_0 0x00000080
+
+#define GPIO_DIRECTION_IN  0
+#define GPIO_DIRECTION_OUT 1
+
+#define GPIO_TERMINATION_DISABLED 0
+#define GPIO_TERMINATION_ENABLED  1
+
+#define GPIO_TERMINATION_PULLUP_DISABLED 0
+#define GPIO_TERMINATION_PULLUP_ENABLED  1
+
+#define GPIO_POLARITY_LOW  0
+#define GPIO_POLARITY_HIGH 1
+
+#define GPIO_STATE_DOWN 0
+
+/* Used to test stubs that don't perform actual work */
+#define DUMMY_VALUE 0x12345678
+
 typedef struct {
     uint32_t size;
     uint32_t req_resp_code;
diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
index 0928a3dff8e..1efd3c628a9 100644
--- a/tests/qtest/bcm2838-mailbox.c
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -11,6 +11,7 @@
 #include "hw/registerfields.h"
 #include "libqtest-single.h"
 #include "bcm2838-mailbox.h"
+#include "hw/arm/raspberrypi-fw-defs.h"
 
 REG32(MBOX_EXCHNG_REG,          0)
 FIELD(MBOX_EXCHNG_REG, CHANNEL, 0, 4)
-- 
2.34.1


