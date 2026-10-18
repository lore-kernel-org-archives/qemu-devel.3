Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B603CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3w-0002Zp-39; Sun, 18 Oct 2026 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3p-0002RQ-Ef
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:25 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3l-0002JS-JG
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:25 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-93c5b7f5bfaso259953485a.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330580; x=1792935380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=loq/9z2qITmRvVK4fBqH6nfcxD/uwFc4DDxvLDl7qWg=;
 b=RtQgSQZOKy1dgoiom+MeUSyAPBNSFgCVBlpcEq4DT3ry+Ib49mUyhY5NRSP2Gj8Fr+
 ccr/H8ufSL1cgNcnqSXOZCcOk9tZz9DM5WAeh16UTIl3BXA18jN4irfVNhA/QtDElNol
 7TWBaHKeYNNRTT+GR0bkaLmhKoHM6Z+2ekuDJFg7BrN317kfSX42zVCG0WhbdNNMOUla
 nnSYkADcti/i2rHAvDuDs884Fclsf1QNnZpmpVUtbRbUmofAuMmtz8rQz2TBRyIbu0zY
 cHXncZ9RHo7Ro1vix8kzTgfoBspopAiW3ugFH4FS55QQ52eYHlH0AstJLHBk7RAZ7fP0
 WdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330580; x=1792935380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=loq/9z2qITmRvVK4fBqH6nfcxD/uwFc4DDxvLDl7qWg=;
 b=wZv9TFGhxLIzMOdEQv/ymM5aou9MLb3XWCrGgCjr4y04gzG8hW/+UrPvSwS5bD0WRF
 EpSb7Xj0vzlt4zwY8a4NQNYwMdkVDgwuQgiF8+3YEvJ1FAb5wz0KGchZDz8V1Os5RT0r
 TuFMPoH702AfWqcmk4ww+Fp7zrVNuHzCzSmYXFyy0lUmCmS/G7XGxKueSCTEEGKiHFWc
 MLeppbwGcaHc/nQ+6x9SBLudFuZ5nR2D2RVtvLlbr4//ZKOkiL2UdN7Eth4RZL2Itk3E
 EsQnvFgVwc/L9jrmYQsCE6wc+Dno+wCALcpVnF2yf9LNiCjU5x0r4pWF0fcj8aSagldO
 79dQ==
X-Gm-Message-State: AFq9FYIaSVU8KXpLHA+a93Y/JQSshFX0GV6Zv+O+VzQ+7RTvP6ywUyY6
 PDVcWbbYXW4gp76aXz43yiRQQuycM6f5/tJK3IyuywLjUnJFV4y7aZUgJ8IHLkls
X-Gm-Gg: AYBFou3dI531cqMNVq8G/pjpojCI9+hO8s4nODSyYMz29vBcLJrZzdFbqMM7iiMEGf/
 8Cags5czgsYVrwuiCl0/IstvodKfjpzxn++Uk2+rEeSf70iTUtf0L7YvmpmAQTTng0V1XZftpcz
 krB9L/CR4u4S8ounUO3eJy1lwF87MGZkZoO9xcChyfr9MwetPYabTRHT27CsOBZtQSHZIKPli59
 XRnFMfSZY0X/a+a9PxRLKF/HTEgiZz/Ufi1pQh5pw3rTfYOl4OOCPQV78ecUs6kZxlutbcxqlT5
 flYhEfvbLj6yxbwsPqZpo7vacd0e+7SuJ8rQ5taSJmXMF6hGd1/Me/UBqiIRua2QJ/N8k99u4XW
 NW0RJrBgq1qbCBuMfxrNmOcJTNI9UjMDnEhozgUWhsyTjeid4/55e5tLTLdvDORXghFeTyNNHD1
 3reVcmO+hk9+t1UXRcxUKdG7IjOxfBhSjEfaw7lkNfp0Og0GNth1ga8E0ukWn3rjicQj8L1g68V
 Jo2bZ09aoFeUiiRx4aRSPSe5zq0iQh7yLc7qNEKYXdRsjnsS/4/JmFhIFpifOksj7SVIYE=
X-Received: by 2002:a05:620a:3196:b0:93e:5534:e63 with SMTP id
 af79cd13be357-93f29c8858fmr821602985a.13.1792330580080; 
 Sun, 18 Oct 2026 06:36:20 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:19 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v4 14/17] hw/net/bcm2838_genet: add migration state
Date: Sun, 18 Oct 2026 09:36:00 -0400
Message-ID: <20261018133603.64323-15-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The device had no VMStateDescription, so none of its register or PHY
state was saved or migrated. Describe the MAC register block and the
PHY, shadow and expansion registers, and re-evaluate the interrupt
outputs after load, since they are derived from the registers.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index e20358c8e7..643ee3ec0b 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -17,6 +17,7 @@
 #include "system/dma.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/resettable.h"
+#include "migration/vmstate.h"
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
@@ -1129,6 +1130,37 @@ static const Property genet_properties[] = {
     DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
 };
 
+static int bcm2838_genet_post_load(void *opaque, int version_id)
+{
+    BCM2838GenetState *s = opaque;
+
+    /* The interrupt outputs are derived from the register state */
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_bcm2838_genet = {
+    .name = "bcm2838-genet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = bcm2838_genet_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_UNSAFE(regs, BCM2838GenetState, 0,
+                              sizeof(BCM2838GenetRegs)),
+        VMSTATE_BUFFER_UNSAFE(phy_regs, BCM2838GenetState, 0,
+                              sizeof(BCM2838GenetPhyRegs)),
+        VMSTATE_BUFFER_UNSAFE(phy_shd_regs, BCM2838GenetState, 0,
+                              sizeof(BCM2838GenetPhyShdRegs)),
+        VMSTATE_BUFFER_UNSAFE(phy_aux_ctl_shd_regs, BCM2838GenetState, 0,
+                              sizeof(BCM2838GenetPhyAuxShdRegs)),
+        VMSTATE_BUFFER_UNSAFE(phy_exp_shd_regs, BCM2838GenetState, 0,
+                              sizeof(BCM2838GenetPhyExpShdRegs)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
 {
     static ResettablePhases unused_parent_phases;
@@ -1136,6 +1168,7 @@ static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(class);
 
     dc->realize = bcm2838_genet_realize;
+    dc->vmsd = &vmstate_bcm2838_genet;
     resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
                                        &unused_parent_phases);
     device_class_set_props(dc, genet_properties);
-- 
2.55.0


