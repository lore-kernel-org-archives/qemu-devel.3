Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CEBC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkB-00060E-Mi; Tue, 09 Jul 2024 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkA-0005tX-5T
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCk7-0006JZ-4U
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso12608765e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538816; x=1721143616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwlDS3Fem601L5/uj6bQqEPalzfsgOLIBKrXuQLdMJU=;
 b=FjYgybO3Sjth2k4OcmUcrv8Qh0KXzPAJniD0aHyIIrE/b9vUfPpka3LgAEyR8KxPGD
 +UVBbtt246ubUA5crTU4BhgOKDABGM4RX5LdVBnCPYafeWYjQPK2Vs2C6jq8atBiMlM8
 d96NGOFiu3doqTpdrZXiJ5ui5ODs4kfvDx4hGfU8RF9nCI4a7/hq/5Gf0i4Y5McoLL+p
 ZfiU2WvW1gzCMd88NcrZbcsw5gN8pPg9Ey9u5nvnlC/P74rr7M6XLGMovoV64sj8hPAF
 TnfV/tuoKfh1AsCaa96Ve3lx9Hui9zHAv8UaBvAcRdkdJkm66G+Qb7htKvl3V11PSFav
 gyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538816; x=1721143616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwlDS3Fem601L5/uj6bQqEPalzfsgOLIBKrXuQLdMJU=;
 b=tRidMk2rLuXNTwJU7a5qp6ffkj8325rCxaz4yJGeVz/Ml5muPCmjeBf65PdSOny0Y5
 cL/G5lW0cvpg62pbgqqbA8iollbZUR6OinXmkvvaqx39/J68UnKtORvILDLE+8OL+OmH
 P3n1crUQaEEc5DSGJOt9h31VrZ0JhWcHkzQPHlOGjkiKM4N3EPx0PCHvIRgjyzHugoig
 nmv9B+TsMu/Y5BEM0ABUP/WrlXCsFW2bNycRO2YdUrGaK97nc7T3TdAAW1ViMp9gB2if
 BDPeSArUXnbzNqZxwgnhpq4Xu7AnrYjWGN7MuKiStUFiV/WQnJKIhErbOhr//TzuEEk0
 reZg==
X-Gm-Message-State: AOJu0Yz78bGKJE7xpfsff6qpqZ+eKxCGkh8tqzUqWciFaWXoKpIRsmTM
 sbiAus/xQG6/iRqi/bLfgQtxwxfBBRUiwmbIYzx0WOZTv0wEglQjmbG5VQWNXZkxX2vNmV4CYNS
 +
X-Google-Smtp-Source: AGHT+IFt1ohULQ5udOQp6NEinCFL2Fr8z8CNRk1O1D/qQWMs0ElRFxrF7nAS6tF3zbBQBIpDpuuq9w==
X-Received: by 2002:a05:600c:2112:b0:426:6416:aa7a with SMTP id
 5b1f17b1804b1-426708f06damr23851025e9.34.1720538816441; 
 Tue, 09 Jul 2024 08:26:56 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266857c28esm98167515e9.2.2024.07.09.08.26.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v47 09/19] hw/sd/sdcard: Implement eMMC sleep state (CMD5)
Date: Tue,  9 Jul 2024 17:25:46 +0200
Message-ID: <20240709152556.52896-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Luc Michel <luc.michel@amd.com>

The JEDEC standards specifies a sleep state where the eMMC won't answer
any command appart from RESET and WAKEUP and go to low power state.
Implement this state and the corresponding command number 5.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-90-philmd@linaro.org>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 05c1b85476..adba53e822 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1236,8 +1236,19 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
-    sd->state = sd_idle_state;
-    sd_reset(DEVICE(sd));
+    if (sd->state == sd_sleep_state) {
+        switch (req.arg) {
+        case 0x00000000:
+        case 0xf0f0f0f0:
+            break;
+        default:
+            return sd_r0;
+        }
+    }
+    if (sd->state != sd_inactive_state) {
+        sd->state = sd_idle_state;
+        sd_reset(DEVICE(sd));
+    }
 
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
@@ -1294,6 +1305,30 @@ static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD5 */
+static sd_rsp_type_t emmc_cmd_sleep_awake(SDState *sd, SDRequest req)
+{
+    bool do_sleep = extract32(req.arg, 15, 1);
+
+    switch (sd->state) {
+    case sd_sleep_state:
+        if (!do_sleep) {
+            /* Awake */
+            sd->state = sd_standby_state;
+        }
+        return sd_r1b;
+
+    case sd_standby_state:
+        if (do_sleep) {
+            sd->state = sd_sleep_state;
+        }
+        return sd_r1b;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -1696,6 +1731,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     case sd_ready_state:
     case sd_identification_state:
     case sd_inactive_state:
+    case sd_sleep_state:
         return sd_invalid_state_for_cmd(sd, req);
     case sd_idle_state:
         if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
@@ -2018,6 +2054,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         req->cmd &= 0x3f;
     }
 
+    if (sd->state == sd_sleep_state && req->cmd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is sleeping\n");
+        rtype = sd_r0;
+        goto send_response;
+    }
+
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
@@ -2467,6 +2509,7 @@ static const SDProto sd_proto_emmc = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
-- 
2.41.0


