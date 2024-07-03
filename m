Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B84C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0dJ-0001kh-9n; Wed, 03 Jul 2024 10:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sP0dE-0001kB-0e; Wed, 03 Jul 2024 10:06:48 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sP0d1-0008Qg-1Y; Wed, 03 Jul 2024 10:06:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 89709260A6B;
 Wed,  3 Jul 2024 16:06:28 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id KBWMOC915zEu; Wed,  3 Jul 2024 16:06:26 +0200 (CEST)
Received: from applejack.lan (83.8.74.165.ipv4.supernova.orange.pl
 [83.8.74.165])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 9311826018B;
 Wed,  3 Jul 2024 16:06:25 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v4 0/2] tests/avocado: updates for sbsa-ref testing
Date: Wed, 03 Jul 2024 16:06:10 +0200
Message-Id: <20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJahWYC/4XNQQ6CMBCF4auYrh1TygjUlfcwLlo7hSZKzZQ0G
 sLdLezc6PJ/yXwzi0QcKInTbhZMOaQQxxK434nbYMaeILjSQkmFslEIFuERM8EUwTORTQ6M8Y5
 seyRfd6IcPpl8eG3o5Vp6CGmK/N5+ZLWuP7msQEKDZForUevOn+9hNBwPkXuxern+b9TFaCvUj
 fVVpR1+GcuyfADJibrQ+QAAAA==
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

We want to have some non-Linux OS in testing in case one of changes keep
Linux booting but crash elsewhere. So far OpenBSD was used for it but we
move to FreeBSD 14.x due to longer support cycles.

One OpenBSD stays - will be run on Cortex-A57 only. And only on local
runs hidden behind AVOCADO_TEST_LEGACY_OS variable.

At same time we add test to run on default cpu settings. For now it is
plain Neoverse-N2 but we are considering either disabling PAuth or going
with 'impdef' way.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

---
Changes in v4:
- hide OpenBSD test behind AVOCADO_TEST_LEGACY_OS switch
- Link to v3: https://lore.kernel.org/r/20240624-b4-move-to-freebsd-v3-0-71496bf119d4@linaro.org

Changes in v3:
- kept OpenBSD/Cortex-A57 test for local runs (by request of Philippe)
- Link to v2: https://lore.kernel.org/r/20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org

---
Marcin Juszkiewicz (2):
      tests/avocado: sbsa-ref: add FreeBSD tests
      tests/avocado: add test for default sbsa-ref cpu

 tests/avocado/machine_aarch64_sbsaref.py | 88 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 24 deletions(-)
---
base-commit: 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768
change-id: 20240624-b4-move-to-freebsd-aafdeb75ef38

Best regards,
-- 
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


