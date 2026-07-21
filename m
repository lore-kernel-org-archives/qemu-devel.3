Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB4BC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6C4-0005Tv-3Q; Tue, 21 Jul 2026 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6C1-0005TQ-Hz
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bx-0005in-Mr
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so51609135e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623868; x=1785228668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnFuMaGFc/9sU6GfqW0ud+aPvT0FGc61xYGm2SDQqU0=;
 b=ZIBfJrVa/zjUdNv6MLWBgG/iTT+ogkBASBnak/JGoGyMVWz/6IUZWlW13VmeN0IUup
 57VlV4tOlOV0YpWjcjajpyLPyJcwbjtHgpx/ujhHsSrHmA93i3pbKkHDXWxZQU/6Sfdh
 EIS7ARFjngWCYSQEEis7hBXRVfISaRVUOS7rEwrsu0AAwXO9hGcmvlZ7dSxIGzESABMe
 p8tZXOH0/7SQOSEHlfzo8rP7UMKrPOMvVpfXYbFS97kC+lnL0RTFEHFhev/84Yl5RH1k
 yn+k49b+es1YvWtqxXWyFpsEO45+6nZQ1pYTqbrtElatmaDyJ2YlVAnLP9VY38g+pCaS
 lREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623868; x=1785228668;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wnFuMaGFc/9sU6GfqW0ud+aPvT0FGc61xYGm2SDQqU0=;
 b=DLFBw+n0PAC64+GLvdmRGHDhKh3MPg/arnY2UXCSlVicVuqs5JY8vtvIxtGcg0FwZU
 NWS4ZYuLQ9ukS4hJuAMAt8IJUOuhYP5gIk0rIlFC0r3Pys6PoXMJ4F510jyySiUoD3Iz
 ja7+dxTyeAxUULfme0b4WGrAAHBfS3iGoVrthyQ8EEiB8wucz452gY18es/eHr88FIt8
 VrUR/MIjq1CZDpSJ0STcQ4dJ3nWSBP03/yudYWqKAWqRYQOUveSVj6SyG4TF8iGmy9Ec
 0RxvqyhnX0qFPcnbQ0q4FYgYrSwPYJd7HSuWAgODq/sr1pQOE+fqinqWIuVnJdjhCzoA
 kzxA==
X-Gm-Message-State: AOJu0Yz7uM4NT92hYnNgMVFSv7SLrnOVis3vJPCKZX+lizx0DkUwyJ7H
 PJPJpP2miIqf+Zo5uvnIrwMQ7x1u/oAqSrvlZLayta8kNherJ7uuLQlyPJVte6S5tqUcFw1rHvN
 kB2V1CVjeew==
X-Gm-Gg: AfdE7cnVH5MD3LbKmd9vdx39DiTZ/7yJyh9gRVsePC5cOmI1on1S/1TkzuRZfBbantG
 J+0DDcRw9qDF2hewBz4+VatBBpL/SpAry3VBfvB0J3Ca1BUw8aQWlnioUUPxu+xmoY1aUo4ktg6
 blWERe00IQDVMmbdTwPrJYBx25YDMvjEAyAH+bvqJppnVarKREDJoBlL9gyuuFRANeXyfsP+JDH
 5tOf5vDiEMPiWlkTJB0Glhjlra2Fvabbuzm2tTU/NtsUzhQFHG3OwW3B9SwOTda7mW0DuHdi/eL
 6sPUQPgK/aimz3xnAcgJJ8QA0D0X/8/oFF5uXw/V804RbUND/WnL6zy1Q7LyizuBOfDU7U9pVHG
 TWp8Dya2ObFymWZsHdQFW7vBI8kYsFCGC44lQdWjKTrrJEjGscGpUwlLIUwn7O8WzoF1ThkSd7E
 FyYTB29mUPuSWYNe1up9g+fqqal5XlWoCV9b75bv2CW2ZsVaU8bT3vM9cNCYvtx/BVOs3EP4GB8
 Z3v1dNRL8E=
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-4954a3d06e4mr188805355e9.5.1784623868302; 
 Tue, 21 Jul 2026 01:51:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] include/hw/arm/omap_dma.h: Move to include/hw/dma
Date: Tue, 21 Jul 2026 09:50:48 +0100
Message-ID: <20260721085050.421257-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

omap_dma.h is the header file for hw/dma/omap_dma.c; it fits better
to put it in include/hw/dma/ to match where we have the .c file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-9-peter.maydell@linaro.org
---
 hw/arm/omap1.c                    | 2 +-
 hw/dma/omap_dma.c                 | 2 +-
 hw/dma/soc_dma.c                  | 2 +-
 include/hw/{arm => dma}/soc_dma.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/hw/{arm => dma}/soc_dma.h (100%)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 9e739a07122..0f78cbd4104 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -32,7 +32,7 @@
 #include "hw/sd/sd.h"
 #include "system/blockdev.h"
 #include "system/system.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 1a3ae747269..16575e73b78 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
 #include "hw/core/irq.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 #include "system/physmem.h"
 
 struct omap_dma_channel_s {
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index ff890149ee8..4feb22e6ea3 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "system/physmem.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 
 static void transfer_mem2mem(struct soc_dma_ch_s *ch)
 {
diff --git a/include/hw/arm/soc_dma.h b/include/hw/dma/soc_dma.h
similarity index 100%
rename from include/hw/arm/soc_dma.h
rename to include/hw/dma/soc_dma.h
-- 
2.43.0


