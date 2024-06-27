Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF27CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMryi-0000lW-PN; Thu, 27 Jun 2024 12:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryg-0000j0-Ls
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrya-0003OO-FN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:28:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso4423195e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505678; x=1720110478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCAoLc7mb3MX2dHo327SeM2P71tXBpRF4C3PP6PydTI=;
 b=Ow85t6zGoMZL5rfAibEj2gYXtKbN8uiqbfc3odrqkW27S4g1qyYAOr/o4s8wmZFVv8
 OsaM82RjZirRqE7l9PmoKGOtauUOoP1z/J+zh/ln2pKgkIVfKhoHLfpFeT7M9Wj6ibv/
 Ohm788b80Qt38XaL6uUjfuhEye96VyAu0CmtBdrQz5n9E+jKCvN6g6d6DD7ecRJNyty1
 4k5m4TJltj5NfMHegpDlzKqjBrCBUBkgGkzNkzuvy96e0UUQt9T8lOY030ffjcbsS6gr
 ofwWydo1HaLzbfkWOx2Uo4BUUkHFAtiwzB6/9Ldf7Q3r//3A+kiXlD2jOiwFcXzOFlWo
 0Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505678; x=1720110478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCAoLc7mb3MX2dHo327SeM2P71tXBpRF4C3PP6PydTI=;
 b=dw0MQaE3GgxrCithlXL2vHgEcyj5Nivnch1FPY9hCNz0PG+97+XHc+g3BSw2lsvkEF
 4kvDboZvyVHbpPfiLlnrw9CfOzK1/aKmaZJeaxyOYMH/YSAL5pBn1EUL4CF6PW6UcXsw
 q7abs66FcJ7jRlPupxXqSmkiD4E33rK0VRN2gyife1JBwrLYtY1oirN0nFTfTMvzVJ45
 DAmyn+DxRzYGMwkP5t+sEAxLxV2waFwINBfxPSoS9pB4kzbMEhsle/CH4JzgBWnzUOqW
 ozh/qh6JAXyvW7bppPf04zUD3zV4xqBtn5I4FldC5UCM4C8ivJVzhVy5o9RF6GDOYXLm
 DmGA==
X-Gm-Message-State: AOJu0YyXJyGG756VfHr/YA7Yxd7CeM1D9oJjtJ4cVONYHuRAOLK8uUld
 zyyK3/2UGoDE+LvgFoGaASm0e5V0Mob6cr4tWw1Sdm1q6w9mB5YWD1zyIp1JQnMNiTR5Rj9ujUu
 tV8o=
X-Google-Smtp-Source: AGHT+IHyN7cEXOLfqrWwo2hBDF13kWgH0mkcLdXed+YMylS9xaoPovfoxzhtUmk3JFbGdFR+cPUFkg==
X-Received: by 2002:a05:600c:1d01:b0:425:6927:5f6a with SMTP id
 5b1f17b1804b1-4256927620cmr3528425e9.19.1719505678287; 
 Thu, 27 Jun 2024 09:27:58 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424606sm73979315e9.30.2024.06.27.09.27.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:27:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 02/11] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
Date: Thu, 27 Jun 2024 18:27:20 +0200
Message-ID: <20240627162729.80909-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


