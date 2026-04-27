Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD0FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5V-0000CW-0i; Mon, 27 Apr 2026 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5M-0000Bk-7x
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:44 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5H-0003T9-IU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E57F460139;
 Mon, 27 Apr 2026 21:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD34C2BCC6;
 Mon, 27 Apr 2026 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323698;
 bh=yYjMRoFt4jzIE4IARqI1Ple+n8OFUuRP8/w/Pzm2guw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fd4R3fKA+0DucIxQqghe5A4DYcHyfqz+Lxk/xMBwiUskYpOhM4pkkWII6BkdUgt8Z
 FenYdo3xaBa7WQz+BgkL9MM7dOGOiT+m5JGFlSJxWnr5OBPCFGULwu71ZzD0wBuqgF
 7LyuTdxx08Hei93vMK2GRr5nRWSlRPr3/xlwGFrQ7SOrVkJwOsR6mVokizzWRlbNSI
 DNAi00Aahy5y5P8kq6+o/+sTv39fmKw8WU1aWU6BPBST8Ft9pJ7Q+9Jx6aHZrelndV
 GovVxrQBV4YRPOsNV/tV1APQz+Tr7lgC96fdnMxoDE6AAM0z+AcPD8NaSvViMGef8E
 T22YglktDg9pA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 01/15] MAINTAINERS: Add myself as maintainer for linux-user
Date: Mon, 27 Apr 2026 23:01:19 +0200
Message-ID: <20260427210133.6016-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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


