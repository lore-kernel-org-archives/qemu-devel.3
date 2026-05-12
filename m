Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD26CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMukC-0006iq-Q1; Tue, 12 May 2026 17:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMujA-0005Ri-Ta; Tue, 12 May 2026 17:33:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuis-0002ke-Pk; Tue, 12 May 2026 17:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619500; bh=xmHfeUJz0ZcDqeB1vL/AXC1QJ6Wf1Lm11pgd52X7R5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NYUDQDHPZcUH0d0wlRzkx3yYSABIu3Wxbug1yinYSX6p3WExF1hQ2ZozMoCIY8zGG
 Le3X7K+9NF9B/FHpOQ3QdN1FAhC0SO1lsbhatiP5W/LJbIEDrF8m22DjOUCFA+5NzD
 nt2QFjhAwpjYHFY0cPm3N4Z4klHsFLKBF6X6ofZ2GDwvUXa/k8bErA+Xp8a9ZNbFcD
 YuRbkMOuQud7qdSqwfw4GEr+cd/X+qb9W6jsYmKh4Py6WOQMTuQ+oBsK7kOZuDv0KE
 XARjwUeojcbA/AqUSkk/XOd4Yr6CzZwTbYQoq3nRD246g7NlSdMZ4a/AstPSj7wjZ3
 XG2vt8Gzk/Q+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 743231AA3FE;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 77A283ABD56;
 Tue, 12 May 2026 23:58:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 51/58] hw/misc/bcm2835_rng: Specify valid memory
 access sizes
Date: Tue, 12 May 2026 23:58:12 +0300
Message-ID: <20260512205820.361821-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The BCM2835 RNG has 32-bit registers only; specify this in
the MemoryRegionOps so wrong-sized accesses are rejected rather
than getting to the assertions in the read and write functions,
and for clarity add the matching .impl constraints.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260501162700.4092512-1-peter.maydell@linaro.org
(cherry picked from commit 18b664c90085b0d2be9c2ad8c747e00a7a733402)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index e4d2c224c8..4492e325b4 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -93,6 +93,10 @@ static const MemoryRegionOps bcm2835_rng_ops = {
     .read = bcm2835_rng_read,
     .write = bcm2835_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static const VMStateDescription vmstate_bcm2835_rng = {
-- 
2.47.3


