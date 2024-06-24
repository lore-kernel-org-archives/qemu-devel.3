Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40ECC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjZM-0005jU-Sg; Mon, 24 Jun 2024 09:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYe-0004ix-1N
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:37 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYb-0005de-N1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:31 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so51699961fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234987; x=1719839787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXfJJfCbngNXWETKRmSoaVmSjOkjTU89WVvhepuXul8=;
 b=fir262VdbE3+A4+6tFWLLdW2ydwg8ioyytaFvNDzRA70DQdUKTvy3z72csUw7XXVJO
 kb7D3mlckeu13XzwJpgr9GRbLz/gXQgB+6K/mzr+CwlTOOy9DqklWhdiBtCDrLfyDYsw
 BcpSMR4RbA6IHhXalUpQZe2+3rIzb/VfjsFkRSjWWWSQMN0mcT7b8GbsU4+6PnfTJKAC
 +8L8a/3oM0xqbgTIf6B/S+mr3x9wDGTJEsvf8k+8fYM777dIFHeeU0XV00DUpHU7XHZj
 /6E7ltMTVMums8hvQUi2kLWQHkUqC7E47WS9H+I8ZrNs8DCVTHuq3pVlltTtw9AnyAbl
 Luhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234987; x=1719839787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXfJJfCbngNXWETKRmSoaVmSjOkjTU89WVvhepuXul8=;
 b=A+eE1xzVHhO0Q7MQzJrCmClnZ7VPw1hYq5WOssxMkZf5Jh8Bp5eROkUr1WoTLuODha
 i/jayxtNw78dl+tnqjZKOW1aaCMPUbbXpmJCEg2XEc1RTKk+fHxVlAce5UlTQOtxoFeh
 BEqK1oh3Qx2MxgcwlZw9lbVJk6n8GtjVYScMLjf72KEJQXLvaP6DXdltGcaZiLBig/vT
 IPX1aYqjUMxoxLKFwv9/w2kgZH/5SSH1tVTGuG88q43RFhDYatdZfJp3B7m8NtgKgDPh
 +sktbRQs8OIydkakqFTHO/lpcMCAjyGObGURundGpVO23QMP+Y3Z22bPvrbgW5yR0iw4
 +CFw==
X-Gm-Message-State: AOJu0Yw23i5Hl1AK+uaUSnuhuBfuJRBYPgNf3mLkjtKHAlBIHmAqr7PO
 Y2ioJJo2Awy4+WSYQV9omfKkvJk3v+R0ag9L1iPBCEmIWsNM478TLaymUDmHT2TsDappuCRRDyY
 Y
X-Google-Smtp-Source: AGHT+IF/r9Rw0Zf+hKADiv4wQF9oQoRWpOXvNQqoFGXoA9GvckLHqQzcd5DQsMR8irUEKhB4624axQ==
X-Received: by 2002:a05:651c:211d:b0:2ec:5dfc:a64e with SMTP id
 38308e7fff4ca-2ec5dfca6demr30542061fa.0.1719234986576; 
 Mon, 24 Jun 2024 06:16:26 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248482f1c4sm120290265e9.10.2024.06.24.06.16.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:16:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/19] hw/sd/sdcard: Add comments around registers and commands
Date: Mon, 24 Jun 2024 15:14:40 +0200
Message-ID: <20240624131440.81111-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-21-philmd@linaro.org>
---
 hw/sd/sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d4e3d079a8..a48010cfc1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -315,6 +315,8 @@ static uint8_t sd_crc7(const void *message, size_t width)
     return shift_reg;
 }
 
+/* Operation Conditions register */
+
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
@@ -364,6 +366,8 @@ static void sd_set_ocr(SDState *sd)
     }
 }
 
+/* SD Configuration register */
+
 static void sd_set_scr(SDState *sd)
 {
     sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
@@ -386,6 +390,8 @@ static void sd_set_scr(SDState *sd)
     sd->scr[7] = 0x00;
 }
 
+/* Card IDentification register */
+
 #define MID     0xaa
 #define OID     "XY"
 #define PNM     "QEMU!"
@@ -411,6 +417,8 @@ static void sd_set_cid(SDState *sd)
     sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
 }
 
+/* Card-Specific Data register */
+
 #define HWBLOCK_SHIFT   9        /* 512 bytes */
 #define SECTOR_SHIFT    5        /* 16 kilobytes */
 #define WPGROUP_SHIFT   7        /* 2 megs */
@@ -480,6 +488,8 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
 }
 
+/* Relative Card Address register */
+
 static void sd_set_rca(SDState *sd)
 {
     sd->rca += 0x4567;
@@ -493,6 +503,8 @@ static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
     return 0;
 }
 
+/* Card Status register */
+
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
@@ -623,6 +635,8 @@ static void sd_reset(DeviceState *dev)
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->state = sd_idle_state;
+
+    /* card registers */
     sd->rca = 0x0000;
     sd->size = size;
     sd_set_ocr(sd);
@@ -1055,6 +1069,7 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_inactive_state) {
@@ -1065,6 +1080,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
+/* CMD1 */
 static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     sd->state = sd_transfer_state;
@@ -1072,6 +1088,7 @@ static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
@@ -1083,6 +1100,7 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD3 */
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
@@ -1097,6 +1115,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
     if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
@@ -1113,6 +1132,7 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD23 */
 static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 {
     if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-- 
2.41.0


