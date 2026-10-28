Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSwhfObo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA59-0005Ls-Gn; Wed, 28 Oct 2026 16:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA55-0005J2-Bm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:07 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA53-0002Kd-Fq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:07 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3282db206d3so1382675eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218624; x=1793823424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B49HQpaDb0z0YnNrSTi7LO1bJgi1tGBwEu7rfsuG9hE=;
 b=gSwhfObo0IN20twNipcv8+RwFtySm4gzHp7rZqf6IjLkVGXBIT5WuKoavjfJiGM/RT
 6nXP9KyWsw6tp4SSA6zr7sQ3UGnmVm/ygtbuBUq1FIBe+YoxPKjeSmbjR1E4ocD5xBQ4
 iLhIYHok2O7jHpT7+QbXyNpeeWr6qw4E2uDk9Zqj90t9h4eQSxbFhvmrsvjYgD8AA5Jz
 5Xf5ShYuW7N+Ra/W++48hhnI8Kn6CnEAxx8ytqM1SKZQErb149wyc2kaiS8nLiRkfLl4
 EFM/HlJBZn9w3V9CAGOQFcIUfqRCw0BXuMW24gyWINDinw0Hnkn7sRgtbAcI3i3HYyIc
 PPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218624; x=1793823424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B49HQpaDb0z0YnNrSTi7LO1bJgi1tGBwEu7rfsuG9hE=;
 b=iazwDsCOlVpQzmjgjWo7BEESmOjF1WFfILJRxs3o2NjjL5GyB3mShiPownId9OYGud
 AiMKHNjrknyLQQQO1NRAfEbJ/sD9j9g28JYwUzfc7kTrzTJOln9G1xp8I70VS8Ds5aHe
 Mpmn3RqjLNsZMxejJDdQe5nmrlLHqP6w1q78XwOf2CE5eWDpWOtw8y7J4z/Ay6g2RiAv
 CPx8rjeeiE0NPBNEhWjm1Ibe1f8zqqi3+b0Jfl+XAFfzvxWltMFrRw1a2oCvUiAc4WJb
 YrCKgZsfbdoO73njNPlMNzFT2ZJfX/PyG5X3f52QH7JRgh4OgpDlHv5gvLeunhpzxH/c
 M+6Q==
X-Gm-Message-State: AFq9FYJQuuz78WkcYmhltDycxrMLCEtFu5lENKiM+CV3eRsHseix119+
 H6wBoXScw6BdU5ZJWmzP9DNlKuRn9eewEQ602NNsOSYluOfRL4WneQ6bzR/pcpXB
X-Gm-Gg: AYBFou2YSLjzKD5VJPkf/wSFnKO1RRUhVjqdIMDaF2orCjIzOTCj005G9UD9hljGG0P
 B1QnGPjYJWqLVY0FsGKrGFRDS73ZCZsRjXnmeJognHhQkZIXwa2qLE28/831UjDx7kch+9IK/yu
 T3dw8o00yFI92YOY3VxS7/d1yTGEXDOx6npVTcMPz7NRFlaSxdbBwYz5biVk/D4vxnJwgegxMQn
 TAFCO9XABA14DG3LOmpX2od54vJIyfIaxhPsVonpuYaLaEeXQdd2YFlt4dp7lmbNYV+1ERij7HI
 svZq6wD3vn27b4bKPalQOX3Q1XZ9w+nb6s+HLVdkugTguXGBiNMa5l096f9ohzUhhBRLGiz842J
 9Wa+pZENYSE1qAMz3nHyxbikH6S+/udKd2fvn2+AicFBVSnGfeBhu7U6B8/kAMaLgdk6tneV5Tc
 UL4k9kM/jmd85rMjTksG1L33ZtXwuPF0dlZsxOaPMNE2R509LNxs+ulO18ZdmoV7w81F1vtfcEF
 ghySQhhb9Fpw9UqKKi9ws3ZfbQKDO3cpPgtWTJ8r0xJohJ2nv70MsaSUIAgnbN4j4Ncnegrf3q7
 n3d3iFVD+QiWJjuggfhpj6/IicpCPnESBmM5lyvnVim1XXMk
X-Received: by 2002:a05:7300:f894:b0:368:4c93:544e with SMTP id
 5a478bee46e88-36a202bc3f0mr5119208eec.1.1793218623951; 
 Wed, 28 Oct 2026 13:17:03 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:17:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
Date: Thu, 29 Oct 2026 04:15:53 +0800
Message-ID: <20261028201557.2688-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1331.google.com
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

virtio-blk-pci and virtio-net-pci added the s390x loadparm property
from class_init when target_s390x() was true. Register each
VirtioPCIDeviceTypeInfo twice. The s390x variant calls
pci_qdev_property_add_specifics(), which now always adds loadparm,
and the other variant does not. target_s390x() and target_not_s390x() select
the two.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/pci/pci.c               | 13 +++++--------
 hw/virtio/virtio-blk-pci.c | 22 +++++++++++++++++++++-
 hw/virtio/virtio-net-pci.c | 22 +++++++++++++++++++++-
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb0..e1bd3bb0e29 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2895,14 +2895,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      pci_qdev_property_get_loadparm,
-                                      pci_qdev_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  pci_qdev_property_get_loadparm,
+                                  pci_qdev_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 MemoryRegion *pci_address_space(PCIDevice *dev)
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 3eecc23a657..f4f86f7b428 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 #include "qom/object.h"
 
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
@@ -71,7 +72,6 @@ static void virtio_blk_pci_class_init(ObjectClass *klass, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     device_class_set_props(dc, virtio_blk_pci_properties);
-    pci_qdev_property_add_specifics(dc);
     k->realize = virtio_blk_pci_realize;
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
@@ -89,6 +89,13 @@ static void virtio_blk_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
+static void virtio_blk_pci_s390x_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    virtio_blk_pci_class_init(klass, data);
+    pci_qdev_property_add_specifics(DEVICE_CLASS(klass));
+}
+
 static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
     .base_name              = TYPE_VIRTIO_BLK_PCI,
     .generic_name           = "virtio-blk-pci",
@@ -97,11 +104,24 @@ static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
     .instance_size = sizeof(VirtIOBlkPCI),
     .instance_init = virtio_blk_pci_instance_init,
     .class_init    = virtio_blk_pci_class_init,
+    .is_available  = target_not_s390x,
+};
+
+static const VirtioPCIDeviceTypeInfo virtio_blk_pci_s390x_info = {
+    .base_name              = TYPE_VIRTIO_BLK_PCI,
+    .generic_name           = "virtio-blk-pci",
+    .transitional_name      = "virtio-blk-pci-transitional",
+    .non_transitional_name  = "virtio-blk-pci-non-transitional",
+    .instance_size = sizeof(VirtIOBlkPCI),
+    .instance_init = virtio_blk_pci_instance_init,
+    .class_init    = virtio_blk_pci_s390x_class_init,
+    .is_available  = target_s390x,
 };
 
 static void virtio_blk_pci_register(void)
 {
     virtio_pci_types_register(&virtio_blk_pci_info);
+    virtio_pci_types_register(&virtio_blk_pci_s390x_info);
 }
 
 type_init(virtio_blk_pci_register)
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 893d1905a97..d7aaf255507 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 #include "qom/object.h"
 
 typedef struct VirtIONetPCI VirtIONetPCI;
@@ -77,7 +78,6 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
     k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
-    pci_qdev_property_add_specifics(dc);
     vpciklass->realize = virtio_net_pci_realize;
 }
 
@@ -91,6 +91,13 @@ static void virtio_net_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
+static void virtio_net_pci_s390x_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    virtio_net_pci_class_init(klass, data);
+    pci_qdev_property_add_specifics(DEVICE_CLASS(klass));
+}
+
 static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .base_name             = TYPE_VIRTIO_NET_PCI,
     .generic_name          = "virtio-net-pci",
@@ -99,11 +106,24 @@ static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .instance_size = sizeof(VirtIONetPCI),
     .instance_init = virtio_net_pci_instance_init,
     .class_init    = virtio_net_pci_class_init,
+    .is_available  = target_not_s390x,
+};
+
+static const VirtioPCIDeviceTypeInfo virtio_net_pci_s390x_info = {
+    .base_name             = TYPE_VIRTIO_NET_PCI,
+    .generic_name          = "virtio-net-pci",
+    .transitional_name     = "virtio-net-pci-transitional",
+    .non_transitional_name = "virtio-net-pci-non-transitional",
+    .instance_size = sizeof(VirtIONetPCI),
+    .instance_init = virtio_net_pci_instance_init,
+    .class_init    = virtio_net_pci_s390x_class_init,
+    .is_available  = target_s390x,
 };
 
 static void virtio_net_pci_register(void)
 {
     virtio_pci_types_register(&virtio_net_pci_info);
+    virtio_pci_types_register(&virtio_net_pci_s390x_info);
 }
 
 type_init(virtio_net_pci_register)
-- 
2.55.0.windows.3


