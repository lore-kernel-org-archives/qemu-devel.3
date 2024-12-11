Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94845E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOxm-0007DS-4R; Wed, 11 Dec 2024 10:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLOxk-0007Cq-8x; Wed, 11 Dec 2024 10:49:20 -0500
Received: from out28-197.mail.aliyun.com ([115.124.28.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLOxg-0003FW-S9; Wed, 11 Dec 2024 10:49:20 -0500
Received: from localhost.localdomain(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.abUPoOe_1733932146 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 11 Dec 2024 23:49:06 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 richard.henderson@linaro.org, alistair.francis@wdc.com
Cc: dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v2 1/1] target/riscv: add VILL field for vtype register macro
 definition
Date: Wed, 11 Dec 2024 23:48:48 +0800
Message-ID: <87f12c20620026268bc49cd030e6ce8f26e718c4.1733930699.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <cover.1733930699.git.lc00631@tecorigin.com>
References: <cover.1733930699.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.197;
 envelope-from=lc00631@tecorigin.com; helo=out28-197.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Chao Liu <lc00631@tecorigin.com>
---
 target/riscv/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..0d74ee4581 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -170,7 +170,8 @@ FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 12)
+FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
-- 
2.47.0


