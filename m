Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083BDCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKZm-0008M4-Hw; Tue, 19 May 2026 09:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKZk-0008KX-Rc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:33:36 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPKZj-0000i3-GK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:33:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 45C354176C;
 Tue, 19 May 2026 13:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09383C2BCB3;
 Tue, 19 May 2026 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779197614;
 bh=5Hag2ilN+ESkd2Kb+HT0871PS9TxMnHFXG88KpF4W+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hiZdU7bNV0dmiq4raqfaH+Dj5v1u3YXRQlCzveMLV2HVVUi9k55+CUxmkMUo2Wi65
 n71pz6i1AOmjHPWjKzqIAaJwWEcVdyPl0N3VSluAWsf95Iyqb0UVLaysh5yMYzVUv4
 L1c+I7TlldAE55+rD6x5jBgw+2Rn4Rsm3OrrUeEc/OsVNP/4lJ8KCc2PBZkoh7p7GZ
 CgBp6AmEwl4IOOIg14x8xjmq+Bui9e/X3Rt+qakQnGsV/+wdT3fGritNLTJCIDjfXp
 i6JuYD3hPaeetlKWCtzTYlFTD/IBwCMMjtm2PcYzja4K1/bdeBvkT6iYAJ6bPI6eEn
 CUq48gCP6Ci+A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] hw/pci-host/astro: Encode Astro version numbers
Date: Tue, 19 May 2026 15:33:28 +0200
Message-ID: <20260519133329.4268-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519133329.4268-1-deller@kernel.org>
References: <20260519133329.4268-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add enum which encodes the Astro version numbers.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 8c61c696bd..fc07608da7 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -41,6 +41,9 @@ static const int elroy_hpa_offsets[ELROY_NUM] = {
 static const char elroy_rope_nr[ELROY_NUM] = {
             0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
 
+/* Astro version numbers */
+enum { ID_ASTRO_1_0 = 0, ID_ASTRO_2_1 = 9, ID_ASTRO_3_0 = 2 };
+
 /*
  * Helper functions
  */
@@ -738,7 +741,7 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
     switch ((addr >> 3) << 3) {
     /* R2I registers */
     case 0x0000:        /* ID */
-        val = (0x01 << 3) | 0x01ULL;
+        val = ID_ASTRO_2_1;
         break;
     case 0x0008:        /* IOC_CTRL */
         val = s->ioc_ctrl;
-- 
2.54.0


