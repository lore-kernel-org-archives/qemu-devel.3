Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8EDC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gq-0002sX-4V; Fri, 28 Jun 2024 03:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ge-0002RQ-JN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gc-0003G5-QW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso3113145e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558381; x=1720163181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7w8iWHuHLj1qqdMh1OWVQD6LygpPO88gA0me6KT8+s=;
 b=n0eXICH0enTkWnUWUIxa9zf1R6DYYIqtxcqFUSyR+JiE1Oq8eozcXW1XxhPyRbRpJ3
 KOPzlWr7HkhFur1EGdly2s0dWVf6EezoquLpYI1RJgo2gQPAbTh9T6z1Cz4+nCiTJw+v
 s4Cwg26LO8fEtYcrw9ISFmcfqWOcL+wc0MqYteImW+Ib5gFvleuE1m9saNYFB95ziD3+
 hSfHRdS9oo5TBUpupdlk3PLgGCs4lSOeuMzX6OVLlUY2RqbPKDTFST0cfiwl6A0ti6Ax
 5nxtNr+49uLegYjqkvomscqIsSbkNoNYVEgOFeEIrEw9ZgTib4k37a0Z67oBN4LA70j7
 dJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558381; x=1720163181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7w8iWHuHLj1qqdMh1OWVQD6LygpPO88gA0me6KT8+s=;
 b=irkfeqAoGQM+Eq0VI6Ne7Kw4saIBeFmACPDhHhZ9uHAfEK4f6jMrdWewhdHIKfSk9I
 tGArufWOGlyIpZkLvq0vzZBkWYrbG1mUlm6KHicaGhisE7cwHPrIlrwDSZFh0VM1bDFi
 sGrq2l0SDiqJ9AQHl4OsIjBVRbrMex4aJoyJZWln9LJ3PaLIQfh3AjS+NPBG2qL7qSe8
 1Kt+9feHVZYWRmEapqwDYJjiM91t05SfIPn4PkVan3KamZutxBPzKuc1d1Lz1WkhhtMh
 Y4nZlbwAHsGfplznMEu9mSCpZe5fZZcqFIga9+5GkLJexTI9akDUG49ZX8FCLGRAI4vN
 vOBA==
X-Gm-Message-State: AOJu0YyveYxksYzt9uwGAfKS6jbB+e5Cs/k4YORU9Kl0dmbj//U8yU8u
 x4/pdm6c3g/tcTnhQOlbs9Pi11rAkzBgWS+Rbb0TT313sGoQws6BygO/7pDkzLCQo70zwKjd2AE
 2wRI=
X-Google-Smtp-Source: AGHT+IECg2eALxMcRI6vn/4t4YWFvTzNSWmjfQdkMymFLExzWlx8Eg0Xpi2xbIWd8ygqJGhD6plxZg==
X-Received: by 2002:a05:600c:5713:b0:421:29cd:5c95 with SMTP id
 5b1f17b1804b1-4248cc27143mr136281765e9.10.1719558381026; 
 Fri, 28 Jun 2024 00:06:21 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af376f5sm21696125e9.6.2024.06.28.00.06.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 41/98] hw/sd/sdcard: Store command class in SDProto
Date: Fri, 28 Jun 2024 09:01:17 +0200
Message-ID: <20240628070216.92609-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Store the command class altogether with the other command
fields (handler, name and type).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c4cc48926d..a816493d37 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 typedef struct SDProto {
     const char *name;
     struct {
+        const unsigned class;
         const sd_cmd_type_t type;
         const char *name;
         sd_cmd_handler handler;
@@ -352,13 +353,6 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const int sd_cmd_class[SDMMC_CMD_MAX] = {
-    0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
-    2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
-    5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
-    7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
-};
-
 static uint8_t sd_crc7(const void *message, size_t width)
 {
     int i, bit;
@@ -1306,7 +1300,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->multi_blk_cnt = 0;
     }
 
-    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+    if (sd->proto->cmd[req.cmd].class == 6 && FIELD_EX32(sd->ocr, OCR,
+                                                         CARD_CAPACITY)) {
         /* Only Standard Capacity cards support class 6 commands */
         return sd_illegal;
     }
@@ -1891,6 +1886,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
 
 static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
 {
+    unsigned cmd_class;
+
     /* Valid commands in locked state:
      * basic class (0)
      * lock card class (7)
@@ -1905,7 +1902,12 @@ static bool cmd_valid_while_locked(SDState *sd, unsigned cmd)
     if (cmd == 16 || cmd == 55) {
         return true;
     }
-    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
+    if (!sd->proto->cmd[cmd].handler) {
+        return false;
+    }
+    cmd_class = sd->proto->cmd[cmd].class;
+
+    return cmd_class == 0 || cmd_class == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -2273,22 +2275,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]  = {    sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [1]  = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41] = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]  = {    sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [2]  = {    sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
-        [3]  = {    sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
-        [19] = {    sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
-        [23] = {    sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


