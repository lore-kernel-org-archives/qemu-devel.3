Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49EBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dK-0000PB-SC; Fri, 28 Jun 2024 00:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cc-0008JX-OS
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cZ-000107-5D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42564316479so1597695e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550440; x=1720155240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSwX8/t3OMl0d9bqgd19YFhdT5y/t7Myi2nZ/gwkh2s=;
 b=yKHNNxKgY7ZX4YFKqfbMD5eiGC34iqqHsHNwkO6bFTSoIjKZURlX9+mcMApLMx1GSq
 SFqZDf5wG9IivNZVq/t8Oko+fT/OfVWnM3MrNj4RNN8pbcIn2VoKCVtCp08jG4Np0s4u
 Zihdc4VriTHx1hkYyIQ3thtKcvRD+bFU8WU/Nqd3Ua5PBSE5Gtbqj/tE31nbShfHFjeB
 nUWiHXF5OMaUyPzebbibFHwdU+JCWFyxfNa4gmsyZUZ25GIIDmZt7sCK/udn5/gm0QGV
 iUiC0I2BKy5HwukolIYHyjYcOLmXRNzpfoSYDZrIHeZJAc3EKr8FQ5aFHPqwqYk0gG6N
 PzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550440; x=1720155240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSwX8/t3OMl0d9bqgd19YFhdT5y/t7Myi2nZ/gwkh2s=;
 b=kK/x0Wdy34wpXswITOH9gyQDJycyLY0GE/45evQucunTlZmhcQjR+RQ7MxjCQv7XZd
 slMVMdPndvGdAHuI6Z65gwZIvDegnWDUCYpHCvV707YeJ1m73U7btvHz4gKtQyoO8kP5
 z4Ia0T28cBieaYMtBvOqxaTkezI6o+H0efpWW6u1/pHs4NCwOnrJWBFr99SjFuZem9iq
 uCOkMoUW/g+BUbmIVQ2THAjiG37atcUB6VqLdIwgZ0D73ecdIrj/oxjUA4PNO+86JlMD
 Mlw46YIOuNOz6GPYJyaZKQ4SQ7Y9Zpo8q0v/u8uUaFR//3XEvj+R4MPr/E6PnogXf5hP
 7xbg==
X-Gm-Message-State: AOJu0YwLbbWxpYdtjBR2c0wc4O7gdYPgMsVfZAfK2DMRJVEv2Z3Eob6v
 3kjoWxXhtCwEHEZp9x8SGCbP/7KU18iWssnV34smlv4ZD0M5y4BA1/IB3gpvA79VfrKiLn/0ILr
 SHbQNkA==
X-Google-Smtp-Source: AGHT+IHlXD0zkgfjs3w0IFmHdT1snza8t4ijzjhTrqN0Ae4teZsL+Nz44JFBZ9GgY1GkVKY/QXL9vg==
X-Received: by 2002:a5d:5745:0:b0:364:81e7:3917 with SMTP id
 ffacd0b85a97d-366e946480fmr11211294f8f.3.1719550440322; 
 Thu, 27 Jun 2024 21:54:00 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af59732sm17977125e9.11.2024.06.27.21.53.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
Date: Fri, 28 Jun 2024 06:53:18 +0200
Message-ID: <20240628045323.86308-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a27a7e0f24..6a9d611429 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
         [54] = "SECU_spec",
         [56] = "SECU_spec",                 [57] = "SECU_spec",
@@ -1758,6 +1757,12 @@ static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD51 */
+static sd_rsp_type_t sd_acmd_SEND_SCR(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1866,16 +1871,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 51:  /* ACMD51: SEND_SCR */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
-
-        default:
-            break;
-        }
-        break;
-
     case 18:    /* Reserved for SD security applications */
     case 25:
     case 26:
@@ -2327,6 +2322,7 @@ static const SDProto sd_proto_spi = {
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
@@ -2388,6 +2384,7 @@ static const SDProto sd_proto_sd = {
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
         [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
-- 
2.41.0


