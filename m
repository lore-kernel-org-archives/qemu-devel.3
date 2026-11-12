Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB106606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QdjzFXao
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvB-000705-Dd; Thu, 12 Nov 2026 08:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu7-000687-BC
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu5-0003Yb-MY
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ndKNZdoR/58rfLya+g8Y1PrRMIUmuGezmsfRor59vo=;
 b=QdjzFXaoIsnKBbNfeu3PfJv7cjbeZa/1OsZCJezinFrSvoYHWE/QT/w+nBhv5XemQgk+0G
 qsk/PoV0/oftpYROtWAfcBnDJiIvh7RCcQZ8yxaHirCOdoCrqS9BPh2DB7+QfGlURBECXZ
 F2sLUHrxQ0o00cEXGUcZ/rvsEHP06DY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Ro3fv1g7PuWNbdZ88ZuVpA-1; Thu,
 12 Nov 2026 08:31:44 -0500
X-MC-Unique: Ro3fv1g7PuWNbdZ88ZuVpA-1
X-Mimecast-MFC-AGG-ID: Ro3fv1g7PuWNbdZ88ZuVpA_1794490303
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8815E1801204; Thu, 12 Nov 2026 13:31:43 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A6831956087; Thu, 12 Nov 2026 13:31:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 25/48] hw/loongarch: rename the 'virt' machine to
 'loongarch-virt'
Date: Thu, 12 Nov 2026 13:30:31 +0000
Message-ID: <20261112133054.1977618-26-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This introduces a globally unique QOM typename 'loongarch-virt' for
the virt machine type.

An alias is added to resolve existing convenience name 'virt'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/loongarch/virt.c         | 17 +++++++++++++++--
 include/hw/loongarch/virt.h |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 52b40883f4e..a1ecc815a13 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1535,7 +1535,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .name = MACHINE_VER_TYPE_NAME("loongarch-virt", __VA_ARGS__), \
         .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
         .secure = true, \
@@ -1552,6 +1552,17 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
     { \
         MACHINE_TYPE_NAME("virt"), \
+        MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        MACHINE_TYPE_NAME("m68k-virt"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
+#define DEFINE_VIRT_MACHINE_ALIASES(...)   \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         NULL, \
     }; \
     alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
@@ -1562,7 +1573,9 @@ static void virt_class_init(ObjectClass *oc, const void *data)
             mc->is_default = true; \
         }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_VERSION({}, major, minor)
+    DEFINE_VIRT_MACHINE_VERSION({ \
+            DEFINE_VIRT_MACHINE_ALIASES(major, minor); \
+        }, major, minor)
 
 static void virt_instance_finalize(Object *obj)
 {
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5dd..09529de48bd 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -130,7 +130,7 @@ struct LoongArchVirtMachineState {
     bool highmem_mmio;
 };
 
-#define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
+#define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("loongarch-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
-- 
2.56.1


