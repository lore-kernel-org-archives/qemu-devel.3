Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A37C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9Uv-0000QV-0Y; Thu, 06 Jun 2024 05:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF9Ut-0000Pz-Bl
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF9Ur-0006s6-Rc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717666405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QtmqXwvQtz9AetCc4aSYzY8LISUCeJ1ftIavHc81UjY=;
 b=RgEMLil9nUvMq+vFaQNeGNde0Rkhbz1v9L2ADbYWXv4v7V7bk6lAJQo5pP1Hl9L17UpodP
 GYjjHxR8fEQUimv19OpB6V4+ESYjAqMLXB+vaFcyP8zMgkNf+OK6IJixmU6qqVFYHoEJtT
 7YgHKhg3kuOEMX0eqyWCpUkPoJG4xDw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-bTHahT-ePzKZDidVQnI0WA-1; Thu, 06 Jun 2024 05:33:23 -0400
X-MC-Unique: bTHahT-ePzKZDidVQnI0WA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68e0faf0e6so37117466b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717666400; x=1718271200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtmqXwvQtz9AetCc4aSYzY8LISUCeJ1ftIavHc81UjY=;
 b=hJeQSU9WEMUk6sl2z8bmYwlk6/gxdd54uSGdo0VeOFrenvRyuDR+Ixj31FPOzJ/IqX
 WKzAqNWp6dlaDR3dzS/T138ctl+2ymIk9C0xEW9MZIJnmNhIbW0/uXGtSIu9ENoG0XvY
 ODXDgNmVmwzl0cWeyZBukaxlFsTmCaS0yy0pWiScIPn3ERxnEgYhHs108U3ZZzwwqmpk
 z50/hdzUChIdLQogldH/G0FzjeOpKE5jOyzwQCdKc4FoAX0YuV1nd0AaLicwSibYqN9O
 zPNaTSEKpKoCd4oGR7CdTloZUvfIu9EkIilHbmpO9qPmadG9dcwg44fsGBlNfASGMB+S
 O8GQ==
X-Gm-Message-State: AOJu0Yz2WTeMcwo4dV/MmrqyyctEyIAC9qrLOLHbTI0g/LxU6UWJdvDN
 3Uoa7ylHHps+vttu/dcjpV9JRHhTr0Qt3q1YO/Y9/uN/4J/Xj8GUrFqmw/KWw/3ckUSdViXO9Jo
 8TUkcW9plZcfPZ2+bDQOWdLovIb61OQkN5H6Wq59RDLC7MgWjbxVA3Ik2kviwfdH0J8VDff8o+Z
 iJ6uF/0C44e+XjF4P/ZEc4MXa9a8m8cYyf39lN
X-Received: by 2002:a17:906:5647:b0:a63:3c57:5806 with SMTP id
 a640c23a62f3a-a699fccb79dmr314612866b.32.1717666400711; 
 Thu, 06 Jun 2024 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3FO1K/1gPqv5Q3hLoQEHafs7DmuenX4vubjU2LijmwZJ+o19rohKqQ6A8wKl0HdpBcBzxyA==
X-Received: by 2002:a17:906:5647:b0:a63:3c57:5806 with SMTP id
 a640c23a62f3a-a699fccb79dmr314610366b.32.1717666400125; 
 Thu, 06 Jun 2024 02:33:20 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581f08sm70705266b.44.2024.06.06.02.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:33:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH] machine,
 hostmem: improve error messages for unsupported features
Date: Thu,  6 Jun 2024 11:33:17 +0200
Message-ID: <20240606093317.2468231-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Detect early unsupported MADV_MERGEABLE and MADV_DONTDUMP, and print a clearer
error message that points to the deficiency of the host.

Cc: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c | 16 ++++++++++++++++
 hw/core/machine.c  |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4d6c69fe4de..584ee160f9c 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -170,6 +170,14 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
+    if (QEMU_MADV_MERGEABLE == QEMU_MADV_INVALID) {
+        if (value) {
+            error_setg(errp, "Memory merging is not supported on this host\n");
+        }
+        assert(!backend->merge);
+        return;
+    }
+
     if (!host_memory_backend_mr_inited(backend)) {
         backend->merge = value;
         return;
@@ -202,6 +210,14 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
+    if (QEMU_MADV_DONTDUMP == QEMU_MADV_INVALID) {
+        if (!value) {
+            error_setg(errp, "Dumping guest memory cannot be disabled on this host\n");
+        }
+        assert(backend->dump);
+        return;
+    }
+
     if (!host_memory_backend_mr_inited(backend)) {
         backend->dump = value;
         return;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c31a672051c..2ac1250f575 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -17,6 +17,7 @@
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qemu/madvise.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
@@ -427,6 +428,10 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
+    if (!value && QEMU_MADV_DONTDUMP == QEMU_MADV_INVALID) {
+        error_setg(errp, "Dumping guest memory cannot be disabled on this host\n");
+        return;
+    }
     ms->dump_guest_core = value;
 }
 
@@ -441,6 +446,10 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
+    if (value && QEMU_MADV_MERGEABLE == QEMU_MADV_INVALID) {
+        error_setg(errp, "Memory merging is not supported on this host\n");
+        return;
+    }
     ms->mem_merge = value;
 }
 
-- 
2.45.1


