Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972CEC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsFa-0004aL-8Y; Thu, 27 Jun 2024 12:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFX-0004O0-Jt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFV-000097-Sg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so11699445e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506727; x=1720111527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vajGPnoCMySfBXhKCpWI2G0uKNcFQdTzNyXEs7BknL8=;
 b=QDtB5SaHqjz97rDRqfAqOmYo0U7u9C+9bI74EDd9DCL1EDfhVH7JsDd9Gk+fREDPe9
 5ta6rqFQZGYy+1/Q/YcLePV7bXS/yv659fh6ySOAOBUJNx8r7amrmhAUhDPRu7qWHTiz
 y45JGE3PtjP2P7mAxyGrDis+7MyyIy6RgPvyMLgm2RR/ku/gSX5zQHsnzv2GQqpd78di
 MYf0XRwjsxwIu0ZuLGzkGMvvxvivdKGqj6iii/ZZDcMSwAkuVJ0jQSNVFi9w4SXAQhiN
 t38EKkAJ9LADLNZVsfcbU6bgAgf3za1LzZJPQwMXNfjgWvZWxp4TCPooPjoidfqDyBxJ
 fHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506727; x=1720111527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vajGPnoCMySfBXhKCpWI2G0uKNcFQdTzNyXEs7BknL8=;
 b=cQj+Yqfl5OSOlsXHMEDmZn7oGYs78/D+kXs5/9XFGiMLiWjng0YWhnv+QjOSJjRXKR
 GehDbHWZsC1+Qjv9b6in1ndTs1tyA1EKfaocYZTgHFSYWqKUmu78KMm82/owvMcPF2P1
 W5QctsUeHF53UXk5EsW5werM+w4s3ciR4Ttyz51vQxgZKXE1HtgLsaC805gHdiR09bur
 ib7C1M7uIwyKYx05XPLZ5TfLeE0UeB2YuWsuo+KaKUaqb9iikPBlJlUmPYrEJC9I1rt1
 qMx2IM1iagDRjwCMwvefhvsckXgUlbFnsRVxF4rPymXvrNJKo/ZXpcbKFYTMmzFn2rm2
 1eHQ==
X-Gm-Message-State: AOJu0YyQ46D8EucMd9y4nMHliP4pP0DCEPbFrsbWN73ylknJnbfE4eiu
 9gaTP6rUYeDoE3322zDm2yjSK10jS93D41Ey7n4GB+6hhysfA0fGRyJw887Mf3mUQ/uM4gCBgKM
 9yJk=
X-Google-Smtp-Source: AGHT+IFajDSTOjQRK81WtD7GfKbnpFHt+3JmotbK081RWOrL4gtHRVh52XqtQF0L3w1czxkbC4PhVA==
X-Received: by 2002:a5d:46c2:0:b0:360:9cf4:58ce with SMTP id
 ffacd0b85a97d-366e96b22damr8635597f8f.46.1719506726806; 
 Thu, 27 Jun 2024 09:45:26 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699a8csm2459238f8f.78.2024.06.27.09.45.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 10/21] hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK handler
 (CMD17)
Date: Thu, 27 Jun 2024 18:43:33 +0200
Message-ID: <20240627164345.82192-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d731c3df58..e2a7ed8b45 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1441,6 +1440,24 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD17 */
+static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    sd_blk_read(sd, addr, sd->blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1507,22 +1524,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
-                return sd_r1;
-            }
-            sd_blk_read(sd, addr, sd->blk_len);
-            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2306,6 +2307,7 @@ static const SDProto sd_proto_spi = {
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2338,6 +2340,7 @@ static const SDProto sd_proto_sd = {
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


