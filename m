Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C99E6FE49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 23:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smhxj-0004XO-Ua; Fri, 06 Sep 2024 19:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smhxh-0004W9-G1; Fri, 06 Sep 2024 19:01:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smhxg-0006KF-3o; Fri, 06 Sep 2024 19:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=BuackiRRFpiul8JpQIgc3NloghbBeK8/ch+QD7HUeb4=; b=Xmszhb7Cv/dUtNftKh332eX0uk
 2ybfEPKZjqXj5AAZYA/fPZOQ67RC4n1+f9jWKNvqX7z+5CtB7ZnxNQHWJIJzLwlKm7RJd9HyA7zPC
 dT90nqqzH3uRE++Xhxlrrux3esNF05+K8plp8o7zlsQitByPwKvFwnBcfeDa4Bak8yX827eTYMapV
 czmtwOS7fJsZk/iXM36eIU3AzweL9Wg/SDBylk8pyoEtWffNXnrtC1evG1PE3zeWwuFkhtJiWPFgN
 T6M1CGqUTYl+AD9NTKuajAnPd/skZDSCCr0g6kdm/tXbIPKW8zP8boiiIDmYt3xAIFZ+7WsV6Kke7
 +wj+aFqt8GOMnaGqU92zy0msvusO0gRneE67bNJieQDNfgXuZOKZOzlD09pOcmWPXBEdnTQcy/sty
 5nKhnMTL9+yACJi84TFRLAyN9yw80/d1QCs4Wph6ET2mLqnGcaMB5qPo5jbB+9qjEF+XNxapZsDFO
 5Mq/lFlUhJtCXzgRxr5r1+ztkNtE+afUXk/yYcAL405JGrop4n+N3EAy5xkH0aPIUdQ+odWJ2/VCA
 +X/DNvP37oTQ2xqVeRw9M68ElvysRRIwLdxcBsWpCgVw6JY+bYtH0RnVaKDuTwllPc3X3a/rl3f69
 T0vwVYyst7aIQSaTVzBS88IeNuFWu1qTAY5SNLL1s=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smhxU-000Cbp-3m; Sat, 07 Sep 2024 00:01:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: hpoussin@reactos.org, arikalo@gmail.com, philmd@linaro.org,
 jiaxun.yang@flygoat.com, dwmw@amazon.co.uk, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Date: Sat,  7 Sep 2024 00:01:38 +0100
Message-Id: <20240906230138.335995-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] hw/mips/jazz: fix typo in in-built NIC alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit e104edbb9d ("hw/mips/jazz: use qemu_find_nic_info()") contained a typo
in the NIC alias which caused initialisation of the in-built dp83932 NIC to fail
when using the normal -nic user,model=dp83932 command line.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/mips/jazz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1bc17e69d3..0d44e19707 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -128,7 +128,7 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
     uint8_t *prom;
     NICInfo *nd;
 
-    nd = qemu_find_nic_info("dp8393x", true, "dp82932");
+    nd = qemu_find_nic_info("dp8393x", true, "dp83932");
     if (!nd) {
         return;
     }
-- 
2.39.2


