Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86084C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsFL-0003SN-NR; Thu, 27 Jun 2024 12:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFF-0003CW-Ks
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFC-0008SQ-RW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso11015e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506707; x=1720111507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wED9lVuSIJVna4+aCIAwx+9S/4ApkNiJ+n4u5rDB9Rw=;
 b=wmXIVJpN7btns5qwTxXrM3N5lSqD+MziS9Evc8M2zMcHOJ1jFmMoBjXSBbG9K5WUL3
 yZxZ6KTg4VnbaZnHNeCcpPZPly0cvWaJhjYgk52uMUxwFnhuumsCKVE0SMKRnbCUIxVf
 NgWe/FCv7bGnlo6ddKcrTvWsAp1k6r8bSa+tJ1FX3n0J9QaF1/IVgQzb4ak8tWmr1bW4
 fpcLnbxN9RZBPt153WoynzXOk2GJjXgNs72SdHTL6GdCT2kFi0/debzRmJHfiE3/qOLh
 ZgS/BWWKIbrYr+PDBjnhfoRTmT4R5PNRNH0lQaUBobU58lnzerLKb1F+rndd4bLQ5qLB
 gXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506707; x=1720111507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wED9lVuSIJVna4+aCIAwx+9S/4ApkNiJ+n4u5rDB9Rw=;
 b=oWBERopdtb/S2S3K7Rf6ddrtfWxkWwMXj1riWhCJk05k/nQ+ZnnvsyXMjFPTUHT9tj
 YOE5XJ6KUB11IW2bBaktGjV3k3kSTE5AzJ4Z1LVQTYZfgP5waoxBNSlMUEVh+GwyxIpc
 dCMgfJh3F7n5qXMyxLUbm+G9zlBHIXwAhHr3siW0D2c7+awmZHi4qgRGt8dX2jEF5wUW
 PnZMMk744bUkb3kfKo1ub+SmkigAI6S28YS+Nl+sAMcy70q35FWUIFvsUhG6u2rW9Glc
 IPpNhqzJJCPTuM3+HHWezCfqd3HJ10Uzvcwz1cR15Bqo6JY5CHKorw2VDRoa6Pft00s7
 MiTw==
X-Gm-Message-State: AOJu0Yy9nGIjoiZ8Xf0MxsnjAbcAsJhLrqjM+KtTbELvwHpCUBf4JBKn
 VtclHp4FP5uTL54nKQhXBzvJfGxrrzBKAr++6bBaMAiqwmSf9lfvdgbdcWqzuja2g4LTK49UFs0
 NxGo=
X-Google-Smtp-Source: AGHT+IHzmc8y2pQilKecexD3dNw+fvmZuQWI1UZ05Q6Cr0V2Zt8AmjzpDRWtPJCBkeIpMDfuVmDl+Q==
X-Received: by 2002:a05:600c:6b0b:b0:424:ac32:afa9 with SMTP id
 5b1f17b1804b1-424ac32b059mr45878805e9.22.1719506707516; 
 Thu, 27 Jun 2024 09:45:07 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8251149sm72983295e9.11.2024.06.27.09.45.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 08/21] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler
 (CMD15)
Date: Thu, 27 Jun 2024 18:43:31 +0200
Message-ID: <20240627164345.82192-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 hw/sd/sd.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bb80d11f87..d7ed8aee73 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
@@ -1402,6 +1401,30 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
 }
 
+/* CMD15 */
+static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
+{
+    if (sd->mode != sd_data_transfer_mode) {
+        return sd_invalid_mode_for_cmd(sd, req);
+    }
+    switch (sd->state) {
+    case sd_standby_state:
+    case sd_transfer_state:
+    case sd_sendingdata_state:
+    case sd_receivingdata_state:
+    case sd_programming_state:
+    case sd_disconnect_state:
+        break;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (sd_req_rca_same(sd, req)) {
+        sd->state = sd_inactive_state;
+    }
+
+    return sd_r0;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1467,17 +1490,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     }
 
     switch (req.cmd) {
-    /* Basic commands (Class 0 and Class 1) */
-    case 15:  /* CMD15:  GO_INACTIVE_STATE */
-        if (sd->mode != sd_data_transfer_mode) {
-            return sd_invalid_mode_for_cmd(sd, req);
-        }
-        rca = sd_req_get_rca(sd, req);
-        if (sd->rca == rca) {
-            sd->state = sd_inactive_state;
-        }
-        return sd_r0;
-
     /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
@@ -2324,6 +2336,7 @@ static const SDProto sd_proto_sd = {
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


