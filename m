Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD10C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsFT-0003uL-O8; Thu, 27 Jun 2024 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFO-0003bR-KT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:24 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsFL-0008Uk-Al
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:45:22 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so92254721fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506717; x=1720111517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x47xZoGwEv6OAz6MBmyY9zpVBzbWRJPcmwD+bMVYlw=;
 b=SbOMYOx5MAvlT7xfXBfWPXJqzZelgjFJZndZ4xCxemYh62UMUKMX3HjOzDYux/G4Nl
 HhA+99i7GomZ3wOghdigkm2Xhi/90eq4BtG1bFDyinL4bYn2YGaBTEfuLgi6uN0dyDqe
 2U4slS0fQaTzUDXinwrS25tCbXOtavz+A9qGkyn65YUYlvtHynfhuNd4/2EOkJDxrdT1
 gI6X9N/haKKy368Qvy4DZ0stC0lbNVey9JpNAa+/k0YYqPKDRIPQD22ZOsu2RNlUdhH+
 J0mHAnW3y6YqG/OW8kM7quf/AGWCRFjpjoFnhOrrjBLZYfpALl0AN2zF+htndkOvqTre
 DOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506717; x=1720111517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x47xZoGwEv6OAz6MBmyY9zpVBzbWRJPcmwD+bMVYlw=;
 b=FIN5Kjo+24fXGt+4Moo5Mu1EgK+lByhCN7vrOGrG2FvPVajTWsitGbSL8dAF4gj3yX
 F1c/09CXTpdYmoGkcyWH1JS+FzLY7MQhCJOWq83OLJ0oSTd9ih6qPWBYwxOOCPuO56/e
 MuxIENNvR7kVcsBzDm6wWzT6HurUgtEGWDFesOcqrnS3qRBkzWT6k8+mI4AKqgXErp7s
 pwPaQPyv1dZ10yMcZiV3TPDQ941eKUuUGEbaKz6CsERxZplHQa55mXerToeXUNmMqdvi
 3JBlFAyaMdpeASys2IEKPPiJ3dHhQndwnDdGeYYhFg25sdl5Bg8kWJM1FEgBpa5nTcKC
 KagQ==
X-Gm-Message-State: AOJu0YwSfDuZhyiNc/VwYAqi5cz4T48vXz2wTUzpCKVEQK2rNt45SN2S
 n20OsLeaVmqC3xRCGY31l0Hc2UkhXMpblNC2OLRnqskqJnua+Y6CSI32miBFLdG8dxpaytpfLoD
 WvzM=
X-Google-Smtp-Source: AGHT+IH1wOqUlvz5b9iIVUERP+SxXCWF0mXK6iHjr6bNOwMzdbGragyXOFp/dj7Z0ULB3I7aL3bJrA==
X-Received: by 2002:a2e:800a:0:b0:2ec:4e59:a3de with SMTP id
 38308e7fff4ca-2ec57967be5mr94810931fa.10.1719506717191; 
 Thu, 27 Jun 2024 09:45:17 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6d28sm35291065e9.31.2024.06.27.09.45.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 09/21] hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler (CMD16)
Date: Thu, 27 Jun 2024 18:43:32 +0200
Message-ID: <20240627164345.82192-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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
 hw/sd/sd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d7ed8aee73..d731c3df58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
+                                            [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
         [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
@@ -1425,6 +1425,22 @@ static sd_rsp_type_t sd_cmd_GO_INACTIVE_STATE(SDState *sd, SDRequest req)
     return sd_r0;
 }
 
+/* CMD16 */
+static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+        sd->card_status |= BLOCK_LEN_ERROR;
+    } else {
+        trace_sdcard_set_blocklen(req.arg);
+        sd->blk_len = req.arg;
+    }
+
+    return sd_r1;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1491,23 +1507,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Block read commands (Class 2) */
-    case 16:  /* CMD16:  SET_BLOCKLEN */
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT)) {
-                sd->card_status |= BLOCK_LEN_ERROR;
-            } else {
-                trace_sdcard_set_blocklen(req.arg);
-                sd->blk_len = req.arg;
-            }
-
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
-
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2306,6 +2305,7 @@ static const SDProto sd_proto_spi = {
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2337,6 +2337,7 @@ static const SDProto sd_proto_sd = {
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


