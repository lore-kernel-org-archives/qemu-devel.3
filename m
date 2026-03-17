Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD62DFEDA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJg-0007TX-Tc; Tue, 17 Mar 2026 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJc-0007Qb-DM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:56 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJX-000796-Q7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso3767269a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776569; x=1774381369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvlR81x866gY3qLaJHNGVc5nZ2VGdLAHBfrAYzTTWAY=;
 b=Kn3/pvxPbqDa7mvIBvks2QiKc+LNpqh5k1JEYnPqZEyvT/HHcFcUeJyGtOoYrI0LOi
 94LDPVt3c0/iTlX/GUj5xtkzmv718QKed/ENHNJ+p5J476sKpUG9n5VHIdEbITbXbUip
 nTPj8kcZravy5luQCJbNdjI1g0X/SBr5NEARdpEdMR0sMcH2GlBYnUwMNp74Yj5Q8qGk
 oZ40vLTxuoq+vGky+JR1S/q/VvXDKRfjk+9O0K2zg8nWEj89mWnspaIBexueyeopNLQi
 EuIdXNNrZwd+j9khmCNxm5PDyoHCKluCnupYQG5vCmFBeZDZ6tzqvK7UzFFfcVm01lMt
 08Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776569; x=1774381369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lvlR81x866gY3qLaJHNGVc5nZ2VGdLAHBfrAYzTTWAY=;
 b=WiTWDDlcchLxSrDsJQz1GVSUfL7oNeVT32l5ygAa9BxWX15odAviyqg3W+tmT0eh53
 zsye2e5z5azE2hUy7uLPLAdTMne+JxWOVSq1NzKC+Md3yDa/JDOw/hV+7+NHaO/O+Mcp
 uIB3ahqLiGCRAfChQ2Qo3cYHHMcvLOlB5MuuAOvr0A+nXd8UYxgqFmR6WwhYhResggex
 HTBxhg1l1a5bn6WPNYYyLlo7cBnjqX+xK4+yRo3hsGJA4l5B5q7UYPKpy3MLsYM7sMC4
 5WjCOpTScLkd1BJV5iu92FSMMT1GMN3FGIFn4VrtaGwlzWKV+K/D4w1MOkSuX8a5Ja4n
 4fcg==
X-Gm-Message-State: AOJu0Yx+Ntx50uk0mLZ9f5Blwmcbl/DbKqxGoHe6Xz9WbLosnmBUQen3
 biISM7iVmK6n5lpp01e62h6YCivuQkZCPuu8ypiezxbVpY4tFr9mhvQUuZqjDXfOU/+xals3wdz
 hNmFAt+s=
X-Gm-Gg: ATEYQzzIyqm0Hor9Xlj8SFPSF4fhja4OZVasAGl4oMh7wRku8wPqQIR7vEPtjjFHM0a
 s3ZIfhBg1eUEqmzyl8ZtU6pArDgozMQ6Am8JKxtwGf1nQG0widAfPkV/c27EUxaPJWrf9MZ3xot
 TJwoecfFgP5j0La9qGD2tp55nn5OZL+ZyKWw5XfyHvln6HKR28ojn7i4/nqwGdlRxHJoPjmKDsG
 CMzvHZ4JmOelwnYNCsaGt/k7XAFkTLiPYfBWsdhcr36fiz6VQyIcPWPrnogz4dhI+/i+SY+ZTRx
 po0khsZBnEgRYXE4qflbXxuotUQgPOyLErBge1szTZ5rG53MVIpxOFhqMe6MG35g6l9wygSNFDu
 PSDYRH4G2HQRtNxPD30sXFGThe8W/Db/eCfBAEFQIQNbSldi+CS9n76P8FesInUCLpFgI7SLDPv
 pjn5K9Jjnd/9ciaQjap/kZ8y7/JS3Dyy6G6XcyR29QlszvLbLKqJhbehpsogc/enIRQrufIktv8
 kQi
X-Received: by 2002:a17:90b:2ecd:b0:359:f6f8:57b8 with SMTP id
 98e67ed59e1d1-35bb9e3ba82mr494819a91.1.1773776568563; 
 Tue, 17 Mar 2026 12:42:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
Date: Tue, 17 Mar 2026 12:42:37 -0700
Message-ID: <20260317194241.869568-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing
inconditionally iommufd related properties, which are declared
statically (in const arrays). The alternative to expose them dynamically
is more complex and requires boilerplate to set properties at runtime,
with set_* callbacks and added logic to check if iommufd backend is
available, with no obvious benefit.

One possible difference is that user may see a different error message
when trying to attach a vfio device with a QEMU not supporting iommufd,
without declaring iommufd object associated.

Instead of:
```
$ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
qemu-system-*: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Property 'vfio-pci.iommufd' not found
```
User will now see:
```
qemu-system-aarch64: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Device 'iommufd0' not found
```

However, since declaring the iommufd object is needed, error reported
before and after is still the same:
```
$ qemu-system-* -object iommufd,id=iommufd0 -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
qemu-system-*: invalid object type: iommufd
```

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/ap.c  |  9 ---------
 hw/vfio/ccw.c |  9 ---------
 hw/vfio/pci.c | 11 -----------
 3 files changed, 29 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e58a0169af9..856fa2678cd 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
@@ -279,10 +278,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
 };
 
 static void vfio_ap_reset(DeviceState *dev)
@@ -320,21 +317,17 @@ static void vfio_ap_instance_init(Object *obj)
     vbasedev->mdev = true;
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ap_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ap_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
-#endif
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -347,11 +340,9 @@ static void vfio_ap_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, /* 3.1 */
                                           "sysfsdev",
                                           "Host sysfs path of assigned device");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
 }
 
 static const TypeInfo vfio_ap_info = {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2251facb356..c66f42a13c2 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
@@ -647,10 +646,8 @@ static void vfio_ccw_unrealize(DeviceState *dev)
 static const Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
     DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
 };
 
@@ -679,12 +676,10 @@ static void vfio_ccw_instance_init(Object *obj)
                      DEVICE(vcdev), true);
 }
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
 {
     vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
 }
-#endif
 
 static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
 {
@@ -692,9 +687,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ccw_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
-#endif
     dc->vmsd = &vfio_ccw_vmstate;
     dc->desc = "VFIO-based subchannel assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -713,11 +706,9 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, /* 3.0 */
                                           "force-orb-pfch",
                                           "Force unlimited prefetch");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
     object_class_property_set_description(klass, /* 9.2 */
                                           "loadparm",
                                           "Define which devices that can be used for booting");
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 94c174a773f..df617f1fe46 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
@@ -3471,9 +3470,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
             error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
-#ifdef CONFIG_IOMMUFD
                               "or -device vfio-pci,fd=DEVICE_FD "
-#endif
                               "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
             return;
         }
@@ -3816,22 +3813,18 @@ static const Property vfio_pci_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTO_PCIBAR_OFF),
-#ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
 };
 
-#ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
-#endif
 
 static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 {
@@ -3840,9 +3833,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_legacy_reset(dc, vfio_pci_reset);
     device_class_set_props(dc, vfio_pci_properties);
-#ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
-#endif
     dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_pci_realize;
@@ -3944,11 +3935,9 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "vf-token",
                                           "Specify UUID VF token. Required for VF when PF is owned "
                                           "by another VFIO driver");
-#ifdef CONFIG_IOMMUFD
     object_class_property_set_description(klass, /* 9.0 */
                                           "iommufd",
                                           "Set host IOMMUFD backend device");
-#endif
     object_class_property_set_description(klass, /* 9.1 */
                                           "x-device-dirty-page-tracking",
                                           "Disable device dirty page tracking and use "
-- 
2.47.3


