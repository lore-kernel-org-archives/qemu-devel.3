Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B8C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 15:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNvSu-0003Ih-Ee; Sat, 07 Jun 2025 11:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uNvSt-0003IY-2d
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:28:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uNvSr-0005fe-8A
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:28:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2320d06b728so26936725ad.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749310086; x=1749914886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzYnQmoGbQ2h6nQSY4r3TBQzxLCj7EIHz8l20WcIL+w=;
 b=gFNBRVqKGwqr/CF4wxiL0v235+2ufcQ9QsJ/jXoyUodZd6s0mMiozljN9XY05Dgt6O
 +mkpq5TbhxmwAPzmHCVuRfujDW5o4tEaNw3sn/ViCvRzH5oHVYj60qx2Ax78qSwjbozu
 5AhoR3WURVotiPhgsy6m6x9j2AvfCo1Xv7TPbJTIEujcDsO2nHSjsKm3zntzBtJ85uau
 +rjQXFhe52m8/3rBNKZrwE5LcNRFWzOhlR3YZ1F/Ktv1XyIj0iPcGA6DvVyOm0GnbWsa
 PRmeFHCXYvObensHUUK9YVrbdik+tvQDKeJLOl5Mq7AzyTUNT7BeFukmFffG5xhwRd38
 k0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749310086; x=1749914886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzYnQmoGbQ2h6nQSY4r3TBQzxLCj7EIHz8l20WcIL+w=;
 b=jnDJkoN63FPxV2V8v5fTsRCnVxGMKcLAYgO/yb9lGzkKiZrmuOfj/wm+qxixh30uJZ
 HWQyWSOJ048eY/7Bi3laJeOvp4MgeCv5YRdUhM+BqgShPuTOJLjBM3ULR50yiU7+IU3s
 pkgcueoD5A11oYYSlwnI+PKLXAyD65EIk2n1TegR8BW48xd1b3n0mHutL8lQPZ6+9dAS
 BkwwYC00UakPDCHejRw8Sa3EG2F7AUZDMMX7GoBLF4KfYq4rb+MCdtb6FOyPpCXoEhGa
 aievPLJd13Ppy6p6ZJYMUzWO83FhffKLZHewQJtnUTV3YZqg26qX4FDalhobN2XCeBLI
 lmAg==
X-Gm-Message-State: AOJu0YzPUoeOpCj7AjzDL8pJPrbfa5OgP41ZC0E+5m1hzCbqAu1DQP6G
 FVlj63n0QNt4eJQh0pgVfsbeW+KjgkSEh3nXN0Du76N1q+73OE5KapjbikvH6i9g
X-Gm-Gg: ASbGnctROHMaVFiP+/v1zRafo846WrO/hpLFb4oNlJc+YKlABb9hNOAz5FtzT1NY/qg
 c+Y679c7O3PJo+LftHdKdt/SUgFYEY4mAbPu1jXlyR3cx2fXu+5Gtq6OsGULypE93NVxgLd5+7U
 Ap+3jzAKqyda0A3eRxYctiQAa8zVAjqaMwI3oxBJXTecYtnt9Etv+zY4Z6X1iqc86VL/if6pR9P
 Te/QyEEEuEluZi8C6YhXA58ndjbfHHXsqeluPLCjEoSa4NRUfecByB2xARXLn5wZGIOD0rqeGd9
 xHdwMvmAhVscS6/gP+k45ayYt0xTOHvaiK00l2D0U3DmcB/jrtjTBweqP9O7jWxPHdJYJ6Ib/is
 19C+XeUJpsDA=
X-Google-Smtp-Source: AGHT+IGForq+xkYj9dOi6MMixZIZ13EN8BgVljycHu6wHSBlu2yQTei9GpEi12ytzrEtqKq9mUtSQQ==
X-Received: by 2002:a17:903:41c8:b0:235:f632:a4d5 with SMTP id
 d9443c01a7336-23601cf096emr110078985ad.9.1749310086451; 
 Sat, 07 Jun 2025 08:28:06 -0700 (PDT)
Received: from fedora.. ([2401:4900:33b6:a3ce:f010:b127:16d4:dabd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236039cb6dasm27796565ad.140.2025.06.07.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 08:28:05 -0700 (PDT)
From: tank0nf <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, deller@gmx.de, jasowang@redhat.com,
 Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH] hw/net/i82596:changed assets link + abstracted configure
 function.
Date: Sat,  7 Jun 2025 20:57:12 +0530
Message-ID: <20250607152711.108914-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii_Ssarkar <soumyajyotisarkar23@gmail.com>

1. Changed the asset link to one which is working from the PARISC website
2. Abstracted the configure function.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

---
 hw/net/i82596.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a5ed66fe47..55d330d3fc 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -5,7 +5,7 @@
  * This work is licensed under the GNU GPL license version 2 or later.
  *
  * This software was written to be compatible with the specification:
- * https://www.intel.com/assets/pdf/general/82596ca.pdf
+ * https://parisc.docs.kernel.org/en/latest/_downloads/96672be0650d9fc046bbcea40b92482f/82596CA.pdf
  */

 #include "qemu/osdep.h"
@@ -178,6 +178,26 @@ static void set_individual_address(I82596State *s, uint32_t addr)
     trace_i82596_new_mac(nc->info_str);
 }

+static void i82596_configure(I82596State *s, uint32_t addr)
+{
+    uint8_t byte_cnt;
+    byte_cnt = get_byte(addr + 8) & 0x0f;
+
+    byte_cnt = MAX(byte_cnt, 4);
+    byte_cnt = MIN(byte_cnt, sizeof(s->config));
+    /* copy byte_cnt max. */
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
+    /* config byte according to page 35ff */
+    s->config[2] &= 0x82; /* mask valid bits */
+    s->config[2] |= 0x40;
+    s->config[7]  &= 0xf7; /* clear zero bit */
+    assert(I596_NOCRC_INS == 0); /* do CRC insertion */
+    s->config[10] = MAX(s->config[10], 5); /* min frame length */
+    s->config[12] &= 0x40; /* only full duplex field valid */
+    s->config[13] |= 0x3f; /* set ones in byte 13 */
+}
+
 static void set_multicast_list(I82596State *s, uint32_t addr)
 {
     uint16_t mc_count, i;
@@ -235,7 +255,6 @@ static void command_loop(I82596State *s)
 {
     uint16_t cmd;
     uint16_t status;
-    uint8_t byte_cnt;

     DBG(printf("STARTING COMMAND LOOP cmd_p=%08x\n", s->cmd_p));

@@ -255,20 +274,7 @@ static void command_loop(I82596State *s)
             set_individual_address(s, s->cmd_p);
             break;
         case CmdConfigure:
-            byte_cnt = get_byte(s->cmd_p + 8) & 0x0f;
-            byte_cnt = MAX(byte_cnt, 4);
-            byte_cnt = MIN(byte_cnt, sizeof(s->config));
-            /* copy byte_cnt max. */
-            address_space_read(&address_space_memory, s->cmd_p + 8,
-                               MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
-            /* config byte according to page 35ff */
-            s->config[2] &= 0x82; /* mask valid bits */
-            s->config[2] |= 0x40;
-            s->config[7]  &= 0xf7; /* clear zero bit */
-            assert(I596_NOCRC_INS == 0); /* do CRC insertion */
-            s->config[10] = MAX(s->config[10], 5); /* min frame length */
-            s->config[12] &= 0x40; /* only full duplex field valid */
-            s->config[13] |= 0x3f; /* set ones in byte 13 */
+            i82596_configure(s, s->cmd_p);
             break;
         case CmdTDR:
             /* get signal LINK */
--
2.49.0


