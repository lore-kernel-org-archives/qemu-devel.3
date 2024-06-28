Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67EAC30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5eM-0001JI-29; Fri, 28 Jun 2024 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dy-0000mQ-0Z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dv-0006kM-FI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4256eec963eso1420405e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558213; x=1720163013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DSF5Ro3NaUsJXtCUAFWLr+3NgzU6nFSUILhMkj2n5D4=;
 b=gnMPtFqf3o5nkRflbjUo1euMOFrmj+D9XYpfzacDrLZOjAIKWLFnYcV/80AIHO7sTb
 nT/8TE8DTUf0ANoNGuFUDA2jHMcltKJeKXJr8HMreYzozef1zqUc11hF9UV79tJElnom
 MpWaTzDrw6Rdfa35wxpmqgRm1HVPL6xtQEXsXw66xJIap8HzT13J0O2jLFKgiOM/7HnI
 hRDvK7ko01dZwRk9ncEPL0FGcz7XtFhqJBzQRSBCj4Be/GlWR2kSt81Y0NYvuHRoOo0D
 pkTBkt/+HTwRa9STXskvtZkVRkH7qxpQESlsk9i0wyMI9XeGD3X6icDqEsXcUmvFAYKC
 ECug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558213; x=1720163013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSF5Ro3NaUsJXtCUAFWLr+3NgzU6nFSUILhMkj2n5D4=;
 b=qPpqs/KzoAJjunE44wQNH7/3T2HnANkAP/LPfU8vTFLw1JRhm9QkNdNxmCvQ529cVS
 +hbCxc6lE/qoDf05f9uHtqoz4V15ipLwIaymBzOUCqlABhCcBeQgN2aBEMRtvdhwz+KV
 x+Oe7IFvmP/vATxXNAEaznRsM4WhleDaCRXry0vLBOsjLnrh8kJeSMBSF5BWvhkto9hY
 pcqCoA5nMLmMOB0c+ZgBxE24yFs2tLhUMn6UA+KshPYtB4i/Q0yyV9GSFjIW9aZsNrg1
 m3AUBd9IFLWFerZLmjQgPZHYjJQG9cVqTg6h5hfg4Kc2UO4nbmzy5nZ+MlHQfw7tL5Hi
 eYTw==
X-Gm-Message-State: AOJu0Yz9f2HOVUo+sVtzIVB/PjExQT2ddMBZctNl586FTF4e4jBXbI2u
 fhuqYctyb4W7It9UDzY67SYKw3fbX5BaNa0RsIIWXTF/u5jw0Z76WpKJpLDUPCOvU9YLVRiGRwk
 ttzY=
X-Google-Smtp-Source: AGHT+IHI9MVOPf96q0rjvuBflkUyd61zl/oAfLRBkhpIWbWG0W+64tOZdGxfV1tdexkhXEEWHcA3vw==
X-Received: by 2002:a05:600c:4889:b0:425:5a26:a12c with SMTP id
 5b1f17b1804b1-42564510fffmr26402755e9.13.1719558212877; 
 Fri, 28 Jun 2024 00:03:32 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc58esm1333986f8f.72.2024.06.28.00.03.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 14/98] hw/sd/sdcard: Extract sd_blk_len() helper
Date: Fri, 28 Jun 2024 09:00:50 +0200
Message-ID: <20240628070216.92609-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

Extract sd_blk_len() helper, use definitions instead
of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaa50ab2c5..5997e13107 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -603,6 +603,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
+static uint32_t sd_blk_len(SDState *sd)
+{
+    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        return 1 << HWBLOCK_SHIFT;
+    }
+    return sd->blk_len;
+}
+
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -2076,7 +2084,7 @@ uint8_t sd_read_byte(SDState *sd)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return 0x00;
 
-    io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
+    io_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
-- 
2.41.0


