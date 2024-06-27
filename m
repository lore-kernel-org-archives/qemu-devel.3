Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E8C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI4-0007uG-3n; Thu, 27 Jun 2024 12:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGe-0006Sd-AY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGc-0000TW-DQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-424acf3226fso19283835e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506796; x=1720111596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYHB8+xaBcVQbVKgp+p9kpTdDb0kmp4G0ZMulayNcv0=;
 b=zY997UVoiEH42cj//KM8OfVSqGqIMwXqJBGXCnOfXoIc1B2Sv1Yq7D5p5uOZ/3+6cB
 AQCbNGoW9OWo6PDi8LBH5rHtD7WSDVGcrUzEh6qFj95Gznu+iTjCugFd/mAGIbM7Nj2B
 NhoDSjXUzUmGRyTqyPIeT9DIWZ1ID82tC9nCsVG1p5c6BNtd6xT7HiIrSkaUOvqlKLBG
 fHyuDY9oD+YO77jRf3LcNQbzlUVxyfSUZvbcd9bliPOHgzzMUVLhwJn0DVDa+tKDuohD
 B19dKPm1A2mhWQvSVHp6WsO0GJLYkJaAE2q9HewSW234y1uPRMe8Tz0QRgtDtQ7oUCVs
 fP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506796; x=1720111596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYHB8+xaBcVQbVKgp+p9kpTdDb0kmp4G0ZMulayNcv0=;
 b=hyvoCQQ+w7lA4HhD/rlmcWS3lArlMUFxb13GrbK56HE6/D3HQSlCoGJyOrwn3mzVKM
 kPeuIzJP5CBYp6jBeZ/36wzglUSgs1h3gghtrRudsghkVFw8Xg7X0vovo9zqjh2vOVKE
 5vbzm/6mgwVV54mL+Kva2uF8pFBqeUkdBLlieaPjlJJ0KpQyg+4Tmi2jc3qIqH37asAZ
 mEzkzmLsZEsLSjGjztDvP1CnVNQZhwlxzkPypyVY9GYcNtK8iEeWSR4wpK053dLvVZiz
 4wfdALtpIxZYXN3zcYoimxM6YFd7niiJvsLxm3thoBMc8oSnDrM4dI3abRicmOq/Eoqj
 ahUA==
X-Gm-Message-State: AOJu0YzBWu9nF+lz3EvL17wxG/Thg7x9shqYFwDF/h62xv39VCTLfVxI
 c7Xh3dBs2a1aFKGEkSszPkZPzZjy/8o5CEKyoKUc9CD5kFeRwtjSc98G1X+BeM622jq2b2wAmI7
 Dneg=
X-Google-Smtp-Source: AGHT+IG6rB8XeieU+MdEOqPoGSIvk6YMxGoNWWfJv+jUoyeMOqO9h64EXqtZOFzvqE6dAU5JSeOLwQ==
X-Received: by 2002:a05:600c:2192:b0:424:bb45:cdea with SMTP id
 5b1f17b1804b1-424bb45cedbmr39589435e9.22.1719506796696; 
 Thu, 27 Jun 2024 09:46:36 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8246b1dsm77780835e9.6.2024.06.27.09.46.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 17/21] hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler (CMD42)
Date: Thu, 27 Jun 2024 18:43:40 +0200
Message-ID: <20240627164345.82192-18-philmd@linaro.org>
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
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 17fec612eb..4d78ac5b59 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
@@ -1619,6 +1618,12 @@ static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
     return sd_r1b;
 }
 
+/* CMD42 */
+static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, 0);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1707,10 +1712,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Lock card commands (Class 7) */
-    case 42:  /* CMD42:  LOCK_UNLOCK */
-        return sd_cmd_to_receivingdata(sd, req, 0, 0);
-
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
         rca = sd_req_get_rca(sd, req);
@@ -2316,6 +2317,7 @@ static const SDProto sd_proto_spi = {
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_spi, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2360,6 +2362,7 @@ static const SDProto sd_proto_sd = {
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


