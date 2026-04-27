Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6739DFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjS-0007rj-3I; Mon, 27 Apr 2026 05:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIj6-0007jK-M6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIj2-00085G-KG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AhD3NeA9GOphQ5JFWGR0WW6M4MqpIZl+KwkC1bTKY5s=;
 b=bp3xiiX58tbRS/X0sbdHkGHiJp+HoW5BWke9CyeAuPgBnVCfVjUrCRuy80v4mOHpn0Izlr
 lbW28Iy6c8fuZBx5/XRpNyP9ScwdDQAOsl0wqnUppNipooRBzbw9bNTEYpgoLtN6nIfhzZ
 8leI+NyP1If+ldiTDoaBlaIfRlY8ekc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-IJWNCYGINSmiPmLOQSOiyw-1; Mon,
 27 Apr 2026 05:57:57 -0400
X-MC-Unique: IJWNCYGINSmiPmLOQSOiyw-1
X-Mimecast-MFC-AGG-ID: IJWNCYGINSmiPmLOQSOiyw_1777283876
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B21A19560A2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:57:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2CB63000C22; Mon, 27 Apr 2026 09:57:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/10] Misc patches (cleanups, functional tests, GCC bump, ...)
Date: Mon, 27 Apr 2026 11:57:37 +0200
Message-ID: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Stefan!

The following changes since commit aa15257174da180c6a8a9d58f87319cfe61c5520:

  Merge tag 'pbouvier/pr/plugins-20260424' of https://gitlab.com/p-b-o/qemu into staging (2026-04-25 10:22:04 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-04-27

for you to fetch changes up to e3c1d0111cab08263646f9ab8d8f6a2b3b51abe4:

  tests/functional/ppc/test_ppe42: Fix warning from the latest version of pylint (2026-04-27 10:31:39 +0200)

----------------------------------------------------------------
* Bump the minimum GCC version to v10.4
* Make SMM code ready for the QEMU universal binary
* Convert TABs to spaces according to QEMU's coding style
* Fix use of pthread_get_name_np on OpenBSD
* Silence some warnings from pylint in the functional tests
* Fix a regression in the "register-array" device
* malloc cleanups

----------------------------------------------------------------
Daniel P. Berrangé (1):
      util: fix use of pthread_get_name_np on OpenBSD

Dmitry Frolov (1):
      target/xtensa: Replace malloc() with g_strdup_printf()

Luc Michel (1):
      hw/core/register: add register_array_get_owner

Sourish Dutta Sharma (1):
      hw/i386/fw_cfg: Use g_new() and g_new0() instead of g_malloc()

Tanya Agarwal (1):
      target: convert TABS indentation to spaces for consistency

Thomas Huth (5):
      meson.build: Bump the minimum GCC version to v10.4
      target/i386/tcg/sysemu: Move target specific SMM code to separate functions
      target/i386/tcg/sysemu: Allow 32-bit SMM code to be used in the 64-bit binary
      tests/functional/qemu_test: Silence warnings from pylint in tesseract.py
      tests/functional/ppc/test_ppe42: Fix warning from the latest version of pylint

 meson.build                             |   4 +-
 include/hw/core/register.h              |  11 ++
 target/alpha/cpu.h                      |   6 +-
 target/i386/cpu.h                       |  40 ++--
 target/i386/svm.h                       | 308 +++++++++++++++---------------
 target/microblaze/cpu.h                 |  12 +-
 target/sparc/asi.h                      | 328 ++++++++++++++++----------------
 hw/core/register.c                      |   5 +
 hw/i386/fw_cfg.c                        |   4 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c       |   4 +-
 hw/nvram/xlnx-zynqmp-efuse.c            |   4 +-
 hw/ssi/xlnx-versal-ospi.c               |  10 +-
 target/i386/tcg/system/smm_helper.c     | 104 ++++++----
 target/xtensa/translate.c               |  11 +-
 util/qemu-thread-posix.c                |   3 +-
 tests/functional/ppc/test_ppe42.py      |   1 -
 tests/functional/qemu_test/tesseract.py |  14 +-
 17 files changed, 456 insertions(+), 413 deletions(-)


