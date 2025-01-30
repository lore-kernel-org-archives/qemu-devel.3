Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08A4C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUbl-0004f1-PF; Thu, 30 Jan 2025 08:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbk-0004ed-8a
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:24 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdUbi-0001Of-Nv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:29:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6D486A40C33;
 Thu, 30 Jan 2025 13:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC2AC4CEE0;
 Thu, 30 Jan 2025 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738243759;
 bh=kFS5JPLZ6Yq0LhIiT+AHVHk3BwDkleBFMtJ92/ovT10=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mTLybAPFPWgDU06R5MM9/rXroJ//GYDbaFqi+UMKYLHyzBFzvKDoDbbUhwMzg0SAU
 TT/gl4jTFxuE/8AABXAMwBjDtAuJB5X11lIlDHKQu5N3SZ5qwRlpO7nxs+JAkJj6gi
 mzwgvF2lHISfHxy/B2THVbTtCPm32QLHqOIHDBLS3ZVV7uzmlZDnIlpkpZpXuX3v00
 gFIEHOypI3n4VkEu2h96ZS15j88XZsSY5JgmaKYrvJsNqLyyoDApD1WVnD4hgMTZPi
 7rcIV7UjfXY18H0PSiv8vj45veKiOAj5rbFkLElz/A1pJkegyt4XhOIbJdx47cwseb
 /hcMdD4JkMZpw==
From: deller@kernel.org
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 1/9] MAINTAINERS: Add myself as HPPA maintainer
Date: Thu, 30 Jan 2025 14:29:06 +0100
Message-ID: <20250130132915.16846-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130132915.16846-1-deller@kernel.org>
References: <20250130132915.16846-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since I contribute quite some code to hppa, I'd like to step up and
become the secondary maintainer for HPPA beside Richard.
Additionally change status of hppa machines to maintained as I will
take care of them.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7be3d8f431..dbf39cfbb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -251,6 +251,7 @@ F: target/hexagon/gen_idef_parser_funcs.py
 
 HPPA (PA-RISC) TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
+M: Helge Deller <deller@gmx.de>
 S: Maintained
 F: target/hppa/
 F: disas/hppa.c
@@ -1188,8 +1189,8 @@ HP-PARISC Machines
 ------------------
 HP B160L, HP C3700
 M: Richard Henderson <richard.henderson@linaro.org>
-R: Helge Deller <deller@gmx.de>
-S: Odd Fixes
+M: Helge Deller <deller@gmx.de>
+S: Maintained
 F: configs/devices/hppa-softmmu/default.mak
 F: hw/display/artist.c
 F: hw/hppa/
-- 
2.47.0


