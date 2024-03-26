Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4991CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72a-0008LT-DD; Tue, 26 Mar 2024 09:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72W-0008Aa-IF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72U-0005FV-FF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTpxY9sVKAa1TjG2Q5l8JHWOtdy2byARIHISthkoJF8=;
 b=DlLlYu5KqpvwyB1OAf/VoYZGE1mFfeqz/avmTXjhDcfdtM4XErxO6e1FOq0exBu/uUrlXT
 PBGgCymN1FW47fafe0mNkgksUY9L4mbK5MPUO3euHtFtQySGlkVJs013tBSG8yFMk4lSCw
 qlsLnwD8c3oXRJdLs9/3kNQ1hb+oSUM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-QWhaZxV3NX6awBu4Z9O6Tg-1; Tue, 26 Mar 2024 09:40:27 -0400
X-MC-Unique: QWhaZxV3NX6awBu4Z9O6Tg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-414913bd7c9so229885e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460426; x=1712065226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTpxY9sVKAa1TjG2Q5l8JHWOtdy2byARIHISthkoJF8=;
 b=AqUKKH6O1EzP7dAj5bZ9UGS7cSoGi0klh5LjtmLGFYhpQ6OGR3jib1ycgkll1VX++Z
 b3TCo7TKTedpawV/lfXO89Y+x4g9oSBQ7V9x4M6KoGzczuA5uGnRlnQ71IdGrTg2MuqN
 iDxmuI6xo1k1d41Ztw/xROgRviSZM1WU1bMvC0yqnxB7SpJH9Do3yGv2S0fN1BuXD6fO
 5wzGS+Lhtf08W7/PjrxZQDRDm6sElOsXpGtos4nt+cgkR1X6CCeE6XykQQQwDn3mdXBl
 IgeHY/ZB52d6xL2RtF5vIM4ylVZN20jYNwCIU1Tq84L0isohjSWg556Hnyq5+njreOl/
 PdaA==
X-Gm-Message-State: AOJu0Yyxne0NXceH4AwsVNiX9EuwxEj7JVoHY6yXexnGBITzSd8uENrl
 /E4VXx+FKF3x71MxsSrXEm2dLXJ7h2gi80ZVRIQMewPoUxKYOtNAGFl9jqHUQcywHR44KSatnG4
 W4nYd9rypIfE8IrVPo5eXuAVOCxmAfa1EWAaG7EYyWJ7lD0DVESpds+q9ryPwyv7x6AZy+BLE8u
 9GVlU3Xi1at1/pZN5475eT1+gp6PFyg2ylWxGv
X-Received: by 2002:a05:600c:474d:b0:414:9048:40ba with SMTP id
 w13-20020a05600c474d00b00414904840bamr881450wmo.0.1711460425738; 
 Tue, 26 Mar 2024 06:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEiqc4JKJHmFMgiyD0X5TC8bFNQF9HaL+UGQuWpamWW6UgXsYMD4fOS0qHNC8VBbVUNd6BsA==
X-Received: by 2002:a05:600c:474d:b0:414:9048:40ba with SMTP id
 w13-20020a05600c474d00b00414904840bamr881410wmo.0.1711460425329; 
 Tue, 26 Mar 2024 06:40:25 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c4ec900b00414659ba8c2sm11794460wmq.37.2024.03.26.06.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 09/11] hostmem: add a new memory backend based on
 POSIX shm_open()
Date: Tue, 26 Mar 2024 14:39:34 +0100
Message-ID: <20240326133936.125332-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 docs/system/devices/vhost-user.rst |   5 +-
 qapi/qom.json                      |  17 +++++
 backends/hostmem-shm.c             | 118 +++++++++++++++++++++++++++++
 backends/meson.build               |   1 +
 qemu-options.hx                    |  10 +++
 5 files changed, 149 insertions(+), 2 deletions(-)
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
index baae3a183f..88136b861d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -720,6 +720,19 @@
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
index 7fd1713fa8..70fa98ba19 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5230,6 +5230,16 @@ SRST
 
         The ``share`` boolean option is on by default with memfd.
 
+    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
+        Creates a POSIX shared memory backend object, which allows
+        QEMU to share the memory with an external process (e.g. when
+        using vhost-user).
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


