Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A67BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShJ9-0002v5-4I; Thu, 28 May 2026 16:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShID-0001jC-Bo
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShI9-0005VI-BD
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so61625895e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999919; x=1780604719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vvrrJ6klvGgz/Fo/Urxcb2omaYPI3WwqyE98ZbkO4fI=;
 b=uOj67wNFR+tiTbVD+DLztY/nePejMtUT11m1qy1lUFAZtMy4zjv5K5lA+idwt1tzqU
 ifFwALNZAu2N6dX0nEBcsORNij9F2CUckuAz25Wl1R4hZNqx5ySJ7YeClvjLIvE1RNV8
 A2BqxlAKpJIC7/lgZNXvVdcrmvXocqjHzII8NcJA75VB0rh5ch+NE69DPxQi7+4O5ISi
 BLZnQNbvHjUuoA+i0nrtnwecqYlNruch6H3Ka+Dr2x7679SlNz5ryH6en3JHL0gm1PrZ
 8SZuz6YVhSjyvKIOXH4zrUozl9lKUE/UkSQNlVWsEvZve4BkyERvk2po5sv+Z7RIFnUS
 ytdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999919; x=1780604719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vvrrJ6klvGgz/Fo/Urxcb2omaYPI3WwqyE98ZbkO4fI=;
 b=ZPQy5mBZLhsGt4XECyB5YtBqgSxodZM8RSucf4SrKjOg4YIcd+PJ94HUtkFf9pQo2p
 H91OZZsvpdTIILkcmDoRJuEABUQ6bVVbEkZdlxVI5LHKjrbeHE9iBgVVxP8UnOXb8y9A
 at1XJ99o8O+hlUyB/LQrlzIBctz6awwF6t+Eo3ikIzBqS2Rj3WzPpiRK7MrkOpGsRKJZ
 Hr/aQQuitjkHoucWRBJfgG2Te8s8wmqGQmcU+tkeoynXSLodtHdGYTuePI4uBkut9lmh
 JZbO9ewtVB3qur/ZcWSBX8pGJ6XFtQ/ZFZ9MLPYe4/Mp2LmKW8Mrq2CvUwZnyfWl2JUQ
 5zkA==
X-Gm-Message-State: AOJu0YzejrLqgWSZkhOw81IpQQ1+qW1xVayaCxLmslrJ3EOVb5syG/BH
 M2m2Ys1Nwpsxg+fvOa04nXrrLV6VumOKucOLdnv8a8dnHUSxyTxWXju4Rtzz5aEaBOURchktmnl
 uNNYLPLHGsg==
X-Gm-Gg: Acq92OEo6cZ58dKb17nw+D4Bodlw9h2xIuGmq/JhyZgUctEeHmgtvDoizLfe/U9xGKR
 8SAYpLTitMSZQaawaq0tN6VFK7jIXa0JXA0r1Sa+sbEaYsuTjuDD7jZqDd2eBWQcqxGnB3Fmj4t
 xSIatliqLUBSzQka7zP3zKn/Aszt3J0GsLxCkPDuGFS4fgVXv3jc6QBOM5KgGXgFsGW6KyBWttU
 Co1DXNnYBCjMS2bp9K8x/jLE1noS+rgtYu2Sd/R5h20IkykXWX0ytlEOqOsAIEA6StYfS971DXL
 UW0zHBmLFOeyjMW9jWJaYEMi+zCwWNPSMAIkDDVqZ6Off7uIDiok+5ecERoiaJyjCWtYLof8jn9
 vOYOfd3WiqZrPO0CrA/CrH6lBj/45fbSYzDab7im0k0Ysu0sNwDBvvKQwmYA5N9pYLG0y++hJKY
 t0ketMzP8xlcnlocykBpHgMQpQ9pXJgUSXL08nmcUDtIk7y++1q1SR1lOsTBxKxUKiCw==
X-Received: by 2002:a05:600c:4694:b0:490:48a0:b87a with SMTP id
 5b1f17b1804b1-4909c08d1fcmr692425e9.9.1779999918803; 
 Thu, 28 May 2026 13:25:18 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eec25e7c4sm4281471f8f.37.2026.05.28.13.25.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/22] accel/common: Remove last bit of target-specific code
Date: Thu, 28 May 2026 22:22:49 +0200
Message-ID: <20260528202253.49122-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Initialize the TypeInfo structure at runtime using the TargetInfo
API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
target_cpu_type(). Since the code is no more target-specific, move
it to accel-common.c, removing the need for accel-target.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260528140857.44130-1-philmd@linaro.org>
---
 accel/accel-common.c | 15 +++++++++++++++
 accel/accel-target.c | 41 -----------------------------------------
 accel/meson.build    |  1 -
 3 files changed, 15 insertions(+), 42 deletions(-)
 delete mode 100644 accel/accel-target.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 9c5b4111c8d..62590a7d9a6 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
 };
 
 DEFINE_TYPES(accel_types)
+
+static void register_accel_target_type(void)
+{
+    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
+    const TypeInfo accel_cpu_type = {
+        .name = name,
+        .parent = TYPE_OBJECT,
+        .abstract = true,
+        .class_size = sizeof(AccelCPUClass),
+    };
+
+    type_register_static(&accel_cpu_type);
+}
+
+type_init(register_accel_target_type);
diff --git a/accel/accel-target.c b/accel/accel-target.c
deleted file mode 100644
index 7fd392fbc4a..00000000000
--- a/accel/accel-target.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * QEMU accel class, components common to system emulation and user mode
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- * Copyright (c) 2014 Red Hat Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "accel/accel-cpu-target.h"
-
-static const TypeInfo accel_cpu_type = {
-    .name = TYPE_ACCEL_CPU,
-    .parent = TYPE_OBJECT,
-    .abstract = true,
-    .class_size = sizeof(AccelCPUClass),
-};
-
-static void register_accel_types(void)
-{
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_types);
diff --git a/accel/meson.build b/accel/meson.build
index 7da12b9741f..1b5b37e3097 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,4 @@
 common_ss.add(files('accel-common.c'))
-specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
-- 
2.53.0


