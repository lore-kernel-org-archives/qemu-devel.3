Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E9606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fdpND/3h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUxw-0003kK-Ck; Thu, 12 Nov 2026 08:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuT-0006WF-5n
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuR-0005A2-Lj
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WpX9gUTs9zKinxRBubIpggvO6RcjccBXAJw3aHpEbEU=;
 b=fdpND/3hLB1ejR/RwqM5xUE0uh5t8v9oHhhFZGRdYMaxmvxtQn/z8Vj/y82NOXWmx43ykw
 oOPfcsE8AyiX7rg67inr0aJalaJvXxIutenxKFugF2rjRG6gu1QGFEz57vx2U4ZZJFXDvv
 5VHJNQ7dfWMdoIvuZ4ATC9upfEhbLnk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-5NYCtfJjOQ6nrRDwRh2VLA-1; Thu,
 12 Nov 2026 08:32:08 -0500
X-MC-Unique: 5NYCtfJjOQ6nrRDwRh2VLA-1
X-Mimecast-MFC-AGG-ID: 5NYCtfJjOQ6nrRDwRh2VLA_1794490327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7951818974F7; Thu, 12 Nov 2026 13:32:07 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D2D91956087; Thu, 12 Nov 2026 13:32:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 38/48] hw/m68k: declare m68k machine target
Date: Thu, 12 Nov 2026 13:30:44 +0000
Message-ID: <20261112133054.1977618-39-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This prevents creation of m68k machines unless the current selected
target is m68k and enables removal of the 'is_available' callback.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/m68k/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 398293144c8..b490d01efc9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -37,6 +37,7 @@
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/virtio/virtio-blk.h"
 #include "qom/object_interfaces.h"
+#include "qemu/base-arch-defs.h"
 
 /*
  * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
@@ -328,7 +329,6 @@ static const TypeInfo virt_machine_info = {
     .parent       = TYPE_MACHINE,
     .abstract     = true,
     .class_init   = virt_machine_class_init,
-    .is_available = target_m68k,
 };
 
 static void virt_machine_register_types(void)
@@ -344,8 +344,10 @@ type_init(virt_machine_register_types)
         const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
+        TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
+        tsc->targets = QEMU_ARCH_BIT(SYS_EMU_TARGET_M68K); \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         classinitextra \
     } \
@@ -354,7 +356,6 @@ type_init(virt_machine_register_types)
         .name = MACHINE_VER_TYPE_NAME("m68k-virt", __VA_ARGS__), \
         .parent = MACHINE_TYPE_NAME("m68k-virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .is_available = target_m68k, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.56.1


