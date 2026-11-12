Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F2606A8AB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPr37mug
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvz-0000GF-24; Thu, 12 Nov 2026 08:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuh-0006kA-2z
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuf-0005r7-By
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpsoC5cSBSSNI0TiVzfvGo9ynHkUwvaybK6Dmv5cCeE=;
 b=XPr37mugTdywc5KDk8aT1akaplV0Vccb7qj2WeSpSBIwL4SWbnPk5ZL61I3SV0qZY1KCdh
 4BLVnOlrg8FxL8qnI6OvrYNMa7H/YczZPmZoc0fc4ALE7W0+XPucutwY91GPNsfAE9Q8AT
 O2UnZUjdqXcxqcNt5fPEnzphECWkMbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-x_ku6x8bMwKT-MlmV9S37w-1; Thu,
 12 Nov 2026 08:32:15 -0500
X-MC-Unique: x_ku6x8bMwKT-MlmV9S37w-1
X-Mimecast-MFC-AGG-ID: x_ku6x8bMwKT-MlmV9S37w_1794490334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB9218005B8; Thu, 12 Nov 2026 13:32:14 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D9F51956087; Thu, 12 Nov 2026 13:32:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 42/48] Revert "multi-target: restrict whpx-accel-*-cpu to
 matching target"
Date: Thu, 12 Nov 2026 13:30:48 +0000
Message-ID: <20261112133054.1977618-43-berrange@redhat.com>
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

This reverts commit 1b879fe489f8894c5b07438f0b10706db916ca4f.

The conditional registration is no longer required since the
base class is now using a target independent name.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/whpx/whpx-common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 20c684638b0..78d2827809b 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -20,7 +20,6 @@
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "qemu/error-report.h"
-#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-type-infos-common.h"
@@ -493,18 +492,11 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
     acc->cpu_instance_init = whpx_cpu_instance_init;
 }
 
-/* TYPE_ACCEL_CPU is only registered for current target cpu type */
-static bool whpx_cpu_accel_is_available(void)
-{
-    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
-}
-
 static const TypeInfo whpx_cpu_accel_type = {
     .name = ACCEL_CPU_NAME("whpx"),
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = whpx_cpu_accel_class_init,
-    .is_available = whpx_cpu_accel_is_available,
     .abstract = true,
 };
 
-- 
2.56.1


