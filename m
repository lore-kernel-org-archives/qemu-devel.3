Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F87BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs02-0007AM-Sg; Thu, 27 Jun 2024 12:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs01-00074B-1n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzz-0003bX-HC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so27143405e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505766; x=1720110566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsWzBaT42Pcps68Pqu01vvv+C6po3s8FyjpSWrBt7mI=;
 b=Dcfd+7nlE+ewoAwUDSjc/r/mqsb3XPO8/+oXQ56IWGPFPKdqLhRvqHmYl8CcTXo4ak
 yHUWHtg7JaMIB3SR5j78jMboWsk0hBPyHUoQGYQi1f3/V18M2XfdNpHdfjZklHjfsEGh
 lNzCxsgjOEtkfudVR16vfmWCieT1QmrKQQOt7Ivbcth2xxVVf6vZBqZlEXiZRs7M+YCA
 R2H8k+MtfdEC9sb/IuHcPx20wItTZX0WuKDJiGntrX+r449qJ072cMKg5Tar52y74/ql
 xf/iHAENHPfumpn/2Eg1djK7y5EV14nm+rHUEvUqBbBgYRFkLAbcRyfqo849l/hpfx1P
 iZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505766; x=1720110566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsWzBaT42Pcps68Pqu01vvv+C6po3s8FyjpSWrBt7mI=;
 b=fp5+N7emuU5Zj/vdrOGoOhrE1wxHVAE5zUYKLEZ4LPdM+6r7FLvSS18OmzEog1QvLE
 rrqiF+d430wGKF/Szm+r5Uc/xNK6HeAroZwXLoDIPsaUh5V9EiOI6SL5frZnjQohYR53
 nJw3AvVfG4nGeE+Cns2aBldjmC1X2n9TrhpDcchG6ksB2PIpQ13oKWm+J2pwZntgDdxd
 rSqHHmdq3Q/hTTZlJSOvKjRrLWgGiipdt+jl9Vh0pglR6Vrfn6DjlYtG+zuJWjmb8b7L
 a+UHfnfmkR+g4eR5zeH4L6j9POXTf22qY6IO5/u4WFQaCj8PGfXtT/oIeYEsGJRAUpR9
 qAlQ==
X-Gm-Message-State: AOJu0Yz2yh9L+ZBo+4tLnUc6gtg3SunhiBAQ9nNpNJYoKcDKbf1ag3O2
 fun3trwgklWh39B8RNx7TO95Y5qjLm6ysTDSeZdLVGz15ShBEiZrm69XTdmFQWbYOHxRF7wlteM
 lt1w=
X-Google-Smtp-Source: AGHT+IFgCdL0TqWPSgt/xNLI4B03zvFMb/iuY8G0yTEcPxIfljbMakW/wbaqjlPJ0laXuuVoA7D9OQ==
X-Received: by 2002:a05:600c:3b8b:b0:425:69b7:3361 with SMTP id
 5b1f17b1804b1-42569b7352bmr1511495e9.18.1719505765858; 
 Thu, 27 Jun 2024 09:29:25 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82515a1sm74222825e9.12.2024.06.27.09.29.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:29:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 11/11] hw/sd/sdcard: Convert SEND_SCR to generic_read_byte
 (ACMD51)
Date: Thu, 27 Jun 2024 18:27:29 +0200
Message-ID: <20240627162729.80909-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 hw/sd/sd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8d02cd9a26..cd308e9a89 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1785,10 +1785,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 51:  /* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
 
         default:
             break;
@@ -2138,6 +2135,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
+    case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
         break;
@@ -2166,13 +2164,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 51:  /* ACMD51: SEND_SCR */
-        ret = sd->scr[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->scr))
-            sd->state = sd_transfer_state;
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
-- 
2.41.0


