Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B0FC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZHc-00054e-7T; Fri, 21 Jun 2024 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHa-00054C-HF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHY-0008Ey-P0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42165f6645fso15641215e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957163; x=1719561963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4c/usVrkl8YKkr8RnXE4rYu6P4lZW+FXlANdR7STD3A=;
 b=ZuS2TuxppI1j00p7VVy2TC5FNuzruBF+SMvwlJWGM4nCzhgoKF5IkZtpGe0uzFKtew
 6Mb2iRmrfxM4gIRWh0AFlpD887mkQz2OBmGbADUtcTXes6OOsSZ67aZrAnU4FQDcPUdP
 oXej5F+LwRbra5dXOIYs+x9rznUrF12fqlGa8F4Wu1X1RXkKQq8pnvHGUA+0ni0O06FY
 eTUtBGD4PYAJ8W+sT9bfjzMQAByp8aOqZF+aFNGP0XZUYweKmZTmP12JAdf+3cxqL6+h
 4W08if0uDSeo2ts4DPIhipio+5u+6VxPt3nlt9b5NChJ6B6dGqam7bBjfZk7xUIVp5xx
 7Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957163; x=1719561963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4c/usVrkl8YKkr8RnXE4rYu6P4lZW+FXlANdR7STD3A=;
 b=eUGAxM/rDIxkwFD4hoMiMapkHtPy667JYK5D06biGPXSPVaReNcWiHUb0hFVb45msJ
 XgTu/C4+Mfu+qiYSl9joZ6OI0yQUgZq7Jd9T7frxsOAPkItYiJ5abbvhlgP3MuUVcamT
 HWe4g6LO1ZJoeYkXP1JaOk9ylc4+HtevwyOGyjuG1mFrwfZKbaHOH2buhKVYvDHvSsT7
 tzVwY9pHEvfgvUbPvy5DTnJOFNSKFkQUgFT45+xCkGamZfepMfBq5KBXZd7GbzrZ/G++
 GuTX77rNQOanO3fvEIWbhFdHeayrkyiC3XsjtEb7wp6WK0eszlgztLsGbaEgjpclCnx6
 a4Cw==
X-Gm-Message-State: AOJu0Yy/s3i0x05KKiJkBh4U6SehViD8QQa45d8gKsqE/DMKY9bun/IZ
 Z7HeCGStjnLEiGOz8ojD7wHD9NRXo1An9oRRurILLbROIG9SiXswJevl4f5FOzEetj2tR5BKwH4
 O
X-Google-Smtp-Source: AGHT+IHcd/mD0AQsb+hbMx8H3KeN11iekchbc+pLPX/KX/3DAMVaO5FJp23Qvipp06K5s10rnBwc/Q==
X-Received: by 2002:a05:600c:4447:b0:422:7996:3f3f with SMTP id
 5b1f17b1804b1-42475174910mr63841185e9.11.1718957162942; 
 Fri, 21 Jun 2024 01:06:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248179d982sm17070775e9.1.2024.06.21.01.06.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 01/23] hw/sd/sdcard: Correct code indentation
Date: Fri, 21 Jun 2024 10:05:32 +0200
Message-ID: <20240621080554.18986-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fix mis-alignment from commits 793d04f495 and 6380cd2052
("Add sd_cmd_SEND_TUNING_BLOCK" and "Add sd_cmd_SET_BLOCK_COUNT").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 16d8d52a78..626e99ecd6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1069,33 +1069,33 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
-        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            return sd_cmd_illegal(sd, req);
-        }
+    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
 
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
 
-        sd->state = sd_sendingdata_state;
-        sd->data_offset = 0;
+    sd->state = sd_sendingdata_state;
+    sd->data_offset = 0;
 
-        return sd_r1;
+    return sd_r1;
 }
 
 static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 {
-        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            return sd_cmd_illegal(sd, req);
-        }
+    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
 
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
 
-        sd->multi_blk_cnt = req.arg;
+    sd->multi_blk_cnt = req.arg;
 
-        return sd_r1;
+    return sd_r1;
 }
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
-- 
2.41.0


