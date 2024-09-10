Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94A6ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxUE-0006XI-2t; Tue, 10 Sep 2024 05:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snxUB-0006TV-Ju; Tue, 10 Sep 2024 05:48:35 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snxU9-0000M9-TM; Tue, 10 Sep 2024 05:48:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id D349A260BA2;
 Tue, 10 Sep 2024 11:48:30 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id X2CWEUwOFf_u; Tue, 10 Sep 2024 11:48:28 +0200 (CEST)
Received: from applejack.lan (83.11.24.101.ipv4.supernova.orange.pl
 [83.11.24.101])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id BD1552602C9;
 Tue, 10 Sep 2024 11:48:17 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v5 0/4] tests: updates for aarch64/sbsa-ref
Date: Tue, 10 Sep 2024 11:48:07 +0200
Message-Id: <20240910-b4-move-to-freebsd-v5-0-0fb66d803c93@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcV4GYC/4XNTQrCMBCG4atI1kbyM20aV95DXCR20ga0kaQEp
 fTupt2IKLp8P5hnJpIwekxkv5lIxOyTD0OJarsh594MHVLfliaCCWC1AGqBXkNGOgbqIqJNLTX
 GtWhVhU42pBzeIjp/X9HjqXTv0xjiY/2RxbL+5LKgjNaARlkGWjfucPGDiWEXYkcWL8v/hiyG4
 qBr6zjXLXwY8DIUk18NKAZTXHOnq6aS7M2Y5/kJcm/hlj0BAAA=
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.14.0
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

We want test to run on default cpu settings. For now it is plain
Neoverse-N2 but we are considering either disabling PAuth or going with
'impdef' way.

We want to have some non-Linux OS in testing in case one of changes keep
Linux booting but crash elsewhere. So far OpenBSD was used for it but we
move to FreeBSD 14.x due to longer support cycles (OpenBSD 7.3 we use is
already EoL).

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

---
Changes in v5:
- update to post-avocado system
- drop all OpenBSD tests
- Link to v4: https://lore.kernel.org/r/20240703-b4-move-to-freebsd-v4-0-07191f958530@linaro.org

Changes in v4:
- hide OpenBSD test behind AVOCADO_TEST_LEGACY_OS switch
- Link to v3: https://lore.kernel.org/r/20240624-b4-move-to-freebsd-v3-0-71496bf119d4@linaro.org

Changes in v3:
- kept OpenBSD/Cortex-A57 test for local runs (by request of Philippe)
- Link to v2: https://lore.kernel.org/r/20240624-b4-move-to-freebsd-v2-0-64ea7b04998f@linaro.org

---
Marcin Juszkiewicz (4):
      tests: use default cpu for aarch64/sbsa-ref
      tests: add FreeBSD tests for aarch64/sbsa-ref
      tests: expand timeout information for aarch64/sbsa-ref
      tests: drop OpenBSD tests for aarch64/sbsa-ref

 tests/functional/test_aarch64_sbsaref.py | 58 +++++++++++++++++---------------
 1 file changed, 31 insertions(+), 27 deletions(-)
---
base-commit: 1581a0bc928d61230ed6e43bcb83f2f6737d0bc0
change-id: 20240624-b4-move-to-freebsd-aafdeb75ef38

Best regards,
-- 
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


