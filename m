Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E140C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrwq-0005tA-1x; Thu, 27 Jun 2024 12:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwh-0005d6-Un
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:26:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwf-0002j6-PP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:26:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso65005565e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505559; x=1720110359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ra/Td8NG8gR6eO/UQBLHxrI5ovJA5Z/mboPyl147upk=;
 b=pPa+hjsqUuQnpThuuiHvwrVcrFZrth8o3ViEH5sY8OQAeJtfHHghD8g+E79GiiNFAp
 iDZSXyx0cO9MDUXU3VErh/UgwH/qwq3tsrNgU0GoP3iQz0dXLpU0AxYAsCxCaGTaZF/3
 KfPIRFpYVD3hJfDmcYHOVWzI+Cyfk6hKAU5/iCcxAbAnP77q0/VM0yoFOXxsuNLH084/
 vN04xHepoCyyaueGRHHVH4ZX+57TEXFU2e4eG2A+Joc0+aQQ1SNXx37VoscYzMYpK+Gi
 E0HDMdPvU8nG3nwhY8Tb/SALzu4nTM9sl40EbEujaFzL7rTs2zYD3LAxV7GxYlM4fNS0
 qqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505559; x=1720110359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ra/Td8NG8gR6eO/UQBLHxrI5ovJA5Z/mboPyl147upk=;
 b=jFG91XiZAhQW7mruBLRz/8W3ThulO2bHIOgTh6JOw+oAnBbrW9PGxTNna1rbgmW2IM
 f/jhyRhuPzWRzXqJNN3RRhoztYWkCuD6+JHPStCYKc7M/ULLOZFl3gAfdU56QVXZGASJ
 UcsK28/YyHp9gnPiWZwjcjaHrohqWCvrHfn4Pv0k10Gkd6RZfRT3y+CDz/ZstvACPU1l
 rvGMfohvexR6ncNe/AyknqyCxb9SPhZKulf+C7XwidD87f0J2rp4eRuV7xWGxj9qQbYB
 7jL/7XQSp416pGHTmr5BSJn75QzBl9UW3v6eLxGU5j/HOY0a5f4UP2zSz9dCoiH9PjAi
 Chtw==
X-Gm-Message-State: AOJu0YxQt2z6L4457zvgkLGD7Ww7dTb0Rg8llK45Xm+uEvHkPm3T+RKa
 YkzGo8uA4XjXCB0S8BT+CrY3aJ207IGE+UDq1q146tKHb57uYxY/4+mNC+5wDpJd6vW9gtCr/Pj
 catI=
X-Google-Smtp-Source: AGHT+IFHm+PkfXUCR4PhH/RkSTaGhHpE9lLURgg9hGE0ArDfmx4G5eQ0pJJ390kDs6wsptoqWeh/0Q==
X-Received: by 2002:a05:600c:3c8d:b0:424:8ef1:816a with SMTP id
 5b1f17b1804b1-4248fe36550mr88926515e9.5.1719505559497; 
 Thu, 27 Jun 2024 09:25:59 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84248afsm72601705e9.31.2024.06.27.09.25.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 16/17] hw/sd/sdcard: Generate random RCA value
Date: Thu, 27 Jun 2024 18:22:31 +0200
Message-ID: <20240627162232.80428-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
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


