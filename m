Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155FC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggif-0007Da-D4; Mon, 06 Jul 2026 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiG-00070I-PT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiF-0003Gu-6T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-493b6f1b14bso11317105e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334285; x=1783939085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OaMjZwxzZhA1NzC7/h6PwC65ow7Bbi/S7QuuxLOQLcM=;
 b=HP0sj+ospkxZq+jWe/OZnpQ8FioILoOzwQMrW6frIwsOxNXGQcEk2ue+CkisHu/3TF
 W4g1E6qkKf/EVSi6AVVp0HDGX9LCWgLo33uUdH0tUwCOdjLqxfPEk2vihTrUv3BFliP6
 CP3Rk+uGFctXMhvt44Z5P0uhgemLsdv4P/TGJjpeGgNJF1hKjM7vaM8+52qp3Vf+Ohrg
 TNDFJ2h7daUGcQ8Cb2qludTe1NN61138vDxDxVP0jwyvkRivJJNCxMebsYhj3oqUL2HR
 5k6JRpSAAZFScsSRPdzKidlGFG5nquF789756NnsPUe8QRQDDCuEuo016ILS+bp2I+IT
 sI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334285; x=1783939085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OaMjZwxzZhA1NzC7/h6PwC65ow7Bbi/S7QuuxLOQLcM=;
 b=cXFBix+R+qRHBGMJ7ZQKPE/yD7GfOg5rI1m/qq024QkdMdatmp7Ru+eiauXnla0srj
 MHBEEBkIgpnkxN8Odq7Y6rWa0uaqesKfX30HT8371muuUrRy9wXKstDAxOm1MeuBxqQG
 CYOwieyh/TgGJRnad2/r2Jv8iRrIOr+iHbAcw30AcVmmohMnkZ3AK8CvqCIOxj/sOlft
 KV4pPev9ilD0tBypsUabyxBHEKLsUUeIkdLfIrZbXWJ1oRaP27pjarErEnV7ndntcWZ4
 9gO5HxhfNeHKqIpKQ7MJQGhq2JtiZqvQIpG0il3u51BzusqdhC1aUxBxayMaaM900Ri1
 aM+w==
X-Gm-Message-State: AOJu0YypvSuGYqOJHZGsM4xcJPAL3HH3JYR+uT5/EIBLhqXfqvzA82SK
 rR/4Nf18z7R93HtWPX5XFJuC9IhJ+c5WyElf5ddvaZgnDuM8cAv4KyF/dOH5C7EekE1nBufyDxM
 RV/4uknsUVPbF
X-Gm-Gg: AfdE7cmymsnBJ/LdC2sAQtUMd8LRMKGdszX8A1x3uYJ4AJxqUCHmwQHIpd4HKSY1852
 oDvdfbx86TXfn9WzhJkT5ZGzQQcFMtb9T5A2ZuOO9TFAqBudqmgGhTnIWVI8009Z/XIm700zWQ6
 7LmKW0I/Jjn5+mIeJ50Jkyu6jHZkhFWsVjlq8Ybrek7CMrgphQCkbYk26aYd6gDJwEiDmEg1wZR
 XBtjadNwvkPa7v554enFmrVROrLkCWN9dlBzfIp/tIoYpwB7/iwkCm7CtCKe7c6IGBhmEsox/dl
 EI0NAOXwalWp5zUDm6XnDoamw5pyIFHPxWiSrnLecd5OkeJm5p8XMQQgsj3uGNDkVZ9GhVmyaHZ
 J7OOgFdw/fQNEgRvw2ucU9CZbsTm3kxfbuR9VBuPwK6FUcLuSmpDebVyhLOsdkhEJ14+UIB18ye
 RcN4nSX1Z4uoZasLiW5YputU8+rfngT8g+N4+zPQq7XJGRgRVvY0iqmU+n/XY/D/R2fpBnkQClA
 YfhmOkk17ZHKyz4NwZb3Q==
X-Received: by 2002:a05:600c:6287:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-493d1188014mr106991075e9.0.1783334285025; 
 Mon, 06 Jul 2026 03:38:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/49] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx
 machines
Date: Mon,  6 Jul 2026 11:37:14 +0100
Message-ID: <20260706103752.320511-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

CBAR is an IMPDEF register and according to the A9 TRM [1]:

  In Cortex-A9 MPCore implementations, the base address is reset to
  PERIPHBASE[31:13] so that software can determine the location of the
  private memory region [2].

If it doesn't we will confuse the Linux kernel as it probes the system
SCU registers [3] and erroneously assumes the system is a buggy Aegis SOC
and nerf the emission of SEV instructions, deadlocking any WFE's in
the kernel (or QEMU smpboot code).

[1] https://developer.arm.com/documentation/ddi0388/i/system-control/register-descriptions/configuration-base-address-register
[2] https://developer.arm.com/documentation/ddi0407/g/Introduction/Private-Memory-Region
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/head.S?h=v7.1#n550

Fixes: 2d8f048c25ab ("hw/arm: Add NPCM730 and NPCM750 SoC models")
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260624103049.884930-2-alex.bennee@linaro.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c2bbcd89db..c27f149c04 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
+                                NPCM7XX_CPUP_BA, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
                                  &error_abort);
 
-- 
2.43.0


