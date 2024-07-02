Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7C2C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmg-0002uj-5k; Tue, 02 Jul 2024 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmc-0002r6-Tl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmX-0001Z9-Dz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso28561295e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912395; x=1720517195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odaH6p2tA7JjyfEGnhEe1HDwlvnEgHVlkHIdzE6llls=;
 b=u3DUJtfFGVQVD1Pv3nm4O7lTx0oRlHmi1RLbxxOhObn3P50wGWrNVtDy5kXc9DOiJa
 DqiKkHV1WLLdQgiwqn7o0ihFogaKMJlP/WvqCgjM/ZFf9jKKs9NHdBMrkRqI5BS6ZuiS
 HJOesRDgyQCbZV1ttg7EXTBAnulU5ur5dR6ZPCZiIrVsaJKyBZF80+7sc4frBplHRhbw
 ZbnMxg73Lfxa/JCotKiPtC6Sym7t5hfzcpApY1Ryu23QMacj0CECSMG1esbbyvaitvqZ
 GkVp3f6fvcUrdLrosH5HDQvcfWIvciE9Y2UpC2Jyk3KtTsXRM2iEw3Yqj38dZYtSnl1H
 xkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912395; x=1720517195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odaH6p2tA7JjyfEGnhEe1HDwlvnEgHVlkHIdzE6llls=;
 b=rDPB1UMaPYSlW4Gr4jpE9H00HVbutNfSoMVCoRisRw+6G6BTJJ07bwPKKeMB3fe21z
 RApJDpWagfsyejIrkxBXmIJUZ63gzCvtw72ltXd75N3LuZDgdVLplEMNJhMKHnxleTTb
 Ugl3azpX7LIBwyPH9bZ2IbV2ExBF/ReEovu8ezgF6gxxDDcFzLKUdBkk8mz1LTVJU0iG
 KY/nqkd6IVHjNvdLmvUv9LYTgqrrAU63mVU0cclsuy3NoPvbD1/CYUYF90tyJdkEMqUx
 cxfHIt7535R+KcR6WSMCDiTo8Rdh3H3R7FDCi4LdVgS1u2mfAYpntzAxSCLvKKbQp1Rq
 XRcg==
X-Gm-Message-State: AOJu0YyBhDA4NdaFXY+tfnjY19XTPQ4/eC3IfwQhOxf5/g+MFn5okws1
 eP2J7zac3XUzSzfQ88WLasOesQRYp7vJjLj/XRaas+bQQhKA3hy2a1l75DIxBhwE5TGhyXUh8vF
 L
X-Google-Smtp-Source: AGHT+IG45CpxWxU8/B7qH0tDNKU6nnr9s3Ed7Vm4fYU9VtM0cwaXh+0hSqoqvHbnHqjkW1dhwSKgPA==
X-Received: by 2002:a05:600c:c88:b0:425:6498:3b6c with SMTP id
 5b1f17b1804b1-4257a06427bmr63720605e9.26.1719912395693; 
 Tue, 02 Jul 2024 02:26:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb950sm12559263f8f.83.2024.07.02.02.26.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 58/67] hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
Date: Tue,  2 Jul 2024 11:20:41 +0200
Message-ID: <20240702092051.45754-59-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-65-philmd@linaro.org>
---
 hw/sd/sd.c | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index da344589f2..f5548d5667 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,7 +242,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
@@ -1616,9 +1615,34 @@ static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
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
@@ -1705,29 +1729,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2323,6 +2324,7 @@ static const SDProto sd_proto_spi = {
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
@@ -2375,6 +2377,7 @@ static const SDProto sd_proto_sd = {
         [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
-- 
2.41.0


