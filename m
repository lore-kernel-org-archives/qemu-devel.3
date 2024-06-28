Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596C0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jt-00077u-T5; Fri, 28 Jun 2024 03:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jq-0006xt-R3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jo-0004XF-Oc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-424acfff613so3353735e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558579; x=1720163379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eSwX8/t3OMl0d9bqgd19YFhdT5y/t7Myi2nZ/gwkh2s=;
 b=Q0cFbwPlWccYJPV8388DFAxCK3F4WIPyrtYh+rgOE9pKxZE9GYQQA6bZssh7VjwstW
 AJLlBN3IYV9VHhLMSz92AQ+3BZNNAxYZA8Spw5KDm9u3dxBdsN2USDRr0LZBC9LxO6Ed
 AJNwtIAFitK5j1tgiiSfQKEqLXPALB8u6VKzL/skb1620zZabbOqTDaQ02cKchA43hS+
 ljFAaVEm7JG1aY/LXhrsctR6/VXshZMD1e64D6LyDhgKoDQ/pP85Ty/82z9G2p6uVgbf
 QHh/gBEpkV/NzN642yUuNpEC2s2qxtaTZS31cdIHbYG6zelfCMvqwpU+2N0+w9vgvj3h
 JM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558579; x=1720163379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSwX8/t3OMl0d9bqgd19YFhdT5y/t7Myi2nZ/gwkh2s=;
 b=v/Ym3y0n7eZ5luHfrOJdj8HRad+CP4MUQSkTCTGArqhsN8xDMXY3QRrKx8Df5dIyUT
 bjRZZFW7tQfU6il59jgkmTq1qJo0oEL0hdBhxf2JyIDmGdwL/2svZ0pkVxDkPzEiMIr8
 kUZxKnSj1TqCqinXElIVsKgerzdNzOGqTAHxIlayEMWBO5x+JBDeuWOfN40rgd84y3mL
 4+WBQ8H2prYQNuIN9fAsCJwOtj1kEYGAuc9Fu4tdBkHjUy6s8jg/Zj/ylLnR+l7EDOGc
 vlV6vHFlniTFOEKpGlXCbmEGIyOo/xjHPRIetP+uTP3jKthXagmwWm5Tqkw/yA9p21Le
 6qsQ==
X-Gm-Message-State: AOJu0YwlFW7TlfaKTGqHkaTwP6k5WL4xkg4jbspORkRjbeBP3IJKS5bs
 7tCmfpjDd8zv9NWy3vPU4GwaacTgmiJBLwilU+iEr1msV361VdNpx8c+y8BbEoqk0+4SAuE+ZVR
 vUgQ=
X-Google-Smtp-Source: AGHT+IEuMJ9aMuTXmHGE4dUu9GVxoG8PR9nFqvNd80fH8rDjl4SyCb+xH/uUbO5C1SAs7ECr2vE6AA==
X-Received: by 2002:a05:600c:1d2a:b0:425:185c:7a55 with SMTP id
 5b1f17b1804b1-425185c7b75mr54184025e9.40.1719558578763; 
 Fri, 28 Jun 2024 00:09:38 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a828sm21423535e9.37.2024.06.28.00.09.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 74/98] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
Date: Fri, 28 Jun 2024 09:01:50 +0200
Message-ID: <20240628070216.92609-75-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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
---
 hw/sd/sd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a27a7e0f24..6a9d611429 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
         [54] = "SECU_spec",
         [56] = "SECU_spec",                 [57] = "SECU_spec",
@@ -1758,6 +1757,12 @@ static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD51 */
+static sd_rsp_type_t sd_acmd_SEND_SCR(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1866,16 +1871,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 51:  /* ACMD51: SEND_SCR */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
-
-        default:
-            break;
-        }
-        break;
-
     case 18:    /* Reserved for SD security applications */
     case 25:
     case 26:
@@ -2327,6 +2322,7 @@ static const SDProto sd_proto_spi = {
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
@@ -2388,6 +2384,7 @@ static const SDProto sd_proto_sd = {
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
         [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
-- 
2.41.0


