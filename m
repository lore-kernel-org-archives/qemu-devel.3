Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E2DCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvylp-0000nn-GC; Tue, 09 Sep 2025 09:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylU-0000iL-Gm
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylJ-0005DN-Hy
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4nBAWfORpYa45Cgm1JsPY5e6jLIh8iCY6ZFTOCOAqEY=;
 b=ZLuGpDc8jsFUuodoL8CLmTPwxbk/anfLWqsHqKVGPgMZptTa+knKsYzkwdImC1Rfzu9wkq
 r0RgBSkIkla4ISn4ZOBWxv0d/aQdlBiOlyDztliAObYMrmqfY31jWdyoqkmwcYBW5V9nmT
 T1SY9IbrZ92who4EoGpvHDFmJ2jUy/Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-uzoNwHIZNuCyU5WVUVCIwQ-1; Tue,
 09 Sep 2025 09:51:51 -0400
X-MC-Unique: uzoNwHIZNuCyU5WVUVCIwQ-1
X-Mimecast-MFC-AGG-ID: uzoNwHIZNuCyU5WVUVCIwQ_1757425910
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28E3019560B0; Tue,  9 Sep 2025 13:51:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 155CD1800447; Tue,  9 Sep 2025 13:51:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/23] Functional tests and misc patches
Date: Tue,  9 Sep 2025 15:51:24 +0200
Message-ID: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 Hi Richard!

The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:

  Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-09-09

for you to fetch changes up to 2fc170bcdc4d2f05534c68572b4f72a7d18c2119:

  tests/functional: purge scratch dir on test startup (2025-09-09 15:45:33 +0200)

----------------------------------------------------------------
* Silence warnings from the undefined-behaviour sanitizer
* Many small improvements to various functional tests
* Remove remainders from storing avocado artifacts in the Gitlab CI
* Keep more meson log files as artifacts in the Gitlab CI instead
* Re-enable -fzero-call-used-regs on OpenBSD

----------------------------------------------------------------
Daniel P. Berrangé (11):
      tests/functional: enable force refresh of cached assets
      tests/functional: fix formatting of exception args
      tests/functional: handle URLError when fetching assets
      gitlab: replace avocado results files with meson results files
      gitlab: always include entire of meson-logs directory
      gitlab: include all junit XML files from meson
      gitlab: prevent duplicated meson log artifacts in test jobs
      tests/functional: fix infinite loop on console EOF
      tests/functional: avoid duplicate messages on failures
      tests/functional: avoid tearDown failure when QEMU dies
      tests/functional: purge scratch dir on test startup

John Levon (2):
      tests/functional: return output from cmd.py helpers
      tests/functional: add vm param to cmd.py helpers

Kane-Chen-AS (4):
      tests/functional/arm: Update test ASPEED SDK v03.02 for AST1030
      tests/functional/arm: Update test ASPEED SDK v09.07 for AST2500
      tests/functional/arm: Update test ASPEED SDK v09.07 for AST2600
      tests/functional/arm: Update test ASPEED SDK v09.07 for AST2700 vbootrom

Thomas Huth (6):
      hw/display/bcm2835_fb: Move inclusion of console.h to the .c file
      Revert "meson.build: Disable -fzero-call-used-regs on OpenBSD"
      hw/mips/malta: Silence warning from ubsan
      system/physmem: Silence warning from ubsan
      ui/vnc: Fix crash when specifying [vnc] without id in the config file
      tests/functional/m68k: Avoid ResourceWarning in the nextcube test

 docs/devel/testing/functional.rst               |  3 ++
 meson.build                                     |  6 +--
 include/hw/display/bcm2835_fb.h                 |  1 -
 hw/display/bcm2835_fb.c                         |  1 +
 hw/mips/malta.c                                 |  2 +-
 system/physmem.c                                |  4 +-
 ui/vnc.c                                        | 18 +++----
 .gitlab-ci.d/buildtest-template.yml             | 16 ++++--
 .gitlab-ci.d/buildtest.yml                      |  4 +-
 .gitlab-ci.d/crossbuild-template.yml            |  4 +-
 .gitlab-ci.d/custom-runners.yml                 |  2 +-
 .gitlab-ci.d/windows.yml                        |  4 +-
 tests/functional/aarch64/test_aspeed_ast2700.py |  8 ++-
 tests/functional/arm/test_aspeed_ast1030.py     | 12 ++---
 tests/functional/arm/test_aspeed_ast2500.py     |  8 +--
 tests/functional/arm/test_aspeed_ast2600.py     |  8 +--
 tests/functional/m68k/test_nextcube.py          |  3 +-
 tests/functional/qemu_test/asset.py             | 16 +++++-
 tests/functional/qemu_test/cmd.py               | 67 ++++++++++++++++++++-----
 tests/functional/qemu_test/testcase.py          | 14 ++++--
 20 files changed, 137 insertions(+), 64 deletions(-)


