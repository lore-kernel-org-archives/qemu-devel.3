Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF9C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 13:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ma5-0003bP-E7; Sat, 11 May 2024 09:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5fvj-0000AR-DS; Sat, 11 May 2024 02:10:00 -0400
Received: from xmbg7.mail.qq.com ([101.226.139.69])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5fvd-0008Nk-1l; Sat, 11 May 2024 02:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1715407774; bh=OyRSIjYPUTrC+yJeWkNTbySGcIE01aQtA2M3XGmFhsc=;
 h=From:To:Cc:Subject:Date;
 b=jyLwzmhfxurH3w5YwxLhbklI9DS8iGIJ5nz2I296w3jqK8jnj/SlghxDWYNqaPMMA
 RwrCtXF2xorxqI1yGKtOtfKrnJTMRi4ZSMWYPR20vB8QsdFVodE+QKY8IE9+neInSI
 jZGSRAfKyfppGZzWJVRARz++Fq37IByVmactPi1k=
Received: from cyy-pc.lan ([240e:379:225a:f200:fbeb:89b3:1d46:d38b])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id EC6B30D4; Sat, 11 May 2024 12:59:06 +0800
X-QQ-mid: xmsmtpt1715403546t8kpsasrv
Message-ID: <tencent_E56BF33996E1EAC7D0853035BAF05109B20A@qq.com>
X-QQ-XMAILINFO: MPaKaX623R7Y3L+KntZXBnBYlUraM6RDBirdwKf/Lap6rkKv7Y8bOzcFp+himL
 ApzPI4qoJqQ8Baoa5IOh4kjzZ8nmnHYM2EZhejBkRxSTQP0cgJxDXtfnj56ALC7zxUGY8RDz5w6D
 ShelPAgX6NWNBysdkmocJHDNuCtcALQlphCP1vwybnMN8mlVFpsY6F9+dV14BvCRDNMlbsFdx+Ke
 yNVGD2KSXJSdjcC8LnhULlEOAgd2ckdjX/EGXgBcxmD/d4+XoE1Sh8x1xZtQzIc5ROZqJ+PYpr+F
 i0bkkjGv3i7zTQnj01NWuS1xrPWuAYYpkcDz6YkBAMWU1KrZi5rNDzBDMILGEBjSxWlqkLtDjgV5
 o+u0RZXED79zvJOgT3aZ262WopulVoXqI00YyrtA4HE4DG+ekUi/6wQgKX0tYm59CIqLctLoFPGo
 qQ3yIuSfEGPZTWCNUKPdczurtYTH/VQHB1w+m1U1q+vBVB0XbEB2xxO1lYQSaZ7D67o9uZunfOlb
 lhcgusqKbtfWnZHGSoAYbkvG4pNL2C2hP0PyVL5gmbfvYBXgwLvBxWHFSAf9VrTwJZ3z3JtqnOD1
 Ghb7Uf4+e/GatKqyOMeA2i2poQigqxp5Sb5wFtTaKJ6uacYBySohUTbKrN45v6ya3X9IlKXufOnQ
 C1n1XUIFg3F5KMlhY92vLsicPAZa5pMQ7zR8W23wAhETTnF8MSc78u/gLsFylIynh+N8vx8kbYte
 XCo5ohzz1wpv2rW6NYYIqWCyQV8z8OavSwhHJs8HicRi4fWfkstNJfJ+AuQ/cHPze7hu7YErLcBU
 Q/SWqaWFDSDOXQECRsXJcL/k/hglVvZ91qJ6cPZHYyIgamhp85G5txu5Tpou5nJ2GIe6w/nxhODT
 Kq1Nw+JUuqXL+33n3hJbrf9Qr0yMnbwRfFYJJYsYAEveTn/059uoZ1lXwkJcnWo7Crb8wLKr+ITi
 UFQUZA2WqEEAq+HUZdgSsQLjdB+k+ddhlOaXLsNL+PA1A8hP4NEbk+/2uPgcth
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] target/riscv/cpu.c: fix Zvkb extension config
Date: Sat, 11 May 2024 12:58:39 +0800
X-OQ-MSGID: <20240511045839.1208159-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=101.226.139.69; envelope-from=cyy@cyyself.name;
 helo=xmbg7.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 09:15:52 -0400
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

This code has a typo that writes zvkb to zvkg, causing users can't
enable zvkb through the config. This patch gets this fixed.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d..13cd34adbd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
+    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-- 
2.43.0


