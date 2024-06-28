Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7675C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5f0-0003cU-8M; Fri, 28 Jun 2024 03:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5er-0003BC-NF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:33 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ep-0006os-O5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:33 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so2318601fa.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558269; x=1720163069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PCAoLc7mb3MX2dHo327SeM2P71tXBpRF4C3PP6PydTI=;
 b=uyST5QjOvsb0ykQQbMbLyz7804TLtHu+9ngoUUkScDsOwfAOfn8K4G2OTM0baekBr2
 LLzhRmVLAuSUzuTWB8RCFIz74E5zs4eFmgcixdyBogJue6pAhYZkmsmma9eJM7jLsaz9
 qJFPHMv7gKABKvZuIAffy4dB0LWlM7yzkskDFhoPm55cA20uJhhG2lcBkC2453cN21GJ
 RNErL/koobew35lq0FZBzfc8Vraw+SeMAy8GMo3lmIBYz1RP0AeJdzRFi+ZgKmpwC7c8
 ryjJMvWDMoGRatfpENThMpev0m0tPkR6wk8OYWn20hzK8sU9FBVBswN+iUfVE2jf58rV
 K4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558269; x=1720163069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCAoLc7mb3MX2dHo327SeM2P71tXBpRF4C3PP6PydTI=;
 b=FP797Rv0V/DfiuhZp61WKbjP4pUADaWtddBCburoNFUp/EY7vUI56DohX9H+PRtfuD
 g2c/vsss5u6X5flFfWVCidH9uLBnetbNBiACyFUK0C/5qyyLe9BgRPDlCGmyGWMpzwps
 JYtOyMZ5Aq6iCY0EHbj97QlzKYYAxM+lw/dddKqDjKaMTzXQjZ38LrcXu3NPa3v2jOTg
 IsKG3TyValvuu/tQl6KBiX7HN2LXM6C3DtHcycBc0SRUHnqEFPPMSLKp5dAGIRsJywJX
 e5Z07HCY24MLUegCfy41dm58EL9lgEKKygU2hzGfqGIVnZurtFh6fBhZR3ATouXKeAsy
 qz2Q==
X-Gm-Message-State: AOJu0Yy6TsOMaGKbGBu1KF32oOLxvoPLTafaIrs7WOr8IwF9SnHpBR3h
 QRn73kRs5IVmn1V8Al20JTyWjxeE9KBLj0GHy9B7sKp3g5VZeVtyDZRq2LFBqsDFCKd40Odp6QD
 cw0Y=
X-Google-Smtp-Source: AGHT+IGqQ6J3B8dDGn4gU9gY+FPJT9leRE/chNQp+0ul6/cErMYBb9el+9W8jgVVz5/QXxDWk6QFNw==
X-Received: by 2002:a2e:9886:0:b0:2ec:57b4:1c6a with SMTP id
 38308e7fff4ca-2ec5936fa52mr112080041fa.42.1719558268964; 
 Fri, 28 Jun 2024 00:04:28 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0fbesm20400065e9.43.2024.06.28.00.04.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 19/98] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
Date: Fri, 28 Jun 2024 09:00:55 +0200
Message-ID: <20240628070216.92609-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
 hw/sd/sd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1a8d06804d..f7735c39a8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1086,7 +1086,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 }
 
 /* Configure fields for following sd_generic_read_byte() calls */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -1243,10 +1242,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
 
         sd_function_switch(sd, req.arg);
-        sd->state = sd_sendingdata_state;
-        sd->data_start = 0;
-        sd->data_offset = 0;
-        return sd_r1;
+        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
@@ -1946,7 +1942,6 @@ send_response:
 }
 
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
-__attribute__((unused))
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
     *value = sd->data[sd->data_offset];
@@ -2135,10 +2130,7 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 64)
-            sd->state = sd_transfer_state;
+        sd_generic_read_byte(sd, &ret);
         break;
 
     case 9:  /* CMD9:   SEND_CSD */
-- 
2.41.0


