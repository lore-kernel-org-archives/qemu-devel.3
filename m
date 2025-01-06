Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FF3E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 02:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUd5z-0002F9-GF; Sun, 05 Jan 2025 21:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tUd5v-0002Eh-T8; Sun, 05 Jan 2025 21:43:55 -0500
Received: from out28-193.mail.aliyun.com ([115.124.28.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tUd5t-0005K8-3J; Sun, 05 Jan 2025 21:43:55 -0500
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.awUx1--_1736131415 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jan 2025 10:43:36 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: alistair.francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v3 0/2] Enhanced VSTART and VL checks for vector instructions
Date: Mon,  6 Jan 2025 10:42:59 +0800
Message-ID: <cover.1736130472.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.193;
 envelope-from=lc00631@tecorigin.com; helo=out28-193.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi, all:

In accordance with the review, i improved the commit message of patch and added
the reason for the modification.

There was no change in the patch content.

PATCH v2 review:
https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e@ventanamicro.com/

PATCH v1 review:
https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkKOAgEMt_b2KvZA@mail.gmail.com/

--
Regards,
Chao

Chao Liu (2):
  target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a
    parameter
  target/riscv: fix handling of nop for vstart >= vl in some vector
    instruction

 target/riscv/vcrypto_helper.c   | 32 ++++++-------
 target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
 target/riscv/vector_internals.c |  4 +-
 target/riscv/vector_internals.h | 12 ++---
 4 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.47.1


