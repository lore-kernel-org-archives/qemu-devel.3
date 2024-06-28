Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07368C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gM-000153-DW; Fri, 28 Jun 2024 03:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gK-0000rv-EX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gI-0003EU-NI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso2790895e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558361; x=1720163161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0hugKoDWkNwghwH1h1z7n8tbSuuJya6Cw/1S35GizWg=;
 b=cRbm9ftMDYVRnJz+b3/hAHqI86esAAZBfX6+mdzwrrNSZO+MBABY/K5DE50e0baKQz
 eS+gtfpan1qe+szqLnvnIoZJIMcJnfQauApX7HFmteOxhd9cP7JQ99e4KatATCNWYCen
 auHVU1Vf4EMNSIStgmmn1y7GJihT7TGUMbaCFYF5whZ1WADffcA2Dxq0xHBpMKjJapDJ
 KhFtXBEOkuzlmzK3M/J/DCsP72O1U0INz9o1F3TBlh4naIzj1HgsPus7nXzirWltbOjF
 QbChvgwmpw2hvG6qxiC2luApgjl5t7L57q3iL4iskXEk7ECahNQfO+m4ZeTtDelf7bOa
 T3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558361; x=1720163161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hugKoDWkNwghwH1h1z7n8tbSuuJya6Cw/1S35GizWg=;
 b=ThF41dRUu3pYL/zXWf4BKK/t+cYy720xRrX/a89G6mMJQWXoynYSVBydJG+mCU2Ghs
 wchjhUtYueS5z+zkK7Eijhi5HJeXiQzzxjunCXMp4EsHuo8BoGt/YXTisy7cpaoFSqXY
 PxpnhTI1+d63OFz444HALue1LiUqrSx1wrYFCnJXxlriLbO2Lv3ZoVTSqj/wdh+HoiXF
 6o3O9dukvnw1v0U+hFx7/bXMQozMx4aLfBQrhT4au7yNFJ2p6f8Ut99TEf5gh24lUv6K
 L8jDTw5X9EpqTvpwn/+2/NO1HNDLDnAlJmEdaLEH4X1AzCUO0t6+PjKRgwRsz0ZVjuu6
 cEbQ==
X-Gm-Message-State: AOJu0Yxy4WWQSfSjlzXTzpy+111fxTqnGTfkM8W6okj+/cxS0XKWx3PW
 8kzDSFu/lIg+/NBC+0HhyyibOcf1lODi2CnzPxWzi7BKV9pUSSA4YCDS6f7tW/lIuK7sVHRtBtC
 wi3o=
X-Google-Smtp-Source: AGHT+IFIZnHXI24bRf3onzUgquDqNpApyG0bkguBXMv8zVV1P4zF/f21G9miHBTFEzj6g2a9F7W6Fg==
X-Received: by 2002:a05:6000:481e:b0:366:f994:33c with SMTP id
 ffacd0b85a97d-366f99403eamr9080089f8f.56.1719558360773; 
 Fri, 28 Jun 2024 00:06:00 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d62sm1319479f8f.105.2024.06.28.00.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 37/98] hw/sd/sdcard: Pass SDState as argument to
 sd_[a]cmd_name()
Date: Fri, 28 Jun 2024 09:01:13 +0200
Message-ID: <20240628070216.92609-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

In order to access SDState::SDProto from sd_[a]cmd_name(),
pass SDState as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 93a4a4e1b4..f4bdd12b26 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -233,7 +233,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     return response_name[rsp];
 }
 
-static const char *sd_cmd_name(uint8_t cmd)
+static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
          [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
@@ -272,7 +272,7 @@ static const char *sd_cmd_name(uint8_t cmd)
     return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
 }
 
-static const char *sd_acmd_name(uint8_t cmd)
+static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
          [6] = "SET_BUS_WIDTH",
@@ -1281,7 +1281,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint64_t addr;
     uint32_t data;
 
-    sd->last_cmd_name = sd_cmd_name(req.cmd);
+    sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
@@ -1748,7 +1748,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    sd->last_cmd_name = sd_acmd_name(sd, req.cmd);
     trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
-- 
2.41.0


