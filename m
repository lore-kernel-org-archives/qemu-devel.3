Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F664C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsA9-00024O-GX; Thu, 27 Jun 2024 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsA3-0001mg-Bo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs9w-0006vW-PE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:39:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36733f09305so943456f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506383; x=1720111183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQYmSrnXt5mY866BTgrOijDYx76JFvHs12wH0ygKj7I=;
 b=Qlb2GJxXRJ97tVKLuaQka19908qnT7nwtxqhPCOvAsRgOiN19IqBHpQLE3dFgr9+Sd
 sPSfIL9Ys8lGjIPRsDdawuSiv8HWgggTq3kBfI4RMkEihnZQ1hU1pj0umKyUbPP/qbCi
 mK+lQYv7KS0mmVuhqfZDhCAQlletdK+oOVEMjqsKp6Z6BoCUOvtb9MTcGI7cw7zaeCHr
 CMXK0AJiGlAeCpjZtGBYfoyLUyjpE0uuB3wMfSBlNWoUttoDG8D7NKWEGaTuEEaobBJc
 YaT7DcTr0gJpSjRsJvM/rbiMQGxdBjAXvxp5Q1p0eLPy5V1mGEzEEnAk1UOVBQLzezDZ
 0vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506383; x=1720111183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQYmSrnXt5mY866BTgrOijDYx76JFvHs12wH0ygKj7I=;
 b=OlngTSKO/1fZtpEIJ8vgeyf/gm4AznuIxDCmGOS9aA9RX8CFFJzAZEKDEQ3BwK1XsW
 5JBJ4/ZPJq3iWv3+Pyiam/l7oMJg7pcHRstQvCNfskBYOKUqES3qEufNWWLDn+EhPROX
 roygS8jqNsyY8HbZ0XCr6v7D+603lo6JVP5kjhJR296ox04evJjQrJI65mQndbS++ag0
 bUTW+CpDQQMCPBA03u9St0ZS977VajLLEwnlH0WmZehDOtikPrr9RGaLBgX+sJB95wG9
 VQI677oKZ7znVb/8aQ6gshWmYLzntdJFfTwxxwl5BhKJJC/mCZH3D7Prw+L93eK/vq1/
 FWDA==
X-Gm-Message-State: AOJu0YzcxrPwLK1MHwPNOlmnb1aRAryQOhoK2JP7jAjzrBwOjff4VBKF
 6WvqtJCaYHx1uwRCnBaM+NnunYuAeMrwqhRJVStZ2UIP1wgdTVqtPgnvk9Y7UGmTedfHkuh+OAG
 BsEo=
X-Google-Smtp-Source: AGHT+IHQbmsC0HWVvuB1JR5LM4eXxNJkSJgXyyXasmZf2+ytQyFcgNKpcceNRUPLeAX3r+AyAtphdQ==
X-Received: by 2002:a5d:6487:0:b0:362:5a6e:2649 with SMTP id
 ffacd0b85a97d-366e7a56dedmr13977062f8f.56.1719506383178; 
 Thu, 27 Jun 2024 09:39:43 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c089sm2442223f8f.7.2024.06.27.09.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:39:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 05/11] hw/sd/sdcard: Store command type in SDProto
Date: Thu, 27 Jun 2024 18:38:37 +0200
Message-ID: <20240627163843.81592-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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


