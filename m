Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E48C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 02:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1renFC-000312-DZ; Mon, 26 Feb 2024 21:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1renFB-00030Y-5D
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:30:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1renEx-0002PL-E9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:30:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxafBKSd1l+c8RAA--.45801S3;
 Tue, 27 Feb 2024 10:30:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxbs1HSd1lRvhGAA--.54308S2; 
 Tue, 27 Feb 2024 10:30:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Add migration test for loongarch64
Date: Tue, 27 Feb 2024 10:30:26 +0800
Message-Id: <20240227023031.3299067-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxbs1HSd1lRvhGAA--.54308S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFy8Jr17WrWfAF18Jw4kXwc_yoW8AFy7pr
 Z3Zr1fKan3GF9rX3Z7G398Wr1Yyw1xGw12qFs3tr10yFZxCF1UZw10gFyDZF95A340gr40
 v3s5J34IgF1DArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
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

Migration test case passes to run in both tcg and kvm mode with the
patch.

---
Change in v2:
  1. Keep the default memory size unchanged with 1GB, only modify minimum
memory size with 256MB
  2. Remove tab char in file tests/migration/loongarch64/a-b-kernel.S
  3. Rebase patch on https://patchwork.kernel.org/project/qemu-devel/patch/0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn
to avoid confliction
---
Bibo Mao (5):
  hw/loongarch: Rename LOONGARCH_MACHINE with VIRT_MACHINE.
  hw/loongarch: Rename LoongArchMachineState with VirtMachineState
  hw/loongarch: Add compat machine for 9.0
  hw/loongarch: Set minimium memory size as 256M
  tests: Add migration test for loongarch64

 hw/loongarch/acpi-build.c                |  80 +++---
 hw/loongarch/fw_cfg.c                    |   2 +-
 hw/loongarch/fw_cfg.h                    |   2 +-
 hw/loongarch/virt.c                      | 345 +++++++++++++----------
 include/hw/loongarch/virt.h              |  10 +-
 tests/migration/Makefile                 |   2 +-
 tests/migration/loongarch64/Makefile     |  18 ++
 tests/migration/loongarch64/a-b-kernel.S |  49 ++++
 tests/migration/loongarch64/a-b-kernel.h |  16 ++
 tests/migration/migration-test.h         |   3 +
 tests/qtest/meson.build                  |   4 +
 tests/qtest/migration-test.c             |  10 +
 12 files changed, 337 insertions(+), 204 deletions(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h


base-commit: 03d496a992d98650315af41be7c0ca6de2a28da1
-- 
2.39.3


