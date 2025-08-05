Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6627C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWE-0008OU-88; Tue, 05 Aug 2025 13:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWA-0008Lb-Hj
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLW7-0004ti-Td
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so51069735e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415122; x=1755019922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fg39G0/rAAlkgbsiRQ53XTzj6ZDXzYraE5f8RxDqE+4=;
 b=QEG7R9lUZCEPUCpVFOoQFqDxpSC8m6O3D3hA8KyrvoCzdbytVuozTmes2yWsDNvkMd
 TWD6dddZVdV6txM+JtMAkOSJXOl4oZfcQVnHobqYeeAo+sqz2WZPUDUmkivqM2nBVQ5f
 XhBItQasQQBbj2VYpq7nU7WU0TRYdSfOAXNTl5o/Me4Sz8xIHvXOfEk0fWwlGTVSKnN4
 AW04IodnvXH7n7Gmt+XPS9653Mj9YaQj2DBnYq+Z9MUxld0dD5rqZvdNBGP7nPLEsf0u
 bYXJl+8GPlE8w1eId0yXuycEzbF1Xq05/y55OTIaV5f2OeSCnDtA8jvcXEZR2Jahtrgt
 UWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415122; x=1755019922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fg39G0/rAAlkgbsiRQ53XTzj6ZDXzYraE5f8RxDqE+4=;
 b=LEdWwWzGXCO4s76995XwSufZWObRfPTaCMYfqOo3f1MfbNAU2000rXeL1qrefO7oF0
 gozwP4zdr8hCDdq5A3IfGsbD6EL+p1JvtsZVLaRO+M8jAXB7dfHniuB3/w+8pv98uTFi
 cPBxF9MPdXa+TYowrIzWyXf6muNbbY8XvkIfy5hvJBH5k7vg8bnCBdHb9owQhCCDLL4T
 U2CHdBBowJTsUQA5HHKtw7X9QnhxtWTZMT3KwqSPLqcl26pf5TpR2c0w9CKrP8eKrtdc
 f9NqtgyI5e3pCxW6jr7BEo4XbDY1LdvTxZJ7d/0jrZWCAC+sKD2fFufK7wMGdDsLS3mt
 z1pg==
X-Gm-Message-State: AOJu0YzY1sxHZbCKxOVStqf2/1n+Gwrir2lFhg7HGTsodeGHIehLF6hD
 V2lPMCGnuRKKQq46gBaOVnX0OtnjIL9yKZDOZ9PhXxg3Hn4J6BoPCu117HZ0DZ+iye2ka0iBYBj
 Ik8S/
X-Gm-Gg: ASbGnctRsLRhybncpoPpuBYYVvOtr+Aa7sdzko5GVBvvj68oGDYTeo7yUKvfMa9dgaq
 u/PvsCI6vIq2dg5cg6KPSknpDK6lItAOxGTZRYmwlnGunRD09TM1dNnSUv5UFLRj9MG6r8UE/Hc
 AV4QSHIVY6KxQFUPL14KhR34p/vKfc2NT656MjFQ9x2YmFUPZA6EM5juDBcC67XrRaMmTX1V+ee
 XQOOTeNFQh51RhgAs3CXBDk8Lz05f3xpZOoRCy2jALuj8X/HfGtmtgetZymoPssmXkHjPgBEhy9
 Arqtr65bp/u+/hUeFc2ru7GMd64bLkAIyrDac9TmL4Dj9rV1Vhwc6uW7uFqQUwtZiwskU67v7Kl
 cTUEuwIFGPZe8NXAj3h1w+hELI4x8e6tjKZHxz2kzA1hd6ubZsIWNRWzph3VIAwbvQ19YjiSS
X-Google-Smtp-Source: AGHT+IFsqGTnhkgxvRuh7ijZGSqtMT1b5DXgM8FF56gs5xARl8Uaj5lfh0WAYZBi562vi+R6YRguUA==
X-Received: by 2002:a05:600c:3145:b0:458:a7b5:9f6c with SMTP id
 5b1f17b1804b1-458b69ddc11mr109377615e9.11.1754415121900; 
 Tue, 05 Aug 2025 10:32:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5c40e9bsm4562125e9.7.2025.08.05.10.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 05/13] hw/sd/sdcard: Implement SPI R2 return value
Date: Tue,  5 Aug 2025 19:31:26 +0200
Message-ID: <20250805173135.38045-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
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

In SPI mode, R2 is a 2-byte value.
Implement in spi_response_r2_make() and
return SPI R2 in the SEND_STATUS commands.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-6-philmd@linaro.org>
---
 hw/sd/sd.c     | 38 +++++++++++++++++++++++++++++++++++---
 hw/sd/ssi-sd.c |  3 ---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cbcc180f6a4..01ec6d951c8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -61,6 +61,7 @@
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
+    spi_r2,       /* STATUS */
     sd_r2_i,      /* CID register */
     sd_r2_s,      /* CSD register */
     sd_r3,        /* OCR register */
@@ -247,6 +248,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     static const char *response_name[] = {
         [sd_r0]     = "RESP#0 (no response)",
         [sd_r1]     = "RESP#1 (normal cmd)",
+        [spi_r2]    = "RESP#2 (STATUS reg)",
         [sd_r2_i]   = "RESP#2 (CID reg)",
         [sd_r2_s]   = "RESP#2 (CSD reg)",
         [sd_r3]     = "RESP#3 (OCR reg)",
@@ -736,6 +738,10 @@ static size_t sd_response_size(SDState *sd, sd_rsp_type_t rtype)
     case sd_r1b:
         return sd_is_spi(sd) ? 1 : 4;
 
+    case spi_r2:
+        assert(sd_is_spi(sd));
+        return 2;
+
     case sd_r2_i:
     case sd_r2_s:
         assert(!sd_is_spi(sd));
@@ -778,6 +784,22 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
     sd->card_status &= ~CARD_STATUS_C;
 }
 
+static void spi_response_r2_make(SDState *sd, uint8_t *resp)
+{
+    /* Prepend R1 */
+    sd_response_r1_make(sd, resp);
+
+    resp[1]  = FIELD_EX32(sd->card_status, CSR, CARD_IS_LOCKED) << 0;
+    resp[1] |= (FIELD_EX32(sd->card_status, CSR, LOCK_UNLOCK_FAILED)
+                || FIELD_EX32(sd->card_status, CSR, WP_ERASE_SKIP)) << 1;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, ERROR) << 2;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, CC_ERROR) << 3;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, CARD_ECC_FAILED) << 4;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, WP_VIOLATION) << 5;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, ERASE_PARAM) << 6;
+    resp[1] |= FIELD_EX32(sd->card_status, CSR, OUT_OF_RANGE) << 7;
+}
+
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
     if (sd_is_spi(sd)) {
@@ -1643,7 +1665,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     }
 
     if (sd_is_spi(sd)) {
-        return sd_r2_s;
+        return spi_r2;
     }
 
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
@@ -1957,8 +1979,14 @@ static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
 /* ACMD13 */
 static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
 {
-    return sd_cmd_to_sendingdata(sd, req, 0,
-                                 sd->sd_status, sizeof(sd->sd_status));
+    sd_rsp_type_t rsp;
+
+    rsp = sd_cmd_to_sendingdata(sd, req, 0,
+                                sd->sd_status, sizeof(sd->sd_status));
+    if (sd_is_spi(sd) && rsp != sd_illegal) {
+        return spi_r2;
+    }
+    return rsp;
 }
 
 /* ACMD22 */
@@ -2264,6 +2292,10 @@ send_response:
         sd_response_r1_make(sd, response);
         break;
 
+    case spi_r2:
+        spi_response_r2_make(sd, response);
+        break;
+
     case sd_r2_i:
         memcpy(response, sd->cid, sizeof(sd->cid));
         break;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 2d5c0ad5016..594dead19ee 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -158,9 +158,6 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
                                          longresp, sizeof(longresp));
             DPRINTF("CMD%d arg 0x%08x = %d\n", s->cmd, request.arg, s->arglen);
             assert(s->arglen > 0);
-                /* CMD13 returns a 2-byte statuse work. Other commands
-                   only return the first byte.  */
-                s->arglen = (s->cmd == 13) ? 2 : 1;
             memcpy(s->response, longresp, s->arglen);
 
             /* handle R1b (busy signal) */
-- 
2.49.0


