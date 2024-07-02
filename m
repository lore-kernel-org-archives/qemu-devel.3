Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E55C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyB-00083P-Su; Tue, 02 Jul 2024 16:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxy-0006jg-UO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxu-0001DN-Kj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nT/3bEAHv/ccVmumWuUDEQosc383NR5xwSBkJ1pU+nE=;
 b=UJ1Q3GQrf4WjNMabRBl6vUAnJRRDfIa+SWRU7G7tiAzwcu51SV1onIT2W3+2yQ8a8IK1DC
 cbnZMyBbsiR4I3+nJn3D3K9g13if7CZs0sTI0E4aPuwW6Ltt0SOCpgOAs0At4k0ODfgbwk
 TCoa4CDJQV2LBBZd+lHy/lH222KJ5Mo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vJROqLE8MSynTU3woZ7Uog-1; Tue, 02 Jul 2024 16:19:00 -0400
X-MC-Unique: vJROqLE8MSynTU3woZ7Uog-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257dd7d462so20007135e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951539; x=1720556339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nT/3bEAHv/ccVmumWuUDEQosc383NR5xwSBkJ1pU+nE=;
 b=EuM+E3qnopJ5agWwwtY7XE266TvU0DLIFmjqRhmJaPZVc0X23VCtpi0LwG0q3H97sj
 E/JF/mEzVEQctcPH2PMLzAthKY/LtLgFf9mUlDc5+Lvd3eK0ZFMR6fswiIS0AdREedbu
 gC4E+ySdZXZJpemD9FUJfbuhdEtYiTy/Hu3mlbvSq+bArmI5DQLj8TQWL5Kv0kp99i7t
 gMrQj8eQyH3+crHdp08rG8BAVsRP4f45Nuxf0S+Gufc8MUXcL9mmqHe2DCJ7S9lPdUme
 wq4XScSYUlhT62w919WilmccWP4g24hiu5MbUNO/ZV3Fpp+w5YJ2vIp/IFTqWeI0U7KT
 Sx1g==
X-Gm-Message-State: AOJu0YxjjSVXek3zZJXozPIyp/XtBZFaC4hGckBA0+4JCLxY+2laPuTH
 zdxKG+vqbzOrsItAoWzgSX83aNw1aAxwygWMqBxOd8lZ2eXMvbt3iBidWn5RUveijESE8Zo4y17
 t8lHJZEgCI29lMpGgQ5dsyT6stQ61hb3CTjQPOMXF2tGSnPc3K31w/2MjiwNNyMrsrqVhFpzA1B
 uXrvTcoakcPfywOj4QSqWYvfDJxXTkaQ==
X-Received: by 2002:a05:6000:d51:b0:360:9e68:d9e1 with SMTP id
 ffacd0b85a97d-367756bd5d6mr6596600f8f.40.1719951538842; 
 Tue, 02 Jul 2024 13:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfDDHZ/BhFi0Z/rj8/uRy+aPnl/QyGiWnJkgp3mQSJbY+2xjXI5HqVBDNf0c7y0cKHmLUErA==
X-Received: by 2002:a05:6000:d51:b0:360:9e68:d9e1 with SMTP id
 ffacd0b85a97d-367756bd5d6mr6596570f8f.40.1719951537975; 
 Tue, 02 Jul 2024 13:18:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8e97sm14047022f8f.33.2024.07.02.13.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:56 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 56/88] hostmem: add a new memory backend based on POSIX
 shm_open()
Message-ID: <21e7b1d01ec98d7012899760c280816c6cf328a2.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

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
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100519.145853-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json                      |  23 +++++-
 backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
 backends/meson.build               |   1 +
 docs/system/devices/vhost-user.rst |   5 +-
 qemu-options.hx                    |  16 ++++
 5 files changed, 164 insertions(+), 4 deletions(-)
 create mode 100644 backends/hostmem-shm.c

diff --git a/qapi/qom.json b/qapi/qom.json
index 9b8f6a7ab5..92b0fea76c 100644
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
@@ -721,6 +721,21 @@
             '*hugetlbsize': 'size',
             '*seal': 'bool' } }
 
+##
+# @MemoryBackendShmProperties:
+#
+# Properties for memory-backend-shm objects.
+#
+# This memory backend supports only shared memory, which is the
+# default.
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
@@ -1049,6 +1064,8 @@
     { 'name': 'memory-backend-memfd',
       'if': 'CONFIG_LINUX' },
     'memory-backend-ram',
+    { 'name': 'memory-backend-shm',
+      'if': 'CONFIG_POSIX' },
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1121,6 +1138,8 @@
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
index 106312f0c8..749b491f12 100644
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
MST


