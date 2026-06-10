Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C9BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXy-0000Ay-BZ; Wed, 10 Jun 2026 12:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXk-00083X-5F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXi-0005Yk-3c
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso59015855e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107957; x=1781712757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cvP8aOq+dkmxUYFr9yBP2ILGw50KTwLpfscjHW38iRg=;
 b=oyl1PyjfgnzN0ZH2G6A+Le+udO8G1kO3f3trTqdsQ5HwxYwaFA99p2vX3n7fPmr8Vn
 oiwyJX3yENdSIjxUEXhpJxfZX25xS6Vct4aVKDLVKGJwH9J+e+Gu+kk24RmUYareRqmx
 JQVLygjtarDGq87SVJxrHrl+904q7HOEKmlYFh0v1fFyXSPwSiZBKXITYWhdobkfCm8i
 LfNHXU38O6V/cqIIxzcYoN/GQBDaDIdapp5EYXndcqX4rFd4nSsS0SmvALOuT6+7iFNE
 2hcbD2h7CKILwgg2o53DmZD2ENx81AuP+mWHYYAl7RPWSHsnVaeCexweOW/kZdzrKDZH
 25RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107957; x=1781712757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cvP8aOq+dkmxUYFr9yBP2ILGw50KTwLpfscjHW38iRg=;
 b=QzAe2CJ2f4OtPxNF75C7zyLD2NW7CyVETC3pdg2d9amkfC0xOhMBQ7yOZjj6WYBtS1
 1psnVWiCIZLUKxrhZ4YeguBSm9IbhfPzeOF53TcM2K61bJOGRiTUVXAUMabjMAQK+vk9
 hWuSMtl7fhCiMCplC0PLEyBOOFycwhr3rAY3enpN23e0ZR20us3RUsqcwtl67X3xHjUX
 KgQj1WxJ2tY0Ccz9huiD4nWQGWiyZVIWqOlrCkXRiW3WojZ22cvbYAHwd9y/8omxQ5cb
 +eGUukYNpJ78i4fiwrftNQRnXxvNpDDBhHbd0VbE2Y0gNTfHIee6NoCtnGxQyTu7ORlP
 uAjQ==
X-Gm-Message-State: AOJu0Yycaja89nR1WwWroUoYLE3pwXhEbFUGeuHUWzp0PQW5ZoEv3krI
 tTV5lZVmjN/mQWZQWGq21TSFhMBp5epdJoN22tnbOGw1VBF+H5Ijf8qVRomko7y4UhqjBuocvSh
 Imo8P
X-Gm-Gg: Acq92OG3i219+f3f3gc7PXwlQnft6lQNMc6K5PYew/icrs19BE/PKOLcrDLGV35cEhH
 Frf5tXp1pkSaANToBXLAFb93pQhMfWTpJ/uCzbVbE179xJGhHvgIoHgGAp2nKQ+qbZY6HUyfdz7
 zDeWRJuTBzUFeHHRID9WTpJjlEC1lyDiD/1hcaIvjO0o9bbRkZtqSvy5bCVasTedlgdnpFjKBQT
 +OCVV/TEpJsWZQuyClmLf+ariupDiIoa4t4MHJNR/Dd1VNdFWHjJ//ASO87IG57rW7xpSkEFOr1
 V4UIBzSi6K3j6RGsfpQTLPWVn6OU3WuQm6RWI5IIAZTHr9NcDDjpVFMNrN5L483o7UXNofOkldF
 mYstuBXQrvCD5+3JqZe/5r/7H9Vf/rX+A1APgh4yGyf55L18g8OcA/iU2u40XCOZSltki0ZcChl
 tbIQw9IHReBpr0usns3R223Rob88cstRWDxf17cPxsy6+GOcSrtWrPPeo0oAKN4LqqxjynZN4WM
 xlDFYlNGuoOt9E1Dahwm/180HF81f0H8nRIzH7wrhQ5N5SrkMhFKg==
X-Received: by 2002:a05:600c:8705:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-490c25898efmr474061165e9.5.1781107956661; 
 Wed, 10 Jun 2026 09:12:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/71] hw/dma/pl080: Don't use hw_error() for unimplemented
 features
Date: Wed, 10 Jun 2026 17:11:15 +0100
Message-ID: <20260610161202.2235298-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In the pl080 device, we don't implement "peripheral flow control",
which is where the DMA engine can be programmed to transfer data
until a source or destination peripheral tells it to stop.  We
currently call hw_error() if the guest tries to use this missing
feature, which prints a register dump and aborts QEMU.

Change the hw_error() call to the LOG_UNIMP log-and-continue,
which is how we prefer to report guest attempts to use
unimplemented features these days.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3409
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260529143624.158935-3-peter.maydell@linaro.org
---
 hw/dma/pl080.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 4a90c7bb27..f9f1e3e931 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -13,7 +13,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
@@ -132,8 +131,9 @@ again:
                 continue;
             flow = (ch->conf >> 11) & 7;
             if (flow >= 4) {
-                hw_error(
-                    "pl080_run: Peripheral flow control not implemented\n");
+                qemu_log_mask(LOG_UNIMP,
+                              "pl080_run: Peripheral flow control not implemented\n");
+                continue;
             }
             src_id = (ch->conf >> 1) & 0x1f;
             dest_id = (ch->conf >> 6) & 0x1f;
-- 
2.43.0


