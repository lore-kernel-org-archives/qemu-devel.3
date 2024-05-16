Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD36C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7X9H-0007mN-U8; Thu, 16 May 2024 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s7X9E-0007lB-PL
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:11:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s7X9B-0006Nm-Fe
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:11:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXeu6zUVmI3QNAA--.25604S3;
 Thu, 16 May 2024 17:11:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx71u4zUVm+8ciAA--.2860S2; 
 Thu, 16 May 2024 17:11:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/5] loongarch-to-apply queue
Date: Thu, 16 May 2024 17:11:15 +0800
Message-Id: <20240516091120.1021435-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx71u4zUVm+8ciAA--.2860S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The following changes since commit 922582ace2df59572a671f5c0c5c6c5c706995e5:

  Merge tag 'pull-hppa-20240515' of https://gitlab.com/rth7680/qemu into staging (2024-05-15 11:46:58 +0200)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240516

for you to fetch changes up to d55d16700a2e2b36c7e34724d4d77f4a75c5243a:

  target/loongarch/kvm: fpu save the vreg registers high 192bit (2024-05-16 16:32:35 +0800)

----------------------------------------------------------------
pull-loongarch-20240516

----------------------------------------------------------------
Bibo Mao (3):
      hw/loongarch: Add compat machine for 9.1
      hw/loongarch: Remove minimum and default memory size
      tests: Add migration test for loongarch64

Song Gao (2):
      target/loongarch/kvm: Fix VM recovery from disk failures
      target/loongarch/kvm: fpu save the vreg registers high 192bit

 hw/loongarch/virt.c                      | 66 +++++++++++++++++++++++---------
 target/loongarch/kvm/kvm.c               |  6 +++
 target/loongarch/machine.c               |  6 ++-
 tests/migration/Makefile                 |  2 +-
 tests/migration/loongarch64/Makefile     | 18 +++++++++
 tests/migration/loongarch64/a-b-kernel.S | 49 ++++++++++++++++++++++++
 tests/migration/loongarch64/a-b-kernel.h | 16 ++++++++
 tests/migration/migration-test.h         |  3 ++
 tests/qtest/meson.build                  |  2 +-
 tests/qtest/migration-test.c             | 10 +++++
 10 files changed, 156 insertions(+), 22 deletions(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h


