Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0545C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsGF-0005jZ-LX; Thu, 27 Jun 2024 12:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFv-0005Wu-Ci
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFf-0000B2-6o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so63900445e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506737; x=1720111537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ6b4+TolgSwbj9JxT9jbN1DwNz8KwrcgVlUMC5kG7c=;
 b=qml8qiv0FaaoRFxhaHOPfjCs8c7hMvMgh8BCXEwbH2+gs3ruLjs985tRO+sTUzeKVq
 GWO9o4z01xTrF6bvx6Tqozcsy4TaaNEtqHmNhEp9pv3rXssJ98b5OqnXlbR0ZYnHCaTv
 PUel36uzmNFDS3EPRLuazL2+ZaZ5djuSiOD9cbGZ86xchwHR3dsnr1YygOjM6LnB27dq
 t6l5NXUYaGGUBQmov4trMtrFI3ZA+YW5aJT/ITxvngE8Gtk+vqn8MK33ndoAR0fJ6763
 pC65MTkfS5NtYQp9y7NELNYSf2BBntBvGadISXKyUpUOgtWqGaFINY4HsPfL2OpHAE8Z
 /0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506737; x=1720111537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ6b4+TolgSwbj9JxT9jbN1DwNz8KwrcgVlUMC5kG7c=;
 b=n1iQC0hnPeyCDC3lhDzVUp4cb+OdVtXK3msD1iqsvgVLfvYbYrgHToIT4b9Ybobu3N
 LRFQLcVHZqGrrROmZ87gkR2B+k9EW+AuHgki5QZVvG+qx+DaPHRaephsC3mwpo9Sbpxl
 pYKtKzECe8eJV96KG/DYuW84D4fIAAPs1IqY8AK5ckz/dGmy1jafwKuxWl/6W8y7VSdr
 8ucQGYRk4Sz7bzWklTh2wc8OsTHbMjNAG0PxDvTCsbymb9cwpi9oLhfzTor4JwGiMP3T
 6SkceEKut3Q8gUoVP4hU5qjfKx3AZS5dZSsVGVBQmvk0iMRzGHsQS2gfhIBRlpKQGGnN
 1xeQ==
X-Gm-Message-State: AOJu0Yz2x2MpPPv7zOH7rj4NFJU/wmw8vAlIVj0XQmLvSqc9EY5GOCz+
 /xFT/f5FvzFlg5SsH/efhf08zwndmwpEhUhNjUG/DU1D48AB7H6Odg4aCWR7U3n77xiXafrNfzn
 tdv4=
X-Google-Smtp-Source: AGHT+IHyDP0ZOgwnbNPDUGbuOCUznyCdRSz3DIV5mdoYYKlGDE8tb5bLrQaeLh61iORQKFHHQ+3saA==
X-Received: by 2002:a05:600c:2e4a:b0:425:5e9a:5958 with SMTP id
 5b1f17b1804b1-4255e9a59b3mr38061485e9.22.1719506737617; 
 Thu, 27 Jun 2024 09:45:37 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c837dc4csm73263165e9.26.2024.06.27.09.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 11/21] hw/sd/sdcard: Add sd_cmd_WRITE_SINGLE_BLOCK handler
 (CMD24)
Date: Thu, 27 Jun 2024 18:43:34 +0200
Message-ID: <20240627164345.82192-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 hw/sd/sd.c | 57 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e2a7ed8b45..4650d20ee7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,7 +242,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
-        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
+                                            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
@@ -1487,6 +1487,33 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD24 */
+static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    if (sd->size <= SDSC_MAX_CAPACITY) {
+        if (sd_wp_addr(sd, addr)) {
+            sd->card_status |= WP_VIOLATION;
+        }
+    }
+    if (sd->csd[14] & 0x30) {
+        sd->card_status |= WP_VIOLATION;
+    }
+
+    sd->blk_written = 0;
+    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1544,32 +1571,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     /* Block write commands (Class 4) */
-    case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
-                                  sd->blk_len)) {
-                return sd_r1;
-            }
-
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
-                    sd->card_status |= WP_VIOLATION;
-                }
-            }
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-            }
-            sd->blk_written = 0;
-            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2308,6 +2309,7 @@ static const SDProto sd_proto_spi = {
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2344,6 +2346,7 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


