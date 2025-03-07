Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4CAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc5o-0007WE-8S; Fri, 07 Mar 2025 13:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc49-0004iH-Vs
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc46-0002KO-So
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so13617285e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370692; x=1741975492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PjjtPvH9M8tF9GLUHgsFKP3TRPxe4Etbg8NvJxAgPo=;
 b=J8QyfalZzrLmWso8CvYXmUuTHHmG3WavuB8GVw2/mvgZfSqsk0ARrt/S79RFV6Tqm7
 wgo2Pih6F0AE6Kf6rfyRowDHObU8jbXB+3fK9LMhgMCFVC+utwpILP6ktsf/m6/bOD3N
 JTyce3xIxoTsbds18IUHeiXB63OJ/GJx985lc3I093rqLi+nKWNFnW6GkcmddKVTTXHP
 hyPaEqNanJVbsrWDnnfqLFGT0T+xRwffp+xAhi0V87/jqG8aMoiH/q+jVu1fguuciniI
 JcmS0kiYTVb/nNzRWBK6f58rubAUQISCmJ0kmJH+W1SzSgjh4kAe8EduB6MpQbCGJEPV
 Qnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370692; x=1741975492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PjjtPvH9M8tF9GLUHgsFKP3TRPxe4Etbg8NvJxAgPo=;
 b=dRFEAzoSb5vVwKoL8N3MYJ+fm/kzvQ2p50GPa77Cg9+KQuMu1MKBEzec1Hxzs8UiCT
 T/m/OXZrslBsriJyyuZysquzRYOvd8CLvqQRDdJogDau7R6a64SFYtaMb+OFO6eSLa75
 PVMqps3I0+60foZLsPBSoYRbNCQqpwjZ6Pz9/3hypG7i8lnI1uH3j0hGsY7+6hQMWuK8
 n3QBTIWZ8vCMERHj94HQF8RRVaEAwTq85xp6nwvd1cAIuGJQS60SS7IuPGEwcXYIQ2NN
 voViQw5D6+69B/lAv0gxD0mGDLGRWfMXBe2CK7G18ae2Ystg2bHUYudXhGad3esJYA7m
 OxwA==
X-Gm-Message-State: AOJu0YzJYXwTJD08z5teTm2Lqmpmk3EqygA1fmVorSh4X5C/zMWzeLNq
 tOwR6UiT9DbIl8fA/OM8CnVkps9QFxLRTuwxQyKLRSA8iFJ9dSmtuqhbw4SZF6DJJ92e5yfxzLH
 E+xk=
X-Gm-Gg: ASbGncvHEo1fEN8Ql2ztob4OfT0zlq+WMMW2mm013wFub556jPc0erv492IKsSY2Tqa
 KQ2YfnNwNHtZ6xWnRxjXZwroNFGo+T+0gVpjs44Mb/fBIEbp7BzTQD5cWaNVARXMNT8lptTtCi7
 Hf/u2KltPeSk4s4qQuqfDwhaz78+diyGg3OA58tQmyuqYcnbFfPmRFsioxA5m9jEDO4lN/eUbpn
 7coueN6yS/1llHg3faV8zbZo9PTsvYKnwicDMrwEhJ/p82cmcckM5irdtvau7xom/ti3RDIogq4
 /l/1ejU8LH6vcSDPHZqQFC+SdhVxt7sDooTjBtvbUDtJkM5KAIEFdilpUxTkuvYk5sy6SMoXffN
 icsYdmyInzq25okiCNrs=
X-Google-Smtp-Source: AGHT+IH9V77Jk8RO698QbiKv+F+gtIcqVl1iG13X0gUKZUfwL0hC3/rmYcr31Z4Epankft7r7WAhHw==
X-Received: by 2002:a05:600c:5108:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-43c5c6a4137mr27636815e9.25.1741370692182; 
 Fri, 07 Mar 2025 10:04:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c9c7sm86670675e9.38.2025.03.07.10.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:50 -0800 (PST)
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
Subject: [PATCH 13/14] hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
Date: Fri,  7 Mar 2025 19:03:36 +0100
Message-ID: <20250307180337.14811-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 hw/vfio/ccw.c       | 27 +++++++++++++--------------
 hw/vfio/meson.build |  2 +-
 2 files changed, 14 insertions(+), 15 deletions(-)

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
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 510ebe6d720..bd6e1d999e4 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,7 +7,6 @@ vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
 ))
-vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
@@ -26,6 +25,7 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
 system_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+system_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci.c',
-- 
2.47.1


