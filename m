Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=06vJ4Qu+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDN-0007sg-9k; Tue, 27 Oct 2026 10:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCf-0007KD-4D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:07 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCc-0005BS-Q5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:04 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-93e515769d3so394263685a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111462; x=1793716262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijtlAWqZWpD6B5Iyc6vFSWbfoujtUcEyGBK5qU2RLO0=;
 b=06vJ4Qu+oAzwxaVnivh+tQVcsV/ExT+kcWBPEDoCftCCsr4KmCLXhhbgNv9moytUyZ
 3bADMz0vjJ2SJT6ycoOjsaW3y1FwIR5g1cv2CUH7kt33OybnveEHyydYdTbPPdS/W3Wy
 5P+oh+EiNApKSFJcDK3wDH59odo6NC6kTNZmkyQuErWiWRUq/xZM5HvdZDV7j801dxJq
 qCmg3UmkpxE7318wAlpXE0KBePb5MXcrpffeKOJ4+4HkiLkUVp2k8dJA2kHfFf87Dlqe
 YkobdWoH9IgZgl2zt4/ZtCob0oXi5psy7AF0ilEQ8fOmMC0WG7u6rvwc8Zv8WiaBOZXj
 +neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111462; x=1793716262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijtlAWqZWpD6B5Iyc6vFSWbfoujtUcEyGBK5qU2RLO0=;
 b=Bahzw0zSFHKiO+e6CA10sDNtaU5oHOrfXa+fZxh44qquEMjeK4Tw1h5hQO47kav9aG
 Hwx8mVN5R1+ZDZ+oJlfADy6yIPJltYrnvOlKuLAC9jYg5kUx302kjn92MwgxCSdRLyeW
 a5etF+B2G8sjZ3I8lD5CTy1VUf20sGASNIA+gFAX+i1JTJnBJRyfB723P+7Cz0/KPy8r
 5Mb8G3ct3oA/Vdual13UN8NXnhn0wTqn4IA2rxq3olD4uSPk/h8V60buCfXrHeKmOkAc
 cCGp/WaRMpFFbpbzCgJojwJJbYe0K3XyFr81StiWQKVB8Bo/TiMn32S4HWWREgCUfbOJ
 ykLg==
X-Gm-Message-State: AFq9FYLINZnPmwEyac2LI9f6Z8+ponsuuvONo4r/Ir/1jdhRBmMGugEL
 jPuXH2mnJqRzVgbBMxsOtiZRxUQHUjW15onyHIrFKJAojCCtixgXAQ5INnASnthj
X-Gm-Gg: AYBFou2QnRn2tU+p/7H93JehmelzkFI9b6pMx9tVlYolcyNT5X9kNQY6q4a5KRJ+uE3
 WH2JefcmA2wpmu1CUR6UrQOlo7RJMr/mz8SM9samtrsgOl1qpyxheveLLicevYi18QmwTN/9bIZ
 cn5CXS4O5Jxs8FBbYj8tYLUJlIEnkiZY1YONHlT+56gL0iYxKpkoX6CcsdW/XQdHCOrWk9SIby3
 TQOZCnPmZwZ5imxwddwVui+LAs8trYyx9cdCmyYK+iGdCnkr7fVZBo3XnZc1oSPFyHBKiO31oAB
 t98yylAwnwxFA7LvgSkHl+CknANPelaaO2KH3bq8OLxUdyR2LzG7x2iIqz1pzeYMGgFPh4uBV1S
 2Exd6JyaYE0vFpCcY8PENpKRCUPY4PqVx8KheO84Za2PgoYV8O5eVZFulrG97GOGO1ohQc2pBjN
 sYvS9SwsUNHksX89gecWThjHd3o6CR1qm74VI8QP4TdFk+9QKbJbVWQFR9mGxAaXaxlrQo9EnYK
 Mgb+m6e8rFMaQydd467VyUtieU/JYL8aoK8TBe7IhdVbz5h/081CvIrTa048wMNL+apywSB3FDX
 Iu/ASrhLUkRvmlm/uFA7++36xbbASGNyhutbuuIfMRuCWgTLxXs=
X-Received: by 2002:a05:620a:6187:b0:93e:9508:8360 with SMTP id
 af79cd13be357-940ef914a88mr1714847385a.27.1793111461436; 
 Tue, 27 Oct 2026 07:31:01 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.31.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:31:00 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v6 14/17] hw/net/bcm2838_genet: add migration state
Date: Tue, 27 Oct 2026 10:30:33 -0400
Message-ID: <20261027143036.44973-15-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 hw/net/bcm2838_genet.c         | 23 +++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h | 22 +++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 840a1bc72b..53bba99b38 100644
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
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 87a59941ec..2420711a29 100644
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
 
-- 
2.55.0


