Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2083606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJgWbyF1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC91-0002bi-PQ; Sat, 31 Oct 2026 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8t-0002ZS-Sn
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:22 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8q-0007lj-LZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:19 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15943c9c005so1225351c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464875; x=1794069675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRQ30tVxjum1sPBkLagUd/u9nnVaLh3QS+WsF+nfMn4=;
 b=OJgWbyF1E/sj0+3iO9hSUkVN2DWFbop/Wdr5v831fhYhyk1n6wzG3OQ1MB9zDVXRe8
 i+eqJkdnS7X7YpJtTzJTt6hbrdIWRxfVuQNgZuRfRZ8Ya6Y6ybtgFJtQRA6NIubIIObw
 1JjDY6VmMVzK2z2Pg8rLcSki1wLBrycZ4hL8/685zIWgfVnozg38Wk+IBTLpVEmzJCPj
 bj21Rxu15JzqnnAF5AEFJYLRRephqEkodyDtw+t4zIhzo3RgZKma2BXMMzfW+jn80SvD
 CaMeI7K6+ZVkk4sxRHsakY9nL3HNTtRAR56xPZiWMmku47uSWuy5uM8YyPZzgaQdQVQp
 zfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464875; x=1794069675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRQ30tVxjum1sPBkLagUd/u9nnVaLh3QS+WsF+nfMn4=;
 b=iUum/ZbaYfKIPRuB8I9664soYaPYIkgo0fHcanCtgka/yvVf1NgU4n+f7bL2LKF+YK
 RpgwhKmcsTrod6idtN+TNvYNIgZb/Y7eZuW03PK6s8ZL1lV4pNXAlLGQHCjYUeBmy6Gu
 T9O/Y0Mwrd7rdPQQbeLEEXwSr5wJ26qxwQ1PLZy944tzh/YMTRj7cW3G43nBw0OvyBJd
 SBs7YXTQpkBYTHD0LHNPBKNvmxJAX04wEQ337MRF3QdbIyebifSkHL2zQ+2tXMPAoE9A
 kH9ptyIfimc0AwvLqYwSFUfm1fTA4tShhaJUwy3AAwITcdAWrRdT/3/Qdfk6FNemsCqP
 +MLw==
X-Gm-Message-State: AFq9FYLVJMe4q2jkdZC4/NP3Zm/pOt+qZtsDmCma85ZdzsK/ts3BdlNo
 4rnVgY4cv0mlEPJzOPRTH1oY7SJft9KoGdrO507fCxTImRGfl5LHbSpWQ5sJeBlI
X-Gm-Gg: AYBFou3BfoWTv4YdI+zAZbaKHzfGUb3/iAu7dn9QiMRaACiKVTx8FzqWSL16EnD1sfn
 Enz9hMcRDwY44gLiDHlMXQbq9Hb8mBcb5rn9CSZHZ39YFHjEwF2uJcGQ8guEvU2tqcwebMFoC59
 Yvi/3drhLT7lbwKIOvt2ewvq10VKlC4rTkJTX2pDH/HZ4LAQ93dhnwwyHU3knk8cY23YqIHk/sm
 Braqmcw7zn0HWIfP7GY82aqpjSbzUjwoE/493ffjnfthGR6H4wBXMNrtNqv+5vIjqMPVyDAqeAS
 Wm+5fzfhoTP/4AI0/RGBx8GNCjeMzVseulWrNKygbRK4sz0xmAOLgkCFXl9yEl3Ydy/wI5c06v5
 KuiIO8NS9boaw5XNTpeDIuwyfx4KnnOtL118CwT1Jr/s58UCDxp9+vZpZEKu4iktqV6YU6RExrO
 lnpGdMcHP+EhA5MgQ6+OwwNQitfTxhV3eaRPBDDjli5k+q5TQv6S4Gpf9lshMkEY0k7BTtl8Q88
 G1RSLsBKzSr3bYzs0g9SJ/qNTRYwmev+waojxjQGe89OIgo7reIfc5qclrqeRcwi4A8k2MuTJkv
 pX9FOt3CQef1L75Vj5sVxFB4xLZZGEcNfAVSERVxAxBfgh2n1TVHxgW8Gxva0w3LadOolw==
X-Received: by 2002:a05:7022:f90d:b0:143:868a:20c1 with SMTP id
 a92af1059eb24-1ac5f36c0d0mr6830224c88.46.1793464874789; 
 Sat, 31 Oct 2026 09:41:14 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
Date: Sun,  1 Nov 2026 00:40:04 +0800
Message-ID: <20261031164009.2048-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
 hw/virtio/virtio-blk-pci.c | 27 ++++++++++++++++++++++++++-
 hw/virtio/virtio-net-pci.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2d2fe02c68e..b5ea0b049aa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2901,14 +2901,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
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
index 3eecc23a657..d15f2d283cb 100644
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
@@ -89,6 +89,18 @@ static void virtio_blk_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
+static void virtio_blk_pci_s390x_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    virtio_blk_pci_class_init(klass, data);
+    pci_qdev_property_add_specifics(DEVICE_CLASS(klass));
+}
+
+static bool target_not_s390x(void)
+{
+    return !target_s390x();
+}
+
 static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
     .base_name              = TYPE_VIRTIO_BLK_PCI,
     .generic_name           = "virtio-blk-pci",
@@ -97,11 +109,24 @@ static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
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
index 893d1905a97..0b018e6b094 100644
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
 
@@ -91,6 +91,18 @@ static void virtio_net_pci_instance_init(Object *obj)
                               "bootindex");
 }
 
+static void virtio_net_pci_s390x_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    virtio_net_pci_class_init(klass, data);
+    pci_qdev_property_add_specifics(DEVICE_CLASS(klass));
+}
+
+static bool target_not_s390x(void)
+{
+    return !target_s390x();
+}
+
 static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .base_name             = TYPE_VIRTIO_NET_PCI,
     .generic_name          = "virtio-net-pci",
@@ -99,11 +111,24 @@ static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
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


