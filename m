Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F3EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fR-0004Wa-9d; Fri, 28 Jun 2024 03:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fB-0004BD-J6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:53 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5f9-0008Ab-NC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:53 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so3505941fa.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558290; x=1720163090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tJt3SUxGAHgfMAGlqAtpQu/ZRYvhhIYidzvQ2esYug0=;
 b=rzKX9ozaCM2NqD9Rn1NPODQq519fzx3uZmVeQ+heO0cFeztr8zKpaoKnyhf5tQ5OBo
 peWvGp7cIeyXFVBJ1cD0WXrK6818h/DPmQDWkiAdHcH/W6+9ft0JXvfaLOuoZSZGOOF7
 wfzxa72xeFvPigGAleOssbGvf+jCtg+s353IwQBO1kLxLjRQ+qhYG8IkL2aWPNDABwTW
 f/S1vF1bazYIxv70BwnbfHEiH7MvN1TDbTtzKNVTfC2llr/vB2KN2wi3GpExkT2G280Y
 fCHPHqzPLZ6fm4XGZFsbb5bh1gfoFFg8EeyVer4jP4gTN/7+jYeX2sNErV4brXsl0IWb
 T6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558290; x=1720163090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJt3SUxGAHgfMAGlqAtpQu/ZRYvhhIYidzvQ2esYug0=;
 b=Qnin1uyajq8X/QnDa2yk2+nwHvVTyGfQHWpJOc6OVK1moxUcQghtcnUf4/oiBNyRiF
 Z4jANCsjFOUPMS/UzHXkUhFbG3fB81L9/J002dcBjQRn3SQu+rycT+sP48ZUjkMCJkep
 Q3mOt4wCh/OmVboulLkCZnfDyPadz41vcNB2Ki4YKQA1SsA606NwHqYPOJT0KTPAETGs
 Vdo4UvncPQ9hjPouVhfdKH6LKlfcmJ92riNcu6YJGUby1bDyHs2J2TygmEMH+FkmdJyj
 T6hCChGGfOhW5u9+uHlObD8PJPYGmox07s4lJb40pNO8nyl8YXE5EDhQSIdo1opruYjO
 NQOg==
X-Gm-Message-State: AOJu0Yyr/et330P+GsEAJ2FOq3WrUh7oJo+Tw1V2rrt77ecXJSHubr8f
 nq5WflzRp8zIS7pRx9dQLXpBH7ppBvnjmkCJqFtc1oWTLiD3xW0u1ZF3h2UGIiQ4wLAg+dSH/nx
 hzJs=
X-Google-Smtp-Source: AGHT+IEC+gTlQXplZZiqhnwSrwBLl+MeRiKMnuBE1NYESpJPRrvtT3n2JUpdwTrRLVIIXtO5q0G5oA==
X-Received: by 2002:a2e:7c07:0:b0:2ec:4e99:92 with SMTP id
 38308e7fff4ca-2ec5b31d156mr120127401fa.29.1719558289688; 
 Fri, 28 Jun 2024 00:04:49 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f99sm21193455e9.41.2024.06.28.00.04.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 23/98] hw/sd/sdcard: Convert SEND_TUNING_BLOCK to
 generic_read_byte (CMD19)
Date: Fri, 28 Jun 2024 09:00:59 +0200
Message-ID: <20240628070216.92609-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
 hw/sd/sd.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 605269163d..eece33194a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -568,6 +568,21 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
+static const uint8_t sd_tuning_block_pattern4[64] = {
+    /*
+     * See: Physical Layer Simplified Specification Version 3.01,
+     * Table 4-2.
+     */
+    0xff, 0x0f, 0xff, 0x00,     0x0f, 0xfc, 0xc3, 0xcc,
+    0xc3, 0x3c, 0xcc, 0xff,     0xfe, 0xff, 0xfe, 0xef,
+    0xff, 0xdf, 0xff, 0xdd,     0xff, 0xfb, 0xff, 0xfb,
+    0xbf, 0xff, 0x7f, 0xff,     0x77, 0xf7, 0xbd, 0xef,
+    0xff, 0xf0, 0xff, 0xf0,     0x0f, 0xfc, 0xcc, 0x3c,
+    0xcc, 0x33, 0xcc, 0xcf,     0xff, 0xef, 0xff, 0xee,
+    0xff, 0xfd, 0xff, 0xfd,     0xdf, 0xff, 0xbf, 0xff,
+    0xbb, 0xff, 0xf7, 0xff,     0xf7, 0x7f, 0x7b, 0xde
+};
+
 static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
@@ -1161,14 +1176,9 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
         return sd_cmd_illegal(sd, req);
     }
 
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
-    }
-
-    sd->state = sd_sendingdata_state;
-    sd->data_offset = 0;
-
-    return sd_r1;
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 sd_tuning_block_pattern4,
+                                 sizeof(sd_tuning_block_pattern4));
 }
 
 /* CMD23 */
@@ -2100,20 +2110,6 @@ void sd_write_byte(SDState *sd, uint8_t value)
     }
 }
 
-#define SD_TUNING_BLOCK_SIZE    64
-
-static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
-    /* See: Physical Layer Simplified Specification Version 3.01, Table 4-2 */
-    0xff, 0x0f, 0xff, 0x00,         0x0f, 0xfc, 0xc3, 0xcc,
-    0xc3, 0x3c, 0xcc, 0xff,         0xfe, 0xff, 0xfe, 0xef,
-    0xff, 0xdf, 0xff, 0xdd,         0xff, 0xfb, 0xff, 0xfb,
-    0xbf, 0xff, 0x7f, 0xff,         0x77, 0xf7, 0xbd, 0xef,
-    0xff, 0xf0, 0xff, 0xf0,         0x0f, 0xfc, 0xcc, 0x3c,
-    0xcc, 0x33, 0xcc, 0xcf,         0xff, 0xef, 0xff, 0xee,
-    0xff, 0xfd, 0xff, 0xfd,         0xdf, 0xff, 0xbf, 0xff,
-    0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
-};
-
 uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
@@ -2142,6 +2138,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
+    case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2176,13 +2173,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
-        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
-            sd->state = sd_transfer_state;
-        }
-        ret = sd_tuning_block_pattern[sd->data_offset++];
-        break;
-
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         ret = sd->data[sd->data_offset ++];
 
-- 
2.41.0


