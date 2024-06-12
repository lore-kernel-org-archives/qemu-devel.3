Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98296C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNe8-00006U-Ee; Wed, 12 Jun 2024 09:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNe2-00084g-F2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdz-0008JE-FW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuILcjmt+IGqqrmCWfNyApHFZ1jwMwhtnj49lIqwDgo=;
 b=IFo53V7KSRmPFDT7VSsZqnpdG+LvhKhbc3U3HfWYROgfogC+o3BS9U+S8/QhJnFzR0nj4N
 UfMLAVGmKAHoHm6ttgICo7AUbnahgk/tg7AyVf9d6JQuf7R4FnSQsaOwz5WcyC/peUOTLg
 oBF2/yV/lLJftUfc3gSU7Lytfg2FCl8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-kyQvt4Y6NrGJX6hzGVGtww-1; Wed, 12 Jun 2024 09:04:01 -0400
X-MC-Unique: kyQvt4Y6NrGJX6hzGVGtww-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6f96e58ad4aso4994891a34.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197438; x=1718802238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuILcjmt+IGqqrmCWfNyApHFZ1jwMwhtnj49lIqwDgo=;
 b=Rh469nttouQBUcqfrWkrWyVyH+lFo1El/3qsuq6oVUcXKKyu99B0NAlyS/y9YgubpQ
 lX469t3n6asUSbwlDjQjqK/xwKmVHgSyYhA/nyeJz392jbcRfeRP/qEZfuMeVy8hK7no
 mf0EbgS2MAtrRIUuu65Xy7yd9m6xfAZagdlnw7tl/b7tNiA1JQDhS9HGlmEr/yyWJPIY
 wbHAe2y2M1YBWP8Uj2z7ZrzOK5OqJdPHcgAHP8/n+JFO9yn69CZPhqQdy8z4hl58sZCU
 4f1OwZdLK2YcmazAc7/L5WT7VTAiO7WPFP09Fj6gqaN6FvAJQf//5yXF7Xe5CA3LNQwq
 DGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs3h/FXOR0rhArCvD0sz8S/z8k1iTowgpFI5gscfm1wpg1r91f7gJLaxQ1/Mqo2HKbH47amD6W/UJF6+Mp1oSYj5P5qws=
X-Gm-Message-State: AOJu0YzDEkwk0MACZrZwAXHFz2wHyuDEY/4RsezsNbuySLhXGGfI7ZUb
 VlypaL9lKKMIlkxf3hr1kQB+likiwnSI0pp1QLc1HB7P2CcY8KOAMOcGHjRMFlxprF7jLdGPrKw
 mOHgJAkvTLerIwOe3M1oHcZAh/gUZOiy8rk3LHlkDdmlXOntDngh5tqYhPL4a
X-Received: by 2002:a9d:6b0c:0:b0:6f9:64f1:5b14 with SMTP id
 46e09a7af769-6fa1c222cb2mr1909724a34.27.1718197438148; 
 Wed, 12 Jun 2024 06:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjkDDd6RjonXndaapuLxB4HBfdCMvqXtpm1GxyQkLBKjROIVCXG0LC2eK96fR+kd7sBMoow==
X-Received: by 2002:a9d:6b0c:0:b0:6f9:64f1:5b14 with SMTP id
 46e09a7af769-6fa1c222cb2mr1909687a34.27.1718197437669; 
 Wed, 12 Jun 2024 06:03:57 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4415df952d9sm3334201cf.88.2024.06.12.06.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:03:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 10/12] hostmem: add a new memory backend based on
 POSIX shm_open()
Date: Wed, 12 Jun 2024 15:01:38 +0200
Message-ID: <20240612130140.63004-11-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

shm_open() creates and opens a new POSIX shared memory object.
A POSIX shared memory object allows creating memory backend with an
associated file descriptor that can be shared with external processes
(e.g. vhost-user).

The new `memory-backend-shm` can be used as an alternative when
`memory-backend-memfd` is not available (Linux only), since shm_open()
should be provided by any POSIX-compliant operating system.

This backend mimics memfd, allocating memory that is practically
anonymous. In theory shm_open() requires a name, but this is allocated
for a short time interval and shm_unlink() is called right after
shm_open(). After that, only fd is shared with external processes
(e.g., vhost-user) as if it were associated with anonymous memory.

In the future we may also allow the user to specify the name to be
passed to shm_open(), but for now we keep the backend simple, mimicking
anonymous memory such as memfd.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v7
- changed default value documentation for @share rebasing on
  20240611130231.83152-1-sgarzare@redhat.com [Markus]
- used `memory-backend-shm` instead of `shm` and wrapped to 70 columns
  [Markus]
- added 'if': 'CONFIG_POSIX' to MemoryBackendShmProperties [Markus]
v5
- fixed documentation in qapi/qom.json and qemu-options.hx [Markus]
v4
- fail if we find "share=off" in shm_backend_memory_alloc() [David]
v3
- enriched commit message and documentation to highlight that we
  want to mimic memfd (David)
---
 docs/system/devices/vhost-user.rst |   5 +-
 qapi/qom.json                      |  24 +++++-
 backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
 backends/meson.build               |   1 +
 qemu-options.hx                    |  16 ++++
 5 files changed, 165 insertions(+), 4 deletions(-)
 create mode 100644 backends/hostmem-shm.c

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 9b2da106ce..35259d8ec7 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -98,8 +98,9 @@ Shared memory object
 
 In order for the daemon to access the VirtIO queues to process the
 requests it needs access to the guest's address space. This is
-achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
-objects. A reference to a file-descriptor which can access this object
+achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
+``memory-backend-shm`` objects.
+A reference to a file-descriptor which can access this object
 will be passed via the socket as part of the protocol negotiation.
 
 Currently the shared memory object needs to match the size of the main
diff --git a/qapi/qom.json b/qapi/qom.json
index 9b8f6a7ab5..94e4458288 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -601,8 +601,8 @@
 #
 # @share: if false, the memory is private to QEMU; if true, it is
 #     shared (default false for backends memory-backend-file and
-#     memory-backend-ram, true for backends memory-backend-epc and
-#     memory-backend-memfd)
+#     memory-backend-ram, true for backends memory-backend-epc,
+#     memory-backend-memfd, and memory-backend-shm)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -721,6 +721,22 @@
             '*hugetlbsize': 'size',
             '*seal': 'bool' } }
 
+##
+# @MemoryBackendShmProperties:
+#
+# Properties for memory-backend-shm objects.
+#
+# Setting @share boolean option (defined in the base type) to false
+# will cause a failure during allocation because it is not
+# supported by this backend.
+#
+# Since: 9.1
+##
+{ 'struct': 'MemoryBackendShmProperties',
+  'base': 'MemoryBackendProperties',
+  'data': { },
+  'if': 'CONFIG_POSIX' }
+
 ##
 # @MemoryBackendEpcProperties:
 #
@@ -1049,6 +1065,8 @@
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
+    { 'name': 'memory-backend-shm',
+      'if': 'CONFIG_POSIX' },
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1121,6 +1139,8 @@
       'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
                                       'if': 'CONFIG_LINUX' },
       'memory-backend-ram':         'MemoryBackendProperties',
+      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
+                                      'if': 'CONFIG_POSIX' },
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
new file mode 100644
index 0000000000..374edc3db8
--- /dev/null
+++ b/backends/hostmem-shm.c
@@ -0,0 +1,123 @@
+/*
+ * QEMU host POSIX shared memory object backend
+ *
+ * Copyright (C) 2024 Red Hat Inc
+ *
+ * Authors:
+ *   Stefano Garzarella <sgarzare@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/hostmem.h"
+#include "qapi/error.h"
+
+#define TYPE_MEMORY_BACKEND_SHM "memory-backend-shm"
+
+OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendShm, MEMORY_BACKEND_SHM)
+
+struct HostMemoryBackendShm {
+    HostMemoryBackend parent_obj;
+};
+
+static bool
+shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
+{
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+    g_autofree char *backend_name = NULL;
+    uint32_t ram_flags;
+    int fd, oflag;
+    mode_t mode;
+
+    if (!backend->size) {
+        error_setg(errp, "can't create shm backend with size 0");
+        return false;
+    }
+
+    if (!backend->share) {
+        error_setg(errp, "can't create shm backend with `share=off`");
+        return false;
+    }
+
+    /*
+     * Let's use `mode = 0` because we don't want other processes to open our
+     * memory unless we share the file descriptor with them.
+     */
+    mode = 0;
+    oflag = O_RDWR | O_CREAT | O_EXCL;
+    backend_name = host_memory_backend_get_name(backend);
+
+    /*
+     * Some operating systems allow creating anonymous POSIX shared memory
+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
+     * defined by POSIX, so let's create a unique name.
+     *
+     * From Linux's shm_open(3) man-page:
+     *   For  portable  use,  a shared  memory  object should be identified
+     *   by a name of the form /somename;"
+     */
+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
+                    backend_name);
+
+    fd = shm_open(shm_name->str, oflag, mode);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create POSIX shared memory");
+        return false;
+    }
+
+    /*
+     * We have the file descriptor, so we no longer need to expose the
+     * POSIX shared memory object. However it will remain allocated as long as
+     * there are file descriptors pointing to it.
+     */
+    shm_unlink(shm_name->str);
+
+    if (ftruncate(fd, backend->size) == -1) {
+        error_setg_errno(errp, errno,
+                         "failed to resize POSIX shared memory to %" PRIu64,
+                         backend->size);
+        close(fd);
+        return false;
+    }
+
+    ram_flags = RAM_SHARED;
+    ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
+
+    return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                              backend_name, backend->size,
+                                              ram_flags, fd, 0, errp);
+}
+
+static void
+shm_backend_instance_init(Object *obj)
+{
+    HostMemoryBackendShm *m = MEMORY_BACKEND_SHM(obj);
+
+    MEMORY_BACKEND(m)->share = true;
+}
+
+static void
+shm_backend_class_init(ObjectClass *oc, void *data)
+{
+    HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
+
+    bc->alloc = shm_backend_memory_alloc;
+}
+
+static const TypeInfo shm_backend_info = {
+    .name = TYPE_MEMORY_BACKEND_SHM,
+    .parent = TYPE_MEMORY_BACKEND,
+    .instance_init = shm_backend_instance_init,
+    .class_init = shm_backend_class_init,
+    .instance_size = sizeof(HostMemoryBackendShm),
+};
+
+static void register_types(void)
+{
+    type_register_static(&shm_backend_info);
+}
+
+type_init(register_types);
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497..3867b0d363 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -13,6 +13,7 @@ system_ss.add([files(
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
   system_ss.add(files('hostmem-file.c'))
+  system_ss.add([files('hostmem-shm.c'), rt])
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34ef0..ad6521ef5e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5240,6 +5240,22 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+        Creates a POSIX shared memory backend object, which allows
+        QEMU to share the memory with an external process (e.g. when
+        using vhost-user).
+
+        ``memory-backend-shm`` is a more portable and less featureful version
+        of ``memory-backend-memfd``. It can then be used in any POSIX system,
+        especially when memfd is not supported.
+
+        Please refer to ``memory-backend-file`` for a description of the
+        options.
+
+        The ``share`` boolean option is on by default with shm. Setting it to
+        off will cause a failure during allocation because it is not supported
+        by this backend.
+
     ``-object iommufd,id=id[,fd=fd]``
         Creates an iommufd backend which allows control of DMA mapping
         through the ``/dev/iommu`` device.
-- 
2.45.2


