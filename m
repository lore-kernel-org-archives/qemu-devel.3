Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62F4C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5go-0002i7-V0; Fri, 28 Jun 2024 03:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ga-0002KM-A4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:22 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gY-0003Fk-Cb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec10324791so2203441fa.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558376; x=1720163176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FQYmSrnXt5mY866BTgrOijDYx76JFvHs12wH0ygKj7I=;
 b=TZxUyhwATKwfwTVrYupmg4bwOOQyQkP0CjqetVsvXTlAs5RuZzXfMRUjCh2IS1u2eY
 2wGPCg5JxZtjgiHnZ7Rh6/OpmtOSyVunb2eEKhJI8lVQYRIxOUEitRaLDrrsVa6Laq7S
 5zwk5nAWI8gHE5u1fpWSBOsZgKtagixvKLLhtoVNhKs+Qhe7yZyp4jjUqnZVKl+kKoOt
 41S4wIwhHnEsUjQWFPIGj2DPiDRp53XeAndV601sDdXbm+OjooVl5fX9+M+xPxdmTazn
 Ab8+VGtKGRCePxawpypRejx0x4I9soAUGUZMueVu+mUMv1LxOzvuX5TgW61nsTj5+m8Q
 7I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558376; x=1720163176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQYmSrnXt5mY866BTgrOijDYx76JFvHs12wH0ygKj7I=;
 b=GII1PvAYbti2jIKUBHTyo7ab4wStBHGhMd1K8GfuAITX5xBVUmQLOwD2FpPKSL+mRK
 ib6Wh8oEOUlF/wlEuBZ1V77lnlhpgq0/85cgWLDE6vglFfhmamLlEFhyVOLwkEciryoa
 k3gdMjB8pCmB7stM03+Ag8nuv2LChwar9r1iHIHaRQ4QsTrFGwI+M2dIUspe2lHZfbVg
 ENMJAyYOKqf49JzRfeL9erlhIqDxLTmXAEtFFpABXLn6vILVz3gk1oxyqR5eStzk/4L+
 i+gWPaoHMm/32/dW88HaEGKM2O0bFuBzxBWVRPix0220zhYyxxArD/x9ZVtq/UEWFMcf
 6jNA==
X-Gm-Message-State: AOJu0YzNxEsFL4tdXfTd5rDQRMNVz+/hC6vTc2Sm8h6UoNio55CtYUZw
 tzzBIBtT8cZYvw90Yruqw93qRb9kzpA6vjuaQLQWYyC4l0A0CD5EIfS9xzsiJingrSCQQnd3Iey
 Rpk0=
X-Google-Smtp-Source: AGHT+IFZw43mMYkHLrxfwfQm+NGw2QpqzOACnTpXF7EkFXtH4oausyoCtjzG568H76PJG33kiu2VFw==
X-Received: by 2002:a2e:9985:0:b0:2ec:5128:1850 with SMTP id
 38308e7fff4ca-2ec5b27e720mr92735051fa.13.1719558375878; 
 Fri, 28 Jun 2024 00:06:15 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a2bcsm21072595e9.36.2024.06.28.00.06.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 40/98] hw/sd/sdcard: Store command type in SDProto
Date: Fri, 28 Jun 2024 09:01:16 +0200
Message-ID: <20240628070216.92609-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Store the command type altogether with the command handler and name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h |  5 +++--
 hw/sd/sd.c         | 44 ++++++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 2c8748fb9b..29c76935a0 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,8 +76,9 @@ typedef enum  {
 } sd_uhs_mode_t;
 
 typedef enum {
-    sd_none = -1,
-    sd_bc = 0, /* broadcast -- no response */
+    sd_none = 0,
+    sd_spi,
+    sd_bc,     /* broadcast -- no response */
     sd_bcr,    /* broadcast with response */
     sd_ac,     /* addressed -- no data transfer */
     sd_adtc,   /* addressed with data transfer */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 97fb3785ee..c4cc48926d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -95,6 +95,7 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 typedef struct SDProto {
     const char *name;
     struct {
+        const sd_cmd_type_t type;
         const char *name;
         sd_cmd_handler handler;
     } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
@@ -351,20 +352,6 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const sd_cmd_type_t sd_cmd_type[SDMMC_CMD_MAX] = {
-    sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
-    sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
-    /* 16 */
-    sd_ac,   sd_adtc, sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none,
-    sd_adtc, sd_adtc, sd_adtc, sd_adtc, sd_ac,   sd_ac,   sd_adtc, sd_none,
-    /* 32 */
-    sd_ac,   sd_ac,   sd_none, sd_none, sd_none, sd_none, sd_ac,   sd_none,
-    sd_none, sd_none, sd_bc,   sd_none, sd_none, sd_none, sd_none, sd_none,
-    /* 48 */
-    sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_ac,
-    sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
-};
-
 static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
     2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
@@ -571,10 +558,19 @@ static void sd_set_rca(SDState *sd, uint16_t value)
 
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
-    if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
+    switch (s->proto->cmd[req.cmd].type) {
+    case sd_none:
+        /* Called from legacy code not ported to SDProto array */
+        assert(!s->proto->cmd[req.cmd].handler);
+        /* fall-through */
+    case sd_ac:
+    case sd_adtc:
         return req.arg >> 16;
+    case sd_spi:
+        g_assert_not_reached();
+    default:
+        return 0;
     }
-    return 0;
 }
 
 /* Card Status register */
@@ -2277,22 +2273,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]  = {            "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [1]  = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [0]  = {    sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41] = {            "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [41] = {    sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]  = {             "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [2]  = {             "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
-        [3]  = {             "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
-        [19] = {             "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
-        [23] = {             "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [0]  = {    sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {    sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {    sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {    sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {    sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


