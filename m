Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A6AC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g5-00074y-QO; Fri, 28 Jun 2024 03:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fw-0006Ho-Rz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ft-0002RY-CI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so2192745e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558335; x=1720163135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1iaio/bW9b4zqPLpqdHkFVAWGPPP4QqHttJbqr0UPY=;
 b=PBCDwgxtpLwNQWHm8Pm5p1cECNVmer2RN18tTTqaRBUbOq0+lT2x6a0sss9lHUdiAH
 n88+WBEAhmLV5E4Q0ZTj8BG9Cm/6WoXI5811Higd4wtFiIoG+zCUfW7YYswQv0vZvLgC
 Epwd0Fr+BSAEeY3H4wakTSMGyAPRUmJyD82+lxxJfyQio77NwMZ/ySygWsI1uIwFHg04
 nD4Cs639t3hWImsPfANcOxAt0lqLuTDJakeiGVMS6GLu1ncrlJ8gRlf2JlAIvT8a0Yz8
 EPDgR/Hm0l7PNRlcaXxykV0hIIXFCDewN2lG7RJuuEcGpnj9wofjWrICgRCVk1IbysZ8
 xDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558335; x=1720163135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1iaio/bW9b4zqPLpqdHkFVAWGPPP4QqHttJbqr0UPY=;
 b=HxDxS/X+AP0UY2h8XsSOfrQbfC2HIROd92XqjjwEViBvBltOHQdT0331ZnixoEu9bh
 Ua4f89HfTY6b9wWFog2JY26ddj1mBL0xOa1ryhilrq1tc+LckKwhcP8BVLyxNCwiGcXA
 8XTYSv++g4dG1nYZOZXRm/6fYLJdUiCQOy6LZ5xb9R73xQfCVObmknVlovtVBMY7tNda
 ul66gMvV5gg+PK14Bq+G8Z07wCrpX7hcV76Gr4oDCoBHtOT4q9XYmMEt8zkR0fv03fl4
 doaTUZlACjf2M4gdwXDTCIspqCG/9xl2NMBAeBD0md7wSRCdTEn20n51OAhS8aJDmcvp
 /IUg==
X-Gm-Message-State: AOJu0Yz2SDgvCNWdgYoKq3Z2EKSjIwQQ36jX5CjU6vxJI0sq679jD2Sp
 3uJ4doQTGm6LiCbFVpm2akr4BEVd0WbACp+adoUnt8kVxT2Anb2RfF7XdF5ET8rb7Ci4fvCxNv8
 L43k=
X-Google-Smtp-Source: AGHT+IHtuYs30GFNoEFAulLL6wD9dMk6N3p4shELI6mDjl8Zeuv0u+kyonfoZxm12iVPAxY4TIngLQ==
X-Received: by 2002:a05:600c:548d:b0:425:6d00:3572 with SMTP id
 5b1f17b1804b1-4256d003730mr6381475e9.6.1719558335593; 
 Fri, 28 Jun 2024 00:05:35 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3912asm21893325e9.10.2024.06.28.00.05.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 32/98] hw/sd/sdcard: Convert PROGRAM_CID to
 generic_write_byte (CMD26)
Date: Fri, 28 Jun 2024 09:01:08 +0200
Message-ID: <20240628070216.92609-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4a03f41086..b9c72a0128 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1515,17 +1515,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
         switch (sd->state) {
@@ -2088,8 +2078,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->cid)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
-- 
2.41.0


