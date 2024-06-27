Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1906C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrzI-0002lX-R5; Thu, 27 Jun 2024 12:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzD-0002fK-2J
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzB-0003UK-BL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4248ff53f04so35300975e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505715; x=1720110515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xyhvw/6qmXFus9eORwXzq1Iu5gU3BghWHGLoDUVW4O4=;
 b=G7uzp2qrNIcGqlouSW4SF+VIDuGX6y1EmnUeCs3txzGzI2//5IRpo67FvokbnB0Fs8
 6NxCybFLaT/4R0rXbv2ZBo45E0GF1UrKcQtosQ8DKGQZw2rmtsnJ07QwBIEQFv/2jyb5
 mtZEmNmUgsi/E+WJvboTV/+bdjGrUzeGdDssc7OWGVLkioTGQedmRZfmiOO+m6RxrBfR
 UllzfeIr482v3SSEdCrSNzhrhm2ee2ALsA62yzpXqkqKBgdrA7z7QZVOnujo52mo1O86
 KQC2HK5UTpNmMMIdciIjWDXbNUmB0iA2UDTDdb0VEKPuuR/hDnIuIbcT9GtAzTOYKSUl
 1ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505715; x=1720110515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xyhvw/6qmXFus9eORwXzq1Iu5gU3BghWHGLoDUVW4O4=;
 b=M39DxUq9ufK4J/qJWo6ID3BIX3hqOC4VARmKy1tpH2RAT+vsGRR148H1OdHL4c0L68
 2W9bMfaX0vdtofKVS6RbJ0j9ta2Q5cehIIa8hCv5VeBgBxBXlGfbTAuODs4yOCeQzW75
 jBAy8xmPDzAgJhaZKU5U9PkzcQHGqTr3Zlrqj5yIeA57N2N5YOBD/XefM/fVrza0/0wQ
 YkDNF52ppiJJbPslM7UIzdtOiimoAAV+y/L67XOia6xggyS8ET8TSrG6FZas+d3bEYUB
 Yyz9qr35yRUUTOQYaznTrZtFz6g/F4tDP3l+3jvykFlFxXMmCj6VBGkSoQgzaJMH9x5s
 m/zA==
X-Gm-Message-State: AOJu0Yyi5DVSIJBmVX7gGc8NhG3lnP3zYsynJEutQuOdf/QkVSfNxYXS
 1QwGkc1zIo2LNWTJsq1PFH2NiTj5GGtMnZa3cboo9YbQkR8Du/A6W4tS1QO+6QvWQCa1vX/K+T/
 V2xE=
X-Google-Smtp-Source: AGHT+IFBWugtaTy3dsO2ravo7MU6jX9ArF5ah+iYrFysZYWQ/RB1Gfy2NEUOVv7mW2UzWj67lIF6og==
X-Received: by 2002:a05:600c:25a:b0:425:6001:6637 with SMTP id
 5b1f17b1804b1-4256001679fmr30535685e9.1.1719505715590; 
 Thu, 27 Jun 2024 09:28:35 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8246828sm76479825e9.5.2024.06.27.09.28.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:28:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 06/11] hw/sd/sdcard: Convert SEND_TUNING_BLOCK to
 generic_read_byte (CMD19)
Date: Thu, 27 Jun 2024 18:27:24 +0200
Message-ID: <20240627162729.80909-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 605269163d..eece33194a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -568,6 +568,21 @@ static void sd_set_sdstatus(SDState *sd)
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
@@ -1161,14 +1176,9 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
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
@@ -2100,20 +2110,6 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2142,6 +2138,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
+    case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2176,13 +2173,6 @@ uint8_t sd_read_byte(SDState *sd)
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


