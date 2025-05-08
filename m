Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFD6C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1m5-0003Q1-DA; Thu, 08 May 2025 09:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lz-00032y-0V
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lx-0007AL-4F
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGZx8rKraXWdEA7Mun1digKtiSsyz+m5f2cDVaTrb2A=;
 b=hPb7zc8qb/4n/FECoSYWRoFnNylpHmJdgywTkFqGPCK7q7XqYkzbDc0kri0RQP8DHukHOJ
 tpsHU81j73PDOXqpxRwR41xUIvS2JFNiExlDqL7phLLfBmHBisxZfiTboH+dZJWn2/KrzF
 aOJalWzQm1NhCHmYj/eS8SpTcPW4Q/s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-v7RsBSoVOCK3Z0ZWBDKmZg-1; Thu,
 08 May 2025 09:58:47 -0400
X-MC-Unique: v7RsBSoVOCK3Z0ZWBDKmZg-1
X-Mimecast-MFC-AGG-ID: v7RsBSoVOCK3Z0ZWBDKmZg_1746712726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07E11955D60; Thu,  8 May 2025 13:58:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAFFE180049D; Thu,  8 May 2025 13:58:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/10] qapi: remove the misc-target.json file
Date: Thu,  8 May 2025 14:58:13 +0100
Message-ID: <20250508135816.673087-8-berrange@redhat.com>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This file is now empty and can thus be removed.

Observe the pre-existing bug with s390-skeys.c and target/i386/monitor.c
both including qapi-commands-misc-target.h despite not requiring it.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/s390x/s390-skeys.c | 1 -
 qapi/meson.build      | 1 -
 qapi/qapi-schema.json | 1 -
 target/i386/monitor.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index aedb62b2d3..8eeecfd58f 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -17,7 +17,6 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "system/memory_mapping.h"
diff --git a/qapi/meson.build b/qapi/meson.build
index 5e93e6b8cf..ffe44f9e0b 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -42,7 +42,6 @@ qapi_all_modules = [
   'machine-target',
   'migration',
   'misc',
-  'misc-target',
   'net',
   'pragma',
   'qom',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index e96bff8d38..d8eb79cfda 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -63,7 +63,6 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-arm.json' }
 { 'include': 'misc-i386.json' }
-{ 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
 { 'include': 'pci.json' }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3ea92b066e..3c9b6ca62f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -29,7 +29,6 @@
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
 /* Perform linear address sign extension */
-- 
2.49.0


