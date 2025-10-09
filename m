Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B926CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQe-0008Gq-3n; Thu, 09 Oct 2025 03:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQd-0008GX-4F
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQW-0004P1-Vu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRttI8LqJE5R4/hPKUJbIz7mchb821txk/PsshPhKrE=;
 b=FFZAubCbD5Zk9Yg3wntR4XVT+8VDtg0FrlngLSmZcEZxELJc5kGF9O6Ko6ZeccKu71nwgA
 TL38m5FKbllBX6YJvF0nIpmI3V0YByUJpuWIzspo8k5CqiQ6Q/FHR/273T+8YxhW0KOahF
 ne2s+0IP4o24DgOAMobG21xk9DQmElc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-s4BmvBT6NimWYR7-U_7w7w-1; Thu, 09 Oct 2025 03:51:01 -0400
X-MC-Unique: s4BmvBT6NimWYR7-U_7w7w-1
X-Mimecast-MFC-AGG-ID: s4BmvBT6NimWYR7-U_7w7w_1759996260
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso787889f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996259; x=1760601059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRttI8LqJE5R4/hPKUJbIz7mchb821txk/PsshPhKrE=;
 b=I0dALN4NVSpnMWpwqHZFiabH0NTSY8VmvCKMOG/Lwg77/dyKFZV0938ajHsEvh1q9z
 QZzqXDfx7vFnAG4+bgNNr6uGALUuv9JrSDM/Oo7USpydYamU1mQ3KqtbdM8sYM9U3Jmb
 gF65nZbucn84FDpP1P4W7Uw8sQPjcUFpQ1kw11VlG/8vCKL55s0cqdpYd2TbqR+7K4Fu
 VVkuzZvW8FWMSifQt8gCCnTAbmZmizztfEvW8KlTXVcS7VVZ3uR0W+6F1JJQ1uLmp0ry
 pwMmUIWyzAwXQqX7/NXORzcdm/ZBQaqTosA4KYL1ez5/Vpz7XQWjuO4F4QKsYg2+Pooh
 qJFw==
X-Gm-Message-State: AOJu0YwnnD7y6ltd9HaYwVLGDTRk4ZEds0ogx5bnQxg2H1dnxwTalThc
 5zZ+wYVtAdku0+rO+kL5+wLRwdoPKyBwYWQ/UcvYLAKmgrERfv5PmxXFhxb7x7/TGJs6YrlIV+7
 zOX+8EpMBJccSla0lgmHm3V/tuRCS3jb4EXGUBASUT4aeyE5f2Hv1iuyTn0A/7QlRiWNVgSZStc
 XpRGVCcDQeif7m10AB7HoVbwqmpUmT2K9GJcG+7xXfH30=
X-Gm-Gg: ASbGncuaiUsBeGe9GsjQguEnHUnJ25cfVkOPgYYGLc/qEKhyRO+dt6U/CL5LIogeyyB
 doLpW4o2wCgUx2whDU/hrV/c2JyVnDGwVlMu2xobx9bQWbDLY7ys4NfhQ6VaaSjCMaqwhuaRuv2
 GdXj647h9n1uDtQ0Ujn/mhMx7CkXV/tBaolrA5OzzIlwwrB4o0iSXMnCYJvqYMC5XMVyxKZTR05
 957f5dbMGipmF07nZ+yQsoxm839VCfA3cO1ntCf0HRzMJjYUFg79xOTdBkwWLTw/N1cUu8MbgKn
 yc6DYWbugKlXmyR/Ve0H4cKC49DCJnrfIOgDE8BlKBpsJgGa2/Y0PHGyzhFC3F9d+9g5w3VCKRs
 PsqhV0uW+K2BcgsTuozdhtBo2ARyAtWWDb3q9aLRndBc3Efys
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr49298145e9.19.1759996259232; 
 Thu, 09 Oct 2025 00:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlJJXmpR5YD6BvCj/ybtiU85WhsDEKc+ocnEN6V2cY2/HsI0wq17W9qQfES5qw3K5nu9v24g==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr49297955e9.19.1759996258791; 
 Thu, 09 Oct 2025 00:50:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d62890sm69282035e9.14.2025.10.09.00.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 14/35] accel/mshv: Register memory region listeners
Date: Thu,  9 Oct 2025 09:50:04 +0200
Message-ID: <20251009075026.505715-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Add memory listener hooks for the MSHV accelerator to track guest
memory regions. This enables the backend to respond to region
additions, removals and will be used to manage guest memory mappings
inside the hypervisor.

Actually registering physical memory in the hypervisor is still stubbed
out.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-9-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h |  4 +++
 accel/mshv/mem.c          | 25 +++++++++++++++
 accel/mshv/mshv-all.c     | 67 +++++++++++++++++++++++++++++++++++++--
 accel/mshv/meson.build    |  1 +
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 accel/mshv/mem.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 132491b599d..cfa177ff72f 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -38,4 +38,8 @@ struct MshvState {
     MshvAddressSpace *as;
 };
 
+/* memory */
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add);
+
 #endif
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
new file mode 100644
index 00000000000..9889918c31f
--- /dev/null
+++ b/accel/mshv/mem.c
@@ -0,0 +1,25 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
+                       bool add)
+{
+    error_report("unimplemented");
+    abort();
+}
+
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ae12f0f58b9..a684a366775 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -49,10 +49,73 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static void mem_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    memory_region_ref(section->mr);
+    mshv_set_phys_mem(mml, section, true);
+}
+
+static void mem_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    MshvMemoryListener *mml;
+    mml = container_of(listener, MshvMemoryListener, listener);
+    mshv_set_phys_mem(mml, section, false);
+    memory_region_unref(section->mr);
+}
+
+static MemoryListener mshv_memory_listener = {
+    .name = "mshv",
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+    .region_add = mem_region_add,
+    .region_del = mem_region_del,
+};
+
+static MemoryListener mshv_io_listener = {
+    .name = "mshv", .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
+    /* MSHV does not support PIO eventfd */
+};
+
+static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
+                                          AddressSpace *as, int as_id,
+                                          const char *name)
+{
+    int i;
+
+    mml->listener = mshv_memory_listener;
+    mml->listener.name = name;
+    memory_listener_register(&mml->listener, as);
+    for (i = 0; i < s->nr_as; ++i) {
+        if (!s->as[i].as) {
+            s->as[i].as = as;
+            s->as[i].ml = mml;
+            break;
+        }
+    }
+}
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
-    error_report("unimplemented");
-    abort();
+    MshvState *s;
+    s = MSHV_STATE(as);
+
+    accel_blocker_init();
+
+    s->vm = 0;
+
+    s->nr_as = 1;
+    s->as = g_new0(MshvAddressSpace, s->nr_as);
+
+    mshv_state = s;
+
+    register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
+                                  0, "mshv-memory");
+    memory_listener_register(&mshv_io_listener, &address_space_io);
+
+    return 0;
 }
 
 static void mshv_start_vcpu_thread(CPUState *cpu)
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index 4c03ac79219..8a6beb3fb1e 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,5 +1,6 @@
 mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
+  'mem.c',
   'mshv-all.c'
 ))
 
-- 
2.51.0


