Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE24C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAPn-0007LD-CU; Wed, 12 Aug 2026 10:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPV-0006h3-NF; Wed, 12 Aug 2026 10:58:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPT-00015I-3G; Wed, 12 Aug 2026 10:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=0T545qlrX6TiwKIgTIhjpjKUw13ITDMi3f3BFQB9u1w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xU0GAtHGXScySeEdrmadUhE4xRB6NcXlb029Z2Tf09fhQx5S3w6JywyS1jHl2UMo1
 2hGMHTCJIekg48g7FTVQbBkTdpXs8sVRRQueVxIrFnyyxK4OMfCRa1//lGyuM01xm0
 d0rq/E779l4UCTj5vklSXYPl9TNgJlelKHBZ3k7gnH9aO/Koap3FQZbY+OOZyjqChG
 a56tdsUTDA2b8+kZVK/8HhK0SuTq98rfzp4yvvr2mr6zoGnGbNUGFg8MfCQQw4oE9X
 XkHjh4iIlxxLYCuFMZu7wPjRiJNrf8E92CPIP/r1/V49jGTKUF2GquOfdXzkbmfX3F
 sP+8X5QFerrJA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E6D541CA652;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4DA5A409D94;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id ABD4D2F9FF; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, botszhuang <huang.botsz@gmail.com>,
 botszhuang <botszhuang@gmail.com>, Nick Huang <sef1548@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 078/120] hw/i2c/bcm2835_i2c: Correct CLKT register
 offset
Date: Wed, 12 Aug 2026 17:49:01 +0300
Message-ID: <20260812144955.649205-78-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: botszhuang <huang.botsz@gmail.com>

The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C
controller is actually located at offset 0x1c, not 0x20.

Update the BCM2835_I2C_CLKT macro to match the hardware
specification.

Since QEMU's implementation ignores whatever value the guest
writes to this register, and Linux only writes to CLKT and
doesn't read it back, the main effect of this fix is to
avoid an incorrect GUEST_ERROR log.

Cc: qemu-stable@nongnu.org
Fixes: 9cf3bc65afdb63 ("hw/i2c: Implement Broadcom Serial Controller (BSC)")
Signed-off-by: botszhuang <botszhuang@gmail.com>
Tested-by: Nick Huang <sef1548@gmail.com>
Message-id: 20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com
[PMM: removed commit message paragraph about effects which I think
 is incorrect, substituted a different one]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit c4580a3a6d1cc542479602048d15556a18928a22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
index 45f876df224..519c65f7652 100644
--- a/include/hw/i2c/bcm2835_i2c.h
+++ b/include/hw/i2c/bcm2835_i2c.h
@@ -38,7 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835I2CState, BCM2835_I2C)
 #define BCM2835_I2C_FIFO    0x10                  /* FIFO */
 #define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
 #define BCM2835_I2C_DEL     0x18                  /* Data Delay */
-#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeout */
+#define BCM2835_I2C_CLKT    0x1c                  /* Clock Stretch Timeout */
 
 #define BCM2835_I2C_C_I2CEN     BIT(15)           /* I2C enable */
 #define BCM2835_I2C_C_INTR      BIT(10)           /* Interrupt on RXR */
-- 
2.47.3


