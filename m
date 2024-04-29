Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D72AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QAH-0001r6-UK; Mon, 29 Apr 2024 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1QAB-0001qQ-Uv; Mon, 29 Apr 2024 08:31:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1QA8-0002rm-V6; Mon, 29 Apr 2024 08:31:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF46E62E1E;
 Mon, 29 Apr 2024 15:31:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7DBD4C3571;
 Mon, 29 Apr 2024 15:31:10 +0300 (MSK)
Received: (nullmailer pid 250723 invoked by uid 1000);
 Mon, 29 Apr 2024 12:31:10 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL v2 0/9] Trivial patches for 2024-04-29
Date: Mon, 29 Apr 2024 15:31:09 +0300
Message-Id: <20240429123110.250689-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to ce1992d45c875c29a9018b7ac2fa9bad6587c711:

  checkpatch.pl: forbid strerrorname_np() (2024-04-29 15:26:56 +0300)

----------------------------------------------------------------
trivial patches for 2024-04-29

v2: fix author of "backends/cryptodev-builtin: Fix local_error leaks"
(which should be catched now by checkpatch.pl additions in this series)
Only patch 6 is being resent.
----------------------------------------------------------------
Daniel Henrique Barboza (2):
      target/riscv/kvm: remove sneaky strerrorname_np() instance
      checkpatch.pl: forbid strerrorname_np()

Li Zhijian (1):
      backends/cryptodev-builtin: Fix local_error leaks

Michael Tokarev (1):
      target/loongarch/cpu.c: typo fix: expection

Philippe Mathieu-Daudé (2):
      scripts/checkpatch: Avoid author email mangled by qemu-*@nongnu.org
      scripts/checkpatch: Do not use mailmap

Thomas Huth (3):
      target/i386/cpu: Remove "x86" prefix from the CPU list
      target/s390x/cpu_models: Rework the output of "-cpu help"
      target/ppc/cpu_init: Remove "PowerPC" prefix from the CPU list

 backends/cryptodev-builtin.c |  9 +++++----
 scripts/checkpatch.pl        | 11 +++++++----
 target/i386/cpu.c            |  2 +-
 target/loongarch/cpu.c       |  2 +-
 target/ppc/cpu_init.c        |  9 +++++----
 target/riscv/kvm/kvm-cpu.c   |  4 ++--
 target/s390x/cpu_models.c    |  9 +++++----
 7 files changed, 26 insertions(+), 20 deletions(-)

