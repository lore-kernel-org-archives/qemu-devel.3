Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38171C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc5l-0007Hg-So; Fri, 07 Mar 2025 13:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc43-0004Sp-AM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:51 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc40-0002JZ-7H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1055505f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370686; x=1741975486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0+sj+5fZPDlRh8EKfyzOVB2Z+MoNxqNRQg5EoTr07c=;
 b=Llj4NGZ4VxZ79idn6xySoUfWGFUAx777jbCT6IOHvS4DnubMwLbSD7DSzqtNbKyQbR
 YlHYxI5ejMMLW2rqkPQ+gfiLT8E5C2CWP7jBCBb/uWAEYVh3YA67jYN/BnM/TLnj6KRI
 x8hgXqt4p0cQnNOT6OcLtf3bHbm6x2dqocOHGqsciXlcWDjGE/DpuLYZ19KpTnkd16d0
 qrZfyDx4PKKwzsP86zCSYYJjYIhwJTHYmI+R490cjzmG81jf2/rhmHpc3xuVDMXZZvZY
 VpWK0ugAqZpbeRUy31caz2QKmgnJSZaiwzpMxLOOVnton3lJthPAEpAck5ycn/8ufg2u
 h3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370686; x=1741975486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0+sj+5fZPDlRh8EKfyzOVB2Z+MoNxqNRQg5EoTr07c=;
 b=Lb/Wca4OKi7h4Y5+tw1hIsVQYAG+uPrZTaUM4Xx4U8ip1vFZuCrItvWAkrRI31RmEN
 OotW4usibuXgdrSjRuuUNpGh3YKSgODAAroIw77Kyz+ATnVyvd14zawDJl5Mwetg5zf1
 7irgQM2wIGmQ2WccFXzPQOFw/PUehSe3Al0+3vPcrS/79Do35uJ5UefppHgpUBoCG/w3
 gu+3N3HMXyi7P8Zt+fFEG6sdZIPZV2af10Bwec4Iwx36X4JFPfaFRXOeImJtHcwjSyu2
 2n7uLEDQ0K8tMWXgiLiv91iyf2JpQzTUj0+pLlrRPvhU5/Ut0229daKATRVUHPAK7/W9
 +cVw==
X-Gm-Message-State: AOJu0YwuvsvG6XBtUsx/coE8pzEx51KeY4YiomTHeWGatHl9OGWW60k9
 7MyZwMqmehnY25pUBiEhw81lmQmTYyivJkCCG5WECG131r0k3IvTYuVI6Vk6ZVWx8XvnbYz1hF1
 yqEA=
X-Gm-Gg: ASbGncv54w82dNwdpatgcnhzH+Emf+wg3EQEyK5cMcB2J6qWR7i0FrcBKMK3kW6pVg9
 VkAMML3+1cyS49ClA/qIUK8vwlQA6lio+7KoAefluR/bZNWHeKkr6zBQZelcUP7aRZHDnWXGHL4
 sZh/NkCQlnnpioh8JuIibHjd2c1HbIM17dZwXq/P/Cg6HuNPLJigVPPfIIgEOFPkftODQ7pSHj6
 HrQoUKrfzHfLoMCGC33WCxyxTzuz1Iu2sHztXu8KZlXq5TqViWVlli72Fc/1VoprR0bnk9XfazZ
 NISGODsnvX5k5333O952yZ+kNLjqt5khEJY7XIEKnKGMH0ssDu65KvQdhCM17YOCOmNY1IOyLR4
 en7GGLhRJiZyW+ZKr0ys=
X-Google-Smtp-Source: AGHT+IF97fayJY/yW6R5BSvdDohNcmjJuG0p61HA9ekjFXsJOXr24N1zzjiAZ7Wbh8GXE9bLdxWyzw==
X-Received: by 2002:a05:6000:402b:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39132db746amr2784656f8f.49.1741370686062; 
 Fri, 07 Mar 2025 10:04:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b046dsm58414135e9.5.2025.03.07.10.04.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 12/14] hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Fri,  7 Mar 2025 19:03:35 +0100
Message-ID: <20250307180337.14811-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert the compile time check on the CONFIG_IOMMUFD definition
by a runtime one by calling iommufd_builtin().

Since the file doesn't use any target-specific knowledge anymore,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h |  2 +-
 hw/vfio/ap.c                 | 27 +++++++++++++--------------
 hw/vfio/meson.build          |  2 +-
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index c7ab4ff57ad..832b98532ea 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
@@ -24,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
@@ -193,10 +192,11 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
-#ifdef CONFIG_IOMMUFD
+};
+
+static const Property vfio_ap_iommufd_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_ap_reset(DeviceState *dev)
@@ -234,21 +234,20 @@ static void vfio_ap_instance_init(Object *obj)
     vbasedev->mdev = true;
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ap_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ap_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_ap_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
+    }
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -261,11 +260,11 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 3.1 */
                                           "sysfsdev",
                                           "Host sysfs path of assigned device");
-#ifdef CONFIG_IOMMUFD
-    object_class_property_set_description(klass, /* 9.0 */
-                                          "iommufd",
-                                          "Set host IOMMUFD backend device");
-#endif
+    if (iommufd_builtin()) {
+        object_class_property_set_description(klass, /* 9.0 */
+                                              "iommufd",
+                                              "Set host IOMMUFD backend device");
+    }
 }
 
 static const TypeInfo vfio_ap_info = {
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 9a004992c11..510ebe6d720 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -9,7 +9,6 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
@@ -26,6 +25,7 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci.c',
-- 
2.47.1


