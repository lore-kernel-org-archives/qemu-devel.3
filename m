Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34668C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsB5-0006wF-3A; Thu, 27 Jun 2024 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsB2-0006d3-7f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAz-0007L1-Dd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so11665895e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506446; x=1720111246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fY9Hw86o5iLpIx4cOdBUGuwKgpX9A8Bw42XBcw/lnQ=;
 b=NY8fR6bW+NKZ5p8wgp6/GPHSTu03mJKLLvYqpC2JxKvJ3G6YRyRmaGrwEXdijzTZRp
 iV4kKotiG4lGG7N880Wm4JiDiwAgYjkXGlkjNZ3eUYJmAEuV0UaQ/pdeU7nMG/NouvSY
 wlPt1uDQ4Zg0Amf+Y+EK5nfQmHxy5FOUKekUHvcT716r/cgkD+lVV2JpgckIEx65AEhK
 Ayov/y4pq7r0gUny7jvc0h0HY07ro0SEhrXXNuxx8LYvT/vVVWjp5N+bhFRHq+GSlKaW
 FofuhKfiTgi2b1UNaqKljoXDcTVM17UCjMb9NEnifCnzfsLrQnheFA/NdH1CYdWmdGfE
 3e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506446; x=1720111246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fY9Hw86o5iLpIx4cOdBUGuwKgpX9A8Bw42XBcw/lnQ=;
 b=X5bFksViUDnPjpF6a2XMS4/CvfQoEnN5nxIx8l9wTQ8uZ89CmaxiuOHybtp+AY22qk
 aV2/cFdWXXWGcaeEMttTXFB/VXbpq/b8DiXFQLHhJfv6CQniszmaPCHQEpNPOdhq7VUR
 gap2SwtWp1qOOTHTmjw9ATcGHVNm2BqE6nx0aDwBVe+4PwTLt2vbV21xTdHmyM45i75s
 Wq8GnhWwa7YErJABkqaqYJVvAJs7F5tkOp89jAjAN2yHdlw4m9Jos35UF+jLsd+/VRPa
 tPE4/AlPwMv5KRoXaMIf4dtytoDcwp3Ciky+xQACE53vOofEjSLOJESfiYek3dcoqRir
 Ua9g==
X-Gm-Message-State: AOJu0Yw9HX+vGVS6A+NxBE0cX4iFSgDGWVb03FjiN9V56pPzm2+dqA/6
 2Due3U1pA0ctAMLwseJcu6I2o+VQmt2xro3zbW94a8j2dpt+Aiy48tV+2IhCotM7w0hwdZdCeUa
 CjAk=
X-Google-Smtp-Source: AGHT+IH+/jB7l3PR5anxBoTRXRp7IJbR7yL5BmLIuxVduKPntxcMQRjPrsMkU0Vc4oCJTj5X1PG4iA==
X-Received: by 2002:a05:600c:16c4:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-4255ec35786mr31261075e9.35.1719506446666; 
 Thu, 27 Jun 2024 09:40:46 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84692b5sm74980905e9.40.2024.06.27.09.40.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 11/11] hw/sd/sdcard: Register Security Extension optional
 handlers
Date: Thu, 27 Jun 2024 18:38:43 +0200
Message-ID: <20240627163843.81592-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

See "Advanced Security SD Extension Specification" v2.00.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 87bfd0fd56..e4941cfdab 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -253,14 +253,11 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
-        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
-        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
-        [50]    = "SW_FUNC_RSVD",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
-        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
+        [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -2269,8 +2266,14 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
@@ -2289,6 +2292,10 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
@@ -2296,8 +2303,10 @@ static const SDProto sd_proto_sd = {
         [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
         [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
         [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
-- 
2.41.0


