Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02B7C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3d2-0008Tg-3r; Fri, 28 Jun 2024 00:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cY-0008Hz-Gt
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cU-0000zH-0S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso1875085e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550433; x=1720155233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0gZMlOJcmhezdd4Yk1lqkQI7yCyPoJydtauFHQrfjI=;
 b=usV2tdS7nqPVEOAl4conk4qZ/m2RHB6p9xOgQLBsDzGxFXoVAokRfgsfSeiytRBZq1
 +g+FSjeQRN7FfUCcg7+6Pf7qXrB3mCxvkdIOS53kmdT5nGMH4EnIByikTJDUmK0vGnvS
 5FZA+XeUFWDJkcIm14enr7JwY+FyE/bcvTlISzMmrFPjSG9U1x4ixDdhIcMQtICtKwGR
 FcPxevBGNSQqQlCY8alJtkjNvMGJxxlvzbHuuvoQslUPt8qEaO42an40oEA+ki+kGYb+
 mBYSeuyNFuetfAkfDxprZtzsCzgsnELx2Ig/sSzxb4vler/dBE6/+g/4tg+REzl2o/0O
 zFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550433; x=1720155233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0gZMlOJcmhezdd4Yk1lqkQI7yCyPoJydtauFHQrfjI=;
 b=FcvctY1gRjN5wS72/tD25Dppb2cxZwMgD+0NT5Hu/XOe17D6rA5URVOkVD6lFKBEaI
 FP8GMgAUpsjrfXY9vfHCw9CDvZ/ORU/awKh2fnQUU7HZLNbXR6ie9SWL1lip7vZf1+f8
 0EUZYwAU38kb8X7+0HSh1UkY/Ntt1csd6OXOMKSXceNNImjVe/Rc0kM2DwXp7/YeNKu+
 WeTocyUM+GY1wZO7rOCBlXo/gTJs2MNwBJ55ssLd5eKrvOTrBMyhiHoj4zNXYbIytw8r
 JgtUtAS8enWWskED+R7IQSvbeTkem4FjQMeRnbOAAZi18QDRHoba17Leudq7LZLZUaxa
 mMDg==
X-Gm-Message-State: AOJu0YwuC+9GeDCFwwKxS32sKqGWjhf3dtv68WiNkCzIN7f3ds2KDyVV
 863KSx4ykyYwZ6hLL4ib0R5nRxQrj5aSiySXlmXsG/u2Otoel342fiuOM1PdOghqkefhdCL5nzy
 NphA2pg==
X-Google-Smtp-Source: AGHT+IFjZet+FWymQKxFtUYPOH65+BK/+GeCnJm/tCxrawI0AMd/5T3D5FPNza8eU++P9DM1khKcoA==
X-Received: by 2002:a5d:58d2:0:b0:367:437f:1774 with SMTP id
 ffacd0b85a97d-367437f1ae7mr2505882f8f.14.1719550433476; 
 Thu, 27 Jun 2024 21:53:53 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8df0sm1064540f8f.29.2024.06.27.21.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/12] hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT handler
 (ACMD42)
Date: Fri, 28 Jun 2024 06:53:17 +0200
Message-ID: <20240628045323.86308-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


