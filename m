Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620BDCF9C5B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 10:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srxer-0003kP-Rw; Sat, 21 Sep 2024 06:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1srxeq-0003jN-8j
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 06:48:08 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1srxeo-00077e-AR
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 06:48:08 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 58DA1208BA;
 Sat, 21 Sep 2024 12:47:59 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id YUaLc-NxmzMk; Sat, 21 Sep 2024 12:47:58 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 5BE7B2086D;
 Sat, 21 Sep 2024 12:47:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 5BE7B2086D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1726915678;
 bh=0pVAqxiPaA2S/dR+37De1xxytrmjckNs4R5fwwNcvgA=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=PBQdB+YQRzJn9jmUTMD5k7LZI/p5NtrGFw1mCaLg2cYIZbGsIU+/nr6JCbIhpM/90
 Ug/FKHUNz/gS0ItUPg4XH6xNEMuasFVr0ZKFkb52kJ/dNbAETzoDlKGjrwwCsjc/aQ
 ozKKNAghMglF/0q8QkQqR5BLJixKuJvRxxpz6O6c=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id IOPiI3cNoYkc; Sat, 21 Sep 2024 12:47:58 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 8156F20843;
 Sat, 21 Sep 2024 12:47:57 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Jacob Abrams <satur9nine@gmail.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH] MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A maintainers
Date: Sat, 21 Sep 2024 12:47:16 +0200
Message-ID: <20240921104751.43671-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It has been a learning experience to contribute to QEMU for our
end-of-studies project. For a few months now, Arnaud and I aren't
actively involved anymore as we lack time and access to the hardware.
Therefore it's high time to update the maintainers file: from now on,
Samuel Tardieu who is behind the project will be taking up the role of
maintainer.

This commit updates maintainers and the list of files, and places the
two devices in alphabetical order.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 MAINTAINERS | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f40..7fa2172df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -706,6 +706,14 @@ F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
 F: tests/qtest/test-arm-mptimer.c
=20
+B-L475E-IOT01A IoT Node
+M: Samuel Tardieu <sam@rfc1149.net>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/b-l475e-iot01a.c
+F: hw/display/dm163.c
+F: tests/qtest/dm163-test.c
+
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -991,6 +999,19 @@ F: include/hw/input/gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
=20
+STM32L4x5 SoC Family
+M: Samuel Tardieu <sam@rfc1149.net>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32l4x5_soc.c
+F: hw/char/stm32l4x5_usart.c
+F: hw/misc/stm32l4x5_exti.c
+F: hw/misc/stm32l4x5_syscfg.c
+F: hw/misc/stm32l4x5_rcc.c
+F: hw/gpio/stm32l4x5_gpio.c
+F: include/hw/*/stm32l4x5_*.h
+F: tests/qtest/stm32l4x5*
+
 STM32VLDISCOVERY
 M: Alexandre Iooss <erdnaxe@crans.org>
 L: qemu-arm@nongnu.org
@@ -1117,26 +1138,6 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/olimex-stm32-h405.c
=20
-STM32L4x5 SoC Family
-M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
-M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/stm32l4x5_soc.c
-F: hw/char/stm32l4x5_usart.c
-F: hw/misc/stm32l4x5_exti.c
-F: hw/misc/stm32l4x5_syscfg.c
-F: hw/misc/stm32l4x5_rcc.c
-F: hw/gpio/stm32l4x5_gpio.c
-F: include/hw/*/stm32l4x5_*.h
-
-B-L475E-IOT01A IoT Node
-M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
-M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
-L: qemu-arm@nongnu.org
-S: Maintained
-F: hw/arm/b-l475e-iot01a.c
-
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
--=20
2.45.2


