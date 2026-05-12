Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16BACD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYk-0006pN-L1; Tue, 12 May 2026 02:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYU-0006OZ-Gw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYS-000721-Qs
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso33230725e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567118; x=1779171918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lw3d2uJ+R/wSfLY+fpKQlgCduoUOgRx7Ov/XrzFQoZs=;
 b=BCXhUvZHScEjIHVqWYhMzEumD8B/CvQnGgXddsy10nOhe+BNzOlsghnxLpqmvzcKMe
 g8ikJfXv3vogIJNkPllrnT7taqHgbxF64+zrOfQawOOWJtsVa7nDPQNdAw/oHHQ+EUn8
 UorjqYN/EXjWGC9hdOOtrxo+edakROE7Qo8RJpfOBp3RsWVSkZISeq6eAjo5Qr/TT3u3
 tIcXLvUDQahEB/siVVns8TUoXETCxk7vf2cwJk3t85Jm8uDDmlwMQzBJbAa+DA86AeOP
 b1kMYoONGrqnHSKYUXivc1jZ1nX4gJBGQmz5lSIi8/nNpqKcRc3rAi4/tOQyC9mehlvN
 iBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567118; x=1779171918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lw3d2uJ+R/wSfLY+fpKQlgCduoUOgRx7Ov/XrzFQoZs=;
 b=Y5Y/lAXOfPoLZPJ2TVRkuL2Xmt/IRGu4tIpGlq87Cb5LO+KDO0gmSmY1qoPCHzLWSh
 mjW7rdbANsexs3TyH/2DotIhDxTHIhs7Dtxu1pigLYsNotwNvxwIj03NlrcQ77fhdOhD
 1NdaY3hl1o/8VaEIYdWLemi/LbiwL60Wk5jU8o6IoRGsKfjPVAvJU3WPlwaHfHg6pWMi
 F/7XFaiUtPuAaXiybOkAWDfqKt7i0IO9YQerCp0jM0Zo+FdmrJA8+7Z/9n61tk8j64sI
 C+LZVkxS3ytSd9bS0IhZSiqaDmDe3Ij0dAe6myq35VlrnJZIRrEm+qwdGX8PwIZzmLMx
 fnCg==
X-Gm-Message-State: AOJu0Yw+YWJYSF+ON41EhOAmf10yEI8rC9BISjrUbbxm1rmLV5rxNZyU
 nFf9xFX0G/Fk+fbJ59HSbwyEzu+z/XlU8bwaH0wOrJYCQXfaJiC6vjvMF6hiERnLFGp5JRgySqH
 Ld6n9HZU=
X-Gm-Gg: Acq92OGm8pZzolemGFuCcb7oUR4LaYMm008ZqGme1EqWL4tQYxSHIJQ9iTsmg8t7JUE
 Dx0UflUhirpIbyp63ImV7Ee0/S4ALsQ+MXjrlnf0mny09/+vo6vt0QJe723Iv0XeXWL2mar+u0g
 lVHct4HvcvFbDeiyapT+UWUoEtOr44/4tTnd+jN+8oVU1etg0WXqXx9LxTOPT6zmwPuVwZqvHNV
 AM9qMfKKIBJa+yHganz0wRjIhoIAD+3EUghAx/N4zbopWOW6t+jmRVew+Ivql31UdaZY+IyKi5c
 QETQoDmCx+KCFneWBWBtsMF16S0/Dz0Uwfn/tIU5H6ADf9MfXzngsrWm7k7OBOa2M4FcrClviHb
 BmO+yOP4pBw5S5Rs6zkX1T471FCkO8JySKO8hhd9qEdKPGSTzW8xqb30p3D9QjvQTUoxJHP9/x3
 r7GaKPYXvMoMIYqlSbRyTil60P7y0o5SzzVfUXOWyzGiEcEHVfVOcmp1HO/q6dM7vXvE4xC8/s
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48e51f4934cmr271044035e9.24.1778567118292; 
 Mon, 11 May 2026 23:25:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906ae8b5sm38760495e9.6.2026.05.11.23.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] hw/xtensa: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:31 +0200
Message-ID: <20260512062142.67998-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We want to remove the cpu_get_phys_addr_debug() function; update the
xtensa boards to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-22-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/sim.c    | 6 +++++-
 hw/xtensa/xtfpga.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 32eb16442f0..835cd04fe01 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -40,8 +40,12 @@
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
+    TranslateForDebugResult tres;
 
-    return cpu_get_phys_addr_debug(CPU(cpu), addr);
+    if (!cpu_translate_for_debug(CPU(cpu), addr, &tres)) {
+        return -1;
+    }
+    return tres.physaddr;
 }
 
 static void sim_reset(void *opaque)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 256497e162d..33a2d9485cf 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -191,8 +191,12 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
+    TranslateForDebugResult tres;
 
-    return cpu_get_phys_addr_debug(CPU(cpu), addr);
+    if (!cpu_translate_for_debug(CPU(cpu), addr, &tres)) {
+        return -1;
+    }
+    return tres.physaddr;
 }
 
 static void xtfpga_reset(void *opaque)
-- 
2.53.0


