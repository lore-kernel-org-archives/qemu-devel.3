Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA70C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5h0-0004DM-LH; Fri, 28 Jun 2024 03:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gy-0003zJ-M5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gw-0003JL-OY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424ad289949so2336685e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558401; x=1720163201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ESvyw3GYgt7hOD38NPh8gyks0iX0X2xZyRHCeLbcWRk=;
 b=wp6guBI7GHGEm83qsEmmGqp0P5S0sxW61xQVswBOKDD3ubKvitaiG5vFCy+I0RW1Z5
 OLTWlK00H3EA1kDSzWQA3xl2VExRPc4E2PgSrOiHmkCllHukLxRRq+fDCpA9cJVdDKQ5
 pOwCbykaRH7weF2MWTWztaohgGZW5fjh1FoDgq+ItAsNOP2GynaXJg7eY0wSysrkdlqe
 6WBp8n8HAtNdJmcOhdtYnS21LCf1HWaR3aRInooN3tZHkLnUl9UnACzUQYK57YKqgtZs
 KN9m4TAMx0+bCx3hV3TkHvi9jjuvWzYSzGx1Xo8oEV0WBcCNQDcKwTxUp5YSVgQlQTDx
 IaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558401; x=1720163201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESvyw3GYgt7hOD38NPh8gyks0iX0X2xZyRHCeLbcWRk=;
 b=n9rvFABEYK5U5ExNwkRE0FxqQio+ozwRq4euJiSzpX4KQIRIsNerg1cZ+QqK/prWs3
 wbUUB3jnlAMfxdjBiA4jB4v6j3pvrt2uv4WuxFMElbfHkSYMYYNoELmfageukZABiTIQ
 IDF6DZRLOHNDqttUzaFixpK5egjjZY/JFvNZQhf2madMoQOsaiPujVkZeyDvYFWWBjbu
 c3sjC6PUQSYd2pMhVDO6HoUCE13PsFSJnHeu1sC7MLueZdJ2gSvIH0JuUVfEk3ROQloG
 naPHo4bDEFVWXTSwtPhsISEXfgbx028j5aalbj3OQACBKIQn4fVtj3PDTKsBnk22REct
 jSTg==
X-Gm-Message-State: AOJu0Yz3gQeUycO/D+aXvY0GgChb2awHrEA1dCl0CBqVZiz5lCKUv43W
 FNWBhuHUj5hK6yHJKthgwN/xIZhcrNgFiJq/VLYammOjMSEpWZ24CYXZUm9yU0nbOwFMk/huwkw
 vfWo=
X-Google-Smtp-Source: AGHT+IFND/a8d4Yk4EFM3oqaOwJsxMq/hEmDRpArSNpZ2RAalooUhAIHuHtStcB0xseeHiFITflk0g==
X-Received: by 2002:a05:600c:4a05:b0:424:9f28:22ff with SMTP id
 5b1f17b1804b1-4249f28238emr68998575e9.5.1719558401129; 
 Fri, 28 Jun 2024 00:06:41 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3f14csm21672955e9.6.2024.06.28.00.06.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 45/98] hw/sd/sdcard: Register SDIO optional handlers
Date: Fri, 28 Jun 2024 09:01:21 +0200
Message-ID: <20240628070216.92609-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

See "SD Input/Output Card Specification" v1.00.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 406fadb3b4..87bfd0fd56 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                             [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
@@ -260,7 +259,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
         [50]    = "SW_FUNC_RSVD",
-        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
@@ -2270,6 +2268,9 @@ static const SDProto sd_proto_spi = {
     .cmd = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
+        [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
@@ -2283,6 +2284,7 @@ static const SDProto sd_proto_sd = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
@@ -2294,6 +2296,8 @@ static const SDProto sd_proto_sd = {
         [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
         [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
         [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
+        [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
-- 
2.41.0


