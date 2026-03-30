Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5ED1061B08
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0q-0000mR-RJ; Mon, 30 Mar 2026 17:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0p-0000lw-7v
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:07 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0n-0003hw-HK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F34541A60;
 Mon, 30 Mar 2026 21:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52891C2BCB0;
 Mon, 30 Mar 2026 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905543;
 bh=75Kot7W8TYmvaAYajRYXbd9HndvesFrDcrITk62Y55I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j6gxIkeGQPXoFNp++d8EY+gVe/jzdkoLt8YIzqBWTaDPW7FhWKOJ78Fhxy10z0ldu
 kR3nGw0xsxEP5lNXYD5gw+3gQDBekYyTemFkqFWxItaStJQbQx1z17tK8389d9P83T
 4xc1YRxXPnHkML+ONgzdyk5LKxV5ytvuyQykr2rzT3OlL0WOE8aujGpOtfh36QTMj6
 cpzceSZxBP0ombqHa9cffTzWOhaqPQCfurl0DynRmr4koNoPHoU0qUq8Fh+4NUwAoO
 WN0+VfLimdeYcD8Ah4/7DcmFDRzxZTJTFGSC/85NiIOYOzORiYx7MjGRyfDyuyF0wV
 d5Mgr+m/q713Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/11] hw/pci-host/astro: Update copyright and documentation
 link
Date: Mon, 30 Mar 2026 23:18:48 +0200
Message-ID: <20260330211859.19317-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Update the link to the documentation, which was still pointing to the
Wiki page. In the meantime the PA-RISC wiki was converted to a
read-the-docs website.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 6cc0b35070..59d8007a1a 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -3,12 +3,12 @@
  * with Elroy PCI bus (LBA) adapter emulation
  * Found in C3000 and similar machines
  *
- * (C) 2023 by Helge Deller <deller@gmx.de>
+ * (C) 2023-2026 by Helge Deller <deller@gmx.de>
  *
  * This work is licensed under the GNU GPL license version 2 or later.
  *
  * Chip documentation is available at:
- * https://parisc.wiki.kernel.org/index.php/Technical_Documentation
+ * https://parisc.docs.kernel.org/en/latest/technical_documentation.html
  *
  * TODO:
  * - All user-added devices are currently attached to the first
-- 
2.53.0


