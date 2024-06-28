Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D3C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5hy-0002dx-Tk; Fri, 28 Jun 2024 03:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hx-0002YB-JD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5hv-0003P9-EP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:07:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso3122075e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558461; x=1720163261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H/Bi9vrwnFZ+zmmMgAN2Gfm5YG78pw+o1VPUAn34pig=;
 b=OumoNjBuTL0ciK60xAaLS72RoPpaf/cShmQhC1RCobdbouKlywMVpyyj8PvAwUAMBG
 +1QCtatHKjQ31v/JIRFFXr4q1bW+Z8+Si8HWIATnNXpxT2uBudmMCtKhsbqlRAn/AbO1
 D5n/hMmo3TBUa/5G1kSo7mwU+8y6O7KS1hXsEiI2NUgmfMu6u6pM32EZZGg1bmxVRkXf
 HrrVxcVdIANTVfRwItziwl6JbBVEfgD2r2/JT+wo3fvhHvy66wNcrUsZpVweL5N8V5iq
 VGaPMiMKsAgRoKbmYi15jAGzrEQcHX5M9aFWOBgyrCIGhFMqKlNVc/NtVDEJXF1EsQos
 ATVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558461; x=1720163261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/Bi9vrwnFZ+zmmMgAN2Gfm5YG78pw+o1VPUAn34pig=;
 b=snf8zKCEI4eMDn7ctJ2gnA88AzqrFXa1NUzokcNMWivXNfngjol7msJEqHWqlA8oTE
 8N9WE8ARkp5n/OHwCdk16fbF8Mh4+yiszS3nTdO59ZnUTFW9E4HE7ozvqQ3erA9jwv8w
 gryxt7giSD0n8nC4fADY+vrViygW5iCTwmGMc1b7tA2WRjjaXlxtZd7fSIyqM6D3Tnuh
 TS9To/Mv6rI/bwGdkhKClnPIcywvSEMzXWYVj/3KETz+IOPPSq3pMRqpSZdT77sd7UDL
 IfZjjk03E3n+cc1UGNt1qE8iaBazBonkAzTwENZz+UKWOkihw2/BP2dlIfNESZkd6ARK
 6W7Q==
X-Gm-Message-State: AOJu0YwpYvSjHTYNPGGz6eocQDniw09Zsj1YLNWEHmlV65tA2Z2K9CLR
 KioxLpPalSR0nlw2Zxb/zKxiwmKOPkz8kjO+Y9asTDJOnCoTyaOEjvBSyU16aICiV7es0EgYLAZ
 qDPM=
X-Google-Smtp-Source: AGHT+IGAELhQoLuAd+UVNQTjHOnMNiCiKUcGkMiC+VWetVzPY+34VDMD2w1jB998nHVvekm7zJJh6w==
X-Received: by 2002:a05:600c:681:b0:424:a578:fcc with SMTP id
 5b1f17b1804b1-424a5781102mr73259085e9.7.1719558461500; 
 Fri, 28 Jun 2024 00:07:41 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1688sm1332840f8f.60.2024.06.28.00.07.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:07:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
Date: Fri, 28 Jun 2024 09:01:27 +0200
Message-ID: <20240628070216.92609-52-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
 hw/sd/sd.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd7c7cf518..564e08709b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1323,6 +1323,15 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
 }
 
 /* CMD9 */
+static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->csd, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1333,6 +1342,15 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 }
 
 /* CMD10 */
+static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->cid, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1408,36 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 9:  /* CMD9:   SEND_CSD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->csd, 16);
-
-        default:
-            break;
-        }
-        break;
-
-    case 10:  /* CMD10:  SEND_CID */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->cid, 16);
-
-        default:
-            break;
-        }
-        break;
-
     case 12:  /* CMD12:  STOP_TRANSMISSION */
         switch (sd->state) {
         case sd_sendingdata_state:
@@ -2288,6 +2276,8 @@ static const SDProto sd_proto_spi = {
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
+        [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
+        [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


