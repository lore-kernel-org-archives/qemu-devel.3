Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3566BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0Dv-000673-8j; Tue, 07 Jul 2026 03:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wh0Dj-00066V-52; Tue, 07 Jul 2026 03:27:58 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wh0Dg-0006Af-Qp; Tue, 07 Jul 2026 03:27:54 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gvXqz0jdNz52SGg;
 Tue, 07 Jul 2026 15:27:43 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
 by mse-fl1.zte.com.cn with SMTP id 6677RYDg065689;
 Tue, 7 Jul 2026 15:27:34 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Tue, 7 Jul 2026 15:27:36 +0800
X-Zmail-TransId: 3e816a4caa68009-51e2f
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v2 RESEND] target/riscv/kvm: add extensions after v7.1-rc4
 update
Date: Tue,  7 Jul 2026 15:26:10 +0800
Message-ID: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 6677RYDg065689
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Jul 2026 15:27:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CAA6F.001/4gvXqz0jdNz52SGg
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Expose zilsd, zclsd and zalasr.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index dcdaf7f2b3..e2c6a4b3aa 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -303,10 +303,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
+    KVM_EXT_CFG("zilsd", ext_zilsd, KVM_RISCV_ISA_EXT_ZILSD),
     KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
     KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
+    KVM_EXT_CFG("zclsd", ext_zclsd, KVM_RISCV_ISA_EXT_ZCLSD),
     KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
+    KVM_EXT_CFG("zalasr", ext_zalasr, KVM_RISCV_ISA_EXT_ZALASR),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
     KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
-- 
2.27.0


