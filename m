Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B59E674B2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXggb-0003sS-4c; Mon, 22 Dec 2025 09:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vXggX-0003s8-4m
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:14:53 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vXggV-0001tA-KJ
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:14:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 58D926001D;
 Mon, 22 Dec 2025 14:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB2C4CEF1;
 Mon, 22 Dec 2025 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766412881;
 bh=ez0MIsvnO4f18ev90qMVztcPfKvMktdgWTWkXCBd8gc=;
 h=From:To:Cc:Subject:Date:From;
 b=QscZBQ4qkgabZPsZZv1nGapS6Kk1762Zj78HU/uHlktIADf1Bs9iruYaGKCccaIcV
 Mv7NzRa5R1uQ6TGogH5AE2A2Ix3Se3bHwGG7XdvetZQ3p6qCgwRr0y6NZuQ0X1OfUK
 dqHY9jGPFYi1unhVjeRALopgtc+t50twagXf+B8kz1wXKW+k4K5vRXg+ymvBY7WsHx
 C2A0996qnQbYqlXVAANr97blPR7MOMqe1rkcYa1nTaIz3/uPNYMyzN2aCMIwGU7JXZ
 SvB9eKxJmYJnMGa4GGuu5h1PS4TK79mjgU4vArLZgNtI0VJLD7KudyQBb99sttjpK/
 1u3JPOI5OSqZA==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: qemu-devel@nongnu.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1] MAINTAINERS: remove David from "Memory API" section
Date: Mon, 22 Dec 2025 15:14:38 +0100
Message-ID: <20251222141438.409218-1-david@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I don't have a lot of capacity to do any maintanance (or even review) of
"Memory API" lately, so remove myself. Fortunately we still do have two
other maintainers and one reviewer :)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..c1ceea6b00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3249,7 +3249,6 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-M: David Hildenbrand <david@kernel.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
-- 
2.52.0


