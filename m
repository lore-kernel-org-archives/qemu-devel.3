Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F840CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVnf-0000e5-F4; Tue, 16 Jun 2026 11:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZVnd-0000dY-3P; Tue, 16 Jun 2026 11:34:01 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZVnY-0004Pw-SR; Tue, 16 Jun 2026 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1781624021;
 bh=zix0yq62GHbXus38oGkGj/93owtFspKq1rppq5/yiqU=;
 h=From:To:Cc:Subject:Date;
 b=ekjM3VSIGlNsMDcae2V2j8xtjEilenhi+hptW1hj+fIwHMjZeDrKF8vUNe5NXAz4E
 0kAwFJ5Q/8Z4FqbAyI3HNpkgPWpbMWLM7lOswGeUwWdqH7L6A17AhmDzrzEN6jXgN3
 GFsMCcJHgV76E2LksdjoJU9JLoi4NDHHRnMROBiQ=
Received: from GavinQin-Ubuntu24.. ([117.147.33.130])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 85D252E7; Tue, 16 Jun 2026 23:33:29 +0800
X-QQ-mid: xmsmtpt1781624009t6vmnb7pl
Message-ID: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
X-QQ-XMAILINFO: NHCc2xbemT0jhcIPUh2SvQWAFtJQa58kmPQGsKW0TkAnxdyk592zPY+kTS6Aye
 i2d4aJDhU3fGFflyVausd12aMnQiDc30/vmK8hOSeSA5tTDSVbAWGRF+1fFuzNiiP2Vhk9viv6oI
 IQEZpLEmCqrrylzuVk4hzWrAmgkcFGf97dfIS1PYxHKPjc+N1VbHJCAOY2nioP6KKOztr05jFnqY
 q4J50M+yie//VshmP9BoM40qK1wCDg4uL1LgvvhzqLCLjrdRhMSS3zp2zfOHiPh4RimRxYHQwP3f
 l0nnaIra8nCe+39MP5FUcB/N3yawTvuu8epTgbHBE7AIadVuFM8ElNwldO8gOcxt/ziaUICLOSdu
 gNkhAQYv09RS8c9seMGgGHWoE53R2jmDkfOi1CBu+txxnFF122nDZXEW+H1TFAQzrOG1JQVb+NFJ
 KDdqYOlL3WtHPkgoyHFfXyoIxCW0vAMFDTsWTVpY/mEex15AsrsBGI2Wzg2iYeKCJjpcDzM7K3MX
 dh3GiuidkJCIuyFhlZ6XnqwahU8mRvrXaBaag+nKt2a89xTw62wgtfap75biSlned/VyOL0nZ5pp
 HaHI7YiqdegiUqS/J7m9MbGW7zxKwDt+J8z0uesY3tAiPH40i1okHzVxCecEQuxYD9GVNpFqBliy
 E6XkKGPXB73D2U8Oz+A5S6eiHusEsjWpmws9GX13SNKlomq4LdoyNlg7l4naPsmuwoVM4tTpa0Mu
 AK7/nGN1w5vGKy+GAOj9gjl5E1xoqzOCXp8vDSU08H6xdxvxlr6FjMaGK0UueJ6QRc+cJoODxsrm
 L7LTbJ3w1+ra/khluPtU9HwbsxtkHGBfrx2PgJooIXeVPGMap5gBvsA1Qbu4tbWLh4qnxgcLxe2e
 ybuysfzQv4QT09+yDV75WTm4iEnXX5hQ1X9Dx8nTI2Hoetq1hElLY7koP5AnTptHiWGEYGSHdRYm
 kQqqMFAgcqcX8EwcINfRZng5YcfUAihJxrgxPNghlwCZsXVkn+pbKzZDbVS6PrEArbDNUKpvqws/
 cNRD7ZBZHR2VOfCJ9otGC/fpRxUwrs6EPRIMyEYg1lM3ONxyfgk30Vp69nvehhelbGG712P286C0
 uaqOi6qZtrslu4on88V3v6S+HsHf0JFp+XuoSEqxWY/kKQcojIyBsXkBgf0K6DO/W91Fcb7wLP8n
 1Sy8c=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH] target/riscv: raise access fault for Zicbom MMIO-like accesses
Date: Tue, 16 Jun 2026 23:33:26 +0800
X-OQ-MSGID: <20260616153326.31362-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64;
 envelope-from=qinzhengxiang@foxmail.com; helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

check_zicbom_access() probes the cache block with MMU_DATA_LOAD and
returns early for any result other than TLB_INVALID_MASK.  This treats
TLB_MMIO as a successful load access.

For Zicbom, a TLB_MMIO result does not provide a RAM host pointer for the
cache block operation and should not be treated as a successful access.
Raise a store/AMO access fault instead of silently completing the CBO
instruction.

This fixes sv39_zicbom_exceptions_Smode.S, where cbo.clean/cbo.flush and
cbo.inval access a block mapped to a physical address without PMA
permissions.  Before this change, the CBO instruction completed and the
following addi was executed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
---
 target/riscv/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..6c9bd5c102 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
     void *phost;
     int ret;
 
+    target_ulong fault_addr = address;
     /* Mask off low-bits to align-down to the cache-block. */
     address &= ~(cbomlen - 1);
 
@@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
      */
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
+    if (ret == TLB_MMIO) {
+        env->badaddr = fault_addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
+    }
     if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
-- 
2.43.0


