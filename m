Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7121606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdrAKiLD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUuI-0006As-B4; Thu, 12 Nov 2026 08:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu9-00068h-Rm
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUu8-0003fk-Am
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X5UKViNf109ebwxdMV78qUKbqTcab+6B/ILPHjvM8E=;
 b=bdrAKiLDMmTcwP3pGuRSHInUepDA9YxAbUp9kusbqL20k278DMo6/Z3/c7sK7N38tOtomd
 mJvztzOXt9xlS4dn1LlWNb/v0BoVLTqZQ4OI1M4vD+FPpRakDm+9P2uRaJMV4F3xr/W/t0
 ZTBEN3PHpeW5eRbHmjzBzwm5LuP9vqw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635--1y-11bNOEyHFd8np-aFDQ-1; Thu,
 12 Nov 2026 08:31:48 -0500
X-MC-Unique: -1y-11bNOEyHFd8np-aFDQ-1
X-Mimecast-MFC-AGG-ID: -1y-11bNOEyHFd8np-aFDQ_1794490307
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37BAD18002FC; Thu, 12 Nov 2026 13:31:47 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A23D9195608D; Thu, 12 Nov 2026 13:31:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 27/48] hw/or1k: rename the 'virt' machine to 'or1k-virt'
Date: Thu, 12 Nov 2026 13:30:33 +0000
Message-ID: <20261112133054.1977618-28-berrange@redhat.com>
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

This introduces a globally unique QOM typename 'or1k-virt' for
the virt machine type.

An alias is added to resolve existing convenience name 'virt'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/or1k/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index a3ff903839b..579acdedfa6 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -28,13 +28,14 @@
 #include "system/system.h"
 #include "system/qtest.h"
 #include "system/reset.h"
+#include "qom/object_interfaces.h"
 
 #include <libfdt.h>
 
 #define VIRT_CPUS_MAX 4
 #define VIRT_CLK_MHZ 20000000
 
-#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("or1k-virt")
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
 
@@ -546,7 +547,12 @@ static void openrisc_virt_init(MachineState *machine)
 static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(oc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("virt"), NULL,
+    };
 
+    alc->aliases = aliases;
     mc->desc = "or1k virtual machine";
     mc->init = openrisc_virt_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-- 
2.56.1


