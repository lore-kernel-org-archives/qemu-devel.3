Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B659310775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzs-00026X-RA; Wed, 18 Mar 2026 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzm-00021W-TZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzi-0005q3-1U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c742882d2a4so71424a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856064; x=1774460864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=EpR1IiM0ib+o83m6xvxhWFTyvMDPdY9F1+KGRVcn9JA3hWC52zQYJeMSWNnFUqE8zD
 hFk27vVApKUi9koJMULBLXbNTI40XfZP3ztbtBsDzBDaGhYZIk8JaLfV64Wopn8A7NOl
 xN9JlRM0Risyx8CtY1XjghDOpQkpbFvx2fYqsmtjlZCu91RAUMFIWMjvkAkoDpMOPzXY
 EFrJEYIzptqenO2YjWu3ZN2bLTRMIaW6wOChCrgJhjimwuuC2NZ39w67SdnquY8Z0vXQ
 2+GQdg2zyEOrVxF5Ybaklvk9Sg6yJhhIpx1pq8f31SPx4uapRsXdC9w4uwU48mU/A5Ms
 eM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856064; x=1774460864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U6HBDS69l4fbTlZmSQgqfg1BjiYPNjySjY8DwVgdsMo=;
 b=TmDsWB353u9lvF/4rSoUIa4j2SLXnjTFSAIeZpWDf4KZD1OExBHLZAonN86KK50WOd
 gif5r5MYqCmGAPP+Gs7fXCgUw788BGWNLJG+qF0cdkNPNKymv7MpfMGUgfKjUxME0xib
 nLdMX3b44+EwIg20n5tVxHZ422wZ4vigqrtscMtixp9Twwhx2bTAc2vj3DP0HUWtAmDz
 7u6uAFrxxKRQrn+22hS1EfwdVCiufL8VYRS+kCvmk5o1OlhIF3mHgeC6t1AdusVKBBlY
 +t0OjlHf4oOfmVYl6G83KEr1LzNcaldMOdJA8wkrd2JGsePSTpGXo6eQOpnGxv1YlDjv
 J6ow==
X-Gm-Message-State: AOJu0Ywh64F8nebHhqSg7IO27p8DXPIhHPuLiucec1sQLrRb+BzN1KPc
 mX02rJmm+hS6tWDsDiPEgZoR7qdQnRUkOadazaLCfBb3P4x/pPSnVjYa+icdAcPXB0pR+lnYBo+
 b5W/uRLg=
X-Gm-Gg: ATEYQzzFKaX1A+Bs96nsD2l13d8/vhfXffQMCMJ+5/ddL99ozyIX1ZcO8/U/4bTRO3X
 7FvnytSHvdfipA8A7K7qz4H0Uob+DN0UU8mA2Ib8j2PIg3gzMzBmNcdzd4Hg88Yxn1jZllSVLku
 r0KBd3Dqev8UpitKN6CUyu/L4qAfqrfTYwOinWvIbCTtQbID4HakaVYcDQ/NOIwhW5bH7fI+RQM
 y1hRGk6yJVLLPyCLqcmXud2fefLjjIxXIZEaB6ESLAyggcbw4WsaOhyE9r98Cx1ltL9xv8ayuxF
 FCL3hissix8Ir9FgZ9SkV4L51Ru3GlmkK1JBr+c2V7W8miuA2oZ+kOKlwmjxG1nEpZyIN+aTgzq
 lXgnxHxan2w/Eq/PX+41IXdoyBwjXlqsxlmXXnbsMI0PFjqtUpGu2UiuqDy/hOmBCr2nNUEp1dg
 jJoA8OjihLPpGswWdkiubiifMjKQo8fa8iEYXplkADzXCNni9EAsNZVaPjNC5NIy7vHP43UId6k
 etE
X-Received: by 2002:a17:903:2f8e:b0:2ae:c981:2a29 with SMTP id
 d9443c01a7336-2b06e2fac2emr39135465ad.2.1773856064117; 
 Wed, 18 Mar 2026 10:47:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Date: Wed, 18 Mar 2026 10:47:32 -0700
Message-ID: <20260318174733.1717643-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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


