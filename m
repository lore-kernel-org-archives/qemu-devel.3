Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D4C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ksn-0003bh-6p; Sat, 11 May 2024 07:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5ksk-0003bQ-WF; Sat, 11 May 2024 07:27:15 -0400
Received: from out203-205-251-72.mail.qq.com ([203.205.251.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s5ksd-00029M-U7; Sat, 11 May 2024 07:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1715426815; bh=yjqpK+Eg5veALQcPqs1E2XoM5kNiLDGJclcs8xp3MIw=;
 h=From:To:Cc:Subject:Date;
 b=rTgqpdl6W7Bv29SHtcIvv9P41zpXKcP8SnX7TrVPIWPCZKeKIescZyfknvgaNTM1K
 z35JpZIsP7tV0nwfyjMTHSK4jjPVfzTqJDK6h+Crjuczq2lO8Mi5bhOfhZTIe4lldd
 YJ0+50Soy8hngrvBff/LGLFrYaaqpZB86w+j7Ytk=
Received: from cyy-pc.lan ([240e:379:225a:f200:fbeb:89b3:1d46:d38b])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 6B42DEAC; Sat, 11 May 2024 19:26:52 +0800
X-QQ-mid: xmsmtpt1715426812tzqiaref2
Message-ID: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCTAw4EW2a1q//sM4v24aLRQAKuIUQXyCLehtrJFlq+8nRMEa302
 egZhAaGTHqA6ZZorY7You4y2pFroZSNLragQv5JvozMcgLLyPriWIIEK81qZWse8nNP1LbAYGbuJ
 VUdvqS6NlNjaeLz3FE57193jEjEfLVgi+QcaPgQawBlqp2TpdKZ1nZUQGA+xN+7P1sQnNOjtVUOj
 6EzpY4ByNLSi4YnylaSsGW9aaJfa+8DzIg+NBWK+812k7YFuPe6OGgfPyDGFntdZltTonpN/hqwe
 MSBPqUZn8jLyA0GkNh1jKostPEBLZEsvCY6RwoDEMafGJxSGRlTolgCoKDcprZ36S/XZTCw9nRim
 lhR09udrLFkgxjx2DzcE3hC/PCEr0azWvDweFK//CJjvUZGXAiqpV0/bx3HRKqzngWljXaI9p8Cp
 8TDE81PQhloOxQhXcrtVQ+t1MVvpXTmjRSd9okkL7+MGJpEQMjwif38n5eH4AhoNGm8uvdri9ZuT
 A0klLg8fCxjDheOyw97UNmuDkTdmqdEK/GhLNcwQluho1NsoFAq0d+EWPSUGlu41XxVSLXEjwHHy
 Gobt71TXM7KFoNcEa8DcNsh3Nnklbfut+iNRwijnoPUUtGJNixymE4CQGRo93gCkcXRyrkvO0XeC
 47jjbD343ZMj9Gue74RheBxnNMKAOlIByI2p38VBSTM0QoGVP/1JLoAM+dItgmf5XRPxn0w/YvQU
 TsJM/whm1Iu7rpjkvwFr/ntS/RIxIKAuKbNNQ2Dp7WH9KMB7SN48XZFBAWPZiHQewTfdw9Eyjri4
 Hjjfv+VOPhuz1zKJrZoh/llxQewlPI/UEG+/n2LLkJPOjN9WyDF9S/DnAwXnZ4bTbnwxZ4tCAzD+
 vCb6sYq++sp7C5Po3tPHs88BK+hSPqVAmubOEzNNoukt165bZgm6kbY+QQ2KWGZwNHdT5XgOUNis
 YVy6xMEuMhlwWQKbZ5359b+eCV6etlevJuFIgkBIvI3CJ7peRWiFG/PoV2CxU7rm9L4DzEU7ReCJ
 3/g/yPZA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
Date: Sat, 11 May 2024 19:26:48 +0800
X-OQ-MSGID: <20240511112648.1612830-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=203.205.251.72; envelope-from=cyy@cyyself.name;
 helo=out203-205-251-72.mail.qq.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This code has a typo that writes zvkb to zvkg, causing users can't
enable zvkb through the config. This patch gets this fixed.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
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


