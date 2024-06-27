Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E2C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsHv-0007HO-Lv; Thu, 27 Jun 2024 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGC-0005ha-IV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsGA-0000NT-5I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4248ff53f04so35439305e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506768; x=1720111568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PF/YVa5FANPMIRP5k1k++097xYJKGaWnEtemmw/L2o0=;
 b=n7ygKGp4qVPs1HX5Dj5EWG0whhVVCSO4N4IVLuFhfBlB0TeCChYFBSvbJHEpeWHhkU
 oqABBu2zsnWG7Rl0J728WU/LLi0v+tSR739SpzRNqoPR5raksPOCH3sKbOJA4/1lMTLw
 tMd2YV3BU4M4SSNx3gdUT7CknCgqS4FxqkLzmJqGq8BFygYlsojqRQYvM8sKNzHVD7ua
 bphIKNuk1s3Q3c3ZUAjct+PYrZ3iKchzQBZ/N4Mh87KK/o7RZ1kdmPeLumC/tvQqB76i
 pl/AwLB4gNO1O6/uHy85KqvkcYLP382MZMmN1g6r/nJYczDCNg3o/z2IeKhgofKiQEnr
 M6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506768; x=1720111568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PF/YVa5FANPMIRP5k1k++097xYJKGaWnEtemmw/L2o0=;
 b=bgjGX6Nr/7tHuqTtIbq3YG/wpY/b1E8avWGHjW3gCmJPom5RnG6jcRRLciOKmM4vLP
 FgROurGiIFFll6acKO4BrmLTv/tjYh0K5ZsmeKJ3KPP5oDfIzobQJxBainq+8+9pU+fP
 ncNlY+jqza7o1XkEPFzucVejWGnGzbUaVlsbxU7XrstYlQ7CPLjn+96YrE4yvb0b59gt
 S/kfJ9D7mgapmquv1YBD+Wnx6IuWacn5Ng4XKhi4EC6YhBNgnqdcJ9baBJ9ia1jNjSIG
 PmmXd9bbNzwFJT9vca55PLp5d+Pp+2U2HaOIeT61Z2swsQYZCuo9Fb3/fDVVKzKHBKVE
 q40w==
X-Gm-Message-State: AOJu0YzeBNitCZ/zXsIx+myG2bnfoKRrwRVpbBZRtTx15DPgRUvYlFj7
 n2dEYkBKaxyjhKaIs6JlSCSwfceDNVlRqanwUcEoRxtvsWh1HN6+vqhDJVCQ9gOWxLAYsof1s2n
 KAy0=
X-Google-Smtp-Source: AGHT+IGwfdpxsHRDwgPLQszqf/rH9dbxEKRzhTG1v5PmX+d0oyjpn81tTf+4dyQBlVv9qg+K/yhoOA==
X-Received: by 2002:a05:600c:4c06:b0:424:a822:7846 with SMTP id
 5b1f17b1804b1-424a82278e7mr47403555e9.28.1719506768292; 
 Thu, 27 Jun 2024 09:46:08 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc59f5sm36290285e9.42.2024.06.27.09.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:46:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 14/21] hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT handler (CMD30)
Date: Thu, 27 Jun 2024 18:43:37 +0200
Message-ID: <20240627164345.82192-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/sd/sd.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a63213613b..bf9975e9b1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
@@ -1561,11 +1560,33 @@ static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
     return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
 }
 
+/* CMD30 */
+static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+    uint32_t data;
+
+    if (sd->size > SDSC_MAX_CAPACITY) {
+        return sd_illegal;
+    }
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "SEND_WRITE_PROT", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    data = sd_wpbits(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
-    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1650,26 +1671,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Write protection (Class 6) */
-    case 30:  /* CMD30:  SEND_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "SEND_WRITE_PROT",
-                                  req.arg, sd->blk_len)) {
-                return sd_r1;
-            }
-            data = sd_wpbits(sd, req.arg);
-            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
-
-        default:
-            break;
-        }
-        break;
-
     /* Erase commands (Class 5) */
     case 32:  /* CMD32:  ERASE_WR_BLK_START */
         switch (sd->state) {
@@ -2313,6 +2314,7 @@ static const SDProto sd_proto_spi = {
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2353,6 +2355,7 @@ static const SDProto sd_proto_sd = {
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


