Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEFC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5h5-0004wv-Ic; Fri, 28 Jun 2024 03:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5h4-0004mb-1u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5h2-0003K0-4W
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so2396675e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558406; x=1720163206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1fY9Hw86o5iLpIx4cOdBUGuwKgpX9A8Bw42XBcw/lnQ=;
 b=KUjcXS86NSJFSfFwmwNDUCO9MFGEVHf9JQU5D+cXqL33mzk+FD8nKtwnKFdsGQQw+A
 zxjc/GbsownBFMw3DLtFOMDpm2rPoRf/J0cSfQ0HU8ST1lS6wqIg76V4JstbhM+8fATB
 wu8mjojWOLUoe7cgpyY4OZgWdIoWQgziBo+k8cJuVwVv9wNAzFvEM+T4/33hyjoenljb
 PQtkZRDvLPrlZVSiLu4kA79DakcWp9htJbxOIyF+RKHkFb/RK6PShb58a73R+iQHK6q1
 HHfJe6XwIllF84FPHY5tM59bYCl/VlOFuuiacpJuitl/zHKnqPC+kyDEkWY6Fc7DtV+m
 WvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558406; x=1720163206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fY9Hw86o5iLpIx4cOdBUGuwKgpX9A8Bw42XBcw/lnQ=;
 b=wozvhbtIZ4YIbTU9F/me+pgFLBhMU56icG1odyOpEQl7KuThWy70cTgQ47nU1QxsaY
 tDQHElqNWKee71nRkYy7f6nDdn6Prh5XyMjjng/P3RBNcx+wZxg1TtFfPHjcr8+CmuJ3
 WOVk/6ud9K+twtZrWKDDqhgeI9RUSEoV8ag0ji58T6pnfEfUSbQ7gwAirbzJHrggIciT
 XE0mKRGoLEujoGDY28PZTugkqymo9j1od5ZuVHzOHiuovXR/YShIs2j5xPYdClEEIugY
 nYXcD8jbCufxDOCcl//fENysN6i891AdSG31W1+M+yKaeqZBysQ/8CcfJFF2/ePrNeTO
 HL4A==
X-Gm-Message-State: AOJu0Yy+RFfZK+j3T2Zmk5fkaWCgtmAMldOtdeWKzaca8a3HjF/WvnAY
 KXCJb4c29IN6t8yZ9C94Vuv0sHHNmf3qjDLeyZXVoQirVZUMIvKaTFYOm6rRQxyBY9832pJmyTw
 a0Dk=
X-Google-Smtp-Source: AGHT+IEKXWvDE4Z2br56xILwRgreFYJ/9ICyAKdzBXRFgds+YM4eK4fPQRDhJi5N8DmC4ghYNaoW9A==
X-Received: by 2002:a05:600c:257:b0:424:a3d7:2a7b with SMTP id
 5b1f17b1804b1-424a3d72b68mr67863365e9.5.1719558406114; 
 Fri, 28 Jun 2024 00:06:46 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af552bbsm21664795e9.13.2024.06.28.00.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 46/98] hw/sd/sdcard: Register Security Extension optional
 handlers
Date: Fri, 28 Jun 2024 09:01:22 +0200
Message-ID: <20240628070216.92609-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

See "Advanced Security SD Extension Specification" v2.00.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 87bfd0fd56..e4941cfdab 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -253,14 +253,11 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
-        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
-        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
-        [50]    = "SW_FUNC_RSVD",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
-        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
+        [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -2269,8 +2266,14 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
@@ -2289,6 +2292,10 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
@@ -2296,8 +2303,10 @@ static const SDProto sd_proto_sd = {
         [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
         [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
         [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
-- 
2.41.0


