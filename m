Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA9C3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3cG-0008DN-J5; Fri, 28 Jun 2024 00:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3c4-0008Al-86
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3c2-00083r-Ax
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so1887815e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550408; x=1720155208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vrkGwBcqZVZMukUtGlLs/nHFLle6eNwrj7janh4+hs=;
 b=nIiDPMkHIaq9c/7QxbDC4b+/Jty15PrIMFR9kMGXT2uQX+UIU4kPLESG2CpNPy7hpr
 B1RkwGaUohdC6mWz19h9DX1gaN4O8wslxsVN2XmoKZSkitLahX/XPRnU3O3FbtJw/4py
 zzOjyiKbayxUR4ICa8K9zNgKjDtefTBFuya5iPYwxJ+/prSmE6L20Xore2Ay8WNf3V0a
 qXN5K4pwVgMagvO8wm3HClapMjPp3SL9iK+Wl1rlmS2KBaeOLbF4gGkM3E/HwBEG16SE
 J631Mn5PVnMXBgDLr7QSVpSby/ho7h66dCLzUr+fL9X5b2itlcc0E2w/i9kzQz8SyffJ
 /ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550408; x=1720155208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vrkGwBcqZVZMukUtGlLs/nHFLle6eNwrj7janh4+hs=;
 b=O+cvkr3A09ducrnbfO6hETkTYmV4piVNVSDC07g5Omd92RQRpK35T6hmJIdUcEGhq+
 KSBH5T543/ukdRiugGXMiwzcF58ykC1K2qXATjKTI/5wKHhczHX7VuG/nT0lSGMlMGxA
 VSzWU0UBUuYHrAlhekwHXf7wvusalTZKaLLkxsnLFoSXukzkBEMDxkj+GTEp1JJOhpUc
 XOYlL7yPI1bsAw+aIUxLCJ5pacCK2rppcKbp8AoHOMu+pnxtLgOmXP5YX0B2tiXbuC2y
 B2TEAEdUEuLyGCjxUiuN3iZJ1AetAs41PZJjnhieDaCtv671G1IPYfsAeSayHNvHix0P
 fcnw==
X-Gm-Message-State: AOJu0YzfWHx9O72+/GCjeAoFJKfOpFb+OzLKBKSLGd94v3+xwBPdk1Um
 QFTYfLFJPG4M1E2EASCJcu/OqZafDTthH6JMD6oQIWt40rSruw17p9jG2Y49V1gYX27wNNGZEeG
 g19CAdw==
X-Google-Smtp-Source: AGHT+IF53qg/ECt1wXE7W7DeylbxfI5udPBJGVPBPA8HXv1Qm1q/Q70vB7/YT53N1cT/dtFikAUoFQ==
X-Received: by 2002:a05:600c:12c5:b0:425:5fe5:f273 with SMTP id
 5b1f17b1804b1-4255fe5f3d0mr42043715e9.26.1719550407561; 
 Thu, 27 Jun 2024 21:53:27 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm17899595e9.31.2024.06.27.21.53.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/12] hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
Date: Fri, 28 Jun 2024 06:53:13 +0200
Message-ID: <20240628045323.86308-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 hw/sd/sd.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0310a5a3a1..5323a42df2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -260,7 +260,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-        [13] = "SD_STATUS",
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
@@ -1683,6 +1682,13 @@ static sd_rsp_type_t sd_acmd_SET_BUS_WIDTH(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD13 */
+static sd_rsp_type_t sd_acmd_SD_STATUS(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 sd->sd_status, sizeof(sd->sd_status));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1791,18 +1797,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 13:  /* ACMD13: SD_STATUS */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0,
-                                         sd->sd_status,
-                                         sizeof(sd->sd_status));
-
-        default:
-            break;
-        }
-        break;
-
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2329,6 +2323,7 @@ static const SDProto sd_proto_spi = {
         [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
     },
     .acmd = {
+        [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
@@ -2386,6 +2381,7 @@ static const SDProto sd_proto_sd = {
     },
     .acmd = {
         [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
+        [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
     },
 };
 
-- 
2.41.0


