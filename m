Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC59106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omD-000724-8M; Thu, 12 Mar 2026 18:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omA-00070C-S2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om8-000399-HP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aae4816912so10796515ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355503; x=1773960303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=134V80R59c6cEmAV414g3btic+2TYlFOl0tJTgaOB2I=;
 b=mg/HYxKh8pquVydZHkKnxz1hh8VTyf3z1Eqc0tjClSeOXd1FRDIFHuZK16j7BoJ5f2
 VGuhTboW9446Rh3TVMf6wM5M66M/zobsJbWzQ5UtXRpMqvptDGWrlcxNug/eIN18sf79
 oi5h1kpwLbGhtPrI/NuqH2Sd6yN+gxRrM+zczq0X7IK1UQItak6bWOEkpb/dj22d4z8h
 /jJLUGvgr9W0lUc33ZfJ2mAqaP6bGfLqqH0OXh6U+NyweHa8FRgacSq3OTVSxJBzxndo
 CRVXjizf7JnnhU1W+KyG20f8Jug00nTgUgMoYqmX13QSLWIiBhF3za1p2qN83cijMBrv
 GXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355503; x=1773960303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=134V80R59c6cEmAV414g3btic+2TYlFOl0tJTgaOB2I=;
 b=b+kJ4jF1mHtXauKwgCq1OpkcZSS601hjxSLt7E2AXoEkrBTEiEBPi9MBmcxhqHFNrq
 uFV5uvNCJdu4E+Kb+iFPGgOldyKyl4yTSq/078cRChwL8aW8cnBVPmQqpQbSDk9CfCK1
 AKstJboGYFpKMYUdREiOjo5e5RrCFWmsxtPemrYAUo+Cn6NCt+8cpDCJfgpXPysZROih
 rHY2GSzP/l9Y0piZJCGU9yY9PA/BxQxkTH0+hrhI4VaTD0LJ/uGS1g9KFPn6k6/jEWo9
 vAg4pSzAWB75ZGlClD+0uay6Aa/BblnEPCXejP78IN+7xB5686uLKQ6WtDA3FTpPv43U
 eqIA==
X-Gm-Message-State: AOJu0Yy4Io2pRGzVSKOQbH2TnZQ4QvDHEv2DJf8khtyGaYKAYUF8mD6I
 qXm2aByYkc1vcDpzQNldQwq6QJ14it5NSnK74sehCS7qndKqikJgOgI+/8adzwzFx8wpyFOgTAE
 s9VFBTWU=
X-Gm-Gg: ATEYQzxHDEn0Walb3fp+6/wtXZb2H63+6WxnKqdH0nPnmKD7+8ELHZUdWh4ljWVkPZZ
 nOKGGg+uFS4QgfydqEY/2mftoKkrN7k+r2tHRpNX5wUH5Eh6RCzdmCG2mlAgcaJSj+/fy9MW09D
 oUJrA6mWK+NVRyZwNN7ltl2SYG+ofNpPiDJrC2vH04PLQQiotKtMxQz4NlmSE2FYz0AkgmN/5KO
 oqpBD1AXY+pXENTTlxjz4tE7Vnarw3JXWrXxGsccwZYz4ZJTzCpdIQbR2/2zk//itvWboXfhijC
 HxfM8zAzWv1Wbp6WU4lic7NCf8QCYigFjew9a0uFw4U+8B+g+nCxbTE/5gM7EdeXMMwnYrUjduO
 Z9T3B5mr6mly3CBPE8VVveq+thxf9zwlPUzkK1BE+Hv4H6CrbCaGc0GqeTqZaze1+ivmcUE6DUY
 bz/zum+ZIIlwaqoltzI7BD+1susT0mV8oCOjlCH+R07PO/Bv3zbOi7Q5qG9ZDXslIeVgH/YkclE
 kPOwaLCwXfkbL0=
X-Received: by 2002:a17:902:d54b:b0:2ae:5671:7067 with SMTP id
 d9443c01a7336-2aecaa7f8admr9750145ad.23.1773355502781; 
 Thu, 12 Mar 2026 15:45:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/8] hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
Date: Thu, 12 Mar 2026 15:44:43 -0700
Message-ID: <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Because those functions use kvm specific types, they need to be isolated
in another source file.
This allows us to link kvm-helpers only in configurations with
CONFIG_KVM.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/helpers.c     | 172 -------------------------------------
 hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-stubs.c   |  27 ++++++
 hw/vfio/meson.build   |   2 +
 4 files changed, 221 insertions(+), 172 deletions(-)
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-stubs.c

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 00d42d3b98e..65c6dba0428 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -22,7 +22,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "system/kvm.h"
 #include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/core/hw-error.h"
@@ -107,177 +106,6 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
-#ifdef CONFIG_KVM
-/*
- * We have a single VFIO pseudo device per KVM VM.  Once created it lives
- * for the life of the VM.  Closing the file descriptor only drops our
- * reference to it and the device's reference to kvm.  Therefore once
- * initialized, this file descriptor is only released on QEMU exit and
- * we'll re-use it should another vfio device be attached before then.
- */
-int vfio_kvm_device_fd = -1;
-
-/*
- * Confidential virtual machines:
- * During reset of confidential vms, the kvm vm file descriptor changes.
- * In this case, the old vfio kvm file descriptor is
- * closed and a new descriptor is created against the new kvm vm file
- * descriptor.
- */
-
-typedef struct VFIODeviceFd {
-    int fd;
-    QLIST_ENTRY(VFIODeviceFd) node;
-} VFIODeviceFd;
-
-static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
-    QLIST_HEAD_INITIALIZER(vfio_device_fds);
-
-static void vfio_device_fd_list_add(int fd)
-{
-    VFIODeviceFd *file_fd;
-    file_fd = g_malloc0(sizeof(*file_fd));
-    file_fd->fd = fd;
-    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
-}
-
-static void vfio_device_fd_list_remove(int fd)
-{
-    VFIODeviceFd *file_fd, *next;
-
-    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
-        if (file_fd->fd == fd) {
-            QLIST_REMOVE(file_fd, node);
-            g_free(file_fd);
-            break;
-        }
-    }
-}
-
-static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
-                                  Error **errp)
-{
-    VFIODeviceFd *file_fd;
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_ADD,
-    };
-    struct kvm_create_device cd = {
-        .type = KVM_DEV_TYPE_VFIO,
-    };
-
-    /* we are not interested in pre vmfd change notification */
-    if (((VmfdChangeNotifier *)data)->pre) {
-        return 0;
-    }
-
-    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
-        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
-        return -errno;
-    }
-
-    if (vfio_kvm_device_fd != -1) {
-        close(vfio_kvm_device_fd);
-    }
-
-    vfio_kvm_device_fd = cd.fd;
-
-    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
-        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
-        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-            error_setg_errno(errp, errno,
-                             "Failed to add fd %d to KVM VFIO device",
-                             file_fd->fd);
-            return -errno;
-        }
-    }
-    return 0;
-}
-
-static struct NotifierWithReturn vfio_vmfd_change_notifier = {
-    .notify = vfio_device_fd_rebind,
-};
-
-#endif
-
-void vfio_kvm_device_close(void)
-{
-#ifdef CONFIG_KVM
-    kvm_close();
-    if (vfio_kvm_device_fd != -1) {
-        close(vfio_kvm_device_fd);
-        vfio_kvm_device_fd = -1;
-    }
-#endif
-}
-
-int vfio_kvm_device_add_fd(int fd, Error **errp)
-{
-#ifdef CONFIG_KVM
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_ADD,
-        .addr = (uint64_t)(unsigned long)&fd,
-    };
-
-    if (!kvm_enabled()) {
-        return 0;
-    }
-
-    if (vfio_kvm_device_fd < 0) {
-        struct kvm_create_device cd = {
-            .type = KVM_DEV_TYPE_VFIO,
-        };
-
-        if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
-            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
-            return -errno;
-        }
-
-        vfio_kvm_device_fd = cd.fd;
-        /*
-         * If the vm file descriptor changes, add a notifier so that we can
-         * re-create the vfio_kvm_device_fd.
-         */
-        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
-    }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
-                         fd);
-        return -errno;
-    }
-
-    vfio_device_fd_list_add(fd);
-#endif
-    return 0;
-}
-
-int vfio_kvm_device_del_fd(int fd, Error **errp)
-{
-#ifdef CONFIG_KVM
-    struct kvm_device_attr attr = {
-        .group = KVM_DEV_VFIO_FILE,
-        .attr = KVM_DEV_VFIO_FILE_DEL,
-        .addr = (uint64_t)(unsigned long)&fd,
-    };
-
-    if (vfio_kvm_device_fd < 0) {
-        error_setg(errp, "KVM VFIO device isn't created yet");
-        return -EINVAL;
-    }
-
-    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-        error_setg_errno(errp, errno,
-                         "Failed to remove fd %d from KVM VFIO device", fd);
-        return -errno;
-    }
-
-    vfio_device_fd_list_remove(fd);
-#endif
-    return 0;
-}
-
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
diff --git a/hw/vfio/kvm-helpers.c b/hw/vfio/kvm-helpers.c
new file mode 100644
index 00000000000..d71c9590aaa
--- /dev/null
+++ b/hw/vfio/kvm-helpers.c
@@ -0,0 +1,192 @@
+/*
+ * low level and IOMMU backend agnostic helpers used by VFIO devices,
+ * related to regions, interrupts, capabilities
+ *
+ * Copyright Red Hat, Inc. 2012
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Based on qemu-kvm device-assignment:
+ *  Adapted for KVM by Qumranet.
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ *  Copyright (C) 2008, Red Hat, Amit Shah (amit.shah@redhat.com)
+ *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include <linux/kvm.h>
+#include "system/kvm.h"
+#include "exec/cpu-common.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/core/hw-error.h"
+#include "qapi/error.h"
+#include "vfio-helpers.h"
+
+/*
+ * We have a single VFIO pseudo device per KVM VM.  Once created it lives
+ * for the life of the VM.  Closing the file descriptor only drops our
+ * reference to it and the device's reference to kvm.  Therefore once
+ * initialized, this file descriptor is only released on QEMU exit and
+ * we'll re-use it should another vfio device be attached before then.
+ */
+int vfio_kvm_device_fd = -1;
+
+/*
+ * Confidential virtual machines:
+ * During reset of confidential vms, the kvm vm file descriptor changes.
+ * In this case, the old vfio kvm file descriptor is
+ * closed and a new descriptor is created against the new kvm vm file
+ * descriptor.
+ */
+
+typedef struct VFIODeviceFd {
+    int fd;
+    QLIST_ENTRY(VFIODeviceFd) node;
+} VFIODeviceFd;
+
+static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
+    QLIST_HEAD_INITIALIZER(vfio_device_fds);
+
+static void vfio_device_fd_list_add(int fd)
+{
+    VFIODeviceFd *file_fd;
+    file_fd = g_malloc0(sizeof(*file_fd));
+    file_fd->fd = fd;
+    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
+}
+
+static void vfio_device_fd_list_remove(int fd)
+{
+    VFIODeviceFd *file_fd, *next;
+
+    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
+        if (file_fd->fd == fd) {
+            QLIST_REMOVE(file_fd, node);
+            g_free(file_fd);
+            break;
+        }
+    }
+}
+
+static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
+                                  Error **errp)
+{
+    VFIODeviceFd *file_fd;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+    };
+    struct kvm_create_device cd = {
+        .type = KVM_DEV_TYPE_VFIO,
+    };
+
+    /* we are not interested in pre vmfd change notification */
+    if (((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+        return -errno;
+    }
+
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+    }
+
+    vfio_kvm_device_fd = cd.fd;
+
+    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
+        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_setg_errno(errp, errno,
+                             "Failed to add fd %d to KVM VFIO device",
+                             file_fd->fd);
+            return -errno;
+        }
+    }
+    return 0;
+}
+
+static struct NotifierWithReturn vfio_vmfd_change_notifier = {
+    .notify = vfio_device_fd_rebind,
+};
+
+void vfio_kvm_device_close(void)
+{
+    kvm_close();
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+}
+
+int vfio_kvm_device_add_fd(int fd, Error **errp)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_ADD,
+        .addr = (uint64_t)(unsigned long)&fd,
+    };
+
+    if (!kvm_enabled()) {
+        return 0;
+    }
+
+    if (vfio_kvm_device_fd < 0) {
+        struct kvm_create_device cd = {
+            .type = KVM_DEV_TYPE_VFIO,
+        };
+
+        if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
+            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
+            return -errno;
+        }
+
+        vfio_kvm_device_fd = cd.fd;
+        /*
+         * If the vm file descriptor changes, add a notifier so that we can
+         * re-create the vfio_kvm_device_fd.
+         */
+        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
+                         fd);
+        return -errno;
+    }
+
+    vfio_device_fd_list_add(fd);
+    return 0;
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_FILE,
+        .attr = KVM_DEV_VFIO_FILE_DEL,
+        .addr = (uint64_t)(unsigned long)&fd,
+    };
+
+    if (vfio_kvm_device_fd < 0) {
+        error_setg(errp, "KVM VFIO device isn't created yet");
+        return -EINVAL;
+    }
+
+    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+        error_setg_errno(errp, errno,
+                         "Failed to remove fd %d from KVM VFIO device", fd);
+        return -errno;
+    }
+
+    vfio_device_fd_list_remove(fd);
+    return 0;
+}
diff --git a/hw/vfio/kvm-stubs.c b/hw/vfio/kvm-stubs.c
new file mode 100644
index 00000000000..9593287d9c2
--- /dev/null
+++ b/hw/vfio/kvm-stubs.c
@@ -0,0 +1,27 @@
+/*
+ * Stubs for kvm helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "qapi/error.h"
+#include "vfio-helpers.h"
+
+void vfio_kvm_device_close(void)
+{
+    return;
+}
+
+int vfio_kvm_device_add_fd(int fd, Error **errp)
+{
+    return 0;
+}
+
+int vfio_kvm_device_del_fd(int fd, Error **errp)
+{
+    return 0;
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 82f68698fb8..f32d8573600 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,6 +7,8 @@ vfio_ss.add(files(
   'container-legacy.c',
   'helpers.c',
 ))
+vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'),
+                                if_false: files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
-- 
2.47.3


