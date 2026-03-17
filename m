Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32D9FEDA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJh-0007To-CD; Tue, 17 Mar 2026 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJa-0007P7-D2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:55 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJW-00070t-3Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35a1cc6e478so3302699a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776567; x=1774381367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg3l86J4Mr25+rkQyEjziZ0gWLQDxkgWnrfmi6Gz93U=;
 b=Pk36eyPgxBTjdGiZS0UUeXN9JAdrf2YJ/Dg9USKlCdfNBhAuQdFNijBtWvxVrqrPzm
 hSqGvgE8drTPLElrMCEDrrvMAW9aV4cz0RVIOUygF4IW3KUe6C5Et5dGZbjeMsgS8Tey
 xipcVPxtkU3SXOmwrAHVp31zgJS4any2h3zWVwrFYf/x/ukHeW5oaMU23qfF4NNN/4Pb
 3+GZa60QhelZmx4Xf+46DswxSvbca3TdFr2lKzBxGl+A35F+ewuqM/dVuzE3EEY55LT8
 nn0urtLYS43T3V3bCWw47GW6peVgxzqI54pPARKAZdKTmHNZOspuOd2kJb7+jrf0JARl
 q93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776567; x=1774381367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wg3l86J4Mr25+rkQyEjziZ0gWLQDxkgWnrfmi6Gz93U=;
 b=ihCYlO8wtsSND/qmWafW1kp4k+imzsuFHnbQOi7NrTvjEgxCEA+EWXKu2YfL9u4m+o
 OjW17WkoMc1Ww8tuSYDjxaN9AueAE9LWjVxHo1azB1EpDSWZ/Dpc6a1uJ2MLDjR3KYq1
 MLaR7/I+qQHi2nlOn8sjlxoipbp/IxRjFFDgEH34wgD/B7Gj0mkxEu+kZz+wN4PuUNHF
 qLGAU6IZ2fjNMWFeO2iZhHUmJqPXeKUxGMjP/Nx0D8u/EeV6iZ/XGp32CSWUw6l2CHjm
 ipYcBJ0uhNMWrgUNrpCUoMgrK3efkCKsFfHQOKZe5yrX48kQknQwZlmVy5+gHSVpcvLu
 lJYQ==
X-Gm-Message-State: AOJu0YzPkEcit2dbhbXsXwjFEn/+OtjpkjDqT8R66x9h0nvZ+akrwjW9
 jfV0eb2fIFRqFbSpIM/GXJJ8CukwE5eKurspDalp0IwnFquHYgJys3zhGSE1554DMjR15z64gwI
 gOuQuGdI=
X-Gm-Gg: ATEYQzxfhjtwMVIGnRWg6kVPDBd/LzEBQXLc5TzPH31XJvo7t79hsRIMG7oihiR28JI
 IHKAVHRU6zbpQSYqcqkiifmmDwq+/Q1ndS++XNJZn47qU/+xT0aVR7FVtXX33sHGkAkRNG2bFkd
 Kl8xFcZu+ZVwvb9i2VJzm1LIDTCbmHgEVFs41Pmd1FCTodjsqogDtAS5XULx77Pg1oYs0gfYhga
 eTaLXxc64hDSpd4/PPaOcvk930d3//aiCy5+pg9AZ7OQDAg7V07Pg3wsDOwMdc4tU5elV3ppxAb
 AWJLRxyyhUcVQB9LoApjhsM72wfg6pFNxCIGBpOAYcHtkoj+z6fr8aT250ch1I9oi219vozcgzi
 mFo/9Lr61/WhmxMSGbcRkXb8/jOmuEvQICw0rA3TNYLZthAXRI5WZdhMZBIoh0GtRRB21e4zoQZ
 P2RmGyEXEQmvkVGBDx86oX1vTm6fN+mh/GnyHfw5X11nmleE67MZBFlG4MbScarQoIQfXWJFMeQ
 58h
X-Received: by 2002:a17:90b:4d85:b0:35b:a656:a60e with SMTP id
 98e67ed59e1d1-35bb9eb48d9mr517815a91.10.1773776566890; 
 Tue, 17 Mar 2026 12:42:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 2/8] hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
Date: Tue, 17 Mar 2026 12:42:35 -0700
Message-ID: <20260317194241.869568-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/helpers.c     | 172 -------------------------------------
 hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-stubs.c   |  26 ++++++
 hw/vfio/meson.build   |   2 +
 4 files changed, 220 insertions(+), 172 deletions(-)
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
index 00000000000..5a489d1b711
--- /dev/null
+++ b/hw/vfio/kvm-stubs.c
@@ -0,0 +1,26 @@
+/*
+ * Stubs for kvm helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
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
index 82f68698fb8..f2a7728d3d0 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -7,6 +7,8 @@ vfio_ss.add(files(
   'container-legacy.c',
   'helpers.c',
 ))
+vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'))
+stub_ss.add(files('kvm-stubs.c'))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
-- 
2.47.3


