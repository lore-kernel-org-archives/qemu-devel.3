Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673EBD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUad-0000F9-AL; Thu, 29 Jan 2026 11:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaO-00005H-7S
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaM-0006aL-JW
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so16561245e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702973; x=1770307773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ckk3q/EmqlkqmYKXWb5LjFCrWrKBLmaPbXOkEvFedwk=;
 b=scaWKmitWeIJobXt5s0v26MncHN1pu3+RvJBihYpQ7+CoDk0k4RhPylTlmgQwnNRa4
 GU1ZRQ5SSwn0UIZ7l7OPtZV2Qu6VMJQV43lmRePYn2kbc+vTyzNnxgWXtrOjV+E8T44p
 wOAmN4bFAzJGMKF1C4h1xLQHeHlDt6054ZUvzZ0NgC+QOWCjm9bAcP+ao+AfiQ5ybFvX
 8aRRnTI0UMGU8/mM/ipwhQNImdylfQ9RyGhymaGAxnZkAtThij52IytKDdLyYM2L1iZ+
 mMmlUx5AnXA9BJ0IFQnM3hZhL5+9tHqYYy23i1zlO3zh2ti5MbWcpWT+7vYuXZ3p4cwc
 CJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702973; x=1770307773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ckk3q/EmqlkqmYKXWb5LjFCrWrKBLmaPbXOkEvFedwk=;
 b=LFwNmFs3bIrF3S+tRoB2K23OXOLCVjL5lnov1RAhB1e0OFYsHlbLfpt+cp60/ZFNgE
 dBaqCjHMcIygDpnbPCGkQmpDjfU6Ly4x7XAFZm/fxb2CkQDctXJn1HtJgMtKGgzMaGGh
 byOWS9+TUTL/ZbLDqjtmStoTxyYuL4mPW1iHC/CKTjAoxdehCxAbhqgVYrgqhMyUrlBG
 55bBzJL3omxkZGaddhnkW3V6O1zjdhwMCpmecH8IJRdzKeHkz4/J1JolhWKTuONuV2ZU
 4bvHJqTiZr8m0F7pMsihkAeniFyUX6ODMJHBEf47WJxEx6aalZtZbRMTCZv+Fpkpn9aa
 BEEw==
X-Gm-Message-State: AOJu0YwruEPEZhj8eYYBRNnr2p7hRmQrzKgmXvDJlr1X1qgzKa5Z/SR8
 tNbMsRf3zleCPr7uF54SpLYy5Oq9a9TDLZ66IcohLvl3FgGGyYVCmXZCqehpfzfeKIXzzVLVcdG
 wtyAyhvo=
X-Gm-Gg: AZuq6aKaJLhi88aZCmzh+ib2P9rNJKJxAZpRV9UxpCga3ezhu4ayBETxwanbTbrUgM3
 bnyA548EaclUTIf0IXGLh4CqJuYRW5AYgAtYfQFwxwkjUIdi25t9VU82G7t6k782RahD4fQXau6
 j42JZqMxV/85gn8hDLaLOIArKaE8gn9qUy4d9FhYHUWQvGKUTgiq/s/rRkCIMprTrHUEMGPOKCU
 x4D2yDZVW4FR0VDNwvGQLjN3K95f7Ir08fTVaA2ILA1uAu+cw2mx4eL06HZC/S3QFJuYPMxMTR6
 QunRoUSGlitUWGhWc8xrVBK70i1tghHVI3C1ua6Rifw6+FIaDIc+349ZZjOr56GPR6ZFQQENyLa
 Qzmav/jPIMYJTSYea7C0SOf05m29yjXAgs4D+uHco7volyps3BzpN6HTVxJ1rg8XyUb842pAVDI
 cP5JSaqRyCxg3RoYSU60ATlu8BXH3dxT7mQAQxqqOF
X-Received: by 2002:a05:6000:2c07:b0:435:932e:f932 with SMTP id
 ffacd0b85a97d-435ea09c280mr4879535f8f.7.1769702972869; 
 Thu, 29 Jan 2026 08:09:32 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/43] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Thu, 29 Jan 2026 16:08:45 +0000
Message-ID: <20260129160917.1415092-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-12-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2fcd301322..be09cf8b73 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/core/iommu.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
@@ -129,9 +130,21 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
+{
+    /*
+     * We return VIOMMU_FLAG_WANT_NESTING_PARENT to inform VFIO core to create a
+     * nesting parent which is required for accelerated SMMUv3 support.
+     * The real HW nested support should be reported from host SMMUv3 and if
+     * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
+     */
+    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+}
+
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .supports_address_space = smmuv3_accel_supports_as,
     .get_address_space = smmuv3_accel_find_add_as,
+    .get_viommu_flags = smmuv3_accel_get_viommu_flags,
 };
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
-- 
2.43.0


