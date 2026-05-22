Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9868CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXmu-0003Zo-L2; Fri, 22 May 2026 17:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXmg-0002rP-5K; Fri, 22 May 2026 17:52:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXme-0004EV-1E; Fri, 22 May 2026 17:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=CBmXxLaye/eE13X9exw7xfw/K70AIPWJmgtC4ZIwDTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eRSPsGvCDZLjvTevoeXj1DlZQhfo456uaa7yR6PV6OxQdLO096Bzam+rYJpsAbGrx
 kdU2xyhh0udz+IWgi+qHrZr0W/MmP70NG/okywjlpF/Nrg+vkOBZSNRlnurs7a5Xpm
 quq9IC4dwFxQJwz6/bewcXFcNToxBEUnZow6qy9c/kAkw33Ng6pJ9Vvl+UY+u37ylA
 D43sluHMKkTN+F0LzohBk9bQIIcAj1yM6eDh02GSvPGecsl+LKlZ1UCzc0H29hN5qf
 cGx0DXzlaYKKc1UTnhk0lfDE+MsRKXi/gJxCyvxI/Jf45MKufKDzJTO0TWf23Id3RD
 Z+GAoW3v1GKBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0514B1AFB77;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2DA453B71C6;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 129/149] hw/i2c/microbit_i2c: Don't index off end of
 twi_read_sequence[]
Date: Sat, 23 May 2026 00:49:01 +0300
Message-ID: <20260522214923.807017-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

If the guest tries to read more bytes from our fake stub I2C device
than we have provided, we incorrectly read one byte beyond the end of
this array. Avoid this, and instead keep reporting the RXD register
as containing the last byte of the "data transfer".

Cc: qemu-stable@nongnu.org
Fixes: 9d68bf564ec ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3408
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260501162634.4092394-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit a824f3531a44cbd19bcd9dd0ca48e5805c781e02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 2291d6370e..d9689b6f1a 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -41,8 +41,13 @@ static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned int size)
         data = 0x01;
         break;
     case NRF51_TWI_REG_RXD:
+        /*
+         * Return the next byte from our fake data sequence. If
+         * the guest keeps reading the register after that, keep
+         * returning the same last byte value.
+         */
         data = twi_read_sequence[s->read_idx];
-        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
+        if (s->read_idx + 1 < G_N_ELEMENTS(twi_read_sequence)) {
             s->read_idx++;
         }
         break;
-- 
2.47.3


