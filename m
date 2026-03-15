Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A887D58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1faq-0001mO-56; Sun, 15 Mar 2026 03:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fao-0001lS-Cq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:54 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fam-0000dt-K2
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so367847a91.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558531; x=1774163331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=lTHHhYOD4Xpjjkgmy70EQoTXQun3nSau9SXVUe6cUR65svfJ3f+KqUMj4zkMTMxBPP
 +48/YtHzOcq9gv00/i85589KRGW/TPRrrvR5rPp2kUfYfB9LTYOoFOugAtlClksF9qxv
 yKVTkJoAGFsG7cfVwbveFNS6mKczLnEHo+hH+89gFSdM47++Nm9K4owvwM4vwPGhtRuf
 YMTjahWRp3uHZDlepUw+8LBAR9UWtbGEl3X6wlgkDVZqrHP5qQ4RXuXyfbEJoc2yld1s
 aXZEo5au78eg8oOsOUcj7LbRxUJ75i+ec7D3iL5ucoqlLYPRVPmmS5422AVqha96hmcv
 ElQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558531; x=1774163331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=YOQ4RSF6gHB6kQA81GPyLr2MIsE/o9F9bCq64RS59aIRVwsgZJjJAaneLNPzbMp+Hi
 NVGXLA16s9NaTAxLEkjER+APcF9JAoLHz2ailcPj0t8th1OcSrRjhp+hiCn3TnBdAyxX
 n98txgmOOObZktpH4uUeqKqVh8iUsa8QyLxhrA6pRezOzOxcvdrkSWbS5S3LHFstTX3f
 47srsV0+Y9atWkAYKGXCqrJ5kfVKgd/QXdN1oOGU5hi6B0mCmMGZhfOfXn4Fay2ugwnP
 O/TZow5KH2XhDo2wI5NowJhpDJZgunCllCrWdBG+IIbVgqc902hbXQXYLmwrbWi/BR8l
 u+7g==
X-Gm-Message-State: AOJu0Yy8yE/u16761yvlbLV0r/IhKsP6a7f7EmOPo+AqepRNGkaBKNAE
 Lc+k3/e/Lj8rxOuEUYR5jbDpAOEVoxEiJBNhp0wn6nKxY/lWLrEryaGBRNTfhH47qCW+cyHRYKE
 /CAKiQls=
X-Gm-Gg: ATEYQzwAp6fvalv7lSqRKSIBLWRz5tUTl5SvElQUM2pi1xfihKerlQSwtrGw0s6wiaJ
 YkDaFb8WCbrAUj6Ogaope4a0Sn2gAr9q7f5MY1jdGt8Nv6wSALRFnxe5U/BovLPR/jnQhJGj0gR
 DJxydpoGfcVx00CzuSvzHJR5Ya16+rMVfBJ2QNNYuyx1hl/yino7K3KESgOWBmd1KBh0Juva0qc
 BoAyCRczK1tnqBlufRulZC5sXPbKmdOT3ZvnFKl35ZgGoB68gTKbpSK+gWPm16bbkQqWgpCn7bD
 32IJ4Dm66nNNm2UrH2/OL/s54mkJ/65u8Ea/qs6cbx24uW4rhmg9W7fS+6KY6ZIW7RByQ0kSr3g
 wRvtm1qv9Fyc3oPg3mzndzYG33S2djW6iG4Uq4twV0+F3C3GDDXig0kUONImMHwkPj7orwTx76e
 SibgXuaUajZI8Yi+2asoZusjc3WIKOCU7+hjPUPc7kYo1gxXHh+6KjPvvt9P1QpVIReS2yutxMd
 UY=
X-Received: by 2002:a17:90a:d407:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-35a21fdd3acmr7857183a91.17.1773558531025; 
 Sun, 15 Mar 2026 00:08:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Date: Sun, 15 Mar 2026 00:08:33 -0700
Message-ID: <20260315070834.198331-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since this function needs kvm specific types, we need to extract in
another file and link it only for KVM builds.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/kvm-spapr.h | 12 ++++++++++++
 hw/vfio/kvm-spapr.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-stubs.c |  8 ++++++++
 hw/vfio/spapr.c     | 30 ++++-------------------------
 hw/vfio/meson.build |  1 +
 5 files changed, 72 insertions(+), 26 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/kvm-spapr.c

diff --git a/hw/vfio/kvm-spapr.h b/hw/vfio/kvm-spapr.h
new file mode 100644
index 00000000000..b1f68c686a7
--- /dev/null
+++ b/hw/vfio/kvm-spapr.h
@@ -0,0 +1,12 @@
+/*
+ * VFIO sPAPR KVM specific functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/vfio/vfio-container.h"
+#include "qapi/error.h"
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp);
diff --git a/hw/vfio/kvm-spapr.c b/hw/vfio/kvm-spapr.c
new file mode 100644
index 00000000000..ad71c5a85e2
--- /dev/null
+++ b/hw/vfio/kvm-spapr.c
@@ -0,0 +1,47 @@
+/*
+ * VFIO sPAPR KVM specific functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include <linux/kvm.h>
+
+#include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/kvm-spapr.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "vfio-helpers.h"
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp)
+{
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOGroup *group;
+    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+    struct kvm_vfio_spapr_tce param;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+
+    if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
+                &param.tablefd)) {
+        QLIST_FOREACH(group, &container->group_list, container_next) {
+            param.groupfd = group->fd;
+            if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                error_setg_errno(errp, errno,
+                        "vfio: failed GROUP_SET_SPAPR_TCE for "
+                        "KVM VFIO device %d and group fd %d",
+                        param.tablefd, param.groupfd);
+                return false;
+            }
+            trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+        }
+    }
+    return true;
+}
diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
index 5a489d1b711..78c51b99155 100644
--- a/hw/vfio/kvm-stubs.c
+++ b/hw/vfio/kvm-stubs.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 
+#include "hw/vfio/kvm-spapr.h"
 #include "hw/vfio/vfio-device.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
@@ -24,3 +25,10 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
 {
     return 0;
 }
+
+bool vfio_spapr_kvm_attach_tce(VFIOContainer *bcontainer,
+                               MemoryRegionSection *section,
+                               Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index a9f093c3570..42690e4323d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,6 +16,7 @@
 #include "system/address-spaces.h"
 
 #include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/kvm-spapr.h"
 #include "hw/core/hw-error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -406,33 +407,10 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
     vfio_host_win_add(scontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
-#ifdef CONFIG_KVM
-    if (kvm_enabled()) {
-        VFIOGroup *group;
-        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-        struct kvm_vfio_spapr_tce param;
-        struct kvm_device_attr attr = {
-            .group = KVM_DEV_VFIO_GROUP,
-            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
-            .addr = (uint64_t)(unsigned long)&param,
-        };
-
-        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
-                                          &param.tablefd)) {
-            QLIST_FOREACH(group, &container->group_list, container_next) {
-                param.groupfd = group->fd;
-                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                    error_setg_errno(errp, errno,
-                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
-                                     "KVM VFIO device %d and group fd %d",
-                                     param.tablefd, param.groupfd);
-                    return false;
-                }
-                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-            }
-        }
+    if (kvm_enabled() && !vfio_spapr_kvm_attach_tce(bcontainer, section, errp)) {
+        return false;
     }
-#endif
+
     return true;
 }
 
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 6c00a7f51bb..bab5f2b7f15 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -10,6 +10,7 @@ vfio_ss.add(files(
 vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
 stub_ss.add(files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
+vfio_ss.add(when: ['CONFIG_KVM', 'CONFIG_PSERIES'], if_true: files('kvm-spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
   'pci.c',
-- 
2.47.3


