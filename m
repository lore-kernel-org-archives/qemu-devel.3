Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80891C30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOR-0000op-Ds; Tue, 25 Jun 2024 02:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOP-0000gu-5q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOM-0005eJ-Lp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so14996465e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295856; x=1719900656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXyQ3ONsL6quYLnxVI/IWP+VnsFMKTPDSRWLpcs4CQU=;
 b=OerGHbpWiNXKdkfeK2U3ADPObM4NAF5xbI+0WTHssPGw4YGD7287cB6T4CPxsBCC67
 TY+Yk5mliZEvJr8jfcI63zkp5WAnohNvEMlUj3jyFRt1zUM9V3PsvLt/VLN8oHuAUDH+
 dtd7nArmYrVMhcMjUKfcecKtqGg1UtDaWfWCheqIsINncFdRje1p+LJIUAU7j5WD6Vrf
 BUZIt8K12kQZj5elSxksl6nD6Fxd3gILvKHluLBilCQuyMqyglf0wzO4Wh0PvxDkfWtH
 VT2oFO/DEGOt6RE2DDt81HZa8zEDLD/QMmVLJOW7c/x9jpLKawSqmxpmC1revtJU8Nt/
 1R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295856; x=1719900656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXyQ3ONsL6quYLnxVI/IWP+VnsFMKTPDSRWLpcs4CQU=;
 b=licyLiFetNF0hA2MD0r6x2ajHpgKuW2Goi4wYY363IWfAlnCaFOrna4Z/l29snZi2V
 1SxdiSZVg3v8p6m1DtiWTeBObHWO8ygvOB6t7STvf2eYCw+jrMVixwqQI2TUPo3V6B3c
 aiQLj03MkWT+T3fAtWzgi0/WG/ZE7zvKm5DYpc/ZBh1iqADadHxbibDnpiXswuiTp7Tb
 c3HQap8/pCkVin9WuPNqR0+qLtyxevPMRnOALR46B25oSkBHNvKzJ3Jacw33D5DLql3y
 /QMEJanqeDUy7SOUHTI4A6VKvUxyDue7kW0PtGnGD8JfhtTRzh5ZDdIoZjo/shiEfMJB
 w2Kg==
X-Gm-Message-State: AOJu0YwWGivix9f05DCaPptA5tyz0aXzgDMOn2fePcTrJyAvXSVxCVuo
 N+J2CrNhDZj/UBFs7PWhupGN9MYCkKHcjDRp8L3dINOkxSvlSrWKMYh2Jh+HAKm038HpLZqL5hR
 U
X-Google-Smtp-Source: AGHT+IEeP6vXgX7kWodfbA84GR+VUyOqEENlgcX2yFTSmxXWIawuvpEiZ6Ds0VkcpiglO862xihA7w==
X-Received: by 2002:a05:600c:434c:b0:424:7e68:99ff with SMTP id
 5b1f17b1804b1-4248cc2a78dmr50826455e9.15.1719295856204; 
 Mon, 24 Jun 2024 23:10:56 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424819224fasm163677795e9.46.2024.06.24.23.10.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/11] hw/sd/sdcard: Convert SEND_TUNING_BLOCK to
 generic_read_byte (CMD19)
Date: Tue, 25 Jun 2024 08:10:10 +0200
Message-ID: <20240625061015.24095-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
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
 hw/sd/sd.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6af7b3f034..3d341495e9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -562,6 +562,21 @@ static void sd_set_sdstatus(SDState *sd)
     memset(sd->sd_status, 0, 64);
 }
 
+static const uint8_t sd_tuning_block_pattern4[64] = {
+    /*
+     * See: Physical Layer Simplified Specification Version 3.01,
+     * Table 4-2.
+     */
+    0xff, 0x0f, 0xff, 0x00,     0x0f, 0xfc, 0xc3, 0xcc,
+    0xc3, 0x3c, 0xcc, 0xff,     0xfe, 0xff, 0xfe, 0xef,
+    0xff, 0xdf, 0xff, 0xdd,     0xff, 0xfb, 0xff, 0xfb,
+    0xbf, 0xff, 0x7f, 0xff,     0x77, 0xf7, 0xbd, 0xef,
+    0xff, 0xf0, 0xff, 0xf0,     0x0f, 0xfc, 0xcc, 0x3c,
+    0xcc, 0x33, 0xcc, 0xcf,     0xff, 0xef, 0xff, 0xee,
+    0xff, 0xfd, 0xff, 0xfd,     0xdf, 0xff, 0xbf, 0xff,
+    0xbb, 0xff, 0xf7, 0xff,     0xf7, 0x7f, 0x7b, 0xde
+};
+
 static int sd_req_crc_validate(SDRequest *req)
 {
     uint8_t buffer[5];
@@ -1139,14 +1154,9 @@ static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
         return sd_cmd_illegal(sd, req);
     }
 
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
-    }
-
-    sd->state = sd_sendingdata_state;
-    sd->data_offset = 0;
-
-    return sd_r1;
+    return sd_cmd_to_sendingdata(sd, req, 0,
+                                 sd_tuning_block_pattern4,
+                                 sizeof(sd_tuning_block_pattern4));
 }
 
 /* CMD23 */
@@ -2078,20 +2088,6 @@ void sd_write_byte(SDState *sd, uint8_t value)
     }
 }
 
-#define SD_TUNING_BLOCK_SIZE    64
-
-static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
-    /* See: Physical Layer Simplified Specification Version 3.01, Table 4-2 */
-    0xff, 0x0f, 0xff, 0x00,         0x0f, 0xfc, 0xc3, 0xcc,
-    0xc3, 0x3c, 0xcc, 0xff,         0xfe, 0xff, 0xfe, 0xef,
-    0xff, 0xdf, 0xff, 0xdd,         0xff, 0xfb, 0xff, 0xfb,
-    0xbf, 0xff, 0x7f, 0xff,         0x77, 0xf7, 0xbd, 0xef,
-    0xff, 0xf0, 0xff, 0xf0,         0x0f, 0xfc, 0xcc, 0x3c,
-    0xcc, 0x33, 0xcc, 0xcf,         0xff, 0xef, 0xff, 0xee,
-    0xff, 0xfd, 0xff, 0xfd,         0xdf, 0xff, 0xbf, 0xff,
-    0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
-};
-
 uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
@@ -2120,6 +2116,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
+    case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2154,13 +2151,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
-        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
-            sd->state = sd_transfer_state;
-        }
-        ret = sd_tuning_block_pattern[sd->data_offset++];
-        break;
-
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         ret = sd->data[sd->data_offset ++];
 
-- 
2.41.0


