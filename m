Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C2D1356A
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 21:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5AaB-0005MX-4A; Sun, 27 Oct 2024 17:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t5Aa9-0005M7-Lx; Sun, 27 Oct 2024 17:13:53 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1t5Aa7-0007Uf-Jr; Sun, 27 Oct 2024 17:13:53 -0400
DKIM-Signature: a=rsa-sha256; bh=HNFsFgrZB0dYwNmxD6h6ZQLXnIKWFN9zCr7O6VELjfk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1730063627; v=1;
 b=UlKvBJLSBekw3v4pgPRmwuLc3OEmOQdMQ/zT37sCw2rWzhfnvR3IQ8vsqq1JjxVbpujldA9r
 W4+DLWKCLC2vDOUphnoevWONNmQ/PfLYTwun1E1zXiI1VJpe5VSWNl6hSUWxyYXqz5X1p6ZTQPC
 Qr52Rvb7mnWe6b70Wk4MdFL3oBSKdDqBIOxfLt+5IUAy9cXUMqIY7yhm1aKID4NtNZ4yEBhXFCj
 CtYC7TU+yPQ1ZljY07aDjzjom+eeUvMpEUHg87BK+x00EY9Kr2CiaWm1efJEB2tkyfAnyKoyT8w
 fm5uptUb025tTlJNddMIfLqiUQqFYjSkEWLhpnw4M3GPA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id A426C202BB;
 Sun, 27 Oct 2024 21:13:47 +0000 (UTC)
From: ~axelheider <axelheider@git.sr.ht>
Date: Sun, 27 Oct 2024 21:13:47 +0000
Subject: [PATCH qemu.git v2 0/2] docs/devel/reset: add missing words
MIME-Version: 1.0
Message-ID: <173006362760.28451.11319467059840843945-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~axelheider <axelheider@gmx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1:
- Add missing words in documentation

v2:
-  add plural 's'

Axel Heider (2):
  docs/devel/reset: add missing words
  docs/devel/reset: add plural 's'

 docs/devel/reset.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2

