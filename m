Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3838C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZnR-0004aY-0N; Tue, 02 Jul 2024 05:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnP-0004Mn-4P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:31 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZnN-0001ei-Co
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:27:30 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so51865291fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912446; x=1720517246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTcgACkHrUOF7g7c1kRdnSX6PuMfUGO+Z91pQ+u8tPQ=;
 b=z46SGOouEiNw6H4liYi/Cz1aZzyjoTbeT4AxoY+XhlER+Lllf1Ob6FsSpvWsNSsX0j
 2IzHoVsEUFc+Cf5f+0NyfS7YhAL0AnNjAc1zJcLGOumr4vsl35AkzlemTqJl2WSg5DCo
 bPcbonWMZSUHdHFDhzzhL5WXzIHoLpcTFxw6RCvuusFKdbjvOziHR5LCh2i6X+Jz4o19
 FxbZJ+nOVUve2m7ZoMpwTzQuJyV/E5spcgphVbEywHzqo9JhvQfnZnrWJ63erFFO1fL4
 LIu1PH7Ad/yi+YEYqtB/WchGOvES6Ku6iP3oKaRh37L6m9Y1xQnH/s2xhlh/G1Fmcafq
 bayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912446; x=1720517246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTcgACkHrUOF7g7c1kRdnSX6PuMfUGO+Z91pQ+u8tPQ=;
 b=dknwdJniPTG3jiJe8fVnUdwx2Cx2dM8uOmJ59C96ExnqhPBksYKvNNfY9rTKl4R04n
 RRuw2ij9sgeWb+4UwGu12OworXjrVegwrTIqiSiKoIsISUteSkygL1Wc3Yw/To+YfQZT
 G+cBznc4VYO4I1HAlFc7T8enmkzMY4HLr1v2A/vn9PHow8N9QGOI7hf1LjlzL4cfbgEf
 xPYtTvXtyPHT7/iw4Sok/2bG4KvuYMwsbzJ4nVGvF++OIDaHJ4TM+/YlhZjds5qiOim5
 zg946if3EZLgQJQUdojDo7COWVZB1921G+FNbXxuJ37udBR8+Y3bve0MN40Y6Qt8PRC/
 WvvA==
X-Gm-Message-State: AOJu0Yz/Qm174eS9P31ByEcZ/GKI351updZRq7zKTk4W8fli/5vBCM/H
 MqKTt8pgnTQJxiYwynbJ7VBz2YvgDnBBOhLOw5Ok3ncfpRRxbPAhuMusEMHgSFDQWDUMzdlNAxT
 I
X-Google-Smtp-Source: AGHT+IH3w3f/eED3Us3i4A4VEWmEXfaMAHQqaoOJ5jR83tYA0xsvjDeOhkYJrqY8KCKlY7C1hsDXMQ==
X-Received: by 2002:a05:651c:b14:b0:2ec:5488:cc9e with SMTP id
 38308e7fff4ca-2ee5e3bbd14mr65967521fa.26.1719912446481; 
 Tue, 02 Jul 2024 02:27:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d0d38bbsm106947395e9.38.2024.07.02.02.27.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:27:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 67/67] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
Date: Tue,  2 Jul 2024 11:20:50 +0200
Message-ID: <20240702092051.45754-68-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-75-philmd@linaro.org>
---
 hw/sd/sd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 698d64d2cb..552957b2e5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -261,7 +261,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
         [14] = "DPS_spec",                  [15] = "DPS_spec",
         [16] = "DPS_spec",
         [18] = "SECU_spec",
-        [51] = "SEND_SCR",
         [52] = "SECU_spec",                 [53] = "SECU_spec",
         [54] = "SECU_spec",
         [56] = "SECU_spec",                 [57] = "SECU_spec",
@@ -1739,6 +1738,12 @@ static sd_rsp_type_t sd_acmd_SET_CLR_CARD_DETECT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD51 */
+static sd_rsp_type_t sd_acmd_SEND_SCR(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1863,16 +1868,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 51:  /* ACMD51: SEND_SCR */
-        switch (sd->state) {
-        case sd_transfer_state:
-            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
-
-        default:
-            break;
-        }
-        break;
-
     case 18:    /* Reserved for SD security applications */
     case 25:
     case 26:
@@ -2333,6 +2328,7 @@ static const SDProto sd_proto_spi = {
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
@@ -2393,6 +2389,7 @@ static const SDProto sd_proto_sd = {
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
         [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
         [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
+        [51] = {8,  sd_adtc, "SEND_SCR", sd_acmd_SEND_SCR},
     },
 };
 
-- 
2.41.0


