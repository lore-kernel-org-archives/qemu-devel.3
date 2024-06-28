Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E68C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5hu-0002AY-DI; Fri, 28 Jun 2024 03:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hs-0001pY-7D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hq-0003Nc-7N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso2459845e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558456; x=1720163256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XRCv4iSMQzY9gbLa0i76FE3UzK8b0j6S+r+3bKGRI48=;
 b=ZL8cUdtz33+OwEurvP/8DR4sgSPT3BTHrDQSd2nYVhaLa7uqK51daucDwKEj7JgoJb
 n8w0MpikwlwCdGp1aVs+q46U6PauhZHNhYZt1XqKkNbwbz8DnHGOnALKZ7qAXdhuafo8
 NHOT58HTk3Zn+qKDuossDfcItwA99fVjm9DdAfKmENerQ4Qa8HqLqweT3nptXiyRk8P5
 a12LVAyyKkptevfF2YIUUZ6pAfHj/Tetp1ICPqwZ2migJRgfKD2E7fvsn1Xpi64pnFQc
 x7wTG3ptMaiSPLGyMJdBtxFmU9Vp0tBcJSnvrSYkQZlXR78edA+JR2VMDk1PkTOSxRvO
 UU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558456; x=1720163256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRCv4iSMQzY9gbLa0i76FE3UzK8b0j6S+r+3bKGRI48=;
 b=ZPer5+47r+r/31SYWTr0Rg/5CxQIsWoHamcNzqnSoeBULMFz4aJlVrdCHJEaNFd4Jq
 KcQwKCaaLvsJrolipCfEDRdld9HYB0A5o79MRBV980zp2kl/lzTGsc5u+wfTWG9johD0
 tdV3gsIPbXDRAbIaFj8c1gfrSKV5QqSBqiGIgfad6TgAvOG5UIMlxgzJlr5AT6ixWLx4
 atNFRiynQ6EmvMtjmM8U34P8bkZTCqDAL+V92611uPvBpy0+mTyLJqMQio4ums8Zm503
 HIFTqjHRKni8DnUC0WkLey689mtg0UoEpA4s7ILztI5KbIl3dZ9SPx7l+ikqoP9sDo2s
 WMDg==
X-Gm-Message-State: AOJu0YxC/qPlUEf646OB6AJmc4b83W5MJ5GosM38RsEnba5ooF6ZCSdV
 /eJxCPiKST8b58VdlS4s54TOZ53BF5fnGmj6ExapsN+SJkSVQ1NLtrJ69RLfcOvtb61TWxjOLWi
 FLmI=
X-Google-Smtp-Source: AGHT+IGI9WenqsVuYx2a0/zzArYjwDmH9wF0nfm3gIMUh3XiG5o5ZT/09zWjyJm3PxCBSD+PLvWSOw==
X-Received: by 2002:a05:600c:16c4:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-4255ec35786mr42332155e9.35.1719558456450; 
 Fri, 28 Jun 2024 00:07:36 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b099c72sm21095405e9.37.2024.06.28.00.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 50/98] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
Date: Fri, 28 Jun 2024 09:01:26 +0200
Message-ID: <20240628070216.92609-51-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e2f7e99ea2..bd7c7cf518 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,8 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [9]    = "SEND_CSD",
-        [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
@@ -1324,6 +1322,26 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
     return sd_r7;
 }
 
+/* CMD9 */
+static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    return sd_req_rca_same(sd, req) ? sd_r2_s : sd_r0;
+}
+
+/* CMD10 */
+static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1393,12 +1411,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 9:  /* CMD9:   SEND_CSD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
-        case sd_standby_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            return sd_r2_s;
-
         case sd_transfer_state:
             if (!sd_is_spi(sd)) {
                 break;
@@ -1414,12 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 10:  /* CMD10:  SEND_CID */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
-        case sd_standby_state:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            return sd_r2_i;
-
         case sd_transfer_state:
             if (!sd_is_spi(sd)) {
                 break;
@@ -2307,6 +2313,8 @@ static const SDProto sd_proto_sd = {
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
+        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
+        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


