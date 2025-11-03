Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B092CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFq8u-0007sA-J0; Mon, 03 Nov 2025 03:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vFq8s-0007qw-5f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vFq8m-0000GH-Qc
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762159329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUUj32D6oHJKOccpTTerhOc8zicP0RzdsJEYLIl05DE=;
 b=HccOe4JOJHT/yZVzqf9V4lk9/A6KWm7bwmdW4petCyh94t1MvHRHZT/2aE9jI35g62hajq
 CswbnML+qneT9RR28qld4NqvkJawJUWzxNsZdNBfeZCEz1+EVLa6Keu6GUz7P+ly5AZ7we
 nNMaPzGTQTceMwh7p3i/mD3Tq10ThhM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-risOyHrWO0y7Wnf513jJcw-1; Mon,
 03 Nov 2025 03:42:05 -0500
X-MC-Unique: risOyHrWO0y7Wnf513jJcw-1
X-Mimecast-MFC-AGG-ID: risOyHrWO0y7Wnf513jJcw_1762159324
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9696A1955F45; Mon,  3 Nov 2025 08:42:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C93201956056; Mon,  3 Nov 2025 08:42:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 810B71800606; Mon, 03 Nov 2025 09:42:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 1/5] igvm: move igvm.h file to include/system
Date: Mon,  3 Nov 2025 09:41:56 +0100
Message-ID: <20251103084201.45417-2-kraxel@redhat.com>
In-Reply-To: <20251103084201.45417-1-kraxel@redhat.com>
References: <20251103084201.45417-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Prepare for arch-specific igvm code being added to the code base.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20251029105555.2492276-2-kraxel@redhat.com>
---
 {backends => include/system}/igvm.h | 0
 backends/igvm-cfg.c                 | 2 +-
 backends/igvm.c                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {backends => include/system}/igvm.h (100%)

diff --git a/backends/igvm.h b/include/system/igvm.h
similarity index 100%
rename from backends/igvm.h
rename to include/system/igvm.h
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 45df63e06c1a..d00acf351249 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm-cfg.h"
-#include "igvm.h"
+#include "system/igvm.h"
 #include "qom/object_interfaces.h"
 
 static char *get_igvm(Object *obj, Error **errp)
diff --git a/backends/igvm.c b/backends/igvm.c
index 9ad41582ee5e..723d45b755a0 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 
-#include "igvm.h"
 #include "qapi/error.h"
+#include "system/igvm.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-- 
2.51.1


