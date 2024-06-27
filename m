Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51745C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsg7-0002Pe-Kp; Thu, 27 Jun 2024 13:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsg6-0002GE-3I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:58 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsg3-0002LF-PS
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:57 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cdb0d8107so8315382e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508373; x=1720113173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa9xIcQNODSrwCgxGYM1DSrbhUURwxNAmEEY/4Qlivk=;
 b=VoFIIkGqb09cePHXVDdEjQEUN5m1JXroqmEzO1wUtuffieoMVDejUAqAe4hoNTiBH4
 /4OREfsY2qNSLUtwTA9U3Eghxzd51THIgKGeyR9XWE4H6a4C2Lg/p7VlfKtuQ6G3wuvw
 XsrTfxaHdZajucqpUv8j6FRfln+fA28guT4rVhyUhgEDN84dQlg6f+juCP+UIUrzl+QF
 VEO5DY19T0pfQ07g+Sfygclz058oAjpQJvoSC7NnHvN05hGC2aTF8v6O5XCpyFiqXPVv
 HvZYTJQhVI2O5ctYDKu2JXRTXJ7irmRVmm46ejN39gjSijdmTaTJ4dxtc1h7OcFFH9uo
 SpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508373; x=1720113173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wa9xIcQNODSrwCgxGYM1DSrbhUURwxNAmEEY/4Qlivk=;
 b=GWbvi49u+LEnDlxoDoZxLBMQJQBIb+2J60ZsKFjoSxmiLCTIcMmMRh8/mKAOZkRdat
 LLZux+Pxea8Xp6wG4ZRwFwnsK9yI+YsGo3Afba2QiyG+3cyxh6l2Qz8mKUQTThVYDuSE
 HqdzKg3t5mLItwq+LrnAQyQivHZO2VykbsmIXgAhhU22G6UWHtK3XmcOh9QXQidzlgRm
 Rg7i0/SbnZK1mvh4OteqItHJjh76c0zV1egFBuNrdERD5e6CDWKqMVoPt3GyEhj5xovI
 qIVxCh8Lc0JUMqtPN3zMjYQYOjeyBDPhnsH+DGolF4QVIS9Fr3ud0z/y76Q2tMHBqtHn
 ybBg==
X-Gm-Message-State: AOJu0YzdU63q8weU4FuPmwyCYm7cHOsJrRGvWgJU5MMuVC6sR8+ATK2P
 V6DFFwa5Aw3qRZtqenVMfPZuO7jyo+FNuatshKSUAPt/2WOvlg7f1+G6r7pNa+ASATQlE9vOCnE
 Coo0=
X-Google-Smtp-Source: AGHT+IGjWfPv5AB6+8vSNJMxy6EaN9nk0J8H2qEgDHr0Qw0CAWDy2PFLDhvrOnE4TCyG/o5jOpM4gw==
X-Received: by 2002:ac2:5618:0:b0:52c:dea0:dd55 with SMTP id
 2adb3069b0e04-52cdf7f10d2mr9085492e87.24.1719508372617; 
 Thu, 27 Jun 2024 10:12:52 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c14fsm2511586f8f.16.2024.06.27.10.12.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 10/19] hw/sd/sdcard: Implement eMMC sleep state (CMD5)
Date: Thu, 27 Jun 2024 19:10:50 +0200
Message-ID: <20240627171059.84349-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

From: Luc Michel <luc.michel@amd.com>

The JEDEC standards specifies a sleep state where the eMMC won't answer
any command appart from RESET and WAKEUP and go to low power state.
Implement this state and the corresponding command number 5.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0f9bab105e..bd77853419 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1182,8 +1182,19 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
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
@@ -1246,6 +1257,30 @@ static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
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
@@ -1648,6 +1683,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     case sd_ready_state:
     case sd_identification_state:
     case sd_inactive_state:
+    case sd_sleep_state:
         return sd_invalid_state_for_cmd(sd, req);
     case sd_idle_state:
         if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
@@ -1969,6 +2005,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
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
@@ -2420,6 +2462,7 @@ static const SDProto sd_proto_emmc = {
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
+        [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
-- 
2.41.0


