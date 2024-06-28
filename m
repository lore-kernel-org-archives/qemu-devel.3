Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65658C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5eQ-0001aV-NB; Fri, 28 Jun 2024 03:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5e8-0000t6-T6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5e5-0006mk-5P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so2473335e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558223; x=1720163023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ra/Td8NG8gR6eO/UQBLHxrI5ovJA5Z/mboPyl147upk=;
 b=QOi3dwCNnD9a3DCjeQEVhrciS46U2rYCzSt3BxgbDGB7q+gsjpP1lihBOinUH+VQpv
 T09eX100C7GZKMpBRcIDeWh1/HJFYAiySwKGysA2i9jH/f6UVCUp9XUaJxjtFOTAPbEA
 JtdMg6zA9Wj0QbfCQyBLTCA7OBQCVXAhq8DPLj1PkNTtNHRIkmIBVS4pqwzQwBkGssIi
 h8OegKsWqG9EqBzlNL7mjS/Kp4ZU3yuHGKA+8+HXbLuAQIVy63DgADUaX64+TWbGrg1w
 vJFZDIc2jug2vbsB0UwXDqskVFQcJfahXdF/kx6Cqki0Dvo37wJBoqiu+JApqN2+G6U7
 Tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558223; x=1720163023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ra/Td8NG8gR6eO/UQBLHxrI5ovJA5Z/mboPyl147upk=;
 b=LVn+Ypb8DMLtWRUPm7ww5ByeGaE64daE/7i7+d15P+C3OIoYqHsWYEnRTYhxKERPjW
 ToO7x7q0RkFkN9JqhOPX2661Qo3j1WPOQFqyOcmgsPoy1VMAnZLBRAYu/bTkiwgwZoER
 w0ybzjtjuUJZjn0xZH087CQTTcRwEaOUrDy02GMQNpHtIx7FTA3XxuzUi15E5amwB8ZS
 8wWX94vJGlPLsSMZq0ZCroHrNMfY3KEXEVXyZqkR17/SHLZmp8FYbSs+tMSYKjpD3YT3
 40Mm5zaqrG+SjNYevu7u9gg3Pik/2yXWTqYmffemjFwk3nvDhJWXhl2wfKhlUhawfDVo
 uGsg==
X-Gm-Message-State: AOJu0Yzm6+sovqz0hu3Eth3wm70F7mMfJSJMRUGWEcHEugpvHVaYp8NY
 6G3vqFcpC46TdLXnzsZAbeZKZlwy4c8AN5jt/8ZZfBFTPrWAtjgzEc/yenNAWmCiqwdO084+YU0
 pR/Y=
X-Google-Smtp-Source: AGHT+IEW+FXycNKZ0YUCbmKShkEJhZRsfSLxk73JI61RrH8ZO12nQY9h/xBGuxRx4fQegwQWjgtEow==
X-Received: by 2002:a5d:58ed:0:b0:362:f291:6f97 with SMTP id
 ffacd0b85a97d-366e4ed2eb5mr10668832f8f.18.1719558223252; 
 Fri, 28 Jun 2024 00:03:43 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba4fsm1324067f8f.85.2024.06.28.00.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 16/98] hw/sd/sdcard: Generate random RCA value
Date: Fri, 28 Jun 2024 09:00:52 +0200
Message-ID: <20240628070216.92609-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Rather than using the obscure 0x4567 magic value,
use a real random one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c         | 11 ++++++++---
 hw/sd/trace-events |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5997e13107..d85b2906f4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -46,6 +46,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
@@ -488,9 +489,10 @@ static void sd_set_csd(SDState *sd, uint64_t size)
 
 /* Relative Card Address register */
 
-static void sd_set_rca(SDState *sd)
+static void sd_set_rca(SDState *sd, uint16_t value)
 {
-    sd->rca += 0x4567;
+    trace_sdcard_set_rca(value);
+    sd->rca = value;
 }
 
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
@@ -1113,11 +1115,14 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 /* CMD3 */
 static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 {
+    uint16_t random_rca;
+
     switch (sd->state) {
     case sd_identification_state:
     case sd_standby_state:
         sd->state = sd_standby_state;
-        sd_set_rca(sd);
+        qemu_guest_getrandom_nofail(&random_rca, sizeof(random_rca));
+        sd_set_rca(sd, random_rca);
         return sd_r6;
 
     default:
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 43eaeba149..6a51b0e906 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -43,6 +43,7 @@ sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_reset(void) ""
+sdcard_set_rca(uint16_t value) "new RCA: 0x%04x"
 sdcard_set_blocklen(uint16_t length) "block len 0x%03x"
 sdcard_set_block_count(uint32_t cnt) "block cnt 0x%"PRIx32
 sdcard_inserted(bool readonly) "read_only: %u"
-- 
2.41.0


