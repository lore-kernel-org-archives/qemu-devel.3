Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B91C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI2-0007rQ-WE; Thu, 27 Jun 2024 12:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGV-0006GW-C5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGT-0000SY-OI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42565697036so5415265e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506787; x=1720111587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoQCzUzxa0YFMI6eXkkGrxD2M8eC5JzJPZMXnDtnM4A=;
 b=pYw59Msc0eaoW9SrZLgBAXXXsRXcb77FOygEE390KPYf3Gq/fwq1GJ5G5nfnOa8Piu
 lD6UO7+CsKBybqezq98SACTE8WBFwwdiM1n5ujUTF/u48CAHfDfBGsDAQZjDy1ZGodvg
 9UwqLKZ+L4QL7a9tDHVfEOXF6ijHG6GNtAy2iw3HDcknV5K1i1W58SZspKsX7I3KJ/xS
 zg1LUedPGryhhBdxv4jYTU1zTOlG2n894efrKfT8LN/7g+UNUF+oFwvC6P6KHXKq6tlP
 wdF9C307qMC7fuIe9b3OdaH+LzNGDajx6wv4RgnOFnD2WkmLEBS2IyFapJSurjr7eJQ7
 V4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506787; x=1720111587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoQCzUzxa0YFMI6eXkkGrxD2M8eC5JzJPZMXnDtnM4A=;
 b=duJlI3ofwZakuyzb29PqzzDb6sbmJ+c/e4iY9SReJlrghvVngKtf9a878NJRR7C1He
 3+zzfqG9cbMkHyr1r5TQC84ScVQbTegzFMOBQmwdu/qwZFeGx4XDgvesRePOyulvsKuE
 brhG7AWYp62BnBBwUmDfv0Mk36/39RrBSDsyqj8OHNMQCoaIKw0p3Y70GjIGmbkTqE53
 lM6mkQPv+ZDyIFM23wqP5BQCD1mi4THsZbPwlHBdGqrKP69t57WdBRK0xRpOmHktYqch
 PbAQKvq6lT80LykN6RZP1Aihg9a5ozySi29p+wh0muwR1CRaF/4k3naaxWTFBSCxI2Ln
 aHYw==
X-Gm-Message-State: AOJu0Yyi6IxZSeJHN3JIFltIKy6++bYIzLuB8MXRHWFNqDKLzlDwUJoP
 UBKd9OFbgn1pttsb/MtubO8D1jW7R5ihOAirIN68pHPsBrIETT5EDP/qZGKDcOpcimAbXRqhXAq
 5SFk=
X-Google-Smtp-Source: AGHT+IEhLDTzYytyt1CZL/6C7wOMe94F80QiJ0Smue2O3Nux4m0d+OjfBmDRId5tFbOa16mtyfVrAw==
X-Received: by 2002:a05:600c:25a:b0:424:7871:2e9e with SMTP id
 5b1f17b1804b1-425630e946bmr28704815e9.6.1719506787368; 
 Thu, 27 Jun 2024 09:46:27 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367435850e0sm2385833f8f.50.2024.06.27.09.46.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 16/21] hw/sd/sdcard: Add sd_cmd_ERASE handler (CMD38)
Date: Thu, 27 Jun 2024 18:43:39 +0200
Message-ID: <20240627164345.82192-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 hw/sd/sd.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4e31dfe18f..17fec612eb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
@@ -1602,6 +1601,24 @@ static sd_rsp_type_t sd_cmd_ERASE_WR_BLK_END(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD38 */
+static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (sd->csd[14] & 0x30) {
+        sd->card_status |= WP_VIOLATION;
+        return sd_r1b;
+    }
+
+    sd->state = sd_programming_state;
+    sd_erase(sd);
+    /* Bzzzzzzztt .... Operation complete.  */
+    sd->state = sd_transfer_state;
+    return sd_r1b;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1690,26 +1707,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Erase commands (Class 5) */
-    case 38:  /* CMD38:  ERASE */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            sd_erase(sd);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
         return sd_cmd_to_receivingdata(sd, req, 0, 0);
@@ -2318,6 +2315,7 @@ static const SDProto sd_proto_spi = {
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2361,6 +2359,7 @@ static const SDProto sd_proto_sd = {
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


