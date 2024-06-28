Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E393C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jv-0007Fo-Ra; Fri, 28 Jun 2024 03:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jl-0006mR-SM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jj-0004Wp-CW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so2642955e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558573; x=1720163373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V0gZMlOJcmhezdd4Yk1lqkQI7yCyPoJydtauFHQrfjI=;
 b=CW+drjv7FLwyqRmrTHriOIWDwIcnY4YW63Nyl3YykARkCJMvP6n4w0Sj+E0jT4efdK
 qLXSw6Gm0FSg41SB1sIkpH+xWxF8EzTMpubDpzTVWbSVDoaKSeXGoJWzxTC/IF8gdOKw
 bIRkoo1gUpGvQ0GuN8BgxG4OEw2ScLB/vrcMb+u7L2KWBFgbIavv8/H4UR0PdjazTGgl
 6B7q11h96y5AVoS7Og7B+Ldlc8DStnas8yXgL4sL/W1jUap4jBq2AjKOiwOdHUER+Op1
 6WKuwTwpZo1MC6M4B6JTIRtCNsZ5MHOwr+Q8OOifKwJTBrVmc4wpfnfzMq7qP6IAuJc7
 6vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558573; x=1720163373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0gZMlOJcmhezdd4Yk1lqkQI7yCyPoJydtauFHQrfjI=;
 b=jwLXC7rKJHgBtWE8CytjXznH1BLLvO4+qat1TNZOzlnhibbI7pdH+wtbERXPYj4ilM
 7zEXev7w3FabtnvJ5CilpkXl9jNaF4hLT0DO9utibJq3m6qotJjFKujKPynU119gK4eS
 adCo9lb9tK/um4UcwcykudCvKxEZvW+KVG15XL9mXnpCiR5sbuoauPFvq/Iz8E8wvG8z
 sq6+To/TLm9HjBol9nhOIRUpqk1iELA3vuUe9t8KsY3rBlU5+2CDIEUPyUPgFdGstTPo
 5WhmXEP21eDE7hbWCZEQugzABQdOEx99XjNJY3YKZQFw8PXD+Mx+uVNn29JCeX15Lxao
 NCxg==
X-Gm-Message-State: AOJu0YxT+qO2p470oCKvHczdWclOdP9eE227uq8GqyocjS8Y3uq8RF+B
 BTv1LXguZ7octFxPZqa7S/r4mXLWVEmQ+99LOpNoAL/Dp/aZy6YMvCX2YRu62bmguTenx1XqNcy
 8yTo=
X-Google-Smtp-Source: AGHT+IH7vrZA9iM8neqGAqvNb3ky7J+bIveEagwKbn1N4DwixZk3anJZLwMlcbvEDrVHAxRzewhdBA==
X-Received: by 2002:a05:600c:829:b0:425:61be:c911 with SMTP id
 5b1f17b1804b1-42561bec952mr38622705e9.21.1719558573732; 
 Fri, 28 Jun 2024 00:09:33 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0676a3sm21385085e9.28.2024.06.28.00.09.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 73/98] hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT
 handler (ACMD42)
Date: Fri, 28 Jun 2024 09:01:49 +0200
Message-ID: <20240628070216.92609-74-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 167e1c517a..a27a7e0f24 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
         [54] = "SECU_spec",
@@ -1748,6 +1747,17 @@ static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
     return sd_r3;
 }
 
+/* ACMD42 */
+static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    /* Bringing in the 50KOhm pull-up resistor... Done.  */
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1856,17 +1866,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 42:  /* ACMD42: SET_CLR_CARD_DETECT */
-        switch (sd->state) {
-        case sd_transfer_state:
-            /* Bringing in the 50KOhm pull-up resistor... Done.  */
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2327,6 +2326,7 @@ static const SDProto sd_proto_spi = {
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
     },
 };
 
@@ -2387,6 +2387,7 @@ static const SDProto sd_proto_sd = {
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
+        [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
     },
 };
 
-- 
2.41.0


