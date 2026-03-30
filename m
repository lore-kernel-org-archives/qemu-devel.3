Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC0B10D14A5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B0F-0005MZ-78; Mon, 30 Mar 2026 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axw-0003ul-Tc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axv-0003bU-K7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774870770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xw56F0rtktmpTY6+GvDgBlLp89XVj2CAus1OJMVrEo8=;
 b=NlSuwXtj0SQbHWvIldcib6xTFKbo19kG9vyam6FgeKKK+to7de1XAOSO8AA3zULLgq9ytv
 p9eaPkoEpJcge5cXrUXsKVZHMmY65EpnN4TTHq4M8vKu5pvXwQ5loOe5BWYCLwLIfgLKw7
 yYup5UZhCHiBlhHSWF+ttp9AtUa5vH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Btnh3ynwP92gmi-Vnwl0cQ-1; Mon,
 30 Mar 2026 07:39:27 -0400
X-MC-Unique: Btnh3ynwP92gmi-Vnwl0cQ-1
X-Mimecast-MFC-AGG-ID: Btnh3ynwP92gmi-Vnwl0cQ_1774870766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62EB5195609E; Mon, 30 Mar 2026 11:39:26 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD7E4180075B; Mon, 30 Mar 2026 11:39:24 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 7/7] qga/vss: Drop unused define uuid(x)
Date: Mon, 30 Mar 2026 14:39:06 +0300
Message-ID: <20260330113906.168002-8-kkostiuk@redhat.com>
In-Reply-To: <20260330113906.168002-1-kkostiuk@redhat.com>
References: <20260330113906.168002-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is no place in code where we use uuid(x), at the same time
MSVC vss.h use it and this define broke compilation.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/vss-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index db849127c2..5e993f9eda 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -30,8 +30,6 @@
 #define __RPC__out_ecount_part(x, y)
 #endif
 #define _declspec(x)
-#undef uuid
-#define uuid(x)
 
 #include <vss.h>
 #include "vss-handles.h"
-- 
2.52.0


