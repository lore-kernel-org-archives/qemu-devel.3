Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F18C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jl-0006ea-8U; Fri, 28 Jun 2024 03:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jR-0006Vi-R0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:17 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jP-0004VK-Vf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:17 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso311825e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558553; x=1720163353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9vrkGwBcqZVZMukUtGlLs/nHFLle6eNwrj7janh4+hs=;
 b=p+Y7zEMlQRTIhRhM81alr2pWYJCYsoQH1cT9PO8aiJx/dX99qTOe8tX6cweQ4aVfHc
 8IXGjg9RVL1pSTA6+2NqoN9GQE17emTRMAEpNXulEQJ9DDiWE90Y+Yu11un7lL40f5OS
 LfjLk2LYyMkEcIjM0DD2IS7POT2+f4xJf68tE876pmo4aG3RJmpEha8xf0L5lBqbae6P
 eFEDSa7cd+hAdEe6BqcFr1JD4HbgkifqosOxicdWtE8xLiR55jL16ayZGEA80mpVcfYY
 uxTy9nijb9bi6rgWpEFMO8O5xuNgvz1ZKz3SE4Dt4geyF9JhgiPMc3ikgkLP7AQvS+w4
 k/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558553; x=1720163353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vrkGwBcqZVZMukUtGlLs/nHFLle6eNwrj7janh4+hs=;
 b=I3A9JKdTcao+tyYuMDfcJl4rpcOONJ1889w70EnEFrvmcse+WUb5lq3sXxVAj7aIpM
 jL9dcagtFCo8VnSAcaI8X6Hk/jtNR8VqUtPqtoJe3YYYjLmej25DKhCLPE/yP2d24uNJ
 9d4DoBvV8CEeufgBmy8beJfRGj4+8ZBwMfO7Cw6sLgifl9PJzfGRO70/N6L1IqSJ+ErR
 zszVlXclkBioPKIBVRRutFARAzAW6M2j7fi7o7hPrUaSzxGuNMs5Zonr1Hf0VEocWqlY
 m44Ym1dgm8F6k3irDbKlA8Q91BzZnQlrNkSu5xfAbH46RAtre1YCJdrfFjkQqFfSb2bT
 JQgw==
X-Gm-Message-State: AOJu0Ywcr2oiHEyzJXa9skn7k7Zr2pnXTVLmQzoNA/Wn8ZVjIh+H05ZQ
 sbs+wg9Meiu5WluQxX9c/+KwyLcIcChXZ7u2RW+eIwfcfYGp5WmZBPoqpLtII27loAWzrc1kbTr
 zm9Y=
X-Google-Smtp-Source: AGHT+IEGbAT0GncNtKHO7ksBH684nt1n5FcMLTsDEIkL/v4jnuq9KhdxF+nrl9N1L4c/37BzeFDAYQ==
X-Received: by 2002:a05:6512:118e:b0:52c:ab83:d783 with SMTP id
 2adb3069b0e04-52ce063d63emr12759506e87.6.1719558553571; 
 Fri, 28 Jun 2024 00:09:13 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb92fsm1335266f8f.88.2024.06.28.00.09.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 69/98] hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
Date: Fri, 28 Jun 2024 09:01:45 +0200
Message-ID: <20240628070216.92609-70-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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


