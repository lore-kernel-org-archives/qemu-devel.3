Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2991FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiw-000430-Ma; Tue, 02 Jul 2024 05:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZit-0003o1-B1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:51 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiq-0006ZT-Em
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:50 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so40017701fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912165; x=1720516965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBkJoq7dOcnQq6fmt+Em92zeZnpvlQPX8gCdahknyqk=;
 b=kzuPDa3Zz6pVKl94q0SKXxpKunVP0+WqlhrIoLJ0Z29jkWhu5XHUeouhb+sF2TDxSO
 Hj7HzHOsfPHd005v3l1F5Qsayc5Kh5Nx3Ss1RXneVdrtyS2/yeSiCNQAHVyX8dRFfMzL
 yVQ8nApTNnoWPUaTT0pATGKVAN3pTIbmCSoVyhOuPwWA6ed5ckp2nzWMNKPb0RvQnXUi
 HFme/vm0sYtthxSdBSovjEdS5WhIbfWcw/dkc6RFYVJxCXfcX7CHjb+ipSJXC6O9jZua
 KQQeOmzPZZeN72ADsNKlyBw+I5NeofBN1zaNfaDM+GjJXvoMBIIDM5KEl8locRF6OYvt
 A0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912165; x=1720516965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBkJoq7dOcnQq6fmt+Em92zeZnpvlQPX8gCdahknyqk=;
 b=hCYsW/WBQBxCCZW6kVrDPaTPzTb/L/z4tGQj5BDEJKW6sSp6atoY5Ytkm9G7ZPwR9z
 6N28oEbUQw3d9gyAopVihz1VslJbhR6aN92Cyf6oGKGaCu7a0r4qBtUpg9vTFuFQqGzw
 Vm1Icf6G1BrQgiLTDq7XfVB1hINm+U1SUCx4dOkl854qKhWjnpJEhJHFx7Cs4wtip2VX
 iB/XxK2lfcavJUm2C/pW5xpIqyO2oblVqg3lRyYJSMJfzrDMRqCqQvwphjrA3t2LmRq7
 RaPaevYmynCzQLI+6LP3YPjVOKTx9T/n3eu0q+RtTmZ4vY3pkfE7YBqWadbT91G2F2nh
 hxpA==
X-Gm-Message-State: AOJu0YxaSQpWnmjAr8cXcgmW2ys5YYefjFNCtwBiXnt4c8OjppM7ApFt
 JNp1sXfi8zBA8p/rKsUOd+O2Ib22/+CdAG2SGklUw61zhqsVFxPxvsYGUp9uiPXDeHLo8pvONUc
 1
X-Google-Smtp-Source: AGHT+IH0bdCVU5IvAmNVnMCdlR6TZPd9sIJ7ldvg3K3wepqgr870phppDEbNxaDm8QKHOo8o/ObwiQ==
X-Received: by 2002:a2e:88d1:0:b0:2ec:53a9:2037 with SMTP id
 38308e7fff4ca-2ee5e6f2bcdmr50533321fa.37.1719912165465; 
 Tue, 02 Jul 2024 02:22:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367898c64c1sm989990f8f.23.2024.07.02.02.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/67] hw/sd/sdcard: Convert SEND_TUNING_BLOCK to
 generic_read_byte (CMD19)
Date: Tue,  2 Jul 2024 11:20:02 +0200
Message-ID: <20240702092051.45754-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-24-philmd@linaro.org>
---
 hw/sd/sd.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8415c23e20..940cbb0d3c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -564,6 +564,21 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
+static const uint8_t sd_tuning_block_pattern4[64] = {
+    /*
+     * See: Physical Layer Simplified Specification Version 3.01,
+     * Table 4-2.
+     */
+    0xff, 0x0f, 0xff, 0x00,     0x0f, 0xfc, 0xc3, 0xcc,
+    0xc3, 0x3c, 0xcc, 0xff,     0xfe, 0xff, 0xfe, 0xef,
+    0xff, 0xdf, 0xff, 0xdd,     0xff, 0xfb, 0xff, 0xfb,
+    0xbf, 0xff, 0x7f, 0xff,     0x77, 0xf7, 0xbd, 0xef,
+    0xff, 0xf0, 0xff, 0xf0,     0x0f, 0xfc, 0xcc, 0x3c,
+    0xcc, 0x33, 0xcc, 0xcf,     0xff, 0xef, 0xff, 0xee,
+    0xff, 0xfd, 0xff, 0xfd,     0xdf, 0xff, 0xbf, 0xff,
+    0xbb, 0xff, 0xf7, 0xff,     0xf7, 0x7f, 0x7b, 0xde
+};
+
 static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
@@ -1153,14 +1168,9 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
         return sd_cmd_illegal(sd, req);
     }
 
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
-    }
-
-    sd->state = sd_sendingdata_state;
-    sd->data_offset = 0;
-
-    return sd_r1;
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 sd_tuning_block_pattern4,
+                                 sizeof(sd_tuning_block_pattern4));
 }
 
 /* CMD23 */
@@ -2093,20 +2103,6 @@ void sd_write_byte(SDState *sd, uint8_t value)
     }
 }
 
-#define SD_TUNING_BLOCK_SIZE    64
-
-static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
-    /* See: Physical Layer Simplified Specification Version 3.01, Table 4-2 */
-    0xff, 0x0f, 0xff, 0x00,         0x0f, 0xfc, 0xc3, 0xcc,
-    0xc3, 0x3c, 0xcc, 0xff,         0xfe, 0xff, 0xfe, 0xef,
-    0xff, 0xdf, 0xff, 0xdd,         0xff, 0xfb, 0xff, 0xfb,
-    0xbf, 0xff, 0x7f, 0xff,         0x77, 0xf7, 0xbd, 0xef,
-    0xff, 0xf0, 0xff, 0xf0,         0x0f, 0xfc, 0xcc, 0x3c,
-    0xcc, 0x33, 0xcc, 0xcf,         0xff, 0xef, 0xff, 0xee,
-    0xff, 0xfd, 0xff, 0xfd,         0xdf, 0xff, 0xbf, 0xff,
-    0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
-};
-
 uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
@@ -2135,6 +2131,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
+    case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2169,13 +2166,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
-        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
-            sd->state = sd_transfer_state;
-        }
-        ret = sd_tuning_block_pattern[sd->data_offset++];
-        break;
-
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         ret = sd->data[sd->data_offset ++];
 
-- 
2.41.0


