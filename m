Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FFBCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34xd-0005Iq-Ld; Sun, 28 Sep 2025 23:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v34xb-0005IN-OU
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:53:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v34xS-0002xV-VA
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:53:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxvr_EAtpobPQPAA--.32101S3;
 Mon, 29 Sep 2025 11:53:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxpeTDAtpoKGG8AA--.3627S2;
 Mon, 29 Sep 2025 11:53:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/loongarch: Move TCG specified functions to
 tcg_cpu.c
Date: Mon, 29 Sep 2025 11:53:35 +0800
Message-Id: <20250929035338.2320419-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeTDAtpoKGG8AA--.3627S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Some functions defined in file target/loongarch/cpu.c are TCG specified,
new file target/loongarch/tcg/tcg_cpu.c is created here and move TCG
specified functions to new file.

---
v1 ... v2:
  1. Merge old patch 1 and patch 3 into new patch 1
  2. Move function declaration from header file target/loongarch/cpu.h
     to file target/loongarch/internals.h
---
Bibo Mao (3):
  target/loongarch: Move TCG specified functions to tcg_cpu.c
  target/loongarch: Move function do_raise_exception() to tcg_cpu.c
  target/loongarch: Define loongarch_exception_name() as static

 target/loongarch/cpu.c               | 318 +-------------------------
 target/loongarch/internals.h         |   4 +-
 target/loongarch/tcg/meson.build     |   1 +
 target/loongarch/tcg/tcg_cpu.c       | 322 +++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_loongarch.h |   1 +
 5 files changed, 328 insertions(+), 318 deletions(-)
 create mode 100644 target/loongarch/tcg/tcg_cpu.c


base-commit: 4975b64efb5aa4248cbc3760312bbe08d6e71638
-- 
2.39.3


