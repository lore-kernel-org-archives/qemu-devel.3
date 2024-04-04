Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F64CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8s-0000yB-B8; Thu, 04 Apr 2024 08:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8q-0000wc-O3
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8n-00014T-Qv
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a31EVxox+uEf/JvzH//LShQvlLk4Tanal3CfBj7bgpw=;
 b=R8I3un0wTct1U6ES223AO7B0L4cZ1yx2kk+5X+8flT+d1cid45KADNHSAwsVPzyxql5FP0
 oWa30fJ+HCjdkwNz1nFM63bAkLH/gqOkG1gKadLCoujGvxKsxOWRfTdv96h6/UIGDSlYby
 HyvTAgvpBYMzdBbkRfpgaMDavg4TG6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qrBQwBT9MCCCttF5nWOxrA-1; Thu, 04 Apr 2024 08:24:23 -0400
X-MC-Unique: qrBQwBT9MCCCttF5nWOxrA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4e9636661eso63913366b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233462; x=1712838262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a31EVxox+uEf/JvzH//LShQvlLk4Tanal3CfBj7bgpw=;
 b=rU7MCfwAb89Z7KYI86aN38HHVxeoWxb6A8fDpI9me7KTLBIq2MX4/4hVxsesRcNGZm
 SdUFvBOiLVOCxEybAYNqNQRP57NpG1mHZmuFJW8F0UC5OUHJUetQQaC/b8+yIWS3yoLL
 Brj8ISa9swYXQ7RtD6m8DQoaQj8jacNEAC+MroAKWtOltGViG7lDKMMsFjN88Y8l8aIe
 o4BIa+j92M8Vn2taZXq5N1eAs8MlVrq0VAGUGha1yhkqRpfZjGbp9b3rfZl1c6mp397i
 G+DjbXa1MYUjixIe0gUBVyfJxdQ+EOvgQHSOqlp7q0KvWhyvyDoJV9d6PRgZSTPTp5mN
 2MDg==
X-Gm-Message-State: AOJu0YzyWF525nuwxKCwXBYkFGllUWNP1k8Y0Xk6VR8+vug6qBQVI/FN
 luRFhU4PH5ypMiWZsH2M3T91w9vnAD9Pwl8E9kngo833Hfukmov2XaYhle9F3K457W5+f59ZjwI
 kP105PC4bGpkp9gcMdly6Ax2QyszDQ7awCikt/GXYeMtFyi/gyUoSz9UzYtuuwMqKgNmTa9zc8p
 Da/nD714MMSuk2PognqO/thqMb+W008y/D1Xqm
X-Received: by 2002:a17:906:1956:b0:a4a:aa3b:8002 with SMTP id
 b22-20020a170906195600b00a4aaa3b8002mr1485742eje.15.1712233461710; 
 Thu, 04 Apr 2024 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5yuDCHj61XKP+6xN1UroYtqXFtcA32EQMQT2scH8qJyhRE3qsgdCdlgWysAROmnSaHUiVtQ==
X-Received: by 2002:a17:906:1956:b0:a4a:aa3b:8002 with SMTP id
 b22-20020a170906195600b00a4aaa3b8002mr1485704eje.15.1712233461311; 
 Thu, 04 Apr 2024 05:24:21 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 qf4-20020a1709077f0400b00a5195edf8e8sm174517ejc.62.2024.04.04.05.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:20 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 09/11] hostmem: add a new memory backend based on
 POSIX shm_open()
Date: Thu,  4 Apr 2024 14:23:28 +0200
Message-ID: <20240404122330.92710-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3
- enriched commit message and documentation to highlight that we
  want to mimic memfd (David)
---
 docs/system/devices/vhost-user.rst |   5 +-
 qapi/qom.json                      |  17 +++++
 backends/hostmem-shm.c             | 118 +++++++++++++++++++++++++++++
 backends/meson.build               |   1 +
 qemu-options.hx                    |  11 +++
 5 files changed, 150 insertions(+), 2 deletions(-)
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
index 85e6b4f84a..5252ec69e3 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -721,6 +721,19 @@
             '*hugetlbsize': 'size',
             '*seal': 'bool' } }
 
+##
+# @MemoryBackendShmProperties:
+#
+# Properties for memory-backend-shm objects.
+#
+# The @share boolean option is true by default with shm.
+#
+# Since: 9.1
+##
+{ 'struct': 'MemoryBackendShmProperties',
+  'base': 'MemoryBackendProperties',
+  'data': { } }
+
 ##
 # @MemoryBackendEpcProperties:
 #
@@ -976,6 +989,8 @@
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
+    { 'name': 'memory-backend-shm',
+      'if': 'CONFIG_POSIX' },
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1047,6 +1062,8 @@
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
index 0000000000..7595204d29
--- /dev/null
+++ b/backends/hostmem-shm.c
@@ -0,0 +1,118 @@
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
+        error_setg(errp, "can't create backend with size 0");
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
+    ram_flags = backend->share ? RAM_SHARED : 0;
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
index 7fd1713fa8..02783803aa 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5230,6 +5230,17 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+        Creates a POSIX shared memory backend object, which allows
+        QEMU to share the memory with an external process (e.g. when
+        using vhost-user). This backend mimics memfd, allocating memory that is
+        practically anonymous. This is useful when memfd is not available.
+
+        Please refer to ``memory-backend-file`` for a description of the
+        options.
+
+        The ``share`` boolean option is on by default with shm.
+
     ``-object iommufd,id=id[,fd=fd]``
         Creates an iommufd backend which allows control of DMA mapping
         through the ``/dev/iommu`` device.
-- 
2.44.0


