Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42592C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEN-00019d-JA; Thu, 27 Jun 2024 12:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEA-000143-35
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:09 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsE8-000889-B9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:05 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so97015531fa.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506641; x=1720111441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ES2XtVxvIqjJs8DitaxtSgSyTv7mRCAuBoO550B/vrE=;
 b=YTnYjj71caiQW28Jthawae0FkjipBB1Rk6VfeeDfdGGcQb61cK0JYdkWQpqUpxREsd
 Ix4Tzjw+H7YUnd5CkZ2lRMiMYCrqGP98qEtxCgTti7P3cDzYRJqQcteEVMEF6PWRpK3M
 jsmdAgeZXOCLYAPjMbF/W3t/sGPGgXw9n0TImBljOs6GZ+XH1U1yc7jJQii5L7+hMMfk
 SlypoyhbE3mc9mG86FtSZ8d49o+DnSnQIQJ6J6HV1hwJXFVi59hsaJXh4WpZ6fXOxlWI
 QMrm5Mgx3GVuSAyrp1HkELDQBVAqcPZ0Mdu6q8GCe3k6MBMQrftnjDoltWCynzrfYHfF
 8nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506641; x=1720111441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ES2XtVxvIqjJs8DitaxtSgSyTv7mRCAuBoO550B/vrE=;
 b=Y0K6ejESoNHN2YPcDJxrRXmGv2q15Bxpk1/+i1Bu6A2Em5BDSgSa5mYfJdjBN+59b2
 ZfqWY9n7wyfNdIv/6pB2/dLtnZldQTSyWMvsk7hBs/HvleqL7PAkbVEWTe3kPT9uI/Vm
 96EK/YlXPKnhgQ1MUt8EYHNbiv+jQOnNRwv4pO16y6SYGP50Sff8Wybyp1F+YNJujfqb
 RrMzbR9kKo6eylyw4ryaVZKzbneRT6nZcl5nMVGP1ZUJ/3yrrkyPmiEI/I8SE2uGwfJr
 Dl1qOSLcH0sT8eAiFTA1f7QRuRLjT7RhYWOqwQZNgK47M5xhwjUeU3kh5FM8wohwfmV8
 XmcA==
X-Gm-Message-State: AOJu0YzGROFdCGn6SLQP7vF+QbWFh3T2YlM9BsUQwCPbnUzmvjXsMB1v
 aqrl+lkNd0oo9M0YyI5Ybll9sWSQ+Vh7Krplq+3Z5F30rZejKM1aM5ZVzprycf9lJ9Vp1r6X6us
 1p9o=
X-Google-Smtp-Source: AGHT+IEpCYbOodIODQp4YbQdXTPlc0Yp8MHoqPfEQplT+Gf8x13rTRq3Z6Tyczzu8l5G8HgJO4lfWg==
X-Received: by 2002:a05:651c:1991:b0:2ec:5bb2:c236 with SMTP id
 38308e7fff4ca-2ec5bb2c276mr111947761fa.33.1719506641466; 
 Thu, 27 Jun 2024 09:44:01 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc5af8sm35072135e9.43.2024.06.27.09.43.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 01/21] hw/sd/sdcard: Add sd_cmd_SWITCH_FUNCTION handler (CMD6)
Date: Thu, 27 Jun 2024 18:43:24 +0200
Message-ID: <20240627164345.82192-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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
 hw/sd/sd.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e4941cfdab..61c9aff2fb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
+                                             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
@@ -1244,6 +1244,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD6 */
+static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd_function_switch(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1310,17 +1324,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 6:  /* CMD6:   SWITCH_FUNCTION */
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
-
-        sd_function_switch(sd, req.arg);
-        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
-
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
@@ -2266,6 +2269,7 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2288,6 +2292,7 @@ static const SDProto sd_proto_sd = {
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
+        [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


