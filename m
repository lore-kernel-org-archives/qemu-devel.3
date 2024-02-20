Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7861C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPRT-0003CE-J3; Tue, 20 Feb 2024 07:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rcPRO-0003AB-Qk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rcPRH-0000D9-FB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxmej3ndRlMj8PAA--.20373S3;
 Tue, 20 Feb 2024 20:41:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxPs_3ndRl5MM8AA--.25558S2; 
 Tue, 20 Feb 2024 20:41:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/5] Add migration test for loongarch64
Date: Tue, 20 Feb 2024 20:41:21 +0800
Message-Id: <20240220124126.1164081-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPs_3ndRl5MM8AA--.25558S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFy8Jr17WrWfCr15CryrKrX_yoW8Jw18pr
 Z3Zw1fKa1xGF9xXF1kG398Wrn5Ar1xGr12qFsxtr10krZxCFyUZw1I9rWqvF95A340qry0
 vwn5Ja47W3WDArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Migration test case is added for loongarch64 here. Since compat machine
type is required for migration test case, also compat machine qemu 9.0
is added for loongarch virt machine.

Bibo Mao (5):
  hw/loongarch: Rename LOONGARCH_MACHINE with VIRT_MACHINE.
  hw/loongarch: Rename LoongArchMachineState with VirtMachineState
  hw/loongarch: Add compat machine for 9.0
  hw/loongarch: Set minimium memory size as 256M
  tests: Add migration test for loongarch64

 hw/loongarch/acpi-build.c                |  76 +++---
 hw/loongarch/fw_cfg.c                    |   2 +-
 hw/loongarch/fw_cfg.h                    |   2 +-
 hw/loongarch/virt.c                      | 333 +++++++++++++----------
 include/hw/loongarch/virt.h              |  10 +-
 tests/migration/Makefile                 |   2 +-
 tests/migration/loongarch64/Makefile     |  18 ++
 tests/migration/loongarch64/a-b-kernel.S |  46 ++++
 tests/migration/loongarch64/a-b-kernel.h |  13 +
 tests/migration/migration-test.h         |   3 +
 tests/qtest/meson.build                  |   4 +
 tests/qtest/migration-test.c             |  10 +
 12 files changed, 323 insertions(+), 196 deletions(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h


base-commit: da96ad4a6a2ef26c83b15fa95e7fceef5147269c
-- 
2.39.3


