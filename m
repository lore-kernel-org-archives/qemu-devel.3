Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2BCC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iv-0005Yn-Uj; Fri, 28 Jun 2024 03:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ih-0005Ee-9l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5if-0004Q7-5K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4256f102e89so1273295e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558507; x=1720163307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PF/YVa5FANPMIRP5k1k++097xYJKGaWnEtemmw/L2o0=;
 b=VKLV4Qu3G/9NEeDZbMn/OtGgeEkYVijO+7ME8dVoz3Z4qO1oIzqfKN8f9O16J42A+1
 i3mQu2BUJGMZNdM7XShf64JkD8VtYA2Bc0qEZsgiKtYe0I0zPXKBWdB0VyCJochoNXaQ
 wL1wagk5AS6wdh11wo6S36jSAWvWwOxh9JX20/aNugTd7HuvJnogJg7Z8UT5mG5DEsqD
 +BJW8r2zmUn9RLdPN8R/UJAdBOBqdEWm2jVimO3gtJl0K5VB4gQad1GZvDTabaT1s7RL
 nwDux9w1N2Sx9MnCDezkkZ4NBOkiiqGvTOPz/lml5dIDcRK4mR52IV3QMhLKzutd7lcS
 9vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558507; x=1720163307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PF/YVa5FANPMIRP5k1k++097xYJKGaWnEtemmw/L2o0=;
 b=Ge5eDoHAo6M55qRKO5RjxG/4xI7Snwn8LOTV5NTVd5v5soOKbSytTPvNc/Jn+3/8d0
 XXmGa3vPT+c9C4z9SuM1R9cMyYJqc8NCUP6zJG9FDuZu8W05HTbdRHviVSdEOymYVnPt
 yinpVPVO2LJ70W0jzT0NzDKPZ3Vb2pJHUIDlJDMfjhL80DVsQyF/uo1vNmTuVo80FU82
 7Nlr6ZjK2NPwBpYzm1aYj2vi476NfnIHqF7GiHxASPrYGFJz6AIlePfu9dGzpMwy0aSv
 9vbOX+gBtvxq6iQuH3tXloeyWHnl+O6T15HZjddwMmnG4UVevYTWf5sw4zlgKC5H9J8u
 e6DA==
X-Gm-Message-State: AOJu0Yy3dTL0wYijVjhS9zi4g3+OO9J1xIAAGB3rLl59X/rfziMTvNQM
 Fj/AOpPx3CgrNEeNWPWkqtFyTWIOmmWv4KllcDWHFbajWYEmnb3KixEdzPGulSFLuNgnZNkzwsd
 chSE=
X-Google-Smtp-Source: AGHT+IFTq+P0eJWvQEc2c5Pqs8+g3tS/KcffcOnvnJlKTnKzsSuxzeoDZptNvq3DkBDySkGP779spA==
X-Received: by 2002:a05:600c:4881:b0:424:aa41:4c15 with SMTP id
 5b1f17b1804b1-424aa414d2bmr59229035e9.22.1719558507565; 
 Fri, 28 Jun 2024 00:08:27 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55e61sm21452605e9.20.2024.06.28.00.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 60/98] hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT handler
 (CMD30)
Date: Fri, 28 Jun 2024 09:01:36 +0200
Message-ID: <20240628070216.92609-61-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a63213613b..bf9975e9b1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
@@ -1561,11 +1560,33 @@ static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
     return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
 }
 
+/* CMD30 */
+static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+    uint32_t data;
+
+    if (sd->size > SDSC_MAX_CAPACITY) {
+        return sd_illegal;
+    }
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "SEND_WRITE_PROT", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    data = sd_wpbits(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
-    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1650,26 +1671,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Write protection (Class 6) */
-    case 30:  /* CMD30:  SEND_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "SEND_WRITE_PROT",
-                                  req.arg, sd->blk_len)) {
-                return sd_r1;
-            }
-            data = sd_wpbits(sd, req.arg);
-            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
-
-        default:
-            break;
-        }
-        break;
-
     /* Erase commands (Class 5) */
     case 32:  /* CMD32:  ERASE_WR_BLK_START */
         switch (sd->state) {
@@ -2313,6 +2314,7 @@ static const SDProto sd_proto_spi = {
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2353,6 +2355,7 @@ static const SDProto sd_proto_sd = {
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


