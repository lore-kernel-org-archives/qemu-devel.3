Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC59D31A25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwOZ-0003HD-V8; Wed, 14 Jan 2026 03:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwOY-0003Fy-3B
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfwOW-0001NH-7Y
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768379902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9jQKbJQSPFI1S1JTg6Lu+7DklgAMBCQog/vTaZtMUMI=;
 b=IUh7hSkIL54eN8hnRxt+VhEK1gZK/4f2dYSacOR370SruyLfM3KGuIw7WbYvGrWetnx110
 FpYyn1XgqVnzddBiM+xEIvhf+zzZzJ3+d5po36/cggbDy7pyLxVJcUJRPzDBiZnCpCbdOJ
 e0YFLzwDt7KgkgXcbfFJCar4Pzee72U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-sN5q1uHLN-mu5gKHdh2NDg-1; Wed,
 14 Jan 2026 03:38:19 -0500
X-MC-Unique: sN5q1uHLN-mu5gKHdh2NDg-1
X-Mimecast-MFC-AGG-ID: sN5q1uHLN-mu5gKHdh2NDg_1768379898
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E5B180057E; Wed, 14 Jan 2026 08:38:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E3BC180049F; Wed, 14 Jan 2026 08:38:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Reinoud Zandijk <reinoud@netbsd.org>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/i386/nvmm: Include missing ramlist.h header
Date: Wed, 14 Jan 2026 09:38:12 +0100
Message-ID: <20260114083812.18496-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Compiling on NetBSD currently fails with:

 ../src/target/i386/nvmm/nvmm-all.c:1136:22: error: unknown type name 'RAMBlockNotifier'
  1136 | nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
       |                      ^~~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1152:15: error: variable 'nvmm_ram_notifier' has initializer but incomplete type
  1152 | static struct RAMBlockNotifier nvmm_ram_notifier = {
       |               ^~~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1153:6: error: 'struct RAMBlockNotifier' has no member named 'ram_block_added'
  1153 |     .ram_block_added = nvmm_ram_block_added
       |      ^~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1153:24: error: 'nvmm_ram_block_added' undeclared here (not in a function)
  1153 |     .ram_block_added = nvmm_ram_block_added
       |                        ^~~~~~~~~~~~~~~~~~~~

Include the right header to get this fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/nvmm/nvmm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f808828d492..8a1af35ed32 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -16,6 +16,7 @@
 #include "system/nvmm.h"
 #include "system/cpus.h"
 #include "system/memory.h"
+#include "system/ramlist.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-- 
2.52.0


