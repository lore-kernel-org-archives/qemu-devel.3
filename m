Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196321061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0y-0000pP-0Q; Mon, 30 Mar 2026 17:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0w-0000os-Hd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:14 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0v-0003k8-3B
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A268A60141;
 Mon, 30 Mar 2026 21:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70265C2BCB1;
 Mon, 30 Mar 2026 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905552;
 bh=6xj6C4pIFtPIFDPUMt52wkUaaYgx/B6hgBiZiDroPQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AMoP+xwbVsbAVeDk/dbY9y6wHEgOY/RW/ZLGmHbWuHrOY0Liatu6Axih5FTfcj1v9
 gF5ubBXjXX7dVeUzuTqmrRoe5T+ypv6ypjIebCFj0plSMQ3AbKHGb8pkIbGRma8bP7
 ZANBHmTUhTBgsqHYfa/ylbOF7rChznWCEkZFOzqy1aQ8kRFyaWvDUqADZAhB0T9ylV
 YbY8d8L5hR+iqWwnQ/HA1w4/NZIL957KLDuIepVpXXzWCbhsxLCjMz8ZadblSqVpIm
 8zvrZqirG+Qyh5PiG49gXO0RxrSkkPtMkcjihow6xmwUwHr1U0NgP0rKDl4mxC/rkV
 mFSTWkznji3Iw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/11] hw/pci-host/astro: Add comment about Astro version
 numbers
Date: Mon, 30 Mar 2026 23:18:55 +0200
Message-ID: <20260330211859.19317-9-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 8c61c696bd..776267e150 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -738,7 +738,7 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
     switch ((addr >> 3) << 3) {
     /* R2I registers */
     case 0x0000:        /* ID */
-        val = (0x01 << 3) | 0x01ULL;
+        val = (0x01 << 3) | 0x01ULL; /* 0=Astro 1.0, 9=Astro 2.1, 2=Astro 3.0 */
         break;
     case 0x0008:        /* IOC_CTRL */
         val = s->ioc_ctrl;
-- 
2.53.0


