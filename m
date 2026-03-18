Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F7710775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzq-00023p-3D; Wed, 18 Mar 2026 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzg-0001zM-ER
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzd-0005oG-Qr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35b9d29480aso163614a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856060; x=1774460860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg3l86J4Mr25+rkQyEjziZ0gWLQDxkgWnrfmi6Gz93U=;
 b=Lz01B+T2XsC3NHtVOV/vinF3JHBZjBaelmk5yPbdisQ7YbMBOrW69ClXYLvjnxRmfJ
 O4AjmGm8BRkapOJL2plD3DHLFEWUmOEmJFd8Mpt742ycMFjOBJZVqgrIulEuqOAciW4G
 N73DzIzJ+mphk7U7+wnh5osSV0CghLZquCQo66+X/5DhUk9gMLwHHa6vjO/rZO1RSaTp
 WzF5R6GXF3vUes1PVP+Mui8YS0kIK9ELsZtZVbAZudRWF5CEfcF/bXaKUIP0SYPmH3V6
 kNGgvZDpV8sd3HVktxefCGWz/r7psLWoxrrw8QM9sBLS4x84IvDDLZ7qETpRYjUKbqJu
 xCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856060; x=1774460860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wg3l86J4Mr25+rkQyEjziZ0gWLQDxkgWnrfmi6Gz93U=;
 b=suSEZT9BM1gS8zVDGiGfdg5MO/TRQBpTCChOEJnYy5pfRzGDOnoVCJwNl9qBB4T23u
 HFCkZTjhMR6lrBiwBPA/QcixiNL3epHfF5T0gIO+qcNzhgDJ7qdIgaYPgrYzdzHySH+N
 /EDsc1Z0/gxW8eEsQrNcue6VKAP80KzboXNeVPJtAQvqtSsCzahZAYSyFAcUsAD6cLQT
 YsB86h65Llugi41EC3/mShktlanCcNvPPmC/xDpz6NwWgav7BY7a59XWr4POxbYzyJnK
 8olYsOBSu4FtvR7p6b+YbgPSFaNAVmH4g7gWl+6x0QQ8b9ypMu/3FRylF5HS7UaBmEZ1
 J28Q==
X-Gm-Message-State: AOJu0YzPEGvJzzvvjo7hYSiTaMbvSmCgg5Ia9/hf41DLtiR8jDVgPBwA
 thTjmgo48rL28t8B3SvQEBejxguvgUWU+qaymH3ankv5N3CkJPiCKjFgxjGwgILjYDXGY4IpqcZ
 MdGSVi8Q=
X-Gm-Gg: ATEYQzzUycvlzu6bWr/azGd4how5n9MmT2HbsRb9NjDd5SK0i+4ipXvODBoswcKczfA
 kD2Sy38wV34Zdxt0AZPHB22L/Uq4ChaLCqFoZ/pf3FR49lBmRt/3vYUFbucIX6nAVJ7RTl9AMde
 Rh8QFPp5eLMqyZHvIFDuVsYVqvW7IrPaPYotw4aANmK7XMKicIALej+gAjq/exdt7usuEjiIXLW
 2GZcZbrAxCdzBAdRaX+ug+AEKRI4+Br+Y2RVR7C3cByze5Q5NJHCxtZlzzzG9wghfYvWG9pEFxa
 hV2JYsgzzYlCwH9ML5inbWFPXu8VRuBb09rBIpww+D4TGJCmINhzxD5tijMmj0YybKDe2YDgGH6
 RasAyURlh7UPQlE7V45C4AnLSWwTB7TLn3mF3rSo+849ftLF1S/cpsey46DfIr9O+cl3J5w0VtE
 7z9i3GqanBKjrJZnyU+I5GsX5c/R90cIz4RGq8/A9HvP3jSQnhoWWIjl8Xh6KgWKP2bBxzg4aTF
 KC+
X-Received: by 2002:a17:902:ea0a:b0:2ae:ceb0:d5f7 with SMTP id
 d9443c01a7336-2b06e43fc20mr41709805ad.52.1773856060134; 
 Wed, 18 Mar 2026 10:47:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 2/8] hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
Date: Wed, 18 Mar 2026 10:47:27 -0700
Message-ID: <20260318174733.1717643-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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


