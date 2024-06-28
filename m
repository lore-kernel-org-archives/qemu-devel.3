Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80508C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fg-0005pL-1Z; Fri, 28 Jun 2024 03:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fb-0005Rv-Dh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fZ-0001Iw-Fa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424acfff613so3323635e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558315; x=1720163115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u+jyXabwo5N3Lda8MVmtADSx82chlrXIi1rMmDBEsbc=;
 b=X9zNV/E+K2ff9RA7RxiqeELnRHPxKWL8Bi79GFWVXVPPHvM7ucV7sRYDmGFWHK6Ww4
 hOgEceuy3n7edOwiDhyFmsjxlHkKOa/PNbivPIeR6dq+hdoASVZWYI+zh5t+TW8coRKx
 APaf+xZEQnpzX3IEFz0SgnkD9daeY7oss6paU8zW7K3CT3m2j8ERkHP7u6VWl4jWb/3k
 NzE27v8tRiFe+MlohkMmtlhP0/30yynX3H9XBSe0TtzrHm/cH/jNx1/THxpc23pZeaH/
 z0dVN8ags60vvT+jX663z2bQppYN3ubYL0RN/hN/ncZuxxDVrggG0C0gnZlygXJsqzIt
 rlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558315; x=1720163115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+jyXabwo5N3Lda8MVmtADSx82chlrXIi1rMmDBEsbc=;
 b=dDQANBHTL4APaRR40NPk0TG6uVztIygHm4Lvpc1S6j1DSodenHenXsbCv0ykU7zq9P
 V8d+seDt37T+eonWFsrHP4tfSzDfYflVzxjYmlAmlWDUjFYr2KJuboYSRU26in5u2K9m
 CeGrtvbjH9iOjB+4CZbNU2Z1LjA3C/rgukEX6nfClb0COdd3GMUp9zzNb8xDkfF/XkPA
 UcFkpyylBzPlGKK7/rJOkI0prABMvVgMSzRFoeQaq7GuhcJ1OSOaOI7d7Rs+9rKZjU3A
 ZfYWaqzAOh38Ng3TLOHuX/6tnmR/oJ9AirVkyqrqbML5JP/ZVNpZKG5s6Pz3botSQKuX
 n9PA==
X-Gm-Message-State: AOJu0YxCpsh5WKWyq79/wbIg1ZwTJVCvCdeuVB0MeuooAO2Q+3T1iWJX
 Pnvpxh1J3FiU4V0lZZoplNqvhmZtgNMe8dhI4RaE+8vvJ6r5A1Lve++p2GtLsvoudOCO4wusVm1
 mfcc=
X-Google-Smtp-Source: AGHT+IFNM5GBxZEIQ8GigFwCieqEY23GxMCHGDAIfqFtQZ+5+3ZDWq3tydnDgc9Uhw867aebE25Y1A==
X-Received: by 2002:a05:600c:4306:b0:424:aa86:cc2a with SMTP id
 5b1f17b1804b1-424aa86cc80mr73450845e9.20.1719558315336; 
 Fri, 28 Jun 2024 00:05:15 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e146bsm1326610f8f.57.2024.06.28.00.05.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 28/98] hw/sd/sdcard: Convert SEND_SCR to generic_read_byte
 (ACMD51)
Date: Fri, 28 Jun 2024 09:01:04 +0200
Message-ID: <20240628070216.92609-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


