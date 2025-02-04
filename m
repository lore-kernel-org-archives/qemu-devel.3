Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C8BC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 22:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfREl-0005Wa-KV; Tue, 04 Feb 2025 17:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREi-0005VZ-AX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREg-0005Rj-F0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 959B75C2BAA;
 Tue,  4 Feb 2025 22:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA8C4CEDF;
 Tue,  4 Feb 2025 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738707457;
 bh=mrPagw6SSe5CTtRH8sceU9mjjwvokCW1bYWEL4Kbl3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XW5KZStI/d3p9wrBOqaIIaj4lKB6hhfqN+2WHthJu0T9XMjn0ohAe5IP4VAxIgBn3
 yXTMyBZPCjoYgj0lsk76ONVDlv1+5y37Sv/7zybaz7Xbv2UrlKKfNUg5EBKfs6iC6Q
 4hdsLqZhgW/BSXrl91UjMwUMcZGK+6NxR0vC8mKN+13nMG9HPfe29NrHZYpr/7e7W7
 rPlJyBU6MWaL2pzu4gxsXCludLB///BV6mwYFvWGF+JwTZi+221jiyOM3oi/QZltYu
 b34erXllsF/FwG7W4lDXXoCQazwAEkCQlsPa0IXcK0gO9NUsihOwNft7n0sZV/2ErH
 XO0/OkIQDQreQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 6/6] target/hppa: Update SeaBIOS-hppa
Date: Tue,  4 Feb 2025 23:17:26 +0100
Message-ID: <20250204221726.151287-7-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204221726.151287-1-deller@kernel.org>
References: <20250204221726.151287-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Update to lastest SeaBIOS-hppa which sets up the
LMMIO range for the internal artist graphic card.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 roms/seabios-hppa | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 1c516b4813..3391c58096 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 1c516b481339f511d83a4afba9a48d1ac904e93e
+Subproject commit 3391c580960febcb9fa8f686f9666adaa462c349
-- 
2.47.0


