Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE39CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaUf-00022j-Cy; Wed, 10 Apr 2024 12:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaU2-0000jQ-Po
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTy-0002nw-3i
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51beae2f13so504833566b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765248; x=1713370048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeYRJP22yetpo8HRu7YHvf77//gfViY+eu8d75tRzXk=;
 b=b7WGxMpvUr/7JNYG7q1dBqA/OJlwdZUXwVuWRnxSxhnn3lgpettZWZSMLCgJiKqhGa
 C39tTzpF6U3NpH+dk3hs9Yem9VUGa8qlvLGQ+hBGB4S0gS2OXnoLGngUToPFUbuSEe2x
 It6Kv6qQMJ3n7QsvBkowxAc43a6K3smjB4PC+Sgwye4YtLa7O1BdhCRy0HX4Rq0G2QtZ
 pcSA0Ie3T5zZpDKP+Vezp8hup5koLKp/RmarX2jddUz2GnuZ9anizNgd/3qlFrbj8thL
 8GhIq0Bc6cPI4LqZKW306Ql6+PhKiKGZkd2SSKX74tb3oEI2udkMWczsNCoNRPEo8Wck
 /ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765248; x=1713370048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeYRJP22yetpo8HRu7YHvf77//gfViY+eu8d75tRzXk=;
 b=ZkUhTLgtXbspKOoGNHQjpiwYfqefHbaM1ttUz862THZEoLqtOX/9zsSnmiRYSCieJ9
 7JLcZXLiTjchsdDrNihMFhznzH3M4ConVz7jAUS0vgcDKOnQGv5jlrL6TsuRfAa8Y5gI
 oxyqB3gq1gn0yXyHXpQxYMorFsw+aQ9S8ldRLYhPGjVkCjR3SPRXJ41HKd3Sh9LWxdAN
 YV+tytv9Q32CmetYj9lm6rh62nk84whJ+rpF+ZJjAxwdOtJw7Hl4yZM0ME5P5ezLp8uL
 TTqsedpl3Ud6NG6FtnDie7KPpQosWUkT9OWzvnIqabaQ3MVpD5YvUJwVP2nmmqJMdED8
 hzEQ==
X-Gm-Message-State: AOJu0Yzb7Sm9wnuvTom31WrTnie2Ls8RLU3eOsQn72sU8T/LNDzRW0Uv
 dDQM78TR/bdSC2BnVqcX9fLZS4Fb9XIK4/y70hauJDgmnqBtnaE8mEggpZKP1tlNHaNvhz3JtLD
 Z
X-Google-Smtp-Source: AGHT+IFJlrbvkvXCPtVg+I26gMmwjxrbRCgY4nHxk56hI/7RLQFUup2oNBSjxaWAnd7wbrM0w1deWA==
X-Received: by 2002:a17:906:7f19:b0:a51:b752:7ed8 with SMTP id
 d25-20020a1709067f1900b00a51b7527ed8mr1556519ejr.25.1712765248441; 
 Wed, 10 Apr 2024 09:07:28 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 re9-20020a170906d8c900b00a4e6750a358sm7054546ejb.187.2024.04.10.09.07.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:07:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 12/12] backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
Date: Wed, 10 Apr 2024 18:06:13 +0200
Message-ID: <20240410160614.90627-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  backends/tpm/tpm_util.c:357:14: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
        p += sprintf(p, "%.2X ", buffer[i]);
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/tpm/tpm_util.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 1856589c3b..0747af2d1c 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "tpm_int.h"
@@ -336,27 +337,18 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string)
 {
-    size_t len, i;
-    char *line_buffer, *p;
+    size_t len;
+    char *line, *lineup;
 
     if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
         return;
     }
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
 
-    /*
-     * allocate enough room for 3 chars per buffer entry plus a
-     * newline after every 16 chars and a final null terminator.
-     */
-    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
+    line = qemu_hexdump_line(buffer, 0, len, false);
+    lineup = g_ascii_strup(line, -1);
+    trace_tpm_util_show_buffer(string, len, lineup);
 
-    for (i = 0, p = line_buffer; i < len; i++) {
-        if (i && !(i % 16)) {
-            p += sprintf(p, "\n");
-        }
-        p += sprintf(p, "%.2X ", buffer[i]);
-    }
-    trace_tpm_util_show_buffer(string, len, line_buffer);
-
-    g_free(line_buffer);
+    g_free(line);
+    g_free(lineup);
 }
-- 
2.41.0


