Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BA7E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqUq-0007j5-Pa; Tue, 24 Feb 2026 06:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1vuqUq-0007iw-55
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:22:32 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1vuqUo-0003Ho-LL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From; bh=Z/WEq8n0U84heIIePjYpbKXiXE+eAfzjOG2ZP9AjAQ8=; b=LxDte9
 AmVwnxHifqo1HWZumJFDsho3HOe/q7qZyYj0HHiL/RZADHF+JTkJIEQUgQwSCzsFTEjR9H6mhAC8Q
 dkY5+/SOgRDHW5b3XTnYWwgVjR7nM/LzSoyZtkJwIQjYINyOy9zwdMGgzPpLp59cNDbVbPjb/aI/A
 iYlDXU9hJPI=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <paul@xen.org>) id 1vuqUk-007oPx-35;
 Tue, 24 Feb 2026 11:22:26 +0000
Received: from [15.248.2.232] (helo=7cf34dd8cfa1.ant.amazon.com)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (Exim 4.96)
 (envelope-from <paul@xen.org>) id 1vuqUk-004AlT-27;
 Tue, 24 Feb 2026 11:22:26 +0000
From: Paul Durrant <paul@xen.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Paul Durrant <pdurrant@amazon.com>
Subject: [PATCH] MAINTAINERS: remove myself as a Xen maintainer
Date: Tue, 24 Feb 2026 11:21:36 +0000
Message-ID: <20260224112215.83355-1-paul@xen.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=paul@xen.org;
 helo=mail.xenproject.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paul Durrant <pdurrant@amazon.com>

I am no longer actively involved in the Xen Project.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71ff..ef805c8ef7a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -603,7 +603,6 @@ Guest CPU Cores (Xen)
 X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony PERARD <anthony@xenproject.org>
-M: Paul Durrant <paul@xen.org>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
-- 
2.50.1 (Apple Git-155)


