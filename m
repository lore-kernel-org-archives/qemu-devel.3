Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl0V-0005H3-OF; Tue, 24 Nov 2026 02:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVl0T-0005GR-99
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:01 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVl0Q-00006y-Gm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:01 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxhvBlPQVr0XwiAA--.32472S3;
 Tue, 24 Nov 2026 15:31:49 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front2 (Coremail) with SMTP id qciowJAxjn9hPQVrL6YNAA--.315S2;
 Tue, 24 Nov 2026 15:31:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/loongarch: Small enhancement about exception
Date: Tue, 24 Nov 2026 15:33:15 +0800
Message-ID: <20261124073321.3015041-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJAxjn9hPQVrL6YNAA--.315S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWrXFWUXFWDKrW8XF17CFX_yoW8Gr1Dpr
 y3uryaqF48JFZxZrnxXa4Yqr98ur4xGr42va1ft348Cw4ayr1Iqr1kt392gFyUGa4UXr1j
 qF1Fyw1UWFy5A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch set uses the unified API do_raise_exception() to inject
exceptions and loongarch_cpu_do_interrupt() to handle them.

It also adds an exception structure to CPULoongArchState with badv and
flags fields, and moves HW CSR register handling into
loongarch_cpu_do_interrupt() instead of doing it at the exception
injection sites.

Bibo Mao (6):
  target/loongarch: Use local variable for exception index
  target/loongarch: Use fallthrough for TLBRET_NOMATCH and
    TLBRET_INVALID
  target/loongarch: Use common do_raise_exception() in
    raise_mmu_exception()
  target/loongarch: Add exception structure to CPULoongArchState
  target/loongarch: Use raise_exception_full() in raise_mmu_exception()
  target/loongarch: Set exception.badv for memory access

 target/loongarch/cpu.h               | 13 ++++++
 target/loongarch/internals.h         |  4 --
 target/loongarch/tcg/fpu_helper.c    |  1 +
 target/loongarch/tcg/op_helper.c     | 24 ++++------
 target/loongarch/tcg/tcg_cpu.c       | 49 +++++++++++++++++----
 target/loongarch/tcg/tcg_loongarch.h |  9 ++++
 target/loongarch/tcg/tlb_helper.c    | 65 ++++++++++------------------
 target/loongarch/tcg/vec_helper.c    |  1 +
 8 files changed, 97 insertions(+), 69 deletions(-)


base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e
-- 
2.54.0


