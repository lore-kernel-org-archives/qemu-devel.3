Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D13C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc5r-0007t0-Ps; Fri, 07 Mar 2025 13:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc4E-0004p1-Dr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:05:03 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc4B-0002L4-Gz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:05:02 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390eebcc331so1396744f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370697; x=1741975497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agcsT+LijTsdk7Aq19MciJhNx25N7TH6CXZbFxHQbqw=;
 b=YFE/+6V1ldaSLRuPkm2c8ZQBZwfWoeMAe+ziIljR3CxuU+4HzvXmZmu/s40yNEg8WF
 ZCtDCoTkOP0Kp2NoZHEA2t6JOC44RRaOAgKfdGR0LCN0tC+k0Gha0yamYwPGBl3j1Cr9
 8desrD1zla6jADc82cPZ7KC5DhSis7tTFE0X3pSSEiyzh6bSC/LRZLnzBsx9R/MNhDmz
 /BeEHGnoOs76l8TjRR8pP7toPfI1Xvbfl88ZY/e+LyNLyXaLmIQewcj9Kc5/sLh0W04P
 Ih34e23CcsKn1LEY5gsMAfIRIgKMEkmWUmaPd+hDHZ+iswniEK4lA8GAnMZwivvdejDN
 dUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370697; x=1741975497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agcsT+LijTsdk7Aq19MciJhNx25N7TH6CXZbFxHQbqw=;
 b=GWAC4IF1Vn7AH62vZq6+bw5S//Jiqg5KZVwtGxx8uktQ5nCKLa11kiCBpSzRn3hGzF
 kYcl7FL5vB9ZSUyVNmV8x/FmzqDAyQbGmwMFMhcmRwjAykWp8LcUuB1/ok3Q1yUYSfoT
 qUHfRTnIcjBz7v05LvtNponRQgoMyo10qGnDN/ZnG6gsAQYBWIhM+cA6ycIZABRitZly
 oYQ/0UzEb0vjrZjExpd7cCpX9VCTQSybnLoartUsX2h2vTDx7I9yJlnHD3lbPOpHuVSE
 mMYUA5io6e4FC2vN2aRtOJ6I+ijYoFEJ583YsgvJNd2Ufig7xSq9dWKO/db23BM/hGZE
 7Pag==
X-Gm-Message-State: AOJu0Yzg9WLR5sIsTa3Zaa7rULGmG/4+uJRBANgWvXJQxrg+ESf9IB41
 FSesenHkRZ9Iw2GTIgGbkZKh7olrmBgtHeo4jXfIxhqoBg5hjieDarrxyTa/xfpwCM7zpxzWO6M
 HI3c=
X-Gm-Gg: ASbGncvde0g3UvYOfPTf0vxr/w58FOZJweN/iLFETgEEg+NesyIYAg/NkJ3UXKf6BmF
 x1aGmPaPjMSZt9yOjF6VleW5eMjPqQizBhIpdNbg+F8oeqdna39wPMR5b2CeDAN29e+2cZR2WrT
 zEqtiHcrHdVW+2Ka/xDnN3VKXDiXFsaLP5RgT/NH6K4jgKT2ane+lo0uTs1NM+7oF04j2H2WzWH
 fgWI1+4fxZ+VL9ATRAcqMPyg9c2wpS/DpofvLsxJGoOO9w9l6VdjJnmNVFKVEnbaOFxkvlF2xac
 OXn/3s1dY89bc7Y2zb9cIaZLHNc+HSRgF/cuooGsiw05HJtnFwhcd1HuvNLeYQM9pnjSkzCyL0d
 EynJnypeZ+djZSvvoLkE=
X-Google-Smtp-Source: AGHT+IE+YfUTsyezmJk1O/V7rJmU3VYke7MWbvI0vhhGZxFwIjiesECECfkOBaEgpCq1WPQAC5PfkA==
X-Received: by 2002:a05:6000:1f8f:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-3913aeee2d7mr346949f8f.8.1741370697461; 
 Fri, 07 Mar 2025 10:04:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352eb1sm86964935e9.31.2025.03.07.10.04.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:57 -0800 (PST)
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
Subject: [PATCH 14/14] hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin
Date: Fri,  7 Mar 2025 19:03:37 +0100
Message-ID: <20250307180337.14811-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
 hw/vfio/platform.c  | 25 ++++++++++++-------------
 hw/vfio/meson.build |  2 +-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 67bc57409c1..265c550b747 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -637,10 +636,11 @@ static const Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
     DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
-#ifdef CONFIG_IOMMUFD
+};
+
+static const Property vfio_platform_dev_iommufd_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_platform_instance_init(Object *obj)
@@ -652,12 +652,10 @@ static void vfio_platform_instance_init(Object *obj)
                      DEVICE(vdev), false);
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_PLATFORM_DEVICE(obj)->vbasedev, str, errp);
 }
-#endif
 
 static void vfio_platform_class_init(ObjectClass *klass, void *data)
 {
@@ -666,9 +664,10 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
 
     dc->realize = vfio_platform_realize;
     device_class_set_props(dc, vfio_platform_dev_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_platform_dev_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
+    }
     dc->vmsd = &vfio_platform_vmstate;
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
@@ -692,11 +691,11 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 2.6 */
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
 
 static const TypeInfo vfio_platform_dev_info = {
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bd6e1d999e4..e5010db2c71 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,7 +7,6 @@ vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
 ))
-vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
@@ -26,6 +25,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
 ))
 system_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 system_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
+system_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci.c',
-- 
2.47.1


