Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54324C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3cU-0008Ge-JH; Fri, 28 Jun 2024 00:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cG-0008Di-0D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cE-0000Wq-EC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so2035135e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550420; x=1720155220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if+k3pC7/tUCTUn2xmGg3zarIgu5LY5GHs2T467fbqI=;
 b=rfxyJ8Wd1lYrO0/S+FMK/iNcQa28OsAdX7QZIpR/NaMFUKaXAoe9Bf5F/aIKuMHOiO
 D1/Qk89vLQGyZbxyfdgPFWFVZ0dz+yT90JHsRxMnTQYKAPdsSh2yXpn9X4deMWhFN0DG
 4NAZk0T3GmxcPuhErZQO6lSVn25P3hHaz/f98xkPgm2YOJErwKoVt8uCRdaH7qc6FsPc
 yS8MjwrqvlW2wvCagin5XcNQ7t5G+/Q9U5M9hwOcWgu7P9QPPw53+xicOvB+xqzQPQLv
 55BP4atz4faUSHGDhcykHcggmsI1f+35T/M5iz616RayWOB6i3Nh5jqKk56Mn0U5+jos
 5DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550420; x=1720155220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=if+k3pC7/tUCTUn2xmGg3zarIgu5LY5GHs2T467fbqI=;
 b=s275s4KpcoZ2pmgpmjT52/ve9RP3aV8iFZvLNcAYWfSN4SpfL2tGrGRlsR5acFRGzw
 QvgbZfZk1wmh4JZCMYb1pkUcGSPEWra6JR5Xv8BBbs1Q+U7tKonhix9uUh0K/CxG/1KA
 xd2YKBDicloB7qz1HubsPKMbxPyci+mxt7W0zGllPogG4hpeyI40RP7bB+FhMgnAHcJm
 oRpRH6mR197FCmcvjNj1yB+SzTrRQW3Yr8suRiWKGX/ssSFd5fWDYrhewA16wBkxG6Ui
 fLLcAbCKCXRiIj/bHr6hFePQdOkqG2xrTtGICMElKK41pZBy6qRCu9PLKG7g8X/WDsMT
 6U4A==
X-Gm-Message-State: AOJu0YzKk4m77TfRw4IgwC04qPk5ESem2gTGsGdzOSlWHq58RtdN1oX+
 O1T+Ma4Gi9VGqvCtgnws1+zmnFYZd8V9vUbz/OufM+6KaFg2PVDTb3jV08W14OYCErU+IX//ebg
 qp/gtBw==
X-Google-Smtp-Source: AGHT+IGDmXtiWX2jJDTWU+jla3epsGjUJndSoFrVb5uDaux98SHygVlvGjOldNv8xum+ZAWzmKhoUQ==
X-Received: by 2002:a05:600c:3b8b:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-42569b7352bmr10751715e9.18.1719550420364; 
 Thu, 27 Jun 2024 21:53:40 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af54ecasm17849165e9.12.2024.06.27.21.53.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/12] hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT
 handler (ACMD23)
Date: Fri, 28 Jun 2024 06:53:15 +0200
Message-ID: <20240628045323.86308-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9d66c3715a..cd207a3090 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1696,6 +1695,15 @@ static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
                                  &sd->blk_written, sizeof(sd->blk_written));
 }
 
+/* ACMD23 */
+static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1804,16 +1812,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 41:  /* ACMD41: SD_APP_OP_COND */
         if (sd->state != sd_idle_state) {
             break;
@@ -2320,6 +2318,7 @@ static const SDProto sd_proto_spi = {
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2379,6 +2378,7 @@ static const SDProto sd_proto_sd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
+        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
     },
 };
 
-- 
2.41.0


