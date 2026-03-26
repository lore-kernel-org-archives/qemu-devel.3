Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D0A10A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n9G-0004IV-AD; Thu, 26 Mar 2026 12:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8z-00047j-Tr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8r-0001i9-KB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXStUMxV9krAQRh3IjJWc/g7Z0w64j5Zbb+7kf8Rcv4=;
 b=UZbwMUpzSn3cdT+1czJI4QR29cWuwPtivG+JtVW10ZPE5FyvjeH129PNLd5NaUsrYAdhJP
 8I7eKWF1/gJZFdxry6MF2ZYVoINxTyahNh6uLLizLwWcm0Xi5UIsGEOBUKaYY7hlDGRONp
 8/lQNJ8B1EKwFw5oYTX7O7qYG9Ja4/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-74YPuoLCNpGCCdJAu5v1-A-1; Thu,
 26 Mar 2026 12:00:53 -0400
X-MC-Unique: 74YPuoLCNpGCCdJAu5v1-A-1
X-Mimecast-MFC-AGG-ID: 74YPuoLCNpGCCdJAu5v1-A_1774540852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C78A219560BB; Thu, 26 Mar 2026 16:00:52 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 301453000223; Thu, 26 Mar 2026 16:00:49 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 4/7] Remove unused dirent.h
Date: Thu, 26 Mar 2026 18:00:30 +0200
Message-ID: <20260326160033.68318-5-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-1-kkostiuk@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 util/drm.c  | 1 -
 util/path.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/util/drm.c b/util/drm.c
index dae8ffebc8..afa9c400df 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -18,7 +18,6 @@
 #include "qemu/drm.h"
 
 #include <glob.h>
-#include <dirent.h>
 
 int qemu_drm_rendernode_open(const char *rendernode)
 {
diff --git a/util/path.c b/util/path.c
index 8e174eb436..72a255890e 100644
--- a/util/path.c
+++ b/util/path.c
@@ -5,7 +5,6 @@
 */
 #include "qemu/osdep.h"
 #include <sys/param.h>
-#include <dirent.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 #include "qemu/thread.h"
-- 
2.52.0


