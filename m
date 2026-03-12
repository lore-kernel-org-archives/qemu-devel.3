Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359B1106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omX-0007Fl-Lv; Thu, 12 Mar 2026 18:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omE-00073Y-Mg
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:10 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omC-0003IU-Kv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c7393536e53so622077a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355507; x=1773960307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvpjWio/aBMSV+EUvl9/0Lsdx7SfDm44tLg19GLlZEY=;
 b=YeDTLqhPbKuQPu9/3hAVjQFYoC4t5QrcM/CQe2FE0YgGF1qEy9pnTwkw+tSgMuNdZo
 5U50vTzt1o/nmlBjC4YHGb/Oqd40HyykKYTlXpn8zKDGO+yjw3wMi0PyvNMCuejl00lF
 hJXCJoPpt47f2BRLMigv5fx5lwHCOgKoiPbUU+/Oslqdyb1Jcm2FBkalfDGuYb5aOUVT
 H1ahJLF54gvtIF9kOuwanRNwtzzUwR/tsnTH0rFnT58R8l4TEB189FcHOcLJ3oMhghUW
 Jyx+Fzn3Dh8s3hJIut8tpckp7grzgnYBAC8qtmM048pybx+f2/+H1hIZzE/FDNtSs/+r
 thpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355507; x=1773960307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvpjWio/aBMSV+EUvl9/0Lsdx7SfDm44tLg19GLlZEY=;
 b=B0l7sjcEJ2k85Lg3K3JnVHtdhCEBXyyvjBaJNs2cPFwB92hQVHCKj9kYJhW+HNQmrp
 +TpLT+rKnDj0LtiFDuJmufYGIUo+CEn58W4oTwkfI1tDCfT1monqBrAOUTaWNZgQlR2P
 iUXa86Fmm0ebE/qWXe4ECfmda855QkqFUy8sBlPneWyT0FiUewFGGDZcWZxEmrFc0Gm1
 FPa8nend1hCp5dJ7ruAVo/O+zzuo562iERYZoKNMEtjFFNvhGpZKbfXktRlIFjAnNK8t
 7l9Tg8rcESqcjOfvb2jWaDTwtFv8qiiEKKYllqwrQEI3TEx0iQn774y9q7CwTmAZATzg
 pIdw==
X-Gm-Message-State: AOJu0YyAACGlBzaRu5TUZGEbpgxKEFQBV1oWmd0KyG3jOIDieNFDbtli
 fikC9X+pJmHTUxafjq5t24pHkFgiDxB7ravHfo0kJy33eBNkqzxfWegl6Yp5ONmWy5DJ7gw55t/
 o+PNNHyE=
X-Gm-Gg: ATEYQzxQZQzEwX7uiKXcLBbP9XYkoiVfS4mMcL1MLVEmDhC5VsLSUWbzyi+ypTxcT+b
 YGu1IA4mI44Z23RDgw7TKl3rpIWXhticPRVqdEqHje8gyiuqNtj7s3yOzROYzMH/T9WiHMAOG3h
 yoogSA29HCs/EZL7J1byktWWZ5LECUSNlCyc1jVbMPkFLtlAip9s4l0wMxNYdZYi5SPU/kzpC1H
 kLSg5M9+jklXmGb1y4LD/FtR/waf15B2S+bHMiN1q27st4/Mu2FnRkZVGJp3D1zPVU3VuuC5C71
 XPh9Xma+h6cB8bD18g8KRXDxeXKtKv84ZVCvrPTJ7wm8hCDu+3C9dMu+zHwXYQ3XXGYRvU8M+z5
 MGuZ/gsuiJnwrjBznu9Kp/8W7GCh+9bbseyrZ3IOI+lm0HYL4c0i+v7pS6Wkspk4Md4peu0dLfY
 RpbrO9gCpUiKPHcOIEvubkR9vrMAhiNv8ypoyeWV2DzXk78nmgMyIks4bbosjxhMwWWBoAKOix9
 yhx4/ShqQAChxY=
X-Received: by 2002:a17:903:38cc:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2aecaab1574mr10285735ad.39.1773355506712; 
 Thu, 12 Mar 2026 15:45:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 7/8] hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
 hw/vfio/kvm-spapr.c
Date: Thu, 12 Mar 2026 15:44:48 -0700
Message-ID: <20260312224449.1605071-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
index 00000000000..1a7697a07a8
--- /dev/null
+++ b/hw/vfio/kvm-spapr.h
@@ -0,0 +1,12 @@
+/*
+ * Vfio spapr kvm specific functions
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
index 00000000000..6b9d04298c5
--- /dev/null
+++ b/hw/vfio/kvm-spapr.c
@@ -0,0 +1,47 @@
+/*
+ * Vfio spapr kvm specific functions
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
index 9593287d9c2..65aa1ef192c 100644
--- a/hw/vfio/kvm-stubs.c
+++ b/hw/vfio/kvm-stubs.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "hw/vfio/kvm-spapr.h"
 #include "hw/vfio/vfio-device.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
@@ -25,3 +26,10 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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
index 562ba79d1c0..06e24122c5c 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -10,6 +10,7 @@ vfio_ss.add(files(
 vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'),
                                 if_false: files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
+vfio_ss.add(when: ['CONFIG_KVM', 'CONFIG_PSERIES'], if_true: files('kvm-spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
   'pci.c',
-- 
2.47.3


