Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423FECF0423
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHai-0000zA-KO; Tue, 08 Oct 2024 17:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHae-0000yR-Tt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHac-0000JE-7b
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e1a715c72so514098b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422272; x=1729027072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+muP5dO1nGu0swq72CYPofawNUkLVVMQiIFvA203T4=;
 b=Wpcgc3zcZczyrRPKMguZiohz1G2Ck6PX+VPVJGgvR2zCTeAT0G3RThYYc/jl6KmdH1
 BpzuMrvsZX7eEmAqsAyzKeWlZi4q34p3wanEXnLvPPt5+WgN+dCJXHz3LhAwoN9YHe7h
 5mVxR+CB6hUUjMatc4+4VsTUwr9+C/7tjgT5a7+eJpKDlZ80y3RDf7LTy7cEJQ0Ezk9y
 irBudbudYN/hm69bhflWpOpOLUDYHBJxpW87EHsAWdYN6G9uGOW4Pbuxqo+MN0L568ra
 QX6AOdiQl3a1Uv7rAze/5irp0xn5pB46KL/TLMAW/JUKpP+38x3QfHOWmFST7Se8mXwN
 RZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422272; x=1729027072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+muP5dO1nGu0swq72CYPofawNUkLVVMQiIFvA203T4=;
 b=AY+b6icijJmcKcJLOowuF2YN/pRRjY/Y7HGyk6CabfdN9WW4A4qf73mlNaL3LgkHBB
 rln/pxdo76WxCKNIFs35DOKs35aUMsQBws2prh190IG18CHYp6Vve/xEg4hgvZyrDgk1
 yWbu7uUT6waxYX8dPpH6bfQPZocAZNm5Sb4ePS32/qTwEnRGl6nP0d+OkeEg0HLKdW6+
 Vb3cRoUaIT+CBnldrlwOvvvynWtPR51CGYeVI40tRSMzfqLTpP2wRHXxppalHV/2SaT0
 ng0SBihHWDUU5TMAvLa6ZV1MkiskjMCXwtMF/oOkjemRFkd/XOhwHLZAMtIVSFQqafpF
 vU2g==
X-Gm-Message-State: AOJu0YzT6HA+/rlugX4jUdE/ee3COiYOAaOb2473UDtUWqiaQqfF/Rgb
 U5IT4NJYAlBE34GuI1senLzLZ9mzVfBn+LVUAy4ZHEQf/uPKuyzLxpx92g==
X-Google-Smtp-Source: AGHT+IGCmyPfZCGVneoY+rTi3FiWj9y7yaqiOqGA5FPE4mcvzmpwHNv/dIfWZYo0PSZo+dHaUEs3cw==
X-Received: by 2002:a05:6a00:1ac7:b0:71e:1784:4cbe with SMTP id
 d2e1a72fcca58-71e1db87c14mr234800b3a.15.1728422271747; 
 Tue, 08 Oct 2024 14:17:51 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6254dsm6549078b3a.153.2024.10.08.14.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:17:51 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v8 4/6] core/machine: Make create_default_memdev machine class
 property
Date: Wed,  9 Oct 2024 03:17:25 +0600
Message-Id: <20241008211727.49088-5-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008211727.49088-1-dorjoychy111@gmail.com>
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is in preparation for the next commit where the nitro-enclave
machine type will need to instead use a memfd backend for the built-in
vhost-user-vsock device to work.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 backends/hostmem-memfd.c |  2 --
 hw/core/machine.c        | 71 +++++++++++++++++++++-------------------
 include/hw/boards.h      |  2 ++
 include/sysemu/hostmem.h |  2 ++
 4 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 6a3c89a12b..9f890a813e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -18,8 +18,6 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 
-#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
-
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..222799bc46 100644
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
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baa..91f2edd392 100644
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
index de47ae59e4..67f45abe39 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -39,6 +39,8 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
  */
 #define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
 
+#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
+
 
 /**
  * HostMemoryBackendClass:
-- 
2.39.5


