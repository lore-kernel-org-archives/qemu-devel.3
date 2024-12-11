Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9125BE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNG6-0002HH-Ra; Wed, 11 Dec 2024 09:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLN8g-0008AH-7p; Wed, 11 Dec 2024 08:52:30 -0500
Received: from out28-1.mail.aliyun.com ([115.124.28.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tLN8d-0001ry-0p; Wed, 11 Dec 2024 08:52:29 -0500
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.abQNlSr_1733924826 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 11 Dec 2024 21:47:07 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
Cc: zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v1 1/1] target/riscv: add VILL field for vtype register macro
 definition
Date: Wed, 11 Dec 2024 21:47:15 +0800
Message-ID: <bd2eb642a5876b4417517febc0656ec4beccb45c.1733922709.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1733922709.git.lc00631@tecorigin.com>
References: <cover.1733922709.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.1; envelope-from=lc00631@tecorigin.com;
 helo=out28-1.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Dec 2024 09:00:06 -0500
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
index 284b112821..fc286484b8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -170,7 +170,8 @@ FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
 FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 12)
+FIELD(VTYPE, VILL, 63, 1)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
-- 
2.47.0


