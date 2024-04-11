Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07DFCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurV2-0006L0-6i; Thu, 11 Apr 2024 06:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUO-0005Mx-Qe
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUL-0007bt-Fn
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4166d6dab3dso30487475e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830620; x=1713435420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmrbaiUVNJN3VwkspX6n0mLGveiY6Yl+m30htubqYrE=;
 b=EyltW+PiE5hSLlX2UuetygNo05dn8PsOOZbqMiH1mnJsDKwpR6vTwEk/aTNKArABid
 lCnMz7N6gBeNu0XoypaS5H0ZcqnnGsRMhZUIDGKTjIySrm9fh52YtiTLgkqzNm4PazAq
 RbsQw2TJLCKcOtbTJA/EuL8IUfK9TEzXr7jK4NHWvBYNrYiVUc6fzoGtGwteRvO7+9xi
 mXrEaVG5zIswp0+PrLLYwEJ/sWuYSyqi48gkGkcwC7fxCD2H1ye5jSzdSfz283YwtERt
 9M7Sb4zn4yhlVEKdOzLsQhEJ9Ace4jHwagOFJBnqP6D+mY9jBYJFb4zjwvo7qRADgpxp
 cSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830620; x=1713435420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmrbaiUVNJN3VwkspX6n0mLGveiY6Yl+m30htubqYrE=;
 b=dpUIq0EU2pQ8NhPASAxE/wuL+F6YGEnQlEPYOHwWN6tf6WUjfANqTfiGS67QNKwRCO
 L9eWT9SyjGVDYUBWQ4CEBCcmf+S1azlOFLg9u+o/FRCnypv+MGxtCouaLUxESglTM+sm
 6fFGEg/QX3IzXO52YdbyDqA+n+S0ehdqgNZepFIDzQMKjZJJne8VEW9TcOg8Q8ivnoGb
 YbLhoYU+p/vXhR8brz6ffsFRZDueb3DOH7hFnBNHIeo/HjvG9fiQWIgiviCXyjQgXOhZ
 KRzfhzSrdLRY8MjuB1mTWgHOQLdCW9WJqIJN1xcFZlyEgBysXIyL+HRuNGwpw/AeWsSc
 Lcpw==
X-Gm-Message-State: AOJu0Yym+Gp/JKTJwdAMxJJR1rYFzSCIofa4jDZyOx7aCuQprpYufLtI
 jopbn6EN7WyAlCwFI0ixLyRVkVwytdVVitSrkAOhzPrwTR8pnB9AOBO9R0q1ZygSP7QFm5oO/fl
 Lq9c=
X-Google-Smtp-Source: AGHT+IFXLv0ASRMRLdsJjssjwNkq+9txaUqFen8WSbfh7/sNPTJbXJZBo9+Oo4T4t5k0b4nenrVjOw==
X-Received: by 2002:a05:600c:4e88:b0:414:93df:bef1 with SMTP id
 f8-20020a05600c4e8800b0041493dfbef1mr3460478wmq.39.1712830619724; 
 Thu, 11 Apr 2024 03:16:59 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 bi8-20020a05600c3d8800b00417e184dacbsm791877wmb.25.2024.04.11.03.16.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 11/13] hw/ide/atapi: Use qemu_hexdump_line() to avoid
 sprintf()
Date: Thu, 11 Apr 2024 12:15:47 +0200
Message-ID: <20240411101550.99392-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  [1367/1604] Compiling C object libcommon.fa.p/backends_tpm_tpm_util.c.o
  backends/tpm/tpm_util.c:355:18: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            p += sprintf(p, "\n");
                 ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/atapi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 73ec373184..27b6aa59fd 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
 #include "scsi/constants.h"
@@ -1309,12 +1310,7 @@ void ide_atapi_cmd(IDEState *s)
     trace_ide_atapi_cmd(s, s->io_buffer[0]);
 
     if (trace_event_get_state_backends(TRACE_IDE_ATAPI_CMD_PACKET)) {
-        /* Each pretty-printed byte needs two bytes and a space; */
-        char *ppacket = g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
-        int i;
-        for (i = 0; i < ATAPI_PACKET_SIZE; i++) {
-            sprintf(ppacket + (i * 3), "%02x ", buf[i]);
-        }
+        char *ppacket = qemu_hexdump_line(buf, 0, ATAPI_PACKET_SIZE, false);
         trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), ppacket);
         g_free(ppacket);
     }
-- 
2.41.0


