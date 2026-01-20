Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5CAD2628E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGgG-0007cO-JM; Tue, 20 Jan 2026 13:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfv-00076q-Rg
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfu-0006eX-8F
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso3193145f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934516; x=1769539316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ib53PlD3S0w6gRxWe/zwqKIeC2KiqAHtDoUd9k0AWPw=;
 b=hV9wYq+C+dpBHl0P1a37f4kRrusH6CI+QFPP7JUJu3ADd3Mb3NW9ZxP0vkBVeHGGnz
 zPWWwqH7blTWB1560rxphGDS/ADGZSuMkMLsamFvj0pJpMapoaoudJgM2JdUVskVtRqp
 PYNiERssHIsKRpORlYcco0nmIjVrfGEB4TdSG+SqDQcMN3xb7efMKaZtJ8RP00HhAcSt
 NYvXIMz0I5SyeGqEk1Dt0t6jlKZ2Q5AAISK7YSzKhmIr/ghYxWN5uPlpn5ymEOyQMZKk
 LvOEvGKUQLmyKAxaQNSNfp3i5clop1vVCXrhaE9brlbYOYDIrMgaiMdzjVDm5Oot7BoO
 gCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934516; x=1769539316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ib53PlD3S0w6gRxWe/zwqKIeC2KiqAHtDoUd9k0AWPw=;
 b=iB3gomcF3oV5WEMYmQehnte48WDdcfdZD7DyiE32j6WoQXl6KRKGfc9ThhJMjreAQo
 lJp7ACOz8bqiAMfisi6lk5koTERkNTHdgYaOgYe8m9PwgrW36qk2fNAQseX6uE2maZeK
 gcslSd65YvB0Fj8KGwDJJdkPbdFUXiWHlB0SYeEbZ5oMyO4SWDixLcwcdk4cU9yX2PwF
 Y9aEsX3t0bGvY/qNsvoJ2vJrYMWIfBZSuZ59mDMvIhCqnchTAwjF1Tsz/R9R5FHxWlJY
 clhlD61tDVTk37AE92X1eOXPQUqrmu8xLLsk/hgEzVaBnSpyWPrwZY+le2XlQteBZqUQ
 64EQ==
X-Gm-Message-State: AOJu0YwpJ+kV/mCGolWZSuwQ0x33HvmV0PCZLPjzGzRLD8zSY3lpKumo
 WQF5l6zMmHx5TqVtCFKEXYfPTay+tWmO+nLPCyMc6Ctxq7/A1vxbzRsryguIXZNsM0+qhhVClxr
 9EA9HvUo=
X-Gm-Gg: AZuq6aJ8mH+mVF4W5KLfWa7VapJOAykPkCucQGn9lNardgClsvX54R+3yS45IHmul5j
 FpqJqAcMmMYKJoP6HWjjcYZIsLDMxl/oUk5GjVJLiAl2SfJOo2HBmqJu3UL7xLfxNTNSRkyV3bR
 Kwavccy1g1TNvK3HMvYhzzsuNTv0CEY47O1aexCdxtJyd9C4pOVeKQggxBmaxdu622vusOwMAPr
 9FiTS2o1GOxPir4baMaKXeMoh4ORW/O9CvyA0JoBM5BmDwJ9ut9dBy8MrjJ5CwQptMN5iZNi3Q2
 VqXi2XmRnZzoA9/l8QXi4O/U2SxhTsMWJ1fLJhbTLm/bGUyvlnOYI4MFRGgEHscQdUxdMigBqI/
 PKve1j+DI/zhyyLitAojowtLSjjCHF8lmCMb3JIhZcI/kAp2TTI6jEJ2g0XAI050yuO/1ZNTgfZ
 l3ZyhqdnaySlkT9yb/nI87cwaoFhyHfBk4s+FTPqnkv0EJ/OMPUhrdPEFEzpsWzUezutvtjrU=
X-Received: by 2002:a5d:5887:0:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-43569bcb816mr19444229f8f.50.1768934516354; 
 Tue, 20 Jan 2026 10:41:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597719d1fsm1267644f8f.23.2026.01.20.10.41.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] hw/loader: Add support for zboot images compressed with
 zstd
Date: Tue, 20 Jan 2026 19:38:58 +0100
Message-ID: <20260120183902.73845-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daan De Meyer <daan.j.demeyer@gmail.com>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Message-ID: <20251124123521.1058183-5-daan.j.demeyer@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4952443fe5d..5cbfba0a86d 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -68,6 +68,11 @@
 
 #include <zlib.h>
 
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#include <zstd_errors.h>
+#endif
+
 static int roms_loaded;
 
 /* return the size or -1 if error */
@@ -916,14 +921,6 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
         return 0;
     }
 
-    if (strcmp(header->compression_type, "gzip") != 0) {
-        fprintf(stderr,
-                "unable to handle EFI zboot image with \"%.*s\" compression\n",
-                (int)sizeof(header->compression_type) - 1,
-                header->compression_type);
-        return -1;
-    }
-
     ploff = ldl_le_p(&header->payload_offset);
     plsize = ldl_le_p(&header->payload_size);
 
@@ -933,7 +930,22 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
     }
 
     data = g_malloc(max_bytes);
-    bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
+
+    if (strcmp(header->compression_type, "gzip") == 0) {
+        bytes = gunzip(data, max_bytes, *buffer + ploff, plsize);
+#ifdef CONFIG_ZSTD
+    } else if (strcmp(header->compression_type, "zstd") == 0) {
+        size_t ret = ZSTD_decompress(data, max_bytes, *buffer + ploff, plsize);
+        bytes = ZSTD_isError(ret) ? -1 : (ssize_t) ret;
+#endif
+    } else {
+        fprintf(stderr,
+                "unable to handle EFI zboot image with \"%.*s\" compression\n",
+                (int)sizeof(header->compression_type) - 1,
+                header->compression_type);
+        return -1;
+    }
+
     if (bytes < 0) {
         fprintf(stderr, "failed to decompress EFI zboot image\n");
         return -1;
-- 
2.52.0


