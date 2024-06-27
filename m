Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3197C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsEk-0002B2-OG; Thu, 27 Jun 2024 12:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEj-0002AI-M5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsEi-0008CW-1q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:44:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so65655415e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506678; x=1720111478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/Bi9vrwnFZ+zmmMgAN2Gfm5YG78pw+o1VPUAn34pig=;
 b=Co8Mx0QEPef7SgA6w0wRk1+trpAJ55gaKcsKDEtur0k0LZ9UdvnCgcj8WdivxhOw91
 l9Tou8Jrqg3tHiTMEUfrD0M3OYpNUnEhB8/mMKK6ZGL4F3d0cgdbK0jwX/I2s7uMqWMA
 wPeLmXcco0ZCOaEYqjrWv+pyC+H8ywk9vLu9hp/BCLyJAVP014WpuEXXt91NZZ18oY3x
 SkQD/lvOk2vcOUDUUlleoO+UoUzSsyr0kfGBV7xyzN0E/59gU697xDCEox/UbGul9l3s
 /xz4k+siuhlOp9xXzxVHKfJ3JUHlZnnUIWvorRKMpMq4VmGpqGN9BqFDU0ewLtPmBpc2
 7ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506678; x=1720111478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/Bi9vrwnFZ+zmmMgAN2Gfm5YG78pw+o1VPUAn34pig=;
 b=ZSpPae0ArmyMSLy/kqT2m5SsNU8GPtbTmU+zE6RRRpmqLPgyeu77+lEK5rVzvztdFI
 X0SC9aClTcn84ocUXrwfmkV70EFw7u+uS6JDCq8ccAYBIVan+WCtFtTNlJfG+Wl/rJPa
 ao0c1YUMij+qWi63Nu9uMCMMvrmzwGG9RIFWLf8822bX9qvDkgM6su4G0ND8pMu0ZkeV
 WAFyqwp1sF3OPCHs0gA5vCMAf7M0ajVGYeXTHYBJfuT9rugjHBt+knx2ZY3g5gW8AUWw
 hE8Eih4Qp1pkbt+cJKbtUOQLin9VyO/rBeokeuWIaNlngJLi7niM8Vb+Fcy9OZlKdO/v
 XBLA==
X-Gm-Message-State: AOJu0YzjVze2Byyjz0nTZfR0PRobCG+SvjIKC/M8Pr/f2D8BkjNDL4ph
 3NvSdU3rvawgPyOD/gD+Z9qV0KgmerEqJVb8Ky7CMJM/7gjFpwiMPTzit9jTu/7Xmlmwljc80Fo
 cShw=
X-Google-Smtp-Source: AGHT+IGo+iurNMuugMYHcDNaCgEQVKpZ/2peMUXFTbfmO95K3zjPGfNhhMu+ZWR54DDEZGvSGffRnA==
X-Received: by 2002:a05:600c:a:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-424ad146e41mr34593085e9.8.1719506678429; 
 Thu, 27 Jun 2024 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564a4daeasm36031835e9.10.2024.06.27.09.44.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:44:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 05/21] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 &
 CMD10)
Date: Thu, 27 Jun 2024 18:43:28 +0200
Message-ID: <20240627164345.82192-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 hw/sd/sd.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd7c7cf518..564e08709b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1323,6 +1323,15 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
 }
 
 /* CMD9 */
+static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->csd, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1333,6 +1342,15 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 }
 
 /* CMD10 */
+static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->cid, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1408,36 +1426,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 9:  /* CMD9:   SEND_CSD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->csd, 16);
-
-        default:
-            break;
-        }
-        break;
-
-    case 10:  /* CMD10:  SEND_CID */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->cid, 16);
-
-        default:
-            break;
-        }
-        break;
-
     case 12:  /* CMD12:  STOP_TRANSMISSION */
         switch (sd->state) {
         case sd_sendingdata_state:
@@ -2288,6 +2276,8 @@ static const SDProto sd_proto_spi = {
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
+        [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
+        [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


