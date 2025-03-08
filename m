Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499EC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3KM-0000am-74; Sat, 08 Mar 2025 18:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3K2-0008FJ-OU
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jz-0001aI-8B
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:11:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso1442095e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475464; x=1742080264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZOLi7hVFZ5LkXmaV+OYfUEhNf7zzYjD6/tmTvULQjs=;
 b=vsle2s6wMRoG3EY19zbB5mkOPy6lx2q4fpqlZuuNOeB+/Uy9eDaKqdI14jbhCUXdUq
 p5+rviXG+ZgR42ri+55kbJI1CPBBA+wgCd1S8kAbkC2yWN9/p9hlWoqWTIP4mfGPFGxv
 fXGcbONdiq0tfXv3zudo3stxXFT8wHGpQ98FFNcMviCOopAlLye+ooaHm7n+h4JxTy3P
 awmWL4rPZteQ0+Wtflmjv4J3ClQtH5Ky6L2VqgxbjkXYKDBOCsNx7ozd5Bv+hlSfoDml
 tnS1aFdz6OZ2QT3rW4R3c7GDihlhOjcoRWEQdqz2zUEtiVFCyplPW2bnndOUbCfVxuft
 QqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475464; x=1742080264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZOLi7hVFZ5LkXmaV+OYfUEhNf7zzYjD6/tmTvULQjs=;
 b=nrDII4mbcNjEMU0Z+2A7M4CsfmldjSaleHuh1Tozubc7I5IYprh6hfQcRJHKF8U8Yb
 H4piU/ErK/+c5rHg4LNUyM5F6OPpXQc97Yzgr0el2kqZFKEwld7mgMEE9bFii/6HHb98
 5ziinAx7hzJG6sevjDRJluyu7mcHHYHQ5ufU+q7Ay2B15MG4o/m/hVnoL3zlbMWWonja
 A/FpgiR8LqXbHHPgIbehnEg3pG0dklkVvEgi4EZ+aNt1uDPWSVEpkhhcic0ey/myV32k
 zpELqBZr7kGy7yc3BBxGW5RZAZ/+xqjM3h+D5cmMujPN6kQBV82rEBS7D1JPbdHKyPP3
 tX3g==
X-Gm-Message-State: AOJu0Yz6kLOatmvvgt3st4AZtDibS5GdWbX2GFGKeJlwEfSRHi9GPWYu
 yaclARED43d3+NLt73auDU1FOQAzv/wcuGKxUjbvRG1ep469I/3p9/uAyxXFPK+m3QfRBRJQ75H
 RYgs=
X-Gm-Gg: ASbGncvefWUAor8/LCD9NXvDRNR9eIWwUwTdWFPYxqJX8acPBbRVYsAPBQJZBiscPrG
 7eLa/rPRnvFFU8ABqYU/M7Bd1htzK1NI2TlVWGFa+WaWi4cUZvRArDXE2l9vF+XoApmseEFXLQX
 QcJdQtz4l8ard3/JnQ/iofxWGS821BDOjw7Ys4kE95866aKVej5nYdbd62/d+n4/G86Ttxly2Qg
 kBfEck2lr9Ip/mgp/edPG6f6b+9d8NWMVxSaZ6V/tTDzbXky2nz48WFFiFQagJa8JKKeH4n3EDH
 eVLSTkH5kVTcOCT3yU8t41L8EBBDjZstsfl2gyqLwxxhGHd1bpOMBAJU0v/TNRW8MEo9UZxACR0
 toxL7q0GEI/RD+6MH/tU=
X-Google-Smtp-Source: AGHT+IGWy1gJ5oJ0bHv2ZZjJsgicnzsIu9r/rWofhhX1E8f5N83B9uErX1SevbWarzZRQU5Rb4Xxww==
X-Received: by 2002:a05:600c:1c03:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-43c6021f124mr55430515e9.26.1741475464444; 
 Sat, 08 Mar 2025 15:11:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352eccsm126209355e9.27.2025.03.08.15.11.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:11:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/21] hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Sun,  9 Mar 2025 00:09:14 +0100
Message-ID: <20250308230917.18907-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/ccw.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e5e0d9e3e7e..84d1437a568 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
@@ -650,11 +649,12 @@ static void vfio_ccw_unrealize(DeviceState *dev)
 static const Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
-#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
+};
+
+static const Property vfio_ccw_iommufd_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
-    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
 };
 
 static const VMStateDescription vfio_ccw_vmstate = {
@@ -682,12 +682,10 @@ static void vfio_ccw_instance_init(Object *obj)
                      DEVICE(vcdev), true);
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ccw_class_init(ObjectClass *klass, void *data)
 {
@@ -695,9 +693,10 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ccw_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
-#endif
+    if (iommufd_builtin()) {
+        device_class_set_props(dc, vfio_ccw_iommufd_properties);
+        object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
+    }
     dc->vmsd = &vfio_ccw_vmstate;
     dc->desc = "VFIO-based subchannel assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -716,11 +715,11 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     object_class_property_set_description(klass, /* 3.0 */
                                           "force-orb-pfch",
                                           "Force unlimited prefetch");
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
     object_class_property_set_description(klass, /* 9.2 */
                                           "loadparm",
                                           "Define which devices that can be used for booting");
-- 
2.47.1


