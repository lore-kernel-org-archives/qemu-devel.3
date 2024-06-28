Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A300C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gv-0003WF-Al; Fri, 28 Jun 2024 03:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gt-0003Gv-Fj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gr-0003Hf-QV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42565670e20so8341295e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558396; x=1720163196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HjpgRXrOQ8bkyegxRpfboHEk5IA653f08nTp/+XGbbA=;
 b=O7YvU14Mjf2V/s5cEpuocxep1uw03LrTVYBvaaZ962BLHF+IgGr2sfvTX2x5bvImUl
 b4YkN0VLlNOcauZG/yddgVy/uORi8ux8rlIkkXCJwg0LBFINh+PAUeXljXAOsmZHOC7e
 z9OlPBcYsmUiCcHbkqzXkj0rQMkmCGSa9j49dJV9HpkPuyGqfE3IHh9JZCGt2gQaaLds
 Em3PQvIXPPyNMe32qDOQIduKvTsmvUDt3+H/JeNJC4+46gzHZyf7s3ddAxqkljMiSK1t
 rg++yo35/u40uW2QWQkHb7rF6y9ekjdN307DGLa6ECNW6ZGB64df3ADL9zJbp5HcdTMg
 Bz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558396; x=1720163196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjpgRXrOQ8bkyegxRpfboHEk5IA653f08nTp/+XGbbA=;
 b=tcFikYPIiFmdMO7i8g9aGMYlT77MBoZAuuL9l1PpknNxe1YIzlzsaV32nnVTtpKD0g
 /rimhy6S+Knnp6N2PRTY6pqrLuuKUGjY9UZ9tF9xPaM8j58Tm/5f2WLa0qB5SEUm5/Kz
 UyUbgG3XACjLpEirqTBMC/BQYEfQ+ksOJj7fYoKoxRwaN4UwNe9hhuXJgC6WTouqSX3f
 cJFXZIfZghbJslwBwPmdpylDZeW9ZP7Z/a4RPwWme8kjbdv0xtkxjGx9NuqfvSaMD+MT
 El7nmuni1+izMvtHnqJ6hjTT9wMIc+qfRCMipYqkP6NyQ81PsE6OkNHRdCdvPfUayl4i
 pcZg==
X-Gm-Message-State: AOJu0YzS3YFfWYmD2Y5OKNs5W6RZnvGdUGwBgAbmK4yNAyyPUk6JrUTp
 P/nX2wnYdkK9TAcfz1RNoPCD2tJnTWpu5JGPSyB9y99InwsBSy9iMkkSoKoGQ90h3I2OdJMtwzT
 OHq0=
X-Google-Smtp-Source: AGHT+IH3a08kEhFFlfGGBrEjKlt5kuytBAd5MdEQkTxSqLibeqn33NXwj+VYfNpKs3G92jXWmgBaig==
X-Received: by 2002:a05:600c:3d09:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-4256d4c3ed1mr6547415e9.2.1719558396146; 
 Fri, 28 Jun 2024 00:06:36 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1108b0sm1315803f8f.114.2024.06.28.00.06.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 44/98] hw/sd/sdcard: Register optional handlers from spec
 v6.00
Date: Fri, 28 Jun 2024 09:01:20 +0200
Message-ID: <20240628070216.92609-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


