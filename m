Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE14FEDA1C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSP-00046e-QC; Tue, 17 Mar 2026 15:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSM-00045v-Gm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:59 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSL-0006RM-9f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 42CB960103;
 Tue, 17 Mar 2026 19:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD18C2BCAF;
 Tue, 17 Mar 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777116;
 bh=s6g2Gm4dbBjnbiN8tY8IiTMbXrriTjpNP6nrtcMrisw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T5ofgio/DLTlgwYEgmxtTdXJ0cSvYVFDobCecNEXNLo9UTNnHewl9ByGf6K92kWxF
 doIvp5q5isaHoq5PdjYXRpbCu6RsMuDcPDE16TS7N9iqGj5XtUAmdz9BWBofw+9Khc
 +rCeZhuyBcbVkc2IkHyl/BkFQwox7AOPAcT/RxUAP12RdNHM6yDz9kgQJCJPlnu8oG
 KwkCVsQkIn6COUlGXv9msHTp8FWjz4zckFfF5HRu9b8Ym7/54UbFyJpySeVYDq1mSK
 nY4dZRM0u2iEYFOnSvMpArSKzXOGe2rz/9xiKjYrdVPRJ3QZWh6TNHv3iIJP0EamPi
 dt9uoOraphdKA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 2/6] hw/hppa: Adjust physical addresses of Astro and Elroy
Date: Tue, 17 Mar 2026 20:51:45 +0100
Message-ID: <20260317195149.8386-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317195149.8386-1-deller@kernel.org>
References: <20260317195149.8386-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Adjust the addresses of the Astro and Elroy PCI chips to a
44-bit physical address space when running a PA8700 CPU.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 0a89c3ed52..006aae63b9 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -61,8 +61,8 @@
 #define ASTRO_BUS_MODULE        0x0a            /* C3700: 0x0a, others maybe 0 ? */
 
 /* ASTRO Memory and I/O regions */
-#define ASTRO_BASE_HPA            0xfffed00000
-#define ELROY0_BASE_HPA           0xfffed30000  /* ELROY0_HPA */
+#define ASTRO_BASE_HPA            0xffffed00000
+#define ELROY0_BASE_HPA           0xffffed30000  /* ELROY0_HPA */
 
 #define ROPES_PER_IOC           8       /* per Ike half or Pluto/Astro */
 
-- 
2.53.0


