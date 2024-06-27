Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F80C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsAC-0002Jm-MG; Thu, 27 Jun 2024 12:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAA-0002Cn-GI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsA7-0006wM-BE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so13077225e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506393; x=1720111193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7w8iWHuHLj1qqdMh1OWVQD6LygpPO88gA0me6KT8+s=;
 b=xulGlB35WaTYVPJLVTnASDz/Udifw7yu7EcAf/k8MV/U8fdDRRaHqh/g3NC41JHlqK
 u+S+gix1r+k8ZM/CQdhGyyda7YPZ1YKPXWbwfsZXJVhtzIFEcrgxBbiDQSXP6IzzKOZ5
 wWPwQX5Z/umc/UHqyhBeMDqUdJG3NWckRZBg1d++fCsjokVSd8XBfwLm8pjxvX+VQ1VU
 DLHSnbKZhFp7fI4me+Eo0yMeCdzt1uqZ2pC30L+F+m2Yf8L27SyeTNvzW67ubxrz6rXU
 aQCU3Wt3dek9BNZvT7c0WUTQBCrGV8cOODhd3NtH9TQPOoyJp7oHzEp6rTMtEMUktzeV
 timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506393; x=1720111193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7w8iWHuHLj1qqdMh1OWVQD6LygpPO88gA0me6KT8+s=;
 b=GJwhaRdVqVHXt1vc3XzOe/6xSXinAapHss7YXI6Nb7rZnUpAD2ilKheLQ/I4Gf8HXU
 ZpOurDl6c+e5UN6A5OgBKtJsIgxK8OOndb5r4+Vmsb/qXg9wPfqpAJ7pB2b7iFvRKG7x
 hhWbFGYzKWYR+XxcIREiJf8m1tW+hBrbbNwEfFk3/1+AdRJxxjlvbTA+mdSFEFdOJ7er
 y30v6npYof704cZzw8KxAyHhnzvqWOwA9zvDjjRxR+diS1aBl5RWeK4WTmGQxlsYB1rE
 abAJ8nQI9LrxVQWMIoPF/AHKGJ+CwxmFsBZey1BcEE3lM3/HQ+ZnhDFw3wrg8E2dlVlW
 GNGg==
X-Gm-Message-State: AOJu0YyEPUABeC7Sp/DAZ/504xBBUSLip+CWd/A0Xo355i480l0159al
 N/GzL2C2SwTqudbnsVh8leB5GYPFS2EJyLv4FzCeLRF294CYDCXP8sIxR3zZfcNE/hIJPOlItDp
 W3wc=
X-Google-Smtp-Source: AGHT+IHz4JjI/2GXWRzm1fXsk+9MIfvigT1nS3xwfMxaU1tdycBy3ddrHKtK8IfTzbTauNVuzP0kww==
X-Received: by 2002:a05:600c:4a06:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-42563126c2dmr32558455e9.19.1719506393602; 
 Thu, 27 Jun 2024 09:39:53 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82519c8sm77443365e9.16.2024.06.27.09.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:39:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 06/11] hw/sd/sdcard: Store command class in SDProto
Date: Thu, 27 Jun 2024 18:38:38 +0200
Message-ID: <20240627163843.81592-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


