Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2C606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pdrqEoxk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCo-00036o-Rx; Mon, 02 Nov 2026 08:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCn-000367-6r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:09 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCl-0002Fz-DT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1680406f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626566; x=1794231366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yrw4jVDKKQ9/gpmh17bdCll8kHFC/f5bCCnLIuSgMXY=;
 b=pdrqEoxkpzj58H/0IXpAcHj9QRXVfVQ21JFljBE9Bnxww65Y6T6SYh/Lj/id85pZHQ
 gwGFIIlGTLn9z6U1SXq4aIHXGnrKqsq83Ti+ni2bp8J2s2uRNe32MM3l1xUgCaTBM5S2
 IQQKsNUnsL40SriR9wl/Q/NUhV9D4P3iFPIFbmTRpagXmCWT+eE3RWqV+lgiH+LKNygu
 BDSqje2fuOKIiAQnk56Ip2G8KsuM8bv+6L8fDVLjZFcX4vbNRa8FJPLklZ3jqRVyk7jb
 EGZir7hh9HQeiH8Xacmcn9j6//AUnoK8jAOfZVgtu9azohqqW34VhuFXaG398QDqA2cv
 0UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626566; x=1794231366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yrw4jVDKKQ9/gpmh17bdCll8kHFC/f5bCCnLIuSgMXY=;
 b=LLpbQyVDZqXfabHXiBPHzGSmIsQyBv8dFNUC8B0ng2gEOJWs48++V6IjI6JlcVcK7j
 mPVYeXWi6EGNhUfENC4lW3XYHaUi0HT/M1WMVc6TkByORD1aBEvXgH4Gd+/YCXNuY96c
 Hnp5z4bjPxT5shYj5hnLmqQXFLAXcMPTfjJ3/AdD8JhG/CH7s7QFwp3FSJEGxPnJUCsN
 C2+N58XNXgZNo42idHkJn7ljQ2Oa+TfBEOsMNXrQwxxLwSjuOF1FGs/Y7UreRcq6uizX
 uUOKC8npghf/7X1swiaKcgPICXHTKjf08O1yHlhpilhcxZGX2yEfj9Ltp4tvC7a42Q14
 UDbg==
X-Gm-Message-State: APuU4Z9ZYm5gz2tcKmsev3Sod2b/KavvhT8MVRakQAvMN06ObBB0JN8L
 IVP/NCPIbhA3dVe3VyyTnHbZTEew6QufDKOvU57v+Ec92iCI6MvFYC09gWTOS/l48vzTmqyVKyw
 T9r2fTTM=
X-Gm-Gg: AYBFou1+b1pagYxROyIOzSuTXyO6zoYPcdv5BSJVggcmJ7tWVs7ZYfSQsu5crvx5fD6
 l7diAg483YI5WEfPB+oFJyx0LCVsUyLvEeqlapK89jfyKqGkoIZVtVfMIsBzlWssGua3tyYflc+
 oLEz7z+RcTrLy8arls7mSCUl6/H75Uhf+D2Gz5gElNEgdpjuxICwXRFac1M1QXzQU5hegH5AbVh
 gvYJ2YavPN/o48RRyQy2Fzry1Vx83z6zXt9of1/09NUSMGpxCEZh9bp5IQJCGHpa5I2gowSGFIL
 sxCf9abNIvNuxKLHpXxB27gY4Cm56T4HgWYn1gvyMGJG9jk2McI/b5kGkuG9hBI+bKyFy/uOs2i
 mQ0nbXO5Nyn/bro3F9WRHZ2Zf0tB4yrPoNfZfv5j2pqcs6v/0o7PcQwD+TYt6AWDt9QnslpQ3y+
 LRlFL+JsTKSl4VOuIAt3kJmNOjLAW1zefa9TzZEwaQs/ba1MFRGkrmSZKlOO2z6283A5SzBquya
 qozhnDynYj4ASnxkWq8L0rnbu3mdvGR4jsGx4ciknfqQNScfGJM/B51RGvqX7GmkhRbZEAdeX3P
 LeeBPq15E7RmAbk+Xu17xAZz5p6Yr8Im2LU3s6ewg+l+lhwRQGg7PDy1nEjUdQYDCSBDovVIge6
 GLg/N9x8w3Qd9T+BvEFmOieHIpM3RffFxnPPvPmLyl7shO1+5cNy/eGg=
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id
 ffacd0b85a97d-48e6e2f6620mr22204076f8f.19.1793626566020; 
 Mon, 02 Nov 2026 05:36:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/47] hw/net/bcm2838_genet: add migration state
Date: Mon,  2 Nov 2026 13:35:14 +0000
Message-ID: <20261102133547.1375701-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

The device had no VMStateDescription, so none of its register or PHY
state was saved or migrated.

The MAC register block and the PHY registers are structs that contain
nothing but uint32_t (MAC) or uint16_t (PHY) fields. Overlay each with
an array of the same element type, in an anonymous union, so that the
rest of the code keeps its s->regs.foo style access, and migrate each
block as an array of that type. Unlike describing them as byte
buffers, this is correct when migrating between hosts of different
endianness.

The interrupt outputs are derived from the registers and need no
handling after load: the device at the other end of each line
migrates its own state.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 20261027143036.44973-15-marcelomanzo@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 22 +++++++++++++++++++---
 hw/net/bcm2838_genet.c         | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 87a59941ec6..2420711a29c 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -409,9 +409,25 @@ struct BCM2838GenetState {
     MemoryRegion regs_mr;
     AddressSpace dma_as;
 
-    BCM2838GenetRegs regs;
-    BCM2838GenetPhyRegs phy_regs;
-    BCM2838GenetPhyShdRegs phy_shd_regs;
+    /*
+     * The register blocks are named structs that contain nothing but
+     * uint32_t (MAC) or uint16_t (PHY) fields. Overlay each with an array
+     * of the same element type so that the whole block can be migrated
+     * with a single VMSTATE_UINT32_ARRAY()/VMSTATE_UINT16_ARRAY().
+     */
+    union {
+        BCM2838GenetRegs regs;
+        uint32_t regs_u32[sizeof(BCM2838GenetRegs) / sizeof(uint32_t)];
+    };
+    union {
+        BCM2838GenetPhyRegs phy_regs;
+        uint16_t phy_regs_u16[sizeof(BCM2838GenetPhyRegs) / sizeof(uint16_t)];
+    };
+    union {
+        BCM2838GenetPhyShdRegs phy_shd_regs;
+        uint16_t phy_shd_regs_u16[sizeof(BCM2838GenetPhyShdRegs)
+                                  / sizeof(uint16_t)];
+    };
     BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
     BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 840a1bc72b0..53bba99b38a 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -17,6 +17,7 @@
 #include "system/dma.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/resettable.h"
+#include "migration/vmstate.h"
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
@@ -1135,6 +1136,27 @@ static const Property genet_properties[] = {
     DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
 };
 
+static const VMStateDescription vmstate_bcm2838_genet = {
+    .name = "bcm2838-genet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs_u32, BCM2838GenetState,
+                             sizeof(BCM2838GenetRegs) / sizeof(uint32_t)),
+        VMSTATE_UINT16_ARRAY(phy_regs_u16, BCM2838GenetState,
+                             sizeof(BCM2838GenetPhyRegs) / sizeof(uint16_t)),
+        VMSTATE_UINT16_ARRAY(phy_shd_regs_u16, BCM2838GenetState,
+                             sizeof(BCM2838GenetPhyShdRegs)
+                             / sizeof(uint16_t)),
+        VMSTATE_UINT16_ARRAY(phy_aux_ctl_shd_regs.regs, BCM2838GenetState,
+                             BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE),
+        VMSTATE_UINT16_2DARRAY(phy_exp_shd_regs.regs, BCM2838GenetState,
+                               BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT,
+                               BCM2838_GENET_PHY_EXP_SHD_REGS_CNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
 {
     static ResettablePhases unused_parent_phases;
@@ -1142,6 +1164,7 @@ static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(class);
 
     dc->realize = bcm2838_genet_realize;
+    dc->vmsd = &vmstate_bcm2838_genet;
     resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
                                        &unused_parent_phases);
     device_class_set_props(dc, genet_properties);
-- 
2.43.0


