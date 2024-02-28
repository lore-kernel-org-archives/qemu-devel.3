Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C3C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIRI-0006Bh-AK; Wed, 28 Feb 2024 06:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIRF-0005z6-OC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIR0-00043G-MM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLM8N8KufGIAXLoDANm2UQXu1s3D3+QLrZtKYGXzVoE=;
 b=L2SuMPT3hUFWfsW7ZNxQyChGYGn+C1HTWcXC/Hkn+dRMiFgTx/31rqM2OocoPaFoYwGvMI
 S9jsO+eSU8Qm+RR3T/S1X1Htm4rg2aIu/zjz0lRXOzCU3ah3brfJYzcNsUW1d5yl7X7/Rs
 rRwKkH+q6Y3FndexKiAsiG4HHjLjQVk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ATKOrPTgMVq0db0zGoDf_g-1; Wed, 28 Feb 2024 06:49:12 -0500
X-MC-Unique: ATKOrPTgMVq0db0zGoDf_g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69033ba441fso6424406d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120952; x=1709725752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLM8N8KufGIAXLoDANm2UQXu1s3D3+QLrZtKYGXzVoE=;
 b=xAn6Jv8ZrS+RxIp1I5vWA+jEiJrwv5MuCquxwHiyn+dOu9rjfWyPbubxau4sOKin+O
 x/a9knjAJk/MOSFKPyGSGO9ACGMshj/y8+1FnA+LZdT5CT+dpprrJtX+i+qfmyWrzBxv
 yFIAd84xSjI6xSOpRpINKcSrUMzgM6H3rCe8X4o5RXHWtOzdm80JfvwpNlEy3yJlogaG
 0H4Mq/OEiRot1Dv8er/Yjupq9M9UVEOWw3CfUFSGLln5fBVjvNvstX3FymKm/xGEZoXk
 V3IgCWAzxsPN6KdJKuLQfeAq9RF6je/FVvDzPWALpX7AUTngeTg3+8ZNAf0E4KGK0X+e
 HwBQ==
X-Gm-Message-State: AOJu0YxfBOH2aeK/8BOhSFpqdO0MiD9eFqYzWrfFUo7bYxck8r5kYiLM
 OU5DsTXpXb1CkLfsw2MU9jFNSlRHyrIhfcwtBBeUdw1EBkiCJXeuW8Jfy6X4bObyUolvUSXwpNp
 GO4FdcxXilqIqe2Xz//7mSLKKAzI8dXSRzKKbonpx9si2S4/s23HdUCyCgPIQmTu8ZamSsPsYB2
 cUdY5LwAeXOOig230qvyP5IRYVsfIqUL+DGIUx
X-Received: by 2002:a05:6214:3019:b0:690:b3f:8a1 with SMTP id
 ke25-20020a056214301900b006900b3f08a1mr5770451qvb.53.1709120951936; 
 Wed, 28 Feb 2024 03:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH1Xe9yloE9WF1xN62J37kqng1CId0u7Gqr9fCNzmg+QWyugEloWRMBvLpAyAPZ4B95+bZ0Q==
X-Received: by 2002:a05:6214:3019:b0:690:b3f:8a1 with SMTP id
 ke25-20020a056214301900b006900b3f08a1mr5770418qvb.53.1709120951591; 
 Wed, 28 Feb 2024 03:49:11 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 qj24-20020a056214321800b0068f9fd1d688sm5121717qvb.21.2024.02.28.03.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:49:10 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Date: Wed, 28 Feb 2024 12:47:59 +0100
Message-ID: <20240228114759.44758-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add a new `shm` bool option for `-object memory-backend-file`.

When this option is set to true, the POSIX shm_open(3) is used instead
of open(2).

So a file will not be created in the filesystem, but a "POSIX shared
memory object" will be instantiated. In Linux this turns into a file
in /dev/shm, but in other OSes this may not happen (for example in
macOS or FreeBSD nothing is shown in any filesystem).

This new feature is useful when we need to share guest memory with
another process (e.g. vhost-user backend), but we don't have
memfd_create() or any special filesystems (e.g. /dev/shm) available
as in macOS.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
I am not sure this is the best way to support shm_open() in QEMU.

Other solutions I had in mind were:

- create a new memory-backend-shm

- extend memory-backend-memfd to use shm_open() on systems where memfd is
not available (problem: shm_open wants a name to assign to the object, but
we can do a workaround by using a random name and do the unlink right away)

Any preference/suggestion?

Thanks,
Stefano
---
 qapi/qom.json           |  4 +++
 backends/hostmem-file.c | 57 ++++++++++++++++++++++++++++++++++++++++-
 backends/meson.build    |  2 +-
 qemu-options.hx         | 10 +++++++-
 4 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 2a6e49365a..bfb01b909f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -682,6 +682,9 @@
 #       writable RAM instead of ROM, and want to set this property to 'off'.
 #       (default: auto, since 8.2)
 #
+# @shm: if true, shm_open(3) is used to create/open POSIX shared memory
+#       object; if false, an open(2) is used. (default: false) (since 9.0)
+#
 # Since: 2.1
 ##
 { 'struct': 'MemoryBackendFileProperties',
@@ -692,6 +695,7 @@
             'mem-path': 'str',
             '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
             '*readonly': 'bool',
+            '*shm': 'bool',
             '*rom': 'OnOffAuto' } }
 
 ##
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ac3e433cbd..9d60375c1f 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -34,6 +34,7 @@ struct HostMemoryBackendFile {
     bool is_pmem;
     bool readonly;
     OnOffAuto rom;
+    bool shm;
 };
 
 static bool
@@ -86,7 +87,37 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
+    /* TODO: check if this should be enabled if shm is enabled */
     ram_flags |= RAM_NAMED_FILE;
+
+    if (fb->shm) {
+        mode_t mode = S_IRUSR | S_IWUSR;
+        int fd, oflag = 0;
+
+        oflag |= fb->readonly ? O_RDONLY : O_RDWR;
+        oflag |= O_CREAT;
+
+        fd = shm_open(fb->mem_path, oflag, mode);
+        if (fd < 0) {
+            error_setg_errno(errp, errno,
+                             "failed to create POSIX shared memory");
+            return false;
+        }
+
+        if (ftruncate(fd, backend->size) == -1) {
+            error_setg_errno(errp, errno,
+                             "failed to resize POSIX shared memory to %" PRIu64,
+                             backend->size);
+            shm_unlink(fb->mem_path);
+            return false;
+        }
+
+        return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
+                                              name, backend->size, ram_flags,
+                                              fd, fb->offset, errp);
+
+    }
+
     return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                             backend->size, fb->align, ram_flags,
                                             fb->mem_path, fb->offset, errp);
@@ -254,17 +285,36 @@ static void file_memory_backend_set_rom(Object *obj, Visitor *v,
     visit_type_OnOffAuto(v, name, &fb->rom, errp);
 }
 
+static bool file_memory_backend_get_shm(Object *obj, Error **errp)
+{
+    return MEMORY_BACKEND_FILE(obj)->shm;
+}
+
+static void file_memory_backend_set_shm(Object *obj, bool value,
+                                             Error **errp)
+{
+    MEMORY_BACKEND_FILE(obj)->shm = value;
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
 
-    if (host_memory_backend_mr_inited(backend) && fb->discard_data) {
+    if (!host_memory_backend_mr_inited(backend)) {
+        return;
+    }
+
+    if (fb->discard_data) {
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
         qemu_madvise(ptr, sz, QEMU_MADV_REMOVE);
     }
+
+    if (fb->shm) {
+        shm_unlink(fb->mem_path);
+    }
 }
 
 static void
@@ -300,6 +350,11 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
     object_class_property_set_description(oc, "rom",
         "Whether to create Read Only Memory (ROM)");
+    object_class_property_add_bool(oc, "shm",
+        file_memory_backend_get_shm,
+        file_memory_backend_set_shm);
+    object_class_property_set_description(oc, "shm",
+        "Use shm_open(3) to create/open POSIX shared memory objects");
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497..64520c0a7e 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -12,7 +12,7 @@ system_ss.add([files(
 
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
-  system_ss.add(files('hostmem-file.c'))
+  system_ss.add([files('hostmem-file.c'), rt])
 endif
 if host_os == 'linux'
   system_ss.add(files('hostmem-memfd.c'))
diff --git a/qemu-options.hx b/qemu-options.hx
index 9be1e5817c..da96ee506d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5079,7 +5079,7 @@ SRST
     they are specified. Note that the 'id' property must be set. These
     objects are placed in the '/objects' path.
 
-    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
+    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto,shm=on|off``
         Creates a memory file backend object, which can be used to back
         the guest RAM with huge pages.
 
@@ -5183,6 +5183,14 @@ SRST
         (``share=off``). For this use case, we need writable RAM instead
         of ROM, and want to also set ``rom=off``.
 
+        The ``shm`` option specifies whether to create/open a POSIX shared
+        memory object identified by ``mem-path``.
+        If set to ``on``, use shm_open(3); if set to ``off`` (default),
+        use open(2); For portable use, a shared memory object should be
+        identified by a name of the form ``/somename``; consisting of an
+        initial slash, followed by one or more characters, none of which
+        are slashes.
+
     ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
         Creates a memory backend object, which can be used to back the
         guest RAM. Memory backend objects offer more control than the
-- 
2.43.2


