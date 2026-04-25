Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF26FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGfIp-00087u-27; Sat, 25 Apr 2026 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIV-00080f-HF
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:52:00 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGfIS-00011v-Dk
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:51:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C0CC44546;
 Sat, 25 Apr 2026 15:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994FCC2BCB4;
 Sat, 25 Apr 2026 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777132306;
 bh=+2xH9pwJPCdtwpTyFDhcK3JSDm0xqxczPOzOhfXaGgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SRoodeA+XUYyfovZ6hASkvryNQs4/Xt04eNVLStGRhp+Jw17EmaWPLkHz5fzBMnEE
 +/YWe975s9whIWQOZ9SXlhglsFNrc+xPJyt4uwu68e1kEFKldw54Ttm3huMsH8Ha0r
 P1y0LzORHIQsrky+Rixn6BE/Gqb3YGDQ9ZTKYEna9vy7CEv8PEyvhUb6iVCkpHQiGv
 2xF8aIaImQcv1Q+87N+RIgk0LHtmFYYmMDY5CwrTkiPS4HgAD0sURZLL3kwQExNKOq
 Fomn4Na5EnM8DJLfChu0BsNxTl7M5wqkRn4NZjmwZUqzdHo+PZ+Kyad+6JkfzxK4cO
 6fKcSBa03xM1Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] MAINTAINERS: Add myself as maintainer for linux-user
Date: Sat, 25 Apr 2026 17:51:27 +0200
Message-ID: <20260425155140.50186-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425155140.50186-1-deller@kernel.org>
References: <20260425155140.50186-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..e0f707a1ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4075,6 +4075,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
+M: Helge Deller <deller@gmx.de>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Odd Fixes
 F: linux-user/
-- 
2.53.0


