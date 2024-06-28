Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5i7-00035Z-0V; Fri, 28 Jun 2024 03:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5i3-0002uU-D5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5i0-0003PK-8C
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so2530725e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558466; x=1720163266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FsxLv41oI+lmhCr+srqJP++Hluvz2oWQHhnQB9fyk4M=;
 b=egvnj1Lz+31lcbWw+AURd5JLyHP3GyqW9bN9MScXbChHNO22jRr1lObNxotM/xQ5f6
 qRU5v1iqw/e43pt0YwNJUKGJ68f64P0CWBKUWjfe97vXN+pmmo5EA4k7ZtMi2PYDDjXO
 Rox0lUhRRx4I2cbDlCkOl2+G0F7rBzQ1wEc7eEnj3knyH97d9HWyv+0K/1w+JylHryOn
 aAKU1trKyPjNW9Bouy7ZFxP2jFyoP+NDIebv1EJ70DzRAQIhzs+r6icvdwLRALrsub1M
 xSm5KFpjmYRheKxjGpTbzT3XPpc3U2zsiOMaCZ41DVkIPkvu4NBz+i/M7/o8aQwqyIul
 a5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558466; x=1720163266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsxLv41oI+lmhCr+srqJP++Hluvz2oWQHhnQB9fyk4M=;
 b=kx+zT1rSgk4OlHNnAZoZVN+i9ev51vzhGvoGT0atftVvb5NQkQbKMOMC8rU5l6XrZ0
 iGMxxdo4GuRR8mg7qLMAtQh+PAgAcbwhb7IlbwiRcaggWg3yAcn/9vNBBux2r7SOLoT1
 2bMAOfR+5h34u3Yn4iZ35QRh0CRZgPt7vFJoo48blnZCBRxxUarczk8gd5QmWR3OwE66
 2daD1S+5hW/hwMcA5s6zK3cHJgGDKV23z5SvpncpFOPaFLX17/s95FGzOQLnC/+xoAMh
 N9QVZRsxwhh+juHUz8Src7I2CemFiVPWX/M0sx9Lloe+OgI8LGvQTn07OMU6QMkxuuHt
 9MaQ==
X-Gm-Message-State: AOJu0YwC4uraSdg+YjvLoIL1vc0I7hkg6Vz5D4KD5o69phgl0bBMSJSJ
 td+Pxl524Hpbi4oSJnLzS4S83fYBSKlpPEyd8w6cjuqf9ld2kdE/CVwsEvEPXrHrSpqZFnekapJ
 xz2M=
X-Google-Smtp-Source: AGHT+IG+02McLrvd2ooNB0ZrFp4vzKmpDYORDA1MZkdEtoENbXUkdviBFSavDoMwxt7jVue8sRv18w==
X-Received: by 2002:a05:600c:1c29:b0:424:a5df:b998 with SMTP id
 5b1f17b1804b1-424a5dfba38mr58706555e9.9.1719558466561; 
 Fri, 28 Jun 2024 00:07:46 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cfc3sm21796845e9.3.2024.06.28.00.07.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 52/98] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler
 (CMD12)
Date: Fri, 28 Jun 2024 09:01:28 +0200
Message-ID: <20240628070216.92609-53-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 564e08709b..1c092ab43c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
+                                            [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
@@ -1360,6 +1360,23 @@ static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
     return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
 }
 
+/* CMD12 */
+static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_sendingdata_state:
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+    case sd_receivingdata_state:
+        sd->state = sd_programming_state;
+        /* Bzzzzzzztt .... Operation complete.  */
+        sd->state = sd_transfer_state;
+        return sd_r1;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1426,23 +1443,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 12:  /* CMD12:  STOP_TRANSMISSION */
-        switch (sd->state) {
-        case sd_sendingdata_state:
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        case sd_receivingdata_state:
-            sd->state = sd_programming_state;
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* CMD13:  SEND_STATUS */
         rca = sd_req_get_rca(sd, req);
         if (sd->mode != sd_data_transfer_mode) {
@@ -2278,6 +2278,7 @@ static const SDProto sd_proto_spi = {
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
+        [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2306,6 +2307,7 @@ static const SDProto sd_proto_sd = {
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


