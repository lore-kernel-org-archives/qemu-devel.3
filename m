Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55068C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsA6-0001kV-5J; Thu, 27 Jun 2024 12:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9r-0001fV-Hx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9p-0006ug-Qc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424aa70fbc4so19168125e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506374; x=1720111174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXDu/2edCnmMgqMgCJOWOkUUywr5VZFDkGviAHlkFf4=;
 b=URXHyzaYJFwTWnRi5TxkntlLX27tOhs8s2iw6Brj7udNdOI6gT6lNjEWCIH/Z6M9Eu
 5P/wMsxHmshHy8gdpDxiEbMTT2zrrRtlbGiZMohcY4TqnmY55M3oh5CRLbPYID7mLbuu
 R0EHq4Ty1XmJpXh1CNkMMRIkJ1Egnem6HweSvUdn2znNmEatBmEuiNDHCSguD2l5VLn9
 JQ1DfQWq5cZBXNVj4r2W8riZ57PbBVcZDOLznEZaHHclTA2JomOdcnlEszCqR7lBQGij
 BG5X2RfZBg5nz3Trta3R3MuTJ+Hn/wwus1b0h69qlvM3YJOZa7XbzE39SylvTSlXADbp
 Sr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506374; x=1720111174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXDu/2edCnmMgqMgCJOWOkUUywr5VZFDkGviAHlkFf4=;
 b=vasUM70tlc/3zCJx+luDKOM08oZPx0ZGpQ0nAqdRLcYi0fZsP65m1OKWXD1aklZuP/
 mrSx1jyQPJWpFVykRgzXgkm0n1jO5TfdRHAl4EOIrzXgiBX9c8ToTHtNwdNGqmCxdpgl
 krftnnbesgE/Gi7Hd2Slm/CiH5P/WMZkBJOsGXnwi1CW4OmFfJIx8vGstFeWOoDKWAsr
 4QBQmXuKDPf1or6fAWBNKL5kB2h+LS/ymAHcOww/x909X+eKm4UCtqIPqDr2/bXFBxex
 Pf7KhEfN950yJOrlqUO2TxdlrWgKL8dywmr34tnDCcYxxWI7U4LUGNvTOl4p7kBypWNv
 dG4g==
X-Gm-Message-State: AOJu0YwybmFeDHt0l+BZV6mz2oS3pC/MXva/a2QXPTtuRHcd4qrreOfH
 7yrMOwUIhDh3Tjyk431zMpRzqo4qfJw1FS9jQW3crwvlI3M5IVGjKzPXhgxpLAgLBJh/86EZKP8
 enDk=
X-Google-Smtp-Source: AGHT+IHxwSzBQDPFgEAPDJXXSSUKuzF7EfYzW5dax+fd4Cz7Sy6IKe+iGAtFxAzIklELg+4EPDdRvw==
X-Received: by 2002:a05:600c:4994:b0:425:5f6d:2f3c with SMTP id
 5b1f17b1804b1-4255f6d32cfmr34598845e9.39.1719506374004; 
 Thu, 27 Jun 2024 09:39:34 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564a4f024sm35025525e9.1.2024.06.27.09.39.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:39:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 04/11] hw/sd/sdcard: Store command name in SDProto
Date: Thu, 27 Jun 2024 18:38:36 +0200
Message-ID: <20240627163843.81592-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
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


