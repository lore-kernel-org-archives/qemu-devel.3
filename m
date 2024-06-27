Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4591C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs5i-0003gn-3T; Thu, 27 Jun 2024 12:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5g-0003Yb-Em
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:35:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5e-0004ol-IH
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:35:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so63818825e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506115; x=1720110915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRVCvBojEsyxAg7JZRES3P5o6lr6YCg7S7r2PnPDGt0=;
 b=OHJusDm1jYbJJqnoTky0JjpTS6JHYNfwEdxtCyM4Y0n90VBg8hCUB20yPGjYySuttc
 BxLQJcXdCduLX/9PIgjaTueAv3Uf7qzbIozr2L0DFHXi3BBAkmhbDen5/6FupsGPY/1Z
 kHdE1XM5Z6iQ03dtXNuANgBotbFLm7FQaqNeOF0nmdJeXDx2RbKLVzrrgAlLTP2oV7rI
 Oq/AWr8v1rxF2TVQOuvUm1Sl67dSmKIwrPHaEPjKU7ZT/JV7LkVyLiRHh6JK/C4aaZbV
 +5gq1w4VirPcKgEmQWvL3RCYDcRPXCiozfRq5/tJl1ANjAh08kmbhpmCK2D7DIvyiVdh
 8Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506115; x=1720110915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRVCvBojEsyxAg7JZRES3P5o6lr6YCg7S7r2PnPDGt0=;
 b=orR9DZZtK780za8VLbllDVSM5KRoU0Xm/vkj06dYklkht9W2SZqVyQtqU7p8OHmNWL
 VzUe7jOq0E8dFzVyJ9lya4KNA+TXAq8Cgi/xcTiFaIGFOke/T2byMixbW4Hgk1XaWFKB
 M7F/2QQbjeClgYj+6KUZk0ZojDSaN2OBJTiXL21YIUr3KUiYcNm6D6nBu9KoYeqENlf9
 sbqliUDlOcxS7JgJYWPcEKvnIhpACduFQezZ+7Y/XTJGPfQG9yqrOeBB60C5gtEk6WyG
 Zaxz4X9Xx7p9ocUWXdJtlXorgz5D+a4AAtKnZN7HpF5Zi8IPJiWVoUf6oqwMqJEUHGaU
 cZlA==
X-Gm-Message-State: AOJu0YyUqmpMqlPpVbMn4Idjyd/wckH7AaHDc6IjwoUlyoXzgMH7GxTW
 ukh2WpfD3k7v75bqGKqjVYM1zHN3WYqooMUy1DmK6cBI3qGrTChrAicgt8i8wMZZ1E8v/MUWHfy
 IS8Y=
X-Google-Smtp-Source: AGHT+IEFjYJbv1wzdz6tE0MLXFPWWFazOYp5YmTZJNwxitmGZekDSAtJ5HL/nP8g+oH+ZcwZxJKT4w==
X-Received: by 2002:a05:600c:26d5:b0:425:6262:1cc2 with SMTP id
 5b1f17b1804b1-42562621d7dmr25305875e9.34.1719506115535; 
 Thu, 27 Jun 2024 09:35:15 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699b02sm2397663f8f.85.2024.06.27.09.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:35:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 7/7] hw/sd/sdcard: Convert GEN_CMD to generic_write_byte
 (CMD56)
Date: Thu, 27 Jun 2024 18:34:03 +0200
Message-ID: <20240627163403.81220-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
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
 hw/sd/sd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0cb528b0b2..f9708064d0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1657,14 +1657,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 56:  /* CMD56:  GEN_CMD */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->data_offset = 0;
             if (req.arg & 1) {
                 return sd_cmd_to_sendingdata(sd, req, 0,
                                              sd->vendor_data,
                                              sizeof(sd->vendor_data));
             }
-            sd->state = sd_receivingdata_state;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
 
         default:
             break;
@@ -2109,9 +2107,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->vendor_data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->vendor_data)) {
-            sd->state = sd_transfer_state;
+        if (sd_generic_write_byte(sd, value)) {
+            memcpy(sd->vendor_data, sd->data, sizeof(sd->vendor_data));
         }
         break;
 
-- 
2.41.0


