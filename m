Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C4FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs9p-0001Y8-9H; Thu, 27 Jun 2024 12:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9h-0001Nu-H0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9d-0006te-5S
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42562fde108so11848395e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506362; x=1720111162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ayYPHbFG82day0p5Ydj8QW5gkkALIElfBxZi1L4r4c=;
 b=UYIChhUmOJcnleBmcpREt/DgJPWddMA2TOthXEsrrf63wYXiX223GYMFacMhUe/KtA
 wiMXXb6HOokSRjOD8UsltcKZL3gTlr4FFR2H4SSFqoB8eOuXYrgfUZdi1AW7/e32MOw0
 ZvO3W8DhsmjyT8JXWlLgtUddPOGEuooc/Lqr6+t47ZX873Dc0THTqNHkgll6Pv4fFex3
 5GT6O9O/u44Nj1xgRV7/3DqvRtGXlRU9okjVXnDaBwoHMaOoFPcfaL+hFDfhIYAzPCsh
 2eHq8I7wBjF/7ca1lrqizMsXPpOSrCFw++d0YbGYmu43H74Bnt5DEfU+puWWuWmqKFfs
 d7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506362; x=1720111162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ayYPHbFG82day0p5Ydj8QW5gkkALIElfBxZi1L4r4c=;
 b=tXZ4uJBAn9b9fTEyJzD8fQYjKKJ6q10NjjtOFPl594DGiU9OmKJZQKGCYshA5fo1e9
 3FxGJiC4mY1W8r16uE15hT3tdUVaUIILaM9TMQ4zVUqHmXVVvwNOtzjUJwy6JNNz3sGE
 L7vheatvzaQZ97HPwGrGOS8lSdSAP5BAcnWyQdBgpyx7RI9l3KLBAbKM+7aUtJ/b6ICC
 L4/NXuqqqrsxQrkuW+kH6KvNfUgCFrdlrywXbawhQ4KoBBmxUpQTXU+6XXQwuJG24+da
 XYcXUnqa+Qdtr0W1BRTnU/WoiHr62/VhtE/m9WcEUU9PAUsE/mXZjYbf3ytwH6izLPjc
 3DZg==
X-Gm-Message-State: AOJu0Yz6/Dcdg/2g9cLOwbOt5vZA7izJBnJSVFzZx85yJYInQmnwwAKx
 6NWr9u1GOTaIkN8756n9PRO5WTQtKMDtr1/9pJY1YqDLJJ4Lv3stavnj5RQOMIYh3zgaJQBWmfT
 cPbI=
X-Google-Smtp-Source: AGHT+IGvXVVqSPczH3o6EFhpIxgBRbgwc4AtnPWHCM8jhIBb5EPC3AN0isqR0HoBNGq3FBvQ/OuVSA==
X-Received: by 2002:a05:600c:4451:b0:422:62db:5a02 with SMTP id
 5b1f17b1804b1-4248cc586ddmr104512195e9.32.1719506362086; 
 Thu, 27 Jun 2024 09:39:22 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6d33sm35884925e9.37.2024.06.27.09.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 03/11] hw/sd/sdcard: Prepare SDProto to contain more fields
Date: Thu, 27 Jun 2024 18:38:35 +0200
Message-ID: <20240627163843.81592-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Convert array of command handlers to array of structures.
The structure contains the command handler. No logical
change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f4bdd12b26..558c39419d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -94,8 +94,9 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 
 typedef struct SDProto {
     const char *name;
-    sd_cmd_handler cmd[SDMMC_CMD_MAX];
-    sd_cmd_handler acmd[SDMMC_CMD_MAX];
+    struct {
+        sd_cmd_handler handler;
+    } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
 
 struct SDState {
@@ -1305,8 +1306,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd->proto->cmd[req.cmd]) {
-        return sd->proto->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd].handler) {
+        return sd->proto->cmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -1753,8 +1754,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
-    if (sd->proto->acmd[req.cmd]) {
-        return sd->proto->acmd[req.cmd](sd, req);
+    if (sd->proto->acmd[req.cmd].handler) {
+        return sd->proto->acmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -2267,22 +2268,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = spi_cmd_SEND_OP_COND,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [1]  = {spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41]        = spi_cmd_SEND_OP_COND,
+        [41] = {spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [2]         = sd_cmd_ALL_SEND_CID,
-        [3]         = sd_cmd_SEND_RELATIVE_ADDR,
-        [19]        = sd_cmd_SEND_TUNING_BLOCK,
-        [23]        = sd_cmd_SET_BLOCK_COUNT,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [2]  = {sd_cmd_ALL_SEND_CID},
+        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


