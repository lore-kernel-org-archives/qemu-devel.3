Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3962CD5BAE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMDS-0003EP-Jj; Tue, 19 May 2026 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDH-0003DO-HE
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:32 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wPMDG-0006u3-2S
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:18:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BD9016021A;
 Tue, 19 May 2026 15:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E9C2BCFB;
 Tue, 19 May 2026 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779203908;
 bh=JVMF+Ez1DKkOsgVFkewaLwlvfUh3cmOhQNDtxNke7iA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y9+i9ezszhm7/kwUPMc5E49HlHKmbwRW+mGFOhT7ddpNqUPS/Rm35iVdbuXy7YlvS
 rxNLK4w2xOWHEuTPDKVEsDvSo+judg7V2BuHB9bhyQaT56iUS7165rwjsSDkZlLgRi
 Rhd6fr4gJnjXOuSA5k288HJJWEKsqPTC9jqr/QeUdv/YhmE2x9qLLoPU0yZOlK87dS
 c8LxziTXA20A43KeOLXGAeTzOt8aGmDNj7gVeF1tbMcPnEwKngRzAFTUOPGpAlxR59
 YjSlbVCl1xQkei7OjLM44MPYgCDIPNwOiA2/EOsZ3hidbYLsDvgVFGMEqiqu649GT2
 bJ4ZIP1kboz9g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/2] hw/pci-host/astro: Encode Astro version numbers
Date: Tue, 19 May 2026 17:18:22 +0200
Message-ID: <20260519151823.13878-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519151823.13878-1-deller@kernel.org>
References: <20260519151823.13878-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


