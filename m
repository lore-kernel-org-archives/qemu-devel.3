Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A684606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFbgUrWb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWbL-0004Ci-SY; Wed, 21 Oct 2026 09:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJWbJ-0004Aa-Iy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:43:29 -0400
Received: from out-123.mta1.migadu.com ([2001:41d0:203:375::7b]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJWbH-0006nL-3t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:43:29 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=Fi4BNJYMdbjLdv/SNYLVVVzqaRaqc5624TRAWZaYcdo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792590202; v=1; x=1793195002;
 b=nFbgUrWbyIKRRtNBc38/0PaQ7R5YFdqpbMx83gBHrzs8s2TslcSIZ5NTGb8YoKk2e31yhS8z
 DRW+xGmpL/urolNm3bSHgPNiXILmGbfcHUtIXZTUQEs8HE1bpuo7JKGxwm48G4NoMwMiHXbfJ2y
 wLXZkuDsIIQJGRQsIqYqlE00=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id ed41e90ce60f5e09;
 Wed, 21 Oct 2026 13:43:22 +0000
X-Mizu-Trace-ID: ed41e90ce60f5e09
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, mst@redhat.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, junjie.cao@linux.dev, junjie.cao@intel.com
Subject: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Date: Wed, 21 Oct 2026 13:43:07 +0000
Message-ID: <20261021134307.874867-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::7b;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update my email address to junjie.cao@linux.dev for future correspondence.
I'll continue contributing and reviewing CXL patches.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f..2b78316436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3370,7 +3370,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
-R: Junjie Cao <junjie.cao@intel.com>
+R: Junjie Cao <junjie.cao@linux.dev>
 R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
-- 
2.43.0


