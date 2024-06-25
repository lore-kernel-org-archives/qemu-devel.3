Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DCCC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOi-0001TQ-FX; Tue, 25 Jun 2024 02:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOa-00016Q-SQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOY-0005hI-F5
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4217136a74dso42276715e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295868; x=1719900668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rzBRaI/ZYbZ2jDlEcvd1eH3g2vJ/qZ3lsOwA042yyE=;
 b=Gutgh3Mkf7/a3886owZbmEZJrEPLjFvOoskBGQsH0bNRIdchiSRgt9hZK5JrR5B8Kv
 DIk8v+rZ1RXWFoS2Gb49neYcnSCYoL5ydk+ALrY1VzBxFw5I+WIe3QUk2cn9123G80gk
 AZHrmxStSLYe1bj7TTdJgztFC+ebRD1ucEryzAexIxX/JBh01D3UnQYrjvcBrv1KEnXi
 /6Ux7JUnMbgR0p0FP31i2/e6hLb0VqiMk+pAVcKUVmPH74O7Q4b6NIcpSA19B8XcwkKf
 aXNDD2WweUCGaziedkZqCG3Kna+kOxqFm6uyQg1OkbxLQtHKaDy0If7UxoKuFtWIjsnR
 qZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295868; x=1719900668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rzBRaI/ZYbZ2jDlEcvd1eH3g2vJ/qZ3lsOwA042yyE=;
 b=dO2oYo8odhShKVkNrGKT4k0kiRRw9QY1y/tWEqrKYwcyP8Cb1ciw29KgfzgNKNHqpa
 HwSmf+W+24i/7ULmuqchoNJe136HeMJDS4yB7BbjfZ9dtc490/BgAy9j82QQd+OAxdYs
 DrG/5T5Yp2PbR0FLIDi7vlfEZPUkgvwsh82qws7du1fxOiNxH4jyvsxzq5lRJVSxU0J3
 2F/gyu3aPlvfPunR0ofdIND/Z/LbWheB8iKktLkLb8rUKhGWOaMBrRj4UO5bFcZCvD7T
 h+mcWvA7WJj5lFY9tmOodFGRZp5i+zv99rjcW+TeiwP3DTcjFqksDat+kPrjypyXuRih
 esbA==
X-Gm-Message-State: AOJu0Yzy6wAY/YAOwrwTRre+IeqMt5M9Hpfz/L3Kjs82OuRSEFEfrcYI
 QSAIZTEeYScN9boPVwgiW9QAd/krinKLmZ7bkZKyu2oTFLlJlgL6SZZ3wHNUKESl8D+Kv79mDp+
 2
X-Google-Smtp-Source: AGHT+IEii8v+PfrGLjPyjzgqKSUPvYemDDQqP1ct93guBkgzzp4YdM3DL1XqEk5RkjnvwBdrUaLjww==
X-Received: by 2002:a05:600c:3204:b0:421:7296:ba3f with SMTP id
 5b1f17b1804b1-4248cc340e9mr42008765e9.22.1719295867776; 
 Mon, 24 Jun 2024 23:11:07 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a8d8esm161294755e9.12.2024.06.24.23.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:11:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/11] hw/sd/sdcard: Convert GEN_CMD to generic_read_byte
 (CMD56)
Date: Tue, 25 Jun 2024 08:10:12 +0200
Message-ID: <20240625061015.24095-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
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
 hw/sd/sd.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6e6b37bd2d..bf78f06b5c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1626,10 +1626,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
-            if (req.arg & 1)
-                sd->state = sd_sendingdata_state;
-            else
-                sd->state = sd_receivingdata_state;
+            if (req.arg & 1) {
+                return sd_cmd_to_sendingdata(sd, req, 0,
+                                             sd->vendor_data,
+                                             sizeof(sd->vendor_data));
+            }
+            sd->state = sd_receivingdata_state;
             return sd_r1;
 
         default:
@@ -2115,6 +2117,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
+    case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2163,14 +2166,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 56:  /* CMD56:  GEN_CMD */
-        ret = sd->vendor_data[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->vendor_data)) {
-            sd->state = sd_transfer_state;
-        }
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
-- 
2.41.0


