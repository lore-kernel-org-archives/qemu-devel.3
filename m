Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9A606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SSoLRPxf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35O-0005tq-Kd; Sat, 31 Oct 2026 03:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN346-0003G5-4V
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN341-0002wH-GD
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNHD2eGcixtNtNS35S27j2vYhuQkWiDiF3bLghF5ZaA=;
 b=SSoLRPxfAYGRDThRJ9fs2onECKKTTqXe+tfHwl9EMb4gORq8W/Vz7Z+e8YFq9qWiCs6O6f
 J3vPCT1n52kdQ1bcffxabibgu+jRHYVn98XCqsuNtpzwUDcKnEnwkFCGYtR7+igcjxCdkr
 mVr52GhhN2cMSwEeJAn1OyIRy2OcOP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-uwtguAAlOVyM2e3PuDkwYg-1; Sat,
 31 Oct 2026 02:59:36 -0400
X-MC-Unique: uwtguAAlOVyM2e3PuDkwYg-1
X-Mimecast-MFC-AGG-ID: uwtguAAlOVyM2e3PuDkwYg_1793429975
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EADD195604B; Sat, 31 Oct 2026 06:59:35 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC77E1800677; Sat, 31 Oct 2026 06:59:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/34] hw/rtc: ds1338: move TYPE_DS1338 to a public header
Date: Sat, 31 Oct 2026 07:58:19 +0100
Message-ID: <20261031065823.191966-31-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Emmanuel Blot <emmanuel.blot@free.fr>

Move the TYPE_DS1338 type name definition from ds1338.c into a new
include/hw/rtc/ds1338.h header so that boards instantiating the device
no longer need to redefine the type name string locally.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20261015-bmc-minerva-v3-8-7d50c8a108e5@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/rtc/ds1338.h | 20 ++++++++++++++++++++
 hw/rtc/ds1338.c         |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/rtc/ds1338.h

diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
new file mode 100644
index 000000000000..f4cfe6a8e762
--- /dev/null
+++ b/include/hw/rtc/ds1338.h
@@ -0,0 +1,20 @@
+/*
+ * MAXIM DS1338 I2C RTC+NVRAM
+ *
+ * Copyright (c) 2009 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_DS1338_H
+#define HW_RTC_DS1338_H
+
+#define TYPE_DS1338 "ds1338"
+
+#endif
diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 5f1ee2e410af..f8b3340bf0f5 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
@@ -29,7 +30,6 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-#define TYPE_DS1338 "ds1338"
 OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
 
 struct DS1338State {
-- 
2.56.0


