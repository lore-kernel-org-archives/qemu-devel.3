Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC94C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEx-0002eg-Ql; Thu, 27 Jun 2024 12:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEu-0002an-Tc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEs-0008Dh-4L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-425624255f3so9725545e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506688; x=1720111488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsxLv41oI+lmhCr+srqJP++Hluvz2oWQHhnQB9fyk4M=;
 b=dy3eJZB5UuDGbae4hsbuRdObjqZRrRVX7iLSuoKSJyCXOOMoMV+Z2u1qZI5l6WxFW9
 VAuWBUiKeF0Mt1+y1wJBjGm3+j739je8MU1gW7Xdzc1Y1cdbGcyd/COnvv26x0buHnC3
 1eARCQFL8LHTWNKgX1jTKyw3+S4hDV94JwXkX5MHpLV++oByVnPlnwP5osJARx2nmxft
 0qV1++AAyBm0QBiMgxHyZVvD0A3ZK78lOcMaN/yn6OStK77HJ+dbFkJRDGr13dqLrc5j
 9Kz/MkeLNNBCXpunfDwAcSGOWvgjrnwVIIRh/GIQAZBSfCrM3a01lizYetedjYlJMdzf
 9mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506688; x=1720111488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsxLv41oI+lmhCr+srqJP++Hluvz2oWQHhnQB9fyk4M=;
 b=L2QUtENB0aeUY5fmgAU+kAtliVZefJhULfRFOTja0+hzOntSbL9qm/GANghTCCnz1h
 FOEKBfDhd67mKT7SKgtfpGP2FtQTy12r8irN6mn536cNW1NFYa6WivQ3Aan/1f4/qk6H
 5ETqQU9/nS91LtIwgxxFgnWv9I/bS6X3/eedBhkrstowrY6xK2EY3dllqw0s8LgTZpDn
 qQsX6d73Ezq4widHPffi9BYhOShs/OfHqX3UGSzB1Ue7n3RSU4jr8QfYG8fGk0qrgHBI
 njQYk0gpogNSV0t6T/hsOQKUby7TWVBXei+mzAXkCnmKhEtcZVNX3OOfcm/DO5d6vob/
 1hpw==
X-Gm-Message-State: AOJu0Yw0CMqeMIIS81oDSw0PTQWC6f6HhpjDAoM5fjT58tcKxmmqnp7/
 I1v5T50pW1BZXvs3JjFGxRFY4d77+cUVQlF65gPyqrgNjQFjz4ypap8AruvXlw1ka0zTVfigxrw
 xfo0=
X-Google-Smtp-Source: AGHT+IFFPs8bqwNbCaE+4Q2Mmg4JCMHfas6N+kurOKMdIhES3IlvIIEUw3KToXJAiYP+wClxEM1sxA==
X-Received: by 2002:a05:600c:4f11:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-42564377c89mr25554745e9.17.1719506688381; 
 Thu, 27 Jun 2024 09:44:48 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256aed237dsm253045e9.0.2024.06.27.09.44.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 06/21] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler
 (CMD12)
Date: Thu, 27 Jun 2024 18:43:29 +0200
Message-ID: <20240627164345.82192-7-philmd@linaro.org>
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
 hw/sd/sd.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 564e08709b..1c092ab43c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
+                                            [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
         [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
         [18]    = "READ_MULTIPLE_BLOCK",
@@ -1360,6 +1360,23 @@ static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
     return sd_req_rca_same(sd, req) ? sd_r2_i : sd_r0;
 }
 
+/* CMD12 */
+static sd_rsp_type_t sd_cmd_STOP_TRANSMISSION(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_sendingdata_state:
+        sd->state = sd_transfer_state;
+        return sd_r1b;
+    case sd_receivingdata_state:
+        sd->state = sd_programming_state;
+        /* Bzzzzzzztt .... Operation complete.  */
+        sd->state = sd_transfer_state;
+        return sd_r1;
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1426,23 +1443,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 12:  /* CMD12:  STOP_TRANSMISSION */
-        switch (sd->state) {
-        case sd_sendingdata_state:
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        case sd_receivingdata_state:
-            sd->state = sd_programming_state;
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 13:  /* CMD13:  SEND_STATUS */
         rca = sd_req_get_rca(sd, req);
         if (sd->mode != sd_data_transfer_mode) {
@@ -2278,6 +2278,7 @@ static const SDProto sd_proto_spi = {
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
         [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
+        [12] = {0,  sd_spi, "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2306,6 +2307,7 @@ static const SDProto sd_proto_sd = {
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
-- 
2.41.0


