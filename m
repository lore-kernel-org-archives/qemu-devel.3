Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC381CD37B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 05:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMJ1f-0003C5-3H; Mon, 11 May 2026 01:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMJ1Z-0003Ag-BB; Mon, 11 May 2026 01:17:49 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vulab@iscas.ac.cn>)
 id 1wMJ1V-0003Lr-JX; Mon, 11 May 2026 01:17:48 -0400
Received: from yzs (unknown [183.156.89.125])
 by APP-01 (Coremail) with SMTP id qwCowAB3HmpxZgFqoBPfDw--.847S2;
 Mon, 11 May 2026 13:17:38 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>
Subject: [PATCH] target/riscv: add Zvknha as an implied extension for Zvknhb
Date: Mon, 11 May 2026 13:17:36 +0800
Message-ID: <20260511051736.2916225-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3HmpxZgFqoBPfDw--.847S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy5WFW5Cr1fCr48GrykZrb_yoWkJrX_Ga
 1F9FWS9r1qvan29ayrCrn8Kr1vya4rGFWqgw4xGF4jkry7WFn8A3WvgrnrWF13ZrWUAF9a
 qrW7Wry7WrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
 U==
X-Originating-IP: [183.156.89.125]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcEA2oBMeu65QAAsi
Received-SPF: pass client-ip=159.226.251.21; envelope-from=vulab@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The RISC-V unpriv specification (zvk.adoc) states that "Zvknhb
implies Zvknha". This means that enabling Zvknhb should automatically
enable Zvknha.

Add Zvknha to ZVKNHB_IMPLIED to ensure the dependency is correctly
enforced.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2635/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37de..61430e44020e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2542,7 +2542,7 @@ static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
 static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvknhb),
     .implied_multi_exts = {
-        CPU_CFG_OFFSET(ext_zve64x),
+        CPU_CFG_OFFSET(ext_zve64x), CPU_CFG_OFFSET(ext_zvknha),
 
         RISCV_IMPLIED_EXTS_RULE_END
     },
-- 
2.51.2


