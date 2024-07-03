Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455AAC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mE-0000oa-5H; Wed, 03 Jul 2024 18:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mC-0000nd-7g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mA-0004Wp-6m
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nT/3bEAHv/ccVmumWuUDEQosc383NR5xwSBkJ1pU+nE=;
 b=RHl8IGDYJN9icaZQR0xdEGEYlB+PT2bfOIt9pzBRHmJkpDkdW7F77kTDbkGmxu5iKxYYoy
 6vctobn6CEYJML8G+f7BHtFdets7RPMZD/uxjLwQBGbwUVIk6ZKEdaapRsw9e4aKd6GcK/
 II8v9qOQQ1cWXvXbQxSoPB65oWrpoAo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-SlvQhxRHMW-1ez-uEx0UAQ-1; Wed, 03 Jul 2024 18:48:32 -0400
X-MC-Unique: SlvQhxRHMW-1ez-uEx0UAQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-586c45fc092so2782291a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046911; x=1720651711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nT/3bEAHv/ccVmumWuUDEQosc383NR5xwSBkJ1pU+nE=;
 b=e5DtawXizb+a5jsVvNcB1ylEBabxWn2HTX/UIG89qkw/kErQ5GtfQ/DFAiCag+txjP
 CKZeDwxYdxC5JXsq/70juwjgTqfn9YkthNlBHrLdL8Wr3zLDR63Va4nJ+uj3RHnwDRy7
 oFcYCo9/IpzXWnz3rdE8IB1CUqB2Wk7oHpHIMzVFJcPtqOwsqkpAMF92tdu7dathkzte
 ITnDkb8rw9hpVE4lwb4ZSuBx7wZPCMuIsLXgkVyP0qMCPQHBpbDdDCvHjqdOXBddWOhA
 eV7iMfb6ZdukL9oZKCC36l27qQHSioVFBqf9VoXaThlINszqJCS4FfNJyqgtTa+q1z1J
 tSzQ==
X-Gm-Message-State: AOJu0Yz256Po6xQG2/jO6Y403xOFGZko3RVdyeXf/FuAwMWXXQoxKxH5
 siBRG6FI7bveYyrgoEVsK1ibnRv3BbmWS/aP8FnyencV3+2f07FhMW0j9GWXlGc66uYT7Qqy5Aa
 Vwj/5EFF7aCCZS7Oc/UFTW6eouKZIkJLPTNLCisF2D1gd3/omPDlI3v25HeVHmb/qmDnevdtsyv
 zTlJjxaVw5pMfxxwqzxkDL1H6xM15IuQ==
X-Received: by 2002:a05:6402:354c:b0:57c:a77d:a61e with SMTP id
 4fb4d7f45d1cf-5879ede2779mr9469304a12.7.1720046910827; 
 Wed, 03 Jul 2024 15:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1CpDi8g8001mRuuRomIjteSgUp7J9coi8GeJJUJynn3T0HgEETgOZoox3ES71S7fZBZKSzg==
X-Received: by 2002:a05:6402:354c:b0:57c:a77d:a61e with SMTP id
 4fb4d7f45d1cf-5879ede2779mr9469265a12.7.1720046909788; 
 Wed, 03 Jul 2024 15:48:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d50c4dad9sm1055799a12.10.2024.07.03.15.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:29 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: [PULL v3 53/85] hostmem: add a new memory backend based on POSIX
 shm_open()
Message-ID: <4e647fa08586a5ada74cf6d3ae1cdf3a027202cb.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


