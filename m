Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C83C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5iw-0005Zy-J2; Fri, 28 Jun 2024 03:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ic-00059a-6W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ia-0004Pi-Ap
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-424ad289949so2345635e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558502; x=1720163302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F6oigTn0Q2A4tjfIsZSpx2Wne2arec43lvnPbuSKAbM=;
 b=OnJjYbSpN+VMgPgu0odyyb7Co8YDrJHKlzfMm1CDOE2SPAb5ZcGf6gcLPrkX2j9iu3
 hkLP1eVRCT1+4xeaIg4Ay0jtT3dOWirIDhicTiuF02kPe+0D6hUGArAtwWncW1AxxdFD
 +r6px/gMfLZ77hsvJMEhKnpmksFHS1/AMhgtBXsgmTDz7eHbALsZlmcsL3dW1WF7l78q
 rQBVEHnMYoqwUut3PR+CTc+O3FQM3JH4NyexwsDlCAGgkkZpqEIcLPOIrNQ5uVfAEg4W
 0DOZDrS4fHl6W8qk8vI2H7DxcyQEyomvq6uGFeT9k+sRRGvTzJI+JMs3Om5FgysDSpR9
 DhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558502; x=1720163302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6oigTn0Q2A4tjfIsZSpx2Wne2arec43lvnPbuSKAbM=;
 b=vI4xm/AXUknbjIIYSO2sQdH+dIM+4qHPgyfhMY6ST7sJ0xdiLPPAJGczCx295oN7Kn
 PyV7gPJMtJM7rsJs7vRolfjyKuWjkS/npDoB6D8LW/gWn9uXR0smExe3j+qNv2vmIhtI
 +Zf1KCkYrUgpI5S/Omcva+NIpN0rMhWB0PD5Xjx05bJwoenfPG9fYvW0En2FAttYCS86
 xiuS9xEu3k+h4EgLHZ/QgmHrD5lTfhd/XcJ9ScTzDnbWVehCaBEjjX0Krh1xAipNoUjl
 /Yf8JHqv6eYKgpMrWYYEmVllL4Db/R/+TVfeKIeVIV03Ve7wRI5p0LBR5E8GmFx9E1S7
 Kz2A==
X-Gm-Message-State: AOJu0Yx8wCfVkyThGARmHeDILBsCIMrpcyiVfdql6vLS10u+ANJ1YJy0
 wjBwqeFSIxWnKbfRBNerreKJVn26pZVaMv8de0SCnUDNOS2PgYQ6wZ2pebyr0azaVyaZXh1wAe2
 vK00=
X-Google-Smtp-Source: AGHT+IGpvi2aP6FLbqbnYe99IKZldTICXHBP3zC3x3cufQZ4QdAXDcXRrQrHl9v+g8E5YygJ6f8ydA==
X-Received: by 2002:a05:600c:1c90:b0:424:eeca:6bd0 with SMTP id
 5b1f17b1804b1-424eeca6c69mr44430225e9.13.1719558502449; 
 Fri, 28 Jun 2024 00:08:22 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd72asm1340694f8f.10.2024.06.28.00.08.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 59/98] hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT handler
 (CMD28 & CMD29)
Date: Fri, 28 Jun 2024 09:01:35 +0200
Message-ID: <20240628070216.92609-60-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 hw/sd/sd.c | 91 +++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9d33113f11..a63213613b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
@@ -1520,6 +1519,48 @@ static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
 }
 
+static sd_rsp_type_t sd_cmd_SET_CLR_WRITE_PROT(SDState *sd, SDRequest req,
+                                               bool is_write)
+{
+    uint64_t addr;
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
+    if (!address_in_range(sd, is_write ? "SET_WRITE_PROT" : "CLR_WRITE_PROT",
+                          addr, 1)) {
+        return sd_r1b;
+    }
+
+    sd->state = sd_programming_state;
+    if (is_write) {
+        set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
+    } else {
+        clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
+    }
+    /* Bzzzzzzztt .... Operation complete.  */
+    sd->state = sd_transfer_state;
+    return sd_r1;
+}
+
+/* CMD28 */
+static sd_rsp_type_t sd_cmd_SET_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, true);
+}
+
+/* CMD29 */
+static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1610,50 +1651,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Write protection (Class 6) */
-    case 28:  /* CMD28:  SET_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
-    case 29:  /* CMD29:  CLR_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 30:  /* CMD30:  SEND_WRITE_PROT */
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
@@ -2314,6 +2311,8 @@ static const SDProto sd_proto_spi = {
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2352,6 +2351,8 @@ static const SDProto sd_proto_sd = {
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


