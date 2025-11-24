Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58522CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTGj-0004wA-A7; Mon, 24 Nov 2025 04:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTES-0004Rw-M8
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:49 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEM-0001XD-7d
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47755de027eso21282095e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977886; x=1764582686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhKFJZWydbqGmcIRFL5kj0hz2mqSNQ29ausDGKqoC0E=;
 b=oZvwqC+SJ971LCsG30vZCCc0O8MwrU/Nj8qEb0AwMBzLUQFWBrWD14nhO3wM9v7Eqw
 Di+O7yFRk3xkIO+Plf/A1qq7PYyi3ZJEvyVZdROQ/9mdychRPBSZ9+Hby6ueFcnMZ1AB
 GLtzF1EWJwMdC3rdZh7i+7Dzx3pE3urDaS7+kqUMmRQu/hQaLrV9SnuA0ZRr55+hqz7F
 KkFwWoqJH+hWHYSrpN8i9m1I0OQQCGyJt6waC0FwZl77u4wDvNlNfsZ/Ia6mz0FdB+W9
 6ZqsuErNvZBtj/kv09Jpcsg1zjqqFo+ZiwoJWDMYAuhcK+EsBqfmaZn4GG0PwnR0pmFl
 DHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977886; x=1764582686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XhKFJZWydbqGmcIRFL5kj0hz2mqSNQ29ausDGKqoC0E=;
 b=hn/b7T3Dpg8bRqI24/Qpql1V2Qi+kglcQXvpQbYHVDCI+sjitv+M7OIp6MI1K9Cyki
 b6WCyb7zxhETDCDVCR4C2cUHniaIhhsnPEvIBzRdCS4qpFv53Y6LHGqf/Vn0dK7Wgho0
 gy8bFevL+NmRhiZePzfl7xfJNepy++BXDMaYM4l0aaWnNJIUp+OURXUCIfKog85xDesX
 ZJtx5LDoolk01+RIjeE8v+hQm6Zq1HPutsOMDWEvl/GJm6gpTd/8HdjucguwDy5gypJl
 1fpCaBpg+Mq6HAq/EPbMltthVKkE70EobTZc5PCyiJIHnFWbxWI9kD60rPw1Bu0Twaqn
 Mu6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbw1K1wx8pAo2NZ2Ys7BfrqlrEKvuA3jetrt82CX1r6K9CsGfHW6feGcfC8BETnYZjRLoS5rqANs07@nongnu.org
X-Gm-Message-State: AOJu0YwFuIW5TDZd4AY2YsIAwj2pxzvQ1Gz3uAnYuxjP3vBXzmdDFXqq
 pVlk8h3cKCxDiL1LWw/HNyI4pbXBMVXBLe0naWC+VzcBYoWGyJeIEA3siOLHVE+2OzM=
X-Gm-Gg: ASbGncvDHmSimaDiHO2QP0W66872S73Qyl9MO4jm41s0xtzfZRyJDurdQ829utZa2KB
 b9tX1gR/YMb6fexlIru9R+MOFiPyS4cQBMSzCIRyOAtCdtXvJtR9rMMKTS4I1OssmxlbRcNn5/f
 g/MAUM/sC6hvfEN45jas4UTQTarTfcaEkfB+dytjcXjMyKulDTQDKaZIuGuYVocBZGtmUV8+wxT
 S1BnI5KZIjRJ6zitB8lhmsvxS1wz8rSettXM9EpytJjXndqNDPyhtrifAtsxQyS9yIDIYp8opEh
 Lsdb4qcfzFxjhfAiLNjKWkuq0PFrN0dwggQnVZmrI8BfKtfaVbacpM41i3HwwfBPudtU4cPt/oB
 ae78mf+3dG5i/ZwLwcLWCCKDf3f+wT27GFIegyl7bJM8JLgA+81wI88MuPqHmaFBBRT9EcnNZdK
 JXkO/X91BRWQR+IhX2U5jH//KDJrgYYfFShZw9WnptWPfjk+mLwLIzfto0hPW+
X-Google-Smtp-Source: AGHT+IHsGWgCAJboBWS7bs81d0BfnA28hzhfVbh2PpGkl8huKl27F3zPdLIAATDUfOlYGujKUuCeZA==
X-Received: by 2002:a05:600c:548b:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-477c01be313mr102460775e9.17.1763977885796; 
 Mon, 24 Nov 2025 01:51:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm142677525e9.8.2025.11.24.01.51.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 02/13] hw/sh4/r2d: Define BOOT_PARAMS_BASE
Date: Mon, 24 Nov 2025 10:50:57 +0100
Message-ID: <20251124095109.66091-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
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

Linux expects the boot_params structure at a fixed location.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 56da48f64cb..5f8c034e1af 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -53,6 +53,7 @@
 
 #define SM501_VRAM_SIZE 0x800000
 
+#define BOOT_PARAMS_BASE 0x0c000000
 #define BOOT_PARAMS_OFFSET 0x0010000
 /* CONFIG_BOOT_LINK_OFFSET of Linux kernel */
 #define LINUX_LOAD_OFFSET  0x0800000
@@ -383,7 +384,7 @@ static void r2d_init(MachineState *machine)
     }
 
     rom_add_blob_fixed("boot_params", &boot_params, sizeof(boot_params),
-                       SDRAM_BASE + BOOT_PARAMS_OFFSET);
+                       BOOT_PARAMS_BASE + BOOT_PARAMS_OFFSET);
 }
 
 static void r2d_machine_init(MachineClass *mc)
-- 
2.51.0


