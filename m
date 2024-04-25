Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57307C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzxOh-0008K8-4E; Thu, 25 Apr 2024 07:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1rzxOa-0008IP-4u
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:36:08 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1rzxOV-0007Cb-TA
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:36:07 -0400
DKIM-Signature: a=rsa-sha256; bh=674wQu7kecJmjQgSd6i5qwu7S6xNbo+I3MXVZwQYWEc=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1714044444; v=1;
 b=oY57TVXJ5PJsztId8MkfVEAtJaJRUnpLWWj6+HFmalVPL2dFF7ld92zDLneyiCQx8cRUyAqb
 uauLx1zyOhNmPSHkTGk3sDhh//m5KaB6wTI5ozjvpjaZgStyNnZIvzIBFRakFLZAStfYIVcqFH5
 JrpFXPc/ufmBSUdu+ZdO3zs6fJvF8JW5BXtxNeHzATI+IPTVjxP6SnIfOGyZemXK5aLqM9BfxoF
 D99v37akTt2jnqVDpWbjoiVU/vHAZtCNuefRyH0cmcUdwnvTEpohXPkVTzAgoDi/tZfGt9toYZI
 mh7/xgj3RRA2bmTeA3Y7lVBJSFB8VpgI+7Cm+kogBtWUA==
Received: from git.sr.ht (unknown [IPv6:2a03:6000:1813:1337::155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 27DBD20412
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 11:27:24 +0000 (UTC)
From: ~norwayfun <norwayfun@git.sr.ht>
Date: Thu, 25 Apr 2024 13:17:56 +0200
Subject: [PATCH qemu1 1/2] po: Add Georgian translation
Message-ID: <171404444411.4173.15963098780730496317-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~norwayfun <temuri.doghonadze@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: norwayfun <temuri.doghonadze@gmail.com>

---
 po/LINGUAS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/po/LINGUAS b/po/LINGUAS
index 9b33a3659f..f3a9b1a802 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -3,6 +3,7 @@ de_DE
 fr_FR
 hu
 it
+ka
 sv
 tr
 uk
-- 
2.43.0


