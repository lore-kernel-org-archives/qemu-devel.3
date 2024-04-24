Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A03BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXcH-0007Tw-6G; Wed, 24 Apr 2024 04:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbX-0005sz-5k
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbS-0003nr-Cf
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7D2l0FiXqQQp9G8HcqOTgsx2MASPc7wgA4hDZssWzU=;
 b=GSTzvV4wJ1b94XyA7QbLGfoWQCI1V2lkA3P0rV9cEd6X5mL7upelYVoWOTAuwS3IRoFc6V
 OR7ypiopC5nBIoM3GjLesPl8KLrsSUSLleCEnQACxNfSs7hlMrJTkAVMkBycaJ4kVTXcFQ
 VNNfq74SHW6AS5nY9mtyODJtE4lkhxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-hHttqdBqOF23y8Vn7bWasQ-1; Wed, 24 Apr 2024 04:03:38 -0400
X-MC-Unique: hHttqdBqOF23y8Vn7bWasQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35C86834FB4;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 171C6492BC7;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3816021E668A; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 01/10] error: Drop superfluous #include "qapi/qmp/qerror.h"
Date: Wed, 24 Apr 2024 10:03:28 +0200
Message-ID: <20240424080337.2782594-2-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-2-armbru@redhat.com>
---
 backends/iommufd.c | 1 -
 chardev/char-fe.c  | 1 -
 system/rtc.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 62a79fa6b0..76a0204852 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/iommufd.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 66cee8475a..b214ba3802 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 
 #include "chardev/char-fe.h"
diff --git a/system/rtc.c b/system/rtc.c
index 4904581abe..dc44576686 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
-- 
2.44.0


