Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D65C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5ks-0001ra-Bn; Fri, 28 Jun 2024 03:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kq-0001oC-BF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ko-0004qP-L7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso1788715e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558640; x=1720163440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z9Lv5oRHhagfJkOeTGJdPKagMg6fgJmQOzE+waR1EWA=;
 b=T98JedF6nwFPQAHKVNQ+26D8R7WkAIvDVxJpEdBL4Idg2vTwQsCJpMwawmmxNnZxHH
 YMwsM8+e02MWUvH1kI9l4m7+lSntnX1NVraQzQ0SJR6GCGLgLGyJv3y3z6SfORJHvyCG
 yzvMlfB6f9BtQ7XAvT86oDVTZ0SPfJl0Q2XBs7pkP5M95z0mJm5PPOO3yxh5L+4ePM6Y
 n7FNd45i77zsqePHYzRNQlVyk9S/kW++Pz331pkBaEYL6ldyFqlXORV6exPHOYao7v0p
 aULwE15PUXzLWffk0jcd5TKqLduhsE9KXj++GGzlotggdDdt4Xp5ddJXPe/sWFCQRMW6
 rd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558640; x=1720163440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9Lv5oRHhagfJkOeTGJdPKagMg6fgJmQOzE+waR1EWA=;
 b=gWGxqyxACSWK6cpCPMosEGGDFe4oxC2AXOjn80o8Nk0yD47nUEXyktCx1kUfthUuQU
 4xZY37JthHTKzdSEZ+iW+NMPNT7sI3WdwAIrIWrkszYfHU/IjVgYj2DbnxYnrJtVlcD2
 KZNwwOpiAryr0VZ1XOFLXjyDwasggSWoupi4N+OPJXtsZRQ+G+pWGEtMFimGih2Umc/1
 voJxxkTgiIIx0lGR1vLwgjT+xHEavh8hpiBioa1qT4eoskeTD+DsKXqr6lyQCnDyUVmo
 7aJqSGjOw0Vw9Ae1jMBJX98zKtAbxE/aXs36DQxnM/muUBlNrjHf7xrZRvvECds6LorH
 d0kw==
X-Gm-Message-State: AOJu0YxUBylwzXSnxfMlpq0gf8kP3o9lerp+ugFoA4MSIklhvNG5+LZF
 0VvxR1lWzMEb0wEIOZoTo3GYEbWOllRV5JlaDA/WOszkLZi8qZZaB1uFHXIyFCZvnUOUB/1M+4o
 y4hQ=
X-Google-Smtp-Source: AGHT+IFCtM6EEN6utenCuAQWkhxLZEEAxegirbAm5FtWJZk+ylEDdAtFKZ+J8+n9UoWCtbKLyba67g==
X-Received: by 2002:a05:600c:484f:b0:424:ac60:3a1 with SMTP id
 5b1f17b1804b1-424ac6005afmr59414605e9.20.1719558640648; 
 Fri, 28 Jun 2024 00:10:40 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0642acsm21930665e9.25.2024.06.28.00.10.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 86/98] hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler
 (CMD1)
Date: Fri, 28 Jun 2024 09:02:02 +0200
Message-ID: <20240628070216.92609-87-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Add support to Power up the card and send response r3 in case of MMC.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c6e5c93acb..2dc0209482 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1190,6 +1190,12 @@ static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+static sd_rsp_type_t emmc_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
+{
+    sd_ocr_powerup(sd);
+    return sd->state == sd_idle_state ? sd_r3 : sd_r0;
+}
+
 /* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
@@ -2398,6 +2404,7 @@ static const SDProto sd_proto_emmc = {
     .name = "eMMC",
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_bcr,  "SEND_OP_COND", emmc_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
-- 
2.41.0


