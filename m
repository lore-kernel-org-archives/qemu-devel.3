Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3DDE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mh-0007Je-P5; Thu, 19 Feb 2026 05:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-0007Ai-84
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-000664-0z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso5741295e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497262; x=1772102062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2piwW7x7xa0tuREr3tdoIgKbLpIosN9QvpX7ZD6Am+E=;
 b=Xlk1F06VDS5yTbZzFUm/wZotkhdfnnjLs96kf5bSa3jemUh4PhNCzhvL5RU5pBYPQ4
 orCkJmawjeuBA3bGwyBHXWs4NjJG7XPbKg5jhVxuE+uYlsjzuOqyvOT9QXuZAXShjo3/
 Iuuo4NInMaZK3hF2uePnL0z1NY5C+0pxlnSn34vSjx4AhiWeObqOOcMc8xHHz7PvuzGl
 kq7khclEZXUZO7ipF0xpWWlO7IOnICDbGCzk58pwCsUbE8llC8H8zf6vqb3jAM8EtRP3
 mpuF4pE2hS44Q7VfA1lKBBm5dpmHssYEPZjTA31TZbtnGK6YUgtZ0/uT7mE7Rk8j96Cy
 RFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497262; x=1772102062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2piwW7x7xa0tuREr3tdoIgKbLpIosN9QvpX7ZD6Am+E=;
 b=XEvezfx8FBWMlBuiJfcwJFh79EZtezLFKNv9c+tcevbe/Wlt+Yud6f67Ja7zFQnlak
 jCU2DEPg7yMxYPPIaEY1jUdoNbNCpUG8YC/Q+PZbwPNDoqLY6RPoQX9/6k6l7zCsaz9z
 IIWOdH/QgjWOOCP69xAvZj5FIEe9/dYwjMS9OVjLAgEEOPMpGN2lxiLccOtfK04NBR8B
 ONsJN41z3LBlKFR0wY6FZkuQRoUcO5sD4Bwo0PSHHiV7D2K0TyxjtYvdgqJqY/WlRE7z
 r+X80Mv/aQ/Uskmqg7CO/y849ao9vcogxWqaccd5LbIPsoapIrm9dM/+P4xLm1aD7gdG
 RvLg==
X-Gm-Message-State: AOJu0YxtUqcLUDLvH9MmNd5FqVrYlXP/FvdJNQ7tFpQ/Uvko+iOSwl3L
 c1YbaPgbF9oeHhAqCNVRimrWW8373FZzo2imWLitEU1Pd84QDX3Lu5gRSdT9J0RbLTkAWcAKkkM
 QDfMG
X-Gm-Gg: AZuq6aKTRY2qrTDevRFq3sNbz922FhtOh0netSmvOCbGk1FuQI0df4+wuVlqUcU7Szd
 L83+JoJtCK8gXMidrzg57ni/as0IMOayeNTa1dARu0YTRCLHRR1tvR7TiNnWp/uk6T+5Y2MNYMV
 yr2OKqu/U2SSJvXHwHWgw8rtuvr1jbRwZ/NbS88fqnE6Sf02FkMBBH/xMeTTSjv5e88ZAMwc4Nq
 zxUaaagwOQ1AYI1p+eawMD07j3tnS3M1fh1wDb6BgAJCwuUIzbBG3n/r9hJ4skp9hBnis1+gh0K
 us5IkM6J1cPEtjiqBgTuvY7JOA7veXXmBaYn8p5iToa5PCFohlDYSklJm4aT8+ahsp4ruansIQY
 0X9vVaTq8maafaZH+oUeSuWHiJJumBu1DxC0l/pGVk0aDaFPj65Xp1VK4vqff/GwpsUdTOlahte
 HP/EI7XqpFZGveUbA7tT8eM7eR5XFjsMwFnKXjOkKDCW3bq7U8YmtQQ/xbikOOjgwWWGWn0Zxq7
 3oVhL2ACYipIEi1Wg0rvmJr+oqDVdc=
X-Received: by 2002:a05:600c:a43:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-48398b7d97fmr73122325e9.34.1771497262406; 
 Thu, 19 Feb 2026 02:34:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] whpx: remove duplicate include
Date: Thu, 19 Feb 2026 10:33:50 +0000
Message-ID: <20260219103405.3793357-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

cpu.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Message-id: 20260217204754.101223-1-osama.abdelkader@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 36c5e30a03..b0602266af 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -27,7 +27,6 @@
 #include <winerror.h>
 
 #include "syndrome.h"
-#include "cpu.h"
 #include "target/arm/cpregs.h"
 #include "internals.h"
 
-- 
2.43.0


