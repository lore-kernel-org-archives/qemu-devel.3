Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA4FC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 19:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTS0o-0002S0-Al; Fri, 26 Jan 2024 14:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rTS0m-0002Qt-Em; Fri, 26 Jan 2024 14:37:12 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rTS0k-0003al-BB; Fri, 26 Jan 2024 14:37:12 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 3B1E3C0DED;
 Fri, 26 Jan 2024 20:37:05 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id qvoqVaz7wRD0; Fri, 26 Jan 2024 20:37:04 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 43052C0D86;
 Fri, 26 Jan 2024 20:37:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 43052C0D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1706297824;
 bh=kWtTllImBywwDyWrrIlI/ERUM/1O5S932DszSJRM3Zs=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=8YvesSE1ptc7aXECP0MYpL+AR0g3xM2LkummYTnXcmwydTZjmqs8Sz0cwGWDhNzby
 iN4RwREaHZAlTTvrK2U7McTe178izlAlTFjoT4HKBbyZXaEwmu3KCIfTYLv0FHjr6k
 eI4DLDm3/4h6FpILukBvg+oQk941KI1VkkgnzW9k=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 2IpB81vwtFmy; Fri, 26 Jan 2024 20:37:04 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id B7398C0D83;
 Fri, 26 Jan 2024 20:37:03 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH 0/3] Add device DM163 (led driver,
 matrix colors shield & display)
Date: Fri, 26 Jan 2024 20:31:00 +0100
Message-ID: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
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

This device implements the IM120417002 colors shield v1.1 for Arduino
(which relies on the DM163 8x3-channel led driving logic) and features
a simple display of an 8x8 RGB matrix.

This color shield can be plugged on the Arduino board (or the
B-L475E-IOT01A board) to drive an 8x8 RGB led matrix.
This RGB led matrix takes advantage of retinal persistance to
seemingly display different colors in each row.

It'd be convenient to set the QEMU console's refresh rate
in order to ensure that the delay before turning off rows
(2 frames currently) isn't too short. However
`dpy_ui_info_supported(s->console)` can't be used.

I saw that Kconfig configurable components aren't visible in C files,
does that mean it's impossible to make the DM163 device optional when
using the B-L475E-IOT01A board?

Based-on: 20240123122505.516393-1-ines.varhol@telecom-paris.fr
([PATCH v3 0/3] Add device STM32L4x5 GPIO)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/display : Add device DM163
  hw/arm : Connect DM163 to STM32L4x5
  tests/qtest : Add testcase for DM163

 hw/arm/Kconfig                 |   1 +
 hw/arm/stm32l4x5_soc.c         |  55 +++++-
 hw/display/Kconfig             |   3 +
 hw/display/dm163.c             | 307 +++++++++++++++++++++++++++++++++
 hw/display/meson.build         |   1 +
 hw/display/trace-events        |  13 ++
 include/hw/arm/stm32l4x5_soc.h |   3 +
 include/hw/display/dm163.h     |  57 ++++++
 tests/qtest/dm163-test.c       | 192 +++++++++++++++++++++
 tests/qtest/meson.build        |   1 +
 10 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/dm163.c
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 tests/qtest/dm163-test.c

--=20
2.43.0


