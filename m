Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E475FEDA0F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZhO-0005XA-SH; Tue, 17 Mar 2026 15:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhM-0005To-LU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2ZhL-0006Yp-74
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:03:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso51877085e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774201; x=1774379001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ogtAdg1io2tmYJL4OBn61XdrLQJF+upnENAOxmRCTJ4=;
 b=faPGUxRWQvZlVccbbJH3N9pPWd7+Wacyag9YwIASm1rcNA38xu0NjSXV3EF6NQy5u3
 fTMJeZcr9LvZUNkbLJXixXry2mLbqhi4iaMjwXoyZ7QOSJVrRzCmU+P3AfxMyv0Nea5V
 f6qYA171raGW4xChR8lyPwRn3aWZFlwm/bMPqlch0x4kWf/R9k0k6RB5O+oVeLIJ8vOI
 9QXisnWlQt5xtB7T92YBjSRLd1Oa1KslWwyQ174qwluXxx6h8CsYNxx5E5h+Qy3VOBdI
 Dex1Xv+deMMXBJsa06us0opmZE3Ule0X7+rEWgmBYFDI260G+k8iFucMVQY2vjptMhqI
 qOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774201; x=1774379001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ogtAdg1io2tmYJL4OBn61XdrLQJF+upnENAOxmRCTJ4=;
 b=JueJXMuIe+GHt/wRuGRGtaUZa8eD8lUMGEOHPuxoLjtxJ+kGlBu/lVg/p1bkvLB+V+
 lCBLpUSvDzFLza/1Njb8kw6OQTAcIZPSKwlaNdgRaGGOR8Md5HTuYTK1XDbKRFsUPth1
 DtziCG48rQ8GQxdeCgZ6Ae6fFs9WJgqChpvcCtPfS+/df97M9sVAuFfYGVStLGGZReW7
 9qUoDbRDesbGfgVpn6F/lNlJ+KjX+xFpswbPLMk8XLTFX/rFtCx5ZSjwa4Wi4yDbf4Fk
 hdg1nqnllx8u1G2Lt1oLf1G927AHt+1cGucHkX6zUEuDe143Accw1tZUw7chBNhLYoTw
 uAFA==
X-Gm-Message-State: AOJu0Yz9CojJS2A30DWE6b1I3pQipSwO6YJzDYbixvEZHuJAUK/DKBxp
 Tz99OvjjJXS306LeiLZHerQpCYwyncF7JiTu59uaP8WdCE3IBqZ2Y6J1tVZN9DBpl8whlah5ptn
 gFJi+rN8=
X-Gm-Gg: ATEYQzx4IQOycPVBKsTzER0iPEBoaPxZoBvZ0ZP/S1ZPco1/OAwIzJcFjEgPFjFqm2C
 K3eO3ngth/LoIiV42LDbN9wBkAOGA/LzkENWaiS8YnlEiPC3NvkhRyIvete5hvTwigINy2oi4lw
 1jFqIncc8YPpfoP2KyeG3AK/mXiU/XXu8+tlYPm/K3whdzMGUIEE4ffc1yOHW31WWAG47IZ7fwe
 S9EUoyVkrbuGu5Zc7RBUOXEx//JgTxr1bO9keiz8dEb88CIEZ7mFEQzGwO0VWT7/XexVNOV40jM
 jWRfEwRmyyiOF6TU793Ytp60WC8i7QM1ZznjsOjRmRFLo+FlIcL+1SMv+QoDXVz/TmoPyddvGtl
 pkCmrWUMl0n5RiUA3sSQgCzq4a5lKvrEMio3lHhZnY0ITkzjgQ56c3gP5yHMTQpVBhUKGVyuEHM
 tfPi7btAKxWqOvm5eVxiySxZmW50qwOBjhcqTDt+xP4LzL4Zo5q6IHvJlQEMUGq302FbY19altb
 qEWSDK/Mbk=
X-Received: by 2002:a05:600c:b8d:b0:485:3a27:a961 with SMTP id
 5b1f17b1804b1-486f421ef58mr10897135e9.0.1773774201040; 
 Tue, 17 Mar 2026 12:03:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4b810bcsm386045e9.15.2026.03.17.12.03.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 12:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hw/s390x/vfio: Replace TARGET_PAGE_BITS ->
 qemu_target_page_bits()
Date: Tue, 17 Mar 2026 20:02:49 +0100
Message-ID: <20260317190250.70506-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
References: <20260317190250.70506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Get the target page bits at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-4-philmd@linaro.org>
---
 hw/s390x/s390-pci-vfio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 8ce44dbecce..7c754b656da 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-helpers.h"
+#include "exec/target_page.h"
 
 /*
  * Get the current DMA available count from vfio.  Returns true if vfio is
@@ -150,7 +151,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to request that the guest free DMA mappings as necessary.
      */
     if (!pbdev->rtr_avail) {
-        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
+        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
         if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
             pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
         }
-- 
2.53.0


