Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D63C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDfA-0001Vk-5P; Mon, 18 Mar 2024 10:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rmDez-0001TQ-W6; Mon, 18 Mar 2024 10:08:18 -0400
Received: from muminek.juszkiewicz.com.pl ([213.251.184.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rmDet-0006Fo-C5; Mon, 18 Mar 2024 10:08:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 8A950260CC8;
 Mon, 18 Mar 2024 15:08:07 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WnRG1pdPX_zP; Mon, 18 Mar 2024 15:08:05 +0100 (CET)
Received: from [172.17.0.1] (83.11.22.169.ipv4.supernova.orange.pl
 [83.11.22.169])
 by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 7367C2600DA;
 Mon, 18 Mar 2024 15:08:04 +0100 (CET)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v3 0/4] tests/avocado: update sbsa-ref firmware to latest
Date: Mon, 18 Mar 2024 15:08:00 +0100
Message-Id: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBK+GUC/43NSw7CIBCA4asY1o7hTXDlPYwLCrQl0dJARU3Tu
 0u70o1x+U9mvplR9in4jI67GSVfQg5xqMH2O2R7M3QegquNKKYcM8IgN9lA8i20Id0eJnm4j85
 MHpRQ2ulWOqEbVM/HuhSeG32+1O5DnmJ6bZ8KWad/oIUABk+kVJhZwSk/XcNgUjzE1KFVLfRT4
 j8kWqVGCGWFFEJb9yUty/IGeDTaXQsBAAA=
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>, 
 qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
X-Mailer: b4 0.12.3
Received-SPF: softfail client-ip=213.251.184.221;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=muminek.juszkiewicz.com.pl
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Updating sbsa-ref firmware for QEMU CI was manual task. Now it is
replaced by CI job run on CodeLinaro Gitlab instance.

This patchset updates to current state:

- Trusted Firmware v2.10.2 (latest LTS)
- Tianocore EDK2 stable202402 (latest release)

And Tianocore EDK2-platforms commit 085c2fb (edk2-platforms does not
have releases).

Firmware images were built using Debian 'bookworm' cross gcc 12.2.0
compiler.

And while I am in that file I dropped use of 'virtio-rng-pci' device as
sbsa-ref is supposed to emulate physical hardware.

Added 'max' tests with 'pauth=off' and 'pauth-impdef=on' variants.

(01/11) test_sbsaref_edk2_firmware: PASS (2.51 s)
(02/11) test_sbsaref_alpine_linux_cortex_a57: PASS (23.72 s)
(03/11) test_sbsaref_alpine_linux_neoverse_n1: PASS (23.70 s)
(04/11) test_sbsaref_alpine_linux_max_pauth_off: PASS (23.00 s)
(05/11) test_sbsaref_alpine_linux_max_pauth_impdef: PASS (29.03 s)
(06/11) test_sbsaref_alpine_linux_max: PASS (80.69 s)
(07/11) test_sbsaref_openbsd73_cortex_a57: PASS (16.05 s)
(08/11) test_sbsaref_openbsd73_neoverse_n1: PASS (15.97 s)
(09/11) test_sbsaref_openbsd73_max_pauth_off: PASS (16.22 s)
(10/11) test_sbsaref_openbsd73_max_pauth_impdef: PASS (16.11 s)
(11/11) test_sbsaref_openbsd73_max: PASS (16.08 s)

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
Changes in v3:
- left OpenBSD at 7.3 (7.4+ is known to not boot)
  https://gitlab.com/qemu-project/qemu/-/issues/2224
  https://marc.info/?l=openbsd-arm&m=171050428327850&w=2
- added pauth variants of 'max' to OpenBSD tests
- Link to v2: https://lore.kernel.org/r/20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org

Changes in v2:
- disabled 'max' tests on OpenBSD
- moved tags to 'one tag per line'
- added 'os:linux' tags to Alpine ones
- Link to v1: https://lore.kernel.org/r/20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org

---
Marcin Juszkiewicz (4):
      tests/avocado: update sbsa-ref firmware
      tests/avocado: drop virtio-rng from sbsa-ref tests
      tests/avocado: sbsa-ref: add Alpine tests for misc 'max' setup
      tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup

 tests/avocado/machine_aarch64_sbsaref.py | 86 +++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 28 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240313-sbsa-ref-firmware-update-7579d9f6d59b

Best regards,
-- 
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


