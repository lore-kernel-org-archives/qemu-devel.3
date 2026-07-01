Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D86C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf3if-0001gg-0G; Wed, 01 Jul 2026 18:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3id-0001fP-M4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wf3ia-0002Zx-W2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 18:47:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-472a14c9965so1020153f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782946063; x=1783550863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjFztGb7C9MEWIW5wBfGcj8wgciULOA+rIFwIPLrLuI=;
 b=Sk4I5xNxk+yz8P1zxSEc9wszfMTLRdSjgqIrq8sTjqr0OsfMvZq5wAcPI64i1B0IPx
 e1iVaeZq/7MoyB+l36Xey9s1vJM5OwYAD29GXKiZH4p8qE8WIrQuJp1IKIeM4FXYNnFn
 fypyGh5+NPAXqly7Bp863J0XkZ3+eZchU+5B1QV3bxlM85X07ag04GA1CHRM+CgEdm+K
 R6SX8XRLsS+P1LQ+loS7JMerc9dLSB3j4wYuamW15ncHGNAuxOiOv/4KLSHzJRh4MS4x
 02BQc/wqVC8PCHen5CLvNwiJwF9zLbJ2Sx8fEr1KD/jm+SIPj/w+8LZye72dxDUK8EHB
 cknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782946063; x=1783550863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KjFztGb7C9MEWIW5wBfGcj8wgciULOA+rIFwIPLrLuI=;
 b=TLDkii0eRrwKsuQsQEoCloVyTifYaVgsk96sbYuJKpxFD+f/gVsV1fl6JSRvVCagtk
 XCN+JCPNQ2ajor+nhjgS8tVmPQU0VdE4+N+oNyTd2RGqktS0dO8TffonypPtGKFs8Hmh
 UWhqmU33cLg5Q+o7srrH2T22gU4zVO6wTtAm5QU1yDlUjQLIsrG2X0gyfpLsf7F6E4G5
 e+IYqEpNcJ+qIWLLk0A2W8zRyDPTlSDUBSOy/1JRLfCC2hJvEShOkIGhSiZRY+Oq5v/K
 hHpBsjCXrQ1tX2VX9DlQijrVhAhQ8ZQhvn1EEUbYaOg0ZXDU6i1SazbPoO17vSeldIne
 3pag==
X-Gm-Message-State: AOJu0Yy1UOQiBTFcjrjf9WIuTJSM4JkE9Gxjx3WxQ9wLu6bCYKeZdAnc
 YECK5pBTtZSbUaN3dAx4V3TB0QFziEAGWSaxNinZhMTECcVtE0HOOyt+t4Op/w==
X-Gm-Gg: AfdE7clM5ct2dWL0S7KCHHgdM328deYa7vUNd4DQXMgo5mDl3xIFeFhS0dKID10Np1V
 vh9DU1Pz9dZdiDG+vfsB0Eq5kxUg3N423UcLxyulLv+Cm6XWGxi7MQfdhHCc98ZZefOx7FqY7zB
 1iCe/phwHURFaAH8idWgyN4WP2LL0vmNYHpJnfGYcOWdwY6hdDU/AIAiez1okaYh1sF9FYe7r2c
 BSB243Dytw874DxH/lYwrUmxbP8XgYeeMe4/ksBglIljdAAPPvRl7CiAdiKwsB9BHH/BLnvmEMj
 k5PL71tsr/c8Bniyfuh6fTtRQsXpnTY9AdQ1YxCWS1Js17IwEoPtTpUdhrArVPFFCX5JkFzr1XL
 yHdK8jLxhJogv7D4pPo6JRu1Nedn827TXIheVrZ5wGq0B7UNQWTKTi19/+tCXQpJkRfWkkM/mBY
 JhVffMSU8iM/NSI9e05jYFoEaAY7CRIBpK1dEKoCsRW400OaYP1vrbFRlOpVC7RS54yOMNEieqb
 vy1iov1/f4VNoDMDcCNtzod+7Y945uensThqJ8uqzVn3PM=
X-Received: by 2002:adf:fc08:0:b0:475:cb71:a344 with SMTP id
 ffacd0b85a97d-4775a0fe280mr4531259f8f.37.1782946063237; 
 Wed, 01 Jul 2026 15:47:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2d44-b300-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2d44:b300:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm3178614f8f.7.2026.07.01.15.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:47:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/4] hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
Date: Thu,  2 Jul 2026 00:46:09 +0200
Message-ID: <20260701224612.48342-2-shentey@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701224612.48342-1-shentey@gmail.com>
References: <20260701224612.48342-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Subclass TYPE_CAN_FLEXCAN, yielding TYPE_CAN_FLEXCAN2 and TYPE_CAN_FLEXCAN3.
Since TYPE_CAN_FLEXCAN is now abstract, TYPE_FSL_IMX6 needs to use
TYPE_CAN_FLEXCAN2. TYPE_CAN_FLEXCAN3 will be used in TYPE_FSL_IMX8MP.

Note that Linux performs 8 byte accesses on the i.MX8M Plus, therefore
.max_access_size has to be adjusted. Otherwise this results in bus errors.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/net/flexcan.h |  4 ++-
 hw/arm/fsl-imx6.c        |  2 +-
 hw/net/can/flexcan.c     | 61 +++++++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 153afc1e03..32de7b904a 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -139,7 +139,9 @@ typedef struct FlexcanState {
 } FlexcanState;
 
 #define TYPE_CAN_FLEXCAN "flexcan"
-
 OBJECT_DECLARE_SIMPLE_TYPE(FlexcanState, CAN_FLEXCAN);
 
+#define TYPE_CAN_FLEXCAN2 "flexcan2"
+#define TYPE_CAN_FLEXCAN3 "flexcan3"
+
 #endif
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index bf106a9063..57cdde971c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -92,7 +92,7 @@ static void fsl_imx6_init(Object *obj)
     }
     for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
         snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
-        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN2);
     }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 1ea459d9f6..d6a76c28ab 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1298,7 +1298,7 @@ static const struct MemoryRegionOps flexcan_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-        .max_access_size = 4,
+        .max_access_size = 8,
         .unaligned = true,
         .accepts = flexcan_mem_accepts
     },
@@ -1324,16 +1324,26 @@ static int flexcan_connect_to_bus(FlexcanState *s, CanBusState *bus)
     return 0;
 }
 
-static void flexcan_init(Object *obj)
+static void flexcan2_init(Object *obj)
 {
     FlexcanState *s = CAN_FLEXCAN(obj);
 
     memory_region_init_io(
-        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
+        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN2,
         offsetof(FlexcanRegs, _reserved6)
     );
 }
 
+static void flexcan3_init(Object *obj)
+{
+    FlexcanState *s = CAN_FLEXCAN(obj);
+
+    memory_region_init_io(
+        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN3,
+        sizeof(FlexcanRegs)
+    );
+}
+
 static void flexcan_realize(DeviceState *dev, Error **errp)
 {
     FlexcanState *s = CAN_FLEXCAN(dev);
@@ -1378,19 +1388,42 @@ static void flexcan_class_init(ObjectClass *klass, const void *data)
     dc->realize = flexcan_realize;
     device_class_set_props(dc, flexcan_properties);
     dc->vmsd = &vmstate_can;
-    dc->desc = "i.MX FLEXCAN Controller";
 }
 
-static const TypeInfo flexcan_info = {
-    .name          = TYPE_CAN_FLEXCAN,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(FlexcanState),
-    .class_init    = flexcan_class_init,
-    .instance_init = flexcan_init,
-};
+static void flexcan2_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-static void can_register_types(void)
+    dc->desc = "i.MX FlexCAN 2 Controller";
+}
+
+static void flexcan3_class_init(ObjectClass *klass, const void *data)
 {
-    type_register_static(&flexcan_info);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "i.MX FlexCAN 3 Controller";
 }
-type_init(can_register_types)
+
+static const TypeInfo flexcan_types[] = {
+    {
+        .name          = TYPE_CAN_FLEXCAN,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexcanState),
+        .class_init    = flexcan_class_init,
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN2,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan2_class_init,
+        .instance_init = flexcan2_init,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN3,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan3_class_init,
+        .instance_init = flexcan3_init,
+    },
+};
+
+DEFINE_TYPES(flexcan_types)
-- 
2.54.0


