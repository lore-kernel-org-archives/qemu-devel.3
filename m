Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F416BFC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvmK-0004MD-Nu; Thu, 23 Apr 2026 11:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wFvmI-0004Lu-DI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:15:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wFvmG-0006r9-EF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:15:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D25E40D88;
 Thu, 23 Apr 2026 15:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6AC2BCAF;
 Thu, 23 Apr 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776957331;
 bh=kljJ0OvtxjoFvq41mznQaoSxpGFa9XTfRKyU8sX3B6s=;
 h=From:To:Cc:Subject:Date:From;
 b=YrYMeeS+/exbLuiVxWGxPqZRQ+BnPxZGEhwXW1YhxO7x0m9FUrDDTnvH8OWhkQitt
 zmVTY/3+xA62bKvIfGrDxDSmdSkaDcra0Xcq975v4hjij2m5sWSrfmWXOdMrHVdGjN
 tyRBqQ5M48RVs3JHZauoq8HND7G1xB3GUpZLxZTlVZODBbeVR4OzGqDR+HJt8Vbpn/
 gmqZiMWUtRY1Sictq2Ub104VKi3rAqVVLfqSwPCMC0nleQB1/2OCuBYsh73QrtpFOR
 Z2ZFIkuHsVCDmDsB8b/eKFwDwsDIWNLz9YpA8q0Pw3pLhpytleVjjVodmTS58fyrWL
 IaSmIMEG+yq1w==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
Date: Thu, 23 Apr 2026 17:15:21 +0200
Message-ID: <20260423151521.3969-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

I'd like to step up as maintainer for linux-user. I'm actively using
linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
buildd servers, so I'm very much interested that linux-user is running
good and stable.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..4736f5ad74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4074,6 +4074,7 @@ F: tests/vm/*bsd
 T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
+M: Helge Deller <deller@gmx.de>
 M: Laurent Vivier <laurent@vivier.eu>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Odd Fixes
-- 
2.53.0


