Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59BCD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZMi-0002KH-If; Thu, 31 Oct 2024 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMG-0001UC-5K
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMA-0007O2-Dh
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkfppaPFQdn9iyhClfe7ogToYCdG3Og5N/a4TPV6LpQ=;
 b=V0RL+jldDOLK48UNly9QOpO6jpuT+hKs7GehvKqet+BFJlv7dqqGgKsyRmLeHvu9AL0IZk
 KLDCOwKki/Xo+96pa7lh4fkD/RB7wvF8E7MUSkWAaOIWenPUaWZrbtFHIqPC10RkdOerAH
 3zUjSIP1jgLpHhRmUnFD0qPhjQx3fg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-HIVlcJpcOHeMnXi_a63LvQ-1; Thu, 31 Oct 2024 13:53:11 -0400
X-MC-Unique: HIVlcJpcOHeMnXi_a63LvQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso7609355e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397189; x=1731001989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkfppaPFQdn9iyhClfe7ogToYCdG3Og5N/a4TPV6LpQ=;
 b=GMomJLmh+90e7BrP9dMJ/c7WvCVdf6lxGcQNYD6s9pLCODYU3AQAKX2wN9tDxAp1/e
 zhoE3BAo9hdfIhQxDHpBLoMj41yUlGbQAxTOsotdvhbLmRlaSEJLV5VlDXjFTe/aunLb
 eqBksUHWYxd9MzPd1tB7tU4fIFHYUKJ06xX9ba0/GQSu9Ch57NLjHhXKVFTcCUKyGsBl
 pQ3VgwgmnvurU2Xg+1/evXkOhfEaa9+b0yR9+pUppIsjjDX+dolxvfL/2UdDnmrlT/C3
 8P0XikJk6ERl2BiJ/BHj5EXBbVVNkZcbjniW68KlauCEC68dQf3SZGs3Ljp1OeOUxuDy
 /Xqg==
X-Gm-Message-State: AOJu0Yx3lejT8z+eLhI0R+g788d1pXM6rwPmmM/KwsBXwGFKjAtYbNFJ
 wjOhUi8MKtyyMS4no2NahxC/RTUZY9NHEtuuDIXoNtCc3qnp18p91EHYAFCnCtsl5q/eh7sz73t
 4sWwT0pXy6GFNL1kri764hS34pDW0Ys7r/5Ybg307I8eo/n2PH/h4pTuljolT06qoqi6YtbCi6b
 Af3Y3iEets6hH79i5ZDPJdwW4viZI0iE0Nj92w4og=
X-Received: by 2002:a05:600c:5121:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4328325681fmr6269905e9.20.1730397188699; 
 Thu, 31 Oct 2024 10:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/pRJsEjEC2NtCVS2qIEH8QbqzAqx16ZK4LYHnWpayEoOTFFoO0k7EbX76NFADMF1Tgtv38g==
X-Received: by 2002:a05:600c:5121:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4328325681fmr6269685e9.20.1730397188213; 
 Thu, 31 Oct 2024 10:53:08 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852fdsm33549295e9.34.2024.10.31.10.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, Alexander Graf <graf@amazon.com>
Subject: [PULL 24/49] core/machine: Make create_default_memdev machine a
 virtual method
Date: Thu, 31 Oct 2024 18:51:48 +0100
Message-ID: <20241031175214.214455-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

This is in preparation for the next commit where the nitro-enclave
machine type will need to instead use a memfd backend, for the built-in
vhost-user-vsock device to work.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20241008211727.49088-5-dorjoychy111@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/boards.h      |  2 ++
 include/sysemu/hostmem.h |  2 ++
 backends/hostmem-memfd.c |  2 --
 hw/core/machine.c        | 71 +++++++++++++++++++++-------------------
 4 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baab..91f2edd3924 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -314,6 +314,8 @@ struct MachineClass {
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
     uint64_t smbios_memory_device_size;
+    bool (*create_default_memdev)(MachineState *ms, const char *path,
+                                  Error **errp);
 };
 
 /**
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index de47ae59e4b..67f45abe392 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -39,6 +39,8 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
  */
 #define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
 
+#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
+
 
 /**
  * HostMemoryBackendClass:
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 6a3c89a12b2..9f890a813e1 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -18,8 +18,6 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 
-#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
-
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17ebac..222799bc46e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1001,6 +1001,39 @@ void machine_add_audiodev_property(MachineClass *mc)
                                           "Audiodev to use for default machine devices");
 }
 
+static bool create_default_memdev(MachineState *ms, const char *path,
+                                  Error **errp)
+{
+    Object *obj;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    bool r = false;
+
+    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
+    if (path) {
+        if (!object_property_set_str(obj, "mem-path", path, errp)) {
+            goto out;
+        }
+    }
+    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
+        goto out;
+    }
+    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
+                              obj);
+    /* Ensure backend's memory region name is equal to mc->default_ram_id */
+    if (!object_property_set_bool(obj, "x-use-canonical-path-for-ramblock-id",
+                             false, errp)) {
+        goto out;
+    }
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
+        goto out;
+    }
+    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
+
+out:
+    object_unref(obj);
+    return r;
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1020,6 +1053,8 @@ static void machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 23;
 
+    mc->create_default_memdev = create_default_memdev;
+
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel);
     object_class_property_set_description(oc, "kernel",
@@ -1413,38 +1448,6 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
     return ret;
 }
 
-static bool create_default_memdev(MachineState *ms, const char *path, Error **errp)
-{
-    Object *obj;
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    bool r = false;
-
-    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
-    if (path) {
-        if (!object_property_set_str(obj, "mem-path", path, errp)) {
-            goto out;
-        }
-    }
-    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
-        goto out;
-    }
-    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
-                              obj);
-    /* Ensure backend's memory region name is equal to mc->default_ram_id */
-    if (!object_property_set_bool(obj, "x-use-canonical-path-for-ramblock-id",
-                             false, errp)) {
-        goto out;
-    }
-    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
-        goto out;
-    }
-    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
-
-out:
-    object_unref(obj);
-    return r;
-}
-
 const char *machine_class_default_cpu_type(MachineClass *mc)
 {
     if (mc->valid_cpu_types && !mc->valid_cpu_types[1]) {
@@ -1548,7 +1551,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                 machine_class->default_ram_id);
             return;
         }
-        if (!create_default_memdev(current_machine, mem_path, errp)) {
+
+        if (!machine_class->create_default_memdev(current_machine, mem_path,
+                                                  errp)) {
             return;
         }
     }
-- 
2.47.0


