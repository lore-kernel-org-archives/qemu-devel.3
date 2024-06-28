Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947DC30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3cR-0008Fe-FG; Fri, 28 Jun 2024 00:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3c9-0008Bn-Mw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3c8-0008TP-5z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4248e28de9eso1960775e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550414; x=1720155214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLfOaKjryvDgm8/tAb2iA3e2u5r9x8cBXXCm9JQWcag=;
 b=MGniMHVbfPFwk4ZmDvn/1W9t2cXnNsxkadB0mqVki0ArGPfLK5E6Gec9ctx97tyqvc
 0WlbRS2IMNx5LiKkqh2nvUI7oJQKg5Q3NKMg4OK+4cmQEJw6y0+8p2tdGbMasDLWo1q4
 //P9DYkxyJWxP3mS/9lW8PSiRwnGjJOToaRsDjZmH/JLQC2dbAbGXoWx3lbc8ognX/5l
 R2wa7vGXLTqbhy+zgIJ8g7327ZtG/CBL7ETrObOS3A5zHIPx+A7RQZmKwZOR7sPWCV6T
 I5X5ooXGtUsd8ob0EzoydQR3tB15mDnnu/IdejfnV1f/be7kVDf+31Q4rwBaiji4Qxxd
 y4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550414; x=1720155214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLfOaKjryvDgm8/tAb2iA3e2u5r9x8cBXXCm9JQWcag=;
 b=kJZRpbXekDovjOq/O+WBMLRZ1AnlmZAeSVdRPTZIM7QLb7SC8XnEzlimnSWtfiaebT
 v349UZ8ZKrTGp++JjouAn8R+uk/snlM5dgg1ZSHzKn3C/9eauWqsy6ZNJYbXRJ4kSVxq
 AXUYAYRklzfQngCyn32I7S3hepj/c9ReBw7bWhucXDMYdJjQFfIZRbNc2mkKakzIB0SA
 c0uJcPmKHi0uBTIBHEwlAYoKQYWaTI1ekbxS7JEArKWLWIzgqA7ZkMRA7VFaMTv1yauc
 OLh2+VV/hrvW8pI9uuuEnAzwEWXenUXnz8tQqTr/nGE4nZ1IDJ+Y5QdavPCTsuYKmFVE
 gN/Q==
X-Gm-Message-State: AOJu0YxcnwIwhTFiMHhBpdwNTOmot6a+mLymzdT1HVByzMWIwBR8UUmI
 +b4laggOIbTqlqXd4zWyXCZRketV3xKJZfVaCoNMPxS1eZlUu5UJdNCRZMr0ENw2XNlnm3cnUlI
 7NEG05g==
X-Google-Smtp-Source: AGHT+IFf8zCe7rLf6YyxQ08v5dLuzr9h9IEbQHaOKi+JzQFKgLNQpxjEI5GK+Cjx5g6mZMP2ZchVAQ==
X-Received: by 2002:a7b:cb17:0:b0:422:9c91:a26f with SMTP id
 5b1f17b1804b1-4248cc3426bmr107515545e9.19.1719550413994; 
 Thu, 27 Jun 2024 21:53:33 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0642acsm18165885e9.25.2024.06.27.21.53.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/12] hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS handler
 (ACMD22)
Date: Fri, 28 Jun 2024 06:53:14 +0200
Message-ID: <20240628045323.86308-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
 hw/sd/sd.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5323a42df2..9d66c3715a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,7 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
+                                            [23] = "SET_WR_BLK_ERASE_COUNT",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -1689,6 +1689,13 @@ static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
                                  sd->sd_status, sizeof(sd->sd_status));
 }
 
+/* ACMD22 */
+static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 &sd->blk_written, sizeof(sd->blk_written));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1797,18 +1804,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0,
-                                         &sd->blk_written,
-                                         sizeof(sd->blk_written));
-
-        default:
-            break;
-        }
-        break;
-
     case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2324,6 +2319,7 @@ static const SDProto sd_proto_spi = {
     },
     .acmd = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2382,6 +2378,7 @@ static const SDProto sd_proto_sd = {
     .acmd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
+        [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
     },
 };
 
-- 
2.41.0


