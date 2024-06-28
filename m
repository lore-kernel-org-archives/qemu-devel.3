Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747DFC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5ge-0002IW-9E; Fri, 28 Jun 2024 03:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gU-0002DG-Di
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gS-0003FA-HX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso3220925e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558371; x=1720163171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YXDu/2edCnmMgqMgCJOWOkUUywr5VZFDkGviAHlkFf4=;
 b=t7i690C67proAEGDgD8xqjwOXctJ/El611+/kU+nH5vEMfn1HBs0ix4Nsyaky3Qs9H
 1MHEk/x6/5/6A5csVd0TRpxGLnollQyzo1L+o09+Y/thI+4Ce0DJzw5iFZ/w7evZxphu
 l+HwA1utOwcShPDg6AzcAsuZ6uipGVCPt6rh9JIEC1WguwoQ6YIdNFXEKmeccrxrCHWG
 3CuWCTdVEhfX4exob8aWhHMaiu18F0YCdd6aOFva8pctss5plOcAqm8MVfRRsU28kEfN
 jrsDyzuNExjzyXMoE+P8iBLBE6lTyhHMj4TZ5+N9EGe+jahsCtVjUfBapp5zSxcHKYHa
 NL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558371; x=1720163171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXDu/2edCnmMgqMgCJOWOkUUywr5VZFDkGviAHlkFf4=;
 b=T2UCOwrSOnsSWZjztGGBAK7lSLzHqqzGBHQ8QDhLlekoSR7HqgoqMDhXhT3TzYBRov
 +1gvh3x8Xs6ITVO1uZ6+3CuJj2u+7HaJf/HBPkxNnUAkoOxqYBYXwLgvSzygQWW0lctD
 DUXhZYb3TAfwmLMbDpops+mYTwOsIPfMk4FxPr1u8xur51j2M2R9uXKz9tmNHUr3ni9d
 uzKEoNXHu6QE/7qoQikNcDR935YMx0vNVUCSMlxdFh4OuqvhixZzbSBHgKXEM8Qg2GC8
 iW/J0mGhclVbFVEtCCJ5aGBnBbPhScT2TNrv5plHU07V1hTLayMYgXB4iY2BHzSkVu7c
 pokg==
X-Gm-Message-State: AOJu0YxSQ2KYuuueWVr2/G60pUUtVVtO6fmwG6aTP8woiIEsXcNso5ct
 +QsyZRJE1OXK8Tgdv8d5krlFcIk/4kKb/vZrRbu0TOwtjmF59w4gPrBCguEpZ+wWYcR3EZoyOcx
 en0k=
X-Google-Smtp-Source: AGHT+IFxcrVEf3kS/Mf3HPWe1xNp+2un7d9Stw5hZIHR/q/TFUqN1bFb6Gb0uw795sTH3g3JhIjDZA==
X-Received: by 2002:a05:600c:3386:b0:424:aa35:9fb9 with SMTP id
 5b1f17b1804b1-424aa35a106mr70402335e9.2.1719558370775; 
 Fri, 28 Jun 2024 00:06:10 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf90sm21615535e9.5.2024.06.28.00.06.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 39/98] hw/sd/sdcard: Store command name in SDProto
Date: Fri, 28 Jun 2024 09:01:15 +0200
Message-ID: <20240628070216.92609-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We already have a const array where command handlers
are listed. Store the command name there too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 558c39419d..97fb3785ee 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 typedef struct SDProto {
     const char *name;
     struct {
+        const char *name;
         sd_cmd_handler handler;
     } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
@@ -237,8 +238,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
-         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
          [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
@@ -246,9 +245,8 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
-        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
+        [18]    = "READ_MULTIPLE_BLOCK",
         [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
-                                            [23]    = "SET_BLOCK_COUNT",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
@@ -270,6 +268,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
+    const SDProto *sdp = sd->proto;
+
+    if (sdp->cmd[cmd].handler) {
+        assert(!cmd_abbrev[cmd]);
+        return sdp->cmd[cmd].name;
+    }
     return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
 }
 
@@ -282,7 +286,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [16] = "DPS_spec",
         [18] = "SECU_spec",
         [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
-        [41] = "SD_SEND_OP_COND",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -290,6 +293,12 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [56] = "SECU_spec",                 [57] = "SECU_spec",
         [58] = "SECU_spec",                 [59] = "SECU_spec",
     };
+    const SDProto *sdp = sd->proto;
+
+    if (sdp->acmd[cmd].handler) {
+        assert(!acmd_abbrev[cmd]);
+        return sdp->acmd[cmd].name;
+    }
 
     return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
 }
@@ -2268,22 +2277,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]  = {sd_cmd_GO_IDLE_STATE},
-        [1]  = {spi_cmd_SEND_OP_COND},
+        [0]  = {            "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41] = {spi_cmd_SEND_OP_COND},
+        [41] = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]  = {sd_cmd_GO_IDLE_STATE},
-        [2]  = {sd_cmd_ALL_SEND_CID},
-        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
-        [19] = {sd_cmd_SEND_TUNING_BLOCK},
-        [23] = {sd_cmd_SET_BLOCK_COUNT},
+        [0]  = {             "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {             "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {             "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {             "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {             "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


