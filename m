Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382ACD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYE-0004pF-G6; Tue, 12 May 2026 02:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXc-0003Ic-Kp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgXX-000630-6O
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso4099176f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567060; x=1779171860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+4XX5xrjDxdhZM2QFnSK/7i4L62H/BPpSU9tE4S16mw=;
 b=MpBBduIFRgdpSJRAZz1Lf5Z8NPfUlkVnOj03//+4HOrFaR0uF1xQms2FMj0ydb1ubO
 a4jdWtp9XPjNPKuwEX4BK1rWkkPylNPR+rUFfl069xCUd8Oyupva5NEYf6brZ6vgWfmh
 QEQPKKDMCZlPfx62go+tOQiAWiaJvf5K5pgQG3sh1SZwEKvDaSwVSXsr4GErzMg4cEx7
 uN7YUVMcvHovWy7XstWQwKb3q8Wn+/zullZmIXmkHH9AZDVznKtfMBRViAfkXhE+e4yn
 9nYQj/DWTGazma0oAqvjRL+isORGvW2WOyK3H3NcxFCRKmGsDq4uEGjIT71tE9WymSux
 NwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567060; x=1779171860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+4XX5xrjDxdhZM2QFnSK/7i4L62H/BPpSU9tE4S16mw=;
 b=HjZIzgRkjD5EqbxHCfvO6DE7qs3zb3RZu7QAbo+C8Hmhx/UtZwwt61UEBn6agKlW0m
 rxbr0ZF1i8/rEEjB6NWIFBPiBtkRWXNfj/urFXh/+Jy1BjI0jec37GfR1e7M5xQ8k4hP
 8SaT8Y0IMEVhNPr7oJr+R6Grmdo5lqRSOeYeWkx7ChRObkUo/M57F7KvuDULvQsB4aKY
 YEiD/z8oi4IYBnoMB5j6diL5dGYoV0/rjzI1n5AF8ReikNnQPBO4V+VHBuaAIi+xQ3bG
 Qvkz4NFeprDQgmyeaGzKhFNcxWpw4pXNZRlMnFJmvrboTVW2QYR/y9qW1zoMPN2YPoJ+
 rvfA==
X-Gm-Message-State: AOJu0YwSUDMXSwYsMGCvmBcHNyVdTtyMOz8o5+Tq/tCk4r44NR9bBkHe
 QxqkJ4n9Y0izt90suLhRaNdBX7bOhpgEWAWze2gO05Vlu8PhXKvULMctzZ5BeTNv0H819vzfFtW
 doAE5nKA=
X-Gm-Gg: Acq92OGnlDn4Dss2r8qyjebxJ86HG37ojkLyQuxEt/VHyOagSU2tfku5ScIpyi4/2Zi
 rVGbalTDzoudL570eVJFgy3eRNHBJD1oVb8n1eL0SiAfHo6RIaPndidv9myTiDadLc/l12FqJpP
 CwkVQDrDBGnPcb5wvs9LoIh68+OE1innnB5s1bSAZ38kslga9MXbFRIf0uXX/rpdfjznI3R4zCC
 63S2j0zpj1UbwymSXMUOKnwXJyX1g00ph1c9M4NtZ4G1d61jlKHUErFEmD1ipN/8ATzADUa78fa
 2svfyLmPelGONXGeqw/r1U44HZUb3HHsoIXGEJMefv7T+N5XClgKpdFiFPFFXd0WLYvhj/7TGMi
 87jvhrLgv8lD3pMWR5uDwd3e8hCROAYcQLcj3LCOKInVc4yCRb6B3o7kHlTQ6PLuwsCsB1N0x5Z
 1LysUAdubN3cW3ogXfzVZZDz0t3Yc3tu15B7hiboc54N8nksg90pxzx+7O78HdXnmM5Uql5Zec
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr422253335e9.8.1778567060330; 
 Mon, 11 May 2026 23:24:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906b04a9sm38325015e9.7.2026.05.11.23.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] monitor: hmp_gva2gpa: Don't page-align
 cpu_get_phys_addr_debug() arg and return
Date: Tue, 12 May 2026 08:21:23 +0200
Message-ID: <20260512062142.67998-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In hmp_gva2gpa() we currently have a workaround for not all implementations
of get_phys_addr_debug handling non-page-aligned addresses: we round the
input address from the user down to the target page boundary before the
call and then add the page offset back to the returned value.

Now that we guarantee that all implementations will return the correct
exact physaddr for a virtual address, we can drop this handling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-13-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-14-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b37a9985c0d..88f9788bd9c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -771,12 +771,11 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_addr_debug(cs, addr & TARGET_PAGE_MASK);
+    gpa  = cpu_get_phys_addr_debug(cs, addr);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
-                       gpa + (addr & ~TARGET_PAGE_MASK));
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", gpa);
     }
 }
 
-- 
2.53.0


