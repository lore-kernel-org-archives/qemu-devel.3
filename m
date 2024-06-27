Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95116C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsAi-0004OR-Nq; Thu, 27 Jun 2024 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAh-0004C1-7h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAf-0007J0-CZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-424adaa6ceeso16687685e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506427; x=1720111227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjpgRXrOQ8bkyegxRpfboHEk5IA653f08nTp/+XGbbA=;
 b=EXwZ0GPjC8Pl3xdRMuumsXoGHLMNptZHhd/gkdHU/+QFJuxnjH8Ivlg5wshnyQZwAf
 If4C7yIi26V+tgDMLfbjtzzILTZo/2rnBsV1cAPCYj77qTe5b++HREzx4IGijKHO8FaQ
 LXeWOSujXbyXGaYePYRw/SaOTXFdtP0Lgyg0Wxkq7VLdgJ1hRT3zUgQx4NIjSndBmm3v
 0dL99WjX5RtfSGplUc4FUNS2XF+fTJGZgV3HCE/XSmpXVw6Iw56YzEEunAH9BZm4Lyf8
 Ra82JZYRmTxnLz+u5xyOIOsvjLnfOaWLwgCH7wGXShB4yyobCJTbj0gV3fOFL7mpSgxT
 itSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506427; x=1720111227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjpgRXrOQ8bkyegxRpfboHEk5IA653f08nTp/+XGbbA=;
 b=Fg1i47YUlarhgOMX7L9g5V4V+aPDUzlW5Ohtckt+kttVqfLRDKJAYQno/vQnGb4MNS
 XrHLCIBjcOtPmORJhh+erMbDSX+5vEWRRnOlBolgbFOBLBKdiqNBbqAe1SkAoc0vBjst
 aB+vOniYHm4JsFBFQ+TuXG1oAoV5ggszhmsnVYCJCA9zMAQ1f0uz5Fv7c2F0iE4bXCOo
 6hsLtF7uMBgeIrGkD6T8/mdrHkicI3Wodu3ZWA1Ra7SDw97keq9t8wJb238jm6ilhDG0
 /NlKualyqmw3+qS9TWZU/H+7M9oGsA5w1kcD0aoeNbo6zDao/9xqAtB3RqPH6xe8+3AI
 fUlA==
X-Gm-Message-State: AOJu0YwbCY9b5vID8z8OcA3x/cvNGEPtbQqq9a/hSddlfO9v6Nja+h6h
 f5+c1P2WsPSN6BYurhSe2jihNaQr31cNMA7dZ5jI/kjeM9wfmoknbhDdQK9mGUDTBnwUHjyFDGy
 dlcs=
X-Google-Smtp-Source: AGHT+IE37qh25axZ4lkptls5MsV0ofskVlBhbm4NNT8UrY+LvZiH3JPSBvRuWxCzYLqkmbrypFDyuQ==
X-Received: by 2002:a05:600c:2d55:b0:424:a319:6b46 with SMTP id
 5b1f17b1804b1-424a3196b9fmr52640135e9.18.1719506426883; 
 Thu, 27 Jun 2024 09:40:26 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82515a1sm74632735e9.12.2024.06.27.09.40.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:40:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 09/11] hw/sd/sdcard: Register optional handlers from spec v6.00
Date: Thu, 27 Jun 2024 18:38:41 +0200
Message-ID: <20240627163843.81592-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
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
 hw/sd/sd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 74aa38a442..406fadb3b4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -258,15 +258,11 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
-        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
-        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
-        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
-        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
+        [42]    = "LOCK_UNLOCK",
         [50]    = "SW_FUNC_RSVD",
         [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
-        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -2291,6 +2287,15 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
+        [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
+        [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
+        [46] = {1,  sd_adtc, "Q_RD_TASK", sd_cmd_optional},
+        [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
+        [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
+        [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
+        [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
 };
 
-- 
2.41.0


