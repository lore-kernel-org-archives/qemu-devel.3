Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69CDC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bm-0005MR-Gy; Tue, 21 Jul 2026 04:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bl-0005Lp-5y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bj-0005fm-Eo
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so14239945e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623854; x=1785228654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lOmDoEzGw0hhmhIBGIg2uJ1q+mJAOqF1fExTH4P3WKk=;
 b=bt6Lr6tgh66gymucRGlBTKDDKCDDeLq3iQ2YDszWvHDtdi6TjDvv53j7oySINoHsli
 F/L7HdMn2wFT2c0SQd7t3N/q07YL8U4QvY1l1jDOqW6My4uTpRiuJDFJhpcAXz7VVaRe
 6YMi16KAXwCx/IWoMAiazob+GNtSSrKzP8vwZI2lAEax31MVQNmcX5bbljdgEmJX+qOT
 cP8qbfsiE6fvMaZt+/6NjAry8WqWWyMf1HEP5Z8DmJHPUiFq1e09+90gVcTq0pCqbKM0
 F65wPV98/HA5yl3flc1f9Bj8hGtD0NzGoKTN5xQZwvlv57pF15kWr7z8nfkISLl0RIOB
 fqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623854; x=1785228654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lOmDoEzGw0hhmhIBGIg2uJ1q+mJAOqF1fExTH4P3WKk=;
 b=sBQAWAkDH6+gwgrNIF3+MV194J3iYN/pdeBxJmXevF6hd3dGxW3hbAJhoRchjYkYRR
 Oi4J+kQgbBN+HCOop64Nd0poeKSgtgrl+arfuYv2MOWLkruxbj3BTRT6M3HaeiNsl5Ds
 p29qGFHFqL/1E30Altk/jytoMZnceqEGP1ul+xKhfH819HEPIlo/d+7F0TdTrUTuU7VL
 fSUCXck0Nredm8b7EiWpy1gTQ+FJdfZjihTooFm3JPmmOB88J/QnMi0QeLTFgsEoSU7b
 k0b3hfmi450CtjbBuYs2UPDXDUo2GEyKeKXCS7bOlta/jsTxLVUeG3rPtrFufMBbp/DV
 ssKw==
X-Gm-Message-State: AOJu0YxLKW+T6RjF0uKSaMBCFg6THZl3W/SrG2rcyuE3g1JfNmGr6yeg
 eQamxsHbVjUyxz9Lu3i5lCU8U4xajvIMZvJkOtGPnh07BtJMgnivAV5PUeNj8T/RuKeTCRb3YiQ
 yLuOhRQe5Ug==
X-Gm-Gg: AfdE7cmsCH5//Psw6LHu8DM/mYiXmsSCCZs5ZbA/i/UCnaaiJTMTGXVf4ZmPX4IqOM0
 K4NNrmWnHSDMY4dT2bvJ617P4wC5rosbumTMBPBdA11u+aWPLU2ii9j6nVLDm/PuIcc6TPMqRKZ
 aW2kSiVNqCm6O3maohz8DG58W0WpdWFmmS8Kvf0mg9ki2hzk6EfTHbMJQwBum61zDhVDqJvWrO5
 ZedGAIy03hjrEnHxvGQnN6MXahaxjTJ6FBrEYCYJRHQ4plhFbcwbQhCyk5zur4hmb4E3YVN3r/C
 fSileomItXqC05ofMZVuHExGQoB6LGSokVaEdYnFi8aTQ/ITY3bJOKKJ92oZU04QTnUthAzSKXI
 vTtcWFoXbuGOuc4fNXFlJd3JzCrhVZ6USrRInHLIDRInACupyAnQ/ufMV9CF8AM+8sRK+pJ4f7W
 yvHXXwrVsGMgbQEb+12Mxp1LSUSnONrBUYKHKd73W4JtG7PpavUUcRMhvOT4Dto1amL46XR/zc5
 odWUN6PBKIdMxf2a6YDxA==
X-Received: by 2002:a05:600c:c097:b0:495:5a91:8027 with SMTP id
 5b1f17b1804b1-4955a9182a8mr105997385e9.5.1784623853947; 
 Tue, 21 Jul 2026 01:50:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] hw/char: imx_serial: add missing migration state
Date: Tue, 21 Jul 2026 09:50:35 +0100
Message-ID: <20260721085050.421257-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Tao Ding <dingtao0430@163.com>

The imx_serial vmstate is missing the ucr2 field.  This register
includes important state like the transmit enable and receive enable
bits, so it's likely that after a migration the UART will be in a
completely broken state. This bug has been present ever since
the UART code was first added to QEMU.

Add ucr2 from imx_serial to vmstate, and increment the version_id.
This is a migration compatibility break, but this UART is only used
in the various imx-based boards, where we are OK with compat breaks.

Migrating on sabrelite can reproduce this issue:
1. Prepare the U-Boot required for sabrelite. (according to sabrelite.rst)
2. Compile qemu
    $ mkdir build && cd build && ../configure --target-list="arm-softmmu" && make -j4
3. Start sabrelite and prepare for migration
    $ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot
4. Enter qemu monitor after uboot. (ctrl + a + c)
    (qemu) stop
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
    (qemu) migrate -d file:vmstate
    (qemu) q

Load the migrated vmstate, before repairing:

$ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot -incoming file:vmstate

(ctrl + a + c)
    QEMU 11.0.50 monitor - type 'help' for more information
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00000004 0x00000784 0x00008000 0x00000a01
    (qemu) q

It can be found that the data for address 0x021e8084 (register of usr2 in imx_serial of sabrelite)
is not the data before the migration.

After being repaired:
$ ./build/qemu-system-arm -M sabrelite \
    -smp 1 -m 1G -display none -serial null -serial mon:stdio \
    -kernel ~/u-boot -incoming file:vmstate
(ctrl + a + c)
    QEMU 11.0.50 monitor - type 'help' for more information
    (qemu) xp /4wx 0x021e8084
    021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01

Cc: qemu-stable@nongnu.org
Fixes: 40b6f91151 ("i.MX: UART support")
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-id: 20260715131819.14827-2-dingtao0430@163.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/imx_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 080b7f6331c..fb41ee2ac50 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -43,14 +43,15 @@
 
 static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_FIFO32(rx_fifo, IMXSerialState),
         VMSTATE_TIMER(ageing_timer, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
         VMSTATE_UINT32(usr2, IMXSerialState),
         VMSTATE_UINT32(ucr1, IMXSerialState),
+        VMSTATE_UINT32(ucr2, IMXSerialState),
         VMSTATE_UINT32(uts1, IMXSerialState),
         VMSTATE_UINT32(onems, IMXSerialState),
         VMSTATE_UINT32(ufcr, IMXSerialState),
-- 
2.43.0


