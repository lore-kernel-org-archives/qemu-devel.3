Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E551BCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurVG-0006Uw-CW; Thu, 11 Apr 2024 06:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUa-0005Yh-JV
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurUX-0007eN-4D
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:17:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343cfa6faf0so5805123f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830631; x=1713435431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cVNgvNeXvdU51bO0Cz/mKYmbc4VssBzSVzGArcUzjU=;
 b=csDD1xx0Z0zF6wd1E23GjOvXPx3NEC5RNlBSZDRspr2zmMs+NclJfIRFriPRDXdt4r
 d8Ji4BQJfWRuQTlQHDHnSrwmuPB2ceiNlUfxc0Oj9D5JmvTixhaRZuDtVVBkIIhEwbYY
 SeNGX+ieQ1kyML4edBYmFXiSje6yy8GC4iy69WlGzyhchqvSULK3bR5MUdow7evnTZVj
 qqAN+k5nvmz0WbE8MAT+rsC4d4jmSC3E/qrM1zEAv2bgoNhQUzC9mLQAyIxRWFbcVb+j
 4LLhaoq1eMoPiwmE13BAyBt1S+El2JjQZwg1lO9fHlhn3J2SxFdF3GDQjdCoAS6+20J7
 cUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830631; x=1713435431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cVNgvNeXvdU51bO0Cz/mKYmbc4VssBzSVzGArcUzjU=;
 b=FDMtfUYHrkS9FlxSfs43BdtZPSwB2uCuedy+PvljEApIi21mjKZWlYdCszPqTK03jH
 5b1tM5TtR/2opTwG21ysEuAuKJd+KIwLvv137ELUlMk79sqdvaffXuvl9BagB7X8zvOZ
 Olhjofvk8VKjYNCk0WRiXTZboR2FEkurR35gpUShrzqSTeAkuwACD593h2OlV82t7Gnz
 tafBLdxCFq02xWqeSBKRTVQDRCmLH1ZP8LUh4mN5xRz0kJTPlJK6h0l7UGmKf8Bt3uMq
 +UNGFBH6YYaXEotwxQVOMUdaBxKoXGmQcczdnJxPt5Jn8MDgAwTufm0ZhZyzxaXasGqV
 dEcg==
X-Gm-Message-State: AOJu0Yz21uaO371cExYU34tXYhL0f2Eci+fLEJnzApexICZ1FZnfSF1L
 0zUkoBFTVo4Q3khpWM6u/7JtRLSDULyQ2Y7s4dc8w58UFBXgujx4Q9FmkBK3uySiZb2J0bR8yYr
 nlds=
X-Google-Smtp-Source: AGHT+IHdltH2e6GjIrJCIhTrRGuk53JS50K8lEHZCpVMgnPXaBK8O9V3kEWM4ilpsXuryIUk+KWEoA==
X-Received: by 2002:a05:6000:186b:b0:343:6b76:251f with SMTP id
 d11-20020a056000186b00b003436b76251fmr5589625wri.42.1712830631600; 
 Thu, 11 Apr 2024 03:17:11 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adffd12000000b00343826878e8sm1413910wrr.38.2024.04.11.03.17.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:17:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 13/13] backends/tpm: Use qemu_hexdump_line() to avoid
 sprintf()
Date: Thu, 11 Apr 2024 12:15:49 +0200
Message-ID: <20240411101550.99392-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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


