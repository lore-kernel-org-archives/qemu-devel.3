Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051EBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iY-0004Ux-3c; Fri, 28 Jun 2024 03:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iU-00043o-Qm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5iS-00043v-Fk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so2321025e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558487; x=1720163287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vajGPnoCMySfBXhKCpWI2G0uKNcFQdTzNyXEs7BknL8=;
 b=REsP/mOAJMUta8qK0S8faM+Vx62fyMDUi0x+qqj+BqBo1huRPVw5RnukRKh0p+f/L3
 V4hGmGOTnSppAotac0NWA5d5EHRkE+KsoZqNxblVzOMA0qSZPVlCVaOMRgMvxgS3/E7c
 OOrDxDWDMC5LAvVrOim03g016Hcz77JXi3PdfjeVDmZL+0OeMD0jlpPRVGkCMC0RWJBJ
 pYXusC+67Mfkme5oOPQh5ut8/vLIjLZHIeDGLGdjpH9cVZDKUpTXbHXbUFgjWrJIezRB
 FBQKk2FeyCEHyf/4i+xJSCDzjhqPzTmPK4hxAjYNRp26i+lyIJjgFCvMLWu30XoMrRgc
 A/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558487; x=1720163287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vajGPnoCMySfBXhKCpWI2G0uKNcFQdTzNyXEs7BknL8=;
 b=JzKvlMwpQm/e/BV6QJezeFrRT/lcIl9psZg62+XO/mdqW4CBOTLxmDge0nnq/E3dNf
 pFnrDta2H+PKfLrW0J8fxNuCP206dGjx8rpGLvywFGS2Gt3+QQmKLpyD8lPk7T8fBH+V
 jiGmZ4TsysFH6XG4MhfJ7AgXf5FONN/VavevM4TteZrljlSz7xaAxK25r7ZU+wnZtb8r
 zgRs6LtdHqTH7Fi9Fj6ljMu/Hj3UcsR7oQ5zJyGzGLXYIggDKIXI98evemAw4bAcQw2L
 aWKrcnyvln4SnQlJaDG/AP2mIVvjhBgP3rIAfE6FxVLJ7lLx4duEUzg2mNszyyjTYZ8H
 GyeA==
X-Gm-Message-State: AOJu0YzvlnDgWqYv6d0Le0DUv5xwU30esOhgKKNRbkm7d4ld6qIcyak7
 vb29A6nhXXsm09x7PWHuYPckB+5AF8U5yZkgO6lMD2FACyWVJ1ZQot/A9NckkA0oEyoqU18ygsC
 /K/M=
X-Google-Smtp-Source: AGHT+IFZSSeCIpBZNfABmCHgLWjYiIP74FuNifXnvNv8Acp3I5ElcT3ycPprdKM2kt/LIADe+3ETxg==
X-Received: by 2002:a05:600c:138e:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-42489e3708fmr108897145e9.4.1719558487163; 
 Fri, 28 Jun 2024 00:08:07 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af37734sm22770345e9.10.2024.06.28.00.08.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 56/98] hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK handler
 (CMD17)
Date: Fri, 28 Jun 2024 09:01:32 +0200
Message-ID: <20240628070216.92609-57-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 hw/sd/sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d731c3df58..e2a7ed8b45 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1441,6 +1440,24 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD17 */
+static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    sd_blk_read(sd, addr, sd->blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1507,22 +1524,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
-                return sd_r1;
-            }
-            sd_blk_read(sd, addr, sd->blk_len);
-            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2306,6 +2307,7 @@ static const SDProto sd_proto_spi = {
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2338,6 +2340,7 @@ static const SDProto sd_proto_sd = {
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


