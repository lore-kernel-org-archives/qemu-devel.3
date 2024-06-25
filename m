Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25324C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzO0-00085q-43; Tue, 25 Jun 2024 02:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNz-00083c-1W
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNx-0005cA-FR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso56281255e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295832; x=1719900632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdZ/gPYJlqHWcokRVsRKXJeHIx3TF27J1xoEuLRI7JQ=;
 b=chsc79MQYpn8x+DQ2JQyZfnY15SOH3PJyyjYOsDWsadJhnQj+t1UtzqvB49oBY63zb
 o7PGTjjjK0/eE+f/iRoM1S1t9wNRduQj7doer0K8A0er1jj8r5VDofIu5/dc1Ky+MEw6
 NGqhqX1/HMtwD6HdJ8w5jH5fKzYx7VzC5Zk/EyPsVV3+m2GOQc8t5xwum3l7RgUwtaRD
 bWyNSs/0JK4i6TERb2M6u/WhJDEfU63/DJS5OVqUliwuNH/w4eXZyCC+gKKmEl/ukxOJ
 uQaP12Or6mAB6B5OzDOUjBbj2Mn25lRBMcZr7ZtTt9tepfD/lexdGjFJeJluGw6W2ONV
 K1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295832; x=1719900632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdZ/gPYJlqHWcokRVsRKXJeHIx3TF27J1xoEuLRI7JQ=;
 b=ZP9c+prs2vysX/U9IyfLfDAzz0qzrH1AkqOFaBdT78nIzKpvlL2PWbulb0dU/xQtKL
 g1AbFygkTxMgwBpoSS8EaNSXiRcEFBZgsrtZGrXvxSB6fEaHocvl8fJBcSEV3KAAzynD
 R2F9wdLfdJTtwC1W59ox/7kNCxIfyyLhn+1WZcIg+T7jBjLJxSp+XWz1DJFqZnpdTKPl
 7G1CUCAdYwOM+JVlAEfOLavcexhyj4BbMQnvsOZQSp1d5NCURmVvC8oR0Bstq+Xo+dHW
 2b+s49XAZZLu3yzLllhyhN2JCbjuuIYarYJPbGPXb2pcZvwD+5l2VqG4tg8ne/dszXc8
 0ZiA==
X-Gm-Message-State: AOJu0YznmPrFwHUm3bUL/Ki3QcNLMMZviXs+4KvygV1kAQgsTW6AyoQ+
 70clEbgBJAz/J4WvvvZFwBGvmiN4aMPyN2I7GDwgY7S51pJd+Yp43n5JI5IhX5NO+8A0C+kilu6
 X
X-Google-Smtp-Source: AGHT+IGbvQopyM1e1ex+qNu6VRCsguS8XVKfd4hVaicyboapG/SVdCtViQ/MB0Yu/aH6FO2GY+pPwA==
X-Received: by 2002:a05:600c:5713:b0:421:29cd:5c95 with SMTP id
 5b1f17b1804b1-4248cc27143mr57459815e9.10.1719295831872; 
 Mon, 24 Jun 2024 23:10:31 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248179d8e0sm166542555e9.3.2024.06.24.23.10.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/11] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
Date: Tue, 25 Jun 2024 08:10:06 +0200
Message-ID: <20240625061015.24095-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
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
 hw/sd/sd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 89006ba1b6..0011aa86da 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1220,10 +1220,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
 
         sd_function_switch(sd, req.arg);
-        sd->state = sd_sendingdata_state;
-        sd->data_start = 0;
-        sd->data_offset = 0;
-        return sd_r1;
+        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
@@ -1922,7 +1919,6 @@ send_response:
     return rsplen;
 }
 
-__attribute__((unused))
 /* Return true when buffer consumed */
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
@@ -2112,10 +2108,7 @@ uint8_t sd_read_byte(SDState *sd)
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


