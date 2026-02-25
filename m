Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56726FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7M-0007fs-AH; Wed, 25 Feb 2026 18:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6h-0006zE-UW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6g-0002oN-FE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso2324255e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061349; x=1772666149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=POgXyEQXCHWOdszOoXS0Dye8v44XC8apxb0vXmXayLs=;
 b=geWKs6uQdsVtwl+QzFH6Pa0Hn99j/MT2oBiaqnkrizm6mu/Yr3fqH+KsHNh2WLefn6
 Y+vf4JfY3Q6lCMoAc1cuGjPp+EgKjivFg+8O/vxAp4d3XVo7CbPMtWcQRdvLDWG9tfqt
 LFsHpavlZS8ulJw7wFYyRHzOoL/Ib1fERORKgxfxqtwiRu1OLxo/cUuvVZNpgqYflUUp
 Zu/oelnOl9p3VxoMrVcFVmRvqpUYmvEqV727qmJHcHOGSdeCuOzuEFTFQ9QaVPHG4t0J
 zTYM9lFQk3VHsosnUuKU3yGGy/tNfxVd1CC09d9jJ63FEFB0CaEI4IbCZ0wub7p5DQEA
 S8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061349; x=1772666149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=POgXyEQXCHWOdszOoXS0Dye8v44XC8apxb0vXmXayLs=;
 b=T6/euuhh+wAaIpcJGZeA+asGkFqRF4ZC2+PixWVnkZ3WtquwRMJLRj4SzZaT/m3jIz
 zqV+Xgvg6IayQC2ZtDo/AWTRQl43W0f8ZGOdZ1oe4EU28cR/DXt1UyQ2NI9iegT+GreF
 4pmID0mP2EP2a8/58EKyXHKboSdWnv9rtNPEnW9KUnXA7jdwl6Mc3V7Y5VA3UdwyGeYV
 dYGvBen3nPrnGttWIbD2a4bzgKDJIaYaE+PhU9bA0cgnn3T+O7G51PafcM8sdPKXKFm5
 m9SuNQoY/mfJFdz1S5dII65iHj2hWfmMDtV3xL3OWlnmgX2DwXvM04cPZ/GGpRT16ZR/
 5PQA==
X-Gm-Message-State: AOJu0YzDnzncE8+kYROj0KtIMT/ebS4kmqc7F4806rea5G56o8k5dVuU
 grD5mQTvaHRMPh6bcvYG0ktTCxhzYoJ6d1Kyv5WWr69AnZgTxuoFcHCMAkGZkjEvV2pbph+jqVo
 4qHYjqBkAoA==
X-Gm-Gg: ATEYQzzbF9cFTQZo6naWhAN0Nmv0b+urWa56NaRxx+pkj7nZc/U6e5yx1LVba+SVqHJ
 HWO02NgE9IfjQvXO7tXdPogwsbDIYeb/Asu6Rdbx2W7u7GRCggDXHYgdadp6aEiMpSbGXEwi8RB
 OaTebZG3K0eKfiX4cTL5qbVvTd3qnmJT8upxavtYTKIokcLCt8yFXsqwt3IY/l14snRefg5hrCq
 jlhsoJFbivbwdqjPIodZf2CQa/xjrGP01tab1ADy4tYIrM6Aw7F7RFwaf026h7owYT9Zh5NBAio
 PGYFIOZdlBdEBuIUHxwCn6KrXmhDzt48ynQErANlSwlWAhT2VHqSZloj2CyUK0Hhvj7RTp5R2b3
 BrXWSFYqyhnRzri7oMqxCQEbSiptG2gXnZ7YJY1lBsetl8q2K1ysid1kBuLPzYdnS1YE1cpsE8C
 hBUbq3nsE5KdfhanuhQ2f2Z0BwXMClfjAC3maDGobugZ2Z4ja9flYuyUfzZctaCelhRG40lEV9
X-Received: by 2002:a05:6000:2284:b0:436:34e8:e661 with SMTP id
 ffacd0b85a97d-439942ed0a8mr3919017f8f.31.1772061348611; 
 Wed, 25 Feb 2026 15:15:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa015sm37057042f8f.8.2026.02.25.15.15.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/70] target/ppc: Fix CPUClass::gdb_num_core_regs value
Date: Thu, 26 Feb 2026 00:13:14 +0100
Message-ID: <20260225231411.96482-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Only 70 registers are exposed from GDB XML file (for either
32 / 64-bit variants).

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-8-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c809c1f4d89..27de8d80204 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7553,7 +7553,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                       PAGE_WRITE == 2 && PAGE_EXEC == 4);
 #endif
 
-    cc->gdb_num_core_regs = 71;
+    cc->gdb_num_core_regs = 70;
 #ifdef USE_APPLE_GDB
     cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
     cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
-- 
2.52.0


