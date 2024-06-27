Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F650C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsHw-0007Sw-TH; Thu, 27 Jun 2024 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGp-0006V5-Kc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGn-0000UV-Vz
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so69478395e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506807; x=1720111607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmktXx8YFnfnnA13QTx+BBHRiUUuhl67+QJQQVhLdE0=;
 b=F7BB2z5YkaS/+odxUjra9tzOgYOrIV6Ou/kh2OnWNPnCRywOK/hTF6KX+ox+IJcswQ
 fyCmtR1snKfwf15BkVy7CaRjmKj/rjLR5ldNKTzYz0TLsy/6nzkQrveXH/L7011r5Xzj
 fYOah0IU1Ybem8DymsWLihsgD6dVfEuB55oyYdhbVWOHyH8461wp5VJWHcdr4WXfpj1J
 hPMNiRiHvEmsYlB8OtsTS+PtIUhuOv2e+jLR3DRkwO6xfhyJFYFg72j5DUsu8slYtHMD
 hXUY8v0z2+6VLwpRjF32Dx0BSCLjqfK9lbOCZMB8/mot/ImEwvz/CuusfPws5OFhwC2u
 ZefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506807; x=1720111607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmktXx8YFnfnnA13QTx+BBHRiUUuhl67+QJQQVhLdE0=;
 b=Xh+RBfEMjjXzFQnlDKQVMcy2HcgROkqCay7IfeZ7j15So1H5e3fUuStwUIOGKXKTlW
 XFYVc8phgFT+tu65/D4oJ2P3pW2FFsX1hiwgBHq9rdhvVnJ8wdJWteBKhmFbNV9Vam1g
 NXwmjvxV2PVi502kXiFkZiL8sCFSkZWURyHpoM+edDywE3yvuv5mQsy1DEDh24wdoTHR
 VO1QQbk/zXWnITmFr65MQG66ElU9lQwDRzKIIcpLCApmYJzIV5fQTjJ8CNxCJo3Vl1FG
 795FST/u2O/l6l2LpXYnX6rFwjG3/bkalLuWuPAASHh0ljmfUexRYB7FJS2Yg26fEPd2
 2bcg==
X-Gm-Message-State: AOJu0YxpYUZ/YHFD1NJJP9q0l3xHD2ScTZpDVZObXrCBNuNqGeyv0oth
 fgx8u1wH7pQZS9fGlAMOI1I0OVewByPOT4XLB7P1s5rRVaJeEng/ohKFqtzUwSrQpygZ4lkQpsV
 fan8=
X-Google-Smtp-Source: AGHT+IHcgQzjgnOMQfbRnlxVQv5zw6hkqX/mYMRFo74YdXbpGq6lkt3mWsXR8BdpkYnaF04lk91Hgg==
X-Received: by 2002:a05:600c:458d:b0:424:781a:188b with SMTP id
 5b1f17b1804b1-4248cc58a63mr105770785e9.31.1719506807564; 
 Thu, 27 Jun 2024 09:46:47 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256798ce18sm22530645e9.23.2024.06.27.09.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 18/21] hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
Date: Thu, 27 Jun 2024 18:43:41 +0200
Message-ID: <20240627164345.82192-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 hw/sd/sd.c | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4d78ac5b59..5461e56e17 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
@@ -1624,9 +1623,34 @@ static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, 0, 0);
 }
 
+/* CMD55 */
+static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_ready_state:
+    case sd_identification_state:
+    case sd_inactive_state:
+        return sd_invalid_state_for_cmd(sd, req);
+    case sd_idle_state:
+        if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
+        }
+        /* fall-through */
+    default:
+        break;
+    }
+    if (!sd_is_spi(sd) && !sd_req_rca_same(sd, req)) {
+        return sd_r0;
+    }
+    sd->expecting_acmd = true;
+    sd->card_status |= APP_CMD;
+
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint16_t rca;
     uint64_t addr;
 
     sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
@@ -1713,29 +1737,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Application specific commands (Class 8) */
-    case 55:  /* CMD55:  APP_CMD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_ready_state:
-        case sd_identification_state:
-            return sd_illegal;
-        case sd_idle_state:
-            if (rca) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
-            }
-        default:
-            break;
-        }
-        if (!sd_is_spi(sd)) {
-            if (sd->rca != rca) {
-                return sd_r0;
-            }
-        }
-        sd->expecting_acmd = true;
-        sd->card_status |= APP_CMD;
-        return sd_r1;
-
     case 56:  /* CMD56:  GEN_CMD */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2321,6 +2322,7 @@ static const SDProto sd_proto_spi = {
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
@@ -2373,6 +2375,7 @@ static const SDProto sd_proto_sd = {
         [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
-- 
2.41.0


