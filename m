Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CACD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUt-00065h-D9; Thu, 11 Apr 2024 06:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurU1-0005GF-Iz
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTu-0007W7-KM
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-416c3aca500so14249375e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830590; x=1713435390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NkZbdhuZimuvYHJRoYOcJ4m476kCV6CLgO0HzeNjj0=;
 b=wQxCVpM/tsYxZblIZozkm4q1DN38xsPQGDxCvZ/LWsfnrjZmLFdc3Bmz/InSAlBuOl
 WSSOlBHgqsCdTq9J0gd3/6+X6eHdDbvRT18KtjJQQhtrThT+VTCkKevSEfLTRhSiwLf0
 26vece0JrNTX0aFxfO4ZX7IH1qD8e3KLW8VhwNCTtRwlpQCUjpXF6ampdmJwgPR9RWRf
 2FsX0Aus4ZAHSERlEUuuEEJba1NGrjYtFfH7qAwpx5v3WmGI+QIM/GeLgJ4cYavRazTR
 5JariKb09vxVvWzJZZ5INsijJjHfmeJZmq5XY0DnF7q7di9mYRnkqIuGnO9NgWxUhLSD
 AyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830590; x=1713435390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NkZbdhuZimuvYHJRoYOcJ4m476kCV6CLgO0HzeNjj0=;
 b=jfAsnxbrtzpLwS2DqPCH7QX1Cf/2532cNCe/AjoNEzoFXuStEYrmHjObvwbIFmhOcO
 2bBAvwSbIMlKDvS2Z1aT77BWHUdeU1z0GlGsn+Q504JVimSt5m69+HM5AXjS3DoIPGdS
 M8hPNv/WUHVwsJVT2vYcmSDC7v0JopQcByR9wNIJ40klFLPxEkdA4OU8w++z7dD//fPi
 f8/1+YzMWeNY9lBy9i1n56hlWm+1ZTx2bETnF5KUojWB6w7gJ25vjsmxDfcGkLlA2cPK
 z5eoMLw/xLn/2SDa7GFWMBTNchz6mg9Mi9wsh4O+jlAlfQAgQsa+FS1GOk2bAJ3HVzrD
 WtYg==
X-Gm-Message-State: AOJu0YyYrQ7bDMUzRuCdZ1n+b/kC3G/I7jofM5+kd6vYPab6863Xa+st
 6PpElPFGnkSGb0UTeN9qjn+pDb0c4N4FLJyThEapalWf9QCU0PnO8BAFbJxdZ0+eK+pbmXMo6e1
 /Hnc=
X-Google-Smtp-Source: AGHT+IGMnvPHl9fzIeVzOggZW568jpYi0m2gNVtQ3UOY8oJCxoruSA/ooqNQmFoEppDPTbKQe3MB4Q==
X-Received: by 2002:a05:600c:468f:b0:417:d75f:fb4 with SMTP id
 p15-20020a05600c468f00b00417d75f0fb4mr1182890wmo.10.1712830590481; 
 Thu, 11 Apr 2024 03:16:30 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c354700b00416aca5ff66sm5046906wmq.19.2024.04.11.03.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/13] system/qtest: Replace sprintf() by
 g_string_append_printf()
Date: Thu, 11 Apr 2024 12:15:42 +0200
Message-ID: <20240411101550.99392-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Replace sprintf() by GString API uses in order to avoid:

  [120/169] Compiling C object libcommon.fa.p/system_qtest.c.o
  system/qtest.c:623:13: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            sprintf(&enc[i * 2], "%02x", data[i]);
            ^
  1 warning generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 system/qtest.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874..22bf1a33dc 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -601,9 +601,9 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
+        g_autoptr(GString) enc = g_string_new("");
         uint64_t addr, len, i;
         uint8_t *data;
-        char *enc;
         int ret;
 
         g_assert(words[1] && words[2]);
@@ -618,16 +618,14 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
-        enc = g_malloc(2 * len + 1);
         for (i = 0; i < len; i++) {
-            sprintf(&enc[i * 2], "%02x", data[i]);
+            g_string_append_printf(enc, "%02x", data[i]);
         }
 
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK 0x%s\n", enc);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
-        g_free(enc);
     } else if (strcmp(words[0], "b64read") == 0) {
         uint64_t addr, len;
         uint8_t *data;
-- 
2.41.0


