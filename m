Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5ll-0003xR-Vj; Fri, 28 Jun 2024 03:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lc-0003h9-5A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lY-0004tp-GU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso1793285e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558687; x=1720163487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L+wEPWvr7kf9AKn0k2ofydQW0/V6lPt4e04Ilr1xeQw=;
 b=A8Dhj5msEjl6dmyPvn37jj5MgVfJNYozDxhzqxXL5WY29ABuCgQOFX932KMrfcQybp
 1PwMAZtsEWW7wwoLGPlWo06uLu9nxerEsB6g9kZ0QCsTgBabKZg3yIwDXmzCJta7rRaB
 e2J0l5QrleND+BTzxQfyVs4SzodPFgLbfG01OMySDkhh5lh3c/IGCnjB5GaBjcjntX3I
 fsz/hFYfgmOg8kMh8KPQ5hd41/SA7c5M60Ndki58XAxK8PTaetcorgCdxWAFBo4Q0BUA
 tE3TMwgxydqYfpbQKJtMqCDJUb7Q08JCWBj2p3sVJqqfAmD0lYav+fcUTMIo8HwCIILs
 Sp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558687; x=1720163487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+wEPWvr7kf9AKn0k2ofydQW0/V6lPt4e04Ilr1xeQw=;
 b=e8w5pvUdP+jCOlkbuwD5nEN47n+1o3EkxlAyxyb90mQGD2uLOFtnRY/XntbEEoGtwF
 9WS4kW5vFyLq/XS2mT1dn5611mVewLe2fK6zLn8LLsqOecFfQ+c+WznIxPB7CG3O1HW7
 PDtEPouSyZzQXmeE9T1jbp19LMnMTVcEx39SRro0KAzNt4+1MPM7Y441MaBukaC3FiGp
 6Yu2j/sxbj7RxoD4sKB8zZ7szw+4u7A/vekaeO4xHie12S/Sehe4Dq1PyiJeYtFNCwWw
 Jv6//MiZuaJQB1ulsdExW3bv7pnejMdLegdWDifx+oyi/Vu4ixHSMaXBai7KU0AxY1h0
 Tt4g==
X-Gm-Message-State: AOJu0YwQBWJzhWQlV2mVRmlj8+YtYYuz6yv4lFTBLGIwxjThEqQtsE/1
 u7zhTWcXFxdDnBPxUUgI1XG1IgaAsuhr/tDzeA4s+LNcMsUJ7BbWy+y2ZHtFFPVTRO3GzXXIvds
 8lUg=
X-Google-Smtp-Source: AGHT+IHprpvY/Fz2e+LfgMwss2eSyaF+AFuIJ9QZRhgB5S+RVc39+fg1aC5LmDzZQ6cTUwp973dj8Q==
X-Received: by 2002:a05:600c:6d84:b0:425:65be:3477 with SMTP id
 5b1f17b1804b1-42565be39e0mr26810505e9.18.1719558686804; 
 Fri, 28 Jun 2024 00:11:26 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b626sm21513825e9.15.2024.06.28.00.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 95/98] hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
Date: Fri, 28 Jun 2024 09:02:11 +0200
Message-ID: <20240628070216.92609-96-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

switch operation in mmc cards, updated the ext_csd register to
request changes in card operations. Here we implement similar
sequence but requests are mostly dummy and make no change.

Implement SWITCH_ERROR if the write operation offset goes beyond
length of ext_csd.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ae5e73175e..e7d8b9c0fb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -625,6 +625,7 @@ static bool sd_req_rca_same(SDState *s, SDRequest req)
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
+FIELD(CSR, SWITCH_ERROR,                7,  1)
 FIELD(CSR, READY_FOR_DATA,              8,  1)
 FIELD(CSR, CURRENT_STATE,               9,  4)
 FIELD(CSR, ERASE_RESET,                13,  1)
@@ -1075,6 +1076,43 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     return ret;
 }
 
+enum {
+    MMC_CMD6_ACCESS_COMMAND_SET = 0,
+    MMC_CMD6_ACCESS_SET_BITS,
+    MMC_CMD6_ACCESS_CLEAR_BITS,
+    MMC_CMD6_ACCESS_WRITE_BYTE,
+};
+
+static void mmc_function_switch(SDState *sd, uint32_t arg)
+{
+    uint32_t access = extract32(arg, 24, 2);
+    uint32_t index = extract32(arg, 16, 8);
+    uint32_t value = extract32(arg, 8, 8);
+    uint8_t b = sd->ext_csd[index];
+
+    switch (access) {
+    case MMC_CMD6_ACCESS_COMMAND_SET:
+        qemu_log_mask(LOG_UNIMP, "MMC Command set switching not supported\n");
+        return;
+    case MMC_CMD6_ACCESS_SET_BITS:
+        b |= value;
+        break;
+    case MMC_CMD6_ACCESS_CLEAR_BITS:
+        b &= ~value;
+        break;
+    case MMC_CMD6_ACCESS_WRITE_BYTE:
+        b = value;
+        break;
+    }
+
+    if (index >= 192) {
+        sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
+        return;
+    }
+
+    sd->ext_csd[index] = b;
+}
+
 static void sd_function_switch(SDState *sd, uint32_t arg)
 {
     int i, mode, new_func;
@@ -1398,6 +1436,19 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 }
 
+static sd_rsp_type_t emmc_cmd_SWITCH(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_transfer_state:
+        sd->state = sd_programming_state;
+        mmc_function_switch(sd, req.arg);
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD7 */
 static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
 {
@@ -2602,6 +2653,7 @@ static const SDProto sd_proto_emmc = {
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [5]  = {0,  sd_ac,   "SLEEP/AWAKE", emmc_cmd_sleep_awake},
+        [6]  = {10, sd_adtc, "SWITCH", emmc_cmd_SWITCH},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [8]  = {0,  sd_adtc, "SEND_EXT_CSD", emmc_cmd_SEND_EXT_CSD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


