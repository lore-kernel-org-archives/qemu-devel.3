Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F04C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iJ-0003V9-Fc; Fri, 28 Jun 2024 03:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iG-0003O5-Rc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iA-0003QM-N2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso2618265e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558476; x=1720163276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wED9lVuSIJVna4+aCIAwx+9S/4ApkNiJ+n4u5rDB9Rw=;
 b=BXFniOJtGwTowF1Wb42HmNOEjT011/k4PffiB29z91IzNdzH3FAHm6VCDBy364oym3
 LTY7v+W+OQkvl5+YISHAslr8VJ/i/vGHzJt5UqHZzThpgniad2sFrC+Dq4lKzcLmJWdJ
 9mK1/iP0p6aP/cLTaZxeR+jjhSSDEm+JtVLN87PdTQ6FEDkYfCmQluHaBaHVfFG6KWuX
 sli4eq3+vn5htW92VNgpIg24gsABKYpK0svkj5awXrPx6yTKA19DbbdAsVbYsjSh12nd
 KiAmFKtnSep7KqHlwXrIG1brPUm9fad4lQVhxU8kbl/1XdNVAso1OEL4BcsNCd7k/cG3
 FvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558476; x=1720163276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wED9lVuSIJVna4+aCIAwx+9S/4ApkNiJ+n4u5rDB9Rw=;
 b=PCLCDlgFBQap6cAT9v/JC8RpMoxuqiFwudGGVwEfY03Jvn83TZO7s7Gw1KNsbElBo0
 el5B/mDM8A/t0DZd0HnP1M4ajTuRIJ99A8WVk+Pxs1inn0Z7oTh3KkAi6d9zyAJ6B4VM
 TGagtFlZWSn2G6oAlizIqkiOVTkJZePJnah2G5+Q9P3jw9SN4Fv2lS7uyIMdcJ5QKNZQ
 COWhWBLc1tTRA58ZZRXDTStt57qA05Qh+sppqhL6WfeuRe8qwEg+j4eqZTXVTxPDoJpA
 JkXbtuRwSqgv7yVoIym+YQ/8dJ/DRzGrjP/Q2O5Q440xbOuuxLKB0TH6XhAHcYY2VMqW
 hiQg==
X-Gm-Message-State: AOJu0YzrjPWt4ZO0tN7CKnQn+jspaMEGhBd20m4JBAVi9RdhxjhiHstN
 jYM0rD1YNDmjA7STOnPuIr4v6wTLmoAi5T0zD846JM5hf7di1DlC8Ya8tljypJWbKifC9OX3F+R
 dBVk=
X-Google-Smtp-Source: AGHT+IGRz9yqr2mZoOGEIQcHLr8gOYiyGF0rwkiCDU+892Ekvm1FzgzAN1lg6+wsid4cj6TLJ8OnLg==
X-Received: by 2002:a05:600c:4fcd:b0:425:672a:768e with SMTP id
 5b1f17b1804b1-425672a7849mr22553215e9.4.1719558476632; 
 Fri, 28 Jun 2024 00:07:56 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc623sm1328893f8f.87.2024.06.28.00.07.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 54/98] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler
 (CMD15)
Date: Fri, 28 Jun 2024 09:01:30 +0200
Message-ID: <20240628070216.92609-55-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


