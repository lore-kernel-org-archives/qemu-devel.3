Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B39EE64014
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvL-0003vV-1o; Sun, 05 Apr 2026 03:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvJ-0003uk-I6
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:33 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvH-0007Fx-Jg
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:33 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so3154571eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374169; x=1775978969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhuQFBcbzpwqAcvo/lQJH+U4zsmLQEc/b+KbhHOCZWI=;
 b=jQnvhuDBJDXIXon65tRLtAoto8ZxK6xMOn0vwFTEGZ3F94fgATA9iw727JOWBX/Tkt
 YXlImx+ak1lpLRoMnLxGGVTzjVhI9Rmzn3XB5MJl6Km6vorZcjOHWYcI+sbpRyFogk3q
 C8LLZJ3VZ1mE5xFLzBcDkHi7/0iOb+UvgcjeA4pS6bYRju+txpGNf+q5nZxOoa7V2s/I
 7hgqnsgPMr1VK78CNcOf0ZEkGIBkDXDFQBwEKf9k7z11g2ywLU/3++6YLIY7IzkzDVcX
 PmOXOO52w8Ri0c8YQtFrXPQvjJwploabUTNDPkKMXaeBKtjK/LauK/XYeQrGq2zfQeuu
 RtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374169; x=1775978969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhuQFBcbzpwqAcvo/lQJH+U4zsmLQEc/b+KbhHOCZWI=;
 b=jRBXxrxhGvv2cQNEVVrlkA9ANSG9m8ZnhDGGiDMDazFR0JgYFNGvC58QsYX/Zm71at
 TCufHv91y/KKSTBMxqpUWltQWdzfDcH+sD2V5H8NevBzIVxQJKp3A/X1S+VPefT8zunY
 D1b9ln7+ljFe4D/yrPXOZa8b2Yp8dsqT5lagjeJYkwAqNpybpE10LtRCVNfKG3R2Cw65
 rXfrHOHrgt1/LaccD/lELOK+MC7SDxZ1vAcMVJyKn8gwCRoshMI9BBdh4e4+jjiaCRb9
 OrRwyQycqcn+vKEjAKza2MEzc4HnbRTp2mVTjNuJIpBLC+y/p/d+lMNso758IypoRANq
 ftCA==
X-Gm-Message-State: AOJu0Yw5u8EAYcTJym+EMYeNfWI327LSHMZ1XGexhghVui24Z7NzEqLE
 rO16bQIcCW4iMMbd6MDm5HHAHnm/9kpCjtHMgrBxr5Z/SbyHrlN2hDw8E/TuhvlVOjs=
X-Gm-Gg: AeBDies1NH6Fbo589dfxPjTDFxtjrhd3NA/1QSYu78JXaxjmSUaUqcOd5tQ4Ce6iOn0
 N1CYD/IXcgwrS7Co5OI3ZMHWK9oN7UqjxQOqk3ovpPZa2zq9z3kfc/oo1zpR+X3z5Otzlkthdhm
 pbDzUmTQpV01aWYNRMGpOTBNl895oAE2N2S7mcUHVH4cTZjgW2XNhi3gIKrden+c2y0Xp7861vB
 YNApBfiEtLp78RB36VWHyQkGJMTTHDRxMrFSjd4ZKIFb2mnBD7MqJ4tAN58iAF0XdDRfp+evWas
 qWIefy6hoVYBtRZUjVvvsy8fFa4nWaTccLsreXzdQ61pecD5oTxgaPD9nzxdbTavm/Wh6pSTMnB
 luWRSOzv1BQ+0d84n0EOeAjIme7ePKPBmCnz8V8+xPPpQPdMQmwQi+pgiVpTORBvqt7MTu+lisM
 JIub7JN0ME5VmqTDq6Z6k+9ZVxw+3dQmBjWC6FoaDqsY7GmfJHxIvnQife3djXB052GVz7O5IbC
 5fEZel/b0jGGvFSHmAY5l7nWt8=
X-Received: by 2002:a05:7300:641a:b0:2c8:7172:3b8d with SMTP id
 5a478bee46e88-2cbf99ef517mr3990367eec.2.1775374169387; 
 Sun, 05 Apr 2026 00:29:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:28 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 03/10] vfio: Allow building on Darwin hosts
Date: Sun,  5 Apr 2026 00:28:47 -0700
Message-ID: <20260405072857.66484-4-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Enable the VFIO subsystem to compile on macOS/Darwin in addition to
Linux.  This is build infrastructure only — no Apple-specific device
code is added yet.

Key changes:
- Add CONFIG_DARWIN Kconfig symbol and propagate it through the build
  system so that VFIO and VFIO_PCI are selectable on Darwin hosts.
- Provide minimal <linux/types.h> and <linux/ioctl.h> shim headers
  under include/compat/ so the Linux UAPI VFIO headers parse on macOS.
- Widen CONFIG_LINUX guards to CONFIG_LINUX || CONFIG_DARWIN in the
  VFIO device, helpers, and migration headers.
- Make container-legacy.c (the Linux /dev/vfio ioctl container) build
  only on Linux, and restrict IOMMUFD to Linux in Kconfig.
- Remove the CONFIG_EVENTFD guard around event_notifier_init_fd() so
  pipe-based EventNotifiers can be initialized on Darwin.
- Mark vfio-pci as not user-creatable on Darwin since the Linux VFIO
  kernel driver is not available; the Apple-specific device type will
  be added in a subsequent commit.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 Kconfig.host                      |  3 +++
 backends/Kconfig                  |  2 +-
 hw/vfio/Kconfig                   |  4 ++--
 hw/vfio/meson.build               |  4 +++-
 hw/vfio/pci.c                     |  3 +++
 hw/vfio/vfio-helpers.h            |  2 +-
 hw/vfio/vfio-migration-internal.h |  4 ++--
 include/compat/linux/ioctl.h      |  2 ++
 include/compat/linux/types.h      | 26 ++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h     |  4 ++--
 meson.build                       | 10 +++++++++-
 util/event_notifier-posix.c       |  5 ++---
 12 files changed, 56 insertions(+), 13 deletions(-)
 create mode 100644 include/compat/linux/ioctl.h
 create mode 100644 include/compat/linux/types.h

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b..bb2780293c 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -5,6 +5,9 @@
 config LINUX
     bool
 
+config DARWIN
+    bool
+
 config LIBCBOR
     bool
 
diff --git a/backends/Kconfig b/backends/Kconfig
index d3dbe19868..d1be4148d3 100644
--- a/backends/Kconfig
+++ b/backends/Kconfig
@@ -2,7 +2,7 @@ source tpm/Kconfig
 
 config IOMMUFD
     bool
-    depends on VFIO
+    depends on VFIO && LINUX
 
 config SPDM_SOCKET
     bool
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 27de24e4db..a409483c34 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -2,14 +2,14 @@
 
 config VFIO
     bool
-    depends on LINUX
+    depends on LINUX || DARWIN
 
 config VFIO_PCI
     bool
     default y
     select VFIO
     select EDID
-    depends on LINUX && PCI
+    depends on (LINUX || DARWIN) && PCI
 
 config VFIO_CCW
     bool
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 82f68698fb..1ee9c11d5b 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,9 +4,11 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
   'container.c',
-  'container-legacy.c',
   'helpers.c',
 ))
+if host_os == 'linux'
+  vfio_ss.add(files('container-legacy.c'))
+endif
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ee1a42e7e0..5a1c2d8c2e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3862,6 +3862,9 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 #endif
     dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
+#ifdef CONFIG_DARWIN
+    dc->user_creatable = false;
+#endif
     pdc->realize = vfio_pci_realize;
 
     object_class_property_set_description(klass, /* 1.3 */
diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index 54a327ffbc..2afb360797 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_HELPERS_H
 #define HW_VFIO_VFIO_HELPERS_H
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_DARWIN)
 #include <linux/vfio.h>
 
 extern int vfio_kvm_device_fd;
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index 814fbd9eba..566cd6a871 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_MIGRATION_INTERNAL_H
 #define HW_VFIO_VFIO_MIGRATION_INTERNAL_H
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_DARWIN)
 #include <linux/vfio.h>
 #endif
 
@@ -62,7 +62,7 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
 int vfio_load_device_config_state(QEMUFile *f, void *opaque);
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_DARWIN)
 int vfio_migration_set_state(VFIODevice *vbasedev,
                              enum vfio_device_mig_state new_state,
                              enum vfio_device_mig_state recover_state,
diff --git a/include/compat/linux/ioctl.h b/include/compat/linux/ioctl.h
new file mode 100644
index 0000000000..2c789fefc6
--- /dev/null
+++ b/include/compat/linux/ioctl.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* empty Darwin shim - ioctl macros not needed */
diff --git a/include/compat/linux/types.h b/include/compat/linux/types.h
new file mode 100644
index 0000000000..d6620aaf7f
--- /dev/null
+++ b/include/compat/linux/types.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Darwin shim for <linux/types.h>
+ *
+ * The Linux UAPI headers that QEMU copies into linux-headers/ expect
+ * these typedefs from <linux/types.h>.  Provide the small subset we
+ * need so those headers parse on macOS.
+ */
+#ifndef COMPAT_LINUX_TYPES_H
+#define COMPAT_LINUX_TYPES_H
+
+#include <stdint.h>
+
+typedef uint8_t  __u8;
+typedef uint16_t __u16;
+typedef uint32_t __u32;
+typedef uint64_t __u64;
+typedef int8_t   __s8;
+typedef int16_t  __s16;
+typedef int32_t  __s32;
+typedef int64_t  __s64;
+typedef int64_t  loff_t;
+
+typedef __u64 __aligned_u64 __attribute__((aligned(8)));
+
+#endif /* COMPAT_LINUX_TYPES_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..17c5db369c 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -23,7 +23,7 @@
 
 #include "system/memory.h"
 #include "qemu/queue.h"
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_DARWIN)
 #include <linux/vfio.h>
 #endif
 #include "system/system.h"
@@ -171,7 +171,7 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(CONFIG_DARWIN)
 /*
  * How devices communicate with the server.  The default option is through
  * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
diff --git a/meson.build b/meson.build
index daa58e46a3..b12466b730 100644
--- a/meson.build
+++ b/meson.build
@@ -764,7 +764,14 @@ if 'objc' in all_languages
   add_project_arguments(objc.get_supported_arguments(qemu_common_flags + warn_flags),
                         native: false, language: 'objc')
 endif
-if host_os == 'linux'
+if host_os == 'darwin'
+  # linux-headers/linux/vfio.h includes <linux/types.h> and <linux/ioctl.h>
+  # which are system headers on Linux but absent on macOS.  Point at the
+  # static shims in include/compat/
+  add_project_arguments('-isystem', meson.current_source_dir() / 'include/compat',
+                        language: all_languages)
+endif
+if host_os in ['linux', 'darwin']
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
                         '-isystem', 'linux-headers',
                         language: all_languages)
@@ -3282,6 +3289,7 @@ host_kconfig = \
   (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=y'] : []) + \
   (have_virtfs ? ['CONFIG_VIRTFS=y'] : []) + \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
+  (host_os == 'darwin' ? ['CONFIG_DARWIN=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 83fdbb96bb..0e05e81aca 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -20,10 +20,10 @@
 #include <sys/eventfd.h>
 #endif
 
-#ifdef CONFIG_EVENTFD
 /*
  * Initialize @e with existing file descriptor @fd.
- * @fd must be a genuine eventfd object, emulation with pipe won't do.
+ * On hosts without eventfd(), callers can still restore a single descriptor
+ * for cases that only need eventfd-like semantics.
  */
 void event_notifier_init_fd(EventNotifier *e, int fd)
 {
@@ -31,7 +31,6 @@ void event_notifier_init_fd(EventNotifier *e, int fd)
     e->wfd = fd;
     e->initialized = true;
 }
-#endif
 
 int event_notifier_init(EventNotifier *e, int active)
 {
-- 
2.50.1 (Apple Git-155)


