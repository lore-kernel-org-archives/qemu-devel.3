Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED96C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXH-0003md-NH; Thu, 06 Jun 2024 06:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXG-0003lz-8A
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:39:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXD-0002kW-KS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:39:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421396e3918so11202985e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670393; x=1718275193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t40djQlv053yA+vH29m5Xf5i4KWL84AS7zuIsTUNOcA=;
 b=VJKoXadKSC4DyDfjah7F7O8+4JKSTt92vzSbjphQ3G6mbz8Ofl4hltGpfUojt1rWC5
 pLRoeEStIyNMyIuU4VOUpr06peNHZihK0XovJPoRGBiG09hOA08doYODJWVzitQcDOjx
 kVamtWUHqZck9ahewFl5M//bYSDPMgunaK8Ygvm8S8T4EVbk2WEVy36/oV2H2ZWcVYJc
 kk7e7lq5ZdLyJMoOBSZZ408xSssKyrIhM7eZaFtWaUvKrZHCLl0V14bkCWwgPl+UwxZV
 1NQpQy0p4qo2+lzUUug5MAfTpfNDOqwNW3t8gwz+CxXcYL0IblF7wjDX8gs65CMPZrVp
 WzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670393; x=1718275193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t40djQlv053yA+vH29m5Xf5i4KWL84AS7zuIsTUNOcA=;
 b=HQz0r20uk/5t+/90Mcgu0/r4mHxFFn10GhmkBHYxVTr83CoLfy48ny8FuBbUTueFgc
 3UWYOZPadL0albk4zG/4bAlVTQiEexN2asvSBER+ovYM/Y71cKGrq135HCt1fq3WgQC7
 L4q627s6Bkiqs7Tdjyt0aPf400iYX0lJkxoSTdJ7hA4+fjv6h0pmJGkosrcZjK7opKTH
 a43IEuEbYbg6DAlJ/XujZt6sbK3nWQxLdEVIZZuMrtbAo9myxdcr2r1aBUYG8jZ+JWYZ
 uuwD6pJbM16+X6LBjI44S9vQyN5twETezdSr6XSITu7N61yxmH2zyOv9SHXHbWfyzkMt
 B6Bg==
X-Gm-Message-State: AOJu0YwHCVYTDpXVNG/zLJTDPhbVk0ThwtwrkBxpfCZC7mmjV1xHUBiN
 Y+INctx2lWBRR99epiQkFeG4aaNezquYY6NyTezsA0LiSJP9mNt4QraCsNApfpOY75HUWKWnU+t
 nKjk=
X-Google-Smtp-Source: AGHT+IHvmf7hOGJtMw+DX5e434x3VVF4KPxp7Gv4LswgBl49Isytyc/GeKCreRMXsS1U3mo2rzwwzw==
X-Received: by 2002:a05:600c:a47:b0:41b:eaf2:f7e6 with SMTP id
 5b1f17b1804b1-421562c3f28mr56338255e9.2.1717670393421; 
 Thu, 06 Jun 2024 03:39:53 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2cd8fcsm16877045e9.47.2024.06.06.03.39.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:39:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] backends/tpm: Remove newline character in trace event
Date: Thu,  6 Jun 2024 12:39:39 +0200
Message-ID: <20240606103943.79116-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
References: <20240606103943.79116-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Split the 'tpm_util_show_buffer' event in two to avoid
using a newline character.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/tpm/tpm_util.c   | 5 +++--
 backends/tpm/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 1856589c3b..cf138551df 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -339,10 +339,11 @@ void tpm_util_show_buffer(const unsigned char *buffer,
     size_t len, i;
     char *line_buffer, *p;
 
-    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER_CONTENT)) {
         return;
     }
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
+    trace_tpm_util_show_buffer_header(string, len);
 
     /*
      * allocate enough room for 3 chars per buffer entry plus a
@@ -356,7 +357,7 @@ void tpm_util_show_buffer(const unsigned char *buffer,
         }
         p += sprintf(p, "%.2X ", buffer[i]);
     }
-    trace_tpm_util_show_buffer(string, len, line_buffer);
+    trace_tpm_util_show_buffer_content(line_buffer);
 
     g_free(line_buffer);
 }
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
index 1ecef42a07..cb5cfa6510 100644
--- a/backends/tpm/trace-events
+++ b/backends/tpm/trace-events
@@ -10,7 +10,8 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
-tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
+tpm_util_show_buffer_header(const char *direction, size_t len) "direction: %s len: %zu"
+tpm_util_show_buffer_content(const char *buf) "%s"
 
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
-- 
2.41.0


