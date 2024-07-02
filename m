Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59512C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZkW-0003O9-Dp; Tue, 02 Jul 2024 05:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkE-00035Y-GU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:16 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkC-00081b-Lw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:14 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52e8b27f493so2170326e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912249; x=1720517049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPLvB2ZG14xjBMcX/e0G2maNGEfR8AYKqnkrhl4dPtE=;
 b=I7BxzGd9Bw/NJrLPONdqiiwZqZ/+nvJC/kDy9CrZoYpz1FHuCKMHOrOM1FCSlLJDnq
 600Da2gxEDKfxj0NPNvY3rjJMQZDKWtTjf8Jqrfc7mNf7eycgViYxPnJU00IqUwvlS05
 Ouol7IDjdBFcMoIgPORRZ3lbEd6SDNv1ExRPLNde7fP1luM+dzv53spfkYBz2K8i2RKl
 c8Wjwr7vd9GJNwnT6LeTyp4w6xozozlKnABlDOCvlrGoLDaCxdnxpk04u8jIeD5yVAoX
 rFgdFlZ98A6SdDwJkmTnu8qWkzVirUJiLb3cxAmxv3df2YMWyQX07/I97H8dMYFsQd6J
 yBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912249; x=1720517049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPLvB2ZG14xjBMcX/e0G2maNGEfR8AYKqnkrhl4dPtE=;
 b=hrXieF71blzLyj14JUURrlOlUFSURO9Ic1qgJTU4dHMH+jTfwYmC7k5bBvWEBpxjC7
 TqoGLqDXZhx7jyjwhJd/85BQBsFDSuj7ABSxqD+lb6fn/i9WZhUve1kimcz4IwJZ0QZD
 Bg60hT0duZ+rIEyRkqn6FV/++PAV6Vmf//A1UpRRUJFDC6AedQmYKB8dU/SVMylDVHEf
 B4wmR8t5ZBxsO5+jN75NaxKp6+sBhtKG+ms6ezFmSVU8ecDQswnjHwK9HzdDEb0sCKWf
 i/cbp3QVSoQTN1vqn26weoUfspDH6vi9dbAzYrk9va0PZcOwHXgPW0F1ON+b+V/HKVVv
 hdcA==
X-Gm-Message-State: AOJu0YxIMcRD4Z9LSCl/i1uWjqMaGNdkF9N162SqJnaqHR143ZUVL3t5
 v9UQtvf5sL9g1EOv9ebV/QNxynySTrAXGNyVWl8aJ6IWDPfnh17yW4HngqBqD34WIozZ0+rriMo
 F
X-Google-Smtp-Source: AGHT+IEFf0KAHsrl2tz/Wxr6UNS7B3N57HJdnRmOoujSNtNZZl2R4KjnJc9j/eq7z79PdBMkPRjgXw==
X-Received: by 2002:a05:6512:3ca9:b0:52e:765b:c00e with SMTP id
 2adb3069b0e04-52e8264c2femr5297206e87.7.1719912249669; 
 Tue, 02 Jul 2024 02:24:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b064f16sm190197265e9.27.2024.07.02.02.24.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/67] hw/sd/sdcard: Store command name in SDProto
Date: Tue,  2 Jul 2024 11:20:16 +0200
Message-ID: <20240702092051.45754-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-40-philmd@linaro.org>
---
 hw/sd/sd.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fb82bc9aa3..2cfba6ff60 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -94,6 +94,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 typedef struct SDProto {
     const char *name;
     struct {
+        const char *name;
         sd_cmd_handler handler;
     } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
@@ -234,8 +235,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
-         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
          [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
@@ -243,9 +242,8 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
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
@@ -267,6 +265,12 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
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
 
@@ -279,7 +283,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [16] = "DPS_spec",
         [18] = "SECU_spec",
         [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
-        [41] = "SD_SEND_OP_COND",
         [42] = "SET_CLR_CARD_DETECT",
         [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
@@ -287,6 +290,12 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
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
@@ -2270,22 +2279,22 @@ void sd_enable(SDState *sd, bool enable)
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


