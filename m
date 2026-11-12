Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3aAeml/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUuG-0006A8-AQ; Thu, 12 Nov 2026 08:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu8-00068H-Ec
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu6-0003cc-E3
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT09c+TWZhPFeZtcufZcDwy4EHSqlKyQOrZITUkpO4k=;
 b=O3aAeml/mEKtsBCcytaRPneCqMDVzpXhcnQXFCo/htempKEPhg/hHX6gJdZxp7RqWrxEfg
 GtakaSdIufYz6nQrzEBBHOHejD545T7xYknVjSd0o00iKU6s6HbP1/LmtvwVNqzfAqyxOm
 Y0p2Qx3DSNr9ZjAQnXi/PHGw5g9kwsE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-6cxZrXykM3-nDvKUV4W-mg-1; Thu,
 12 Nov 2026 08:31:46 -0500
X-MC-Unique: 6cxZrXykM3-nDvKUV4W-mg-1
X-Mimecast-MFC-AGG-ID: 6cxZrXykM3-nDvKUV4W-mg_1794490305
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5286318004F6; Thu, 12 Nov 2026 13:31:45 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D862E1956087; Thu, 12 Nov 2026 13:31:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 26/48] hw/m68k: rename the 'virt' machine to 'm68k-virt'
Date: Thu, 12 Nov 2026 13:30:32 +0000
Message-ID: <20261112133054.1977618-27-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This introduces a globally unique QOM typename 'm68k-virt' for
the virt machine type.

An alias is added to resolve existing convenience name 'virt'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/m68k/virt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 487d9bcc8d0..398293144c8 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -324,7 +324,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo virt_machine_info = {
-    .name         = MACHINE_TYPE_NAME("virt"),
+    .name         = MACHINE_TYPE_NAME("m68k-virt"),
     .parent       = TYPE_MACHINE,
     .abstract     = true,
     .class_init   = virt_machine_class_init,
@@ -351,8 +351,8 @@ type_init(virt_machine_register_types)
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
-        .parent = MACHINE_TYPE_NAME("virt"), \
+        .name = MACHINE_VER_TYPE_NAME("m68k-virt", __VA_ARGS__), \
+        .parent = MACHINE_TYPE_NAME("m68k-virt"), \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
         .is_available = target_m68k, \
     }; \
@@ -368,6 +368,17 @@ type_init(virt_machine_register_types)
     static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
     { \
         MACHINE_TYPE_NAME("virt"), \
+        MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        MACHINE_TYPE_NAME("m68k-virt"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
+#define DEFINE_VIRT_MACHINE_ALIASES(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         NULL, \
     }; \
     alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
@@ -377,7 +388,9 @@ type_init(virt_machine_register_types)
             DEFINE_VIRT_MACHINE_ALIASES_LATEST(major, minor); \
         }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
+    DEFINE_VIRT_MACHINE_IMPL({ \
+            DEFINE_VIRT_MACHINE_ALIASES(major, minor); \
+        }, major, minor)
 
 static void virt_machine_11_2_options(MachineClass *mc)
 {
-- 
2.56.1


